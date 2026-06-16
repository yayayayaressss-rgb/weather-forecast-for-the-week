import 'package:flutter/material.dart';
import '../../../../../../../domain/entities/meteo_enity/current_weather.dart';

Widget cityName(BuildContext context, CurrentWeather data) {
  final textS = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 25,
  );
  return Text(data.cityName, style: textS);
}
