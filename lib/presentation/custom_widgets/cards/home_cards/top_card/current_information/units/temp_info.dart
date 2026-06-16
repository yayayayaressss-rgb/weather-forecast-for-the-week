import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';

class TempInfo extends StatelessWidget {
  final MeteoEntity data;
  final bool isMetric;

  const TempInfo({super.key, required this.data, required this.isMetric});

  @override
  Widget build(BuildContext context) {
    final dataLocal = data.current;
    final textS = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontSize: 35,
    );
    final c = '°C';
    final f = '°F';
    return Text(
      '${dataLocal.temperature.round()}${isMetric ? c : f}',
      style: textS,
    );
  }
}
