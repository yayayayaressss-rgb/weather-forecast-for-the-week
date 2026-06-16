class ConstantsApiOpenMeteo {
  static const String SCHEME = 'https://';
  static const String DOMAIN = 'api.open-meteo.com';
  static const String PATH = '/v1/forecast';
  static const String BASE_URL = SCHEME + DOMAIN + PATH;

  // https://api.open-meteo.com/v1/forecast&temperature_2m
  static const String CURRENT_TEMPERATURE = 'temperature_2m';
  static const String CURRENT_HUMIDITY = 'relative_humidity_2m';
  static const String CURRENT_APPARENT_TEMP = 'apparent_temperature';
  static const String CURRENT_PRECIPITATION = 'precipitation';
  static const String CURRENT_RAIN = 'rain';
  static const String CURRENT_SHOWERS = 'showers';
  static const String CURRENT_SNOWFALL = 'snowfall';
  static const String CURRENT_WEATHER_CODE = 'weather_code';
  static const String CURRENT_CLOUD_COVER = 'cloud_cover';
  static const String CURRENT_PRESSURE = 'pressure_msl';
  static const String CURRENT_WIND_SPEED = 'wind_speed_10m';
  static const String CURRENT_WIND_DIRECTION = 'wind_direction_10m';
  static const String CURRENT_WIND_GUSTS = 'wind_gusts_10m';

  static const String HOURLY_TEMPERATURE = 'temperature_2m';
  static const String HOURLY_PRECIPITATION_PROB = 'precipitation_probability';
  static const String HOURLY_RAIN = 'rain';
  static const String HOURLY_WEATHER_CODE = 'weather_code';

  static const String DAILY_WEATHER_CODE = 'weather_code';
  static const String DAILY_TEMP_MAX = 'temperature_2m_max';
  static const String DAILY_TEMP_MIN = 'temperature_2m_min';
  static const String DAILY_SUNRISE = 'sunrise';
  static const String DAILY_SUNSET = 'sunset';

  static const String TIMEZONE = 'auto';
  static const int FORECAST_DAYS = 7;

  static const String CURRENT_PARAMS =
      '$CURRENT_TEMPERATURE,$CURRENT_HUMIDITY,$CURRENT_APPARENT_TEMP,'
      '$CURRENT_PRECIPITATION,$CURRENT_RAIN,$CURRENT_SHOWERS,$CURRENT_SNOWFALL,'
      '$CURRENT_WEATHER_CODE,$CURRENT_CLOUD_COVER,$CURRENT_PRESSURE,'
      '$CURRENT_WIND_SPEED,$CURRENT_WIND_DIRECTION,$CURRENT_WIND_GUSTS';

  static const String HOURLY_PARAMS =
      '$HOURLY_TEMPERATURE,$HOURLY_PRECIPITATION_PROB,$HOURLY_RAIN,$HOURLY_WEATHER_CODE';

  static const String DAILY_PARAMS =
      '$DAILY_WEATHER_CODE,$DAILY_TEMP_MAX,$DAILY_TEMP_MIN,$DAILY_SUNRISE,$DAILY_SUNSET';
}

class Constants {
  static const String LANGUAGE = 'ru';
  static const String UNITS_METRIC = 'metric';
  static const String FORECAST_APP_IP = 'a72ddfe0f07b477e9124400a78da9c00';
  static const String FORECAST_DEF_SCHEME = 'http://';
  static const String FORECAST_DEF_DOMAIN = 'api.openweathermap.org';
  static const String FORECAST_DEF_PATH = '/data/2.5/forecast';
  static const String FORECAST_BASE_URL =
      FORECAST_DEF_SCHEME + FORECAST_DEF_DOMAIN + FORECAST_DEF_PATH;
}
