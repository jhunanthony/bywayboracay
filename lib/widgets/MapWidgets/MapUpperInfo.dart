// ignore_for_file: unnecessary_statements

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class MapUserInformation extends StatelessWidget {
  bool isSelected;
  // get the location data with this
  LocationData currentLocationLatlong;

  MapUserInformation({this.isSelected, this.currentLocationLatlong});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            color: this.isSelected ? Colors.blue[100] : Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero)
            ]),
        child: Row(children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: AssetImage('assets/images/User_Location_Marker.png'),
                    fit: BoxFit.cover),
                border: Border.all(
                  color: this.isSelected ? Colors.white : Colors.blue[100],
                  width: 2,
                ),
              )),
          SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: this.isSelected ? Colors.white : Colors.grey,
                    )),
                Text('Lat: ' + this.currentLocationLatlong.latitude.toString(),
                    style: TextStyle(color: Colors.green)),
                Text(
                    'Long: ' + this.currentLocationLatlong.longitude.toString(),
                    style: TextStyle(color: Colors.green)),
              ])),
          Image.asset("assets/images/User_Location_Marker.png",
              height: 30, width: 30),
        ]));
  }
}
