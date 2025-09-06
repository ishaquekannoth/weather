part of 'weather_bloc.dart';

sealed class WeatherState {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  const WeatherLoaded(this.weather);
}

final class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
}
