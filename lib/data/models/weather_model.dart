class WeatherDetail{
  final int id;
  final String icon;
  final String description;
  final String main;
  WeatherDetail({
    required this.id,
    required this.main,
    required this.description,
    required this.icon
  });
  factory WeatherDetail.fromMap(Map<String, dynamic> map) {
    return WeatherDetail(
      id: map['id'],
      description: map['description'],
      main: map['main'],
      icon: map['icon'],
    );
  }
}

class MainWeatherData{
  final double temp;
  final double temp_max;
  final double feels_like;
  final double temp_min;
  final int pressure;
  final int sea_level;
  final int grnd_level;
  final int humidity;
  final int temp_kf;
  MainWeatherData({
    required this.temp,
    required this.temp_min,
    required this.feels_like,
    required this.temp_max,
    required this.pressure,
    required this.sea_level,
    required this.grnd_level,
    required this.humidity,
    required this.temp_kf,
  });
  factory MainWeatherData.fromMap(Map<String, dynamic> map) {
    return MainWeatherData(
      temp: map['temp'],
      feels_like: map['feels_like'],
      temp_min: map['temp_min'],
      temp_max: map['temp_max'],
      pressure: map['pressure'],
      sea_level: map['sea_level'],
      grnd_level: map['grnd_level'],
      humidity: map['humidity'],
      temp_kf: map['temp_kf'],
    );
  }
}
class WeatherObject{
  final WeatherDetail weather;
  final MainWeatherData main;
  WeatherObject({
    required this.weather,
    required this.main,
  });
  factory WeatherObject.fromMap(Map<String, dynamic> map) {
    return WeatherObject(
      weather: WeatherDetail.fromMap(map["weather"][0]),
      main:  MainWeatherData.fromMap(map["main"]),
    );
  }
}
