import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItineraryDistDur extends StatelessWidget {
  //final startlocation;

  ItineraryDistDur({
    @required this.distancevalue,
    @required this.distance,
    @required this.duration,
    //@required this.startlocation,
  });

  final distance;
  final distancevalue;
  final duration;

  @override
  Widget build(BuildContext context) {
    double meterperpeso = 180.00;
    double estimatedfare = distancevalue / meterperpeso;
   

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              '${distance.toString()}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            distancevalue < 500
                ? Text(
                    ' • Walking Distance',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  )
                : Text(
                    ' • Away',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
            /*Visibility(
          //if distancevalue is less than 500 show walking distance
          visible: distancevalue < 500,
          child: Text(
            ' • Walking Distance',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 13,
            ),
          ),
        ),*/
          ]),
          /*Text(
        '${distancevalue.toString()}',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 12,
        ),
      ),*/
          Row(children: [
            Icon(Icons.emoji_transportation_rounded,
                size: 13, color: Colors.blue),
            Text(
              ' ${duration.toString()}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Text(
              ' in Transit',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
              ),
            ),
          ]),

          //in 9000 meter 50 pesos fare, is 180 meter there is 1 pesos rate
          //supposed it is 40 pesos, but due to pandemic rate has increase by 10 pesos

          Row(children: [
            Text(
              'Regular E-trike Fare: ₱ ',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
              ),
            ),

            //since 20.00 is minimum fare then return 20 pesos
            estimatedfare <= 20.00 ?
            Text(
              '20.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) : estimatedfare > 20.00 && estimatedfare <= 25.00 ?
            Text(
              '25.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) : estimatedfare > 25.00 && estimatedfare <= 30.00 ?
            //return 20.00 as minimum fare
            Text(
              '30.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) : estimatedfare > 30.00 && estimatedfare <= 35.00 ?
            Text(
              '35.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) : estimatedfare > 35.00 && estimatedfare <= 40.00 ?
            Text(
              '40.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) : estimatedfare > 40.00 && estimatedfare <= 45.00 ?
            Text(
              '45.00',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) :
            Text(
              estimatedfare.toStringAsFixed(2),
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ) 

          ])
        ]);
  }
}

class ItineraryDestDurInfo {
  //final startlocation;

  ItineraryDestDurInfo({
    @required this.distancevalue,
    @required this.distance,
    @required this.duration,
    //@required this.startlocation,
  });

  factory ItineraryDestDurInfo.fromJson(Map<String, dynamic> json) {
    return ItineraryDestDurInfo(

      distancevalue: json['rows'][0]['elements'][0]['distance']['value'],
      distance: json['rows'][0]['elements'][0]['distance']['text'],
      duration: json['rows'][0]['elements'][0]['duration']['text'],

    );
  }

  final distance;
  final distancevalue;
  final duration;
}
