import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/providers/weather_api.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository{
  Future<WeatherObject> fetchDailyWeatherByPosition(Position position, String units) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getDailyWeather(position, units);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
    return WeatherObject.fromMap(rawWeather);
  }
  Future<WeatherObject> fetchDailyWeatherByCity(String city, String units) async {
    debugPrint("fetching weather data");
    // Fetch weather data from OpenWeatherMap API.
    try{
      var weatherData = await WeatherAPI.getDailyWeatherByCity(city, units);
      Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
      return WeatherObject.fromMap(rawWeather);
    }catch(error){
      debugPrint(error.toString());
      return Future.error(error);
    }
  }
  Future<Map<String, dynamic>> fetchWeatherForecastByPosition(Position position, String units) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getWeeklyWeather(position, units);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);

    return rawWeather;
  }
  Future<List<WeatherObject>> fetchWeatherForecastByCity(String city, String units) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getWeeklyWeatherByCity(city, units);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
    List<WeatherObject> _weather = [];
    rawWeather["list"].forEach((value) {
      _weather.add(WeatherObject.fromMap(value));
    });
    return _weather;
  }
}