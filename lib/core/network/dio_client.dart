import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:forecast_app_pet_proj/core/network/remote_params.dart';
import 'package:forecast_app_pet_proj/core/network/util/constants_api_open_meteo.dart';
import 'get_geoparams_by_name.dart';
import 'get_name_from_geo.dart';

class DioClient {
  final Dio dioClient;

  DioClient({required this.dioClient}) {
    dioClient.options = BaseOptions(
      sendTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      baseUrl: ConstantsApiOpenMeteo.BASE_URL,
    );
  }

  Future<Map<String, dynamic>?> getForecastRowData({
    required Params param,
  }) async {
    try {
      Map<String, dynamic> queryParams;
      ParamsGeo? correctParams;
      String cityName = '';
      if (param is ParamsName) {
        cityName = param.name;
        correctParams = await getCoordinatesByCityName(
          dioClient: dioClient,
          params: param,
        );
        if (correctParams == null) {
          return null;
        }
      }
      if (param is ParamsGeo) {
        cityName =
            await getCityNameByCoordinates(
              params: param,
              dioClient: dioClient,
            ) ??
            '';
        correctParams = param;
      }
      queryParams = {
        'latitude': correctParams?.lat.toString() ?? 0.0.toString(),
        'longitude': correctParams?.lon.toString() ?? 0.0.toString(),
        'current':
            'temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,rain,showers,snowfall,weather_code,cloud_cover,pressure_msl,wind_speed_10m,wind_direction_10m,wind_gusts_10m',
        'hourly': 'temperature_2m,precipitation_probability,rain,weather_code',
        'daily':
            'weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset',
        'timezone': 'auto',
        'forecast_days': '7',
      };
      return await _getResponse(q: queryParams, cityName: cityName);
    } on DioException catch (e) {
      log(e.message ?? 'неизвестная ошибка ');
    } catch (e) {
      log(e.toString());
    }
    return {};
  }

  Future<Map<String, dynamic>> _getResponse({
    required Map<String, dynamic> q,
    required String cityName,
  }) async {
    final response = await dioClient.get(
      '',
      queryParameters: q,
      options: Options(responseType: ResponseType.json),
    );
    if (response.statusCode == 200) {
      if (response.data is String) {
        final tempData = jsonDecode(response.data);
        tempData['cityName'] = cityName;
        log(tempData.toString());
        return tempData;
      }

      if (response.data is Map<String, dynamic>) {
        response.data['cityName'] = cityName;
        return response.data;
      }
    }
    ('Ошибка API: ${response.statusCode}');
    return {};
  }
}
