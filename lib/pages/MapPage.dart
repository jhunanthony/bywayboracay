import 'dart:async';
import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapBottomInfo.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapUpperInfo.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

//construct a widget that passes user location as source location
//const LatLng DEST_LOCATION = LatLng(11.98189918417696, 121.9151854334716);
const LatLng DEFAULT_LOCATION = LatLng(11.96151239329021, 121.92470019282162);

const double CAMERA_ZOOM = 16;
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

class _MapPageState extends State<MapPage> {
  //Google map Controller that controlls single instance of the google map
  Completer<GoogleMapController> _controller = Completer();

  //for costum marker pin
  //custom marker to costumize assets to be used
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  //set to hold list of markers
  Set<Marker> _markers = Set<Marker>();

  String googleAPI = 'AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE';

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
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocationref = cLoc;
      updatePinOnMap();
    });

    //instantiate the polyline reference to call API
    polylinePoints = PolylinePoints();

    //set up initial Locations & invoke the method
    this.setInitialLocation();
  }

  // location custom marker

  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;

    String parentCategory = widget.items.markerName;

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/User_Location_Marker.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/' + parentCategory + '.png');
  }

  //create a method to instantiate from const to hard coded coordinates
  void setInitialLocation() async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    widget.items = catSelection.items;
    //add latlong value here

    LatLng destinationlatlong = LatLng(widget.items.lat, widget.items.long);
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocationref = await locationref.getLocation();

    /*sourceLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);*/
    //display latlong value here

    /*destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);*/
    destinationLocationref = LocationData.fromMap({
      "latitude": destinationlatlong.latitude,
      "longitude": destinationlatlong.longitude
    });
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
        target: LatLng(widget.items.lat, widget.items.long));

    if (currentLocationref != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocationref.latitude, currentLocationref.longitude),
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
            markers: _markers,

            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              setPolylines();
              showPinsOnMap();
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
            top: 80,
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
            child: MapBottomInfo()),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              colorbackground: Colors.transparent,
              showTopProfile: false,
            )),
        Positioned(
          bottom: 10,
          right: 10,
          child: GestureDetector(
            child: Row(children: [
              Icon(Icons.directions, size: 20, color: Colors.blue[200]),
              Text('Open on Google Map',
                  style: TextStyle(color: Colors.grey[600])),
            ]),
            onTap: () async {
              String googleUrl =
                  'https://www.google.com/maps/dir/?api=1&origin=${currentLocationref.latitude},${currentLocationref.longitude}&destination=${destinationLocationref.latitude},${destinationLocationref.longitude}&travelmode=walking&dir_action=navigate';

              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
                throw 'Could not launch $googleUrl';
              }
            },

            //return info to redirect to google direction
          ),
        )
      ])),
    );
  }

  //this method will perform network call from the API
  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE',
      PointLatLng(currentLocationref.latitude, currentLocationref.longitude),
      PointLatLng(
          destinationLocationref.latitude, destinationLocationref.longitude),
      travelMode: TravelMode.walking,
      optimizeWaypoints: true,
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
            width: 5,
            polylineId: PolylineId('polyLine'),
            color: widget.items.color,
            points: polylineCoordinates));
      });
    }
  }

  //create two marker reference and surround inside set state to trigger rebuild
  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object

    var currentPosition =
        LatLng(currentLocationref.latitude, currentLocationref.longitude);
    var distinationPosition = LatLng(
        destinationLocationref.latitude, destinationLocationref.longitude);

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: currentPosition,
          icon: sourceIcon,
          infoWindow: InfoWindow(title: 'User'),
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: distinationPosition,
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
        infoWindow: InfoWindow(title: 'User'),
      ));
    });
  }
}
