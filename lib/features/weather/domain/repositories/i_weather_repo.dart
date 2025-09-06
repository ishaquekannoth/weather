import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';

abstract interface class IWeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeatherForCity({
    required String cityName,
  });
  Future<Either<Failure, Unit>> storeWeatherLocally({
    required WeatherEntity weatherEntity,
  });
}
