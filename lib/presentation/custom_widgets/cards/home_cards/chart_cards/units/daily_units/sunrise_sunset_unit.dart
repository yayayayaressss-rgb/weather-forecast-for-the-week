import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';
import 'package:intl/intl.dart';

Widget sunRiseSunSetUnit({
  required BuildContext context,
  required DailyWeather data,
}) {
  return Row(
    children: [
      sunRise(context: context, data: data),
      const SizedBox(width: 10.0),
      sunSet(context: context, data: data),
    ],
  );
}

Widget sunRise({required BuildContext context, required DailyWeather data}) {
  final formattedTime = DateFormat('HH:mm').format(data.sunrise);
  String txt = 'Восход : $formattedTime';
  return Text(txt, style: _txtStyle(context));
}

Widget sunSet({required BuildContext context, required DailyWeather data}) {
  final formattedTime = DateFormat('HH:mm').format(data.sunset);
  String txt = 'Закат : $formattedTime';
  return Text(txt, style: _txtStyle(context));
}

TextStyle _txtStyle(BuildContext context) {
  return TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight(350),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
}
