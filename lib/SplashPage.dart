import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: must_be_immutable
class SplashPage extends StatelessWidget {
  int duration = 0;
  Widget goToPage ;

  SplashPage({this.goToPage, this.duration});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.goToPage));
    });

    return SafeArea(child:Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //use ClipRRect for circular border
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/Test_Image_1.png"),
                          fit: BoxFit.cover,
                        )))),
                //use SizedBox for spacing
                SizedBox(height: 10),
                Text('Brand Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 40,
                    )),
              ],
            ),
          
        )));
  }
}
