import 'dart:convert';
import 'dart:developer';
import '../../domain/entities/meteo_enity/current_weather.dart';
import '../../domain/entities/meteo_enity/daily_weather.dart';
import '../../domain/entities/meteo_enity/hourly_weather.dart';
import '../../domain/entities/meteo_enity/location_info.dart';
import '../../domain/entities/meteo_enity/meteo_enity.dart';
import '../models/api_model_forecast/api_model_meteo.dart';

class MeteoMapper {
  MeteoEntity fromApiToEntity(dynamic dto) {
    Map<String, dynamic> jsonMap;

    if (dto is String) {
      jsonMap = jsonDecode(dto);
    } else if (dto is Map<String, dynamic>) {
      jsonMap = dto;
    } else {
      throw Exception(
        'fromApiToEntity: ожидается String или Map, получен ${dto.runtimeType}',
      );
    }

    final data = WeatherResponse.fromJson(jsonMap);

    final cityName = jsonMap['cityName'] ?? '';

    final location = LocationInfo(
      latitude: data.latitude,
      longitude: data.longitude,
      elevation: data.elevation.toDouble(),
      timezone: data.timezone,
    );

    final current = CurrentWeather(
      cityName: cityName,
      time: _dateTimeToString(DateTime.parse(data.current.time)),
      rowDate: DateTime.parse(data.current.time),
      temperature: data.current.temperature2m.toDouble(),
      humidity: data.current.relativeHumidity2m.toDouble(),
      apparentTemperature: data.current.apparentTemperature.toDouble(),
      precipitation: data.current.precipitation.toDouble(),
      weatherCode: _getByCode(data.current.weatherCode.toDouble()),
      cloudCover: data.current.cloudCover.toDouble(),
      pressure: data.current.pressureMsl.toDouble(),
      windSpeed: data.current.windSpeed10m.toDouble(),
      windDirection: data.current.windDirection10m.toDouble(),
      windGusts: data.current.windGusts10m.toDouble(),
    );
    final hourlyForecast = List.generate(data.hourly.time.length, (index) {
      if (index < 3) {}
      return HourlyWeather(
        validTimeFormat: _dateTimeToString(
          DateTime.parse(data.hourly.time[index]),
        ),
        time: DateTime.parse(data.hourly.time[index]),
        temperature: data.hourly.temperature2m[index],
        precipitationProbability: data.hourly.precipitationProbability[index]
            .toDouble(),
        weatherCode: _getByCode(data.hourly.weatherCode[index].toDouble()),
      );
    });
    final dailyForecast = List.generate(data.daily.time.length, (index) {
      return DailyWeather(
        date: _parseWeekDays(DateTime.parse(data.daily.time[index])),
        rowDate: DateTime.parse(data.daily.time[index]),
        weatherCode: _getByCode(data.daily.weatherCode[index].toDouble()),
        tempMax: data.daily.temperature2mMax[index].toDouble(),
        tempMin: data.daily.temperature2mMin[index].toDouble(),
        sunrise: DateTime.parse(data.daily.sunrise[index]),
        sunset: DateTime.parse(data.daily.sunset[index]),
      );
    });

    return MeteoEntity(
      cityName: cityName ?? '',
      location: location,
      current: current,
      hourlyForecast: hourlyForecast,
      dailyForecast: dailyForecast,
    );
  }

  String _getByCode(double weatherCode) {
    switch (weatherCode) {
      case 0:
        return '☀️';
      case 1:
        return '🌤️';
      case 2:
        return '⛅';
      case 3:
        return '☁️';
      case 45:
      case 48:
        return '🌫️';
      case 51:
      case 53:
      case 55:
        return '🌧️';
      case 56:
      case 57:
        return '🌨️';
      case 61:
      case 63:
      case 65:
        return '🌧️';
      case 66:
      case 67:
        return '❄️';
      case 71:
      case 73:
      case 75:
        return '❄️';
      case 77:
        return '❄️';
      case 80:
      case 81:
      case 82:
        return '🌦️';
      case 85:
      case 86:
        return '🌨️';
      case 95:
        return '⛈️';
      case 96:
      case 99:
        return '🌩️';
      default:
        return '';
    }
  }

  Map<String, dynamic> toJson(MeteoEntity entity) {
    return {
      'cityName': entity.cityName,
      'location': {
        'lat': entity.location.latitude,
        'lon': entity.location.longitude,
        'el': entity.location.elevation,
        'tz': entity.location.timezone,
      },
      'current': {
        'cityName': entity.cityName,
        'time': entity.current.time,
        'rowDate': entity.current.rowDate.toIso8601String(),
        'temp': entity.current.temperature,
        'hum': entity.current.humidity,
        'appTemp': entity.current.apparentTemperature,
        'precip': entity.current.precipitation,
        'code': entity.current.weatherCode,
        'cloud': entity.current.cloudCover,
        'press': entity.current.pressure,
        'wind': entity.current.windSpeed,
        'windDir': entity.current.windDirection,
        'gusts': entity.current.windGusts,
      },
      'hourly': entity.hourlyForecast
          .map(
            (h) => {
              'time': h.time.toIso8601String(),
              'temp': h.temperature,
              'prob': h.precipitationProbability,
              'code': h.weatherCode,
            },
          )
          .toList(),
      'daily': entity.dailyForecast
          .map(
            (d) => {
              'date': d.date,
              'rowDate': d.rowDate.toIso8601String(),
              'code': d.weatherCode,
              'max': d.tempMax,
              'min': d.tempMin,
              'rise': d.sunrise.toIso8601String(),
              'set': d.sunset.toIso8601String(),
            },
          )
          .toList(),
    };
  }

  MeteoEntity fromJson(Map<String, dynamic> json) {
    dynamic rowDateValue = json['current']['rowDate'];
    DateTime currentDateTime;

    if (rowDateValue is String && rowDateValue.contains(' ')) {
      log('⚠️ В кэше битые данные, используем текущее время');
      currentDateTime = DateTime.now();
    } else {
      currentDateTime = DateTime.parse(rowDateValue);
    }

    return MeteoEntity(
      cityName: json['cityName'] ?? '',
      location: LocationInfo(
        latitude: json['location']['lat'],
        longitude: json['location']['lon'],
        elevation: json['location']['el'],
        timezone: json['location']['tz'],
      ),
      current: CurrentWeather(
        cityName: json['cityName'] ?? '',
        time: _dateTimeToString(currentDateTime),
        rowDate: currentDateTime,
        temperature: (json['current']['temp'] as num).toDouble(),
        humidity: (json['current']['hum'] as num).toDouble(),
        apparentTemperature: (json['current']['appTemp'] as num).toDouble(),
        precipitation: (json['current']['precip'] as num).toDouble(),
        weatherCode: json['current']['code'],
        cloudCover: (json['current']['cloud'] as num).toDouble(),
        pressure: (json['current']['press'] as num).toDouble(),
        windSpeed: (json['current']['wind'] as num).toDouble(),
        windDirection: (json['current']['windDir'] as num).toDouble(),
        windGusts: (json['current']['gusts'] as num).toDouble(),
      ),
      hourlyForecast: (json['hourly'] as List)
          .map(
            (h) => HourlyWeather(
              validTimeFormat: _dateTimeToString(DateTime.parse(h['time'])),
              time: DateTime.parse(h['time']),
              temperature: (h['temp'] as num).toDouble(),
              precipitationProbability: (h['prob'] as num).toDouble(),
              weatherCode: h['code'],
            ),
          )
          .toList(),
      dailyForecast: (json['daily'] as List)
          .map(
            (d) => DailyWeather(
              date: d['date'],
              rowDate: DateTime.parse(d['rowDate']),
              weatherCode: d['code'],
              tempMax: (d['max'] as num).toDouble(),
              tempMin: (d['min'] as num).toDouble(),
              sunrise: DateTime.parse(d['rise']),
              sunset: DateTime.parse(d['set']),
            ),
          )
          .toList(),
    );
  }

  String _dateTimeToString(DateTime date) {
    final monthNames = {
      1: 'Января',
      2: 'Февраля',
      3: 'Марта',
      4: 'Апреля',
      5: 'Мая',
      6: 'Июня',
      7: 'Июля',
      8: 'Августа',
      9: 'Сентября',
      10: 'Октября',
      11: 'Ноября',
      12: 'Декабря',
    };

    final month = monthNames[date.month] ?? '';
    final day = date.day;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$day $month  $hour:$minute';
  }

  String _parseWeekDays(DateTime date) {
    const weekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    final weekday = weekdays[date.weekday - 1];
    final day = date.day;

    return '$weekday, $day';
  }
}
