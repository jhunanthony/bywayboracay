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
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(2, 2)),
          ],
          image: DecorationImage(
            image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/bywayboracay-329114.appspot.com/o/null_photos%2FLogin_Beach.jpg?alt=media&token=b1ec35fb-7774-4640-9b8a-042995c83fd2",
            ),
            fit: BoxFit.fitWidth,
          ),

          /*color: Colors.yellow[50],*/
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(children: [
          Positioned.fill(
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.center,
                colors: <Color>[
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${temp.toInt().toString()}°C in ${location.toString()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${tempMax.toInt().toString()}°C / ${tempMin.toInt().toString()}°C · ${weather.toString().toUpperCase()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Image.network(
                        'http://openweathermap.org/img/wn/$weathericon@2x.png',
                        //color: Colors.blue[200],
                        height: 50,
                        width: 50),
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
                ]),
          ),
        ]));
  }
}
