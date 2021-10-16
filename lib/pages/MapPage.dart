import 'dart:async';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapBottomInfo.dart';
import 'package:bywayborcay/widgets/MapWidgets/MapUpperInfo.dart';
import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//construct a widget that passes user location as source location
const LatLng SOURCE_LOCATION = LatLng(11.98189918417696, 121.9151854334716);
//const LatLng DEST_LOCATION = LatLng(11.987426774719031, 121.90622655889455);

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
  //custom marker to costumize assets to be used
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  //set to hold list of markers
  Set<Marker> _markers = Set<Marker>();

  //control the state of bottom info position
  double pinBottomInfoPosition = PIN_VISIBLE_POSITION;
  //control the state color of user info
  bool userInfoSelected = false;

  LatLng sourceLocation;
  LatLng destinationLocation;

  //this will hold each polylines that if connected together will form the route
  //store each coordinates since polylines consist of multiple coordinates
  //a way to fetch the coordinates

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    //instantiate the polyline reference to call API
    polylinePoints = PolylinePoints();

    //set up initial Locations & invoke the method
    this.setInitialLocation();
  }

  // location custom marker
  void setSourceAndDestinationMarkerIcons(BuildContext context) async {
    String parentCategory = widget.items.categoryName;

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/User_Location_Marker.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/' + parentCategory + '_Marker.png');
  }

  //create a method to instantiate from const to hard coded coordinates
  void setInitialLocation() {
    //add latlong value here

    LatLng destinationlatlong = LatLng(widget.items.lat, widget.items.long);

    sourceLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    //display latlong value here

    destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);
  }

  @override
  Widget build(BuildContext context) {
    // set up the marker icons & invoke the method
    this.setSourceAndDestinationMarkerIcons(context);

    //create a camera position instance to feed to the map
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    return Scaffold(
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
          onTap: (LatLng loc) {
            setState(() {
              this.pinBottomInfoPosition = PIN_NOTVISIBLE_POSITION;
              this.userInfoSelected = false;
            });
          },
          //tapping will hide the bottom info //grab custom pins //grab the polylines
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);

            showPinsOnMap();
            setPolylines();
          },
        ),
      ),
      Positioned(
          top: 90,
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
          child: MapBottomInfo(items: widget.items)),
      Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TopNavBar(
            colorbackground: Colors.transparent,
            showTopProfile: false,
          ))
    ]));
  }

  //create two marker reference and surround inside set state to trigger rebuild
  void showPinsOnMap() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: sourceLocation,
          icon: sourceIcon,
          onTap: () {
            setState(() {
              this.userInfoSelected = true;
            });
          }));

      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon,
          onTap: () {
            setState(() {
              this.pinBottomInfoPosition = PIN_VISIBLE_POSITION;
            });
          }));
    });
  }

  //this method will perform network call from the API
  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.walking,
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
}
