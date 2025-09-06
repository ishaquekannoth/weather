import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/common_failures.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/data/data_source_repo/i_local_ds.dart';
import 'package:weather/features/weather/data/data_source_repo/i_remote_ds.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';
import 'package:weather/features/weather/domain/repositories/i_weather_repo.dart';

class WeatherRepoImpl implements IWeatherRepo {
  final IRemoteDs remoteDs;
  final ILocalDs localDs;

  WeatherRepoImpl({required this.remoteDs, required this.localDs});

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherForCity({
    required String cityName,
  }) async {
    WeatherModel? remoteWeather;
    WeatherModel? cachedWeather;

    try {
      remoteWeather = await remoteDs.getWeatherForCity(cityName: cityName);
      try {
        await localDs.cacheWeather(weather: remoteWeather);
      } catch (cacheError) {
        log("Caching failed ..Not a fatal case...");
      }
      return right(remoteWeather.toEntity());
    } catch (remoteError) {
      try {
        cachedWeather = await localDs.getCachedWeather();
        if (cachedWeather != null) {
          return right(cachedWeather.toEntity());
        }
      } catch (_) {}
      if (remoteError is Failure) {
        return left(remoteError);
      }
      return left(
        DefaultFailure(message: "Failed to fetch weather for $cityName"),
      );
    }
  }
}
