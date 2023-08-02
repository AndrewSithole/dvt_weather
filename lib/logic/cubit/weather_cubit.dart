import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/repositories/weather_repository.dart';
import 'package:dvt_weather/logic/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository = WeatherRepository();
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeather(Position position) async {
    debugPrint("Position is ${position.longitude}");
    emit(WeatherLoading());
    // Fetch weather data from repository.
    _repository.fetchDailyWeatherByPosition(position, "metric")
        .then((weatherData){
      debugPrint("Emitted the items - ${weatherData.weather.main}");
      fetchForecast(position, weatherData);
    }).catchError((value) {
      debugPrint("An error occurred - ${value.toString()}");
      emit(WeatherError());
    });
  }
  Future<void> fetchForecast(Position position, WeatherObject todayWeather) async {
    // Fetch weather data from repository.
    _repository.fetchWeatherForecastByPosition(position, "metric")
        .then((weatherData){
      WeatherData data = WeatherData(daily: todayWeather, weekly: weatherData);
      emit(WeatherSuccess(data));
          debugPrint("Emitted the items");
    }).catchError((error) {
      debugPrint("An error occurred - ${error.toString()}");
      emit(WeatherError());
    });
  }
}
