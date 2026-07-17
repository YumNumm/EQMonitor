import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

sealed class PushTokenSyncWorkerState {
  const PushTokenSyncWorkerState();

  const factory PushTokenSyncWorkerState.absent() = PushTokenSyncWorkerAbsent;
  const factory PushTokenSyncWorkerState.syncing({required int attempt}) =
      PushTokenSyncWorkerSyncing;
  const factory PushTokenSyncWorkerState.waiting({
    required int attempt,
    required DeviceProvisioningException error,
    required DateTime resumeAt,
  }) = PushTokenSyncWorkerWaiting;
  const factory PushTokenSyncWorkerState.synced() = PushTokenSyncWorkerSynced;
  const factory PushTokenSyncWorkerState.failed({
    required int attempt,
    required DeviceProvisioningException error,
  }) = PushTokenSyncWorkerFailed;
  const factory PushTokenSyncWorkerState.disposed() =
      PushTokenSyncWorkerDisposed;
}

final class PushTokenSyncWorkerAbsent extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerAbsent();
}

final class PushTokenSyncWorkerSyncing extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerSyncing({required this.attempt});

  final int attempt;
}

final class PushTokenSyncWorkerWaiting extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerWaiting({
    required this.attempt,
    required this.error,
    required this.resumeAt,
  });

  final int attempt;
  final DeviceProvisioningException error;
  final DateTime resumeAt;
}

final class PushTokenSyncWorkerSynced extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerSynced();
}

final class PushTokenSyncWorkerFailed extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerFailed({required this.attempt, required this.error});

  final int attempt;
  final DeviceProvisioningException error;
}

final class PushTokenSyncWorkerDisposed extends PushTokenSyncWorkerState {
  const PushTokenSyncWorkerDisposed();
}
