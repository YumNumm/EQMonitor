import 'package:firebase_messaging/firebase_messaging.dart';

class const OsNotificationPermission._({
  required final AuthorizationStatus authorizationStatus,
  required final AppleNotificationSetting _criticalAlert,
  required final bool _isCriticalAlertAvailable,
}) {
  factory fromNotificationSettings(
    NotificationSettings settings, {
    bool isCriticalAlertAvailable = false,
  }) => OsNotificationPermission._(
    authorizationStatus: settings.authorizationStatus,
    criticalAlert: settings.criticalAlert,
    isCriticalAlertAvailable: isCriticalAlertAvailable,
  );

  bool get isOsNotificationGranted => authorizationStatus == .authorized;

  // iOS は `.criticalAlert` を一度も要求していない間、エンタイトルメントがあっても
  // notSupported を返す。notSupported だけで非対応と判定すると要求する機会がなくなる。
  bool get isCriticalAlertSupported =>
      _isCriticalAlertAvailable || _criticalAlert != .notSupported;

  bool get isCriticalAlertGranted => _criticalAlert == .enabled;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OsNotificationPermission &&
            authorizationStatus == other.authorizationStatus &&
            _criticalAlert == other._criticalAlert &&
            _isCriticalAlertAvailable == other._isCriticalAlertAvailable;
  }

  @override
  int get hashCode => Object.hash(
    authorizationStatus,
    _criticalAlert,
    _isCriticalAlertAvailable,
  );
}
