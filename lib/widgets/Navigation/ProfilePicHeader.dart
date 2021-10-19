import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:flutter/material.dart';
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
            width: 30,
            height: 30,
          );
  }
}
