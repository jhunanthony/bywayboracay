import 'dart:convert';

import 'package:bywayborcay/models/ItemsModel.dart';
import 'package:bywayborcay/services/categoryselectionservice.dart';
import 'package:bywayborcay/widgets/CategoryWidgets/CategoryIcon.dart';
import 'package:bywayborcay/widgets/MapWidgets/Transitfare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DistanceAndDurationWidget.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
//create the transit/tariff features here

class MapBottomInfo extends StatefulWidget {
  @override
  State<MapBottomInfo> createState() => _MapBottomInfoState();
}

class _MapBottomInfoState extends State<MapBottomInfo> {
  //String farevalue = 'Tourist';

  Items items;

  Future<DistanceAndDurationInfo> futuredistanceandduration;

  LatLng destinationLocation;
  // the user's initial location and current location
  // as it moves
  LocationData currentLocationref;
  //LocationData destinationLocationref;

  // wrapper around the location API
  Location locationref;

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
    });

    futuredistanceandduration = getdistanceandduration();
  }

  void getcurrentLocation() async {
    currentLocationref = await locationref.getLocation();
  }

//get distance and duration using json parse
  Future<DistanceAndDurationInfo> getdistanceandduration() async {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    this.items = catSelection.items;

    currentLocationref = await locationref.getLocation();

    LatLng destinationlatlong = LatLng(this.items.itemlat, this.items.itemlong);
    destinationLocation =
        LatLng(destinationlatlong.latitude, destinationlatlong.longitude);

    final requestURL =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&mode=Transit&origins=${currentLocationref.latitude},${currentLocationref.longitude}&destinations=${destinationLocation.latitude},${destinationLocation.longitude}&key=AIzaSyCnOiLJleUXIFKrzM5TTcCjSybFRCDvdJE";

    final response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      return DistanceAndDurationInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error Leoading request URL info.");
    }
  }

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context, listen: false);
    this.items = catSelection.items;

    return Container(
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
                        child: Image.network(this.items.imgName,
                            width: 60, height: 60, fit: BoxFit.cover)),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: CategoryIcon(
                        iconName: this.items.itemcategoryName,
                        color: this.items.color,
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
                          this.items.name,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          this.items.itemaddress,
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
                    'assets/images/' + this.items.itemcategoryName + '.png',
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
                          distance: snapshot.data.distance,
                          distancevalue: snapshot.data.distancevalue,
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
                                builder: (context) => TransitfarePage()));
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
                              horizontal: 17, vertical: 17), //foreground
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
                            'https://www.google.com/maps/dir/?api=1&origin=${currentLocationref.latitude},${currentLocationref.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&travelmode=walking&dir_action=navigate';

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
        ]));
  }
}
