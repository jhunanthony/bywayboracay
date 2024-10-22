import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



Future<WeatherInfo> fetchWeather() async {
  final zipCode = "5608";
  final apiKey = "5d36856671805a64eb9ec85edb242a85";
  final requestURL =
      "http://api.openweathermap.org/data/2.5/weather?zip=$zipCode,ph&units=metric&appid=$apiKey";

  final response = await http.get(Uri.parse(requestURL));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error Leoading request URL info.");
  }
}

class WeatherInfo {
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

  WeatherInfo({
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

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      weathericon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
      visibility: json['visibility'],
      airpressure: json['main']['pressure'],
    );
  }
}

