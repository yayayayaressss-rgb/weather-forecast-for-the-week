import 'package:flutter/material.dart';
import '../../../../../../../../domain/entities/meteo_enity/hourly_weather.dart';

Widget temperatureUnitCard({
  required HourlyWeather data,
  required BuildContext context,
}) {
  TextStyle textStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight(350),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
  return Text(
    '${data.temperature.round()}°${data.weatherCode}',
    style: textStyle,
  );
}
