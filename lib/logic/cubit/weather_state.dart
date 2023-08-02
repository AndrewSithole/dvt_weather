part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {
  final WeatherObject weatherObject;
  WeatherSuccess(this.weatherObject);
}
class WeatherError extends WeatherState {}
