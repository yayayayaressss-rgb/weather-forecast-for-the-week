import 'package:fl_chart/fl_chart.dart';

List<ShowingTooltipIndicators> showingTooltipIndicatorsSpots({
  required List<FlSpot> spotList,
  required LineChartBarData lineBarData,
}) {
  return spotList.asMap().entries.map((entry) {
    final spot = entry.value;
    final lineBarSpot = LineBarSpot(lineBarData, 0, spot);
    return ShowingTooltipIndicators([lineBarSpot]);
  }).toList();
}

List<ShowingTooltipIndicators> showingTooltipIndicatorsSpotsFiltered({
  required List<FlSpot> spotList,
  required LineChartBarData lineBarData,
  List<int>? indices,
}) {
  final targetIndices = indices ?? List.generate(spotList.length, (i) => i);

  return targetIndices.map((index) {
    final spot = spotList[index];
    final lineBarSpot = LineBarSpot(lineBarData, 0, spot);

    return ShowingTooltipIndicators([lineBarSpot]);
  }).toList();
}

extension LineChartDataWithTooltips on LineChartData {
  LineChartData withAlwaysVisibleTooltips({
    required List<FlSpot> spotList,
    required LineChartBarData lineBarData,
  }) {
    return copyWith(
      showingTooltipIndicators: showingTooltipIndicatorsSpots(
        spotList: spotList,
        lineBarData: lineBarData,
      ),
    );
  }
}
