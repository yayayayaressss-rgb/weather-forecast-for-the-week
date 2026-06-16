import 'package:equatable/equatable.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';
import '../../../../domain/entities/meteo_enity/daily_weather.dart';
import '../../../../domain/entities/meteo_enity/hourly_weather.dart';

sealed class ChangeStates extends Equatable {
  const ChangeStates();
}

final class EmptyChangeState extends ChangeStates {
  const EmptyChangeState();

  @override
  List<Object?> get props => [];
}

final class GetChangeToDaily extends ChangeStates {
  final DailyWeather data;

  const GetChangeToDaily({required this.data});

  @override
  List<Object?> get props => [data];
}

final class FailureChangeState extends ChangeStates {
  final Failure data;

  const FailureChangeState({required this.data});

  @override
  List<Object?> get props => [data];
}

final class GetChangeToHourly extends ChangeStates {
  final HourlyWeather data;

  const GetChangeToHourly({required this.data});

  @override
  List<Object?> get props => [data];
}
