import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/core/network/dio_client.dart';
import 'package:forecast_app_pet_proj/core/network/remote_params.dart';

void main() {
  final skipIntegrationTests = true;

  late Dio dio;
  late DioClient dioClient;

  setUpAll(() {
    dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (Object? object) {
          log(object.toString(), name: 'DIO');
        },
      ),
    );
    dioClient = DioClient(dioClient: dio);
  });

  group('Integration tests: DioClient', () {
    test(
      'getForecastRowData should return data for London',
      () async {
        final params = ParamsName(name: 'London');

        final result = await dioClient.getForecastRowData(param: params);

        expect(result, isNotNull);
        expect(result!.isNotEmpty, true);
        expect(result['cityName'], 'London');
        expect(result['latitude'], isNotNull);
        expect(result['longitude'], isNotNull);
        expect(result['current'], isNotNull);
        expect(result['hourly'], isNotNull);
        expect(result['daily'], isNotNull);
      },
      skip: skipIntegrationTests,
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'getForecastRowData should return data for Moscow by name',
      () async {
        final params = ParamsName(name: 'Moscow');

        final result = await dioClient.getForecastRowData(param: params);

        expect(result, isNotNull);
        expect(result!.isNotEmpty, true);
        expect(result['cityName'], 'Moscow');
        expect(result['current']['temperature_2m'], isNotNull);
      },
      skip: skipIntegrationTests,
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'getForecastRowData should return data for coordinates',
      () async {
        final params = ParamsGeo(lat: 55.7558, lon: 37.6176);

        final result = await dioClient.getForecastRowData(param: params);

        expect(result, isNotNull);
        expect(result!.isNotEmpty, true);
        expect(result['latitude'], 55.75);
        expect(result['longitude'], 37.625);
        expect(result['current'], isNotNull);
      },
      skip: skipIntegrationTests,
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'getForecastRowData should return null for non-existent city',
      () async {
        final params = ParamsName(name: 'NonExistentCity123456');

        final result = await dioClient.getForecastRowData(param: params);

        expect(result, isNull);
      },
      skip: skipIntegrationTests,
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'getForecastRowData should have correct weather data structure',
      () async {
        final params = ParamsName(name: 'Paris');

        final result = await dioClient.getForecastRowData(param: params);

        expect(result, isNotNull);

        expect(result!['current'], isA<Map>());
        expect(result['current']['temperature_2m'], isA<num>());
        expect(result['current']['weather_code'], isA<num>());
        expect(result['hourly'], isA<Map>());
        expect(result['hourly']['time'], isA<List>());
        expect(result['hourly']['temperature_2m'], isA<List>());
        expect(result['daily'], isA<Map>());
        expect(result['daily']['time'], isA<List>());
        expect(result['daily']['temperature_2m_max'], isA<List>());
        expect(result['daily']['temperature_2m_min'], isA<List>());
      },
      skip: skipIntegrationTests,
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
