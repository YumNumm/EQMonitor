import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_item_decision.dart';
import 'package:eqmonitor/feature/permission/data/notifier/permission_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {}

class _SuccessfulPermissionRepository extends PermissionRepository {
  _SuccessfulPermissionRepository()
    : super(readMessaging: _FakeFirebaseMessaging.new);

  @override
  Future<OsNotificationPermission> getNotificationPermission() async =>
      OsNotificationPermission.fromNotificationSettings(
        _notificationSettings(AuthorizationStatus.denied),
      );

  @override
  Future<LocationPermission> getLocationPermission() async =>
      LocationPermission.denied;

  @override
  Future<bool> requestNotificationPermission() async => true;
}

NotificationSettings _notificationSettings(AuthorizationStatus status) =>
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
  test('初期化時の通知権限は共有 OS Provider から取得する', () async {
    final container = ProviderContainer(
      overrides: [
        permissionRepositoryProvider.overrideWithValue(
          _SuccessfulPermissionRepository(),
        ),
        osNotificationPermissionProvider.overrideWith(
          (ref) async => OsNotificationPermission.fromNotificationSettings(
            _notificationSettings(AuthorizationStatus.authorized),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final state = await container.read(permissionProvider.future);

    expect(state.notification, PermissionItemDecision.granted);
  });

  test('通知権限要求後に OS 通知権限を再取得する', () async {
    var buildCount = 0;
    final container = ProviderContainer(
      overrides: [
        permissionRepositoryProvider.overrideWithValue(
          _SuccessfulPermissionRepository(),
        ),
        osNotificationPermissionProvider.overrideWith((ref) async {
          buildCount++;
          return OsNotificationPermission.fromNotificationSettings(
            _notificationSettings(AuthorizationStatus.denied),
          );
        }),
      ],
    );
    addTearDown(container.dispose);
    container.listen(osNotificationPermissionProvider, (_, _) {});

    await container.read(osNotificationPermissionProvider.future);
    await container.read(permissionProvider.future);
    expect(buildCount, 1);

    await container.read(permissionProvider.notifier).requestNotification();
    await container.read(osNotificationPermissionProvider.future);

    expect(buildCount, 2);
  });
}
