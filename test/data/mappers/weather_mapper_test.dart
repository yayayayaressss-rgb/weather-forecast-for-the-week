import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/location_info.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MeteoEntity])
import 'weather_mapper_test.mocks.dart';

void main() {
  late MockMeteoEntity meteoEntityMock;
  setUp(() {
    meteoEntityMock = MockMeteoEntity();
    when(meteoEntityMock.cityName).thenReturn('London');
    when(meteoEntityMock.location).thenReturn(
      LocationInfo(
        latitude: 51.5085,
        longitude: -0.1257,
        elevation: 156.0,
        timezone: 'Europe/London',
      ),
    );
    when(meteoEntityMock.current).thenReturn(
      CurrentWeather(
        cityName: 'London',
        time: '27 Мая  12:00',
        rowDate: DateTime.now(),
        temperature: 21.07,
        humidity: 59,
        apparentTemperature: 20.77,
        precipitation: 0,
        weatherCode: '☀️',
        cloudCover: 6,
        pressure: 1026,
        windSpeed: 4.82,
        windDirection: 90,
        windGusts: 4.78,
      ),
    );
    when(meteoEntityMock.hourlyForecast).thenReturn([]);
    when(meteoEntityMock.dailyForecast).thenReturn([]);
  });
  final mockJsonString = File(
    'test/data/mappers/fixtures/ent_mapper_mock.json',
  ).readAsStringSync();
  final MeteoMapper mapper = MeteoMapper();
  group('MeteoEnty mapper test group', () {
    test('mapper toJson should return Map<String, dynamic>', () {
      final result = mapper.toJson(meteoEntityMock);
      expect(result, isNotNull);
      expect(result, isA<Map<String, dynamic>>());
    });
    test('mapper fromJson foo test should return MeteoEnty', () {
      mapper.fromJson(json.decode(mockJsonString));
    });
  });
}
