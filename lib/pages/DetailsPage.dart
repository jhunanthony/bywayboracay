import 'dart:async';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/LikedItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/likeservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/auth.dart';
import 'package:bywayborcay/widgets/CalendarWidget/datepicker.dart';
import 'package:bywayborcay/widgets/CalendarWidget/emailtext.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    String parentCategory = widget.items.itemmarkerName;

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/' + parentCategory + '.png');
  }

  //indicator if button is liked or not
  //bool isLiked = false;

  final _imagepageController = PageController(viewportFraction: 0.877);
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
    LikeService likeService = Provider.of<LikeService>(context, listen: false);

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
                  height: 450,
                  width: MediaQuery.of(context).size.width,

                  //wrap with stack to overlay other components
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      controller: _imagepageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.items.detailsimages.length,
                      itemBuilder: (BuildContext context, int index) {
                        //show photos here
                        return Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.items.detailsimages[index].imgName),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          /*child: Stack(
                              children: [
                                //add gradient
                                Positioned.fill(
                                  child: Container(
                                      decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.3),
                                      ],
                                    ),
                                  )),
                                ),
                              ],
                            )*/
                        );
                        //add spacing
                      }),
                ),

                //add save button
                Positioned(
                    top: 70,
                    right: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(children: [
                        /*Consumer<LikeService>(
                            //a function called when notifier changes
                            builder: (context, save, child) {
                          return Text(
                            '${save.items.length} likes',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          );
                        }),*/

                        SizedBox(
                          height: 10,
                        ),
                        CategoryIcon(
                          iconName: widget.items.iconName,
                          color: Colors.transparent,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<LoginService>(
                            builder: (context, loginService, child) {
                          if (loginService.isUserLoggedIn()) {
                            return Consumer<LikeService>(
                                builder: (context, like, child) {
                              //check if saved
                              Widget renderedButton;

                              //check is it is saved then display regular button

                              if (!like.isLiked(widget.items)) {
                                renderedButton = ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.favorite_rounded),
                                      color: Colors.white,
                                      iconSize: 25,
                                      splashColor: Colors.pink[300],
                                      onPressed: () {
                                        likeService.add(context,
                                            LikedItem(category: widget.items));
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                renderedButton = Container(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(Icons.favorite_rounded,
                                      color: Colors.pink, size: 25),
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
                            return Consumer<LikeService>(
                                builder: (context, like, child) {
                              //check if saved
                              Widget likedtext;

                              //check is it is saved then display regular button

                              if (!like.isLiked(widget.items)) {
                                likedtext = Text(
                                  'Like',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                likedtext = Text(
                                  'Liked',
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
                      ]),
                    )),

                //title and calendar button

                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SmoothPageIndicator(
                          controller: _imagepageController,
                          count: widget.items.detailsimages.length,
                          effect: ExpandingDotsEffect(
                              activeDotColor: widget.items.color,
                              dotColor: Colors.white,
                              dotHeight: 5,
                              dotWidth: 5,
                              spacing: 3),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 13,
                          ),
                          //use wrap horizontal to auto expand text
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(direction: Axis.horizontal, children: [
                                  Text(
                                    widget.items.name,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                                Consumer<LoginService>(
                                    builder: (context, loginService, child) {
                                  if (loginService.isUserLoggedIn()) {
                                    return ClipOval(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(CupertinoIcons.calendar),
                                          color: Colors.blue[200],
                                          iconSize: 30,
                                          splashColor: Colors.blue,
                                          onPressed: () => _showAction(context),
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                }),
                              ]),
                        ),
                      ),
                    ]))
              ]),

              //show ratings1 here
              Padding(
                  padding:
                      EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                //show rating

                                Visibility(
                                  visible: widget.items.itemrating1 == null
                                      ? false
                                      : true,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${widget.items.itemratingname} ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      //for rating
                                      RatingBarIndicator(
                                        rating: widget.items.itemrating1,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star_rounded,
                                          color: Colors.yellow[800],
                                        ),
                                        itemCount: 5,
                                        itemSize: 12.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        " " +
                                            widget.items.itemrating1.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.yellow[800],
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            /*Visibility(
                              visible: widget.items.itemrating1 == null
                                  ? false
                                  : true,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Google ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  //for rating
                                  RatingBarIndicator(
                                    rating: widget.items.itemrating2.toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.yellow[800],
                                    ),
                                    itemCount: 5,
                                    itemSize: 12.0,
                                    direction: Axis.horizontal,
                                  ),
                                  Text(
                                    " " + widget.items.itemrating2.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.yellow[800],
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                        //save button here
                        /*Column(children: [
                          ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(CupertinoIcons.calendar),
                                color: Colors.blue[200],
                                iconSize: 30,
                                splashColor: Colors.blue,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Text(
                            'Save to \nItinerary',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ])*/
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
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          'min. ₱' +
                              widget.items.itempriceMin.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
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
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
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
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.directions,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    InkWell(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Get Directions',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          //use push replacement

                          Navigator.of(context).pushNamed('/mappage');
                        }),
                  ],
                ),
              ),

              //add contact information
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 5,
                    right: 20,
                  ),
                  child: Text(
                    'Direct Booking here!',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //add contacts

              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //column for text call and fb
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue, //background
                              onPrimary: Colors.white, //foreground
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
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
                            String sms =
                                "tel:" + widget.items.itemcontactNumber;
                            if (await canLaunch(sms)) {
                              await launch(sms);
                            } else {
                              throw 'Could not launch $sms';
                            }
                          }, // on press animate to 6 th element
                        ),
                      ],
                    ),

                    //column for email and website
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Email',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold)),
                                ),
                                onTap: () async {
                                  String mailto = "mailto:" +
                                      widget.items.itememail +
                                      "?subject=Inquiry&body=Greetings!";
                                  if (await canLaunch(mailto)) {
                                    await launch(mailto);
                                  } else {
                                    throw 'Could not launch $mailto';
                                  }
                                }),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text('Website',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold)),
                                ),
                                onTap: () async {
                                  String url = widget.items.itemwebsite;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                    //column for button email and web
                  ],
                ),
              ),
              SizedBox(
                height: 100,
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

  DateTime _selectedDay = DateTime.now();
  RegExp time_24H = new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$");
  RegExp time_12H =
      new RegExp(r"^(2[0-3]|[01]?[0-9]):([0-5]?[0-9]) ?((a|p)m|(A|P)M)$");
  List tapTitles = [
    "Are you sure you want to delete the event?",
    "Are you sure you want to send  the event reminders?"
  ];
  Timestamp t;
  DateTime eventDate;
  Map res = Map();

//action dialog for calendar here
  static const _actionTitle = 'Add Event';

  void _showAction(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_actionTitle),
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
                TextField(
                  controller: event..text = "${widget.items.name}",
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Event',
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
                    ..text = "${widget.items.itempriceMin.toStringAsFixed(2)}",
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
                  controller: website
                    ..text =
                        "https://www.google.com/maps/search/?api=1&query=${destinationLocation.latitude},${destinationLocation.longitude}",
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

                //SizedBox( height: 8),

                /*TextField(
                       controller: event,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: "Event",
                           hintText: "Enter Event Name"
                       ),
                     ),
                     //SizedBox( height: 8),
                     TextField(
                       controller: desc,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: "Description",
                           hintText: "Enter Event Description"
                       ),
                     ),*/
                //SizedBox( height: 8),
                /*Container(
                    child: EmailInput(
                  parentEmails: emails,
                  setList: (e) {
                    setState(() {
                      emails = e;
                    });
                  },
                ))*/
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
                  website.text = '0.00';
                } else if (website.text.isEmpty) {
                  website.text = 'No Website Linked';
                } else {
                  print(emails);
                  setEvents().whenComplete(() {
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
      showSimpleNotification(Text("You cannot create a event before today!"));
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
          "CreatedBy": emails[0],
          "users": emails
        });
        final sp =
            await databaseReference.collection('Users').doc(temp[i]).get();
        String name = sp.get("Name");
        String email = sp.get("Email");
        String date = DateFormat('yyyy-MM-dd').format(eventDate);
        final snapShot = databaseReference
            .collection('Users')
            .doc(temp[i])
            .collection("Events")
            .doc(date);
        var data = await snapShot.get();
        int max = !data.exists ? 0 : data.get("EventList").length;
        if (max <= 3) {
          if (data.exists) {
            snapShot.update({"EventList": FieldValue.arrayUnion(events)});
            showSimpleNotification(Text("Event Added"),
                background: Color(0xff29a39d));
            FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);
          } else {
            snapShot.set({'EventList': events});
            showSimpleNotification(
                Text(
                  "Event Added",
                ),
                background: Color(0xff29a39d));
            FunctionUtils()
                .sendEmail(email, date, events[0]["time"], emails[0]);
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
}
