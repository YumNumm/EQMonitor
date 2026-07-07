import 'package:firebase_messaging/firebase_messaging.dart';

class OsNotificationPermission {
  const OsNotificationPermission._({
    required this.authorizationStatus,
    required AppleNotificationSetting criticalAlert,
  }) : _criticalAlert = criticalAlert;

  factory OsNotificationPermission.fromNotificationSettings(
    NotificationSettings settings,
  ) {
    return OsNotificationPermission._(
      authorizationStatus: settings.authorizationStatus,
      criticalAlert: settings.criticalAlert,
    );
  }

  final AuthorizationStatus authorizationStatus;
  final AppleNotificationSetting _criticalAlert;

  bool get isOsNotificationGranted =>
      authorizationStatus == AuthorizationStatus.authorized ||
      authorizationStatus == AuthorizationStatus.provisional;

  bool get isCriticalAlertSupported =>
      _criticalAlert != AppleNotificationSetting.notSupported;

  bool get isCriticalAlertGranted =>
      _criticalAlert == AppleNotificationSetting.enabled;

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

extension NotificationSettingsOsPermissionExtension on NotificationSettings {
  OsNotificationPermission toOsNotificationPermission() =>
      OsNotificationPermission.fromNotificationSettings(this);
}
