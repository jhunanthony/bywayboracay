import 'package:bywayborcay/pages/BagPage.dart';
import 'package:bywayborcay/pages/DetailsPage.dart';
import 'package:bywayborcay/pages/ItemsPage.dart';
import 'package:bywayborcay/pages/LogInPage.dart';
import 'package:bywayborcay/pages/MapPage.dart';
import 'package:bywayborcay/pages/OnBoardingPage.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/categoryservice.dart';

import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/Itinerarypage2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/ExplorePage.dart';
import 'pages/LikedPage.dart';
import 'pages/SplashPage.dart';
import 'pages/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //add provider at the very root
    return MultiProvider(
      providers:[
      ChangeNotifierProvider(
      create: (_) => LoginService(),),
      ChangeNotifierProvider(
        create:(_) => CategorySelectionService(
      )),
      //tells all widget if there's a need for revuild
      ChangeNotifierProvider(
        create: (_) => LikeService()),
      //import instances from provider firebase
     
      Provider(
        create: (_) => CategoryService(),
      )
      ],
    
      child: MaterialApp(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'ProductSans'
        ),
        debugShowCheckedModeBanner: false,
        //use this to debug pages that needs data
    /*home: MapPage(
        items: Utils.getMockedCategory()[0].items[0],
      )*/
        //home: OnBoardingPage()
        //home: SplashPage(duration: 3, goToPage: LogInPage()),
       initialRoute: '/',
       routes:{
        '/': (context)=>SplashPage(duration: 3, goToPage: LogInPage()),
        '/loginpage' : (context)=> LogInPage(),
        '/mainpage' : (context)=> MainPage(),
        '/explorepage' : (context)=> ExplorePage(),
        '/itemspage':(context)=> ItemsPage(),
        '/detailspage':(context)=> DetailsPage(),
        '/mappage':(context)=> MapPage(),
        '/onboardingpage':(context)=> OnBoardingPage(),
        '/itinerarypage':(context)=> ItineraryPage(),
        '/likedpage':(context)=> LikedPage(),
        '/bagpage':(context)=> BagPage(),
       }
        )
    );
    
    
  }
}
