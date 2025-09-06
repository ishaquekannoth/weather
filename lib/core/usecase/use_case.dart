import 'package:fpdart/fpdart.dart';
import 'package:weather/core/error/failure.dart';

abstract interface class UseCase<T, R> {
  Future<Either<Failure, T>> call({required R parameters});
}

abstract interface class UseCaseSync<T, R> {
  T call({required R parameters});
}

class NoParam {}
