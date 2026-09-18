import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';

sealed class const PushTokenSyncWorkerState() {
  const factory absent() = PushTokenSyncWorkerAbsent;
  const factory syncing({required int attempt}) = PushTokenSyncWorkerSyncing;
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
  const factory disposed() = PushTokenSyncWorkerDisposed;
}

final class const PushTokenSyncWorkerAbsent() extends PushTokenSyncWorkerState;

final class const PushTokenSyncWorkerSyncing({required final int attempt})
    extends PushTokenSyncWorkerState;

final class const PushTokenSyncWorkerWaiting({
  required final int attempt,
  required final DeviceProvisioningException error,
  required final DateTime resumeAt,
}) extends PushTokenSyncWorkerState;

final class const PushTokenSyncWorkerSynced() extends PushTokenSyncWorkerState;

final class const PushTokenSyncWorkerFailed({
  required final int attempt,
  required final DeviceProvisioningException error,
}) extends PushTokenSyncWorkerState;

final class const PushTokenSyncWorkerDisposed()
    extends PushTokenSyncWorkerState;
