class DailyWeather {
  final String date;
  final DateTime rowDate;
  final String? weatherCode;
  final double tempMax;
  final double tempMin;
  final DateTime sunrise;
  final DateTime sunset;

  DailyWeather({
    required this.date,
    required this.weatherCode,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.sunset,
    required this.rowDate,
  });
}
