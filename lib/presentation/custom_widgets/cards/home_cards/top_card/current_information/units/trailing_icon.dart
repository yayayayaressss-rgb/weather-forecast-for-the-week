import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';

Widget showIcon(CurrentWeather data) {
  final size = TextStyle(fontSize: 60.0);
  return SizedBox(
    height: 80,
    width: 80,
    child: Text(data.weatherCode ?? '', style: size),
  );
}
