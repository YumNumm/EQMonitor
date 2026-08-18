import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _MutableAppLifecycle extends AppLifecycle {
  new(this.initial);

  final AppLifecycleState initial;

  @override
  AppLifecycleState build() => initial;

  void publish(AppLifecycleState value) => state = value;
}

final class _MutableMessaging extends Fake implements FirebaseMessaging {
  AuthorizationStatus authorizationStatus = AuthorizationStatus.denied;

  @override
  Future<NotificationSettings> getNotificationSettings() async =>
      NotificationSettings(
        alert: AppleNotificationSetting.disabled,
        announcement: AppleNotificationSetting.notSupported,
        authorizationStatus: authorizationStatus,
        badge: AppleNotificationSetting.disabled,
        carPlay: AppleNotificationSetting.notSupported,
        lockScreen: AppleNotificationSetting.disabled,
        notificationCenter: AppleNotificationSetting.disabled,
        showPreviews: AppleShowPreviewSetting.notSupported,
        timeSensitive: AppleNotificationSetting.notSupported,
        criticalAlert: AppleNotificationSetting.disabled,
        sound: AppleNotificationSetting.disabled,
        providesAppNotificationSettings: AppleNotificationSetting.notSupported,
      );
}

void main() {
  test('フォアグラウンド復帰時にOSの通知権限を再取得する', () async {
    final lifecycle = _MutableAppLifecycle(AppLifecycleState.resumed);
    final messaging = _MutableMessaging();
    final repository = PermissionRepository(
      readMessaging: () => messaging,
      readLocationPermission: () async => LocationPermission.denied,
      requestLocationPermission: () async => LocationPermission.denied,
      requestAlwaysLocationPermission: () async => LocationPermission.denied,
      onLocationPermissionGranted: () async {},
      openNotificationSettings: () async {},
    );
    final container = ProviderContainer(
      overrides: [
        appLifecycleProvider.overrideWith(() => lifecycle),
        permissionRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final initial = await container.read(permissionProvider.future);
    expect(initial.isNotificationGranted, isFalse);

    messaging.authorizationStatus = AuthorizationStatus.authorized;
    lifecycle
      ..publish(AppLifecycleState.paused)
      ..publish(AppLifecycleState.resumed);
    await container.pump();
    await container.pump();

    expect(
      container.read(permissionProvider).requireValue.isNotificationGranted,
      isTrue,
    );
  });
}
