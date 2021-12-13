import 'package:flutter/material.dart';

import 'ProfilePicHeader.dart';

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
      //able to tap and return to landing page

      

      title: Visibility(
        visible: widget.showTopLogo,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/mainpage', (Route<dynamic> route) => false);
            /*Navigator.of(context)
              .popUntil((route) => route.settings.name == '/mainpage');*/
          },
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withOpacity(0.3),
                  Colors.white,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/images/Logo_Test.png",
              height: 35,
              width: 35,
              fit: BoxFit.scaleDown,
            ),
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
