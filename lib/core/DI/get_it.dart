import 'package:dio/dio.dart';
import 'package:forecast_app_pet_proj/core/network/dio_client.dart';
import 'package:forecast_app_pet_proj/core/services/geo/geo_location_service.dart';
import 'package:forecast_app_pet_proj/data/mappers/units_mapepr.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/favorite_repo.dart';
import 'package:forecast_app_pet_proj/domain/repositories_interface/data_local_repo_inter.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/get_data_to_bottom_card/get_to_bottom_card_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/mappers/weather_mapper.dart';
import '../../data/repositories_data_impl/data_local_repo.dart';
import '../../data/repositories_data_impl/data_remote_repo.dart';
import '../../domain/repositories_interface/favorite_repo_inter.dart';
import '../../domain/repositories_interface/remote_data_repo.dart';
import '../../domain/use_cases/local_data_use_case/local_data_source_use_case.dart';
import '../../domain/use_cases/remote_data_use_cases/remote_data_use_case.dart';
import '../../presentation/state_management/bloc/bloc.dart';
import '../../presentation/state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import '../../presentation/state_management/cubit/network_check_cub/network_cubit.dart';
import '../services/network_checker/network_checker_serv.dart';

final getIt = GetIt.instance;

Future<void> getStart() async {
  /// cache source ///
  final sharedPreferences = await SharedPreferences.getInstance();

  /// external dependencies || services ///
  getIt.registerLazySingleton<GeoLocationService>(() => GeoLocationService());
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  getIt.registerLazySingleton<NetworkCheckerServ>(
    () => NetworkCheckerServ(serv: getIt()),
  );
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(dioClient: getIt()));

  /// mappers ///
  getIt.registerLazySingleton<MeteoMapper>(() => MeteoMapper());
  getIt.registerLazySingleton<UnitsMapper>(() => UnitsMapper());

  /// REPO ///
  getIt.registerLazySingleton<DataLocalRepo>(
    () => DataLocalRepoIMPL(mapper: getIt(), shared: getIt()),
  );
  getIt.registerLazySingleton<RemoteDataRepo>(
    () => DataRemoteRepoIMPL(
      dioClient: getIt(),
      geoService: getIt(),
      sharedPreferences: sharedPreferences,
      mapper: getIt(),
    ),
  );
  getIt.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoIMPL(sharedPreferences: sharedPreferences),
  );

  /// use cases ///
  getIt.registerFactory<FavoritesUseCase>(
    () => FavoritesUseCase(aRepo: getIt()),
  );
  getIt.registerFactory<GetToBottomCardUseCase>(
    () => GetToBottomCardUseCase(aRepo: getIt()),
  );
  getIt.registerFactory<LocalDataSourceUseCase>(
    () => LocalDataSourceUseCase(aRepo: getIt()),
  );
  getIt.registerFactory<RemoteDataUseCase>(
    () => RemoteDataUseCase(aRepo: getIt()),
  );

  /// Cubit ///
  getIt.registerFactory<FavoriteCubit>(() => FavoriteCubit(useCase: getIt()));
  getIt.registerFactory<BottomCardCubit>(
    () => BottomCardCubit(useCase: getIt()),
  );
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<NetworkCubit>(
    () => NetworkCubit(netWorkCheckService: getIt()),
  );

  /// BLoC ///
  getIt.registerFactory<MyBloc>(
    () => MyBloc(
      localDataSourceUseCase: getIt(),
      remoteDataUseCase: getIt(),
      favoritesUseCase: getIt(),
      localDataUseCase: getIt(),
      unitMapper: getIt(),
    ),
  );
}
