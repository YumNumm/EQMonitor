import 'dart:math';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

const _retryBaseDelay = Duration(seconds: 2);
const _retryMaxDelay = Duration(seconds: 60);
const _retryMaxAttempts = 6;

sealed class RetryControllerState();

final class RetryIdle() extends RetryControllerState;

final class RetryRunning({required int attempt}) extends RetryControllerState ;

final class RetryWaiting({required int attempt, required DateTime resumeAt, required DeviceProvisioningException lastError}) extends RetryControllerState;

final class RetryExhausted({required DeviceProvisioningException lastError}) extends RetryControllerState;

/// 指数バックオフで operation を繰り返し実行する制御クラス
class RetryController({
  required Future<void> Function(Duration) _delay,
}) {
  final _random = Random();

  RetryControllerState _state = const RetryIdle();
  RetryControllerState get state => _state;

  void Function(RetryControllerState)? onStateChanged;

  var _cancelled = false;

  void cancel() => _cancelled = true;

  void reset() {
    _cancelled = false;
    _setState(const RetryIdle());
  }

  Future<T> run<T>(Future<T> Function() operation) async {
    _cancelled = false;
    var attempt = 0;

    while (true) {
      _setState(RetryRunning(attempt: attempt));

      try {
        final result = await operation();
        _setState(const RetryIdle());
        return result;
      } on DeviceProvisioningException catch (e) {
        if (!e.isRetryable || attempt >= _retryMaxAttempts - 1) {
          _setState(RetryExhausted(lastError: e));
          rethrow;
        }

        final waitDuration = _computeDelay(e, attempt);
        final resumeAt = DateTime.now().add(waitDuration);
        _setState(
          RetryWaiting(attempt: attempt, resumeAt: resumeAt, lastError: e),
        );

        await _delay(waitDuration);

        if (_cancelled) {
          _setState(RetryExhausted(lastError: e));
          rethrow;
        }

        attempt++;
      }
    }
  }

  Duration _computeDelay(DeviceProvisioningException e, int attempt) {
    if (e case RateLimitedException(:final int retryAfter)) {
      return Duration(seconds: retryAfter);
    }
    final base = _retryBaseDelay.inMilliseconds * (1 << attempt);
    final jitter = _random.nextInt(1000);
    final total = Duration(milliseconds: base + jitter);
    return total > _retryMaxDelay ? _retryMaxDelay : total;
  }

  void _setState(RetryControllerState s) {
    _state = s;
    onStateChanged?.call(s);
  }
}
