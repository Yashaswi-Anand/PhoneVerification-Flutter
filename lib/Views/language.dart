import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_verification_flutter/Views/home_screen.dart';
import 'package:phone_verification_flutter/Views/login_screen.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  var _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Text("Please select your language",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown),),
            SizedBox(
              height: 5,
            ),
            Text("Change the language",style: TextStyle(fontSize: 15,  color: Colors.black87),),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: DropdownButton<String>(
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.black),
                items: <String>[
                  'Select',
                  'English'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Please select your language",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _chosenValue = value!;
                  });
                }
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              padding: const EdgeInsets.symmetric(horizontal: 83,vertical: 10),
              color: Colors.brown,
              child: Text('Next',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
              onPressed: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
            ),
            Spacer(),
           ],
        ),
      ),
    );
  }
}
