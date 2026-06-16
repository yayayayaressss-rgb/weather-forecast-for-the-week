import 'package:fl_chart/fl_chart.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';

List<FlSpot> spotsDataHours(MeteoEntity data) {
  return data.hourlyForecast
      .asMap()
      .entries
      .where((entry) {
        return entry.key <= 72;
      })
      .map((entry) => FlSpot(entry.key.toDouble(), entry.value.temperature))
      .toList();
}

List<String> spotsTimeHours(MeteoEntity data) {
  final hoursData = data.hourlyForecast.map((hour) {
    final hourOfDay = hour.time.hour.toString();
    return hourOfDay;
  }).toList();

  return hoursData;
}

List<FlSpot> spotsDataDaily(MeteoEntity data) {
  final dailyData = data.dailyForecast.asMap().entries.map((entry) {
    return FlSpot(entry.key.toDouble(), entry.value.tempMax);
  }).toList();
  return dailyData;
}

List<String> spotsDays(MeteoEntity data) {
  final days = data.dailyForecast.map((day) {
    final date = day.date.toString();
    return date;
  }).toList();
  return days;
}
