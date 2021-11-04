import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


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
      body: Column(
        children: [
          //use Flexible and FractionallySizedBox for resposiveness
          Container(

              //60%* of screen
              height: MediaQuery.of(context).size.height * 0.60,
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
                        Colors.transparent,
                        Colors.blue.withOpacity(0.5),
                      ],
                    ),
                  ))),
                  //align all to center
                  Align(
                      //represents a point that is horizontally centered with respect to the rectangle and vertically half way between the top edge and the center.
                      alignment: Alignment(0.0, -0.3),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.transparent,
                                Colors.white.withOpacity(0.5),
                                Colors.white,
                              ],
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/Logo_Test.png",
                          ))),
                  //use this as spacer
                  Align(
                    alignment: Alignment(0.0, 0.6),
                    child: Text('Byway Boracay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w400)),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.8),
                    child: Text('Venture with Precision',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w200)),
                  ),
                ],
              )),

          Column(
            children: [
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background
                    onPrimary: Colors.white, //foreground
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Continue as Guess',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/onboardingpage');
                },
              ),
              SizedBox(height: 25),
              Text(
                '- Login with Google - ',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w200),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background
                    onPrimary: Colors.blue,
                    //foreground
                    shape: CircleBorder(),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )),
                    child: SvgPicture.asset('assets/icons/google.svg',
                        height: 30, width: 30),
                  ),
                  //capture the success flag with async and await
                  onPressed: () async {
                    bool success = await loginService.signInWithGoogle();

                    if (success) {
                      Auth().signInWithGoogle().then((user) {
                        checkIfExists(user);
                      });

                      // Navigator.of(context).pushReplacementNamed('/onboardingpage');
                    }
                  }),
            ],
          )

          //continue button
        ],
      ),
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
