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
import 'package:bywayborcay/services/ratedservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/Itinerarypage2.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'pages/ExplorePage.dart';
import 'pages/LikedPage.dart';
import 'pages/SplashPage.dart';
import 'pages/MainPage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize(
  'resource://drawable/res_notification_app_icon',
  [
    NotificationChannel(
  channelKey: 'scheduled_channel',
  channelName: 'Scheduled Notifications',
  channelDescription: 'For basic notification' ,
  defaultColor: Colors.teal,
  locked: true,
  importance: NotificationImportance.High,
   ),
 

    /*NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      channelDescription: 'For basic notification' ,
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,  
    ),*/
  ],
  );

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
     ChangeNotifierProvider(
        create: (_) => RatingService()),
      Provider(
        create: (_) => CategoryService(),
      )
      ],
    
      child: OverlaySupport.global(
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
          ),
      )
    );
    
    
  }
}
