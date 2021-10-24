import 'dart:ui';

import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/LikedItemsModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/Navigation/BottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LikedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //fetch user data with login service

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;

    String userName = userModel != null ? userModel.displayName : 'User';

    //import like service provider

    LikeService likeService = Provider.of<LikeService>(context, listen: false);
    //bool if a user is currently logged in

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 80),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            'assets/icons/' + AppIcons.LikesIcon + '.svg',
            color: Colors.blue,
            height: 30,
            width: 30,
          ),
          Text(
            "Likes",
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue[100],
                fontWeight: FontWeight.w300),
          )
        ]),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Hi $userName,',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[100],
                ),
              ),
              Consumer<LikeService>(
                  //a function called when notifier changes
                  builder: (context, like, child) {
                return
                    //hide if 0 likes
                    Visibility(
                  visible: like.items.length > 0,
                  child: Text(
                    'you have ${like.items.length} liked items!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[100],
                    ),
                  ),
                );
              }),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    //remove all items
                    likeService.removeAll();
                  },
                  child: Container(

                      margin: EdgeInsets.only(right: 20, top:10),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 20, right: 20),
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.blue),
                          SizedBox(width: 5),
                          Text('Delete All',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ))
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Consumer<LikeService>(
            //a function called when notifier changes
            builder: (context, like, child) {
              List<Widget> likeditems = [];
              double mainTotal = 0;

              if (like.items.length > 0) {
                like.items.forEach((LikedItem item) {
                  Items itemslistinfo = (item.category as Items);
                  double total = itemslistinfo.itempriceMin;
                  mainTotal += total;

                  likeditems.add(
                      //for each item create a container to hold the values
                      Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: Offset.zero)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                  child: Image.asset(
                                      'assets/images/' +
                                          itemslistinfo.imgName +
                                          '.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover)),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemslistinfo.catname,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12),
                                    ),
                                    Text(
                                      itemslistinfo.itemaddress,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      'min. ₱ ' +
                                          itemslistinfo.itempriceMin.toString(),
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    like.remove(item);
                                  },
                                  icon: Icon(
                                    Icons.highlight_off,
                                    size: 30,
                                    color: Colors.blue,
                                  ))
                            ],
                          )));
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(children: likeditems),
                          )),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(CupertinoIcons.tag,
                                color: Colors.blue, size: 14),
                            SizedBox(
                              width: 10,
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text:
                                    'Calculated Min Price: \₱${mainTotal.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )
                            ]))
                          ],
                        ))
                  ],
                );
              } else {
                return Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.favorite_rounded,
                          size: 20, color: Colors.grey[400]),
                      Text(' Explore Boracay Now!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
                    ]));
              }
            },
          ),
        ),
        SizedBox(height: 75),
      ]),

      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
