import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/usecase/use_case.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';
import 'package:weather/features/weather/domain/repositories/i_weather_repo.dart';

class FetchWeatherUseCase implements UseCase<WeatherEntity, String> {
  final IWeatherRepo _weatherRepository;

  FetchWeatherUseCase(IWeatherRepo weatherRepo)
    : _weatherRepository = weatherRepo;

  @override
  Future<Either<Failure, WeatherEntity>> call({required String parameters}) {
    return _weatherRepository.getWeatherForCityFromServer(cityName: parameters);
  }
}
