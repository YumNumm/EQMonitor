import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_item_decision.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

NotificationSettings _notificationSettings({
  required AuthorizationStatus authorizationStatus,
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

void main() {
  group('PermissionState', () {
    test('initial state cannot continue', () {
      const state = PermissionState(isCriticalAlertSupported: true);

      expect(state.canContinue, isFalse);
      expect(state.canRequestCriticalAlert, isFalse);
      expect(state.canRequestBackgroundLocation, isFalse);
    });

    test('skipping notification also skips critical alert', () {
      final state = const PermissionState(
        isCriticalAlertSupported: true,
      ).skipNotification();

      expect(state.notification, PermissionItemDecision.skipped);
      expect(state.criticalAlert, PermissionItemDecision.skipped);
    });

    test('unsupported critical alert is not required to continue', () {
      final state = const PermissionState(
        isCriticalAlertSupported: false,
      ).grantNotification().grantForegroundLocation().grantBackgroundLocation();

      expect(state.isCriticalAlertVisible, isFalse);
      expect(state.canContinue, isTrue);
    });

    test('foreground location grants access to background request', () {
      final initial = const PermissionState(isCriticalAlertSupported: false);
      final granted = initial.grantForegroundLocation();

      expect(initial.canRequestBackgroundLocation, isFalse);
      expect(granted.canRequestBackgroundLocation, isTrue);
    });

    test('skipping foreground location also skips background location', () {
      final state = const PermissionState(
        isCriticalAlertSupported: false,
      ).skipForegroundLocation();

      expect(state.foregroundLocation, PermissionItemDecision.skipped);
      expect(state.backgroundLocation, PermissionItemDecision.skipped);
    });

    test('all visible items must be complete to continue', () {
      final incomplete = const PermissionState(
        isCriticalAlertSupported: true,
      ).grantNotification().grantCriticalAlert().grantForegroundLocation();
      final complete = incomplete.skipBackgroundLocation();

      expect(incomplete.canContinue, isFalse);
      expect(complete.canContinue, isTrue);
    });

    test('provisional notification permission is not treated as granted', () {
      final state = PermissionState.fromOs(
        notification: OsNotificationPermission.fromNotificationSettings(
          _notificationSettings(
            authorizationStatus: AuthorizationStatus.provisional,
          ),
        ),
        location: LocationPermission.always,
      );

      expect(state.notification, PermissionItemDecision.notRequested);
      expect(state.canRequestCriticalAlert, isFalse);
    });
  });
}
