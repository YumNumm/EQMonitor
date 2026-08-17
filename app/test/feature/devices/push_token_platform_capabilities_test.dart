import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/devices/data/data_source/apns_token_callback_data_source.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_platform_capabilities.dart';
import 'package:eqmonitor/feature/live_activity/data/provider/eqm_live_activity_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('iOS 17 syncs FCM and APNs without push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 17,
    );

    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isTrue);
    expect(value.supportsPushToStart, isFalse);
  });

  test('iOS 18 enables push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 18,
    );

    expect(value.supportsPushToStart, isTrue);
  });

  test('Android only enables FCM', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.android,
    );

    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isFalse);
    expect(value.supportsPushToStart, isFalse);
  });

  test(
    'iOS 17 notification stream never reads Live Activity utility',
    () async {
      var utilityReadCount = 0;
      final container = ProviderContainer(
        overrides: [
          firebaseMessagingProvider.overrideWithValue(_FakeFirebaseMessaging()),
          apnsTokenCallbackDataSourceProvider.overrideWithValue(
            const _FakeApnsTokenCallbackDataSource(),
          ),
          pushTokenPlatformCapabilitiesProvider.overrideWithValue(
            PushTokenPlatformCapabilities.forPlatform(
              platform: PushTokenPlatform.ios,
              iosMajorVersion: 17,
            ),
          ),
          eqmLiveActivityUtilProvider.overrideWith((ref) {
            utilityReadCount++;
            throw StateError(
              'Live Activity utility must not be read on iOS 17',
            );
          }),
        ],
      );
      addTearDown(container.dispose);

      final subscription = container.listen(
        notificationTokenStreamProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);
      await pumpEventQueue(times: 5);

      expect(utilityReadCount, 0);
    },
  );

  test('iOS 18 notification stream wires push-to-start token stream', () async {
    var pushToStartStreamReadCount = 0;
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(_FakeFirebaseMessaging()),
        pushTokenPlatformCapabilitiesProvider.overrideWithValue(
          const PushTokenPlatformCapabilities(supportsPushToStart: true),
        ),
        apnsPushToStartTokenStreamProvider.overrideWith((ref) {
          pushToStartStreamReadCount++;
          return Stream.value('push-to-start-token');
        }),
      ],
    );
    addTearDown(container.dispose);

    final subscription = container.listen(
      notificationTokenStreamProvider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    await pumpEventQueue(times: 5);

    expect(pushToStartStreamReadCount, 1);
  });
}

final class _FakeApnsTokenCallbackDataSource
    implements ApnsTokenCallbackDataSource {
  const _FakeApnsTokenCallbackDataSource();

  @override
  Stream<String> get tokenUpdates => const Stream.empty();
}

final class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) async => _notificationSettings;

  @override
  Future<String?> getAPNSToken() async => 'apns-token';

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async => 'fcm-token';

  @override
  Stream<String> get onTokenRefresh => const Stream.empty();
}

final _notificationSettings = NotificationSettings(
  alert: AppleNotificationSetting.notSupported,
  announcement: AppleNotificationSetting.notSupported,
  authorizationStatus: AuthorizationStatus.provisional,
  badge: AppleNotificationSetting.notSupported,
  carPlay: AppleNotificationSetting.notSupported,
  lockScreen: AppleNotificationSetting.notSupported,
  notificationCenter: AppleNotificationSetting.notSupported,
  showPreviews: AppleShowPreviewSetting.notSupported,
  timeSensitive: AppleNotificationSetting.notSupported,
  criticalAlert: AppleNotificationSetting.notSupported,
  sound: AppleNotificationSetting.notSupported,
  providesAppNotificationSettings: AppleNotificationSetting.notSupported,
);
