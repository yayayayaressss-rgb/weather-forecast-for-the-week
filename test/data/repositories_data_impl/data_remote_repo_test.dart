import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/core/network/dio_client.dart';
import 'package:forecast_app_pet_proj/core/services/geo/geo_location_service.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_remote_repo.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/hourly_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/location_info.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mappers/weather_mapper_test.mocks.dart';
import 'data_local_repo_test.mocks.dart';
import 'data_remote_repo_test.mocks.dart'
    hide MockSharedPreferences, MockMeteoEntity;

@GenerateMocks([
  GeoLocationService,
  DioClient,
  SharedPreferences,
  Position,
  MeteoEntity,
])
// import 'data_remote_repo_test.dart.mocks';
Future<void> main() async {
  late MeteoMapper mapper = MeteoMapper();
  late MockGeoLocationService mockGeoLocationService;
  late MockDioClient mockDioClient;
  late MockSharedPreferences mockSharedPreferences;
  late DataRemoteRepoIMPL repo;
  setUp(() {
    mockGeoLocationService = MockGeoLocationService();
    mockDioClient = MockDioClient();
    mockSharedPreferences = MockSharedPreferences();
    mapper = MeteoMapper();

    repo = DataRemoteRepoIMPL(
      mapper: mapper,
      dioClient: mockDioClient,
      geoService: mockGeoLocationService,
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('Testing  DataRemoteRepoIMPL group ', () {
    test('getRespByName foo test should return MeteoEntity', () async {
      final responseJsonMock = File(
        'test/data/models/weather_response.json',
      ).readAsStringSync();
      when(
        mockDioClient.getForecastRowData(param: anyNamed('param')),
      ).thenAnswer((_) async => jsonDecode(responseJsonMock));
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      final result = await repo.getRespByName(isMetric: true, name: 'London');
      result.fold(
        (l) {
          fail('wrong answer ! ${l.message}');
        },
        (r) {
          expect(r, isNotNull);
          expect(r, isA<MeteoEntity>());
        },
      );
    });
    test('getRespByGeo should return MeteoEntity', () async {
      final mockPosition = MockPosition();

      when(mockPosition.latitude).thenReturn(55.7558);
      when(mockPosition.longitude).thenReturn(37.6173);

      when(
        mockGeoLocationService.getCurrentPosition(),
      ).thenAnswer((_) async => mockPosition);

      final responseJsonMock = File(
        'test/data/models/weather_response.json',
      ).readAsStringSync();

      when(
        mockDioClient.getForecastRowData(param: anyNamed('param')),
      ).thenAnswer((_) async => jsonDecode(responseJsonMock));

      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      final result = await repo.getRespByGeo(isMetric: true);

      result.fold((l) => fail('wrong answer ! ${l.message}'), (r) {
        expect(r, isNotNull);
        expect(r, isA<MeteoEntity>());
      });
    });
    test('saveToCache foo test should finish whit out exceptions', () {
      final String cityName = 'Moscow';
      final testLocation = LocationInfo(
        latitude: 55.7558,
        longitude: 37.6176,
        elevation: 156.0,
        timezone: 'Europe/Moscow',
      );
      final current = CurrentWeather(
        cityName: 'Moscow',
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
      final meteoEntityMock = MockMeteoEntity();
      when(meteoEntityMock.cityName).thenReturn(cityName);
      when(meteoEntityMock.location).thenReturn(testLocation);
      when(meteoEntityMock.current).thenReturn(current);
      when(meteoEntityMock.hourlyForecast).thenReturn(hourly);
      when(meteoEntityMock.dailyForecast).thenReturn(daily);

      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);
      repo.saveToCache(meteoEntityMock);
    });
    test('getPermission foo test should return true', () {
      when(
        mockGeoLocationService.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.always);

      expect(repo.getPermission(), completion(true));
    });
  });
}
