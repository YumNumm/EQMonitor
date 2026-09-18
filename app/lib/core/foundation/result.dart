import 'dart:async';

sealed class const Result<S, E extends Exception>() {
  static Future<Result<V, E>> capture<V, E extends Exception>(
    FutureOr<V> Function() fn,
  ) async {
    try {
      return Success(await fn.call());
    } on E catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
  }

  S unwrap() => switch (this) {
    Success(:final value) => value,
    Failure(:final exception) => throw exception,
  };

  S unwrapOr(S defaultValue) => switch (this) {
    Success(:final value) => value,
    Failure() => defaultValue,
  };
}

final class const Success<S, E extends Exception>(final S value)
    extends Result<S, E>;

final class const Failure<S, E extends Exception>(
  final E exception, [
  final StackTrace? stackTrace,
]) extends Result<S, E>;
