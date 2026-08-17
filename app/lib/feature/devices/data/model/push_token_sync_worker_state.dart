import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

sealed class PushTokenSyncWorkerState {
  const new();

  const factory absent() = PushTokenSyncWorkerAbsent;
  const factory syncing({required int attempt}) =
      PushTokenSyncWorkerSyncing;
  const factory waiting({
    required int attempt,
    required DeviceProvisioningException error,
    required DateTime resumeAt,
  }) = PushTokenSyncWorkerWaiting;
  const factory synced() = PushTokenSyncWorkerSynced;
  const factory failed({
    required int attempt,
    required DeviceProvisioningException error,
  }) = PushTokenSyncWorkerFailed;
  const factory disposed() =
      PushTokenSyncWorkerDisposed;
}

final class PushTokenSyncWorkerAbsent extends PushTokenSyncWorkerState {
  const new();
}

final class PushTokenSyncWorkerSyncing extends PushTokenSyncWorkerState {
  const new({required this.attempt});

  final int attempt;
}

final class PushTokenSyncWorkerWaiting extends PushTokenSyncWorkerState {
  const new({
    required this.attempt,
    required this.error,
    required this.resumeAt,
  });

  final int attempt;
  final DeviceProvisioningException error;
  final DateTime resumeAt;
}

final class PushTokenSyncWorkerSynced extends PushTokenSyncWorkerState {
  const new();
}

final class PushTokenSyncWorkerFailed extends PushTokenSyncWorkerState {
  const new({required this.attempt, required this.error});

  final int attempt;
  final DeviceProvisioningException error;
}

final class PushTokenSyncWorkerDisposed extends PushTokenSyncWorkerState {
  const new();
}
