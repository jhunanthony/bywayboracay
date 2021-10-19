import 'package:bywayborcay/pages/BagPage.dart';
import 'package:bywayborcay/pages/DetailsPage.dart';
import 'package:bywayborcay/pages/ItemsPage.dart';
import 'package:bywayborcay/pages/ItineraryPage.dart';
import 'package:bywayborcay/pages/LogInPage.dart';
import 'package:bywayborcay/pages/MapPage.dart';
import 'package:bywayborcay/pages/OnBoardingPage.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/Utils.dart';
import 'models/LikedItemsModel.dart';
import 'pages/ExplorePage.dart';
import 'pages/SplashPage.dart';
import 'widgets/Navigation/BotNavBar2.dart';

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
      Provider(
      create: (_) => LoginService(),),
      ChangeNotifierProvider(
        create:(_) => CategorySelectionService(
      )),
      //tells all widget if there's a need for revuild
      ChangeNotifierProvider(
        create: (_) => LikeService())
      ],
    
      child: MaterialApp(
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
        //home: SplashPage(duration: 3, goToPage: LogInPage()),
       initialRoute: '/',
       routes:{
        '/': (context)=>SplashPage(duration: 3, goToPage: LogInPage()),
        '/loginpage' : (context)=> LogInPage(),
        '/explorepage' : (context)=> ExplorePage(),
        '/itemspage':(context)=> ItemsPage(),
        '/detailspage':(context)=> DetailsPage(),
        '/mappage':(context)=> MapPage(),
        '/onboardingpage':(context)=> OnBoardingPage(),
        '/itinerarypage':(context)=> ItineraryPage(),
        '/bagpage':(context)=> BagPage(),
       }
        )
    );
    
    
  }
}
