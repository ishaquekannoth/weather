import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/widgets/shared/text_widget.dart';
import 'package:weather/features/weather/domain/entities/weather_entity.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({required this.weather, super.key});

  final WeatherEntity weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final condition = weather.toCondition();

    final tempFactor = tempToMeterFactor(weather.temperature).clamp(0.0, 1.0);

    return Stack(
      children: [
        _WeatherBackground(condition: condition),
        Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 48.h),
                _WeatherIcon(condition: condition),
                TextWidget(
                  maxLines: 2,
                  text: weather.cityName,
                  textStyle: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.h),

                Column(
                  children: [
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C 🌡️',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 220,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade300,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: tempFactor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.orange,
                                Colors.red,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C 🤗',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '💧 Humidity: ${weather.humidity}%',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '💨 Wind: ${weather.windSpeed} m/s',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '☁️ Clouds: ${weather.clouds}%',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                // Description box
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade200.withAlpha(70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '“${weather.description}”',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
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

enum WeatherCondition { hot, warm, mild, cold, freezing, unknown }

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.hot:
        return '🔥';
      case WeatherCondition.warm:
        return '☀️';
      case WeatherCondition.mild:
        return '🌤️';
      case WeatherCondition.cold:
        return '🧥';
      case WeatherCondition.freezing:
        return '❄️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }

  List<Color> toColors(BuildContext context) {
    switch (this) {
      case WeatherCondition.hot:
        return [
          Colors.red.shade400,
          Colors.orange.shade400,
          Colors.yellow.shade300,
          Colors.orange.shade200,
        ];
      case WeatherCondition.warm:
        return [
          Colors.orange.shade200,
          Colors.yellow.shade200,
          Colors.orange.shade300,
          Colors.orange.shade400,
        ];
      case WeatherCondition.mild:
        return [
          Colors.green.shade200,
          Colors.teal.shade200,
          Colors.blue.shade200,
          Colors.blue.shade300,
        ];
      case WeatherCondition.cold:
        return [
          Colors.blue.shade300,
          Colors.blue.shade400,
          Colors.blueGrey.shade400,
          Colors.blueGrey.shade600,
        ];
      case WeatherCondition.freezing:
        return [
          Colors.cyan.shade100,
          Colors.cyan.shade200,
          Colors.blue.shade100,
          Colors.blue.shade200,
        ];
      case WeatherCondition.unknown:
        return [
          Colors.grey.shade400,
          Colors.grey.shade500,
          Colors.blueGrey.shade400,
          Colors.blueGrey.shade500,
        ];
    }
  }
}

/// Map WeatherEntity.temperature → WeatherCondition
extension WeatherEntityMapper on WeatherEntity {
  WeatherCondition toCondition() {
    final temp = temperature; // temperature in Celsius
    if (temp >= 35) return WeatherCondition.hot;
    if (temp >= 30) return WeatherCondition.warm;
    if (temp >= 20) return WeatherCondition.mild;
    if (temp >= 5) return WeatherCondition.cold;
    if (temp < 5) return WeatherCondition.freezing;
    return WeatherCondition.unknown;
  }
}

double tempToMeterFactor(double temp) {
  if (temp < 5) {
    // Freezing (0–0.1)
    return ((temp + 10) / 15 * 0.1).clamp(0.0, 0.1);
  } else if (temp < 20) {
    // Cold (0.1–0.4)
    return 0.1 + ((temp - 5) / 15 * 0.3).clamp(0.0, 0.3);
  } else if (temp < 30) {
    // Mild (0.4–0.7)
    return 0.4 + ((temp - 20) / 10 * 0.3).clamp(0.0, 0.3);
  } else if (temp < 35) {
    // Warm (0.7–0.9)
    return 0.7 + ((temp - 30) / 5 * 0.2).clamp(0.0, 0.2);
  } else {
    // Hot (≥35)
    return 1.0; // Always full
  }
}
