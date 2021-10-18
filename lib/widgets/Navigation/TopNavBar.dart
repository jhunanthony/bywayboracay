import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ProfilePicHeader.dart';

// ignore: must_be_immutable
class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  Color colorbackground;

  bool showTopProfile;
  bool showTopLogo;
  Color theme;

  TopNavBar({
    this.theme = Colors.blue,
    this.colorbackground,
    this.showTopProfile = true,
    this.showTopLogo = true,
  });

  @override
  TopNavBarState createState() => TopNavBarState();

  @override
  Size get preferredSize => new Size.fromHeight(60);
}

class TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: true,
      title: Visibility(
        visible: widget.showTopLogo,
        child: ClipOval(
          child: Image.asset(
            "assets/images/" + AppIcons.LogoIcon + ".png",
            height: 40,
            width: 40,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      backgroundColor: widget.colorbackground,
      elevation: 0,
      iconTheme: IconThemeData(color: widget.theme),
      actions: [
       /* Visibility(
          visible: widget.showTopProfile,
          child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(CupertinoIcons.profile_circled,
                  size: 40, color: Colors.white)

              /*SvgPicture.asset('assets/icons/Profile.svg',
                  height: 20,
                  width: 20,
                  fit: BoxFit.contain,
                  color: Colors.blue)*/,,*/

        ProfilePicHeader(showProfilePic: widget.showTopProfile)
      ],
    );
  }
}

