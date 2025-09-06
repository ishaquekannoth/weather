import 'package:weather/features/weather/data/model/weather_model.dart';

abstract interface class IRemoteDs {
  Future<WeatherModel> getWeatherForCity({required String cityName});
}
