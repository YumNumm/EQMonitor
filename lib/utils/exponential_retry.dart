import 'dart:async';

/// 指数バックオフの実装
/// [maxRetries] は最大リトライ回数
/// 2のmaxRetries秒までリトライ試行します。
class ExponentialBackoff {
  ExponentialBackoff({this.maxRetries = 5});

  ///   最大再試行回数
  final int maxRetries;

  int _retryCount = 0;

  /// 指数バックオフの実装
  /// [maxRetries] は最大リトライ回数
  Future<T> retry<T>(
    FutureOr<T> Function() callback, {
    void Function(
      Exception exception, [
      StackTrace stackTrace,
      int retryCount,
    ])?
        onError,
  }) async {
    try {
      return await callback();
    } on Exception catch (e, stackTrace) {
      onError?.call(e, stackTrace, _retryCount);
      if (_retryCount >= maxRetries) {
        throw ExponentioalBackoffException(e, stackTrace, _retryCount);
      }
      _retryCount++;
      await Future<void>.delayed(Duration(seconds: 2 ^ _retryCount));
      return _internalRetry(callback, onError);
    }
  }

  Future<T> _internalRetry<T>(
    FutureOr<T> Function() callback,
    void Function(
      Exception exception, [
      StackTrace stackTrace,
      int retryCount,
    ])?
        onError,
  ) async {
    try {
      return await callback();
    } on Exception catch (e, stackTrace) {
      onError?.call(e, stackTrace, _retryCount);
      if (_retryCount >= maxRetries) {
        throw ExponentioalBackoffException(e, stackTrace, _retryCount);
      }
      _retryCount++;
      await Future<void>.delayed(Duration(seconds: 2 ^ _retryCount));
      return _internalRetry(callback, onError);
    }
  }
}

/// 指数バックオフの例外
/// リトライ回数が上限に達した場合に投げられます。
class ExponentioalBackoffException implements Exception {
  ExponentioalBackoffException(
    this.finalException,
    this.stackTrace,
    this.retryCount,
  );

  final Exception finalException;
  final StackTrace stackTrace;
  final int retryCount;

  @override
  String toString() {
    return 'ExponentioalBackoffException{'
        'finalException: $finalException, '
        'stackTrace: $stackTrace, '
        'retryCount: $retryCount'
        '}';
  }
}
