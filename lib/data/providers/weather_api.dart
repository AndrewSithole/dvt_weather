import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherAPI{
  static Future<http.Response> getDailyWeather(Position position, String units) async{
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=f16b5b11d45fae7731e545ca034d3b44&units=$units");
    return http.get(url);
  }
  static Future<http.Response> getWeeklyWeather(Position position, String units) async{
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=f16b5b11d45fae7731e545ca034d3b44&units=$units");
    return http.get(url);
  }
  static Future<http.Response> getDailyWeatherByCity(String city, String units) async{
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=f16b5b11d45fae7731e545ca034d3b44&units=$units");
    return http.get(url);
  }
  static Future<http.Response> getWeeklyWeatherByCity(String city, String units) async{
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=f16b5b11d45fae7731e545ca034d3b44&units=$units");
    return http.get(url);
  }
}