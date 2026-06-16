import 'package:equatable/equatable.dart';

sealed class EventW extends Equatable {
  const EventW();
}

final class GetByNameEvent extends EventW {
  final bool isMetric;
  final String params;

  const GetByNameEvent({required this.params, required this.isMetric});

  @override
  List<Object?> get props => [params, isMetric];
}

final class GetByGeoEvent extends EventW {
  final bool isMetric;

  const GetByGeoEvent({required this.isMetric});

  @override
  List<Object?> get props => [isMetric];
}

final class ReadCache extends EventW {
  final bool isMetric;
  final String stringKey;

  const ReadCache({required this.stringKey, required this.isMetric});

  @override
  List<Object?> get props => [stringKey, isMetric];
}

final class CleanCacheEvent extends EventW {
  @override
  List<Object?> get props => [];
}

final class AddToFavorites extends EventW {
  final String cityName;

  const AddToFavorites({required this.cityName});

  @override
  List<Object?> get props => [];
}

final class GetAllFavoritesCityData extends EventW {
  final bool isMetric;

  const GetAllFavoritesCityData({required this.isMetric});

  @override
  List<Object?> get props => [isMetric];
}

final class GetDataFromCache extends EventW {
  final bool isMetric;

  const GetDataFromCache({required this.isMetric});

  @override
  List<Object?> get props => [isMetric];
}

///// for tests

final class TesterEventMock extends EventW {
  @override
  List<Object?> get props => [];
}
