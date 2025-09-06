part of 'weather_bloc.dart';

sealed class WeatherEvent {
  const WeatherEvent();
}

final class FetchWeather extends WeatherEvent {
  final String cityName;
  const FetchWeather(this.cityName);
}

class LoadCachedWeather extends WeatherEvent {
  final String cityName;

  LoadCachedWeather({required this.cityName});
}
