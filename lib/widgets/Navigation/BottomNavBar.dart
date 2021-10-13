import 'package:bywayborcay/helper/AppIcons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentindex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13, right: 13, bottom: 10, top: 10),
      child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.blue[50],
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(2, 2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipOval(
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30),
                      onPressed: () {},
                    )),
              ),
              ClipOval(
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.ExploreIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30),
                      onPressed: () {},
                    )),
              ),
              ClipOval(
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/' + AppIcons.BagIcon + '.svg',
                        color: Colors.blue,
                        height: 30,
                        width: 30,
                      ),
                      onPressed: () {},
                    )),
              ),
            ],
          )),
    );
  }
}
