import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final SharedPreferences _preferences;

  PreferencesCubit(this._preferences) : super(PreferencesInitial());

  PreferencesState get preferences => state;

  Future<void> setTheme(String theme) async {
    // Set the theme in shared preferences.
    await _preferences.setString('theme', theme);

    // Update the preferences state.
    emit(ThemeChanged(theme: theme));
  }

  Future<void> clearTheme() async {
    // Clear the theme in shared preferences.
    await _preferences.remove('theme');

    // Update the preferences state.
    emit(ThemeChanged(theme: "null"));
  }
}