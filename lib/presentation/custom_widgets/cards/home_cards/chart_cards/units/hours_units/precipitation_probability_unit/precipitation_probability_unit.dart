import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/hourly_weather.dart';

Widget precipitationProbabilityUnit({
  required HourlyWeather data,
  required BuildContext context,
}) {
  TextStyle textStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight(350),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
  return Text(
    'Вероятность осадков ${data.precipitationProbability.round()}%',
    style: textStyle,
  );
}
