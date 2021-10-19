import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/services/likeservice.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
          height: 65,
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
                      highlightColor: Colors.blue.withOpacity(0.3),
                      splashColor: Colors.white.withOpacity(0.3),
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
                      highlightColor: Colors.blue.withOpacity(0.3),
                      splashColor: Colors.white.withOpacity(0.3),
                      icon: SvgPicture.asset(
                          'assets/icons/' + AppIcons.ItineraryIcon + '.svg',
                          color: Colors.blue,
                          height: 30,
                          width: 30),
                      onPressed: () {},
                    )),
              ),
              Padding(
                padding:  EdgeInsets.only(left:5, right:5, top:8, bottom:8),
                child: ClipOval(
                  child: Material(
                      color: Colors.transparent,
                      child: Container(

                        child: Stack(
                                  children: [
                                    Center(
                                        child: IconButton(
                                          highlightColor: Colors.blue.withOpacity(0.3),
                          splashColor: Colors.white.withOpacity(0.3),
                                          icon: Icon(Icons.favorite_border_rounded, size: 30,),
                                            color: Colors.blue, 
                                         onPressed: () {},
                                           )),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Consumer<LikeService>(
                                          //a function called when notifier changes
                                          builder: (context, like, child) {
                                        return
                                            //hide if 0 likes
                                            Visibility(
                                          visible: like.items.length > 0,
                                          child: Text(
                                            '${like.items.length}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue[100],
                                                fontWeight: FontWeight.w300),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                      ),
                        

                            /*Consumer<LikeService>(
                              //a function called when notifier changes
                              builder: (context, like, child) {
                            return Row(children: [
                              Icon(Icons.favorite_border_rounded,
                                  color: Colors.blue, size: 30),
                              //hide if 0 likes
                              Visibility(
                                visible: like.items.length > 0,
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${like.items.length}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ]);
                          }),*/
                            
                       
                      ),
                ),
              ),
              ClipOval(
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      highlightColor: Colors.blue.withOpacity(0.3),
                      splashColor: Colors.white.withOpacity(0.3),
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
