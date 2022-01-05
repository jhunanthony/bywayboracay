import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/pages/SavePage.dart';
import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/Navigation/AboutUs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    bool showUserInfo = userImg.isNotEmpty && userName.isNotEmpty;

    //bool if a user is currently logged in
    bool userLoggedIn = loginService.loggedInUserModel != null;
    //RatingService ratingService = Provider.of<RatingService>(context, listen: false);

    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.blue[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //show logo
                Column(children: [
                  Container(
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

                  //display user information
                  //user visibility to hide if empty
                ]),
                Column(
                  children: [
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
                                      color: Colors.white, fontSize: 20)),
                              Consumer<RatingService>(
                                  //a function called when notifier changes
                                  builder: (context, rating, child) {
                                return Visibility(
                                  visible: rating.rateditems.length > 0,
                                  child: Text(
                                    'You have ${rating.rateditems.length} reviewed item.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ]),
                      ),
                    ),
                    SizedBox(height: 20),
                    Consumer<LoginService>(
                        builder: (context, loginService, child) {
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //use userLoggedIn flag to change icon and text
                                    Stack(children: [
                                      Icon(Icons.bookmark,
                                          color: Colors.blue, size: 25),
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
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),

                                    SizedBox(width: 5),
                                    Text("Saved Items",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          );
                          /* GestureDetector(
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
                          );*/
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(CupertinoIcons.question_circle_fill,
                                  color: Colors.blue, size: 25),

                              SizedBox(width: 5),
                              Text("About Us",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14)),
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
                          /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LikedPage()));*/
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //use userLoggedIn flag to change icon and text
                              Icon(Icons.shield_rounded,
                                  color: Colors.blue, size: 25),

                              SizedBox(width: 5),
                              Text("Terms & Policies",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 60),

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
