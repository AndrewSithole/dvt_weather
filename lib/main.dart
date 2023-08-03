import 'package:dvt_weather/logic/cubit/preferences_cubit.dart';
import 'package:dvt_weather/logic/cubit/weather_cubit.dart';
import 'package:dvt_weather/logic/cubit/location_cubit.dart';
import 'package:dvt_weather/presentation/screens/app_home_screen.dart';
import 'package:dvt_weather/presentation/screens/app_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  // Set up Shared preferences
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(preferences: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});
  @override
  Widget build(BuildContext context) {
    PreferencesCubit preferencesCubit = PreferencesCubit(preferences);
    LocationCubit locationCubit = LocationCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => preferencesCubit),
        BlocProvider(create: (context) => WeatherCubit(locationCubit, preferencesCubit)),
        BlocProvider(create: (context) => locationCubit),
      ],
      child: BlocBuilder<PreferencesCubit, PreferencesState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'DVT Weather',
              theme: state.preferences.theme,
              home: const AppSplashScreen(),
            );
          },
        ),
    );
  }
}

