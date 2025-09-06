import 'package:weather/core/error/failure.dart';

class DefaultFailure extends Failure {
  DefaultFailure({super.message = 'Network error occurred'});
}

final class ResponseParsingFailure extends Failure {
  String? errorMessage;
  ResponseParsingFailure({
    this.errorMessage = "Response received successfully..Invalid JSON",
  });

  @override
  String toString() => '$errorMessage';
}
