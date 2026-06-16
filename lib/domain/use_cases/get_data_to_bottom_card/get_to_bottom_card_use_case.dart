import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import '../../entities/meteo_enity/daily_weather.dart';
import '../../entities/meteo_enity/hourly_weather.dart';
import '../../repositories_interface/data_local_repo_inter.dart';

class GetToBottomCardUseCase {
  final DataLocalRepo aRepo;

  const GetToBottomCardUseCase({required this.aRepo});

  Future<Either<Failure, HourlyWeather>> getHourlyWeatherItem({
    required String cityName,
    required int index,
  }) async {
    final rowData = await aRepo.getFromCache(stringKey: cityName);
    return rowData.fold(
      (l) {
        log(l.message);
        return Left(l);
      },
      (r) {
        final result = r.hourlyForecast[index];
        return Right(result);
      },
    );
  }

  Future<Either<Failure, DailyWeather>> getDailyWeatherItem({
    required String cityName,
    required int index,
    required bool isMetric,
  }) async {
    final rowData = await aRepo.getFromCache(stringKey: cityName);
    return rowData.fold(
      (l) {
        log(l.message);
        return Left(l);
      },
      (r) {
        final result = r.dailyForecast[index];
        return Right(result);
      },
    );
  }
}
