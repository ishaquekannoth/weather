

import 'package:weather/core/error/network_exceptions.dart';

final class Result<T> {
  final T? successResponse;
  final NetworkFailure? failure;

  Result.success({required this.successResponse}) : failure = null;

  Result.failure({required this.failure}) : successResponse = null;

  bool get isSuccess => successResponse != null;

  bool get isFailure => failure != null;

  @override
  String toString() =>
      isSuccess ? successResponse.toString() : failure.toString();
}

final Map<int, String> customMessageMap = {
  -1: "Couldnt map the provided status code",
  300: "Multiple options for the requested resource",
  301: "Resource has been permanently moved",
  302: "Resource temporarily found at a different location",
  303: "Redirect to another resource",
  304: "Resource not modified since the last request",
  305: "Must access the requested resource through a proxy",
  307: "Temporary redirect to another resource",
  308: "Permanent redirect to another resource",
  310: "Too many redirects encountered",
  400:
      "The server could not understand the request due to invalid syntax or missing parameters.",
  401: "Un Authorised Request",
  403: "The server understood the request, but is refusing to fulfill it.",
  404: "The requested resource could not be found.",
  405: "The request method is not supported for the requested resource.",
  406:
      "The requested resource is not capable of generating a response matching the list of acceptable values defined in the request's headers.",
  408: "The server timed out waiting for the request.",
  409:
      "The request could not be completed due to a conflict with the current state of the resource.",
  410:
      "The requested resource is no longer available and has been permanently removed.",
  411:
      "The server requires a Content-Length header to be included in the request.",
  412: "The server detected a pre-condition failure.",
  413: "The payload size exceeds the maximum allowed.",
  414: "The URI requested by the client is too long for the server to process.",
  415: "The media type of the requested data is not supported by the server.",
  416:
      "The range specified by the Range header field in the request can't be fulfilled.",
  417:
      "The expectation given in the request's Expect header field could not be met.",
  418: "I'm a teapot.",
  422:
      "The server understands the content type of the request entity, but was unable to process the contained instructions.",
  425:
      "The server is unwilling to risk processing a request that might be replayed.",
  426:
      "The client should switch to a different protocol such as TLS/1.3, given in the Upgrade header field.",
  428: "The server requires the request to be conditional.",
  429: "The user has sent too many requests in a given amount of time.",
  431:
      "The server is unwilling to process the request because its header fields are too large.",
  451:
      "The server is denying access to a resource as a consequence of a legal demand.",
  500:
      "The server encountered an unexpected condition that prevented it from fulfilling the request.",
  501:
      "The server does not support the functionality required to fulfill the request.",
  502:
      "The server received an invalid response from an upstream server while attempting to fulfill the request.",
  503:
      "The server is currently unable to handle the request due to a temporary overload or maintenance.",
  504: "Gateway Timeout",
  505: "HTTP Version Not Supported",
  506: "Variant Also Negotiates",
  507: "Insufficient Storage",
  508: "Loop Detected",
  510: "Not Extended",
  511: "Network Authentication Required",
};
