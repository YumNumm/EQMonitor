import 'dart:async';

const _maximumBackoff = Duration(seconds: 60);

final class PushTokenBackoff {
  const new();

  Duration durationFor({required int attempt, Duration? retryAfter}) {
    if (retryAfter != null) {
      return retryAfter > _maximumBackoff ? _maximumBackoff : retryAfter;
    }
    if (attempt >= 5) {
      return _maximumBackoff;
    }
    return Duration(seconds: 2 << attempt);
  }
}

final class InterruptibleBackoff {
  new({Future<void> Function(Duration)? delayOverride})
    : _delay = delayOverride ?? Future<void>.delayed;

  final Future<void> Function(Duration) _delay;
  Completer<void>? _wakeSignal;
  var _disposed = false;

  Future<void> wait(Duration duration) async {
    if (_disposed) {
      return;
    }

    final wakeSignal = Completer<void>();
    _wakeSignal = wakeSignal;
    try {
      await Future.any<void>([_delay(duration), wakeSignal.future]);
    } finally {
      if (identical(_wakeSignal, wakeSignal)) {
        _wakeSignal = null;
      }
    }
  }

  void interrupt() {
    final wakeSignal = _wakeSignal;
    if (wakeSignal != null && !wakeSignal.isCompleted) {
      wakeSignal.complete();
    }
  }

  void dispose() {
    _disposed = true;
    interrupt();
  }
}
