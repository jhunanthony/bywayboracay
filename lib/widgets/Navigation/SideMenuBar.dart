import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/pages/SavePage.dart';
import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/Navigation/AboutUs.dart';
import 'package:bywayborcay/widgets/Navigation/PrivacyPolicy.dart';
import 'package:bywayborcay/widgets/Navigation/TermsandCon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../services/ratedservice.dart';

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
    String userEmail = userModel != null ? userModel.email : '';
        String userId = userModel != null ? userModel.uid : '';

    bool showUserInfo = userImg.isNotEmpty && userName.isNotEmpty;
//x19aFGBbXBaXTZY92Al8f8UbWyX2
    //bool if a user is currently logged in
    bool userLoggedIn = loginService.loggedInUserModel != null;
    //RatingService ratingService = Provider.of<RatingService>(context, listen: false);

    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //show logo

            Column(
              children: [
                Visibility(
                  replacement: SizedBox(height: 200),
                  visible: showUserInfo,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    color: Colors.blue[400],
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
                            userId == "x19aFGBbXBaXTZY92Al8f8UbWyX2" ? Text("Admin_bywayboracay",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)) :Text(userName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text(userEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Consumer<LoginService>(builder: (context, loginService, child) {
                  if (loginService.isUserLoggedIn()) {
                    return Consumer<SaveService>(
                        //a function called when notifier changes
                        builder: (context, like, child) {
                      return
                          //hide if 0 likes
                          Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background
                            onPrimary: Colors.blue,
                            //foreground
                            //remove border radius
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SavedPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //use userLoggedIn flag to change icon and text
                                Stack(children: [
                                  Icon(Icons.bookmark,
                                      color: Colors.blue[400], size: 25),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Visibility(
                                      visible: like.items.length > 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[50],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          '${like.items.length}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue[400],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),

                                SizedBox(width: 5),
                                Text("Saved Items",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }
                  return SizedBox();
                }),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //background
                      onPrimary: Colors.blue,
                      //foreground
                      //remove border radius
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(CupertinoIcons.question_circle_fill,
                              color: Colors.green[400], size: 25),

                          SizedBox(width: 5),
                          Text("About Us",
                              style: TextStyle(
                                  color: Colors.green[400], fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //background
                      onPrimary: Colors.blue,
                      //foreground
                      //remove border radius
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(Icons.shield_rounded,
                              color: Colors.purple[300], size: 25),

                          SizedBox(width: 5),
                          Text("Privacy Policy",
                              style: TextStyle(
                                  color: Colors.purple[300], fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //background
                      onPrimary: Colors.blue,
                      //foreground
                      //remove border radius
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsConditionPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(CupertinoIcons.doc_text_fill,
                              color: Colors.grey, size: 25),

                          SizedBox(width: 5),
                          Text("Terms & Conditions",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //background
                      onPrimary: Colors.blue,
                      //foreground
                      //remove border radius
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      SystemNavigator.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(Icons.exit_to_app_rounded,
                              color: Colors.red[400], size: 25),

                          SizedBox(width: 5),
                          Text("Exit",
                              style: TextStyle(
                                  color: Colors.red[400], fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                /*Text("Account Options",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
                SizedBox(height: 10),
                userLoggedIn
                    ? GestureDetector(
                        onTap: () async {
                          if (userLoggedIn) {
                            if (userLoggedIn) {
                              await loginService.signOut();
                            }
                          } else {}
                        },
                        child: Text("Switch to Other Account",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            )),
                      )
                    : SizedBox(),*/
              ],
            ),

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
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
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
        ));
  }
}
