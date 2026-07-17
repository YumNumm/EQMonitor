import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('copyWith updates only the selected immutable entry', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: AbsentTokenState(),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: SyncedTokenState(),
    );

    final updated = snapshot.copyWith(fcm: const SyncingTokenState(attempt: 0));

    expect(updated.fcm, isA<SyncingTokenState>());
    expect(updated.apnsNotification, same(snapshot.apnsNotification));
    expect(updated.apnsPushToStart, same(snapshot.apnsPushToStart));
  });

  test('aggregate retry state prioritizes failed over waiting and running', () {
    final snapshot = PushTokenSyncSnapshot(
      fcm: const SyncingTokenState(attempt: 2),
      apnsNotification: WaitingTokenState(
        attempt: 1,
        error: const NetworkUnreachableException(),
        resumeAt: DateTime.utc(2026),
      ),
      apnsPushToStart: const FailedTokenState(
        error: AuthorizationException(
          reason: AuthorizationFailureReason.unauthenticated,
        ),
      ),
    );

    final retryState = snapshot.retryState;

    expect(retryState, isA<RetryExhausted>());
    expect(
      (retryState as RetryExhausted).lastError,
      isA<AuthorizationException>(),
    );
  });

  test('aggregate retry state prioritizes waiting over running', () {
    final resumeAt = DateTime.utc(2026);
    final snapshot = PushTokenSyncSnapshot(
      fcm: const SyncingTokenState(attempt: 2),
      apnsNotification: WaitingTokenState(
        attempt: 1,
        error: const NetworkUnreachableException(),
        resumeAt: resumeAt,
      ),
      apnsPushToStart: const SyncedTokenState(),
    );

    final retryState = snapshot.retryState;

    expect(retryState, isA<RetryWaiting>());
    expect((retryState as RetryWaiting).resumeAt, resumeAt);
    expect(retryState.attempt, 1);
  });

  test('aggregate retry state is running when a worker is syncing', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncingTokenState(attempt: 3),
      apnsNotification: SyncedTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.retryState, isA<RetryRunning>());
    expect((snapshot.retryState as RetryRunning).attempt, 3);
  });
}
