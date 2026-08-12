import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_worker_state.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';

/// 3種類のプッシュトークンそれぞれの同期状態スナップショット。
final class PushTokenSyncSnapshot {
  const PushTokenSyncSnapshot({
    required this.fcm,
    required this.apnsNotification,
    required this.apnsPushToStart,
  });

  final PushTokenKindState fcm;
  final PushTokenKindState apnsNotification;
  final PushTokenKindState apnsPushToStart;

  bool get allSynced => kindEntries.every(
    (entry) => switch (entry.value) {
      SyncedTokenState() ||
      NotApplicableTokenState() ||
      AbsentTokenState() => true,
      SyncingTokenState() || WaitingTokenState() || FailedTokenState() => false,
    },
  );

  bool get hasFailed =>
      kindEntries.any((entry) => entry.value is FailedTokenState);

  RetryControllerState get retryState {
    for (final entry in kindEntries) {
      final kindState = entry.value;
      if (kindState case FailedTokenState(:final error)) {
        return RetryExhausted(lastError: error);
      }
    }
    for (final entry in kindEntries) {
      final kindState = entry.value;
      if (kindState case WaitingTokenState(
        :final attempt,
        :final resumeAt,
        :final error,
      )) {
        return RetryWaiting(
          attempt: attempt,
          resumeAt: resumeAt,
          lastError: error,
        );
      }
    }
    for (final entry in kindEntries) {
      final kindState = entry.value;
      if (kindState case SyncingTokenState(:final attempt)) {
        return RetryRunning(attempt: attempt);
      }
    }
    return  RetryIdle();
  }

  Iterable<MapEntry<PushTokenKind, PushTokenKindState>> get kindEntries => [
    MapEntry(PushTokenKind.fcm, fcm),
    MapEntry(PushTokenKind.apnsNotification, apnsNotification),
    MapEntry(PushTokenKind.apnsPushToStart, apnsPushToStart),
  ];

  PushTokenSyncSnapshot copyWith({
    PushTokenKindState? fcm,
    PushTokenKindState? apnsNotification,
    PushTokenKindState? apnsPushToStart,
  }) => PushTokenSyncSnapshot(
    fcm: fcm ?? this.fcm,
    apnsNotification: apnsNotification ?? this.apnsNotification,
    apnsPushToStart: apnsPushToStart ?? this.apnsPushToStart,
  );

  PushTokenSyncSnapshot updateKind({
    required PushTokenKind kind,
    required PushTokenKindState kindState,
  }) => switch (kind) {
    .fcm => copyWith(fcm: kindState),
    .apnsNotification => copyWith(apnsNotification: kindState),
    .apnsPushToStart => copyWith(apnsPushToStart: kindState),
  };
}

sealed class PushTokenKindState {
  const PushTokenKindState();
}

final class NotApplicableTokenState extends PushTokenKindState {
  const NotApplicableTokenState();
}

final class AbsentTokenState extends PushTokenKindState {
  const AbsentTokenState();
}

final class SyncingTokenState extends PushTokenKindState {
  const SyncingTokenState({required this.attempt});

  final int attempt;
}

final class WaitingTokenState extends PushTokenKindState {
  const WaitingTokenState({
    required this.attempt,
    required this.error,
    required this.resumeAt,
  });

  final int attempt;
  final DeviceProvisioningException error;
  final DateTime resumeAt;
}

final class SyncedTokenState extends PushTokenKindState {
  const SyncedTokenState();
}

final class FailedTokenState extends PushTokenKindState {
  const FailedTokenState({required this.error});

  final DeviceProvisioningException error;
}

PushTokenKindState pushTokenKindStateFromWorker(
  PushTokenSyncWorkerState workerState,
) => switch (workerState) {
  PushTokenSyncWorkerAbsent() ||
  PushTokenSyncWorkerDisposed() => const AbsentTokenState(),
  PushTokenSyncWorkerSyncing(:final attempt) => SyncingTokenState(
    attempt: attempt,
  ),
  PushTokenSyncWorkerWaiting(:final attempt, :final error, :final resumeAt) =>
    WaitingTokenState(attempt: attempt, error: error, resumeAt: resumeAt),
  PushTokenSyncWorkerSynced() => const SyncedTokenState(),
  PushTokenSyncWorkerFailed(:final error) => FailedTokenState(error: error),
};
