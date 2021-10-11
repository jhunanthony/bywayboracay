/*import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/pages/BagPage.dart';
import 'package:bywayborcay/pages/ExplorePage.dart';
import 'package:bywayborcay/pages/ItineraryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BotNavBar2 extends StatefulWidget {
  @override
  _BotNavBar2State createState() => _BotNavBar2State();
}

class _BotNavBar2State extends State<BotNavBar2> {
  int _currentindex = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  //dispose method when another page is accessed
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          backgroundColor: Colors.yellow[50],
          containerHeight: 80,
          itemCornerRadius: 50,
          selectedIndex: _currentindex,
          onItemSelected: (index) => setState(() => _currentindex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: SvgPicture.asset(
                'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                color: Colors.blue,
              ),
              title: Text('Itinerary'),
              textAlign: TextAlign.center,
              activeColor: Colors.pink,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset(
                'assets/icons/' + AppIcons.ExploreIcon + '.svg',
                color: Colors.blue,
              ),
              title: Text('Explore'),
              textAlign: TextAlign.center,
              activeColor: Colors.blue,
            ),
            BottomNavyBarItem(
              icon: SvgPicture.asset(
                'assets/icons/' + AppIcons.BagIcon + '.svg',
                color: Colors.blue,
              ),
              title: Text('Bag'),
              textAlign: TextAlign.center,
              activeColor: Colors.green,
            ),
          ]),
    );
  }

  Widget buildPages() {
    switch (_currentindex) {
      case 2:
        return BagPage();
      case 0:
        return ItineraryPage();
      case 1:
      default:
        return ExplorePage();
    }
  }
}*/
