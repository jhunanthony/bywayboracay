import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/pages/BagPage.dart';
import 'package:bywayborcay/pages/ExplorePage.dart';

import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/ratedservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/Itinerarypage2.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/Navigation/SideMenuBar.dart';

class MainPage extends StatefulWidget {
  int currentIndex;

  MainPage({this.currentIndex = 0});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String likes;

  /*final screens = [
    ExplorePage(),
    ItineraryPage(),
    LikedPage(),
    BagPage(),
  ];*/

  @override
  Widget build(BuildContext context) {
    //implement a method that clears likeitems when users log out and new user come in
   /* SaveService likeService = Provider.of<SaveService>(context, listen: false);
    //fetch liked items and load on likepage
    likeService.loadLikedItemsFromFirebase(context);*/

   /* RatingService ratingService =
        Provider.of<RatingService>(context, listen: false);
    //fetch liked items and load on likepage
    ratingService.loadRatedItemsFromFirebase(context);*/

    return SafeArea(
      child: Scaffold(
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: Drawer(elevation: 6, child: SideMenuBar())),
        body: Stack(children: [
          buildPages(),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: TopNavBar(
                colorbackground: Colors.transparent,
              )),
          Positioned(
            bottom: 6,
            right: 20,
            left: 20,
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: 8,
              shadowColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BottomNavyBar(
                    iconSize: 30,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    backgroundColor: Colors.white,
                    containerHeight: 68,
                    itemCornerRadius: 50,
                    selectedIndex: widget.currentIndex,
                    onItemSelected: (index) {
                      setState(() => widget.currentIndex = index);
                    },
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.compass, size: 30),
                        title: Text('Explore'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.calendar, size: 30),
                        title: Text('Itinerary'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                      BottomNavyBarItem(
                        icon: Icon(CupertinoIcons.bag, size: 30),
                        /*icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.BagIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30,
                        ),*/
                        title: Text('Bag'),
                        textAlign: TextAlign.center,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.blue[200],
                      ),
                    ]),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget buildPages() {
    switch (widget.currentIndex) {
      case 1:
        return ItineraryPage();
      /*case 2:
        return LikedPage();*/
      case 2:
        return BagPage();
      case 0:
      default:
        return ExplorePage();
    }
  }
}
