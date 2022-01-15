import 'dart:async';
import 'dart:convert';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/MapWidgets/ItineraryDistanceAndDurationWidget.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapUpperInfo.dart';
import 'package:bywayborcay/widgets/MapWidgets/Transitfare.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../CategoryWidgets/CategoryIcon.dart';

//construct a widget that passes user location as source location
//const LatLng DEST_LOCATION = LatLng(11.98189918417696, 121.9151854334716);
//default location is central boracay
const LatLng DEFAULT_LOCATION = LatLng(11.96151239329021, 121.92470019282162);

const double CAMERA_ZOOM = 20;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_NOTVISIBLE_POSITION = -300;

// ignore: must_be_immutable
class ItineraryMap extends StatefulWidget {
  ItineraryMap({
    Key key,
    this.markerlist,
    this.dest,
    this.category,
    this.imgName,
    this.name,
    this.timer,
    this.budget,
    this.address,
  }) : super(key: key);

  List<Event> markerlist;
  LatLng dest;
  String category;
  String imgName;
  String name;
  String timer;
  String budget;
  String address;

  @override
  _ItineraryMapState createState() => _ItineraryMapState();
}

class _ItineraryMapState extends State<ItineraryMap>
    with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(null);
    _controller.complete(controller);
  }

  //control the state of bottom info position
  double pinBottomInfoPosition = PIN_VISIBLE_POSITION;
  //control the state color of user info
  bool userInfoSelected = false;

  //LatLng destinationLocation;

  // the user's initial location and current location
  // as it moves
  LocationData currentLocationref;
  LocationData destinationLocationref;

  // wrapper around the location API
  Location locationref;

  //this will hold each polylines that if connected together will form the route
  //store each coordinates since polylines consist of multiple coordinates
  //a way to fetch the coordinates

  //for drawn routes on map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  Future<ItineraryDestDurInfo> futuredistanceandduration;

  @override
  void initState() {
    super.initState();
    

    // create an instance of Location
    locationref = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    locationref.onLocationChanged.listen((LocationData cLoc) {
      //locationref.enableBackgroundMode(enable: true);
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocationref = cLoc;
      updatePinOnMap();
     
    });

    this.setInitialLocation(context);
    //instantiate the polyline reference to call API
    polylinePoints = PolylinePoints();

    WidgetsBinding.instance.addObserver(this);
     futuredistanceandduration = getitinerarydistanceandduration();
  }

  void setInitialLocation(BuildContext context) async {
    currentLocationref = await locationref.getLocation();
    destinationLocationref = LocationData.fromMap({
      "latitude": this.widget.dest.latitude,
      "longitude": this.widget.dest.longitude
    });
  }

  //get distance and duration using json parse
  Future<ItineraryDestDurInfo> getitinerarydistanceandduration() async {
    currentLocationref = await locationref.getLocation();
    destinationLocationref = LocationData.fromMap({
      "latitude": this.widget.dest.latitude,
      "longitude": this.widget.dest.longitude
    });

    final requestURL =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&mode=Transit&origins=${currentLocationref.latitude},${currentLocationref.longitude}&destinations=${destinationLocationref.latitude},${destinationLocationref.longitude}&key=AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE";

    final response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      return ItineraryDestDurInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error Leoading request URL info.");
    }
  }

  /// Disposes of the platform resources

  // location custom marker

  BitmapDescriptor tostaymarker;
  BitmapDescriptor toeatdrinkmarker;
  BitmapDescriptor toseemarker;
  BitmapDescriptor todomarker;
  BitmapDescriptor usermarker;

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    tostaymarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2), 'assets/images/ToStay.png');
    toeatdrinkmarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2),
        'assets/images/ToEat&Drink.png');
    toseemarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2), 'assets/images/ToSee.png');
    todomarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2), 'assets/images/ToDo.png');
    usermarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.2),
        'assets/images/User_Location_Marker.png');
  }

  Set<Marker> _markers = Set<Marker>();

  void showMarkers() async {
    this.setSourceAndDestinationMarkerIcons(context);
    currentLocationref = await locationref.getLocation();

    this.widget.markerlist.forEach((item) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(item.title),
            position: LatLng(
              double.parse(item.lat),
              double.parse(item.long),
            ),
            infoWindow: InfoWindow(
                title: ' "' +
                    "${this.widget.markerlist.indexWhere((markerdata) => markerdata.title == item.title && markerdata.timer == item.timer) + 1}" +
                    '" ' +
                    // ' • ' +
                    item.title),
            icon: item.category == "ToStay"
                ? tostaymarker
                : item.category == "ToEat&Drink"
                    ? toeatdrinkmarker
                    : item.category == "ToDo"
                        ? todomarker
                        : item.category == "ToSee"
                            ? toseemarker
                            : toseemarker,
            onTap: () {
              setState(() {
                this.pinBottomInfoPosition = PIN_VISIBLE_POSITION;
                this.widget.name = item.itemname;
                this.widget.imgName = item.imgName;
                this.widget.budget = item.budget;
                this.widget.category = item.category;
                this.widget.timer = item.timer;
                /*LatLng destlocal =
                    LatLng(double.parse(item.lat), double.parse(item.long));
                this.widget.dest = destlocal;*/
              });
            }));
      });
    });

    LatLng currentLoc =
        LatLng(currentLocationref.latitude, currentLocationref.longitude);
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;
    String userName = userModel != null ? userModel.displayName : 'User';

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentLoc,
          icon: usermarker,
          infoWindow: InfoWindow(title: userName),
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));
    });
  }

  @override
  void dispose() {
    locationref.onLocationChanged.listen((LocationData cLoc) {
      currentLocationref = cLoc;
      updatePinOnMap();
    }).cancel();
    super.dispose();
  }

  //observe phone status
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        //Add These lines
        final GoogleMapController controller = await _controller.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    this.setSourceAndDestinationMarkerIcons(context);

    //create a camera position instance to feed to the map
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(this.widget.dest.latitude, this.widget.dest.longitude)
        //target: LatLng(this.widget.dest.latitude, this.widget.dest.longitude)
        );

    if (currentLocationref != null) {
      initialCameraPosition = CameraPosition(
          target:
              LatLng(currentLocationref.latitude, currentLocationref.longitude),
          zoom: 14,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        Positioned.fill(
          child: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            polylines: _polylines,
            markers: _markers,

            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              // showPinsOnMap();
              setPolylines();
            },
            onTap: (LatLng loc) {
              setState(() {
                this.pinBottomInfoPosition = PIN_NOTVISIBLE_POSITION;
              });
            },
            //tapping will hide the bottom info //grab custom pins //grab the polylines
          ),
        ),
        Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: MapUserInformation(
              isSelected: this.userInfoSelected,
            )),
        AnimatedPositioned(
            //animate the bottom Info
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: this.pinBottomInfoPosition,
            child: Container(
                margin: EdgeInsets.all(20),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset.zero)
                    ]),
                child: Column(children: [
                  Container(
                      color: Colors.transparent,
                      child: Row(children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipOval(
                                child: Image.network(this.widget.imgName,
                                    width: 60, height: 60, fit: BoxFit.cover)),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: CategoryIcon(
                                iconName: this.widget.category,
                                color: this.widget.category == "ToStay"
                                    ? Colors.purple[400]
                                    : this.widget.category == "ToEat&Drink"
                                        ? Colors.red[400]
                                        : this.widget.category == "ToSee"
                                            ? Colors.blue[400]
                                            : this.widget.category == "ToDo"
                                                ? Colors.green[400]
                                                : Colors.blue,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  this.widget.name,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                /*Text(
                                  this.widget.markerlist.toString(),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 5,
                                  ),
                                ),*/
                                Text(
                                  this.widget.address,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      this.widget.timer,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "PHP ${this.widget.budget}",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        //marker
                        Image.asset('assets/images/${this.widget.category}.png',
                            height: 40, width: 40),
                        SizedBox(width: 15),

                        /*Icon(Icons.location_pin,
                    color: AppColors.accomodations, size: 50)*/
                      ])),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder<ItineraryDestDurInfo>(
                            future: futuredistanceandduration,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ItineraryDistDur(
                                  distancevalue: snapshot.data.distancevalue,
                                  distance: snapshot.data.distance,
                                  duration: snapshot.data.duration,
                                );
                              } else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransitfarePage()));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 15,
                                width: 15,
                                child: Icon(
                                  CupertinoIcons.question,
                                  size: 13,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[200], //background
                                  onPrimary: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 17,
                                      vertical: 17), //foreground
                                  shape: CircleBorder()),
                              child: Center(
                                child: Icon(
                                  Icons.directions_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                String googleUrl =
                                    'https://www.google.com/maps/dir/?api=1&origin=${currentLocationref.latitude},${currentLocationref.longitude}&destination=${this.widget.dest.latitude},${this.widget.dest.longitude}&travelmode=walking&dir_action=navigate';

                                if (await canLaunch(googleUrl)) {
                                  await launch(googleUrl);
                                } else {
                                  throw 'Could not launch $googleUrl';
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]))),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              colorbackground: Colors.transparent,
              showTopProfile: false,
            )),
      ])),
    );
  }

  //this method will perform network call from the API
  void setPolylines() async {
    currentLocationref = await locationref.getLocation();

    destinationLocationref = LocationData.fromMap({
      "latitude": this.widget.dest.latitude,
      "longitude": this.widget.dest.longitude,
    });

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE',
      PointLatLng(currentLocationref.latitude, currentLocationref.longitude),
      PointLatLng(
          destinationLocationref.latitude, destinationLocationref.longitude),

      //wayPoints: [PolylineWayPoint(location: "Philippines")]
    );

    //check status since it used async
    //returns an array of points and convert to LatLng to enable to render in the map
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 3,
            polylineId: PolylineId('polyLine'),
            color: this.widget.category == "ToStay"
                ? Colors.purple[400]
                : this.widget.category == "ToEat&Drink"
                    ? Colors.red[400]
                    : this.widget.category == "ToSee"
                        ? Colors.blue[400]
                        : this.widget.category == "ToDo"
                            ? Colors.green[400]
                            : Colors.blue,
            points: polylineCoordinates));
      });
    }

    showMarkers();
  }

  //create two marker reference and surround inside set state to trigger rebuild

  void updatePinOnMap() async {
    //get user information from loginservice to display name on user pin
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;
    String userName = userModel != null ? userModel.displayName : 'User';

    currentLocationref = await locationref.getLocation();

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocationref.latitude, currentLocationref.longitude),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position

      var currentPosition =
          LatLng(currentLocationref.latitude, currentLocationref.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentPosition,
          icon: usermarker,
          infoWindow: InfoWindow(title: userName),
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));
    });
  }
}
