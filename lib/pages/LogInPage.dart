import 'package:bywayborcay/services/loginservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OnBoardingPage.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //fetch login service via provider
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      //wraph with expanded to avoid axis error
      body: Column(
        children: [
          //use Flexible and FractionallySizedBox for resposiveness
          Container(
              color: Colors.blue[50],
              //60%* of screen
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              /*decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/Test_Image_1.png"),
                            fit: BoxFit.cover,
                          )
                          ),*/
              child: Stack(
                children: [
                  //align all to center
                  Align(
                      //represents a point that is horizontally centered with respect to the rectangle and vertically half way between the top edge and the center.
                      alignment: Alignment(0.0, -0.3),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/Test_Image_2.png"),
                              fit: BoxFit.cover,
                            )),
                      )),
                  //use this as spacer
                  Align(
                    alignment: Alignment(0.0, 0.6),
                    child: Text('Brand Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 40,
                            fontWeight: FontWeight.w400)),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.8),
                    child: Text('Brand Slogan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.w200)),
                  ),
                ],
              )),

          Column(
            children: [
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue, //background
                    onPrimary: Colors.white, //foreground
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Continue as Guess',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/onboardingpage');
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background
                    onPrimary: Colors.blue,
                    //foreground
                    shape: CircleBorder(),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )),
                    child: Icon(
                      Icons.android,
                      size: 25,
                      color: Colors.blue,
                    ),
                  ),
                  //capture the success flag with async and await
                  onPressed: () async {
                    bool success = await loginService.signInWithGoogle();

                    if (success) {
                       Navigator.of(context).pushReplacementNamed('/explorepage');
                    }
                  }),
              SizedBox(height: 25),
              Text(
                '- Login with Google - ',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w200),
              ),
            ],
          )

          //continue button
        ],
      ),
    ));
  }
}
