import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/models/api_model_forecast/api_model_meteo.dart';

void main() {
  final jsonMock = File(
    'test/data/models/weather_response.json',
  ).readAsStringSync();
  test(
    '  WeatherResponse.fromJson(json) test, should return WeatherResponse',
    () {
      final result = WeatherResponse.fromJson(jsonDecode(jsonMock));
      expect(result, isNotNull);
      expect(result, isA<WeatherResponse>());
    },
  );
}
