import 'package:dartz/dartz.dart';
import '../entities/meteo_enity/meteo_enity.dart';
import '../failures/failure_interface.dart';

abstract class DataLocalRepo {
  Future<Either<Failure, MeteoEntity>> getFromCache({
    required String stringKey,
  });

  Future<void> cleanCache();
}
