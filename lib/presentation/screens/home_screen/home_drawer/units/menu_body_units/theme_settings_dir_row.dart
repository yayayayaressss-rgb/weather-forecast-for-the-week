import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_cubit.dart';
import '../../../../../custom_widgets/switches/switch_app_theme/switch_app_theme.dart';
import 'unit_interface.dart';

ListTile theme({required BuildContext context}) {
  const String txt = 'Сменить тему ';
  return tileUnitInterface(
    context: context,
    title: txt,
    icon: SwitchAppTheme(
      action: () {
        context.read<ThemeCubit>().changeTheme();
      },
    ),
    action: () {
      context.read<ThemeCubit>().changeTheme();
    },
  );
}
