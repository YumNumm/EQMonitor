import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_item_decision.dart';
import 'package:geolocator/geolocator.dart';

class PermissionState {
  const PermissionState({
    required this.isCriticalAlertSupported,
    this.notification = PermissionItemDecision.notRequested,
    this.criticalAlert = PermissionItemDecision.notRequested,
    this.foregroundLocation = PermissionItemDecision.notRequested,
    this.backgroundLocation = PermissionItemDecision.notRequested,
  });

  factory PermissionState.fromOs({
    required OsNotificationPermission notification,
    required LocationPermission location,
  }) {
    final notificationDecision = notification.isOsNotificationGranted
        ? PermissionItemDecision.granted
        : PermissionItemDecision.notRequested;
    final criticalAlertDecision = !notification.isCriticalAlertSupported
        ? PermissionItemDecision.notRequested
        : notification.isCriticalAlertGranted
        ? PermissionItemDecision.granted
        : PermissionItemDecision.notRequested;
    final foregroundLocationDecision = switch (location) {
      LocationPermission.always || LocationPermission.whileInUse =>
        PermissionItemDecision.granted,
      _ => PermissionItemDecision.notRequested,
    };
    final backgroundLocationDecision = location == LocationPermission.always
        ? PermissionItemDecision.granted
        : PermissionItemDecision.notRequested;

    return PermissionState(
      isCriticalAlertSupported: notification.isCriticalAlertSupported,
      notification: notificationDecision,
      criticalAlert: criticalAlertDecision,
      foregroundLocation: foregroundLocationDecision,
      backgroundLocation: backgroundLocationDecision,
    );
  }

  final bool isCriticalAlertSupported;
  final PermissionItemDecision notification;
  final PermissionItemDecision criticalAlert;
  final PermissionItemDecision foregroundLocation;
  final PermissionItemDecision backgroundLocation;

  bool get isCriticalAlertVisible => isCriticalAlertSupported;

  bool get canRequestCriticalAlert =>
      isCriticalAlertVisible && notification.isGranted;

  bool get canRequestBackgroundLocation => foregroundLocation.isGranted;

  bool get canContinue =>
      notification.isComplete &&
      (!isCriticalAlertVisible || criticalAlert.isComplete) &&
      foregroundLocation.isComplete &&
      backgroundLocation.isComplete;

  PermissionState grantNotification() =>
      copyWith(notification: PermissionItemDecision.granted);

  PermissionState skipNotification() => copyWith(
    notification: PermissionItemDecision.skipped,
    criticalAlert: PermissionItemDecision.skipped,
  );

  PermissionState grantCriticalAlert() =>
      copyWith(criticalAlert: PermissionItemDecision.granted);

  PermissionState skipCriticalAlert() =>
      copyWith(criticalAlert: PermissionItemDecision.skipped);

  PermissionState grantForegroundLocation() =>
      copyWith(foregroundLocation: PermissionItemDecision.granted);

  PermissionState skipForegroundLocation() => copyWith(
    foregroundLocation: PermissionItemDecision.skipped,
    backgroundLocation: PermissionItemDecision.skipped,
  );

  PermissionState grantBackgroundLocation() =>
      copyWith(backgroundLocation: PermissionItemDecision.granted);

  PermissionState skipBackgroundLocation() =>
      copyWith(backgroundLocation: PermissionItemDecision.skipped);

  PermissionState copyWith({
    bool? isCriticalAlertSupported,
    PermissionItemDecision? notification,
    PermissionItemDecision? criticalAlert,
    PermissionItemDecision? foregroundLocation,
    PermissionItemDecision? backgroundLocation,
  }) => PermissionState(
    isCriticalAlertSupported:
        isCriticalAlertSupported ?? this.isCriticalAlertSupported,
    notification: notification ?? this.notification,
    criticalAlert: criticalAlert ?? this.criticalAlert,
    foregroundLocation: foregroundLocation ?? this.foregroundLocation,
    backgroundLocation: backgroundLocation ?? this.backgroundLocation,
  );
}
