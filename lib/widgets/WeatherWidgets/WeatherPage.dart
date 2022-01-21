
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherPageWidget extends StatelessWidget {
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

  WeatherPageWidget({
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[300]),
              child: Center(
                child: Image.network(
                    'http://openweathermap.org/img/wn/$weathericon@2x.png',
                    //color: Colors.blue[200],
                    height: 50,
                    width: 50),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                '${temp.toInt().toString()}°C in ${location.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${DateFormat('MMMM DD yyyy').format(DateTime.now())} ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${tempMax.toInt().toString()}°C / ${tempMin.toInt().toString()}°C · ${weather.toString().toUpperCase()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Humidity: ${humidity.toInt().toString()}%',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Wind Speed: ${windspeed.toInt().toString()}m/s',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Air Pressure: ${airpressure.toInt().toString()}hPa',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Visibility: ${visibility.toInt().toString()}km',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

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