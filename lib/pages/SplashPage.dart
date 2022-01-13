import 'package:bywayborcay/pages/LogInPage.dart';
import 'package:bywayborcay/services/categoryservice.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget goToPage;

  SplashPage({this.goToPage, this.duration});

  @override
  Widget build(BuildContext context) {
    //retrieve instance of categoryservice
    CategoryService catService =
        Provider.of<CategoryService>(context, listen: false);

    Future.delayed(Duration(seconds: this.duration), () async {
      //wait for the firebase initialization to occur if fetched start pulling data from online database
      FirebaseApp app = await Firebase.initializeApp();

      //fetch data from firebase
      catService.getCategoriesCollectionFromFirebase().then((value) {
        Navigator.of(context).pushNamed('/loginpage');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => this.goToPage));
      });
    });

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blue,
            body: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
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
                        //color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/images/Logo_Test.png",
                        height: 150,
                        width: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    //use SizedBox for spacing
                    SizedBox(height: 10),
                    Text('Byway Boracay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              )
            ])));
  }
}
