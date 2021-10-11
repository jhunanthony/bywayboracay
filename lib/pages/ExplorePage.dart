import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:bywayborcay/helper/AppIcons.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryCard.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/BottomNavBar.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:bywayborcay/widgets/VideoPlayerWidgets/VideoAssetPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'CategoryPage.dart';
import '../helper/Utils.dart';
import '../models/CategoryModel.dart';

//create scroll controller
ScrollController _controller = new ScrollController();

void _goToElement(int index) {
  _controller.animateTo((350.0 * index),
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn);
}

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int pageindex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      ListView(controller: _controller, children: [
        Header(),
        PromotionalVideo(),
        CategoryButtons(),
        ScrollButtons(),
        ForYouTabs(),
        Highlights(),
        Geography(),
        AwardsAndRecognition(),
        Culture(),
        History(),
        SizedBox(
          height: 100,
        )
      ]),

      //show top navigation bar
      Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: TopNavBar(
            colorbackground: Colors.transparent,
            showTopLogo: false,
          )),
      //show bottom navigation bar
      Positioned(bottom: 10, left: 10, right: 15, child: BottomNavBar())
    ])));
  }
}

class History extends StatelessWidget {
  const History({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_1.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

class Culture extends StatelessWidget {
  const Culture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_4.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

class AwardsAndRecognition extends StatelessWidget {
  const AwardsAndRecognition({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_5.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

class Geography extends StatelessWidget {
  const Geography({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_2.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

class Highlights extends StatelessWidget {
  const Highlights({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_3.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

class ForYouTabs extends StatelessWidget {
  const ForYouTabs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_5.png"),
        fit: BoxFit.cover,
      )),
    );
  }
}

//show category buttons and scroll buttons
// ignore: must_be_immutable
class CategoryButtons extends StatelessWidget {
//create a member variable that will hold reference to the list of category
  List<Category> categories = Utils.getMockedCategory();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        height: 150,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        //column
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Explore Boracay Island!',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: 5),
            //Show Category Buttons here
            //Render as a list using Listview Builder
            //use categories.[index].item to add values
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return CategoryCard(
                      //populate the CategoryCard
                      category: categories[index],
                      onCardClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryPage()));
                      });
                },
              ),
            ),

            //show scroll buttons
          ],
        ));
  }
}

class ScrollButtons extends StatelessWidget {
  const ScrollButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background
                  onPrimary: Colors.white, //foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Container(
                height: 13,
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  'Geography',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () =>
                  _goToElement(3), // on press animate to 6 th element
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background
                  onPrimary: Colors.white, //foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Container(
                height: 13,
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  'Highlights',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () =>
                  _goToElement(4), // on press animate to 6 th element
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background
                  onPrimary: Colors.white, //foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Container(
                height: 13,
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  'Awards',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () =>
                  _goToElement(5), // on press animate to 6 th element
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background
                  onPrimary: Colors.white, //foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Container(
                height: 13,
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  'Culture',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () =>
                  _goToElement(6), // on press animate to 6 th element
            ),
            SizedBox(width: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, //background
                  onPrimary: Colors.white, //foreground
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: Container(
                height: 13,
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  'History',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              onPressed: () =>
                  _goToElement(7), // on press animate to 6 th element
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

//Show Promotional Video
class PromotionalVideo extends StatelessWidget {
  const PromotionalVideo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: VideoAssetPlayer());
  }
}

//header part
class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[50],
        //35%* of screen
        height: MediaQuery.of(context).size.height * 0.34,
        width: MediaQuery.of(context).size.width,
        /*decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            ),                   
                          color: Colors.blue[50],
                          ),*/
        child: Stack(
          children: [
            //align all to center
            Align(
                //represents a point that is horizontally centered with respect to the rectangle and vertically half way between the top edge and the center.
                alignment: Alignment(0.0, -0.5),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/Test_Image_2.png"),
                        fit: BoxFit.cover,
                      )),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text('Brand Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 40,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Brand Slogan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 25,
                            fontWeight: FontWeight.w200)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text('Saylo Kamo Iya!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
