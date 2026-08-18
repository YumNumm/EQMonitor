import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

class _FakeMessaging extends Fake implements FirebaseMessaging {
  new(
    this._requestSettings, {
    NotificationSettings? currentSettings,
  }) : _currentSettings = currentSettings ?? _requestSettings;

  final NotificationSettings _requestSettings;
  final NotificationSettings _currentSettings;

  @override
  Future<NotificationSettings> getNotificationSettings() async =>
      _currentSettings;

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
        readLocationPermission: () async => LocationPermission.denied,
        requestLocationPermission: () async => LocationPermission.denied,
        requestAlwaysLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async {},
        openNotificationSettings: () async {},
      );

      final isGranted = await repository.requestNotificationPermission();

      expect(isGranted, isTrue);
    });

    test('provisional is not granted', () async {
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.provisional)),
        readLocationPermission: () async => LocationPermission.denied,
        requestLocationPermission: () async => LocationPermission.denied,
        requestAlwaysLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async {},
        openNotificationSettings: () async {},
      );

      final isGranted = await repository.requestNotificationPermission();

      expect(isGranted, isFalse);
    });

    test('denied opens settings but is not granted', () async {
      var settingsOpened = false;
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        readLocationPermission: () async => LocationPermission.denied,
        requestLocationPermission: () async => LocationPermission.denied,
        requestAlwaysLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async {},
        openNotificationSettings: () async => settingsOpened = true,
      );

      final isGranted = await repository.requestNotificationPermission();

      expect(isGranted, isFalse);
      expect(settingsOpened, isTrue);
    });

    test(
      'request result is authorized but OS state is denied is not granted',
      () async {
        var settingsOpened = false;
        final repository = PermissionRepository(
          readMessaging: () => _FakeMessaging(
            _settings(AuthorizationStatus.authorized),
            currentSettings: _settings(AuthorizationStatus.denied),
          ),
          readLocationPermission: () async => LocationPermission.denied,
          requestLocationPermission: () async => LocationPermission.denied,
          requestAlwaysLocationPermission: () async =>
              LocationPermission.denied,
          onLocationPermissionGranted: () async {},
          openNotificationSettings: () async => settingsOpened = true,
        );

        final isGranted = await repository.requestNotificationPermission();

        expect(isGranted, isFalse);
        expect(settingsOpened, isTrue);
      },
    );
  });

  group('PermissionRepository.requestForegroundLocationPermission', () {
    test('権限付与時に現在地のApp Group同期を要求する', () async {
      var syncRequested = false;
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        readLocationPermission: () async => LocationPermission.denied,
        requestLocationPermission: () async => LocationPermission.whileInUse,
        requestAlwaysLocationPermission: () async =>
            LocationPermission.whileInUse,
        onLocationPermissionGranted: () async {
          await Future<void>.delayed(Duration.zero);
          syncRequested = true;
        },
        openNotificationSettings: () async {},
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
        readLocationPermission: () async => LocationPermission.denied,
        requestLocationPermission: () async => LocationPermission.denied,
        requestAlwaysLocationPermission: () async => LocationPermission.denied,
        onLocationPermissionGranted: () async => syncRequested = true,
        openNotificationSettings: () async {},
      );

      final isGranted = await repository.requestForegroundLocationPermission();

      expect(isGranted, isFalse);
      expect(syncRequested, isFalse);
    });
  });

  group('PermissionRepository.requestBackgroundLocationPermission', () {
    test('always への昇格用の要求を使う', () async {
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        readLocationPermission: () async => LocationPermission.whileInUse,
        // 使用中の許可しか返さない要求が使われていたら false になる
        requestLocationPermission: () async => LocationPermission.whileInUse,
        requestAlwaysLocationPermission: () async => LocationPermission.always,
        onLocationPermissionGranted: () async {},
        openNotificationSettings: () async {},
      );

      final isGranted = await repository.requestBackgroundLocationPermission();

      expect(isGranted, isTrue);
    });

    test('whileInUse のままなら許可されていない', () async {
      var syncRequested = false;
      final repository = PermissionRepository(
        readMessaging: () =>
            _FakeMessaging(_settings(AuthorizationStatus.denied)),
        readLocationPermission: () async => LocationPermission.whileInUse,
        requestLocationPermission: () async => LocationPermission.whileInUse,
        requestAlwaysLocationPermission: () async =>
            LocationPermission.whileInUse,
        onLocationPermissionGranted: () async => syncRequested = true,
        openNotificationSettings: () async {},
      );

      final isGranted = await repository.requestBackgroundLocationPermission();

      expect(isGranted, isFalse);
      expect(syncRequested, isFalse);
    });
  });
}
