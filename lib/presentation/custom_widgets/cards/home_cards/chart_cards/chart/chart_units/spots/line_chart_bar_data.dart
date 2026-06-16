import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<LineChartBarData> lineChartBarData({
  required BuildContext context,
  required List<FlSpot> spots,
  required bool flag,
}) {
  return [
    LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Theme.of(context).colorScheme.primary,
      dotData: FlDotData(show: !flag),
      belowBarData: BarAreaData(show: false),
    ),
  ];
}
