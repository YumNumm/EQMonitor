import 'dart:math';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

const _retryBaseDelay = Duration(seconds: 2);
const _retryMaxDelay = Duration(seconds: 60);
const _retryMaxAttempts = 6;

sealed class RetryControllerState {
  const RetryControllerState();
}

/// 待機中 — まだ実行していない、または正常完了後。
final class RetryIdle extends RetryControllerState {
  const RetryIdle();
}

/// 実行中。
final class RetryRunning extends RetryControllerState {
  const RetryRunning({required this.attempt});

  final int attempt;
}

/// 次の試行まで待機中。
final class RetryWaiting extends RetryControllerState {
  const RetryWaiting({
    required this.attempt,
    required this.resumeAt,
    required this.lastError,
  });

  final int attempt;
  final DateTime resumeAt;
  final DeviceProvisioningException lastError;
}

/// 最大試行回数到達、またはリトライ不可エラー。
final class RetryExhausted extends RetryControllerState {
  const RetryExhausted({required this.lastError});

  final DeviceProvisioningException lastError;
}

/// 指数バックオフで operation を繰り返し実行する制御クラス。
///
/// delayOverride はテスト用に時間進行を置き換えるための注入口
/// （デフォルト: Future.delayed）。
class RetryController {
  RetryController({Future<void> Function(Duration)? delayOverride})
    : _delay = delayOverride ?? Future<void>.delayed;

  final Future<void> Function(Duration) _delay;

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

  /// operation を最大 _retryMaxAttempts 回試行する。
  /// 成功したら戻り値を返す。全試行失敗で最後の例外を throw。
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
    if (e case RateLimitedException(retryAfter: final Duration retryAfter)) {
      return retryAfter;
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
