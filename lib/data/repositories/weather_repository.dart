import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/providers/weather_api.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository{
  late WeatherObject weather;
  Future getWeatherForLocation(Position position) async{
    WeatherAPI.getDailyWeather(position).then((response){
      Map<String, dynamic> map = jsonDecode(response.body);
      weather = WeatherObject.fromMap(map);
    }).catchError((error){
      debugPrint(error);
    });
  }
}