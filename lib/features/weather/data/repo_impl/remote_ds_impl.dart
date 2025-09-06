import 'package:dio/dio.dart';
import 'package:weather/core/error/common_failures.dart';
import 'package:weather/core/error/network_exceptions.dart';
import 'package:weather/core/network/dio/dio_services.dart';
import 'package:weather/core/network/dio/network_enums.dart';
import 'package:weather/core/network/utils/url_strings.dart';
import 'package:weather/features/weather/data/data_source_repo/i_remote_ds.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

class RemoteDsImpl implements IRemoteDs {
  final DioService dioService;

  RemoteDsImpl({required this.dioService});

  @override
  Future<WeatherModel> getWeatherForCity({required String cityName}) async {
    try {
      final Response response = await dioService.makeRESTrequest(
        urlPath: UrlStrings.baseUrl,
        method: RequestMethod.getRequest,
        baseOptions: BaseOptions(
          queryParameters: {
            "q": cityName,
            "appid": UtilStrings.apiKey,
            "units": "metric",
          },
        ),
      );
      return WeatherModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw NetworkFailure.fromDioError(
        messagePath: 'message',
        dioError: dioError,
        messageType: ErrorMessageType.messageFromResponseBody,
      );
    } catch (e) {
      throw DefaultFailure(message: "Its on Us..Something went wrong..");
    }
  }
}
