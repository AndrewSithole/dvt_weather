import 'package:dvt_weather/data/models/weather_model.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('Daily weather From Map', () {
      test('returns correct Weather object', () {
        expect(
          WeatherObject.fromMap(
            <String, dynamic>{
              "coord": {
                "lon": 42.5,
                "lat": 11.5
              },
              "weather": [
                {
                  "id": 804,
                  "main": "Clouds",
                  "description": "overcast clouds",
                  "icon": "04d"
                }
              ],
              "base": "stations",
              "main": {
                "temp": 32.08,
                "feels_like": 31.72,
                "temp_min": 32.08,
                "temp_max": 32.08,
                "pressure": 1010,
                "humidity": 36,
                "sea_level": 1010,
                "grnd_level": 944
              },
              "visibility": 10000,
              "wind": {
                "speed": 9.47,
                "deg": 240,
                "gust": 10.31
              },
              "clouds": {
                "all": 93
              },
              "dt": 1691129211,
              "sys": {
                "country": "DJ",
                "sunrise": 1691117878,
                "sunset": 1691163255
              },
              "timezone": 10800,
              "id": 223816,
              "name": "Djibouti",
              "cod": 200
            },
          ),
          isA<WeatherObject>()
              .having((w) => w.weather.id, 'id', 804)
              .having((w) => w.main.temp, 'temperature', 32),
        );
      });
    });
  });
}
