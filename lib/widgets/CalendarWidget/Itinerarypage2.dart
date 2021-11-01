import 'package:bywayborcay/pages/LogInPage.dart';
import 'package:bywayborcay/widgets/CalendarWidget/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

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
            return Container(decoration: BoxDecoration(color: Colors.white), child:  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 20, color: Colors.grey[400]),
                      Text(' Login and Start Planning!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
                    ]))   );
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
