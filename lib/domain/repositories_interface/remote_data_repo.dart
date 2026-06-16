import 'package:dartz/dartz.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import '../failures/failure_interface.dart';

abstract class RemoteDataRepo {
  Future<Either<Failure, MeteoEntity>> getRespByName({
    required bool isMetric,
    required String name,
  });

  Future<Either<Failure, MeteoEntity>> getRespByGeo({required bool isMetric});

  Future<bool> getPermission();

  Future<void> saveToCache(MeteoEntity data);
}
