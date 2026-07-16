import 'dart:async';

const _backoffBaseDelay = Duration(seconds: 2);
const _backoffMaxDelay = Duration(seconds: 60);

/// プッシュトークン同期ワーカー用の指数バックオフポリシー。
///
/// [attempt] 回目（0 始まり）の再試行までの待機時間を、
/// `_backoffBaseDelay * 2^attempt` として計算し、`_backoffMaxDelay` で頭打ちにする。
/// サーバーが `Retry-After` を返した場合は [retryAfter] を優先するが、
/// 同様に `_backoffMaxDelay` を上限とする。
class PushTokenBackoff {
  const PushTokenBackoff();

  Duration durationFor({required int attempt, Duration? retryAfter}) {
    final candidate = retryAfter ?? _backoffBaseDelay * (1 << attempt);
    return candidate > _backoffMaxDelay ? _backoffMaxDelay : candidate;
  }
}

/// 中断可能な待機を提供するクラス。
///
/// 通常は [wait] に渡した [Duration] の経過を待つが、待機中に [interrupt] が
/// 呼ばれると即座に完了する（新しいトークンが届いた等で再試行を早めたい場合）。
/// [dispose] 後は待機を新規にスケジュールせず、[wait] は即座に完了する。
class InterruptibleBackoff {
  InterruptibleBackoff({Future<void> Function(Duration)? delayOverride})
    : _delay = delayOverride ?? Future.delayed;

  final Future<void> Function(Duration) _delay;

  Completer<void>? _wakeSignal;
  var _isDisposed = false;

  /// [duration] の経過、または [interrupt]・[dispose] の呼び出しのいずれか
  /// 早い方まで待機する。
  Future<void> wait(Duration duration) async {
    if (_isDisposed) {
      return;
    }

    final signal = Completer<void>();
    _wakeSignal = signal;

    await Future.any([_delay(duration), signal.future]);

    if (identical(_wakeSignal, signal)) {
      _wakeSignal = null;
    }
  }

  /// 現在の待機（あれば）を即座に完了させる。
  void interrupt() {
    final signal = _wakeSignal;
    if (signal != null && !signal.isCompleted) {
      signal.complete();
    }
  }

  /// このインスタンスを破棄する。保留中の待機を完了させ、
  /// 以後の [wait] 呼び出しは新規待機をスケジュールせず即座に完了する。
  void dispose() {
    _isDisposed = true;
    interrupt();
  }
}
