import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/providers/weather_api.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepository{
  Future<WeatherObject> fetchDailyWeatherByPosition(Position position) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getDailyWeather(position);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
    return WeatherObject.fromMap(rawWeather);
  }
  Future<WeatherObject> fetchDailyWeatherByCity(String city) async {
    debugPrint("fetching weather data");
    // Fetch weather data from OpenWeatherMap API.
    try{
      var weatherData = await WeatherAPI.getDailyWeatherByCity(city);
      Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
      debugPrint(weatherData.body);
      return WeatherObject.fromMap(rawWeather);
    }catch(error){
      debugPrint(error.toString());
      return Future.error(error);
    }

  }
  Future<List<WeatherObject>> fetchWeatherForecastByPosition(Position position) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getWeeklyWeather(position);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
    List<WeatherObject> _weather = [];
    rawWeather["list"].forEach((key, value) {
      _weather.add(WeatherObject.fromMap(value));
    });
    return _weather;
  }
  Future<List<WeatherObject>> fetchWeatherForecastByCity(String city) async {
    // Fetch weather data from OpenWeatherMap API.
    var weatherData = await WeatherAPI.getWeeklyWeatherByCity(city);
    Map<String, dynamic> rawWeather = jsonDecode(weatherData.body);
    List<WeatherObject> _weather = [];
    rawWeather["list"].forEach((key, value) {
      _weather.add(WeatherObject.fromMap(value));
    });
    return _weather;
  }
}