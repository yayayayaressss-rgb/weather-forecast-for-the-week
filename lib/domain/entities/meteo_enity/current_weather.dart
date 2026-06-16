  class CurrentWeather {
    final String cityName;
    final String time;
    final DateTime rowDate;
    final double temperature;
    final double humidity;
    final double apparentTemperature;
    final double precipitation;
    final String? weatherCode;
    final double cloudCover;
    final double pressure;
    final double windSpeed;
    final double windDirection;
    final double windGusts;

    CurrentWeather({
      required this.cityName,
      required this.time,
      required this.rowDate,
      required this.temperature,
      required this.humidity,
      required this.apparentTemperature,
      required this.precipitation,
      required this.weatherCode,
      required this.cloudCover,
      required this.pressure,
      required this.windSpeed,
      required this.windDirection,
      required this.windGusts,
    });
  }
