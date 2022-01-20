import 'dart:async';

import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/adminservice.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:filter_list/filter_list.dart';

import '../models/RatedItemsModel.dart';
import '../models/UserLogInModel.dart';
import '../services/ratedservice.dart';

const double PIN_NOTVISIBLE_POSITION = -50;
const double PIN_VISIBLE_POSITION = 53;
//create category page

class ItemsPage extends StatefulWidget {
  //create instance variables
  Category selectedCategory;

  ItemsPage({
    this.selectedCategory,
  });

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  bool filteron = false;

  Completer<GoogleMapController> googlemapcontroller = Completer();

  //initiate map controller
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.962116499999999, 121.92994489999998),
    zoom: 15,
  );

  //double pinBottomInfoPosition = PIN_VISIBLE_POSITION;
  //int itemindex = 0;

  //place holder of filtered items
  List<Items> selectedCountList = [];

  //map dialog
  void _showMapWidget(Category selectedCategory) async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.selectedCategory = catSelection.selectedCategory;

    SaveService likedService = Provider.of<SaveService>(context, listen: false);

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2),
        'assets/images/${this.widget.selectedCategory.items[0].itemcategoryName}.png');

    showDialog<void>(
        context: context,
        builder: (context) {
          //Iterable markers = [];
          //use iterable to map true items and return markers
          Iterable _markers = Iterable.generate(
              this.widget.selectedCategory.items.length, (index) {
            return Marker(
              markerId: MarkerId(
                this.widget.selectedCategory.items[index].name,
              ),
              position: LatLng(
                this.widget.selectedCategory.items[index].itemlat,
                this.widget.selectedCategory.items[index].itemlong,
              ),
              infoWindow: InfoWindow(
                  title: this.widget.selectedCategory.items[index].name,
                  snippet:
                      "${this.widget.selectedCategory.items[index].itemsubcategoryName} • ${this.widget.selectedCategory.items[index].itemopenTime}",
                  onTap: () {
                    var itemcat = this.widget.selectedCategory.items[index];
                    catSelection.items =
                        likedService.getCategoryFromLikedItems(itemcat);
                    Navigator.of(context).pushNamed('/detailspage');
                  }),
              icon: destinationIcon,
              //icon: BitmapDescriptor.defaultMarkerWithHue(200)
            );
            //
          });

          return AlertDialog(
              title: Column(
                children: [
                  Text("Map Search"),
                  Text("Tap on item name", style: TextStyle(fontSize: 10)),
                ],
              ),
              contentPadding:
                  EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
              content: Stack(
                children: [
                  Positioned.fill(
                    child: GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          this.widget.selectedCategory.items[0].itemlat,
                          this.widget.selectedCategory.items[0].itemlong,
                        ),
                        zoom: 18,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        googlemapcontroller.complete(controller);
                      },
                      markers: Set.from(_markers),
                    ),
                  ),
                ],
              ));
        });
  }

  List<String> tags = [];
  List<String> options = [
    '1',
    '2',
    '3',
    'Balabag',
    'Manocmanoc',
    'Yapak',
    'MainLand',
  ];
  List<String> tags2 = [];
  List<String> subcategoryoptions = [];

  void _openFilterDialog(Category selectedCategory) async {
    await FilterListDialog.display<Items>(
      context,
      listData: this.widget.selectedCategory.items,
      selectedListData: selectedCountList,
      height: 480,
      headlineText: "Group Search",
      searchFieldHintText: "Search Here",
      choiceChipLabel: (items) {
        return items.name;
      },
      validateSelectedItem: (list, val) {
        return list.contains(val);
      },
      onItemSearch: (list, text) {
        if (list.any(
            (items) => items.name.toLowerCase().contains(text.toLowerCase()))) {
          return list
              .where((items) =>
                  items.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
        } else {
          return [];
        }
      },
      onApplyButtonClick: (list) {
        if (list != null) {
          setState(() {
            selectedCountList = List.from(list);
          });
        }
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    RatingService ratingService =
        Provider.of<RatingService>(context, listen: false);
    //fetch liked items and load on likepage
//ratingService.loadRatedItemsFromFirebase(context);
    SaveService likedService = Provider.of<SaveService>(context, listen: false);

    //fetch liked items and load on likepage
    //likedService.loadLikedItemsFromFirebase(context);
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.selectedCategory = catSelection.selectedCategory;

    //to activate change notifier on saves
    //SaveService saveService = Provider.of<SaveService>(context, listen: false);

    //access like service

    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);

    UserLogInModel userModel = loginService.loggedInUserModel;

    String useruid = userModel != null ? userModel.uid : '';

    bool userLoggedIn = loginService.loggedInUserModel != null;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          body: Stack(children: [
            Column(children: [
              SizedBox(
                height: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryIcon(
                    iconName: this.widget.selectedCategory.name,
                    color: this.widget.selectedCategory.color,
                    size: 35,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(this.widget.selectedCategory.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      this.widget.selectedCategory.items[0].itemcategoryName ==
                              "ToStay"
                          ? "Find a place to Check In and Breathe out!"
                          : this
                                      .widget
                                      .selectedCategory
                                      .items[0]
                                      .itemcategoryName ==
                                  "ToEat&Drink"
                              ? "Find a place to Eat Good & Feel Good!"
                              : this
                                          .widget
                                          .selectedCategory
                                          .items[0]
                                          .itemcategoryName ==
                                      "ToDo"
                                  ? "Experience Exciting and Exhilarating activities to do!"
                                  : this
                                              .widget
                                              .selectedCategory
                                              .items[0]
                                              .itemcategoryName ==
                                          "ToSee"
                                      ? "Wander and Discover places new to your eyes!"
                                      : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ],
              ),

              Consumer<LoginService>(builder: (context, loginService, child) {
                if (loginService.isUserLoggedIn()) {
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, //background
                                onPrimary: Colors.blue,
                                //foreground
                              ),
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search_rounded,
                                          size: 25, color: Colors.blue),
                                      Text(
                                          this
                                                      .widget
                                                      .selectedCategory
                                                      .items[0]
                                                      .itemcategoryName ==
                                                  "ToStay"
                                              ? "Book a place to stay!"
                                              : this
                                                          .widget
                                                          .selectedCategory
                                                          .items[0]
                                                          .itemcategoryName ==
                                                      "ToEat&Drink"
                                                  ? "Craving for good food?"
                                                  : this
                                                              .widget
                                                              .selectedCategory
                                                              .items[0]
                                                              .itemcategoryName ==
                                                          "ToDo"
                                                      ? "Looking for fun?"
                                                      : this
                                                                  .widget
                                                                  .selectedCategory
                                                                  .items[0]
                                                                  .itemcategoryName ==
                                                              "ToSee"
                                                          ? "Wanting new sceneries?"
                                                          : "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  )),
                              //capture the success flag with async and await
                              onPressed: () =>
                                  _openFilterDialog(widget.selectedCategory),
                            ),
                            //fitler button
                            filteron == false
                                ? InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    highlightColor: Colors.red,
                                    onTap: () {
                                      setState(() {
                                        filteron = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3,
                                                offset: Offset(2, 2)),
                                          ],
                                          color: Colors.red[300],
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        'assets/icons/funnel.svg',
                                        color: Colors.white,
                                        height: 23,
                                        width: 23,
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    highlightColor: Colors.red,
                                    onTap: () {
                                      setState(() {
                                        filteron = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3,
                                                offset: Offset(2, 2)),
                                          ],
                                          color: Colors.red[600],
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        'assets/icons/funnel.svg',
                                        color: Colors.blue[50],
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                            //map button

                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              highlightColor: Colors.green,
                              onTap: () =>
                                  _showMapWidget(widget.selectedCategory),
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                          offset: Offset(2, 2)),
                                    ],
                                    color: Colors.green[300],
                                    shape: BoxShape.circle),
                                child: Icon(Icons.map_rounded,
                                    size: 22, color: Colors.white),
                              ),
                            ),
                            /* value
                                ..sort((item1, item2) => DateFormat("h:mm a")
                                    .parse(item1.timer)
                                    .compareTo(DateFormat("h:mm a")
                                        .parse(item2.timer)));*/
                          ],
                        ),
                      ),

                      filteron == true
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: 30),
                                  Text(
                                    "Station",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ChipsChoice<String>.multiple(
                                    choiceStyle: C2ChoiceStyle(
                                        color: Colors.blue,
                                        margin: EdgeInsets.only(left: 5)),
                                    value: tags,
                                    onChanged: (val) => setState(() {
                                      tags = val;

                                      Query _query = Query(station: val);
                                      List<Items> filter(
                                          List<Items> items, Query query) {
                                        return items
                                            .where((items) =>
                                                (query.station == null ||
                                                    query.station.contains(
                                                        items.itemstation)))
                                            .toList();
                                      }

                                      List<Items> results = filter(
                                          this.widget.selectedCategory.items,
                                          _query);
                                      if (results != null) {
                                        selectedCountList = List.from(results);
                                      }
                                    }),
                                    choiceItems:
                                        C2Choice.listFrom<String, String>(
                                      source: options,
                                      value: (i, v) => v,
                                      label: (i, v) => v,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      //subcategory filter
                      filteron == true
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: 30),
                                  Text(
                                    "Subcategory",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ChipsChoice<String>.multiple(
                                    choiceStyle: C2ChoiceStyle(
                                        color: Colors.blue,
                                        margin: EdgeInsets.only(left: 5)),
                                    value: tags2,
                                    onChanged: (val) => setState(() {
                                      tags2 = val;

                                      Query _query = Query(subcategory: val);
                                      List<Items> filter(
                                          List<Items> items, Query query) {
                                        return items
                                            .where((items) => (query
                                                        .subcategory ==
                                                    null ||
                                                query.subcategory.contains(
                                                    items.itemsubcategoryName)))
                                            .toList();
                                      }

                                      List<Items> results = filter(
                                          this.widget.selectedCategory.items,
                                          _query);
                                      if (results != null) {
                                        selectedCountList = List.from(results);
                                      }
                                    }),
                                    choiceItems:
                                        C2Choice.listFrom<String, String>(
                                      source: this
                                                  .widget
                                                  .selectedCategory
                                                  .items[0]
                                                  .itemcategoryName ==
                                              "ToStay"
                                          ? subcategoryoptions = [
                                              'Hotel',
                                              'Inn',
                                              'Villas',
                                              'Resort',
                                            ]
                                          : this
                                                      .widget
                                                      .selectedCategory
                                                      .items[0]
                                                      .itemcategoryName ==
                                                  "ToEat&Drink"
                                              ? subcategoryoptions = [
                                                  'Restaurant',
                                                  'Fast Food',
                                                  'Cafe',
                                                  'Bar',
                                                  'Cuisine',
                                                ]
                                              : this
                                                          .widget
                                                          .selectedCategory
                                                          .items[0]
                                                          .itemcategoryName ==
                                                      "ToDo"
                                                  ? subcategoryoptions = [
                                                      'WaterActivities',
                                                      'LandActivities',
                                                      'LocalServices',
                                                      'Environmental',
                                                      'Social',
                                                    ]
                                                  : this
                                                              .widget
                                                              .selectedCategory
                                                              .items[0]
                                                              .itemcategoryName ==
                                                          "ToSee"
                                                      ? subcategoryoptions = [
                                                          'BeachSites',
                                                          'WetLands',
                                                          'LandMarks',
                                                          'Museums',
                                                        ]
                                                      : subcategoryoptions = [],
                                      value: (i, v) => v,
                                      label: (i, v) => v,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                }
                return SizedBox();
              }),
              /*this.widget.selectedCategory.items[0].itemcategoryName == "ToStay"
                  ? Text("Listed are DOT-accredited accomodations.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ))
                  : SizedBox(),*/

              // create list builder to show subCategories this.selectedCategory.subCategory.length
              //show list here

              Consumer<LoginService>(builder: (context, loginService, child) {
                if (loginService.isUserLoggedIn()) {
                  this.widget.selectedCategory.items
                    ..sort((item1, item2) =>
                        item1.itempriceMin.compareTo(item2.itempriceMin));
                  selectedCountList
                    ..sort((item1, item2) =>
                        item1.itempriceMin.compareTo(item2.itempriceMin));

                  return Expanded(
                      child: selectedCountList == null ||
                              selectedCountList.length == 0
                          ? GridView.count(
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20, bottom: 80),
                              shrinkWrap: true,
                              childAspectRatio: 0.6,
                              crossAxisCount: 2,
                              children: List.generate(
                                  this.widget.selectedCategory.items.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    /*if (useruid ==
                                        "x19aFGBbXBaXTZY92Al8f8UbWyX2") {
                                      ratingService.addrecord(
                                        context,
                                        RatedItems(
                                            category: this
                                                .widget
                                                .selectedCategory
                                                .items[index]),
                                      );
                                    }*/
                                       ratingService.addrecord(context,
                                        RatedItems(
                                            category: this
                                                .widget
                                                .selectedCategory
                                                .items[index]),
                                      );

                                    if (this
                                            .widget
                                            .selectedCategory
                                            .items[index]
                                            .itemcategoryName ==
                                        "ToStay") {
                                      FirebaseFirestore.instance
                                          .collection('status')
                                          .doc(
                                              '${this.widget.selectedCategory.items[index].itemcategoryName}')
                                          .update({
                                        "${this.widget.selectedCategory.items[index].name}.itemstatus":
                                            FieldValue.increment(0)
                                      });
                                    }
                                    //check if added already or not
                                    var itemcat = this
                                        .widget
                                        .selectedCategory
                                        .items[index];
                                    catSelection.items = likedService
                                        .getCategoryFromLikedItems(itemcat);
                                    catSelection.items = ratingService
                                        .getCategoryFromRatedItems(itemcat);
                                    Navigator.of(context)
                                        .pushNamed('/detailspage');
                                  },
                                  //user physicalmodel to add shadow in a combined widgets
                                  child: Column(children: [
                                    Container(
                                      height: 250,
                                      width: 150,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3,
                                                offset: Offset(2, 2)),
                                          ]),
                                      child: Container(
                                        height: 240,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(this
                                                  .widget
                                                  .selectedCategory
                                                  .items[index]
                                                  .imgName),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 3,
                                                  offset: Offset(2, 2)),
                                            ]),
                                        //stack all descriptions values etc. here
                                        child: Stack(children: [
                                          Positioned.fill(
                                            child: Container(
                                                decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: <Color>[
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.3),
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.black,
                                                ],
                                              ),
                                            )),
                                          ),
                                          //add likes and number of likes

                                          //showname
                                          // add sub cat name
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //wrap to expand if too long

                                                  Text(
                                                    this
                                                        .widget
                                                        .selectedCategory
                                                        .items[index]
                                                        .name,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),

                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .blue[400],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1,
                                                                )),
                                                        child: Text(
                                                          this
                                                              .widget
                                                              .selectedCategory
                                                              .items[index]
                                                              .itemsubcategoryName,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "  • ",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'ratings')
                                                              .doc(
                                                                  '${this.widget.selectedCategory.items[index].itemcategoryName}')
                                                              .snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                      DocumentSnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              var userDocument =
                                                                  snapshot.data;

                                                              double
                                                                  itemrating =
                                                                  double.parse(
                                                                      userDocument[
                                                                              "${this.widget.selectedCategory.items[index].name}.itemrating"]
                                                                          .toString());

                                                              double
                                                                  itemratingnum =
                                                                  double.parse(
                                                                      userDocument[
                                                                              "${this.widget.selectedCategory.items[index].name}.itemratingnum"]
                                                                          .toString());
                                                              double rating =
                                                                  itemrating /
                                                                      itemratingnum;

                                                              return rating > 0
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                          " ${rating.toStringAsFixed(1)} ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.green[400],
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        RatingBarIndicator(
                                                                          rating:
                                                                              rating / 5,
                                                                          itemBuilder: (context, index) =>
                                                                              Icon(
                                                                            Icons.eco_rounded,
                                                                            color:
                                                                                Colors.green[400],
                                                                          ),
                                                                          itemCount:
                                                                              1,
                                                                          itemSize:
                                                                              18,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          unratedColor:
                                                                              Colors.grey[400],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : rating ==
                                                                          null
                                                                      ? Icon(
                                                                          Icons
                                                                              .eco_rounded,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .eco_rounded,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.grey,
                                                                        );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return SizedBox();
                                                            } else
                                                              return SizedBox();
                                                          })
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Text(
                                                    this
                                                        .widget
                                                        .selectedCategory
                                                        .items[index]
                                                        .itemaddress,
                                                    style: TextStyle(
                                                        overflow:
                                                            TextOverflow.fade,
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ]),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Visibility(
                                                  visible: this
                                                              .widget
                                                              .selectedCategory
                                                              .items[index]
                                                              .itempriceMin !=
                                                          0 ||
                                                      this
                                                              .widget
                                                              .selectedCategory
                                                              .items[index]
                                                              .itempriceMin !=
                                                          0.00,
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Text(
                                                      "from ₱ " +
                                                          this
                                                              .widget
                                                              .selectedCategory
                                                              .items[index]
                                                              .itempriceMin
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Open " +
                                                      this
                                                          .widget
                                                          .selectedCategory
                                                          .items[index]
                                                          .itemopenTime,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ]),
                                );
                              }))
                          :
                          //if selectedCountList is not null
                          GridView.count(
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20, bottom: 80),
                              shrinkWrap: true,
                              childAspectRatio: 0.6,
                              crossAxisCount: 2,
                              children: List.generate(selectedCountList.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    /*if (useruid ==
                                        "x19aFGBbXBaXTZY92Al8f8UbWyX2") {
                                      ratingService.addrecord(
                                        context,
                                        RatedItems(
                                            category: selectedCountList[index]),
                                      );
                                    }*/

                                     ratingService.addrecord(
                                        context,
                                        RatedItems(
                                            category: selectedCountList[index]),
                                      );

                                    if (selectedCountList[index]
                                            .itemcategoryName ==
                                        "ToStay") {
                                      FirebaseFirestore.instance
                                          .collection('status')
                                          .doc(
                                              '${selectedCountList[index].itemcategoryName}')
                                          .update({
                                        "${selectedCountList[index].name}.itemstatus":
                                            FieldValue.increment(0)
                                      });
                                    }
                                    //check if added already or not
                                    var itemcat = selectedCountList[index];
                                    catSelection.items = likedService
                                        .getCategoryFromLikedItems(itemcat);
                                    catSelection.items = ratingService
                                        .getCategoryFromRatedItems(itemcat);
                                    Navigator.of(context)
                                        .pushNamed('/detailspage');
                                  },
                                  //user physicalmodel to add shadow in a combined widgets
                                  child: Column(children: [
                                    Container(
                                      height: 250,
                                      width: 150,
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 3,
                                                offset: Offset(2, 2)),
                                          ]),
                                      child: Container(
                                        height: 240,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  selectedCountList[index]
                                                      .imgName),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 3,
                                                  offset: Offset(2, 2)),
                                            ]),
                                        //stack all descriptions values etc. here
                                        child: Stack(children: [
                                          Positioned.fill(
                                            child: Container(
                                                decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: <Color>[
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.3),
                                                  Colors.black.withOpacity(0.5),
                                                  Colors.black,
                                                ],
                                              ),
                                            )),
                                          ),
                                          //add likes and number of likes

                                          //showname
                                          // add sub cat name
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            right: 10,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //wrap to expand if too long

                                                  Text(
                                                    selectedCountList[index]
                                                        .name,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),

                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .blue[400],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1,
                                                                )),
                                                        child: Text(
                                                          selectedCountList[
                                                                  index]
                                                              .itemsubcategoryName,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "  • ",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'ratings')
                                                              .doc(
                                                                  '${selectedCountList[index].itemcategoryName}')
                                                              .snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                      DocumentSnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              var userDocument =
                                                                  snapshot.data;

                                                              double
                                                                  itemrating =
                                                                  double.parse(
                                                                      userDocument[
                                                                              "${selectedCountList[index].name}.itemrating"]
                                                                          .toString());

                                                              double
                                                                  itemratingnum =
                                                                  double.parse(
                                                                      userDocument[
                                                                              "${selectedCountList[index].name}.itemratingnum"]
                                                                          .toString());
                                                              double rating =
                                                                  itemrating /
                                                                      itemratingnum;

                                                              return rating > 0
                                                                  ? Row(
                                                                      children: [
                                                                        Text(
                                                                          " ${rating.toStringAsFixed(1)} ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.green[400],
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        RatingBarIndicator(
                                                                          rating:
                                                                              rating / 5,
                                                                          itemBuilder: (context, index) =>
                                                                              Icon(
                                                                            Icons.eco_rounded,
                                                                            color:
                                                                                Colors.green[400],
                                                                          ),
                                                                          itemCount:
                                                                              1,
                                                                          itemSize:
                                                                              18,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          unratedColor:
                                                                              Colors.grey[400],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : rating ==
                                                                          null
                                                                      ? Icon(
                                                                          Icons
                                                                              .eco_rounded,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .eco_rounded,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Colors.grey,
                                                                        );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Text(
                                                                '',
                                                              );
                                                            } else
                                                              return Text(
                                                                '',
                                                              );
                                                          })
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),

                                                  Text(
                                                    selectedCountList[index]
                                                        .itemaddress,
                                                    style: TextStyle(
                                                        overflow:
                                                            TextOverflow.fade,
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ]),
                                          ),
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Visibility(
                                                  visible: selectedCountList[
                                                                  index]
                                                              .itempriceMin !=
                                                          0 ||
                                                      selectedCountList[index]
                                                              .itempriceMin !=
                                                          0.00,
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Text(
                                                      "from ₱ " +
                                                          selectedCountList[
                                                                  index]
                                                              .itempriceMin
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Open " +
                                                      selectedCountList[index]
                                                          .itemopenTime,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ]),
                                );
                              })));
                }
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background
                            onPrimary: Colors.blue,
                            padding: EdgeInsets.all(0),
                            //foreground
                            //remove border radius
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (userLoggedIn) {
                              await loginService.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/loginpage',
                                  (Route<dynamic> route) => false);
                            } else {
                              bool success =
                                  await loginService.signInWithGoogle();
                              if (success) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/mainpage');
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //use userLoggedIn flag to change icon and text
                                Icon(userLoggedIn ? Icons.logout : Icons.login,
                                    color: Colors.blue, size: 20),
                                SizedBox(width: 5),
                                Text(userLoggedIn ? 'Sign Out' : 'Sign In',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(' Login first to access items!',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20,
                          )),
                    ],
                  ),
                );
              }),
            ]),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopNavBar(
                colorbackground: Colors.transparent,
              ),
            ),
          ])),
    );
  }
}

class Query {
  final List<String> station;
  final List<String> subcategory;
  //final List<String> weight;

  Query({this.station, this.subcategory});
}
