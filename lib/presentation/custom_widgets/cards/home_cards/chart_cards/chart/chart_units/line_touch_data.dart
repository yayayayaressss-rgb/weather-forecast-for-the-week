import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../state_management/cubit/bottom_card_change_cubit/bottom_card_change_cubit.dart';

LineTouchData lineTouchData({
  required bool flag,
  required BuildContext context,
  required List<String> time,
  required String cityName,
  required bool isMetric,
}) {
  return LineTouchData(
    enabled: true,
    touchTooltipData: LineTouchTooltipData(
      fitInsideHorizontally: true,
      fitInsideVertically: true,
      getTooltipItems: (touchedSpots) {
        return touchedSpots.map((spot) {
          final hour = spot.x.toInt();
          final temperature = spot.y;
          final timeHourlyString = hour < time.length
              ? '${time[hour]}${_hourOrDay(flag)}'
              : '$hour${_hourOrDay(flag)}';
          _getChange(
            context: context,
            flag: flag,
            index: hour,
            cityName: cityName,
            isMetric: isMetric,
          );
          return LineTooltipItem(
            '$temperature ${isMetric ? '°C' : 'F°'}\n$timeHourlyString',
            TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          );
        }).toList();
      },
    ),
  );
}

String _hourOrDay(bool flag) {
  return flag ? '' : ':00';
}

void _getChange({
  required BuildContext context,
  required bool flag,
  required int index,
  required String cityName,
  required bool isMetric,
}) {
  flag
      ? context.read<BottomCardCubit>().changeToDaily(
          cityName: cityName,
          index: index,
          isMetric: isMetric,
        )
      : context.read<BottomCardCubit>().changeToHourly(
          index: index,
          cityName: cityName,
          isMetric: isMetric,
        );
}
