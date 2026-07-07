import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  _FakeFirebaseMessaging(this._settings);

  final NotificationSettings _settings;

  @override
  Future<NotificationSettings> getNotificationSettings() async => _settings;
}

NotificationSettings _notificationSettings({
  AuthorizationStatus authorizationStatus = AuthorizationStatus.notDetermined,
  AppleNotificationSetting criticalAlert =
      AppleNotificationSetting.notSupported,
}) {
  return NotificationSettings(
    alert: AppleNotificationSetting.notSupported,
    announcement: AppleNotificationSetting.notSupported,
    authorizationStatus: authorizationStatus,
    badge: AppleNotificationSetting.notSupported,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.notSupported,
    notificationCenter: AppleNotificationSetting.notSupported,
    showPreviews: AppleShowPreviewSetting.notSupported,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: criticalAlert,
    sound: AppleNotificationSetting.notSupported,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );
}

ProviderContainer _container(FirebaseMessaging messaging) {
  final container = ProviderContainer(
    overrides: [firebaseMessagingProvider.overrideWithValue(messaging)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('OsNotificationPermission.fromNotificationSettings', () {
    test('authorized のとき isOsNotificationGranted が true', () {
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.authorized,
        ),
      );

      expect(permission.isOsNotificationGranted, isTrue);
      expect(permission.authorizationStatus, AuthorizationStatus.authorized);
    });

    test('provisional のとき isOsNotificationGranted が true', () {
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.provisional,
        ),
      );

      expect(permission.isOsNotificationGranted, isTrue);
      expect(permission.authorizationStatus, AuthorizationStatus.provisional);
    });

    test('denied のとき isOsNotificationGranted が false', () {
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(authorizationStatus: AuthorizationStatus.denied),
      );

      expect(permission.isOsNotificationGranted, isFalse);
    });

    test('notDetermined のとき isOsNotificationGranted が false', () {
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(
          authorizationStatus: AuthorizationStatus.notDetermined,
        ),
      );

      expect(permission.isOsNotificationGranted, isFalse);
    });

    test(
      'criticalAlert が notSupported 以外のとき isCriticalAlertSupported が true',
      () {
        final permission = OsNotificationPermission.fromNotificationSettings(
          _notificationSettings(
            criticalAlert: AppleNotificationSetting.disabled,
          ),
        );

        expect(permission.isCriticalAlertSupported, isTrue);
        expect(permission.isCriticalAlertGranted, isFalse);
      },
    );

    test('criticalAlert が enabled のとき isCriticalAlertGranted が true', () {
      final permission = OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(criticalAlert: AppleNotificationSetting.enabled),
      );

      expect(permission.isCriticalAlertSupported, isTrue);
      expect(permission.isCriticalAlertGranted, isTrue);
    });

    test(
      'criticalAlert が notSupported のとき isCriticalAlertSupported が false',
      () {
        final permission = OsNotificationPermission.fromNotificationSettings(
          _notificationSettings(
            criticalAlert: AppleNotificationSetting.notSupported,
          ),
        );

        expect(permission.isCriticalAlertSupported, isFalse);
        expect(permission.isCriticalAlertGranted, isFalse);
      },
    );
  });

  group('NotificationSettingsOsPermissionExtension', () {
    test('toOsNotificationPermission が fromNotificationSettings と同等', () {
      final settings = _notificationSettings(
        authorizationStatus: AuthorizationStatus.authorized,
        criticalAlert: AppleNotificationSetting.enabled,
      );

      expect(
        settings.toOsNotificationPermission(),
        OsNotificationPermission.fromNotificationSettings(settings),
      );
    });
  });

  group('osNotificationPermissionProvider', () {
    test('FirebaseMessaging の設定を OsNotificationPermission に変換して返す', () async {
      final settings = _notificationSettings(
        authorizationStatus: AuthorizationStatus.authorized,
        criticalAlert: AppleNotificationSetting.enabled,
      );
      final messaging = _FakeFirebaseMessaging(settings);

      final container = _container(messaging);
      final permission = await container.read(
        osNotificationPermissionProvider.future,
      );

      expect(permission.isOsNotificationGranted, isTrue);
      expect(permission.isCriticalAlertGranted, isTrue);
    });
  });
}
