import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/common/app_theme/colors_second.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/bloc.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/bloc/events/events.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_cubit.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/theme_cubit/theme_states.dart';

import '../../../../common/app_theme/colors_first.dart';

class SwitchAppTheme extends StatelessWidget {
  final VoidCallback action;

  const SwitchAppTheme({super.key, required this.action});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        bool flag = false;
        final isMetric = context.watch<MetricCubit>().state.isMetric;
        if (state is ThemeStateDark) flag = false;
        if (state is ThemeStateLight) flag = true;
        return Switch(
          value: flag,
          onChanged: (value) {
            log('!!!!!!!!!!!!!!!');
            flag = !flag;
            action();
            context.read<MyBloc>().add(
              GetAllFavoritesCityData(isMetric: isMetric),
            );
          },
          activeColor: ColorSystem.COLOR_APPBAR,
          inactiveThumbColor: ColorSystemForestRain.COLOR_APPBAR,
          inactiveTrackColor: ColorSystem.COLOR_APPBAR,
        );
      },
    );
  }
}
