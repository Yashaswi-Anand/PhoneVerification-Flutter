import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification_flutter/Views/home_screen.dart';
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

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCerdential) async {
    setState(() {
      loading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCerdential);

      setState(() {
        loading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on Exception catch (e) {
      setState(() {
        loading = false;
      });
      _globalKey.currentState!.showSnackBar(SnackBar(
        content: Text("error in login"),
      ));
    }
  }

  getMobileFormWidget(context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Text(
            "Please enter your mobile number",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "you will receive an otp for verification...",
            style: TextStyle(color: Colors.black38),
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Phone Number",
              //hintText: "Phone Number",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 10),
            onPressed: () async {
              setState(() {
                loading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: "+91 " + phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    loading = false;
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
                    loading = false;
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
            child: Text('continue',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            color: Colors.brown,
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
          Spacer(),
          Text(
            "Verify Number",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          Text(
            "Code is send to " + phoneController.text,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          SizedBox(
            height: 16,
          ),
          PinFieldAutoFill(
            controller: otpController,
            codeLength: 6,
            decoration: const UnderlineDecoration(
                colorBuilder: FixedColorBuilder(Colors.blue)),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Didn't receive the code?",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
              Text(
                "Request Again",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 10),
            onPressed: () async {
              final phoneAuthCerdential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: otpController.text);
              signInWithPhoneAuthCredential(phoneAuthCerdential);
            },
            child:  Text('verify',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            color: Colors.brown,
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
        backgroundColor: Colors.blue[50],
        key: _globalKey,
        body: Container(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }
}
