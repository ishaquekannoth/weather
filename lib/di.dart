import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/network/dio/dio_services.dart';
import 'package:weather/features/weather/data/data_source_repo/i_local_ds.dart';
import 'package:weather/features/weather/data/data_source_repo/i_remote_ds.dart';
import 'package:weather/features/weather/data/repo_impl/local_ds_impl.dart';
import 'package:weather/features/weather/data/repo_impl/remote_ds_impl.dart';
import 'package:weather/features/weather/data/repo_impl/weather_repo_impl.dart';
import 'package:weather/features/weather/domain/repositories/i_weather_repo.dart';
import 'package:weather/features/weather/domain/usecases/weather_usecases.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Core / External dependencies
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  serviceLocator.registerLazySingleton<DioService>(() => DioService.instance);

  // Data sources

  serviceLocator.registerLazySingleton<ILocalDs>(
    () => LocalDsImpl(sharedPreferences: serviceLocator<SharedPreferences>()),
  );

  serviceLocator.registerLazySingleton<IRemoteDs>(
    () => RemoteDsImpl(dioService: serviceLocator<DioService>()),
  );

  // Repository

  serviceLocator.registerLazySingleton<IWeatherRepo>(
    () => WeatherRepoImpl(
      remoteDs: serviceLocator<IRemoteDs>(),
      localDs: serviceLocator<ILocalDs>(),
    ),
  );

  // Use cases

  serviceLocator.registerLazySingleton<FetchWeatherUseCase>(
    () => FetchWeatherUseCase(serviceLocator<IWeatherRepo>()),
  );

  serviceLocator.registerFactory<WeatherBloc>(
    () => WeatherBloc(fetchWeatherUseCase: serviceLocator()),
  );
  await serviceLocator.allReady();
}
