import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';
import 'package:weather/features/weather/domain/usecases/weather_usecases.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;
  final GetCachedWeatherUseCase getCachedWeatherUseCase;
  WeatherBloc({
    required this.fetchWeatherUseCase,
    required this.getCachedWeatherUseCase,
  }) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final Either<Failure, WeatherEntity> result = await fetchWeatherUseCase(
      parameters: event.cityName,
    );

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }
}
