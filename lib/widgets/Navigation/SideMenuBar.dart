import 'package:bywayborcay/helper/AppIcons.dart';
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
                                height: 80,
                                width: 80,
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
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15))
                          ]),
                    ),
                  ),
                ]),

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
                      Navigator.of(context).pushReplacementNamed('/loginpage');
                    } else {
                      bool success = await loginService.signInWithGoogle();
                      if (success) {
                        Navigator.of(context)
                            .pushReplacementNamed('/mainpage');
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right:10, top:20, bottom:20),
                   
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
