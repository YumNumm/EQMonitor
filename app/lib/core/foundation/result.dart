import 'dart:async';

/// sealed classに準拠したResultクラスを生成
sealed class Result<S, E extends Exception> {
  const Result();

  static Future<Result<V, Exception>> capture<V>(
    FutureOr<V> Function() fn,
  ) async {
    try {
      return Success(await fn.call());
    } on Exception catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
  }

  static Future<Result<V, E>> captureSelected<V, E extends Exception>(
    FutureOr<V> Function() fn,
  ) async {
    try {
      return Success(await fn.call());
    } on E catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
  }

  static Result<V, Exception> success<V>(V value) => Success(value);
  static Result<V, Exception> failure<V>(Exception exception) =>
      Failure(exception);
}

/// Resultクラスに準拠したSuccessクラス
final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);

  final S value;
}

/// Resultクラスに準拠したFailureクラス
final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception, [this.stackTrace]);

  final E exception;
  final StackTrace? stackTrace;
}
