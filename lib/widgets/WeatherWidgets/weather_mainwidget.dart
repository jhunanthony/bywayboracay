import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WeatherMainWidget extends StatelessWidget {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windspeed;
  final visibility;
  final airpressure;
  final weathericon;

  WeatherMainWidget({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windspeed,
    @required this.visibility,
    @required this.airpressure,
    @required this.weathericon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        
        padding: EdgeInsets.only(left:10, right: 10, top: 5, bottom:5),
        color: Colors.transparent,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                '${temp.toInt().toString()}°C',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                ),
              ),
              Text(
                ' in ${location.toString()}',
                style: TextStyle(
                 color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ]),
            SizedBox(height: 5),
            Row(children: [
              Text(
                '${tempMax.toInt().toString()}°C / ',
                style: TextStyle(
              color: Colors.blue,
                  fontSize: 10,
                ),
              ),
              Text(
                '${tempMin.toInt().toString()}°C',
                style: TextStyle(
              color: Colors.blue,
                  fontSize: 10,
                ),
              ),
              Text(
                ' · ${weather.toString().toUpperCase()}',
                style: TextStyle(
               color: Colors.blue,
                  fontSize: 10,
                ),
              ),
            ])
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Image.network(
                'http://openweathermap.org/img/wn/$weathericon@2x.png',
                color: Colors.blue[200],
                height: 60,
                width: 60),
          ])

          /*Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            
            Text(
              'Humidity: ${humidity.toInt().toString()}%',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            
            Text(
              'Wind Speed: ${windspeed.toInt().toString()}m/s',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Air Pressure: ${airpressure.toInt().toString()}hPa',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              'Visibility: ${visibility.toInt().toString()}km',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ])
        */
        ]));
  }
}
