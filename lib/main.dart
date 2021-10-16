import 'package:bywayborcay/pages/DetailsPage.dart';
import 'package:bywayborcay/pages/ItemsPage.dart';
import 'package:bywayborcay/pages/LogInPage.dart';
import 'package:bywayborcay/pages/MapPage.dart';
import 'package:bywayborcay/pages/OnBoardingPage.dart';
import 'package:flutter/material.dart';

import 'helper/Utils.dart';
import 'pages/ExplorePage.dart';
import 'pages/SplashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        //use this to debug pages that needs data
    /*home: MapPage(
        items: Utils.getMockedCategory()[0].items[0],
      )*/
        //home: OnBoardingPage()
        home: SplashPage(duration: 3, goToPage: LogInPage()),
        );
  }
}
