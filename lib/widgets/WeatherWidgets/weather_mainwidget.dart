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
        padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], blurRadius: 6, offset: Offset(2, 2)),
          ],
          /*image: DecorationImage(
            image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2FLogin_Beach.jpg?alt=media&token=b1ec35fb-7774-4640-9b8a-042995c83fd2",
            ),
            fit: BoxFit.fitWidth,
          ),*/

          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 20, bottom: 0, right: 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${temp.toInt().toString()}°C in ${location.toString()}',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${tempMax.toInt().toString()}°C / ${tempMin.toInt().toString()}°C · ${weather.toString().toUpperCase()}',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                          ),
                        ),
                      ]),
                  Container(
                    height: 65,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.blue),
                    child: Center(
                      child: Image.network(
                          'http://openweathermap.org/img/wn/$weathericon@2x.png',
                          //color: Colors.blue[200],
                          height: 50,
                          width: 50),
                    ),
                  )

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
                ]),
          ),
        ]));
  }
}
