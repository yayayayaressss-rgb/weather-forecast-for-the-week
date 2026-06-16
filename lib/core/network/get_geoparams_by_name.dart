import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:forecast_app_pet_proj/core/network/remote_params.dart';
import 'package:forecast_app_pet_proj/core/network/util/constants_geocoding.dart';

Future<ParamsGeo?> getCoordinatesByCityName({
  required Dio dioClient,
  required ParamsName params,
}) async {
  try {
    final queryParams = {
      ConstantsGeocoding.GEOCODING_NAME_PARAM: params.name,
      ConstantsGeocoding.GEOCODING_COUNT_PARAM: '1',
      ConstantsGeocoding.GEOCODING_LANG_PARAM: 'ru',
    };
    final response = await dioClient.get(
      ConstantsGeocoding.GEOCODING_BASE_URL,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200 && response.data != null) {
      final results = response.data['results'] as List?;
      if (results != null && results.isNotEmpty) {
        final firstResult = results.first;

        final double lat = (firstResult['latitude'] as num).toDouble();
        final double lon = (firstResult['longitude'] as num).toDouble();

        if (lat.abs() < 1.0 && lon.abs() < 1.0) {
          return null;
        }
        return ParamsGeo(lat: lat, lon: lon);
      }
    }
    log('fail');
    return null;
  } catch (e) {
    log('Ошибка при геокодинге: $e');
    return null;
  }
}
