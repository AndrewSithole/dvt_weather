import 'package:bloc_test/bloc_test.dart';
import 'package:dvt_weather/cubit/location_cubit.dart';
import 'package:dvt_weather/data/providers/weather_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

Position position = Position.fromMap({
  "latitude": 33.1,
  "longitude": -17.0
});
class MockLocationCubit extends MockCubit<LocationState> implements LocationCubit {
  @override
  Future<Position> determinePosition() async {
    emit(LocationState(position: position));
    return position;
  }
}

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main(){
  group("Open weather map API", ()
  {
    late http.Client httpClient;
    late WeatherAPI apiClient;
    late MockLocationCubit locationCubit;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = WeatherAPI();
      locationCubit = MockLocationCubit();
    });

    group('constructor', () {
      test('does not require any parameters', () {
        expect(WeatherAPI(), isNotNull);
      });
    });


  });
}