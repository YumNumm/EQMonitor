import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

class _FakeMessaging extends Fake implements FirebaseMessaging {
  _FakeMessaging(this._requestSettings);

  final NotificationSettings _requestSettings;

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
  }) async => _requestSettings;
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
  group('PermissionRepository.requestNotificationPermission', () {
    test('authorized is granted', () async {
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.authorized)),
        requestLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async {},
      );

      final isGranted = await repository.requestNotificationPermission();

      expect(isGranted, isTrue);
    });

    test('provisional is not granted', () async {
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.provisional)),
        requestLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async {},
      );

      final isGranted = await repository.requestNotificationPermission();

      expect(isGranted, isFalse);
    });
  });

  group('PermissionRepository.requestForegroundLocationPermission', () {
    test('権限付与時に現在地のApp Group同期を要求する', () async {
      var syncRequested = false;
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        requestLocationPermission: () async => LocationPermission.whileInUse,
        onLocationPermissionGranted: () async {
          await Future<void>.delayed(Duration.zero);
          syncRequested = true;
        },
      );

      final isGranted = await repository.requestForegroundLocationPermission();

      expect(isGranted, isTrue);
      expect(syncRequested, isTrue);
    });

    test('権限拒否時は現在地のApp Group同期を要求しない', () async {
      var syncRequested = false;
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        requestLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async => syncRequested = true,
      );

      final isGranted = await repository.requestForegroundLocationPermission();

      expect(isGranted, isFalse);
      expect(syncRequested, isFalse);
    });
  });
}
