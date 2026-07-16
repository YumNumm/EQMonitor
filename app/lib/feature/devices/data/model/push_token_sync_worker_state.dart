import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

/// [PushTokenSyncWorker] が公開する同期状態。
///
/// - [AbsentWorkerState]: まだトークンを受け取っていない。
/// - [SyncingWorkerState]: サーバーへ upsert 中。
/// - [WaitingWorkerState]: リトライ可能なエラーの後、指数バックオフで待機中。
/// - [SyncedWorkerState]: 最新のトークンが同期済み。
/// - [FailedWorkerState]: リトライ不可のエラーで停止中（[PushTokenSyncWorker.retry] 待ち）。
/// - [DisposedWorkerState]: [PushTokenSyncWorker.dispose] 済み。
sealed class PushTokenSyncWorkerState {
  const PushTokenSyncWorkerState();

  const factory PushTokenSyncWorkerState.absent() = AbsentWorkerState;

  const factory PushTokenSyncWorkerState.syncing() = SyncingWorkerState;

  const factory PushTokenSyncWorkerState.waiting({
    required int attempt,
    required DateTime resumeAt,
    required DeviceProvisioningException error,
  }) = WaitingWorkerState;

  const factory PushTokenSyncWorkerState.synced() = SyncedWorkerState;

  const factory PushTokenSyncWorkerState.failed({
    required DeviceProvisioningException error,
  }) = FailedWorkerState;

  const factory PushTokenSyncWorkerState.disposed() = DisposedWorkerState;
}

/// まだトークンを受け取っていない初期状態。
final class AbsentWorkerState extends PushTokenSyncWorkerState {
  const AbsentWorkerState();
}

/// サーバーへ upsert 中。
final class SyncingWorkerState extends PushTokenSyncWorkerState {
  const SyncingWorkerState();
}

/// リトライ可能なエラーの後、次の試行まで待機中。
final class WaitingWorkerState extends PushTokenSyncWorkerState {
  const WaitingWorkerState({
    required this.attempt,
    required this.resumeAt,
    required this.error,
  });

  final int attempt;
  final DateTime resumeAt;

  /// 待機の原因となった、リトライ可能なエラー。
  final DeviceProvisioningException error;
}

/// 最新のトークンがサーバーと同期済み。
final class SyncedWorkerState extends PushTokenSyncWorkerState {
  const SyncedWorkerState();
}

/// リトライ不可のエラーで停止中。[PushTokenSyncWorker.retry] で再開できる。
final class FailedWorkerState extends PushTokenSyncWorkerState {
  const FailedWorkerState({required this.error});

  final DeviceProvisioningException error;
}

/// [PushTokenSyncWorker.dispose] 済み。以後トークンは受け付けない。
final class DisposedWorkerState extends PushTokenSyncWorkerState {
  const DisposedWorkerState();
}
