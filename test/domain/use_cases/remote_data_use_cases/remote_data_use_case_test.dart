import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_remote_repo.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/remote_data_use_cases/remote_data_use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import '../../../data/repositories_data_impl/data_remote_repo_test.mocks.dart';

void main() {
  late MockDioClient mockDioClient;
  late MockGeoLocationService mockGeoLocationService;
  late MockSharedPreferences mockSharedPreferences;
  late MeteoMapper mapper;
  late DataRemoteRepoIMPL repo;
  late RemoteDataUseCase useCase;

  setUp(() {
    mockDioClient = MockDioClient();
    mockGeoLocationService = MockGeoLocationService();
    mockSharedPreferences = MockSharedPreferences();
    mapper = MeteoMapper();

    repo = DataRemoteRepoIMPL(
      mapper: mapper,
      dioClient: mockDioClient,
      geoService: mockGeoLocationService,
      sharedPreferences: mockSharedPreferences,
    );
    useCase = RemoteDataUseCase(aRepo: repo);
  });

  group('RemoteDataUseCase testing group', () {
    test('getByGeo foo test, should return right MeteoEntity ', () async {
      final mockPosition = MockPosition();
      when(mockPosition.latitude).thenReturn(55.7558);
      when(mockPosition.longitude).thenReturn(37.6176);

      when(
        mockGeoLocationService.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.always);
      when(
        mockGeoLocationService.getCurrentPosition(),
      ).thenAnswer((_) async => mockPosition);

      final responseJsonMock = jsonDecode(
        File('test/data/models/weather_response.json').readAsStringSync(),
      );

      when(
        mockDioClient.getForecastRowData(param: anyNamed('param')),
      ).thenAnswer((_) async => responseJsonMock);

      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      // Act
      final result = await useCase.getByGeo(isMetric: true);

      // Assert
      expect(result.isRight(), true);

      result.fold((error) => fail('Ошибка: ${error.message}'), (data) {
        expect(data, isNotNull);
        expect(data, isA<MeteoEntity>());
      });
    });

    test('getByName foo test, should return right MeteoEntity ', () async {
      final q = 'Moscow';

      final responseJsonMock = jsonDecode(
        File('test/data/models/weather_response.json').readAsStringSync(),
      );

      when(
        mockDioClient.getForecastRowData(param: anyNamed('param')),
      ).thenAnswer((_) async => responseJsonMock);

      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      final result = await useCase.getByName(isMetric: true, q: q);

      expect(result.isRight(), true);

      result.fold((error) => fail('Ошибка: ${error.message}'), (data) {
        expect(data, isNotNull);
        expect(data, isA<MeteoEntity>());
      });
    });
  });
}
