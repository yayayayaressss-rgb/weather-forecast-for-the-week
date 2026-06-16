import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/domain/failures/cache_failure.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import 'package:forecast_app_pet_proj/domain/failures/network_failures.dart';
import '../../entities/meteo_enity/meteo_enity.dart';
import '../../repositories_interface/data_local_repo_inter.dart';

class LocalDataSourceUseCase {
  final DataLocalRepo aRepo;

  const LocalDataSourceUseCase({required this.aRepo});


  Future<Either<Failure, MeteoEntity>> loadFromCache({
    required String cityName,
  }) async {
    final Either<Failure, MeteoEntity> result;
    try {
      result = await aRepo.getFromCache(stringKey: cityName);
      return result.fold(
        (l) {
          return Left(CacheFailure(message: 'Ошибка чтения кэша'));
        },
        (r) {
          return Right(r);
        },
      );
    } catch (e) {
      return Left(
        UnknownFailure(
          message: 'Failed to load from cache: ${e.toString()}',
          statusCode: null,
        ),
      );
    }
  }
}
