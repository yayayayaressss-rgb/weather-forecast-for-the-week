import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/domain/failures/cache_failure.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/meteo_enity/meteo_enity.dart';
import '../../domain/repositories_interface/data_local_repo_inter.dart';

class DataLocalRepoIMPL implements DataLocalRepo {
  final SharedPreferences _shared;
  final MeteoMapper _mapper;

  DataLocalRepoIMPL({
    required MeteoMapper mapper,
    required SharedPreferences shared,
  }) : _shared = shared,
       _mapper = mapper;

  @override
  Future<Either<Failure, MeteoEntity>> getFromCache({
    required String stringKey,
  }) async {
    log('read cache');
    try {
      final rawData = _shared.getString(stringKey) ?? '';

      if (rawData.isEmpty) {
        return Left(CacheFailure(message: 'Кэш пуст'));
      }

      final answer = _mapper.fromJson(jsonDecode(rawData));
      return Right(answer);
    } catch (e) {
      return Left(
        CacheFailure(message: 'Ошибка при чтении кэша: ${e.toString()}'),
      );
    }
  }

  @override
  Future<void> cleanCache() async {
    _shared.clear();
  }
}
