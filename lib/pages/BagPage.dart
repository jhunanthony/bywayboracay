import 'package:bywayborcay/widgets/MapWidgets/offline.dart';

import 'package:flutter/material.dart';

import '../widgets/BagPageWidgets/CurrencyConverter/currencywidget.dart';
import '../widgets/BagPageWidgets/commonphrase.dart';
import '../widgets/BagPageWidgets/emergencywidget.dart';

class BagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        //1sd Container
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(0),
            color: Colors.lightBlue[100],
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              fixedSize: Size(215.0, 90.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text("Travel\nGuidelines",
                                          textAlign: TextAlign.center),
                                    ),
                                    Icon(Icons.airplanemode_active_rounded),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white,
                              onSurface: Colors.grey,
                              padding: EdgeInsets.all(3.0),
                              fixedSize: Size(100.0, 90.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                            onPressed: () {},
                            child: Column(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("", textAlign: TextAlign.center),
                                ),
                                Icon(Icons.fact_check_rounded),
                                Text("\Travel\Tips")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            //2nd Container
            margin: const EdgeInsets.all(0),
            color: Colors.lightBlue[90],
            width: MediaQuery.of(context).size.width,
            height: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red[300],
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(220.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmergencyPage()));
                  },
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.add_box_rounded),
                      Text("\Emergency\nContacts")
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    onSurface: Colors.grey,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
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
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.textsms_rounded),
                      Text("\Common\nPhrases")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //3nd Container
            margin: const EdgeInsets.all(0),
            color: Colors.lightBlue[90],

            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    onSurface: Colors.grey,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {},
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.brightness_4_rounded),
                      Text("\Weather\nForecast")
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Offline_Map()));
                  },
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.fmd_good_rounded),
                      Text("\Offline\nMap")
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    primary: Colors.white,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrencyPage()));
                  },
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.attach_money_rounded),
                      Text("\tCurrency\nConverter")
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //4nd Container
            margin: const EdgeInsets.all(0),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    primary: Colors.blue,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {},
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(Icons.celebration_rounded),
                      Text("\tLocal\nEvents")
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    primary: Colors.blue,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {},
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(
                        Icons.liquor_rounded,
                      ),
                      Text('\t\t\tLocal\nProducts')
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    primary: Colors.blue,
                    padding: EdgeInsets.all(3.0),
                    fixedSize: Size(100.0, 90.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onPressed: () {},
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text("", textAlign: TextAlign.center),
                      ),
                      Icon(
                        Icons.local_dining_rounded,
                      ),
                      Text('\tLocal\nFoods')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
