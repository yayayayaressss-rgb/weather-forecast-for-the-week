import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/data/repositories_data_impl/data_local_repo.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/hourly_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/domain/use_cases/get_data_to_bottom_card/get_to_bottom_card_use_case.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/bottom_card_change_cubit/change_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bottom_card_change_cubit_test.mocks.dart';

@GenerateMocks([DataLocalRepoIMPL, DailyWeather, HourlyWeather, MeteoEntity])
void main() {
  late MockDataLocalRepoIMPL mockDataLocalRepoIMPL;

  setUp(() {
    mockDataLocalRepoIMPL = MockDataLocalRepoIMPL();
  });

  group('BottomCardCubit testing group', () {
    final cityName = 'Moscow';
    final dailyMock = MockDailyWeather();
    final hourlyMock = MockHourlyWeather();
    final meteoEntityMock = MockMeteoEntity();

    when(meteoEntityMock.dailyForecast).thenReturn([dailyMock]);
    when(meteoEntityMock.hourlyForecast).thenReturn([hourlyMock]);

    blocTest<BottomCardCubit, ChangeStates>(
      'changeToDaily foo test',
      build: () {
        when(
          mockDataLocalRepoIMPL.getFromCache(stringKey: cityName),
        ).thenAnswer((_) async => Right(meteoEntityMock));

        final useCase = GetToBottomCardUseCase(aRepo: mockDataLocalRepoIMPL);
        return BottomCardCubit(useCase: useCase);
      },
      act: (cubit) =>
          cubit.changeToDaily(cityName: cityName, index: 0, isMetric: true),
      expect: () => [GetChangeToDaily(data: dailyMock)],
    );

    blocTest<BottomCardCubit, ChangeStates>(
      'changeToHourly foo test',
      build: () {
        when(
          mockDataLocalRepoIMPL.getFromCache(stringKey: cityName),
        ).thenAnswer((_) async => Right(meteoEntityMock));

        final useCase = GetToBottomCardUseCase(aRepo: mockDataLocalRepoIMPL);
        return BottomCardCubit(useCase: useCase);
      },
      act: (cubit) =>
          cubit.changeToHourly(cityName: cityName, index: 0, isMetric: true),
      expect: () => [GetChangeToHourly(data: hourlyMock)],
    );
  });
}
