import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:forecast_app_pet_proj/core/network/remote_params.dart';
import 'package:forecast_app_pet_proj/core/network/util/constants_api_open_meteo.dart';

Future<String?> getCityNameByCoordinates({
  required ParamsGeo params,
  required Dio dioClient,
}) async {
  try {
    final queryParams = {
      'lat': params.lat.toString(),
      'lon': params.lon.toString(),
      'format': 'json',
      'accept-language': Constants.LANGUAGE,
    };

    final response = await dioClient.get(
      'https://nominatim.openstreetmap.org/reverse',
      queryParameters: queryParams,
      options: Options(
        headers: {'User-Agent': 'ForecastApp/1.0'},
        validateStatus: (status) => status! < 500,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      Map<String, dynamic> data;
      if (response.data is String) {
        data = jsonDecode(response.data);
      } else if (response.data is Map<String, dynamic>) {
        data = response.data;
      } else {
        return null;
      }

      final address = data['address'] as Map<String, dynamic>?;
      if (address != null) {
        final city =
            address['city'] ??
            address['town'] ??
            address['village'] ??
            address['state'] ??
            address['country'];
        return city?.toString();
      }
    }
    return null;
  } catch (e) {
    log('Ошибка при получении названия города: $e');
    return null;
  }
}
