import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfilePicHeader extends StatelessWidget {
  bool showProfilePic;

  ProfilePicHeader({this.showProfilePic});

  @override
  Widget build(BuildContext context) {
    //fetch login service via provider
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;

    String imgPath = userModel != null ? userModel.photoUrl : '';

    return this.showProfilePic && imgPath.length > 0
        ? Container(

            //margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(20),
            child: ClipOval(
                //get the photo url
                child: Image.network(
              imgPath,
            )))
        : SizedBox(
            height: 30,
            width: 30,
          );

    /*Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(
              'assets/icons/' + AppIcons.UserIcon + '.svg',
              color: Colors.blue,
              height: 30,
              width: 30,
            ),
        );*/
  }
}
