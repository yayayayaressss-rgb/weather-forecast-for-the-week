import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/favorite_repo.dart';
import 'package:forecast_app_pet_proj/domain/repositories_interface/favorite_repo_inter.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/favorite_cubit/favorite_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavoriteRepoIMPL>()])
void main() {
  late MockFavoriteRepoIMPL mockRepo;
  late FavoritesUseCase useCase;

  const testCity = 'Moscow';
  final testFavoritesList = ['Moscow', 'Ural', 'London'];

  setUp(() {
    mockRepo = MockFavoriteRepoIMPL();
    useCase = FavoritesUseCase(aRepo: mockRepo);
  });

  group('FavoriteCubit', () {
    blocTest<FavoriteCubit, FavoriteStates>(
      'initial state should be UnFavorite(false)',
      build: () => FavoriteCubit(useCase: useCase),
      expect: () => [],
    );

    blocTest<FavoriteCubit, FavoriteStates>(
      'addToFavorite emits Favorite(true)',
      build: () {
        when(mockRepo.addCityToFavorites(testCity)).thenAnswer((_) async => {});
        when(
          mockRepo.checkFavoriteOrNo(testCity),
        ).thenAnswer((_) async => true);
        return FavoriteCubit(useCase: useCase);
      },
      act: (cubit) => cubit.addToFavorite(cityName: testCity),
      expect: () => [
        isA<Favorite>().having((state) => state.favorite, 'favorite', true),
      ],
      verify: (_) {
        verify(mockRepo.addCityToFavorites(testCity)).called(1);
      },
    );

    blocTest<FavoriteCubit, FavoriteStates>(
      'deleteFromFavorite emits UnFavorite(false) then GetListFavorites',
      build: () {
        when(
          mockRepo.deleteFromFavorites(testCity),
        ).thenAnswer((_) async => {});
        when(mockRepo.getFavoritesList()).thenAnswer((_) async => []);
        return FavoriteCubit(useCase: useCase);
      },
      act: (cubit) => cubit.deleteFromFavorite(cityName: testCity),
      expect: () => [
        isA<UnFavorite>().having((state) => state.favorite, 'favorite', false),
        isA<GetListFavorites>().having(
          (state) => state.favoritesList,
          'favoritesList',
          [],
        ),
      ],
      verify: (_) {
        verify(mockRepo.deleteFromFavorites(testCity)).called(1);
        verify(mockRepo.getFavoritesList()).called(1);
      },
    );

    blocTest<FavoriteCubit, FavoriteStates>(
      'getFavoritesList emits GetListFavorites with list',
      build: () {
        when(
          mockRepo.getFavoritesList(),
        ).thenAnswer((_) async => testFavoritesList);
        return FavoriteCubit(useCase: useCase);
      },
      act: (cubit) => cubit.getFavoritesList(),
      expect: () => [
        isA<GetListFavorites>().having(
          (state) => state.favoritesList,
          'favoritesList',
          testFavoritesList,
        ),
      ],
    );

    blocTest<FavoriteCubit, FavoriteStates>(
      'checkFavoriteStatus emits Favorite(true) when city exists',
      build: () {
        when(
          mockRepo.checkFavoriteOrNo(testCity),
        ).thenAnswer((_) async => true);
        return FavoriteCubit(useCase: useCase);
      },
      act: (cubit) => cubit.checkFavoriteStatus(cityName: testCity),
      expect: () => [
        isA<Favorite>().having((state) => state.favorite, 'favorite', true),
      ],
    );

    blocTest<FavoriteCubit, FavoriteStates>(
      'checkFavoriteStatus emits UnFavorite(false) when city not exists',
      build: () {
        when(
          mockRepo.checkFavoriteOrNo('UnknownCity'),
        ).thenAnswer((_) async => false);
        return FavoriteCubit(useCase: useCase);
      },
      act: (cubit) => cubit.checkFavoriteStatus(cityName: 'UnknownCity'),
      expect: () => [
        isA<UnFavorite>().having((state) => state.favorite, 'favorite', false),
      ],
    );
  });
}
