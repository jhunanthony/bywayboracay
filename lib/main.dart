import 'package:bywayborcay/pages/DetailsPage.dart';
import 'package:bywayborcay/pages/ItemsPage.dart';
import 'package:bywayborcay/pages/LogInPage.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //use this to debug pages that needs data
      home: DetailsPage(
        items: Utils.getMockedCategory()[0].items[0],
      )
     //home: SplashPage(duration: 3, goToPage: LogInPage()),
    );
  }
}

