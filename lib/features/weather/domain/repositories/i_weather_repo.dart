import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';

abstract interface class IWeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeatherForCityFromServer({
    required String cityName,
  });
}
