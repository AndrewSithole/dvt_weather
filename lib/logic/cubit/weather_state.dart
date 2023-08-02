part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {
  WeatherData? weather;
}

class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {
  WeatherSuccess(WeatherData weather){
    this.weather = weather;
  }
}
class WeatherError extends WeatherState {}
