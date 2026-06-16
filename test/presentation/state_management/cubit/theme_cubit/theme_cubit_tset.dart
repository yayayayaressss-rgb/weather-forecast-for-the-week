import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_states.dart';

void main() {
  group('ThemeCubit', () {
    test('initial state should be ThemeStateLight', () {
      final cubit = ThemeCubit();

      expect(cubit.state, isA<ThemeStateLight>());
    });

    blocTest<ThemeCubit, ThemeState>(
      'changeTheme should switch from light to dark',
      build: () => ThemeCubit(),
      act: (cubit) => cubit.changeTheme(),
      expect: () => [isA<ThemeStateDark>()],
    );

    blocTest<ThemeCubit, ThemeState>(
      'changeTheme should switch from dark to light',
      build: () => ThemeCubit()..changeTheme(),
      act: (cubit) => cubit.changeTheme(),
      expect: () => [isA<ThemeStateLight>()],
    );
  });
}
