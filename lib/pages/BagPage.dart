import 'package:bywayborcay/widgets/BagPageWidgets/local_products/localproducts.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';

import '../widgets/BagPageWidgets/CurrencyConverter/currencywidget.dart';
import '../widgets/BagPageWidgets/tobring.dart';
import '../widgets/BagPageWidgets/travelguidelines.dart';
import '../widgets/BagPageWidgets/commonphrase.dart';
import '../widgets/BagPageWidgets/emergencywidget.dart';
import '../widgets/BagPageWidgets/local_events/localevents.dart';
import '../widgets/BagPageWidgets/traveltips.dart';

class BagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Explore_Beach.jpg'),
            fit: BoxFit.fitHeight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelGuidelines()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Travel\nGuidelines",
                                textAlign: TextAlign.center),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.airplanemode_active_rounded),
                          ],
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                      onSurface: Colors.grey,
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelTips()));
                    },
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.fact_check_rounded),
                        Text("\Travel\nTips")
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red[300],
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmergencyPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Text("\Emergency\nContacts"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add_box_rounded),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 14, bottom: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ToBringPage()));
                    },
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.bag,
                        ),
                        Text("\To Bring"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                      onSurface: Colors.grey,
                      padding: EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommonPhrasePage()));
                    },
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.textsms_rounded),
                        Text("\Common\nPhrases")
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      primary: Colors.white,
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrencyPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Text("", textAlign: TextAlign.center),
                        Icon(Icons.sync_outlined),
                        Text("\tCurrency\nConverter")
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      primary: Colors.blue,
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalEvents()));
                    },
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(Icons.celebration_rounded),
                        Text("\tLocal\nEvents")
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      primary: Colors.blue,
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalProducts()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Text("", textAlign: TextAlign.center),
                        Icon(
                          Icons.liquor_rounded,
                        ),
                        Text('\t\t\tLocal\nProducts')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),

        //bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
