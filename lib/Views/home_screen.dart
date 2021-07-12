import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ProfileType { Shipper, Transporter }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileType? _profileType;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Icon(Icons.logout),
      ),*/
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(
              "Please select your profile",
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w500, fontSize: 25)),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: ProfileType.Shipper,
                    groupValue: _profileType,
                    onChanged: (ProfileType? value) {
                      setState(() {
                        _profileType = value;
                      });
                    },
                  ),
                  Icon(Icons.home),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Shipper",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Merchant shipper may be an \n authorised agent.Merchant shipper",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: ProfileType.Transporter,
                    groupValue: _profileType,
                    onChanged: (ProfileType? value) {
                      setState(() {
                        _profileType = value;
                      });
                    },
                  ),
                  Icon(Icons.directions_bus_rounded),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transporter",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "A mode of transport is a solution \n that makes A mode of transport is",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: 135, vertical: 10),
              color: Colors.deepPurple,
              child: Text('CONTINUE',
                  style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w500, color: Colors.white)),
              onPressed: () {
                setState(() {
                  // button action.
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
