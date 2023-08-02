import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherAPI{
  static Future<http.Response> getDailyWeather(Position position) async{
    Uri url = Uri.https("https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=f16b5b11d45fae7731e545ca034d3b44");
    return http.get(url);
  }
  static Future<http.Response> getWeeklyWeather(Position position) async{
    Uri url = Uri.https("https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=f16b5b11d45fae7731e545ca034d3b44");
    return http.get(url);
  }
}