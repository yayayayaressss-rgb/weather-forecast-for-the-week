import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import '../../../../../custom_buttons/top_card_buttons/extended_information_txt_button/extended_information_txt_button.dart';
import '../../../../../custom_buttons/top_card_buttons/favorite_icon_button/favorite_icon_button.dart';
import '../units/city_name.dart';
import '../units/date_time_unit.dart';
import '../units/temp_info.dart';
import '../units/trailing_icon.dart';
import 'extended_information_card.dart';

class CurrentInfo extends StatelessWidget {
  final VoidCallback removeLogicAction;
  final VoidCallback action;
  final MeteoEntity data;
  final bool flag;

  const CurrentInfo({
    super.key,
    required this.removeLogicAction,
    required this.data,
    required this.flag,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isMetric = context.watch<MetricCubit>().state.isMetric;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _firstRow(
          context: context,
          data: data.current,
          removeLogicAction: () {
            removeLogicAction();
          },
        ),
        _secondRow(context: context, data: data, isMetric: isMetric),
        extendedInfoCard(
          context: context,
          flag: flag,
          data: data.current,
          isMetric: isMetric,
        ),
        ExtendedInformationButton(
          flag: flag,
          action: () {
            action();
          },
        ),
      ],
    );
  }
}

Widget _firstRow({
  required BuildContext context,
  required CurrentWeather data,
  required VoidCallback removeLogicAction,
}) {
  return Row(
    children: [
      currentDate(context, data),
      FavoriteIconButton(
        cityName: data.cityName,
        removeLogicAction: () {
          removeLogicAction();
        },
      ),
    ],
  );
}

Widget _secondRow({
  required bool isMetric,
  required BuildContext context,
  required MeteoEntity data,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TempInfo(data: data, isMetric: isMetric),
      cityName(context, data.current),
      showIcon(data.current),
    ],
  );
}
