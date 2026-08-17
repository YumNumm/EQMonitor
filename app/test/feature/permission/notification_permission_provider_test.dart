import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/feature/permission/data/notification_permission_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeMessaging extends Fake implements FirebaseMessaging {
  new(this._settings);
  final NotificationSettings _settings;
  @override
  Future<NotificationSettings> getNotificationSettings() async => _settings;
}

NotificationSettings _settings(AuthorizationStatus status) =>
    NotificationSettings(
      alert: AppleNotificationSetting.notSupported,
      announcement: AppleNotificationSetting.notSupported,
      authorizationStatus: status,
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('authorized なら granted=true', () async {
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(
          _FakeMessaging(_settings(AuthorizationStatus.authorized)),
        ),
      ],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(isNotificationPermissionGrantedProvider.future),
      isTrue,
    );
  });

  test('provisional なら granted=false', () async {
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(
          _FakeMessaging(_settings(AuthorizationStatus.provisional)),
        ),
      ],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(isNotificationPermissionGrantedProvider.future),
      isFalse,
    );
  });

  test('denied なら granted=false', () async {
    final container = ProviderContainer(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(
          _FakeMessaging(_settings(AuthorizationStatus.denied)),
        ),
      ],
    );
    addTearDown(container.dispose);
    expect(
      await container.read(isNotificationPermissionGrantedProvider.future),
      isFalse,
    );
  });
}
