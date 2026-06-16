import 'dart:developer';

import '../../domain/entities/meteo_enity/current_weather.dart';
import '../../domain/entities/meteo_enity/daily_weather.dart';
import '../../domain/entities/meteo_enity/hourly_weather.dart';
import '../../domain/entities/meteo_enity/location_info.dart';
import '../../domain/entities/meteo_enity/meteo_enity.dart';

class UnitsMapper {
  double celsiusToFahrenheit(double celsius) => (celsius * 9 / 5) + 32;

  double kmhToMph(double kmh) => (kmh * 0.621371);

  double mmToInches(double mm) => mm * 0.0393701;

  double hPaToInHg(double hPa) => hPa * 0.02953;

  double metersToFeet(double meters) => meters * 3.28084;

  double kmToMiles(double km) => km * 0.621371;

  double fahrenheitToCelsius(double fahrenheit) => (fahrenheit - 32) * 5 / 9;

  double mphToKmh(double mph) => mph / 0.621371;

  double inchesToMm(double inches) => inches / 0.0393701;

  double inHgToHPa(double inHg) => inHg * 33.8639;

  double feetToMeters(double feet) => feet / 3.28084;

  double milesToKm(double miles) => miles / 0.621371;

  double _roundDouble(double value, int decimals) {
    double mod = 1.0;
    for (int i = 0; i < decimals; i++) {
      mod *= 10;
    }
    return (value * mod).roundToDouble() / mod;
  }

  MeteoEntity toImperial(MeteoEntity entity) {
    log('pars to Imperial');
    return MeteoEntity(
      cityName: entity.cityName,
      location: LocationInfo(
        latitude: entity.location.latitude,
        longitude: entity.location.longitude,
        elevation: _roundDouble(metersToFeet(entity.location.elevation), 0),
        timezone: entity.location.timezone,
      ),
      current: CurrentWeather(
        cityName: entity.current.cityName,
        time: entity.current.time,
        rowDate: entity.current.rowDate,
        temperature: _roundDouble(
          celsiusToFahrenheit(entity.current.temperature),
          0,
        ),
        humidity: entity.current.humidity,
        apparentTemperature: _roundDouble(
          celsiusToFahrenheit(entity.current.apparentTemperature),
          0,
        ),
        precipitation: _roundDouble(
          mmToInches(entity.current.precipitation),
          2,
        ),
        weatherCode: entity.current.weatherCode,
        cloudCover: entity.current.cloudCover,
        pressure: _roundDouble(hPaToInHg(entity.current.pressure), 1),
        windSpeed: _roundDouble(kmhToMph(entity.current.windSpeed), 1),
        windDirection: entity.current.windDirection,
        windGusts: _roundDouble(kmhToMph(entity.current.windGusts), 1),
      ),
      hourlyForecast: entity.hourlyForecast
          .map((h) => _toImperialHourly(h))
          .toList(),
      dailyForecast: entity.dailyForecast
          .map((d) => _toImperialDaily(d))
          .toList(),
    );
  }

  MeteoEntity toMetric(MeteoEntity entity) {
    log('pars to Metric');
    return MeteoEntity(
      cityName: entity.cityName,
      location: LocationInfo(
        latitude: entity.location.latitude,
        longitude: entity.location.longitude,
        elevation: _roundDouble(feetToMeters(entity.location.elevation), 0),
        timezone: entity.location.timezone,
      ),
      current: CurrentWeather(
        cityName: entity.current.cityName,
        time: entity.current.time,
        rowDate: entity.current.rowDate,
        temperature: _roundDouble(
          fahrenheitToCelsius(entity.current.temperature),
          0,
        ),
        humidity: entity.current.humidity,
        apparentTemperature: _roundDouble(
          fahrenheitToCelsius(entity.current.apparentTemperature),
          0,
        ),
        precipitation: _roundDouble(
          inchesToMm(entity.current.precipitation),
          1,
        ),
        weatherCode: entity.current.weatherCode,
        cloudCover: entity.current.cloudCover,
        pressure: _roundDouble(inHgToHPa(entity.current.pressure), 1),
        windSpeed: _roundDouble(mphToKmh(entity.current.windSpeed), 1),
        windDirection: entity.current.windDirection,
        windGusts: _roundDouble(mphToKmh(entity.current.windGusts), 1),
      ),
      hourlyForecast: entity.hourlyForecast
          .map((h) => _toMetricHourly(h))
          .toList(),
      dailyForecast: entity.dailyForecast
          .map((d) => _toMetricDaily(d))
          .toList(),
    );
  }

  HourlyWeather _toImperialHourly(HourlyWeather h) {
    return HourlyWeather(
      validTimeFormat: h.validTimeFormat,
      time: h.time,
      temperature: _roundDouble(celsiusToFahrenheit(h.temperature), 0),
      precipitationProbability: h.precipitationProbability,
      weatherCode: h.weatherCode,
    );
  }

  DailyWeather _toImperialDaily(DailyWeather d) {
    return DailyWeather(
      date: d.date,
      rowDate: d.rowDate,
      weatherCode: d.weatherCode,
      tempMax: _roundDouble(celsiusToFahrenheit(d.tempMax), 0),
      tempMin: _roundDouble(celsiusToFahrenheit(d.tempMin), 0),
      sunrise: d.sunrise,
      sunset: d.sunset,
    );
  }

  HourlyWeather _toMetricHourly(HourlyWeather h) {
    return HourlyWeather(
      validTimeFormat: h.validTimeFormat,
      time: h.time,
      temperature: _roundDouble(fahrenheitToCelsius(h.temperature), 0),
      precipitationProbability: h.precipitationProbability,
      weatherCode: h.weatherCode,
    );
  }

  DailyWeather _toMetricDaily(DailyWeather d) {
    return DailyWeather(
      date: d.date,
      rowDate: d.rowDate,
      weatherCode: d.weatherCode,
      tempMax: _roundDouble(fahrenheitToCelsius(d.tempMax), 0),
      tempMin: _roundDouble(fahrenheitToCelsius(d.tempMin), 0),
      sunrise: d.sunrise,
      sunset: d.sunset,
    );
  }

  String formatTemperatureCelsius(double celsius, {bool showUnit = true}) {
    final rounded = celsius.round();
    return showUnit ? '$rounded°C' : '$rounded';
  }

  String formatWindSpeedKmh(double kmh, {bool showUnit = true}) {
    final oneDecimal = kmh.toStringAsFixed(1);
    return showUnit ? '$oneDecimal км/ч' : oneDecimal;
  }

  String formatPrecipitationMm(double mm, {bool showUnit = true}) {
    final twoDecimals = mm.toStringAsFixed(1);
    return showUnit ? '$twoDecimals мм' : twoDecimals;
  }

  String formatPressureHPa(double hPa, {bool showUnit = true}) {
    final oneDecimal = hPa.toStringAsFixed(1);
    return showUnit ? '$oneDecimal гПа' : oneDecimal;
  }

  String formatTemperatureFahrenheit(double celsius, {bool showUnit = true}) {
    final fahrenheit = _roundDouble(celsiusToFahrenheit(celsius), 0);
    return showUnit ? '${fahrenheit.round()}°F' : '${fahrenheit.round()}';
  }

  String formatWindSpeedMph(double kmh, {bool showUnit = true}) {
    final mph = _roundDouble(kmhToMph(kmh), 1);
    final oneDecimal = mph.toStringAsFixed(1);
    return showUnit ? '$oneDecimal mph' : oneDecimal;
  }

  String formatPrecipitationInches(double mm, {bool showUnit = true}) {
    final inches = _roundDouble(mmToInches(mm), 2);
    final twoDecimals = inches.toStringAsFixed(2);
    return showUnit ? '$twoDecimals in' : twoDecimals;
  }

  String formatPressureInHg(double hPa, {bool showUnit = true}) {
    final inHg = _roundDouble(hPaToInHg(hPa), 1);
    final oneDecimal = inHg.toStringAsFixed(1);
    return showUnit ? '$oneDecimal inHg' : oneDecimal;
  }

  String formatElevationMeters(double meters, {bool showUnit = true}) {
    final rounded = meters.round();
    return showUnit ? '$rounded м' : '$rounded';
  }

  String formatElevationFeet(double meters, {bool showUnit = true}) {
    final feet = _roundDouble(metersToFeet(meters), 0);
    final rounded = feet.round();
    return showUnit ? '$rounded ft' : '$rounded';
  }

  String formatHumidity(double humidity, {bool showUnit = true}) {
    final rounded = humidity.round();
    return showUnit ? '$rounded%' : '$rounded';
  }

  String formatCloudCover(double cloudCover, {bool showUnit = true}) {
    final rounded = cloudCover.round();
    return showUnit ? '$rounded%' : '$rounded';
  }

  String formatPrecipitationProbability(
    double probability, {
    bool showUnit = true,
  }) {
    final rounded = probability.round();
    return showUnit ? '$rounded%' : '$rounded';
  }
}
