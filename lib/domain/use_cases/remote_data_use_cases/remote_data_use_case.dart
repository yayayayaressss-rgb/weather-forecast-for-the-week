import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../entities/meteo_enity/meteo_enity.dart';
import '../../failures/failure_interface.dart';
import '../../failures/network_failures.dart';
import '../../repositories_interface/remote_data_repo.dart';

class RemoteDataUseCase {
  final RemoteDataRepo aRepo;

  const RemoteDataUseCase({required this.aRepo});

  Future<Either<Failure, MeteoEntity>> getByName({
    required bool isMetric,
    required String q,
  }) async {
    if (q.isEmpty || q.length < 2) {
      return Left(
        ValidationFailure(
          message: 'Validation failure : нельзя сделать пустой запрос',
        ),
      );
    } else {
      final result = await aRepo.getRespByName(isMetric: isMetric, name: q);
      return result.fold(
        (l) {
          return Left(l);
        },
        (r) {
          _saveRemotedData(r);
          return Right(r);
        },
      );
    }
  }

  Future<Either<Failure, MeteoEntity>> getByGeo({
    required bool isMetric,
  }) async {
    try {
      final result = await aRepo.getRespByGeo(isMetric: isMetric);
      return await result.fold(
        (l) async {
          await aRepo.getPermission();
          return Left(l);
        },
        (r) async {
          _saveRemotedData(r);
          return Right(r);
        },
      );
    } catch (e) {
      aRepo.getPermission();
      return Left(UnknownFailure(message: e.toString(), statusCode: null));
    }
  }

  Future<void> _saveRemotedData(MeteoEntity data) async {
    log('save to cahce ${data.current.temperature}');
    aRepo.saveToCache(data);
  }
}
