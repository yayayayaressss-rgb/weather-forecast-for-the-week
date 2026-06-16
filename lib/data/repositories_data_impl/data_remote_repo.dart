import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:forecast_app_pet_proj/core/network/dio_client.dart';
import 'package:forecast_app_pet_proj/core/services/geo/geo_location_service.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/network/remote_params.dart';
import '../../domain/failures/failure_interface.dart';
import '../../domain/failures/parsing_failure.dart';
import '../../domain/repositories_interface/remote_data_repo.dart';
import '../mappers/failure_mapper.dart';
import '../mappers/weather_mapper.dart';

class DataRemoteRepoIMPL implements RemoteDataRepo {
  final MeteoMapper _mapper;
  final GeoLocationService _geoService;
  final DioClient _dioClient;
  final SharedPreferences _sharedPreferences;

  DataRemoteRepoIMPL({
    required MeteoMapper mapper,
    required DioClient dioClient,
    required GeoLocationService geoService,
    required SharedPreferences sharedPreferences,
  }) : _mapper = mapper,
       _geoService = geoService,
       _dioClient = dioClient,
       _sharedPreferences = sharedPreferences;

  @override
  Future<Either<Failure, MeteoEntity>> getRespByName({
    required bool isMetric,
    required String name,
  }) async {
    final params = ParamsName(name: name);
    return _remoteData(params: params, client: _dioClient, isMetric: isMetric);
  }

  @override
  Future<Either<Failure, MeteoEntity>> getRespByGeo({
    required bool isMetric,
  }) async {
    final pos = await _geoService.getCurrentPosition();
    final params = ParamsGeo(lat: pos.latitude, lon: pos.longitude);
    return _remoteData(params: params, client: _dioClient, isMetric: isMetric);
  }

  Future<Either<Failure, MeteoEntity>> _remoteData({
    required DioClient client,
    required Params params,
    required bool isMetric,
  }) async {
    MeteoEntity result;
    try {
      final mapper = UnitsMapper();
      final rawData = await client.getForecastRowData(param: params);
      result = _mapper.fromApiToEntity(rawData);
      saveToCache(result);
      return Right(result);
    } on DioException catch (e) {
      return Left(FailureMapper.fromDioError(e));
    } catch (e) {
      return Left(
        ParsingFailure(message: 'Неожиданная ошибка: ${e.toString()}'),
      );
    }
  }

  @override
  Future<bool> getPermission() async {
    final permission = await _geoService.checkPermission();

    if (permission == LocationPermission.denied) {
      final requested = await _geoService.requestPermission();
      return requested == LocationPermission.always ||
          requested == LocationPermission.whileInUse;
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<void> saveToCache(MeteoEntity data) async {
    await _sharedPreferences.setString(
      data.cityName,
      jsonEncode(_mapper.toJson(data)),
    );
  }
}
