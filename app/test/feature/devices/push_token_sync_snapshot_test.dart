import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  test(
    'APNs token states are notApplicable when APNs is unsupported',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = DeviceProvisioningRepository(
        app_prefs.SharedPreferencesAsync(prefs),
      );

      final snapshot = repo.computeSnapshot(
        const NotificationToken(
          fcmToken: 'fcm-token',
          apnsToken: 'apns-token',
          apnsPushToStartToken: 'push-to-start-token',
        ),
        apnsSupported: false,
      );

      expect(snapshot.fcm, isA<PendingTokenState>());
      expect(snapshot.apnsNotification, isA<NotApplicableTokenState>());
      expect(snapshot.apnsPushToStart, isA<NotApplicableTokenState>());
    },
  );
}
