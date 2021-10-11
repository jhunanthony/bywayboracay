import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      centerTitle: true,
      title: Visibility(
        visible: widget.showTopLogo,
        child: Image.asset(
          "assets/images/Test_Logo.png",
          height: 40,
          width: 40,
          fit: BoxFit.scaleDown,
        ),
      ),
      backgroundColor: widget.colorbackground,
      elevation: 0,
      iconTheme: IconThemeData(color: widget.theme),
      actions: [
        
        Visibility(
          visible: widget.showTopProfile,
          child: Container(
            margin: EdgeInsets.only(right: 13),
            padding: EdgeInsets.all(8),
             child: SvgPicture.asset('assets/icons/Profile.svg',
             height: 40,
                          width: 40,
                          fit: BoxFit.scaleDown,
                color: Colors.blue)
          ),
        )

        /*Visibility(
            visible: widget.showTopProfile,
            child: Container(
                margin: EdgeInsets.only(right: 13),
                padding: EdgeInsets.all(8),
                child: ClipOval(
                    child: Image.asset('assets/icons/Profile.svg',
                        color: Colors.black,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover))))*/
      ],
    );
  }
}
