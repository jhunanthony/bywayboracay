import 'package:bywayborcay/widgets/BagPageWidgets/local_foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/BagPageWidgets/CurrencyConverter/currencywidget.dart';
import '../widgets/BagPageWidgets/WeatherReportPage.dart';
import '../widgets/BagPageWidgets/local_events.dart';
import '../widgets/BagPageWidgets/local_products.dart';
import '../widgets/BagPageWidgets/tobring.dart';
import '../widgets/BagPageWidgets/travelguidelines.dart';
import '../widgets/BagPageWidgets/commonphrase.dart';
import '../widgets/BagPageWidgets/emergencywidget.dart';

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
            opacity: 0.5,
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
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("To provide further\n assistance in your\n travels,",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Byway Boracay is here to\nprovide you a set of tools\nthat might come-in hadly along\nthe way!",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[800])),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.blue[400], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (context) {
                                //Iterable markers = [];
                                //use iterable to map true items and return markers

                                return WeatherReportPage();
                              });
                        },
                        child: Container(
                          height: 75,
                          width: 180,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text

                              Text("Weather Report",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(CupertinoIcons.cloud_sun_fill,
                                  color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.blue[400], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ToBringPage()));
                        },
                        child: Container(
                          height: 75,
                          width: 180,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text

                              Text("To Bring",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(CupertinoIcons.bag,
                                  color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.blue[400], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommonPhrasePage()));
                        },
                        child: Container(
                          height: 75,
                          width: 180,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text

                              Text("Common Phrases",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.textsms_rounded,
                                  color: Colors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.blue[400], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TravelGuidelines()));
                        },
                        child: Container(
                          height: 95,
                          width: 120,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(Icons.airplanemode_active_rounded,
                                  color: Colors.white, size: 20),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Travel\nGuidelines",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.blue[400], ////background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TravelTips()));
                        },
                        child: Container(
                          height: 95,
                          width: 120,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(Icons.fact_check_rounded,
                                  color: Colors.white, size: 20),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Travel\nTips",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.green[300], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CurrencyPage()));
                        },
                        child: Container(
                          height: 95,
                          width: 120,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(Icons.sync_outlined,
                                  color: Colors.white, size: 20),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Currency\nConverter",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          shadowColor: Colors.black,
                          elevation: 4,
                          primary: Colors.red[400], //background
                          onPrimary: Colors.white,
                          //foreground
                          //remove border radius
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmergencyPage()));
                        },
                        child: Container(
                          height: 95,
                          width: 120,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(Icons.add_box_rounded,
                                  color: Colors.white, size: 20),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Emergency\nCalls",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),

              ///local
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalEventsWidgetPage()));
                    },
                    child: Container(
                      height: 130,
                      width: 95,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Fmaxresdefault.jpg?alt=media&token=00a4f767-5aff-4ab0-8611-5dc622a15738"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                offset: Offset(2, 2)),
                          ]),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                                height: 130,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.transparent,
                                      Colors.blue.withOpacity(0.3),
                                      Colors.blue.withOpacity(0.5),
                                      Colors.blue,
                                    ],
                                  ),
                                )),
                          ),
                          //use userLoggedIn flag to change icon and text

                          Positioned(
                            bottom: 8,
                            left: 3,
                            right: 3,
                            child: Text("Local\nEvents",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalFoodPage()));
                    },
                    child: Container(
                      height: 130,
                      width: 95,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Faklanon-food-6.jpg?alt=media&token=727b927d-4246-4ba4-90cf-c958359ad601"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                offset: Offset(2, 2)),
                          ]),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                                height: 130,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.transparent,
                                      Colors.blue.withOpacity(0.3),
                                      Colors.blue.withOpacity(0.5),
                                      Colors.blue,
                                    ],
                                  ),
                                )),
                          ),
                          //use userLoggedIn flag to change icon and text

                          Positioned(
                            bottom: 8,
                            left: 3,
                            right: 3,
                            child: Text("Local\nFoods",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalProductsWidgetPage()));
                    },
                    child: Container(
                      height: 130,
                      width: 95,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/local%2Fmine_large.jpg?alt=media&token=60df0a81-06e0-4af9-9dfd-d444792e366f"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                offset: Offset(2, 2)),
                          ]),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                                height: 130,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      Colors.transparent,
                                      Colors.blue.withOpacity(0.3),
                                      Colors.blue.withOpacity(0.5),
                                      Colors.blue,
                                    ],
                                  ),
                                )),
                          ),
                          //use userLoggedIn flag to change icon and text

                          Positioned(
                            bottom: 8,
                            left: 3,
                            right: 3,
                            child: Text("Local\nProducts",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
            ],
          ),
        ),

        //bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
