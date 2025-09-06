enum RequestMethod {
  getRequest,
  postRequest,
  putRequest,
  deleteRequest,
  patchRequest,
  headRequest,
}

extension RESTMethodString on RequestMethod {
  String get getMethodName {
    switch (this) {
      case RequestMethod.getRequest:
        return "GET";
      case RequestMethod.postRequest:
        return "POST";
      case RequestMethod.putRequest:
        return "PUT";
      case RequestMethod.deleteRequest:
        return "DELETE";
      case RequestMethod.patchRequest:
        return "PATCH";
      case RequestMethod.headRequest:
        return "HEAD";
    }
  }
}

enum ErrorMessageType {
  messageFromResponseBody,
  messageDefaultByDio,
  messageCustomised,
}

T sanitize<T>(dynamic value, {T? defaultValue}) {
  try {
    // Handle null and empty values
    if (value == null || (value is String && value.trim().isEmpty)) {
      return defaultValue ?? _defaultValue<T>();
    }

    // If the value is already of expected type
    if (value is T) {
      return value;
    }

    // Attempt to convert
    if (T == String) return value.toString() as T;
    if (T == int) {
      return int.tryParse(value.toString()) as T? ?? defaultValue ?? 0 as T;
    }
    if (T == double) {
      return double.tryParse(value.toString()) as T? ??
          defaultValue ??
          0.0 as T;
    }
    if (T == num) {
      return num.tryParse(value.toString()) as T? ?? defaultValue ?? 0 as T;
    }
    if (T == bool) return (_parseBool(value)) as T;
  } catch (_) {
    return defaultValue ?? _defaultValue<T>();
  }

  return defaultValue ?? _defaultValue<T>();
}

T _defaultValue<T>() {
  if (T == String) return 'Unknown' as T;
  if (T == int) return 0 as T;
  if (T == double) return 0.0 as T;
  if (T == num) return 0 as T;
  if (T == bool) return false as T;
  throw UnsupportedError("No default value for type $T");
}

bool _parseBool(dynamic value) {
  final str = value.toString().toLowerCase().trim();
  return str == 'true' || str == '1' || str == 'yes';
}
