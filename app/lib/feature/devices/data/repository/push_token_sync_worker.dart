import 'dart:async';

import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';

/// 1種類のプッシュトークン（FCM / APNs 等）を独立してサーバーへ同期するワーカー。
///
/// - [accept] は最新のトークンを保持し、進行中の待機を中断し、
///   ポンプ（[process] ループ）が動いていなければ起動する。
/// - セッション内での同一トークンの重複送信は行わない
///   （直前に同期済みのトークンと同じ場合は upsert をスキップする）。
/// - リトライ可能なエラーは [PushTokenBackoff] による指数バックオフで自動的に再試行し、
///   回数上限は設けない。
/// - リトライ不可のエラーでは停止し、[retry] が呼ばれるまで再開しない。
class PushTokenSyncWorker {
  PushTokenSyncWorker({
    required this.upsert,
    this.backoff = const PushTokenBackoff(),
    Future<void> Function(Duration)? delayOverride,
  }) : _backoffWait = InterruptibleBackoff(delayOverride: delayOverride);

  /// サーバーへトークンを送信する処理。
  final Future<void> Function(String token) upsert;

  /// リトライ間隔を計算するポリシー。
  final PushTokenBackoff backoff;

  final InterruptibleBackoff _backoffWait;
  final _statesController =
      StreamController<PushTokenSyncWorkerState>.broadcast();

  PushTokenSyncWorkerState _state = const PushTokenSyncWorkerState.absent();

  /// 現在の状態。
  PushTokenSyncWorkerState get state => _state;

  set state(PushTokenSyncWorkerState value) {
    _state = value;
    if (!_statesController.isClosed) {
      _statesController.add(value);
    }
  }

  /// 状態遷移のストリーム。
  Stream<PushTokenSyncWorkerState> get states => _statesController.stream;

  String? _latestToken;
  String? _lastSyncedToken;
  int _attempt = 0;
  Future<void>? _pumpFuture;
  var _isDisposed = false;

  /// 最新のトークンを受け付ける。
  ///
  /// 進行中の待機があれば中断し、ポンプが動いていなければ [process] を起動する。
  void accept({required String token}) {
    if (_isDisposed || token.isEmpty) {
      return;
    }
    _latestToken = token;
    _backoffWait.interrupt();
    if (_pumpFuture == null) {
      _pumpFuture = process().whenComplete(() => _pumpFuture = null);
    }
  }

  /// [FailedWorkerState]（リトライ不可エラーで停止中）から再開する。
  void retry() {
    if (_isDisposed || _state is! FailedWorkerState) {
      return;
    }
    if (_latestToken == null) {
      return;
    }
    if (_pumpFuture == null) {
      _pumpFuture = process().whenComplete(() => _pumpFuture = null);
    }
  }

  /// 最新トークンを同期するまで（または失敗・破棄されるまで）繰り返すポンプ本体。
  ///
  /// クラスプライベートメソッドを使わない方針のため public。
  /// [accept] / [retry] からのみ、ポンプが未起動のときに起動される。
  Future<void> process() async {
    while (true) {
      if (_isDisposed) {
        return;
      }

      final attemptedToken = _latestToken;
      if (attemptedToken == null || attemptedToken.isEmpty) {
        return;
      }

      if (attemptedToken == _lastSyncedToken) {
        // 既に同期済みのトークンと同じ場合は何もしない（重複した状態通知も避ける）。
        if (_state is! SyncedWorkerState) {
          state = const PushTokenSyncWorkerState.synced();
        }
        return;
      }

      state = const PushTokenSyncWorkerState.syncing();

      try {
        await upsert(attemptedToken);
      } on DeviceProvisioningException catch (error) {
        if (_isDisposed) {
          return;
        }

        if (!error.isRetryable) {
          state = PushTokenSyncWorkerState.failed(error: error);
          return;
        }

        final retryAfter = error is RateLimitedException
            ? error.retryAfter
            : null;
        final duration = backoff.durationFor(
          attempt: _attempt,
          retryAfter: retryAfter,
        );
        state = PushTokenSyncWorkerState.waiting(
          attempt: _attempt,
          resumeAt: DateTime.now().add(duration),
        );

        await _backoffWait.wait(duration);

        if (_isDisposed) {
          return;
        }
        // 待機中にトークンが変わっていたら、新しいトークンとして仕切り直す。
        _attempt = _latestToken == attemptedToken ? _attempt + 1 : 0;
        continue;
      }

      if (_isDisposed) {
        return;
      }

      if (_latestToken == attemptedToken) {
        _lastSyncedToken = attemptedToken;
        _attempt = 0;
        state = const PushTokenSyncWorkerState.synced();
        return;
      }
      // upsert 中に新しいトークンが届いていたら、そちらを送るためループし直す。
      _attempt = 0;
    }
  }

  /// このワーカーを破棄する。以後 [accept] / [retry] は何もしない。
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    _backoffWait.dispose();
    state = const PushTokenSyncWorkerState.disposed();
    unawaited(_statesController.close());
  }
}
