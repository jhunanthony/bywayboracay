import 'dart:async';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/pages/MapPage.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/LikeButtonWidgetdart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    String parentCategory = widget.items.markerName;

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/' + parentCategory + '.png');
  }

  @override
  void initState() {
    super.initState();
    //instantiate the polyline reference to call API

    this.setInitialLocation();
  }

  //set up initial Locations & invoke the method
  void setInitialLocation() {
    //add latlong value here

    LatLng destinationlatlong = LatLng(widget.items.lat, widget.items.long);
    //display latlong value here

    destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);
  }

  //indicator if button is liked or not
  //bool isLiked = false;

  final _imagepageController = PageController(viewportFraction: 0.877);
  @override
  Widget build(BuildContext context) {
    //pull marker icon
    this.setSourceAndDestinationMarkerIcons(context);
    //initialize needed values for map

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: destinationLocation);

    //canvas starts here
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //show header
              //wrap with stack to add components above images
              Stack(children: [
                Container(
                  height: 325,
                  width: MediaQuery.of(context).size.width,

                  //wrap with stack to overlay other components
                  child: ListView.builder(
                      controller: _imagepageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.items.detailsimages.length,
                      itemBuilder: (BuildContext context, int index) {
                        //show photos here
                        return Row(children: [
                          Container(
                              height: 325,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/' +
                                      widget
                                          .items.detailsimages[index].imgName +
                                      '.png'),
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
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Colors.transparent,
                                          widget.items.color.withOpacity(0.3),
                                        ],
                                      ),
                                    )),
                                  ),
                                ],
                              )),
                          //add spacing
                          SizedBox(
                            width: 5,
                          )
                        ]);
                      }),
                ),

                //add like button
                Positioned(
                    top: 80,
                    right: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(children: [
                        LikeButtonWidget(items: widget.items),

                        /*LikeButton(
                            countPostion: CountPostion.top,
                            size: 30,
                            circleColor: CircleColor(
                                start: Colors.pink[50], end: Colors.pink),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.pink[100],
                              dotSecondaryColor: Colors.pink,
                            ),

                            //bool here
                            //isLiked: isLiked,
                            //edit looks here

                            likeBuilder: (isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.pink : Colors.white,
                                size: 30,
                              );
                            },
                            likeCount: widget.items.likes,
                            likeCountPadding: EdgeInsets.only(
                              bottom: 5,
                            ),
                            countBuilder:
                                (int count, bool isLiked, String text) {
                              var color =
                                  isLiked ? Colors.pink[300] : Colors.white;
                              Widget result;
                              if (count == 0) {
                                result = Text(
                                  "love",
                                  style: TextStyle(color: color, fontSize: 12),
                                );
                              } else
                                result = Text(
                                  text,
                                  style: TextStyle(color: color, fontSize: 12),
                                );
                              return result;
                            },
                            onTap: (isLiked) async {
                              this.isLiked = !isLiked;
                              widget.items.likes += this.isLiked ? 1 : -1;

                              //TO DO: server request push new value likes

                              return !isLiked;
                            }),*/

                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ]),
                    )),

                //page indicator
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Align(
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
                ),
                //icon
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: CategoryIcon(
                    iconName: widget.items.iconName,
                    color: widget.items.color,
                    size: 40,
                  ),
                ),
              ]),
              //show page indicator

              //show name of item
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                //use wrap horizontal to auto expand text
                child: Wrap(direction: Axis.horizontal, children: [
                  Text(
                    widget.items.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
              ),

              //category icon

              //show ratings1 here
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'TripAdvisor ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                ),
                                //for rating
                                RatingBarIndicator(
                                  rating: widget.items.rating1,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.circle,
                                    color: Colors.green[300],
                                  ),
                                  itemCount: 5,
                                  itemSize: 12.0,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  " " + widget.items.rating1.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[300],
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Expedia ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                ),
                                //for rating
                                RatingBarIndicator(
                                  rating: widget.items.rating2.toDouble(),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.yellow[800],
                                  ),
                                  itemCount: 5,
                                  itemSize: 12.0,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  " " + widget.items.rating2.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.yellow[800],
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //save button
                        Column(children: [
                          ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(Icons.bookmark),
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
                        ])
                      ])),

              //Use EXapnding text widget
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: ExpandableText(
                  "       " + widget.items.description,
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
                            widget.items.opentime,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.tag,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'min. ₱' + widget.items.pricemin,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
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
                        widget.items.address,
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
                    GestureDetector(
                        child: Text(
                          'Get Directions',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MapPage(items: widget.items)));
                        }),
                  ],
                ),
              ),

              //add contact information
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 10,
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
                        GestureDetector(
                          child: Text(' Call  ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          onTap: () async {
                            String sms = "tel:" + widget.items.contactnumber;
                            if (await canLaunch(sms)) {
                              await launch(sms);
                            } else {
                              throw 'Could not launch $sms';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            child: Text(' Facebook  ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            onTap: () async {
                              String socialmedia = "fb://facewebmodal/f?href=" +
                                  widget.items.socialmedia;
                              if (await canLaunch(socialmedia)) {
                                await launch(socialmedia);
                              } else {
                                throw 'Could not launch $socialmedia';
                              }
                            }),
                      ],
                    ),
                    //column for buttons for call and fb
                    Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          child: Icon(
                            Icons.phone,
                            size: 20,
                            color: Colors.blue,
                          ),
                          onTap: () async {
                            String sms = "tel:" + widget.items.contactnumber;
                            if (await canLaunch(sms)) {
                              await launch(sms);
                            } else {
                              throw 'Could not launch $sms';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.circle,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String socialmedia = "fb://facewebmodal/f?href=" +
                                  widget.items.socialmedia;
                              if (await canLaunch(socialmedia)) {
                                await launch(socialmedia);
                              } else {
                                throw 'Could not launch $socialmedia';
                              }
                            }),
                      ],
                    ),
                    //column for email and website
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            child: Text(' Email  ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            onTap: () async {
                              String mailto = "mailto:" +
                                  widget.items.email +
                                  "?subject=Inquiry&body=Greetings!";
                              if (await canLaunch(mailto)) {
                                await launch(mailto);
                              } else {
                                throw 'Could not launch $mailto';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            child: Text(' Website  ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            onTap: () async {
                              String url = widget.items.website;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }),
                      ],
                    ),
                    //column for button email and web
                    Column(
                      children: [
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String mailto = "mailto:" +
                                  widget.items.email +
                                  "?subject=Inquiry&body=Greetings!";
                              if (await canLaunch(mailto)) {
                                await launch(mailto);
                              } else {
                                throw 'Could not launch $mailto';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.web_asset_rounded,
                              size: 20,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              String url = widget.items.website;
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            }),
                      ],
                    )
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
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
        icon: destinationIcon,
      ));
    });
  }
}
