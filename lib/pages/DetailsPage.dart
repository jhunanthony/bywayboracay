import 'dart:async';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/SavedItemModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/savecategory.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/services/ratedservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:bywayborcay/widgets/CalendarWidget/datepicker.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/RatedItemsModel.dart';

const double CAMERA_ZOOM_DETAILSPAGE = 16;
const double CAMERA_TILT_DETAILSPAGE = 0;
const double CAMERA_BEARING_DETAILSPAGE = 30;

class DetailsPage extends StatefulWidget {
  //pass the values
  Items items;

  DetailsPage({this.items});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  LatLng destinationLocation;

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    String parentCategory = widget.items.itemcategoryName;

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/$parentCategory.png');
  }

  PageController _pagecontroller;

  @override
  void initState() {
    super.initState();
    _pagecontroller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pagecontroller.dispose();
  }

  //indicator if button is liked or not

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    //pull marker icon
    this.setSourceAndDestinationMarkerIcons(context);
    //initialize needed values for map

    LatLng destinationlatlong =
        LatLng(widget.items.itemlat, widget.items.itemlong);
    destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM_DETAILSPAGE,
        tilt: CAMERA_TILT_DETAILSPAGE,
        bearing: CAMERA_BEARING_DETAILSPAGE,
        target: destinationLocation);

    //to activate change notifier on saves
    SaveService likeService = Provider.of<SaveService>(context, listen: false);
    RatingService ratingService =
        Provider.of<RatingService>(context, listen: false);
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    UserLogInModel userModel = loginService.loggedInUserModel;

    String uid = userModel != null ? userModel.uid : '';

    //canvas starts here

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //show header
              //wrap with stack to add components above images
              Stack(children: [
                Container(
                    height: 520,
                    width: MediaQuery.of(context).size.width,

                    //wrap with stack to overlay other components
                    child: PageView(
                        controller: _pagecontroller,
                        children: List.generate(
                            widget.items.detailsimages.length,
                            (index) => Container(
                                height: 470,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget
                                        .items.detailsimages[index].imgName),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    //add gradient
                                    Positioned.fill(
                                      child: Container(
                                          decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.center,
                                          end: Alignment.centerRight,
                                          colors: <Color>[
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.5),
                                          ],
                                        ),
                                      )),
                                    ),
                                  ],
                                ))))),

                //add save button

                Positioned(
                    top: 70,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        CategoryIcon(
                          iconName: widget.items.itemcategoryName,
                          color: Colors.transparent,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<LoginService>(
                            builder: (context, loginService, child) {
                          if (loginService.isUserLoggedIn()) {
                            return Consumer<SaveService>(
                                builder: (context, like, child) {
                              //check if saved
                              Widget renderedButton;

                              //check is it is saved then display regular button

                              if (!like.isSaved(widget.items)) {
                                renderedButton = ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.bookmark_add_rounded),
                                      color: Colors.white,
                                      iconSize: 25,
                                      splashColor: Colors.pink[300],
                                      onPressed: () {
                                        likeService.add(context,
                                            SavedItem(category: widget.items));
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                renderedButton = ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon:
                                            Icon(Icons.bookmark_added_rounded),
                                        color: Colors.blue[200],
                                        iconSize: 25,
                                        splashColor: Colors.white,
                                        onPressed: () {
                                          /*likeService.remove(
                                              context,
                                              LikedItem(
                                                  category: widget.items));*/
                                        }),
                                  ),
                                );
                              }

                              return renderedButton;
                            });
                          }
                          return SizedBox();
                        }),
                        SizedBox(
                          height: 3,
                        ),
                        Consumer<LoginService>(
                            builder: (context, loginService, child) {
                          if (loginService.isUserLoggedIn()) {
                            return Consumer<SaveService>(
                                builder: (context, like, child) {
                              //check if saved
                              Widget likedtext;

                              //check is it is saved then display regular button

                              if (!like.isSaved(widget.items)) {
                                likedtext = Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                likedtext = Text(
                                  'Saved',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                );
                              }

                              return likedtext;
                            });
                          }
                          return SizedBox();
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.share_rounded),
                          color: Colors.white,
                          iconSize: 25,
                          splashColor: Colors.blue[300],
                          onPressed: () {
                            _showShare(context);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 50,
                          height: 100,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('ratings')
                                  .doc('${widget.items.itemcategoryName}')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  var userDocument = snapshot.data;
                                  var path =
                                      userDocument["${widget.items.name}.sets"];
                                  return path.length > 0
                                      ? Column(
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: path.length > 3
                                                      ? 3
                                                      : path.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var username = path[index];

                                                    return Align(
                                                      heightFactor: 0.6,
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.8),
                                                        child: CircleAvatar(
                                                          radius: 18,

                                                          backgroundImage:
                                                              NetworkImage(
                                                            "${username["userimg"].toString()}",
                                                          ), // Provide your custom image
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Text(
                                              '${path.length.toString()} reviews',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                      : path.length == null
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'No reviews',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'No reviews',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'No Reviews',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  );
                                } else
                                  return Text(
                                    'Loading',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  );
                              }),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SmoothPageIndicator(
                            controller: _pagecontroller,
                            count: widget.items.detailsimages.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: widget.items.color,
                                dotColor: Colors.white,
                                dotHeight: 5,
                                dotWidth: 5,
                                spacing: 3),
                          ),
                        ),
                      ]),
                    )),

                //title and calendar button

                Positioned(
                  bottom: -2,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                      /* boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 5,
                                      offset: Offset(4, 0), // Shadow position
                                    ),
                                  ],*/
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 70,
                            bottom: 20,
                          ),
                          //use wrap horizontal to auto expand text
                          child: Text(
                            widget.items.name,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 5,
                          child: Consumer<LoginService>(
                              builder: (context, loginService, child) {
                            if (loginService.isUserLoggedIn()) {
                              return ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(CupertinoIcons.calendar),
                                      color: Colors.blue[200],
                                      iconSize: 25,
                                      splashColor: Colors.blue,
                                      onPressed: () async {
                                        _showAction(context);
                                      }),
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                        )
                      ],
                    ),
                  ),
                )
              ]),
              //show ratings here
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('ratings')
                          .doc('${widget.items.itemcategoryName}')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var userDocument = snapshot.data;

                          double itemrating = double.parse(
                              userDocument["${widget.items.name}.itemrating"]
                                  .toString());
                          double itemratingnum = double.parse(
                              userDocument["${widget.items.name}.itemratingnum"]
                                  .toString());
                          double rating = itemrating / itemratingnum;

                          return rating > 0
                              ? Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.eco_rounded,
                                        color: Colors.green[400],
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      direction: Axis.horizontal,
                                      unratedColor: Colors.grey[400],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${rating.toStringAsFixed(1)} • ${userDocument["${widget.items.name}.itemratingnum"].toString()}",
                                      style: TextStyle(
                                        color: Colors.green[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              : rating == null
                                  ? Text(
                                      'Unrated',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      'Unrated',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Unrated',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          );
                        } else
                          return Text(
                            'Loading',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          );
                      })
                ]),
              ),

              //show ratings1 here
              Padding(
                  padding:
                      EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: Colors.blue,
                                width: 1,
                              )),
                          child: Text(
                            widget.items.itemsubcategoryName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ])),

              //Use EXapnding text widget
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.items.itemopenTime,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: widget.items.itempriceMin != 0 ||
                            widget.items.itempriceMin != 0.00 ||
                            widget.items.itempriceMin != null,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            'from. ₱' +
                                widget.items.itempriceMin.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: ExpandableText(
                  "       " + widget.items.itemdescription,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 4,
                  linkColor: Colors.blue,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ),

              //show location here
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20, bottom: 10, right: 20, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.items.itemaddress,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //show map here
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        compassEnabled: false,
                        zoomControlsEnabled: true,
                        tiltGesturesEnabled: false,

                        mapToolbarEnabled: false,
                        myLocationButtonEnabled: false,

                        markers: _markers,
                        mapType: MapType.normal,
                        initialCameraPosition: initialCameraPosition,

                        //tapping will hide the bottom info //grab custom pins //grab the polylines
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);

                          showPinsOnMap();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              //show get direction button here
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(3),
                            primary: Colors.blue, //background
                            onPrimary: Colors.blue, //foreground
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(
                                Icons.directions,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                ' Directions',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/mappage');
                        }, // on press animate to 6 th element
                      ),
                    ],
                  ),
                ),
              ),

              //add contact information
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 5,
                    right: 20,
                  ),
                  child: Text(
                    'Direct Booking',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),

              //add contacts

              Padding(
                padding: EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //column for text call and fb
                    Visibility(
                      visible: widget.items.itemcontactNumber != "none" ||
                          widget.items.itemcontactNumber != "None" ||
                          widget.items.itemcontactNumber != null,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue, //background
                            onPrimary: Colors.white, //foreground
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, left: 5, right: 5),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(Icons.call_rounded,
                                  color: Colors.white, size: 14),
                              Text(
                                ' Call',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          String sms = "tel:" + widget.items.itemcontactNumber;
                          if (await canLaunch(sms)) {
                            await launch(sms);
                          } else {
                            throw 'Could not launch $sms';
                          }
                        }, // on press animate to 6 th element
                      ),
                    ),

                    //column for email and website

                    Row(
                      children: [
                        Visibility(
                          visible: widget.items.itememail != "none" ||
                              widget.items.itememail != "None" ||
                              widget.items.itememail != null,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, //background
                                onPrimary: Colors.blue,
                                //foreground
                                shape: CircleBorder(),
                              ),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 3, bottom: 3, left: 5, right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.email_rounded,
                                      size: 20, color: Colors.blue)),
                              //capture the success flag with async and await
                              onPressed: () async {
                                String mailto = "mailto:" +
                                    widget.items.itememail +
                                    "?subject=Inquiry&body=Greetings!";
                                if (await canLaunch(mailto)) {
                                  await launch(mailto);
                                } else {
                                  throw 'Could not launch $mailto';
                                }
                              }),
                        ),
                        Visibility(
                          visible: widget.items.itemwebsite != "none" ||
                              widget.items.itemwebsite != "None" ||
                              widget.items.itemwebsite != null,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, //background
                                onPrimary: Colors.blue,
                                //foreground
                                shape: CircleBorder(),
                              ),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 3, bottom: 3, left: 5, right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(CupertinoIcons.globe,
                                      size: 20, color: Colors.blue)),
                              //capture the success flag with async and await
                              onPressed: () async {
                                String url = "${widget.items.itemwebsite}";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  showSimpleNotification(
                                    Text("Could not lunch $url"),
                                    background: Colors.green[400],
                                    position: NotificationPosition.bottom,
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),

                //column for button email and web
              ),

              Padding(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
                child: //expirement rating here
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w300),
                      ),
                      Consumer<LoginService>(
                          builder: (context, loginService, child) {
                        if (loginService.isUserLoggedIn()) {
                          return Consumer<RatingService>(
                              builder: (context, rating, child) {
                            //check if saved
                            Widget renderedButton;
                            //for ratings

                            //check is it is saved then display regular button

                            if (!rating.isRated(widget.items)) {
                              renderedButton = ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(3),
                                    primary: Colors.white, //background
                                    onPrimary: Colors.green, //foreground
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 3, bottom: 3, left: 5, right: 5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '  Submit Review ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                onPressed: () {
                                  double itemratingval = 0;
                                  TextEditingController comment =
                                      TextEditingController();

                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Green Rating",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.green[400])),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  RatingBar.builder(
                                                      wrapAlignment:
                                                          WrapAlignment.center,
                                                      glowColor: Colors.green,
                                                      itemSize: 35,
                                                      initialRating: 1,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder: (context,
                                                              _) =>
                                                          Icon(
                                                            Icons.eco_rounded,
                                                            color: Colors
                                                                .green[400],
                                                          ),
                                                      updateOnDrag: true,
                                                      onRatingUpdate: (rating) {
                                                        setState(() {
                                                          itemratingval =
                                                              rating;
                                                        });
                                                      }),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Tell us about the socio-economic and/or environmental impact practiced by this business.",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey)),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  //field to comment
                                                  TextField(
                                                    controller: comment,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .words,
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey),
                                                      labelText: 'Review',
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .green[400],
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Topics you may include; Environmental Awareness, Water/Energy/Paper Savings, Food Waste Reduction, Proper Waste Management, Cultural Promotion, Employees well-being, Support on Charitable Projects, Responsible Tourist Advice, Child Protection, Local Support, etc. ",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey)),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "Note: This is not a certification. No on-site inspection has been conducted nor an assesment by an organization. This is a user-based peer rating system that gathers user perspectives on how the business deals with sustainable tourism based on the user's personal experiences.",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Colors.red[400])),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  comment.clear();
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (comment.text.isEmpty) {
                                                    desc.text = '';
                                                  }
                                                  ratingService.addrateditem(
                                                      context,
                                                      RatedItems(
                                                          category:
                                                              widget.items),
                                                      itemratingval,
                                                      comment.text);
                                                  Navigator.pop(context);
                                                  showSimpleNotification(
                                                    Text(
                                                        "Review has been submitted!"),
                                                    background:
                                                        Colors.green[400],
                                                    position:
                                                        NotificationPosition
                                                            .bottom,
                                                  );
                                                },
                                                child: Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));

                                  //rate item
                                },
                              );
                            } else {
                              renderedButton = Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(Icons.check,
                                        color: Colors.green[400], size: 20),
                                    Text(" Reviewed",
                                        style: TextStyle(
                                            color: Colors.green[400])),
                                  ],
                                ),
                              );
                            }

                            return renderedButton;
                          });
                        }
                        return SizedBox();
                      }),
                    ]),
              ),

              //for comment section

              SingleChildScrollView(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('ratings')
                          .doc('${widget.items.itemcategoryName}')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var userDocument = snapshot.data;
                          var path = userDocument["${widget.items.name}.sets"];
                          /*var username = path[0];

                          return Text(
                            "${username["username"].toString()} name this",
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            Text(
                                    "${username["username"].toString()}",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 14));
                          );*/
                          return path.length > 0
                              ? ListView.builder(
                                  itemCount: path.length,
                                  itemBuilder: (context, index) {
                                    var username = path[index];
                                    double userrating = double.parse(
                                        username["rating"].toString());
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        ListTile(
                                            leading: Text(
                                                "${username["rating"].toString()}",
                                                style: TextStyle(
                                                    color: Colors.green[400],
                                                    fontSize: 20)),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RatingBarIndicator(
                                                  rating: userrating,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.eco_rounded,
                                                    color: Colors.green[400],
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 14.0,
                                                  direction: Axis.horizontal,
                                                  unratedColor:
                                                      Colors.grey[400],
                                                ),
                                                Text(
                                                    "${username["username"].toString()}",
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            subtitle: Text(
                                                "${username["comment"].toString()}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                            trailing: Wrap(
                                                direction: Axis.vertical,
                                                spacing:
                                                    10, // space between two icons
                                                children: <Widget>[
                                                  ClipOval(
                                                      child: Image.network(
                                                          "${username["userimg"].toString()}",
                                                          width: 35,
                                                          height: 35,
                                                          fit: BoxFit.cover)),
                                                  SizedBox()
                                                ])),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey[400],
                                        ),
                                      ]),
                                    );
                                  })
                              : path.length == null
                                  ? Center(
                                      child: Text(
                                      'No reviews',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ))
                                  : Center(
                                      child: Text(
                                      'No reviews',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ));
                        } else if (snapshot.hasError) {
                          return Text(
                            'Unrated',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          );
                        } else
                          return Text('Loading');
                      }),
                ),
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ),

        //add top nav
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              colorbackground: Colors.transparent,
            )),
      ]),
    ));
  }

  //to show pins or markers on map
  void showPinsOnMap() {
    LatLng destinationlatlong =
        LatLng(widget.items.itemlat, widget.items.itemlong);
    destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
        icon: destinationIcon,
      ));
    });
  }

//initiate values to add to calendar

  List<String> emails = [Auth().getCurrentUser().email];

  List<Map<DateTime, List<Event>>> events2 = [];
  TextEditingController event = TextEditingController();
  TextEditingController timer = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController website = TextEditingController();
  String imgName;
  String lat;
  String long;
  String address;
  String itemname;
  String category;

  DateTime _selectedDay = DateTime.now();
  RegExp time_24H = new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$");
  RegExp time_12H =
      new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9]) ?((a|p)m|(A|P)M)$");

  Timestamp t;
  DateTime eventDate;
  Map res = Map();

//action dialog for calendar here

  void _showAction(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextFieldDatePicker(
                  prefixIcon: Icon(Icons.calendar_today_rounded),
                  firstDate: kFirstDay,
                  lastDate: kLastDay,
                  initialDate: _selectedDay,
                  onDateChanged: (DateTime value) {
                    if (mounted)
                      setState(() {
                        eventDate = value;
                      });
                    print(eventDate);
                  },
                ),
                SizedBox(height: 7),
                TextField(
                  onTap: () {
                    setState(() {
                      showPicker(context).then((value) => timer.text = value);
                    });
                  },
                  controller: timer,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.timer_rounded),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      labelText: "Time",
                      hintText: "Enter Time"),
                ),
                SizedBox(height: 7),
                buildTextField(controller: event, hint: 'Event'),
                SizedBox(height: 7),
                TextField(
                  controller: desc,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: budget
                    ..text = "${widget.items.itempriceMin.toString()}",
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Budget',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  controller: website..text = "${widget.items.itemwebsite}",
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Website',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                event.clear();
                desc.clear();
                timer.clear();
                budget.clear();
                website.clear();

                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                imgName = widget.items.imgName.toString();
                lat = widget.items.itemlat.toString();
                long = widget.items.itemlong.toString();
                address = widget.items.itemaddress.toString();
                itemname = widget.items.name.toString();
                category = widget.items.itemcategoryName.toString();
                if (timer.text.isEmpty ||
                    !(time_12H.hasMatch(timer.text) ||
                        time_24H.hasMatch(timer.text))) {
                  showSimpleNotification(
                      Text("Please enter a valid time to the event"));
                } else if (eventDate == null) {
                  eventDate = DateTime.now();
                } else if (event.text.isEmpty) {
                  showSimpleNotification(
                      Text("Please enter a valid title to the event"));
                } else if (desc.text.isEmpty) {
                  desc.text = 'No Description';
                } else if (budget.text.isEmpty) {
                  budget.text = '0.00';
                } else if (website.text.isEmpty) {
                  website.text = 'No Website Linked';
                } else {
                  print(emails);
                  setEvents().whenComplete(() async {
                    event.clear();
                    desc.clear();
                    budget.clear();
                    website.clear();
                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(
      {String hint, @required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  //time picker
  Future<String> showPicker(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (BuildContext context, Widget child) {
          return child;
        });
    String res = t.format(context);
    return res;
  }

  //set events here
  Future setEvents() async {
    List temp = await FunctionUtils().eventUsers(emails);
    int today = FunctionUtils().calculateDifference(_selectedDay);
    if (today < 0) {
      showSimpleNotification(
        Text("You cannot create a event before today!",
            style: TextStyle(color: Colors.blue)),
        background: Colors.white,
        position: NotificationPosition.bottom,
      );
    } else {
      for (int i = 0; i < temp.length; i++) {
        List events = [];
        print("lol");
        events.add({
          "Event": event.text,
          "description": desc.text,
          "time": timer.text,
          "budget": budget.text,
          "website": website.text,
          "imgName": imgName,
          "lat": lat,
          "long": long,
          "address": address,
          "itemname": itemname,
          "category": category,
          "CreatedBy": emails[0],
          "users": emails
        });
        final sp =
            await databaseReference.collection('Users').doc(temp[i]).get();
        String name = sp.get("Name");

        String date = DateFormat('yyyy-MM-dd').format(eventDate);
        final snapShot = databaseReference
            .collection('Users')
            .doc(temp[i])
            .collection("Events")
            .doc(date);
        var data = await snapShot.get();
        int max = !data.exists ? 0 : data.get("EventList").length;
        if (max <= 50) {
          if (data.exists) {
            snapShot.update({"EventList": FieldValue.arrayUnion(events)});
            showSimpleNotification(
              Text("Event Added", style: TextStyle(color: Colors.blue)),
              background: Colors.white,
              position: NotificationPosition.bottom,
            );
            /* FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);*/
          } else {
            snapShot.set({'EventList': events});
            showSimpleNotification(
              Text("Event Added", style: TextStyle(color: Colors.blue)),
              background: Colors.white,
              position: NotificationPosition.bottom,
            );
            /*FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);*/
          }
        } else {
          showSimpleNotification(
              Text(
                "$name isn't available",
              ),
              background: Color(0xff29a39d));
          break;
        }
      }
    }
  }

//show share dialog
  void _showShare(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
            title: Column(
              children: [
                Text('Share To'),
              ],
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                //facebook
                Padding(
                  padding: const EdgeInsets.all(5),
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
                      FlutterSocialContentShare.share(
                          type: ShareType.facebookWithoutImage,
                          url: "${widget.items.itemwebsite}",
                          quote:
                              "Hey, check this awesome place at Boracay Island! ${widget.items.name} - ${widget.items.itemaddress}.");
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(Icons.facebook_rounded,
                              size: 30, color: Colors.blue),
                          SizedBox(width: 5),
                          Text("Facebook",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
                //instagram
                Padding(
                  padding: const EdgeInsets.all(5),
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
                      FlutterSocialContentShare.share(
                        type: ShareType.instagramWithImageUrl,
                        imageUrl: "${widget.items.imgName}",
                        quote:
                            "Hey, check this awesome place at Boracay Island! ${widget.items.name} - ${widget.items.itemaddress}.",
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          SvgPicture.asset(
                            'assets/icons/InstagramIcon.svg',
                            color: Colors.blue,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Text("Instagram",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
                //whatsapp
                Padding(
                  padding: const EdgeInsets.all(5),
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
                      FlutterSocialContentShare.shareOnWhatsapp("xxxxxx",
                          "Hey, check this awesome place at Boracay Island! ${widget.items.name} - ${widget.items.itemaddress}.  ${widget.items.itemwebsite}");
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          SvgPicture.asset(
                            'assets/icons/WhatsAppIcon.svg',
                            color: Colors.blue,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 5),
                          Text("WhatsApp",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
                //email
                Padding(
                  padding: const EdgeInsets.all(5),
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
                      FlutterSocialContentShare.shareOnEmail(
                          recipients: ["xxxx.xxx@gmail.com"],
                          subject:
                              "Hey, check this awesome place at Boracay Island! ${widget.items.name} - ${widget.items.itemaddress}.",
                          body: "${widget.items.itemwebsite}",
                          isHTML: true); //default isHTML: False
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(Icons.email_rounded,
                              size: 30, color: Colors.blue),
                          SizedBox(width: 5),
                          Text("Email",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
                //sms
                Padding(
                  padding: const EdgeInsets.all(5),
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
                      FlutterSocialContentShare.shareOnSMS(
                          recipients: ["xxxxxx"],
                          text:
                              "Hey, check this awesome place Boracay Island! ${widget.items.name} - ${widget.items.itemaddress}, ${widget.items.itemwebsite}");
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //use userLoggedIn flag to change icon and text
                          Icon(Icons.sms_rounded, size: 30, color: Colors.blue),
                          SizedBox(width: 5),
                          Text("SMS",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
