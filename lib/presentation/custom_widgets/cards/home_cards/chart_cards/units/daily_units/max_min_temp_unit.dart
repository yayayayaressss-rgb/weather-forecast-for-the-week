import 'package:flutter/material.dart';
import '../../../../../../../domain/entities/meteo_enity/daily_weather.dart';
import '../unit_interface.dart';

Widget minMaxTempUnit({
  required BuildContext context,
  required DailyWeather data,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      maxTemp(context: context, data: data),
      minTemp(context: context, data: data),
    ],
  );
}

Widget maxTemp({required BuildContext context, required DailyWeather data}) {
  String txt = 'Максимальная температура :${data.tempMax.round()}°';
  return Text(txt, style: _txtStyle(context));
}

Widget minTemp({required BuildContext context, required DailyWeather data}) {
  String txt = 'Минимальаня температура :${data.tempMin.round()}°';
  return Text(txt, style: _txtStyle(context));
}

TextStyle _txtStyle(BuildContext context) {
  return TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight(350),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
}
