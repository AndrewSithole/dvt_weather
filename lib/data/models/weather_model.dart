import 'package:flutter/material.dart';

class WeatherDetail{
  final int id;
  final String icon;
  final String description;
  final String image;
  final String main;
  WeatherDetail({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.image
  });
  factory WeatherDetail.fromMap(Map<String, dynamic> map) {
    String icon = "";
    String image = "";
    if(map["id"]<800){
      icon = "rain@3x.png";
      image = "rainy";
    }else if(map["id"]==800){
      icon = "clear@3x.png";
      image = "sunny";
    }else if(map["id"]>800){
      icon = "partlysunny@3x.png";
      image = "cloudy";
    }
    return WeatherDetail(
      id: map['id'],
      description: map['description'],
      main: map['main'],
      icon: icon,
      image: image,
    );
  }
}

class MainWeatherData{
  final int temp;
  int temp_max;
  final int feels_like;
  int temp_min;
  final int pressure;
  final int humidity;
  MainWeatherData({
    required this.temp,
    required this.temp_min,
    required this.feels_like,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
  });
  factory MainWeatherData.fromMap(Map<String, dynamic> map) {
    return MainWeatherData(
      temp: map['temp'].round(),
      feels_like: map['feels_like'].round(),
      temp_min: map['temp_min'].round(),
      temp_max: map['temp_max'].round(),
      pressure: map['pressure'],
      humidity: map['humidity'],
    );
  }
}
class WeatherObject{
  final WeatherDetail weather;
  final MainWeatherData main;
  final DateTime date;
  WeatherObject({
    required this.weather,
    required this.main,
    required this.date,
  });
  factory WeatherObject.fromMap(Map<String, dynamic> map) {
    return WeatherObject(
      date: DateTime.fromMillisecondsSinceEpoch(map["dt"]*1000),
      weather: WeatherDetail.fromMap(map["weather"][0]),
      main:  MainWeatherData.fromMap(map["main"]),
    );
  }
}
class WeatherData{
  final WeatherObject daily;
  final List<WeatherObject> weekly;
  WeatherData({
    required this.daily,
    required this.weekly,
  });
}
