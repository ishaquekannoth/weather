import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/di.dart' show initDependencies, serviceLocator;
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411.4, 914.3),
      splitScreenMode: false,
      enableScaleText: () => true,
      enableScaleWH: () => true,
      ensureScreenSize: true,
      fontSizeResolver: (fontSize, instance) => fontSize * 1,
      minTextAdapt: true,
      rebuildFactor: (old, data) => old != data,
      useInheritedMediaQuery: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (BuildContext context) => serviceLocator<WeatherBloc>(),
          ),
        ],
        child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: WeatherPage(),
        ),
      ),
    );
  }
}
