import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

FlTitlesData flTitlesData({required bool flag, required List<String> time}) {
  return FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: flag ? 6 : 1,
        reservedSize: 30,
        getTitlesWidget: (value, meta) {
          final index = value.toInt();
          if (index >= time.length) return const SizedBox.shrink();
          if (!flag && index == 0) {
            return Padding(
              padding: EdgeInsetsGeometry.only(left: 8.0, top: 8.0),
              child: Text(time[index], style: const TextStyle(fontSize: 12.0)),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),

            child: Text(time[index], style: const TextStyle(fontSize: 12.0)),
          );
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false, interval: 10, reservedSize: 30),
    ),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
