// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:ui';

import 'package:bywayborcay/helper/AppExploreContent.dart';
import 'package:bywayborcay/helper/Utils.dart';
import 'package:bywayborcay/models/ExplorePageModels.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/categoryservice.dart';

import 'package:bywayborcay/widgets/CategoryWidgets/CategoryCard.dart';
import 'package:bywayborcay/widgets/VideoPlayerWidgets/VideoAssetPlayer.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/CategoryModel.dart';
import 'package:expansion_card/expansion_card.dart';

//create scroll controller
ScrollController _controller = new ScrollController();

void _goToElement(int index) {
  _controller.animateTo((300.0 * index),
      duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
}

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int pageindex = 1;

  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        setState(() {
          if (_controller.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //grab the instances from the provider

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        ListView(controller: _controller, children: [
          Header(),
          PromotionalVideo(),
          CategoryButtons(),
          ScrollButtons(),
          ForYouTabs(),
          Geography(),
          Highlights(),
          AwardsAndRecognition(),
          Culture(),
          History(),
          SizedBox(
            height: 100,
          ),
        ]),
        Positioned(
          bottom: 83,
          left: MediaQuery.of(context).size.width * 0.42,
          child: _showBackToTopButton == false
              ? SizedBox()
              : ElevatedButton(
                  onPressed: () => _goToElement(0),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, //background
                    onPrimary: Colors.blue,
                    //foreground
                    shape: CircleBorder(),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 25,
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                  //capture the success flag with async and await
                ),
        )
      ]),

      //show top bar
      /*Positioned(top: 0, left:0,right:0, child: TopNavBar(
                    colorbackground: Colors.transparent,
                  ),),
                Positioned(bottom: 0, left:0,right:0, child: BottomNavBar(
                    
                  ),)*/
      /*floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              
               onPressed: () =>
                    _goToElement(0), 
              
              child: Icon(Icons.arrow_upward),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,*/
    ));
  }
}

class History extends StatelessWidget {
  List<HistoryModel> _historymodel = Utils.getHistory();
  final _historypageController = PageController(viewportFraction: 0.877);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text('History', style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        //wrap with stack to overlay other components
        Container(
            height: 200,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _historypageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  _historymodel.length,
                  (int index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 5,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/${_historymodel[index].imgName}.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      )),
            )),

        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: _historypageController,
            count: _historymodel.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotColor: Colors.grey[400],
                dotHeight: 5,
                dotWidth: 5,
                spacing: 3),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
          child: ExpandableText(
            AppContent.history,
            expandText: 'MORE',
            collapseText: 'LESS',
            maxLines: 4,
            linkColor: Colors.blue,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

class Culture extends StatelessWidget {
  List<CultureModel> _culturemodel = Utils.getculture();
  final _culturepageController = PageController(viewportFraction: 0.8777);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text('Culture', style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        //wrap with stack to overlay other components
        Container(
            height: 330,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _culturepageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  _culturemodel.length,
                  (int index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 5,
                              height: 330,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/${_culturemodel[index].imgName}.jpg'),
                                    fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                        decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.blue.withOpacity(0.1),
                                          Colors.blue.withOpacity(0.2),
                                          Colors.blue.withOpacity(0.5),
                                          Colors.blue.withOpacity(1),
                                          Colors.blue,
                                        ],
                                      ),
                                    )),
                                  ),
                                  Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_culturemodel[index].name}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${_culturemodel[index].caption}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        ),
                      )),
            )),

        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: _culturepageController,
            count: _culturemodel.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotColor: Colors.grey[400],
                dotHeight: 5,
                dotWidth: 5,
                spacing: 3),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
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
      decoration: BoxDecoration(color: Colors.white
          /*image: DecorationImage(
        image: AssetImage("assets/images/Test_Image_5.png"),
        fit: BoxFit.cover,
      )*/
          ),
    );
  }
}

class Geography extends StatelessWidget {
  Completer<GoogleMapController> googlemapcontroller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.962116499999999, 121.92994489999998),
    zoom: 11,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Geography', style: TextStyle(fontSize: 20, color: Colors.blue)),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: Colors.blue),
            Text(' Boracay Island, Malay, Aklan, 5608',
                style: TextStyle(fontSize: 14, color: Colors.blue)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                googlemapcontroller.complete(controller);
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(AppContent.geography,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Colors.blue)),
      ]),
    );
  }
}

class Highlights extends StatelessWidget {
  List<HighlightModel> _highlightmodel = Utils.getHighlight();
  final _highlightpageController = PageController(viewportFraction: 0.877);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text('Highlight',
                style: TextStyle(fontSize: 20, color: Colors.blue)),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        //wrap with stack to overlay other components
        Container(
            height: 200,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _highlightpageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  _highlightmodel.length,
                  (int index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              width: MediaQuery.of(context).size.width - 5,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/${_highlightmodel[index].imgName}.jpg'),
                                    fit: BoxFit.cover),
                              ),
                              child: Stack(
                                children: [
                                  //add gradient
                                  Positioned.fill(
                                    child: Container(
                                        decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: <Color>[
                                          Colors.transparent,
                                          _highlightmodel[index]
                                              .color
                                              .withOpacity(0.5),
                                          _highlightmodel[index].color,
                                        ],
                                      ),
                                    )),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: Colors.white,
                                        child: Text(
                                            ' ' +
                                                _highlightmodel[index].name +
                                                ' ',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      )),
            )),

        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: _highlightpageController,
            count: _highlightmodel.length,
            effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotColor: Colors.grey[400],
                dotHeight: 5,
                dotWidth: 5,
                spacing: 3),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
          child: ExpandableText(
            AppContent.introduction,
            expandText: 'MORE',
            collapseText: 'LESS',
            maxLines: 4,
            linkColor: Colors.blue,
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

class ForYouTabs extends StatelessWidget {
  final _imagepageController = PageController(viewportFraction: 0.877);

  List<ForYouContent> _foryoucontent = Utils.getForyouContents();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Row(children: [
        SizedBox(width: 20),
        Text('For You!', style: TextStyle(fontSize: 20, color: Colors.blue))
      ]),
      SizedBox(
        height: 10,
      ),
      Container(
          height: 200,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: PageView(
            physics: BouncingScrollPhysics(),
            controller: _imagepageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
                _foryoucontent.length,
                (int index) => Container(
                      margin: EdgeInsets.only(right: 20),
                      width: MediaQuery.of(context).size.width - 5,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/${_foryoucontent[index].imgName}.jpg'))),
                      child: Stack(children: <Widget>[
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaY: 19.2, sigmaX: 19.2),
                                          child: Container(
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        _foryoucontent[index]
                                                            .name,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        )),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            _foryoucontent[
                                                                    index]
                                                                .address,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ))
                                                      ],
                                                    ),
                                                  ])))),
                                ]))
                      ]),
                    )),
          )),
      //pageindicator
      SmoothPageIndicator(
        controller: _imagepageController,
        count: _foryoucontent.length,
        effect: ExpandingDotsEffect(
            activeDotColor: Colors.blue,
            dotColor: Colors.grey[400],
            dotHeight: 5,
            dotWidth: 5,
            spacing: 3),
      ),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}

//show category buttons and scroll buttons
// ignore: must_be_immutable
class CategoryButtons extends StatelessWidget {
//create a member variable that will hold reference to the list of category
  //List<Category> categories = Utils.getMockedCategory();
  List<Category> categories = [];
  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);

    CategoryService catService =
        Provider.of<CategoryService>(context, listen: false);
    categories = catService.getCategories();

    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
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
                'Explore Now',
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(children: [
        Text(
          'Read about Boracay',
          style: TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w300),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, //background
                      onPrimary: Colors.blue, //foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Text(
                      'Geography',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () =>
                      _goToElement(3), // on press animate to 6 th element
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, //background
                      onPrimary: Colors.blue, //foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Text(
                      'Highlights',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () =>
                      _goToElement(4), // on press animate to 6 th element
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, //background
                      onPrimary: Colors.blue, //foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Text(
                      'Awards',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () =>
                      _goToElement(5), // on press animate to 6 th element
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, //background
                      onPrimary: Colors.blue, //foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Text(
                      'Culture',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () =>
                      _goToElement(6), // on press animate to 6 th element
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(2),
                      primary: Colors.white, //background
                      onPrimary: Colors.white, //foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Text(
                      'History',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue,
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
        //color: Colors.blue[50],
        //35%* of screen
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/Explore_Beach.jpg',
          ),
          fit: BoxFit.fitHeight,
        )),
        child: Stack(
          children: [
            //align all to center
            Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                  Colors.blue.withOpacity(0.5),
                ],
              ),
            ))),

            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text('Byway Boracay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Venture with Precision',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(4, 0), // Shadow position
                          ),
                        ],
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
