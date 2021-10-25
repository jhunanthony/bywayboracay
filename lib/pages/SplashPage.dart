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
            backgroundColor: Colors.white,
            body: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Test_Image_1.png"),
                                fit: BoxFit.cover,
                              ))),
                    
                    //use SizedBox for spacing
                    SizedBox(height: 10),
                    Text('Brand Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 40,
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ),
              )
            ])));
  }
}
