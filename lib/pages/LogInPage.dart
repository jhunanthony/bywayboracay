import 'dart:ui';

import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/Navigation/TermsandCon.dart';

class LogInPage extends StatefulWidget {
  //final formKey = GlobalKey<FormState>();
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    //fetch login service via provider
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      //wraph with expanded to avoid axis error
      body:
          //use Flexible and FractionallySizedBox for resposiveness
          Container(

              //60%* of screen
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Login_Beach.jpg"),
                fit: BoxFit.fitHeight,
              )),
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                          decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.blue.withOpacity(0.1),
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.5),
                        Colors.blue.withOpacity(0.7),
                        Colors.blue.withOpacity(0.9),
                        Colors.blue,
                      ],
                    ),
                  ))),
                  //align all to center

                  Center(

                      //represents a point that is horizontally centered with respect to the rectangle and vertically half way between the top edge and the center.

                      child: Column(
                    children: [
                      SizedBox(
                        height: 85,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0.8),
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/Logo_Test.png",
                          )),
                      Text('Byway Boracay',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 3.0, color: Colors.grey[900]),
                            ],
                          )),
                      Text('Venture with Precision',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(blurRadius: 5, color: Colors.grey[900]),
                            ],
                          ))
                    ],
                  )),
                  //use this as spacer

                  Positioned(
                      bottom: 25,
                      right: 20,
                      left: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.black.withOpacity(0.12),
                            child: Column(
                              children: [
                                Text('WELCOME,',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text("I'm your new travel buddy!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200)),
                                SizedBox(height: 25),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.white, //background
                                      onPrimary: Colors.yellow, //foreground
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.yellow[100],
                                          Colors.yellow[700],
                                          Colors.yellow[900]
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.person_fill,
                                            size: 25, color: Colors.white),
                                        Text(
                                          '  Continue as Guest',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/onboardingpage');
                                  },
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      primary: Colors.white, //background
                                      onPrimary: Colors.blue, //foreground
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.blue[100],
                                          Colors.blue[500],
                                          Colors.blue[700]
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(50),
                                                  topLeft:
                                                      Radius.circular(50))),
                                          child: Center(
                                            child: SvgPicture.asset(
                                                'assets/icons/google.svg',
                                                height: 25,
                                                width: 25),
                                          ),
                                        ),
                                        Text(
                                          'Sign In with Google',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    bool success =
                                        await loginService.signInWithGoogle();

                                    if (success) {
                                      Auth().signInWithGoogle().then((user) {
                                        checkIfExists(user);
                                      });

                                      // Navigator.of(context).pushReplacementNamed('/onboardingpage');
                                    }
                                  },
                                ),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermsConditionPage()));
                                  },
                                  child: Text('Terms and Conditions',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w200)),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              )),

      //continue button
    ));
  }

  void checkIfExists(User user) async {
    final snapShot =
        await databaseReference.collection('Users').doc(user.uid).get();
    if (snapShot == null || !snapShot.exists) {
      DocumentReference newData =
          databaseReference.collection("Users").doc(user.uid);
      newData.set({'Name': user.displayName, 'Email': user.email});
      Navigator.of(context).pushReplacementNamed('/onboardingpage');
    } else {
      Navigator.of(context).pushReplacementNamed('/onboardingpage');
    }
  }
}
