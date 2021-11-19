import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/pages/LikedPage.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

//create a side menu bar

class SideMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //get other user information using login provider
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;

    String userImg = userModel != null ? userModel.photoUrl : '';
    String userName = userModel != null ? userModel.displayName : '';

    bool showUserInfo = userImg.isNotEmpty && userName.isNotEmpty;

    //bool if a user is currently logged in
    bool userLoggedIn = loginService.loggedInUserModel != null;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.blue[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //show logo
                Column(children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/images/" + AppIcons.LogoIcon + ".png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  SizedBox(height: 40),
                  //display user information
                  //user visibility to hide if empty
                  Visibility(
                    visible: showUserInfo,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //user image
                            ClipOval(
                              child: Image.network(
                                userImg,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(height: 12),
                            /*Text('Welcome to Boracay!',
                             textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20)),*/
                            SizedBox(height: 12),
                            Text('Hi, ' + userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15))
                          ]),
                    ),
                  ),
                ]),
                Consumer<LoginService>(builder: (context, loginService, child) {
                  if (loginService.isUserLoggedIn()) {
                    return Consumer<LikeService>(
                        //a function called when notifier changes
                        builder: (context, like, child) {
                      return
                          //hide if 0 likes
                          GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LikedPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Stack(children: [
                            SvgPicture.asset(
                              'assets/icons/' + AppIcons.LikesIcon + '.svg',
                              color: Colors.blue,
                              height: 30,
                              width: 30,
                            ),
                            //get the number of like values
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Visibility(
                                visible: like.items.length > 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow[50],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    '${like.items.length}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    });
                  }
                  return SizedBox();
                }),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background
                    onPrimary: Colors.blue,
                    //foreground
                    //remove border radius
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () async {
                    if (userLoggedIn) {
                      await loginService.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                '/loginpage', (Route<dynamic> route) => false);
                     
                    } else {
                      bool success = await loginService.signInWithGoogle();
                      if (success) {
                        Navigator.of(context).pushReplacementNamed('/mainpage');
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //use userLoggedIn flag to change icon and text
                        Icon(userLoggedIn ? Icons.logout : Icons.login,
                            color: Colors.blue, size: 20),
                        SizedBox(width: 5),
                        Text(userLoggedIn ? 'Sign Out' : 'Sign In',
                            style: TextStyle(color: Colors.blue, fontSize: 20))
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
