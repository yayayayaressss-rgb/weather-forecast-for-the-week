import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/core/network/dio_client.dart';
import 'package:forecast_app_pet_proj/core/services/geo/geo_location_service.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/repositories_interface/remote_data_repo.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/local_data_use_case/local_data_source_use_case.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/remote_data_use_cases/remote_data_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/events/events.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/states/states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  LocalDataSourceUseCase,
  RemoteDataUseCase,
  GeoLocationService,
  DioClient,
  RemoteDataRepo,
  FavoritesUseCase,
  MeteoEntity,
])
import 'bloc_test.mocks.dart';

void main() {
  late MyBloc bloc;
  late MockLocalDataSourceUseCase mockLocalDataSourceUseCase;
  late MockRemoteDataUseCase mockRemoteDataUseCase;
  late MockFavoritesUseCase mockFavoritesUseCase;

  setUp(() {
    mockLocalDataSourceUseCase = MockLocalDataSourceUseCase();
    mockRemoteDataUseCase = MockRemoteDataUseCase();
    mockFavoritesUseCase = MockFavoritesUseCase();
    bloc = MyBloc(
      localDataSourceUseCase: mockLocalDataSourceUseCase,
      remoteDataUseCase: mockRemoteDataUseCase,
      favoritesUseCase: mockFavoritesUseCase,
      localDataUseCase: mockLocalDataSourceUseCase,
      unitMapper: UnitsMapper(),
    );
  });
  group('MyBloc testing group', () {
    final cityName = 'Moscow';
    final mockMeteoEntity = MockMeteoEntity();
    blocTest<MyBloc, StateW>(
      'GetByNameEvent event',
      build: () {
        when(
          mockFavoritesUseCase.getFavoritesList(),
        ).thenAnswer((_) async => []);
        when(
          mockRemoteDataUseCase.getByName(isMetric: true, q: cityName),
        ).thenAnswer((_) async => Right(mockMeteoEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(GetByNameEvent(params: cityName, isMetric: true)),
      expect: () => [
        LoadingState(),
        LoadedSingle(
          favoritesIsEmpty: true,
          data: mockMeteoEntity,
          isMetric: true,
        ),
      ],
    );
    blocTest<MyBloc, StateW>(
      'GetByGeoEvent event ',
      build: () {
        when(
          mockFavoritesUseCase.getFavoritesList(),
        ).thenAnswer((_) async => ['asdf']);
        when(
          mockRemoteDataUseCase.getByGeo(isMetric: true),
        ).thenAnswer((_) async => Right(mockMeteoEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(GetByGeoEvent(isMetric: true)),
      expect: () => [
        LoadingState(),
        LoadedSingle(
          favoritesIsEmpty: false,
          data: mockMeteoEntity,
          isMetric: true,
        ),
      ],
    );
    blocTest<MyBloc, StateW>(
      'ReadCache event ',
      build: () {
        when(
          mockFavoritesUseCase.getFavoritesList(),
        ).thenAnswer((_) async => []);
        when(
          mockLocalDataSourceUseCase.loadFromCache(cityName: cityName),
        ).thenAnswer((_) async => Right(mockMeteoEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(ReadCache(stringKey: cityName, isMetric: true)),
      expect: () => [
        LoadingState(),
        LoadedSingle(
          data: mockMeteoEntity,
          favoritesIsEmpty: true,
          isMetric: true,
        ),
      ],
    );
    blocTest<MyBloc, StateW>(
      'GetAllFavoritesCityData event ',
      build: () {
        when(
          mockFavoritesUseCase.getFavoritesList(),
        ).thenAnswer((_) async => [cityName]);
        when(
          mockRemoteDataUseCase.getByName(isMetric: true, q: cityName),
        ).thenAnswer((_) async => Right(mockMeteoEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(GetAllFavoritesCityData(isMetric: true)),
      expect: () => [
        LoadingState(),
        LoadedAllFavoritesCityData(
          listCurrentData: [mockMeteoEntity],
          isMetric: true,
        ),
      ],
    );
  });
}
