import 'package:flutter/material.dart';
import '../../../../../../../../domain/entities/meteo_enity/hourly_weather.dart';

Widget timeUnit({required BuildContext context, required HourlyWeather data}) {
  TextStyle textStyle = TextStyle(
    fontSize: 19.5,
    fontWeight: FontWeight(400),
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );
  return Padding(
    padding: EdgeInsetsGeometry.only(right: 20.0),
    child: Text(data.validTimeFormat, style: textStyle),
  );
}
