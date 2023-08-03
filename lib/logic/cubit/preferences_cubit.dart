import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dvt_weather/data/models/preference_model.dart';
import 'package:dvt_weather/logic/cubit/weather_cubit.dart';
import 'package:dvt_weather/presentation/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final SharedPreferences _preferences;
  PreferenceModel preferenceObject = PreferenceModel(theme: defaultTheme, units: "metric");

  PreferencesCubit(this._preferences) : super(PreferencesInitial());

  PreferencesState get preferences => state;

  Future<void> setUnits(String units) async {
    // Set the theme in shared preferences.
    await _preferences.setString('units', units);
    preferenceObject.units = units;
    // Update the preferences state.
    emit(PreferencesChanged(preferences: preferenceObject));
  }

  Future<void> setTheme(ThemeData theme) async {
    // Set the theme in shared preferences.
    await _preferences.setString('theme', jsonEncode(theme));
    preferenceObject.theme = theme;
    // Update the preferences state.
    emit(PreferencesChanged(preferences: preferenceObject));
  }
  Future<void> updateTheme(String themeName) async {
    ThemeData themeData  = defaultTheme;
    if (themeName == "cloudy"){
      themeData = cloudyTheme;
    }else if(themeName == "rainy"){
      themeData = rainyTheme;
    }

    // Set the theme in shared preferences.
    _preferences.setString('theme', themeName);
    preferenceObject.theme = themeData;
    // Update the preferences state.
    emit(PreferencesChanged(preferences: preferenceObject));
  }
  Future<void> getTheme() async {
    // Set the theme in shared preferences.
    String? themeName = _preferences.getString('theme');
    if(themeName != null){
      ThemeData themeData  = defaultTheme;
      if (themeName == "cloudy"){
        themeData = cloudyTheme;
      }else if(themeName == "rainy"){
        themeData = rainyTheme;
      }
      preferenceObject.theme = themeData;
      emit(PreferencesChanged(preferences: preferenceObject));
    }
    // Update the preferences state.
  }

}