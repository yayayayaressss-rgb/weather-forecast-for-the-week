import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/app_theme/colors_second.dart';
import '../../../state_management/bloc/bloc.dart';
import '../../../state_management/bloc/events/events.dart';
import '../../custom_buttons/search_bar_action_button/search_Icon/search_icon.dart';
import 'bar_units/enabled_border.dart';
import 'bar_units/error_border.dart';
import 'bar_units/focused_border.dart';
import 'bar_units/focused_error_border.dart';

InputDecoration barDecor({
  required TextEditingController txtController,
  required BuildContext context,
  required VoidCallback action,
  required bool isMetric,
}) {
  return InputDecoration(
    prefixIcon: searchIcon(() {
      final query = txtController.text.trim();
      if (query.isNotEmpty && query.length >= 2) {
        txtController.text = '';
        context.read<MyBloc>().add(GetByNameEvent(params: query, isMetric: isMetric));
      }
      action();
    }),
    filled: true,
    fillColor: ColorSystemForestRain.COLOR_SURFACE,
    hintText: 'Поиск...',
    enabledBorder: enabledBorder(context),
    focusedBorder: focusedBorder(context),
    focusedErrorBorder: focusedErrorBorder(context),
    errorBorder: errorBorder(context),
  );
}
