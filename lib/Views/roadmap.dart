import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoadMap extends StatefulWidget {
  const RoadMap({Key? key}) : super(key: key);

  @override
  _RoadMapState createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
        title: Center(child: Text("Suggested Loads",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top:12,bottom: 12,right: 18),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.deepPurple,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    Icons.privacy_tip_outlined,
                    size: 10,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(width: 3,),
                  Text(
                    'Filter',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child:
            ListView.builder(
              itemCount: cityName.length,
              itemBuilder: (context, position) {
                return Card(
                  child: CardView(cityName[position]),
                );
              },
            ),


      ),
    );
  }
}

class CardView extends StatelessWidget {
  CityName cityName;
  CardView(this.cityName);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Posted on: 27Apr, Tue| Ends on : 10 May Thr,",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.radio_button_checked_outlined,color: Colors.green,size: 15,),
                          SizedBox(
                            width: 15,
                          ),
                          Text(cityName.desiCity,style: GoogleFonts.oswald(fontSize: 18),),
                        ],
                      ),
                      Container(margin: EdgeInsets.only(left: 5), child: Text("|",),),
                      Row(
                        children: [
                          Icon(Icons.radio_button_off,color: Colors.red,size: 15,),
                          SizedBox(
                            width: 15,
                          ),
                          Text(cityName.arriveCity,style: GoogleFonts.oswald(fontSize: 18),),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.directions_bus_outlined,color: Colors.yellow,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Packaged Container/High-cube container \n| 20 trucks",
                      style: GoogleFonts.oswald(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.account_box_rounded,color: Colors.yellow,),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Packaged/Consumer boxes | 21-30 tons",
                      style: GoogleFonts.oswald(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.payment_rounded,color: Colors.deepPurple,),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Rs6000/tonne",
                        style: GoogleFonts.oswald(fontSize: 15,color: Colors.deepPurple),
                      ),
                      Spacer(),
                      Container(
                        height: 25,
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.topRight,
                        child: FloatingActionButton.extended(
                            onPressed: () {},
                            label: Text("Bid",style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.deepPurple
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Asian Paint Pvt Ltd",
                  style:GoogleFonts.oswald(fontSize: 15),
                ),
                Spacer(),
                Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 18,
                        ),
                        SizedBox(width: 3,),
                        Text(
                          'Call',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CityName {
  String arriveCity;
  String desiCity;

  CityName(this.arriveCity, this.desiCity);
}

// List of Items
List<CityName> cityName = [
  CityName("Visakhapatnam","Ahmedabad"),
  CityName( "Thiruvanathupuram","Ahmedabad"),
  CityName( "Visakhapatnam","Bhubaneswar"),
  CityName( "Thiruvanathupuram","Ahmedabad"),
  CityName( "Visakhapatnam","Bhubaneswar"),
];


