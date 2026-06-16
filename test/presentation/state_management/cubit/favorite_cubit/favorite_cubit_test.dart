import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_remote_repo.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../data/repositories_data_impl/data_local_repo_test.mocks.dart';

@GenerateMocks([DataRemoteRepoIMPL])
import 'favorite_cubit_test.mocks.dart';

void main() {
  late MockDataRemoteRepoIMPL repo;
  late MockSharedPreferences sharedPreferences;
  setUp(() {
    repo = MockDataRemoteRepoIMPL();
    sharedPreferences = MockSharedPreferences();
  });
  group('FavoriteCubit testing group', () {
    final cityName = 'Moscow';
    final stringKey = 'favorite';
    blocTest(
      'getFavoritesList foo test ',
      build: () {
        when(sharedPreferences.getStringList(stringKey)).thenReturn([cityName]);
        return FavoriteCubit(
          useCase: FavoritesUseCase(
            dataRepo: repo,
            sharedPreferences: sharedPreferences,
          ),
        );
      },
      act: (cubit) => cubit.getFavoritesList(),
      expect: () => [
        GetListFavorites(favoritesList: ['Moscow'], favorite: true),
      ],
    );
    blocTest(
      'checkFavoriteStatus foo test ',
      build: () {
        when(sharedPreferences.getStringList(stringKey)).thenReturn([cityName]);
        return FavoriteCubit(
          useCase: FavoritesUseCase(
            dataRepo: repo,
            sharedPreferences: sharedPreferences,
          ),
        );
      },
      act: (cubit) => cubit.checkFavoriteStatus(cityName: cityName),
      expect: () => [Favorite(favorite: true)],
    );
    blocTest(
      'deleteFromFavorite foo test',
      build: () {
        final localTestList = ['Moscow', 'Ural'];
        when(
          sharedPreferences.getStringList(stringKey),
        ).thenReturn(localTestList);
        return FavoriteCubit(
          useCase: FavoritesUseCase(
            dataRepo: repo,
            sharedPreferences: sharedPreferences,
          ),
        );
      },

      act: (cubit) => cubit.deleteFromFavorite(cityName: cityName),
      expect: () => [
        UnFavorite(favorite: false),
        GetListFavorites(favorite: true),
      ],
    );
    blocTest(
      'addToFavorite foo test',
      build: () {
        when(sharedPreferences.getStringList(stringKey)).thenReturn([cityName]);
        return FavoriteCubit(
          useCase: FavoritesUseCase(
            dataRepo: repo,
            sharedPreferences: sharedPreferences,
          ),
        );
      },
      act: (cubit) => cubit.addToFavorite(cityName: cityName),
      expect: () => [Favorite(favorite: true)],
    );
  });
}
