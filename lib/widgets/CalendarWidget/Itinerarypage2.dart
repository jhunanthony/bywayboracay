
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../services/loginservice.dart';
import 'auth.dart';
import 'calendar.dart';

class ItineraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    bool userLoggedIn = loginService.loggedInUserModel != null;
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background
                            onPrimary: Colors.blue,
                            //foreground
                            //remove border radius
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (userLoggedIn) {
                              await loginService.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/loginpage',
                                  (Route<dynamic> route) => false);
                            } else {
                              bool success =
                                  await loginService.signInWithGoogle();
                              if (success) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/mainpage');
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //use userLoggedIn flag to change icon and text
                                Icon(userLoggedIn ? Icons.logout : Icons.login,
                                    color: Colors.blue, size: 20),
                                SizedBox(width: 5),
                                Text(userLoggedIn ? 'Sign Out' : 'Sign In',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20))
                              ],
                            ),
                          ),
                        ),
                      ),
                        SizedBox(height: 10),
                      Text(' Login and Start Planning!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
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
