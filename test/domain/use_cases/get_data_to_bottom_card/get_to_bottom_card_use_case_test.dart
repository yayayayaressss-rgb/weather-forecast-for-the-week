import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_local_repo.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/hourly_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/location_info.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/get_data_to_bottom_card/get_to_bottom_card_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mappers/weather_mapper_test.mocks.dart';
import '../../../data/repositories_data_impl/data_local_repo_test.mocks.dart';

void main() {
  late GetToBottomCardUseCase useCase;
  late DataLocalRepoIMPL repo;
  late MeteoMapper mapper;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mapper = MeteoMapper();
    mockSharedPreferences = MockSharedPreferences();
    repo = DataLocalRepoIMPL(mapper: mapper, shared: mockSharedPreferences);
    useCase = GetToBottomCardUseCase(aRepo: repo);
  });
  final String cityName = 'Moscow';
  final testLocation = LocationInfo(
    latitude: 55.7558,
    longitude: 37.6176,
    elevation: 156.0,
    timezone: 'Europe/Moscow',
  );

  final current = CurrentWeather(
    cityName: cityName,
    time: '8 Июня',
    rowDate: DateTime.now(),
    temperature: 18.5,
    humidity: 65,
    apparentTemperature: 17.2,
    precipitation: 0.0,
    weatherCode: null,
    cloudCover: 10,
    pressure: 1013,
    windSpeed: 5.5,
    windDirection: 180,
    windGusts: 8.0,
  );

  final hourly = [
    HourlyWeather(
      validTimeFormat: '2024-01-15T12:00',
      time: DateTime(2024, 1, 15, 12, 0),
      temperature: 18.5,
      precipitationProbability: 20.0,
      weatherCode: '800',
    ),
  ];

  final daily = [
    DailyWeather(
      date: '2024-01-15',
      weatherCode: '800',
      tempMax: 22.5,
      tempMin: 12.0,
      sunrise: DateTime(2024, 1, 15, 7, 30),
      sunset: DateTime(2024, 1, 15, 16, 45),
      rowDate: DateTime(2024, 1, 15),
    ),
  ];
  group('GetToBottomCardUseCase group test', () {
    test(
      'getHourlyWeatherItem foo test should return HourlyWeather ',
      () async {
        final index = 0;
        final meteoEntityMock = MockMeteoEntity();
        when(meteoEntityMock.cityName).thenReturn(cityName);
        when(meteoEntityMock.location).thenReturn(testLocation);
        when(meteoEntityMock.current).thenReturn(current);
        when(meteoEntityMock.hourlyForecast).thenReturn(hourly);
        when(meteoEntityMock.dailyForecast).thenReturn(daily);
        when(
          repo.getFromCache(stringKey: cityName),
        ).thenAnswer((_) async => Right(meteoEntityMock));
        final jsonString = jsonEncode(mapper.toJson(meteoEntityMock));
        when(mockSharedPreferences.getString(cityName)).thenReturn(jsonString);
        final result = await useCase.getHourlyWeatherItem(
          cityName: cityName,
          index: index,
        );
        result.fold(
          (l) {
            print(l.message);
            fail('wrong answer!');
          },
          (r) {
            expect(r, isNotNull);
            expect(r, isA<HourlyWeather>());
          },
        );
      },
    );
    test('getDailyWeatherItem foo test should return DailyWeather', () async {
      final index = 0;
      final meteoEntityMock = MockMeteoEntity();
      when(meteoEntityMock.cityName).thenReturn(cityName);
      when(meteoEntityMock.location).thenReturn(testLocation);
      when(meteoEntityMock.current).thenReturn(current);
      when(meteoEntityMock.hourlyForecast).thenReturn(hourly);
      when(meteoEntityMock.dailyForecast).thenReturn(daily);
      when(
        repo.getFromCache(stringKey: cityName),
      ).thenAnswer((_) async => Right(meteoEntityMock));
      final jsonString = jsonEncode(mapper.toJson(meteoEntityMock));
      when(mockSharedPreferences.getString(cityName)).thenReturn(jsonString);
      final result = await useCase.getDailyWeatherItem(
        cityName: cityName,
        index: index,
        isMetric: true,
      );
      result.fold(
        (l) {
          print(l.message);
          fail('wrong answer!');
        },
        (r) {
          expect(r, isNotNull);
          expect(r, isA<DailyWeather>());
        },
      );
    });
  });
}
