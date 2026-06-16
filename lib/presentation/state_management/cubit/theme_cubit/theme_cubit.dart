import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_states.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeStateLight());

  void changeTheme() {
    if (state is ThemeStateLight) {
      log('  void changeTheme()  state is ThemeStateLight ');
      emit(ThemeStateDark());
    } else {
      log('  void changeTheme()  state is ELSE ');
      emit(ThemeStateLight());
    }
  }
}
