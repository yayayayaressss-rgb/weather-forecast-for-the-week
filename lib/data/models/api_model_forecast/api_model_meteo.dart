class WeatherResponse {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final double utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits currentUnits;
  final Current current;
  final HourlyUnits hourlyUnits;
  final Hourly hourly;
  final DailyUnits dailyUnits;
  final Daily daily;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      generationtimeMs: (json['generationtime_ms'] ?? 0.0).toDouble(),
      utcOffsetSeconds: (json['utc_offset_seconds'] ?? 0).toDouble(),
      timezone: json['timezone'] ?? '',
      timezoneAbbreviation: json['timezone_abbreviation'] ?? '',
      elevation: (json['elevation'] ?? 0).toDouble(),
      currentUnits: CurrentUnits.fromJson(json['current_units'] ?? {}),
      current: Current.fromJson(json['cityName'] ?? '', json['current'] ?? {}),
      hourlyUnits: HourlyUnits.fromJson(json['hourly_units'] ?? {}),
      hourly: Hourly.fromJson(json['hourly'] ?? {}),
      dailyUnits: DailyUnits.fromJson(json['daily_units'] ?? {}),
      daily: Daily.fromJson(json['daily'] ?? {}),
    );
  }
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String apparentTemperature;
  final String precipitation;
  final String rain;
  final String showers;
  final String snowfall;
  final String weatherCode;
  final String cloudCover;
  final String pressureMsl;
  final String windSpeed10m;
  final String windDirection10m;
  final String windGusts10m;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.weatherCode,
    required this.cloudCover,
    required this.pressureMsl,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.windGusts10m,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'] ?? '',
      interval: json['interval'] ?? '',
      temperature2m: json['temperature_2m'] ?? '',
      relativeHumidity2m: json['relative_humidity_2m'] ?? '',
      apparentTemperature: json['apparent_temperature'] ?? '',
      precipitation: json['precipitation'] ?? '',
      rain: json['rain'] ?? '',
      showers: json['showers'] ?? '',
      snowfall: json['snowfall'] ?? '',
      weatherCode: json['weather_code'] ?? '',
      cloudCover: json['cloud_cover'] ?? '',
      pressureMsl: json['pressure_msl'] ?? '',
      windSpeed10m: json['wind_speed_10m'] ?? '',
      windDirection10m: json['wind_direction_10m'] ?? '',
      windGusts10m: json['wind_gusts_10m'] ?? '',
    );
  }
}

class Current {
  final String cityName;
  final String time;
  final double interval;
  final double temperature2m;
  final double relativeHumidity2m;
  final double apparentTemperature;
  final double precipitation;
  final double rain;
  final double showers;
  final double snowfall;
  final int weatherCode;
  final double cloudCover;
  final double pressureMsl;
  final double windSpeed10m;
  final double windDirection10m;
  final double windGusts10m;

  Current({
    required this.cityName,
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.weatherCode,
    required this.cloudCover,
    required this.pressureMsl,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.windGusts10m,
  });

  factory Current.fromJson(String cityName, Map<String, dynamic> json) {
    return Current(
      cityName: cityName,
      time: json['time'] ?? '',
      interval: (json['interval'] ?? 0).toDouble(),
      temperature2m: (json['temperature_2m'] ?? 0.0).toDouble(),
      relativeHumidity2m: (json['relative_humidity_2m'] ?? 0).toDouble(),
      apparentTemperature: (json['apparent_temperature'] ?? 0.0).toDouble(),
      precipitation: (json['precipitation'] ?? 0.0).toDouble(),
      rain: (json['rain'] ?? 0.0).toDouble(),
      showers: (json['showers'] ?? 0.0).toDouble(),
      snowfall: (json['snowfall'] ?? 0.0).toDouble(),
      weatherCode: json['weather_code'] ?? 0,
      cloudCover: (json['cloud_cover'] ?? 0).toDouble(),
      pressureMsl: (json['pressure_msl'] ?? 0.0).toDouble(),
      windSpeed10m: (json['wind_speed_10m'] ?? 0.0).toDouble(),
      windDirection10m: (json['wind_direction_10m'] ?? 0).toDouble(),
      windGusts10m: (json['wind_gusts_10m'] ?? 0.0).toDouble(),
    );
  }
}

class HourlyUnits {
  final String time;
  final String temperature2m;
  final String precipitationProbability;
  final String rain;
  final String weatherCode;

  HourlyUnits({
    required this.time,
    required this.temperature2m,
    required this.precipitationProbability,
    required this.rain,
    required this.weatherCode,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) {
    return HourlyUnits(
      time: json['time'] ?? '',
      temperature2m: json['temperature_2m'] ?? '',
      precipitationProbability: json['precipitation_probability'] ?? '',
      rain: json['rain'] ?? '',
      weatherCode: json['weather_code'] ?? '',
    );
  }
}

class Hourly {
  final List<String> time;
  final List<double> temperature2m;
  final List<double> precipitationProbability;
  final List<double> rain;
  final List<int> weatherCode;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.precipitationProbability,
    required this.rain,
    required this.weatherCode,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    final tempRaw = json['temperature_2m'] as List? ?? [];
    final precipProbRaw = json['precipitation_probability'] as List? ?? [];
    final rainRaw = json['rain'] as List? ?? [];
    final weatherCodeRaw = json['weather_code'] as List? ?? [];

    return Hourly(
      time: List<String>.from(json['time'] ?? []),
      temperature2m: tempRaw.map((e) => (e as num).toDouble()).toList(),
      precipitationProbability: precipProbRaw
          .map((e) => (e as num).toDouble())
          .toList(),
      rain: rainRaw.map((e) => (e as num).toDouble()).toList(),
      weatherCode: weatherCodeRaw.map((e) => (e as num).toInt()).toList(),
    );
  }
}

class DailyUnits {
  final String time;
  final String weatherCode;
  final String temperature2mMax;
  final String temperature2mMin;
  final String sunrise;
  final String sunset;

  DailyUnits({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'] ?? '',
      weatherCode: json['weather_code'] ?? '',
      temperature2mMax: json['temperature_2m_max'] ?? '',
      temperature2mMin: json['temperature_2m_min'] ?? '',
      sunrise: json['sunrise'] ?? '',
      sunset: json['sunset'] ?? '',
    );
  }
}

class Daily {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<String> sunrise;
  final List<String> sunset;

  Daily({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.sunrise,
    required this.sunset,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    final weatherCodeRaw = json['weather_code'] as List? ?? [];
    final tempMaxRaw = json['temperature_2m_max'] as List? ?? [];
    final tempMinRaw = json['temperature_2m_min'] as List? ?? [];

    return Daily(
      time: List<String>.from(json['time'] ?? []),
      weatherCode: weatherCodeRaw.map((e) => (e as num).toInt()).toList(),
      temperature2mMax: tempMaxRaw.map((e) => (e as num).toDouble()).toList(),
      temperature2mMin: tempMinRaw.map((e) => (e as num).toDouble()).toList(),
      sunrise: List<String>.from(json['sunrise'] ?? []),
      sunset: List<String>.from(json['sunset'] ?? []),
    );
  }
}
