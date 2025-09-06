import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/network/utils/url_strings.dart';
import 'package:weather/features/weather/data/data_source_repo/i_local_ds.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

class LocalDsImpl implements ILocalDs {
  final SharedPreferences prefs;

  LocalDsImpl({required SharedPreferences sharedPreferences})
    : prefs = sharedPreferences;

  @override
  Future<void> cacheWeather({required WeatherModel weather}) async {
    final jsonString = jsonEncode(weather.toDisk());
    await prefs.setString(weather.cityName.toLowerCase(), jsonString);
  }

  @override
  Future<WeatherModel?> getCachedWeather({required String cityName}) async {
    final jsonString = prefs.getString(cityName.toLowerCase());
    if (jsonString == null) return null;
    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return WeatherModel.fromDisk(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearCachedWeather() async {
    await prefs.remove(UtilStrings.weather);
  }
}
