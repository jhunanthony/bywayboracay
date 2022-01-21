
import 'package:flutter/material.dart';


import '../WeatherWidgets/WeatherPage.dart';
import '../WeatherWidgets/weather_forecast.dart';

class WeatherReportPage extends StatefulWidget {
  const WeatherReportPage({Key key}) : super(key: key);

  @override
  State<WeatherReportPage> createState() => _WeatherReportPageState();
}

class _WeatherReportPageState extends State<WeatherReportPage> {
  Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Daily Weather Report",
          textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
      content: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherPageWidget(
                location: snapshot.data.location,
                temp: snapshot.data.temp,
                tempMin: snapshot.data.tempMin,
                tempMax: snapshot.data.tempMax,
                weather: snapshot.data.weather,
                humidity: snapshot.data.humidity,
                windspeed: snapshot.data.windspeed,
                visibility: snapshot.data.visibility,
                airpressure: snapshot.data.airpressure,
                weathericon: snapshot.data.weathericon,
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            return CircularProgressIndicator(color: Colors.white);
          }),
    );
  }
}
