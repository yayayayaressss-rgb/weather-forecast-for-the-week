import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/favorite_repo.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorites_use_case_test.mocks.dart';

@GenerateMocks([FavoriteRepoIMPL])
void main() {
  late MockFavoriteRepoIMPL mockRepo;
  late FavoritesUseCase useCase;

  const testCity = 'Moscow';
  const testCity2 = 'London';
  final testFavoritesList = ['London', 'Moscow', 'Ural'];

  setUp(() {
    mockRepo = MockFavoriteRepoIMPL();
    useCase = FavoritesUseCase(aRepo: mockRepo);
  });

  group('FavoritesUseCase', () {
    test('getFavoritesList should return list of favorite cities', () async {
      when(
        mockRepo.getFavoritesList(),
      ).thenAnswer((_) async => testFavoritesList);

      final result = await useCase.getFavoritesList();

      expect(result, isNotEmpty);
      expect(result, equals(testFavoritesList));
      expect(result, isA<List<String>>());
      verify(mockRepo.getFavoritesList()).called(1);
    });

    test(
      'checkFavoriteOrNo should return true when city is in favorites',
      () async {
        when(
          mockRepo.checkFavoriteOrNo(testCity),
        ).thenAnswer((_) async => true);

        final result = await useCase.checkFavoriteOrNo(testCity);

        expect(result, true);
        verify(mockRepo.checkFavoriteOrNo(testCity)).called(1);
      },
    );

    test(
      'checkFavoriteOrNo should return false when city is not in favorites',
      () async {
        final unknownCity = 'qiwubedfciubqiewcd';
        when(
          mockRepo.checkFavoriteOrNo(unknownCity),
        ).thenAnswer((_) async => false);

        final result = await useCase.checkFavoriteOrNo(unknownCity);

        expect(result, false);
        verify(mockRepo.checkFavoriteOrNo(unknownCity)).called(1);
      },
    );

    test('addCityToFavorites should call repository add method', () async {
      when(
        mockRepo.addCityToFavorites(testCity),
      ).thenAnswer((_) async => Future.value());

      await useCase.addCityToFavorites(testCity);

      verify(mockRepo.addCityToFavorites(testCity)).called(1);
    });

    test('deleteFromFavorites should call repository delete method', () async {
      when(
        mockRepo.deleteFromFavorites(testCity),
      ).thenAnswer((_) async => Future.value());

      await useCase.deleteFromFavorites(testCity);

      verify(mockRepo.deleteFromFavorites(testCity)).called(1);
    });

    test(
      'getFavoritesList should return empty list when repository returns empty',
      () async {
        when(mockRepo.getFavoritesList()).thenAnswer((_) async => []);

        final result = await useCase.getFavoritesList();

        expect(result, isEmpty);
        expect(result, isA<List<String>>());
        verify(mockRepo.getFavoritesList()).called(1);
      },
    );
  });
}
