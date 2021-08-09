import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:phone_verification_flutter/Views/home_screen.dart';
import 'package:phone_verification_flutter/Views/language.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

enum MobileVerificationState { SHOW_MOBILE_FORM_STATE, SHOW_OTP_FORM_STATE }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;
  bool loading = false;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCerdential) async {
    /*setState(() {
      loading = true;
    });*/

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCerdential);

      /*setState(() {
        loading = false;
      });*/

      if (authCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Verified Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightGreenAccent,
            textColor: Colors.black,
            fontSize: 16.0
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on Exception catch (e) {
      /*setState(() {
        loading = false;
      });*/
      _globalKey.currentState!.showSnackBar(SnackBar(
        content: Text("error in login"),
      ));
    }
  }

  getMobileFormWidget(context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Language(),
                          ));
                    });
                  },
                  child: Icon(Icons.clear))),
          Spacer(),
          Text(
            "Please enter your mobile number",
            style:
                GoogleFonts.oswald(fontSize: 22, fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              width: 200,
              child: Text(
                "  You'll receive a 6 digit code \n               to verify next.",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            margin: EdgeInsets.only(left: 5, right: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InternationalPhoneNumberInput(
              spaceBetweenSelectorAndTextField: 12,
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
                print("Phone controller: " + phoneController.text);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                showFlags: true,
              ),
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: phoneController,
              formatInput: false,
              autoFocus: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ),
          /*TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Phone Number",
              //hintText: "Phone Number",
            ),
          ),*/
          SizedBox(
            height: 16,
          ),
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 12),
            child: loading == false?
            Text(
              'CONTINUE',
              style: GoogleFonts.oswald(fontWeight: FontWeight.w500),
            ) : Container(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            ),
            onPressed: () async {
              setState(() {
                loading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: "+91 " + phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  otpController.text = phoneAuthCredential.smsCode!;
                  setState(() {
                    loading = false;
                    //print(phoneController.text);
                  });
                  //signInWithPhoneAuthCredential(phoneAuthCerdential);
                },
                verificationFailed: (verificationFailed) {
                  setState(() {
                    loading = false;
                  });
                  _globalKey.currentState!.showSnackBar(
                      SnackBar(content: Text("Verification failed...")));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() async {
                    //loading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                    // here add signature
                    final signature = await SmsAutoFill().getAppSignature;
                    //print(signature); // 6fwgbEqpFDu
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            },
            color: loading == true ? Colors.white :Colors.deepPurple,
            textColor: Colors.white,
          ),
          Spacer(),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Language(),
                          ));
                    });
                  },
                  child: Icon(Icons.arrow_back))),
          Spacer(),
          Text(
            "Verify Phone",
            style:
                GoogleFonts.oswald(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Text(
            "Code is send to " + phoneController.text,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              //obscureText: false,

              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                inactiveColor: Colors.blue,
                inactiveFillColor: Colors.blue,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: otpController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
                setState(() {
                  //currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinFieldAutoFill(
              controller: otpController,
              keyboardType: TextInputType.number,
              codeLength: 6,
              decoration: const UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(Colors.blue)),
            ),
          ),*/
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                "Request Again",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
            onPressed: () async {
              final phoneAuthCerdential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otpController.text);
              signInWithPhoneAuthCredential(phoneAuthCerdential);
            },
            child: loading == false? Text(
              'VERIFY AND CONTINUE',
              style: GoogleFonts.oswald(fontWeight: FontWeight.w500),
            ): Container(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            ),
            color: loading == true ? Colors.white : Colors.deepPurple,
            textColor: Colors.white,
          ),
          Spacer(),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _listenOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        body: Container(
          child:/* loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :*/ currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }
}