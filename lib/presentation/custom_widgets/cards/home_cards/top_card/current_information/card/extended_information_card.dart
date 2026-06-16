import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/current_weather.dart';

Widget extendedInfoCard({
  required BuildContext context,
  required bool flag,
  required CurrentWeather data,
  required bool isMetric,
}) {
  SizedBox noData = const SizedBox.shrink();
  Row dataRow = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [_firstColumn(context: context, data: data, isMetric: isMetric)],
  );
  return Padding(
    padding: EdgeInsetsGeometry.only(left: 8.0),
    child: flag ? dataRow : noData,
  );
}

Text _txt(String txt, BuildContext context) {
  return Text(
    txt,
    style: TextStyle(
      color: Theme
          .of(context)
          .textTheme
          .bodyLarge
          ?.color,
      fontSize: 14.0,
      fontWeight: FontWeight(400),
    ),
  );
}

Widget _firstColumn({
  required BuildContext context,
  required CurrentWeather data,
  required bool isMetric,
}) {
  final String humidity = 'Относительная влажность : ${data.humidity} %';
  final String apparentTemperature =
      'Ощущается как ${data.apparentTemperature.round()}°';
  final String precipitation =
      'Осадки за последний час : ${data.precipitation} ${isMetric
      ? 'mm'
      : 'in'}';
  final String cloudCover = 'Облачность : ${data.cloudCover.round()} %';
  final String pressure =
      'Атмосферное давление : ${data.pressure.round()}${isMetric
      ? 'гПа'
      : 'inHg'}';
  final String windSpeed =
      'Скорость ветра : ${data.windSpeed} ${isMetric ? 'км/ч' : 'mph'}';
  final String windDirection =
      'Направление ветра : ${data.windDirection.round()}°';
  final String windGusts =
      'Порывы ветра : ${data.windGusts} ${isMetric ? 'км/ч' : 'mph'}';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _txt(humidity, context),
      _txt(apparentTemperature, context),
      _txt(precipitation, context),
      _txt(cloudCover, context),
      _txt(pressure, context),
      _txt(windSpeed, context),
      _txt(windDirection, context),
      _txt(windGusts, context),
    ],
  );
}
