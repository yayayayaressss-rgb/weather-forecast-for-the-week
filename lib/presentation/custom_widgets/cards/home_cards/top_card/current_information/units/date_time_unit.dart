import 'package:flutter/material.dart';
import '../../../../../../../domain/entities/meteo_enity/current_weather.dart';

Widget currentDate(BuildContext context, CurrentWeather data) {
  final textS = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 25.0,
    fontWeight: FontWeight(300),
  );
  final txt = data.time;
  return Padding(
    padding: EdgeInsetsGeometry.only(top: 8.0, left: 8.0),
    child: Text(txt, style: textS),
  );
}
