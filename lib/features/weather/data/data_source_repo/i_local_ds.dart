import 'package:weather/features/weather/data/model/weather_model.dart';

abstract interface class ILocalDs {
  Future<void> cacheWeather({required WeatherModel weather});
  Future<WeatherModel?> getCachedWeather();
  Future<void> clearCachedWeather();
}
