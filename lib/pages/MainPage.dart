import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/pages/BagPage.dart';
import 'package:bywayborcay/pages/ExplorePage.dart';
import 'package:bywayborcay/pages/ItineraryPage.dart';
import 'package:bywayborcay/pages/LikedPage.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../widgets/Navigation/SideMenuBar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  /*final screens = [
    ExplorePage(),
    ItineraryPage(),
    LikedPage(),
    BagPage(),
  ];*/

  @override
  Widget build(BuildContext context) {
 
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(elevation: 6, child: SideMenuBar()),
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
            bottom: 8,
            right: 15,
            left: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BottomNavyBar(
                  iconSize: 30,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  backgroundColor: Colors.yellow[50],
                  containerHeight: 65,
                  itemCornerRadius: 50,
                  selectedIndex: currentIndex,
                  onItemSelected: (index) {
                    setState(() => currentIndex = index);
                  },
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/' + AppIcons.ExploreIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                      title: Text('Explore'),
                      textAlign: TextAlign.center,
                      activeColor: Colors.blue,
                    ),
                    BottomNavyBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                      title: Text('Itinerary'),
                      textAlign: TextAlign.center,
                      activeColor: Colors.blue,
                    ),
                    BottomNavyBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/' + AppIcons.LikesIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                      title: Text('Likes'),
                      textAlign: TextAlign.center,
                      inactiveColor: Colors.blue,
                      activeColor: Colors.blue,
                    ),
                    BottomNavyBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/' + AppIcons.BagIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                      title: Text('Bag'),
                      textAlign: TextAlign.center,
                      activeColor: Colors.blue,
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  Widget buildPages() {
    switch (currentIndex) {
      case 1:
        return ItineraryPage();
      case 2:
        return LikedPage();
      case 3:
        return BagPage();
      case 0:
      default:
        return ExplorePage();
      
    }
  }
}
