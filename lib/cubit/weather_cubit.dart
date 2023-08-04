import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/repositories/weather_repository.dart';
import 'package:dvt_weather/cubit/preferences_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'location_cubit.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository _repository = WeatherRepository();
  final LocationCubit locationCubit = LocationCubit();
  final PreferencesCubit preferenceCubit;
  StreamSubscription<PreferencesState>? preferenceSubscription;
  StreamSubscription<LocationState>? locationSubscription;
  // Adding the ability to pass location for testing purposes
  Position? position;

  WeatherCubit(this.preferenceCubit, {this.position}) : super(WeatherState()){
    if(position == null) {
      locationCubit.determinePosition().then((value) => null);
    }
  }
  void listenToLocationState() {
    debugPrint("listening to state changes");
    // Create a StreamSubscription that listens to changes in location state.
    locationSubscription = locationCubit.stream.listen((locationState) {
      debugPrint("Location state changed: ${locationState.toString()}");
      // If the location state is changed, update the WeatherState.
      if (locationState.status == LocationStatus.success) {
        fetchWeather();
      }
    });
    preferenceSubscription = preferenceCubit.stream.listen((preferenceState) {
      debugPrint("Location state changed: ${preferenceState.toString()}");
      // If the location state is changed, update the WeatherState.
      if (preferenceState is UnitsChanged && locationCubit.state.status == LocationStatus.success) {
        fetchWeather();
      }
    });

  }

  Future<void> fetchWeather(
      {String units = "metric",
        bool testLoading = false,
      bool testNoLocation = false}) async {
    emit(const WeatherState().copyWith(status: WeatherStatus.loading));
    if(testLoading) return;
    // Fetch weather data from repository.
    Position? location;
    if (position != null) {
      debugPrint("location is not null");
      location = position;
    } else if (locationCubit.state.status == LocationStatus.success) {
      location = locationCubit.state.position;
    }
    if (location != null && !testNoLocation) {
      try{
        debugPrint("Fetching weather data");
        WeatherObject weatherData  =  await _repository
                .fetchDailyWeatherByPosition(location, units);
        debugPrint("Emitted the items - ${weatherData.weather.main}");
        await fetchForecast(location, weatherData);
      }catch(error) {
        debugPrint("An error occurred - ${error.toString()}");
        emit(const WeatherState().copyWith(status: WeatherStatus.error));
      }
    }
    else{
      debugPrint("Location is null");
      emit(const WeatherState().copyWith(status: WeatherStatus.error));
    }
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
      emit(const WeatherState().copyWith(status: WeatherStatus.success, weather: data));
          debugPrint("Emitted the items");
    }).catchError((error) {
      debugPrint("An error occurred - ${error.toString()}");
      emit(const WeatherState().copyWith(status: WeatherStatus.error));
    });
  }

  @override
  close() async {
    if(locationSubscription != null)locationSubscription!.cancel();
    if(preferenceSubscription != null)preferenceSubscription!.cancel();
    super.close();
  }
}
