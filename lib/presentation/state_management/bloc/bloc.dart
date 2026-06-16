import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/failures/network_failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/states/states.dart';
import '../../../domain/failures/failure_interface.dart';
import '../../../domain/use_cases/local_data_use_case/local_data_source_use_case.dart';
import '../../../domain/use_cases/remote_data_use_cases/remote_data_use_case.dart';
import 'events/events.dart';

class MyBloc extends Bloc<EventW, StateW> {
  final LocalDataSourceUseCase _localDataSourceUseCase;
  final RemoteDataUseCase _remoteDataUseCase;
  final FavoritesUseCase _favoritesUseCase;
  final LocalDataSourceUseCase _localDataUseCase;
  final UnitsMapper _unitMapper;

  MyBloc({
    required LocalDataSourceUseCase localDataUseCase,
    required LocalDataSourceUseCase localDataSourceUseCase,
    required RemoteDataUseCase remoteDataUseCase,
    required FavoritesUseCase favoritesUseCase,
    required UnitsMapper unitMapper,
  }) : _unitMapper = unitMapper,
       _localDataSourceUseCase = localDataSourceUseCase,
       _remoteDataUseCase = remoteDataUseCase,
       _favoritesUseCase = favoritesUseCase,
       _localDataUseCase = localDataUseCase,
       super(const EmptyState()) {
    on<GetDataFromCache>(_getDataFromCache);
    on<GetByNameEvent>(_getByNameFoo);
    on<GetByGeoEvent>(_getByGeoFoo);
    on<ReadCache>(_getFromCacheFoo);
    on<GetAllFavoritesCityData>(_getAllFavoritesCityData);
  }

  /// helper foo ///
  Future<void> _emitResult(
    bool isMetric,
    Future<Either<Failure, MeteoEntity>> future,
    Emitter<StateW> emit,
  ) async {
    emit(const LoadingState());
    log(
      'remote data remote data remote data remote data remote data remote data remote data remote data ',
    );
    try {
      final result = await future;
      final bool favoritesIsEmpty = await _favoritesUseCase
          .getFavoritesList()
          .then((val) {
            return val.isEmpty;
          });
      result.fold((failure) => emit(FailureState(failure: failure)), (data) {
        if (!isMetric) {
          emit(
            LoadedSingle(
              data: _unitMapper.toImperial(data),
              favoritesIsEmpty: favoritesIsEmpty,
              isMetric: isMetric,
            ),
          );
        } else {
          emit(
            LoadedSingle(
              data: data,
              favoritesIsEmpty: favoritesIsEmpty,
              isMetric: isMetric,
            ),
          );
        }
      });
    } catch (e) {
      emit(
        FailureState(
          failure: UnknownFailure(
            message: 'Unknown error: ${e.toString()}',
            statusCode: null,
          ),
        ),
      );
    }
  }

  Future<void> _getAllFavoritesCityData(
    GetAllFavoritesCityData event,
    Emitter<StateW> emit,
  ) async {
    emit(const LoadingState());
    final List<String> favoritesCityNames = await _favoritesUseCase
        .getFavoritesList();
    final List<MeteoEntity> currentWeatherList = [];
    if (favoritesCityNames.isEmpty) {
      emit(EmptyState());
      return;
    }

    try {
      for (final cityName in favoritesCityNames) {
        final value = await _remoteDataUseCase.getByName(
          isMetric: event.isMetric,
          q: cityName,
        );
        value.fold((l) => emit(FailureState(failure: l)), (r) {
          if (!event.isMetric) {
            currentWeatherList.add(_unitMapper.toImperial(r));
          } else {
            currentWeatherList.add(r);
          }
        });
      }
      emit(
        LoadedAllFavoritesCityData(
          listCurrentData: currentWeatherList,
          isMetric: event.isMetric,
        ),
      );
      log(currentWeatherList.length.toString());
    } catch (e) {
      log('failure: $e');
      emit(
        FailureState(
          failure: UnknownFailure(
            message: e.runtimeType.toString(),
            statusCode: null,
          ),
        ),
      );
    }
  }

  Future<void> _getDataFromCache(
    GetDataFromCache event,
    Emitter<StateW> emit,
  ) async {
    emit(LoadingState());
    final List<MeteoEntity> currentWeatherListT = [];
    final listCityNames = await _favoritesUseCase.getFavoritesList();
    for (final city in listCityNames) {
      final result = await _localDataUseCase.loadFromCache(cityName: city);
      result.fold((l) => emit(FailureState(failure: l)), (r) {
        if (event.isMetric == false) {
          currentWeatherListT.add(_unitMapper.toImperial(r));
        } else {
          currentWeatherListT.add(r);
        }
      });
    }
    emit(
      LoadedAllFavoritesCityData(
        listCurrentData: currentWeatherListT,
        isMetric: event.isMetric,
      ),
    );
  }

  Future<void> _getByNameFoo(GetByNameEvent event, Emitter<StateW> emit) async {
    await _emitResult(
      event.isMetric,
      _remoteDataUseCase.getByName(isMetric: event.isMetric, q: event.params),
      emit,
    );
  }

  Future<void> _getByGeoFoo(GetByGeoEvent event, Emitter<StateW> emit) async {
    await _emitResult(
      event.isMetric,
      _remoteDataUseCase.getByGeo(isMetric: event.isMetric),
      emit,
    );
  }

  Future<void> _getFromCacheFoo(ReadCache event, Emitter<StateW> emit) async {
    await _emitResult(
      event.isMetric,
      _localDataSourceUseCase.loadFromCache(cityName: event.stringKey),
      emit,
    );
  }
}
