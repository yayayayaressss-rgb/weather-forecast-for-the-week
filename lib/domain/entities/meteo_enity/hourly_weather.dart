class HourlyWeather {
  final String validTimeFormat;
  final DateTime time;
  final double temperature;
  final double precipitationProbability;
  final String? weatherCode;

  HourlyWeather({
    required this.validTimeFormat,
    required this.time,
    required this.temperature,
    required this.precipitationProbability,
    required this.weatherCode,
  });
}
