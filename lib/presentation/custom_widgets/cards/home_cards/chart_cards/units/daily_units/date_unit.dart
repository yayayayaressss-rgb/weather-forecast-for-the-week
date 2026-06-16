import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';

Widget dateUnit({
  required BuildContext context,
  required DailyWeather data,
  required String cityName,
}) {
  TextStyle txtStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight(350),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
  return Row(children: [Text(data.date, style: txtStyle)]);
}
