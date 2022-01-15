
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
//create the transit/tariff features here
class DistanceAndDurationInfo {
  final distance;
  final distancevalue;
  final duration;
  //final startlocation;

  DistanceAndDurationInfo({
    @required this.distance,
    @required this.distancevalue,
    @required this.duration,
    //@required this.startlocation,
  });

  factory DistanceAndDurationInfo.fromJson(Map<String, dynamic> json) {
    return DistanceAndDurationInfo(
      distance: json['rows'][0]['elements'][0]['distance']['text'],
      distancevalue: json['rows'][0]['elements'][0]['distance']['value'],
      duration: json['rows'][0]['elements'][0]['duration']['text'],
    );
  }
}

