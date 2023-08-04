// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:dvt_weather/cubit/preferences_cubit.dart';
import 'package:dvt_weather/cubit/weather_cubit.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nb_utils/nb_utils.dart';

Position position = Position.fromMap({
  "latitude": 33.1,
  "longitude": -17.0
});

class MockWeather extends Mock implements WeatherData {}

void main() {

  group('WeatherCubit', () {
    late WeatherCubit weatherCubit;
    late WeatherData weather;
    late PreferencesCubit preferenceCubit;
    late WeatherRepository weatherRepository;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferenceCubit = PreferencesCubit(preferences);
      weatherCubit = WeatherCubit(preferenceCubit, position: position);
      weatherRepository = WeatherRepository();
    });

    test('initial state is correct', () {
      final weatherCubit = WeatherCubit(preferenceCubit, position: position);
      expect(weatherCubit.state, WeatherState());
    });


    group('fetchWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'starts loading when fetch weather is invoked',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeather(testLoading: true),
        expect: () => <WeatherState>[WeatherState(status: WeatherStatus.loading)],
      );

      blocTest<WeatherCubit, WeatherState>(
        'Emits loading and error when location is not specified',
        build: () => weatherCubit,
        act: (cubit) => weatherCubit.fetchWeather(testNoLocation: true),
        expect: () => <WeatherState>[WeatherState(status: WeatherStatus.loading), WeatherState(status: WeatherStatus.error)],
      );


      // blocTest<WeatherCubit, WeatherState>(
      //   'calls getWeather with correct position',
      //   build: () => weatherCubit,
      //   act: (cubit) => cubit.fetchWeather(),
      //   verify: (_) {
      //     verify(() => weatherRepository.fetchDailyWeatherByPosition(position, "metric")).called(1);
      //   },
      // );
    });

  });
}
