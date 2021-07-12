import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Icon(
              Icons.image_rounded,
              size: 140,
            ),
            SizedBox(
              height: 18,
            ),
            Text("Please select your language",
                style: GoogleFonts.oswald(
                    fontSize: 25, fontWeight: FontWeight.w700)),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                width: 200,
                child: Text(
                  "  You can change the language \n               at any time",
                  style: TextStyle(fontSize: 15, color: Colors.black38),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  "  select your language  ",
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
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
              color: Colors.deepPurple,
              child: Text('NEXT',
                  style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20)),
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
