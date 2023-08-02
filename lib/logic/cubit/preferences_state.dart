part of 'preferences_cubit.dart';

@immutable
abstract class PreferencesState {
  String units = "metric";
}

class PreferencesInitial extends PreferencesState {}
class ThemeChanged extends PreferencesState {
  final String theme;
  ThemeChanged({required this.theme});
}
class PreferencesStateThemeChanged extends PreferencesState {
  final String theme;
  PreferencesStateThemeChanged({required this.theme});
}
