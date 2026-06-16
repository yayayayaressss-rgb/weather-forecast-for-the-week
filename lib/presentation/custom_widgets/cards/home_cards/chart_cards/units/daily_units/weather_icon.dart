import 'package:flutter/cupertino.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/daily_weather.dart';

Widget weatherIconDaile({required DailyWeather data}) {
  TextStyle size = TextStyle(fontSize: 30.0);
  return Text(data.weatherCode ?? '', style: size);
}
