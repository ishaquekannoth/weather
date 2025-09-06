import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/core/network/dio/network_enums.dart';
import 'package:weather/core/network/utils/api_result.dart';

class NetworkFailure extends Failure {
  final bool isResponseErr;
  final DioExceptionType? errorType;
  NetworkFailure({
    required super.message,
    required this.errorType,
    this.isResponseErr = false,
  });

  factory NetworkFailure.fromDioError({
    required DioException dioError,
    String? messagePath,
    ErrorMessageType? messageType = ErrorMessageType.messageCustomised,
  }) {
    if (dioError.error is SocketException || dioError.error is HttpException) {
      return NetworkFailure(
        errorType: dioError.type,
        isResponseErr: false,
        message: "Please check your Network Connectivity",
      );
    }

    switch (dioError.type) {
      case DioExceptionType.cancel:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "Request to API server was cancelled",
        );
      case DioExceptionType.connectionTimeout:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "mmm...its taking too long, try again",
        );
      case DioExceptionType.unknown:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "Something went wrong. Please try again later",
        );
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "oops its taking too long than expected, try again",
        );
      case DioExceptionType.badResponse:
        return _handleResponseError(
          messagePath: messagePath,
          statusCode: dioError.response?.statusCode ?? 0,
          errorMessageType: messageType!,
          error: dioError,
        );
      case DioExceptionType.sendTimeout:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "Send timeout, try again",
        );
      case DioExceptionType.badCertificate:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "Bad Certificate",
        );
      default:
        return NetworkFailure(
          errorType: dioError.type,
          isResponseErr: false,
          message: "Unknown Error...try again later",
        );
    }
  }

  static NetworkFailure _handleResponseError({
    required int statusCode,
    required DioException error,
    String? messagePath,
    ErrorMessageType errorMessageType = ErrorMessageType.messageCustomised,
  }) {
    assert(
      errorMessageType != ErrorMessageType.messageFromResponseBody ||
          messagePath != null,
      "Please provide the path to the response error message",
    );

    String serverMessage;
    try {
      serverMessage =
          error.response?.data[messagePath]?.toString() ??
          "Oops ..Server Error";
    } catch (_) {
      serverMessage = 'Err: [$messagePath] Not Found';
    }

    return _statusCodeToFailureMapper(
      error: error,
      serverMessage: serverMessage,
      statusCode: statusCode,
      errorMessageType: errorMessageType,
    );
  }

  static NetworkFailure _statusCodeToFailureMapper({
    required int statusCode,
    required DioException error,
    required String serverMessage,
    ErrorMessageType errorMessageType = ErrorMessageType.messageCustomised,
  }) {
    return errorMessageType == ErrorMessageType.messageFromResponseBody
        ? NetworkFailure(errorType: error.type, message: serverMessage)
        : errorMessageType == ErrorMessageType.messageDefaultByDio
        ? NetworkFailure(
            errorType: error.type,
            message: error.message ?? 'Unknown Error',
          )
        : NetworkFailure(
            errorType: error.type,
            message: customMessageMap.entries
                .firstWhere(
                  (entry) => entry.key == statusCode,
                  orElse: () => customMessageMap.entries.first,
                )
                .value,
          );
  }
}
