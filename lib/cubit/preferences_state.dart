part of 'preferences_cubit.dart';

@immutable
abstract class PreferencesState {
  final PreferenceModel preferences = PreferenceModel(theme: defaultTheme, units: "metric", homeImage: "sunny");
}
enum WeatherUnits{
  metric,
  standard,
  imperial
}
class PreferencesInitial extends PreferencesState {
  final PreferenceModel preferences = PreferenceModel(theme: defaultTheme, units: "metric", homeImage: "sunny");
}
class PreferencesChanged extends PreferencesState {
  final PreferenceModel preferences;
  PreferencesChanged({
    required this.preferences,
  });
}
class UnitsChanged extends PreferencesState {
  final PreferenceModel preferences;
  UnitsChanged({
    required this.preferences,
  });
}
class PreferencesStateThemeChanged extends PreferencesState {
  final String theme;
  PreferencesStateThemeChanged({required this.theme});
}
