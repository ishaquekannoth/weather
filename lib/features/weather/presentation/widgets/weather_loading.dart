import 'package:flutter/material.dart';

class WeatherLoadingWidget extends StatefulWidget {
  const WeatherLoadingWidget({super.key});

  @override
  State<WeatherLoadingWidget> createState() => _WeatherLoadingWidgetState();
}

class _WeatherLoadingWidgetState extends State<WeatherLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.7,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Colors.blue.shade200,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated sun emoji
            ScaleTransition(
              scale: _animation,
              child: const Text('☀️', style: TextStyle(fontSize: 80)),
            ),
            const SizedBox(height: 16),
            Text(
              'Fetching the latest weather...',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white54,
                color: Colors.yellow.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
