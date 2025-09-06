import 'package:weather/core/network/dio/network_enums.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final String description;
  final double windSpeed;
  final int clouds;

  const WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.windSpeed,
    required this.clouds,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: sanitize<String>(json['name']),
      temperature: sanitize<double>(json['main']?['temp']),
      feelsLike: sanitize<double>(json['main']?['feels_like']),
      humidity: sanitize<int>(json['main']?['humidity']),
      description: sanitize<String>(
        (json['weather'] is List && (json['weather'] as List).isNotEmpty)
            ? (json['weather'] as List).first['description']
            : null,
      ),
      windSpeed: sanitize<double>(json['wind']?['speed']),
      clouds: sanitize<int>(json['clouds']?['all']),
    );
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
      cityName: cityName,
      temperature: temperature,
      feelsLike: feelsLike,
      humidity: humidity,
      description: description,
      windSpeed: windSpeed,
      clouds: clouds,
    );
  }

  Map<String, dynamic> toDisk() {
    return {
      'cityName': cityName,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'description': description,
      'windSpeed': windSpeed,
      'clouds': clouds,
    };
  }

  factory WeatherModel.fromDisk(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: sanitize<String>(map['cityName']),
      temperature: sanitize<double>(map['temperature']),
      feelsLike: sanitize<double>(map['feelsLike']),
      humidity: sanitize<int>(map['humidity']),
      description: sanitize<String>(map['description']),
      windSpeed: sanitize<double>(map['windSpeed']),
      clouds: sanitize<int>(map['clouds']),
    );
  }
  factory WeatherModel.fromEntity(WeatherEntity entity) {
    return WeatherModel(
      cityName: entity.cityName,
      temperature: entity.temperature,
      feelsLike: entity.feelsLike,
      humidity: entity.humidity,
      description: entity.description,
      windSpeed: entity.windSpeed,
      clouds: entity.clouds,
    );
  }
}
