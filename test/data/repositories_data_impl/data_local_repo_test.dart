import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/mappers/weather_mapper.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/failures/cache_failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_local_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_local_repo_test.mocks.dart';

@GenerateMocks([SharedPreferences])
import 'data_local_repo_test.mocks.dart';

void main() {
  final mapper = MeteoMapper();
  final jsonPrefsMock = File(
    'test/data/repositories_data_impl/jsonPrefsMock.json',
  ).readAsStringSync();
  test(
    'testing DataLocalRepoIMPL getFromCache foo  should return MeteoEntity',
    () async {
      final mock = MockSharedPreferences();
      final repo = DataLocalRepoIMPL(shared: mock, mapper: mapper);

      when(mock.getString('London')).thenReturn(jsonPrefsMock);

      final result = await repo.getFromCache(stringKey: 'London');
      result.fold(
        (l) {
          fail('wrong answer');
        },
        (r) {
          expect(r, isA<MeteoEntity>());
        },
      );
    },
  );

  test('cleanCache calls clear', () async {
    final mock = MockSharedPreferences();
    final repo = DataLocalRepoIMPL(shared: mock, mapper: mapper);

    when(mock.clear()).thenAnswer((_) async => true);

    await repo.cleanCache();

    verify(mock.clear()).called(1);
  });
}
