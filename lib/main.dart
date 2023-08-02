import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dvt_weather/logic/cubit/internet_cubit.dart';
import 'package:dvt_weather/logic/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(connectivity: Connectivity(),));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({super.key, required this.connectivity});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: MaterialApp(
        title: 'Connectivity cubit',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Connectivity cubit spotlight'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial || state is WeatherLoading) {
                      return const Text(
                        'Loading',
                        style: TextStyle(color: Colors.yellow, fontSize: 30),
                      );
                    } else if (state is WeatherSuccess) {
                      return Text(
                        'Success',
                        style: TextStyle(color: Colors.green, fontSize: 30),
                      );
                    } else if (state is WeatherError) {
                      return Text(
                        'Error',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}