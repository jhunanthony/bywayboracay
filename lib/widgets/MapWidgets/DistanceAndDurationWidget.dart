import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DistanceAndDurationWidget extends StatelessWidget {
  final distance;
   final distancevalue;
  final duration;
 

  DistanceAndDurationWidget({
    @required this.distancevalue,
    @required this.distance,
    @required this.duration,
 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
         Text(
                '${distance.toString()}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
              Text(
                '${distancevalue.toString()}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
        Text(
                '${duration.toString()}',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
      ]
    );
  }
}
