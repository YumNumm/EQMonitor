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
}
