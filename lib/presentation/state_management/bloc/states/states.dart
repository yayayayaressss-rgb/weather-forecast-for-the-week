import 'package:equatable/equatable.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/failures/failure_interface.dart';

sealed class StateW extends Equatable {
  const StateW();
}

final class EmptyState extends StateW {
  const EmptyState();

  @override
  List<Object?> get props => [];
}

final class LoadingState extends StateW {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

final class LoadedSingle extends StateW {
  final bool isMetric;
  final bool favoritesIsEmpty;
  final MeteoEntity data;

  const LoadedSingle({
    required this.data,
    required this.favoritesIsEmpty,
    required this.isMetric,
  });

  @override
  List<Object?> get props => [favoritesIsEmpty, isMetric, data];
}

final class FailureState extends StateW {
  final Failure failure;

  const FailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

final class LoadedAllFavoritesCityData extends StateW {
  final bool isMetric;
  final List<MeteoEntity> listCurrentData;

  const LoadedAllFavoritesCityData({
    required this.listCurrentData,
    required this.isMetric,
  });

  @override
  List<Object?> get props => [listCurrentData];
}

final class LoadedDataFromCache extends StateW {
  final bool isMetric;
  final List<MeteoEntity> listCurrentData;

  const LoadedDataFromCache({
    required this.isMetric,
    required this.listCurrentData,
  });

  @override
  List<Object?> get props => [isMetric, listCurrentData];
}
