import 'package:dvt_weather/logic/cubit/preferences_cubit.dart';
import 'package:dvt_weather/logic/cubit/weather_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PreferencesCubit(preferences)),
        BlocProvider(create: (context) => WeatherCubit()),
      ],
      child: MaterialApp(
        title: 'DVT Weather',
        home: AppHomeScreen(),
      ),
    );
  }
}

