import 'dart:async';
import 'dart:convert';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapBottomInfo.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapUpperInfo.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../widgets/CategoryWidgets/CategoryIcon.dart';
import '../widgets/MapWidgets/DistanceAndDurationWidget.dart';
import '../widgets/MapWidgets/Transitfare.dart';

//construct a widget that passes user location as source location
//const LatLng DEST_LOCATION = LatLng(11.98189918417696, 121.9151854334716);
//default location is central boracay

const double CAMERA_ZOOM = 20;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const double PIN_VISIBLE_POSITION = 20;
const double PIN_NOTVISIBLE_POSITION = -300;

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  MapPage({Key key, this.items}) : super(key: key);

  Items items;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  //Google map Controller that controlls single instance of the google map

  Completer<GoogleMapController> _controller = Completer();
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(null);
    _controller.complete(controller);
  }

  //for costum marker pin
  //custom marker to costumize assets to be used
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  //set to hold list of markers
  Set<Marker> _markers = Set<Marker>();

  //call the distance info model
  //Future<DistanceAndDurationInfo> futuredistanceandduration;

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
  Future<DistanceAndDurationInfo> futuredistanceandduration;

  @override
  void initState() {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;
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
    this.setInitialLocation();

    //instantiate the polyline reference to call API
    polylinePoints = PolylinePoints();
    //set up initial Locations & invoke the method

    futuredistanceandduration = getdistanceandduration();

    WidgetsBinding.instance.addObserver(this);
  }

  /// Disposes of the platform resources

  // location custom marker

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    String parentCategory = widget.items.itemcategoryName;

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/User_Location_Marker.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/$parentCategory.png');
  }

  //create a method to instantiate from const to hard coded coordinates
  void setInitialLocation() async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    currentLocationref = await locationref.getLocation();
    destinationLocationref = LocationData.fromMap(
        {"latitude": widget.items.itemlat, "longitude": widget.items.itemlong});
  }

   Future<DistanceAndDurationInfo> getdistanceandduration() async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    currentLocationref = await locationref.getLocation();
    LatLng currentref =
        LatLng(currentLocationref.latitude, currentLocationref.longitude);
    destinationLocationref = LocationData.fromMap(
        {"latitude": widget.items.itemlat, "longitude": widget.items.itemlong});
    LatLng destinationref = LatLng(
        destinationLocationref.latitude, destinationLocationref.longitude);

    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&mode=transit_mode&origins=${currentref.latitude},${currentref.longitude}&destinations=${destinationref.latitude},${destinationref.longitude}&key=AIzaSyAlTZWNMZ063LrIy9yOlQzdS38zBT9utgc"));

    if (response.statusCode == 200) {
      return DistanceAndDurationInfo.fromJson(jsonDecode(response.body));
    } else {
      print("error distance matrix");
      throw Exception("Error Leoading request URL info.");
    }
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
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    // set up the marker icons & invoke the method
    this.setSourceAndDestinationMarkerIcons(context);

    //create a camera position instance to feed to the map
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(widget.items.itemlat, widget.items.itemlong));

    if (currentLocationref != null) {
      initialCameraPosition = CameraPosition(
          target:
              LatLng(currentLocationref.latitude, currentLocationref.longitude),
          zoom: CAMERA_ZOOM,
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
            markers: Set.from(_markers),

            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setPolylines();
              //showPinsOnMap();
            },
            onTap: (LatLng loc) {
              setState(() {
                this.pinBottomInfoPosition = PIN_NOTVISIBLE_POSITION;
                this.userInfoSelected = false;
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
                padding: EdgeInsets.all(15),
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
                                child: Image.network(widget.items.imgName,
                                    width: 60, height: 60, fit: BoxFit.cover)),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: CategoryIcon(
                                iconName: widget.items.itemcategoryName,
                                color: widget.items.itemcategoryName == "ToStay"
                                    ? Colors.purple[400]
                                    : widget.items.itemcategoryName ==
                                            "ToEat&Drink"
                                        ? Colors.red[400]
                                        : widget.items.itemcategoryName ==
                                                "ToSee"
                                            ? Colors.blue[400]
                                            : widget.items.itemcategoryName ==
                                                    "ToDo"
                                                ? Colors.green[400]
                                                : Colors.grey[700],
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
                                  widget.items.name,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  widget.items.itemaddress,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ]),
                        ),
                        //marker
                        Image.asset(
                            'assets/images/' +
                                widget.items.itemcategoryName +
                                '.png',
                            height: 40,
                            width: 40),
                        SizedBox(width: 15),

                        /*Icon(Icons.location_pin,
                    color: AppColors.accomodations, size: 50)*/
                      ])),
                  SizedBox(
                    height: 8,
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
                        FutureBuilder<DistanceAndDurationInfo>(
                            future: futuredistanceandduration,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DistanceAndDurationWidget(
                                    distancevalue: snapshot.data.distancevalue,
                                    distance: snapshot.data.distance,
                                    duration: snapshot.data.duration);
                              } else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              return CircularProgressIndicator();
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
                                    'https://www.google.com/maps/dir/?api=1&origin=${currentLocationref.latitude},${currentLocationref.longitude}&destination=${destinationLocationref.latitude},${destinationLocationref.longitude}&travelmode=walking&dir_action=navigate';

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

    destinationLocationref = LocationData.fromMap(
        {"latitude": widget.items.itemlat, "longitude": widget.items.itemlong});

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
            color: widget.items.itemcategoryName == "ToStay"
                ? Colors.purple[400]
                : widget.items.itemcategoryName == "ToEat&Drink"
                    ? Colors.red[400]
                    : widget.items.itemcategoryName == "ToSee"
                        ? Colors.blue[400]
                        : widget.items.itemcategoryName == "ToDo"
                            ? Colors.green[400]
                            : Colors.blue,
            points: polylineCoordinates));
      });
    }

    showPinsOnMap();
  }

  //create two marker reference and surround inside set state to trigger rebuild
  void showPinsOnMap() async {
    //get user information from loginservice to display name on user pin
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;
    String userName = userModel != null ? userModel.displayName : 'User';

    // get a LatLng for the source location
    // from the LocationData currentLocation object

    currentLocationref = await locationref.getLocation();

    destinationLocationref = LocationData.fromMap(
        {"latitude": widget.items.itemlat, "longitude": widget.items.itemlong});

    var currentPosition =
        LatLng(currentLocationref.latitude, currentLocationref.longitude);
    var destinationlatlong = LatLng(
        destinationLocationref.latitude, destinationLocationref.longitude);

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentPosition,
          icon: sourceIcon,
          infoWindow: InfoWindow(title: userName),
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationlatlong,
          icon: destinationIcon,
          infoWindow: InfoWindow(title: this.widget.items.name),
          onTap: () {
            setState(() {
              this.pinBottomInfoPosition = PIN_VISIBLE_POSITION;
            });
          }));
    });
  }

  void updatePinOnMap() async {
    //get user information from loginservice to display name on user pin
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    //grab the
    UserLogInModel userModel = loginService.loggedInUserModel;
    String userName = userModel != null ? userModel.displayName : 'User';

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
          icon: sourceIcon,
          infoWindow: InfoWindow(title: userName),
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));
    });
  }
}
