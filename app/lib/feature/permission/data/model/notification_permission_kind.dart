import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';

enum NotificationPermissionKind { notification, criticalAlert }

extension NotificationPermissionKindPresentation on NotificationPermissionKind {
  String get label => switch (this) {
    .notification => '通知',
    .criticalAlert => '重大な通知',
  };

  String get explanation => switch (this) {
    .notification => '緊急地震速報や地震情報の通知を受け取るには、通知の許可が必要です。',
    .criticalAlert => 'マナーモードや集中モード中でも、緊急地震速報（警報）の通知音を鳴らすには、重大な通知の許可が必要です。',
  };

  bool isGranted(OsNotificationPermission permission) => switch (this) {
    .notification => permission.isOsNotificationGranted,
    .criticalAlert => permission.isCriticalAlertGranted,
  };
}

class const NotificationPermissionPolicy() {
  List<NotificationPermissionKind> missing({
    required OsNotificationPermission permission,
    required bool requiresCriticalAlert,
  }) => [
    if (!permission.isOsNotificationGranted) .notification,
    if (requiresCriticalAlert &&
        permission.isCriticalAlertSupported &&
        !permission.isCriticalAlertGranted)
      .criticalAlert,
  ];
}
