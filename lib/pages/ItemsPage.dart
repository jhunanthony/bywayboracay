import 'dart:async';

import 'package:bywayborcay/models/CategoryModel.dart';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
  Completer<GoogleMapController> googlemapcontroller = Completer();

  //initiate map controller
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.962116499999999, 121.92994489999998),
    zoom: 15,
  );

  //double pinBottomInfoPosition = PIN_VISIBLE_POSITION;
  //int itemindex = 0;

  void _showMapWidget(Category selectedCategory) async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.selectedCategory = catSelection.selectedCategory;

    LikeService likedService = Provider.of<LikeService>(context, listen: false);

    BitmapDescriptor destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2),
        'assets/images/' +
            this.widget.selectedCategory.items[0].itemmarkerName +
            '.png');

    showDialog<void>(
        context: context,
        builder: (context) {
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
                      "${this.widget.selectedCategory.items[index].itemsubcategoryName} ${this.widget.selectedCategory.items[index].itemrating1.toStringAsFixed(1)}",
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
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        googlemapcontroller.complete(controller);
                      },
                      markers: Set.from(_markers),
                    ),
                  ),
                  /*AnimatedPositioned(
                      //animate the bottom Info
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      left: 20,
                      bottom: this.pinBottomInfoPosition,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(2),
                              primary: Colors.white, //background
                              onPrimary: Colors.blue, //foreground
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            alignment: Alignment.center,
                            child: Text(
                              "View",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          onPressed: () {
                            
                          }))*/
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.selectedCategory = catSelection.selectedCategory;

    //to activate change notifier on saves
    //SaveService saveService = Provider.of<SaveService>(context, listen: false);

    //access like service

    LikeService likedService = Provider.of<LikeService>(context, listen: false);

    //Iterable markers = [];
    //use iterable to map true items and return markers
    /*Iterable _markers =
        Iterable.generate(this.widget.selectedCategory.items.length, (index) {
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
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(200));
      //
    });*/

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Column(children: [
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.white
                      /*image: DecorationImage(
                      image: NetworkImage(this.selectedCategory.imgName),
                      fit: BoxFit.fill,
                    ),*/
                      ),
                ),
                /*Positioned.fill(
                    child: Container(
                        decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      this.selectedCategory.color.withOpacity(0.5),
                    ],
                  ),
                ))),*/

                Positioned(
                  top: 65,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategoryIcon(
                        iconName: this.widget.selectedCategory.iconName,
                        color: this.widget.selectedCategory.color,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(this.widget.selectedCategory.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ]),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, //background
                  onPrimary: Colors.blue,
                  //foreground
                  shape: CircleBorder(),
                ),
                child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(Icons.map_rounded, size: 25, color: Colors.blue)),
                //capture the success flag with async and await
                onPressed: () => _showMapWidget(widget.selectedCategory),
              ),
              /*Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 150,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        googlemapcontroller.complete(controller);
                      },
                      markers: Set.from(_markers),
                    ),
                  ),
                ),
              ),*/
              // create list builder to show subCategories this.selectedCategory.subCategory.length
              /*child: ListView.builder(
                      padding: EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 80),
                      itemCount: this.selectedCategory.items.length,
                      itemBuilder: (BuildContext ctx, int index) {*/
              Consumer<LoginService>(builder: (context, loginService, child) {
                if (loginService.isUserLoggedIn()) {
                  return Expanded(
                      child: GridView.count(
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
                                //check if added already or not
                                var itemcat =
                                    this.widget.selectedCategory.items[index];
                                catSelection.items = likedService
                                    .getCategoryFromLikedItems(itemcat);
                                Navigator.of(context).pushNamed('/detailspage');
                              },
                              //user physicalmodel to add shadow in a combined widgets
                              child: Column(children: [
                                Container(
                                  height: 250,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(this
                                            .widget
                                            .selectedCategory
                                            .items[index]
                                            .imgName),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
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
                                        borderRadius: BorderRadius.circular(20),
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
                                    /*Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Column(children: [
                                        //wrap this with gesture detector
                                        Icon(
                                          Icons.bookmark,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(height: 3),
                                        //Use Visibility to hide empty
                                        /*Consumer<SaveService>(
                                            //a function called when notifier changes
                                            builder: (context, save, child) {
                                          return Text(
                                            '${save.items.length}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          );
                                        }),*/
                                      ]),
                                    ),*/
                                    //showname
                                    // add sub cat name
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      border: Border.all(
                                                        color: Colors.white,
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
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  this
                                                      .widget
                                                      .selectedCategory
                                                      .items[index]
                                                      .itemrating1
                                                      .toStringAsFixed(1),
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      fontSize: 12,
                                                      color: Colors.yellow[800],
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                                SizedBox(width: 3),
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
                                              ],
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
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Text(
                                                "₱ " +
                                                    this
                                                        .widget
                                                        .selectedCategory
                                                        .items[index]
                                                        .itempriceMin
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
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
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ]),
                            );
                          })));
                }
                return Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Text(' Login first to access items!',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 20,
                            )),
                      ]),
                );
              })
            ]),
            //show Icon
            /*Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: CategoryIcon(
                  iconName: this.selectedCategory.iconName,
                  color: this.selectedCategory.color,
                  size: 30,
                )),*/
            //show app bar
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
