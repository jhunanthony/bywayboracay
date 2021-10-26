import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistanceAndDurationWidget extends StatelessWidget {
  final distance;
  final distancevalue;
  final duration;
  //final startlocation;

  DistanceAndDurationWidget({
    @required this.distancevalue,
    @required this.distance,
    @required this.duration,
     //@required this.startlocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
      Text(
        'Distance: ${distance.toString()}',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 15,
        ),
      ),
      /*Text(
        '${distancevalue.toString()}',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
      ),*/
      Row(
        children: [
          Text(
          'Duration: ',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
          ),

        ),
          Icon(Icons.directions_walk_rounded, size: 12, color:Colors.blue),
          Text(
          ' ${duration.toString()}',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
          ),

        ),
        

        
        ]
      ),
      
    ]);
  }
}

class DistanceAndDurationInfo {
  final distancevalue;
  final distance;
  final duration;
  
  //final startlocation;

  DistanceAndDurationInfo({
    @required this.distancevalue,
    @required this.distance,
    @required this.duration,
    //@required this.startlocation,
  });

  factory DistanceAndDurationInfo.fromJson(Map<String, dynamic> json) {
    return DistanceAndDurationInfo(
      /*distancevalue: json['routes'][0][2]['legs'][0][0]['distance']['value'],
      distance: json['routes'][0][2]['legs'][0][0]['distance']['text'],
      duration: json['routes'][0][2]['legs'][0][1]['duration']['text'],
       startlocation: json['routes'][0]['legs'][0][4]['start_address'],*/
      distancevalue: json['rows'][0]['elements'][0]['distance']['value'],
      distance: json['rows'][0]['elements'][0]['distance']['text'],
      duration: json['rows'][0]['elements'][0]['duration']['text'],
      //startlocation: json['origin_addresses'][0],
    );
  }
}
