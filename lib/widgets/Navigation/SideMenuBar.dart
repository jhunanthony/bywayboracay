import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/helper/Utils.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:flutter/material.dart';
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
            padding: EdgeInsets.all(50),
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //user image
                          ClipOval(
                            child: Image.network(
                              userImg,
                              height: 80,
                              width: 80,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('Welcome to Boracay!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(height: 12),
                          Text(userName,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30))
                        ]),
                  ),
                ]),

                TextButton(
                  onPressed: () async {
                    if (userLoggedIn) {
                      await loginService.signOut();
                      Utils.mainAppNav.currentState
                          .pushReplacementNamed('/loginpage');
                    } else {
                      bool success = await loginService.signInWithGoogle();
                      if (success) {
                        Utils.mainAppNav.currentState
                            .pushReplacementNamed('/defaultpage');
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //use userLoggedIn flag to change icon and text
                      Icon(userLoggedIn ? Icons.logout : Icons.login,
                          color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(userLoggedIn ? 'Sign Out' : 'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 25))
                    ],
                  ),
                ),
              ],
            )));
  }
}
