import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/domain/repositories_interface/remote_data_repo.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/favorites_use_case/favorites_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data/mappers/weather_mapper_test.mocks.dart';
import '../../../data/repositories_data_impl/data_remote_repo_test.mocks.dart'
    hide MockMeteoEntity;

@GenerateMocks([RemoteDataRepo])
import 'favorites_use_case_test.mocks.dart';

void main() {
  late MockSharedPreferences sharedPreferences;
  late MockRemoteDataRepo mockRepo;
  late FavoritesUseCase useCase;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    mockRepo = MockRemoteDataRepo();

    useCase = FavoritesUseCase(
      dataRepo: mockRepo,
      sharedPreferences: sharedPreferences,
    );
  });

  final stringKey = 'favorite';
  final testedList = ['London', 'Moscow', 'Ural'];

  group('FavoritesUseCase group test', () {
    test('getFavoritesList foo test should return List<String>', () async {
      when(sharedPreferences.getStringList(stringKey)).thenReturn(testedList);
      final result = await useCase.getFavoritesList();
      expect(result, isNotEmpty);
      expect(result, isA<List<String>>());
    });

    test(
      'checkFavoriteOrNo foo test should return in first case true , in second case false',
      () async {
        final justes = 'Moscow';
        final unJustes = 'qiwubedfciubqiewcd';
        when(sharedPreferences.getStringList(stringKey)).thenReturn(testedList);
        final firstCase = await useCase.checkFavoriteOrNo(justes);
        final secondCase = await useCase.checkFavoriteOrNo(unJustes);
        expect(firstCase, true);
        expect(secondCase, false);
      },
    );

    test('addCityToFavorites foo test should return true', () async {
      final cityName = 'Moscow';
      when(sharedPreferences.getStringList(stringKey)).thenReturn([]);
      when(
        sharedPreferences.setStringList(stringKey, any),
      ).thenAnswer((_) async => true);

      await useCase.addCityToFavorites(cityName);

      verify(sharedPreferences.setStringList(stringKey, [cityName])).called(1);
    });
  });
}
