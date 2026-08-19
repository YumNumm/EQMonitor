import 'package:firebase_messaging/firebase_messaging.dart';

class const OsNotificationPermission._({
  required final AuthorizationStatus authorizationStatus,
  required final AppleNotificationSetting _criticalAlert,
}) {
  factory fromNotificationSettings(
    NotificationSettings settings,
  ) => OsNotificationPermission._(
    authorizationStatus: settings.authorizationStatus,
    criticalAlert: settings.criticalAlert,
  );

  bool get isOsNotificationGranted => authorizationStatus == .authorized;

  bool get isCriticalAlertSupported => _criticalAlert != .notSupported;

  bool get isCriticalAlertGranted => _criticalAlert == .enabled;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OsNotificationPermission &&
            authorizationStatus == other.authorizationStatus &&
            _criticalAlert == other._criticalAlert;
  }

  @override
  int get hashCode => Object.hash(authorizationStatus, _criticalAlert);
}
