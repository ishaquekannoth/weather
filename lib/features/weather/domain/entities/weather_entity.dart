class WeatherEntity {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final double windSpeed;
  final int clouds;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.windSpeed,
    required this.clouds,
  });
  @override
  String toString() {
    return 'WeatherEntity('
        'cityName: $cityName, '
        'temperature: $temperature, '
        'feelsLike: $feelsLike, '
        'humidity: $humidity, '
        'description: $description, '
        'windSpeed: $windSpeed, '
        'clouds: $clouds'
        ')';
  }
}
