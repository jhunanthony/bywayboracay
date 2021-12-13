import 'dart:async';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/models/UserLogInModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/services/loginservice.dart';
import 'package:bywayborcay/widgets/CalendarWidget/utils.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapBottomInfo.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapUpperInfo.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

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
  }) : super(key: key);

  List<Event> markerlist;
  LatLng dest;

  @override
  _ItineraryMapState createState() => _ItineraryMapState();
}

class _ItineraryMapState extends State<ItineraryMap> {
  Completer<GoogleMapController> _controller = Completer();

  //control the state of bottom info position
  double pinBottomInfoPosition = PIN_VISIBLE_POSITION;
  //control the state color of user info
  bool userInfoSelected = false;

  //LatLng destinationLocation;

  // the user's initial location and current location
  // as it moves
  LocationData currentLocationref;
  //LocationData destinationLocationref;

  // wrapper around the location API
  Location locationref;

  //this will hold each polylines that if connected together will form the route
  //store each coordinates since polylines consist of multiple coordinates
  //a way to fetch the coordinates

  //for drawn routes on map
  /*Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;*/

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    locationref = new Location();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    locationref.onLocationChanged.listen((LocationData cLoc) {
      locationref.enableBackgroundMode(enable: true);
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocationref = cLoc;
      //updatePinOnMap();
    });

    this.setInitialLocation();

    //instantiate the polyline reference to call API
    // polylinePoints = new PolylinePoints();
  }

  void setInitialLocation() async {
    currentLocationref = await locationref.getLocation();
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

  /*Iterable _markers;

  void _setmarkers(BuildContext context) async {
    this.setSourceAndDestinationMarkerIcons(context);
    _markers = Iterable.generate(this.widget.markerlist.length, (index) {
      return Marker(
          markerId: MarkerId(this.widget.markerlist[index].title),
          position: LatLng(
            double.parse(this.widget.markerlist[index].lat),
            double.parse(this.widget.markerlist[index].long),
          ),
          infoWindow: InfoWindow(
              title: (index).toString() +
                  ' • ' +
                  this.widget.markerlist[index].title),
          icon: this.widget.markerlist[index].category == "ToStay"
              ? tostaymarker
              : this.widget.markerlist[index].category == "ToEat&Drink"
                  ? toeatdrinkmarker
                  : this.widget.markerlist[index].category == "ToDo"
                      ? todomarker
                      : this.widget.markerlist[index].category == "ToSee"
                          ? toseemarker
                          : this.widget.markerlist[index].title ==
                                  "sourcemarker"
                              ? usermarker
                              : toseemarker);
      //
    });
  }*/
  Set<Marker> _markers = Set<Marker>();

  void showPinsOnMap() async {
    int indexvalue = 0;
    this.setSourceAndDestinationMarkerIcons(context);
    currentLocationref = await locationref.getLocation();

    this.widget.markerlist.insert(
        0,
        Event(
          "sourcemarker",
          [
            {"user"}
          ],
          "source",
          "12:00",
          "0.00",
          "No Website Linked",
          "none",
          currentLocationref.latitude.toString(),
          currentLocationref.longitude.toString(),
          "none",
          "user",
        ));

    this.widget.markerlist.forEach((item) {
      setState(() {
        indexvalue++;
        _markers.add(Marker(
            markerId: MarkerId(item.title),
            position: LatLng(
              double.parse(item.lat),
              double.parse(item.long),
            ),
            infoWindow: InfoWindow(
                title: indexvalue.toString() +
                    ' ' +
                    item.timer +
                    ' • ' +
                    item.title),
            icon: item.category == "ToStay"
                ? tostaymarker
                : item.category == "ToEat&Drink"
                    ? toeatdrinkmarker
                    : item.category == "ToDo"
                        ? todomarker
                        : item.category == "ToSee"
                            ? toseemarker
                            : item.title == "sourcemarker"
                                ? usermarker
                                : toseemarker));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    this.setSourceAndDestinationMarkerIcons(context);

    /*this.widget.markerlist.insert(
        0,
        Event(
          "sourcemarker",
          [
            {"user"}
          ],
          "source",
          "12:00",
          "0.00",
          "No Website Linked",
          "none",
          currentLocationref.latitude.toString(),
          currentLocationref.longitude.toString(),
          "none",
          "user",
        ));*/

    // set up the marker icons & invoke the method

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
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        /*Text(this.widget.markerlist[0].title),
        Text(this.widget.markerlist[1].title),
        Text(this.widget.markerlist[2].title),
        Text(this.widget.dest.latitude.toString()),
        Text(this.widget.dest.latitude.toString()),*/

        Positioned.fill(
          child: GoogleMap(
            myLocationEnabled: true,
            compassEnabled: false,
            zoomControlsEnabled: false,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            //polylines: _polylines,
            markers: _markers,

            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              showPinsOnMap();

              //setPolylines();
            },
            /* onTap: (LatLng loc) {
              setState(() {
                //this.pinBottomInfoPosition = PIN_NOTVISIBLE_POSITION;
                this.userInfoSelected = false;
              });
            },*/
            //tapping will hide the bottom info //grab custom pins //grab the polylines
          ),
        ),
        /*Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: MapUserInformation(
              isSelected: this.userInfoSelected,
            )),*/
        /* AnimatedPositioned(
            //animate the bottom Info
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: this.pinBottomInfoPosition,
            child: MapBottomInfo()),*/
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
  /*void setPolylines() async {
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
            color: widget.items.color,
            points: polylineCoordinates));
      });
    }

    showPinsOnMap();
  }*/

  //create two marker reference and surround inside set state to trigger rebuild

  /*void updatePinOnMap() async {
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
      zoom: CAMERA_ZOOM,
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
  }*/
}
