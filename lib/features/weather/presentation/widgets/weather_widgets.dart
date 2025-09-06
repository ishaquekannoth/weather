import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({required this.weather, super.key});

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        _WeatherBackground(condition: weather.toCondition()),
        Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 48),
                _WeatherIcon(condition: weather.toCondition()),
                Text(
                  weather.cityName,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Feels like ${weather.feelsLike.toStringAsFixed(1)}°C'),
                Text('Humidity: ${weather.humidity}%'),
                Text('Wind: ${weather.windSpeed} m/s'),
                Text('Clouds: ${weather.clouds}%'),
                Text(weather.description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(condition.toEmoji, style: const TextStyle(fontSize: _iconSize));
  }
}

/// Background that adapts based on condition
class _WeatherBackground extends StatelessWidget {
  const _WeatherBackground({required this.condition});

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    final colors = condition.toColors(context);

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: colors,
          ),
        ),
      ),
    );
  }
}

/// --- ENUM + EXTENSIONS ---

enum WeatherCondition { clear, rainy, cloudy, snowy, unknown }

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }

  List<Color> toColors(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;
    switch (this) {
      case WeatherCondition.clear:
        return [
          Colors.orange.shade200,
          Colors.orange.shade400,
          Colors.blue.shade200,
          Colors.blue.shade400,
        ];
      case WeatherCondition.rainy:
        return [
          Colors.blueGrey.shade200,
          Colors.blueGrey.shade400,
          Colors.blue.shade700,
          Colors.blue.shade900,
        ];
      case WeatherCondition.cloudy:
        return [
          Colors.grey.shade300,
          Colors.grey.shade400,
          Colors.blueGrey.shade300,
          Colors.blueGrey.shade500,
        ];
      case WeatherCondition.snowy:
        return [
          Colors.white,
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade300,
        ];
      case WeatherCondition.unknown:
        return [
          color,
          color.brighten(),
          color.brighten(33),
          color.brighten(50),
        ];
    }
  }
}

/// Map WeatherEntity.description → WeatherCondition
extension WeatherEntityMapper on WeatherEntity {
  WeatherCondition toCondition() {
    final desc = description.toLowerCase();
    if (desc.contains('clear')) return WeatherCondition.clear;
    if (desc.contains('rain')) return WeatherCondition.rainy;
    if (desc.contains('cloud')) return WeatherCondition.cloudy;
    if (desc.contains('snow')) return WeatherCondition.snowy;
    return WeatherCondition.unknown;
  }
}

/// Color brighten extension

extension ColorBrightness on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;

    return Color.fromARGB(
      a.toInt(),
      (r + ((255 - r) * p)).round(),
      (g + ((255 - g) * p)).round(),
      (b + ((255 - b) * p)).round(),
    );
  }
}
