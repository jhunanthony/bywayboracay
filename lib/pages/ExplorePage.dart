import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryCard.dart';
import 'package:bywayborcay/widgets/Navigation/BottomNavBar.dart';
import 'package:bywayborcay/widgets/Navigation/SideMenuBar.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:bywayborcay/widgets/VideoPlayerWidgets/VideoAssetPlayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ItemsPage.dart';
import '../helper/Utils.dart';
import '../models/CategoryModel.dart';

//create scroll controller
ScrollController _controller = new ScrollController();

void _goToElement(int index) {
  _controller.animateTo((350.0 * index),
      duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
}

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int pageindex = 1;

  @override
  Widget build(BuildContext context) {
    //grab the instances from the provider

    return SafeArea(
        child: Scaffold(
          drawer: Drawer(
            elevation: 6,
            child: SideMenuBar()),
            backgroundColor: Colors.white,
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
                  )),
              //show bottom navigation bar
              Positioned(bottom: 0, left: 0, right: 0, child: BottomNavBar())
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

    CategorySelectionService catSelection =Provider.of<CategorySelectionService>(context, listen: false);

    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
        height: 175,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.yellow[50],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        //column
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Explore Now!',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add something in your itinerary.',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
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
                        catSelection.selectedCategory = this.categories[index];
                        Navigator.of(context).pushNamed('/itemspage');
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
      child: Column(children: [
        Text(
          'Read about Boracay',
          style: TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w300),
        ),
        SingleChildScrollView(
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
      ]),
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
        height: MediaQuery.of(context).size.height * 0.35,
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
                      height: 10,
                    ),
                    Container(
                      height: 40,
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
