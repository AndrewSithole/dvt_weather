part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, error }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.error;
}

final class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    WeatherData? this.weather
  });

  final WeatherStatus status;
  final WeatherData? weather;

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherData? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
