import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';
import 'location_info.dart';

class MeteoEntity {
  final String cityName;
  final LocationInfo location;
  final CurrentWeather current;
  final List<HourlyWeather> hourlyForecast;
  final List<DailyWeather> dailyForecast;

  MeteoEntity({
    required this.cityName,
    required this.location,
    required this.current,
    required this.hourlyForecast,
    required this.dailyForecast,
  });
}
