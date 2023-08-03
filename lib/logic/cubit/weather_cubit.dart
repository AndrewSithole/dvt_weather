import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/repositories/weather_repository.dart';
import 'package:dvt_weather/logic/cubit/internet_cubit.dart';
import 'package:dvt_weather/logic/cubit/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';

import 'location_cubit.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository _repository = WeatherRepository();
  final LocationCubit locationCubit;
  final PreferencesCubit preferenceCubit;
  StreamSubscription<PreferencesState>? preferenceSubscription;
  StreamSubscription<LocationState>? locationSubscription;

  WeatherCubit(this.locationCubit, this.preferenceCubit) : super(WeatherInitial()){
    // StreamSubscription streamSubscription = InternetCubit().

  }
  void listenToLocationState() {
    debugPrint("listening to state changes");
    // Create a StreamSubscription that listens to changes in location state.
    locationSubscription = locationCubit.stream.listen((locationState) {
      debugPrint("Location state changed: ${locationState.toString()}");
      // If the location state is changed, update the WeatherState.
      if (locationState is LocationSuccess) {
        fetchWeather(locationState.position);
      }
    });
    preferenceSubscription = preferenceCubit.stream.listen((preferenceState) {
      debugPrint("Location state changed: ${preferenceState.toString()}");
      // If the location state is changed, update the WeatherState.
      if (preferenceState is UnitsChanged && locationCubit.state is LocationSuccess) {
        fetchWeather(locationCubit.state.position);
      }
    });

  }
  Future<void> fetchWeather(Position position, {String units = "metric"}) async {
    debugPrint("Position is ${position.longitude}");
    emit(WeatherLoading());
    // Fetch weather data from repository.
    _repository.fetchDailyWeatherByPosition(position, units)
        .then((weatherData){
      debugPrint("Emitted the items - ${weatherData.weather.main}");
      fetchForecast(position, weatherData);
    }).catchError((value) {
      debugPrint("An error occurred - ${value.toString()}");
      emit(WeatherError());
    });
  }
  Future<void> fetchForecast(Position position, WeatherObject todayWeather, {String units = "metric"}) async {
    // Fetch weather data from repository.
    _repository.fetchWeatherForecastByPosition(position, units)
        .then((weatherData){
          // loop and set max and min values
      List<WeatherObject> weather = [];
      int i = 0;
      weatherData["list"].forEach((value) {
        if(i<=8){
          if(value["main"]["temp_min"]<todayWeather.main.temp_min){
            todayWeather.main.temp_min = value["main"]["temp_min"].round();
          }
          if(value["main"]["temp_max"]>todayWeather.main.temp_max){
            todayWeather.main.temp_max = value["main"]["temp_max"].round();
          }
        }
        if (i%8==3)weather.add(WeatherObject.fromMap(value));
        i++;
      });
      WeatherData data = WeatherData(daily: todayWeather, weekly: weather);
      preferenceCubit.updateTheme(data.daily.weather.image);
      emit(WeatherSuccess(data));
          debugPrint("Emitted the items");
    }).catchError((error) {
      debugPrint("An error occurred - ${error.toString()}");
      emit(WeatherError());
    });
  }

  @override
  close() async {
    if(locationSubscription != null)locationSubscription!.cancel();
    if(preferenceSubscription != null)preferenceSubscription!.cancel();
    super.close();
  }
}
