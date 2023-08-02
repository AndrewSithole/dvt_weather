import 'package:bloc/bloc.dart';
import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:dvt_weather/data/repositories/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository = WeatherRepository();

  WeatherCubit() : super(WeatherInitial()){
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    // Fetch weather data from repository.
    _repository.fetchDailyWeatherByCity('Harare')
        .then((weatherData) => emit(WeatherSuccess(weatherData)))
        .catchError((value) => emit(WeatherError()));
    // Update the weather state.

  }
}
