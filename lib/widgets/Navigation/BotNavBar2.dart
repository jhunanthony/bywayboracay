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
  int currentIndex = 1;
 
 final screens =[
   ItineraryPage(),
   ExplorePage(),
   BagPage(),
 ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavyBar(
          iconSize: 30,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            backgroundColor: Colors.yellow[50],
            containerHeight: 80,
            itemCornerRadius: 50,
            selectedIndex: currentIndex,
             onItemSelected: (index) {
            setState(() => currentIndex = index);
            
          },
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
      ),
    );
  }

}
*/