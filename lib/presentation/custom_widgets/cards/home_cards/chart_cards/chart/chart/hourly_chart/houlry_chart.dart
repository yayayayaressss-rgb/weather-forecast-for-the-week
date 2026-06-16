import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import 'package:forecast_app_pet_proj/presentation/state_management/cubit/metric_cubit/metric_cubit.dart';
import '../../chart_units/fl_titles_data.dart';
import '../../chart_units/line_touch_data.dart';
import '../../chart_units/spots/line_chart_bar_data.dart';
import '../../chart_units/spots/spot_data.dart';

LineChart hourlyChartBuild({
  required BuildContext context,
  required MeteoEntity data,
  required String cityName,
}) {
  final isMetric = context.read<MetricCubit>().state.isMetric;
  final spots = spotsDataHours(data);
  final time = spotsTimeHours(data);
  final spotsLength = (spots.length - 1).toDouble();
  const flag = true;
  return LineChart(
    LineChartData(
      minX: 0,
      maxX: spotsLength + 1.0,
      minY: isMetric ? -50 : -150,
      maxY: isMetric ? 50 : 150,
      clipData: FlClipData.all(),
      lineBarsData: lineChartBarData(
        context: context,
        spots: spots,
        flag: flag,
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: isMetric ? 10 : 25,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '${value.toInt()}°',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        bottomTitles: flTitlesData(flag: flag, time: time).bottomTitles,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 10,
        getDrawingHorizontalLine: (value) {
          if ((value - 0).abs() < 0.1) {
            return FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          }
          return FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 0.5,
            dashArray: [3, 3],
          );
        },
      ),
      borderData: FlBorderData(show: false),
      lineTouchData: lineTouchData(
        context: context,
        time: time,
        flag: !flag,
        cityName: cityName,
        isMetric: isMetric,
      ),
    ),
    duration: Duration.zero,
  );
}
