import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'allSynced is true when platform-inapplicable tokens are not pending',
    () {
      const snapshot = PushTokenSyncSnapshot(
        fcm: SyncedTokenState(),
        apnsNotification: NotApplicableTokenState(),
        apnsPushToStart: NotApplicableTokenState(),
      );

      expect(snapshot.allSynced, isTrue);
    },
  );

  test('allSynced is false when any token is pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: PendingTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isFalse);
  });

  test('allSynced is false when any token is syncing', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncingTokenState(),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isFalse);
  });

  test('allSynced is false when any token is failed', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: FailedTokenState(error: NetworkUnreachableException()),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isFalse);
  });

  test('allSynced is true when all synced or absent', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: AbsentTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isTrue);
  });

  test('hasPending returns true when any token is pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: PendingTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.hasPending, isTrue);
  });

  test('hasPending returns false when no tokens are pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: SyncingTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.hasPending, isFalse);
  });

  test('hasFailed returns true when any token has failed', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: FailedTokenState(error: NetworkUnreachableException()),
      apnsNotification: SyncedTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.hasFailed, isTrue);
  });

  test('hasFailed returns false when no tokens have failed', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: SyncingTokenState(),
      apnsPushToStart: PendingTokenState(),
    );

    expect(snapshot.hasFailed, isFalse);
  });
}
