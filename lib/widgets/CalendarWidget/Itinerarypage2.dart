import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'auth.dart';
import 'calendar.dart';

class ItineraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      // ignore: missing_return
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return new Container(child: Text("Firebase went wrong"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if (Auth().getCurrentUser() != null) {
            return CalendarPage();
          } else {
            return Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Column(children: [SizedBox(height: 80),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          SvgPicture.asset(
                        'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                            Text(
                              " Itineray",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue[100],
                                  fontWeight: FontWeight.w300),
                            )
                          ]),],),
                      Column(children: [Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             SvgPicture.asset(
                        'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                        color: Colors.grey[700],
                        height: 20,
                        width: 20,
                      ),
                            Text(' Login and Start Planning!',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 20,
                                )),
                          ]),
                      SizedBox(height: 305),],)
                    ])));
            //Container(child: Center(child: Text('Log In to access Itinerary')));
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
