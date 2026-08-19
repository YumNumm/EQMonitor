import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_repository.g.dart';

@Riverpod(keepAlive: true)
PermissionRepository permissionRepository(Ref ref) => PermissionRepository(
  readMessaging: () => ref.read(firebaseMessagingProvider),
  readLocationPermission: Geolocator.checkPermission,
  requestLocationPermission: Geolocator.requestPermission,
  requestAlwaysLocationPermission: () async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return Geolocator.requestPermission();
    }
    // iOS では「使用中の許可」がないと「常に許可」を要求できないため、先に要求する
    final permission = await Geolocator.checkPermission();
    if (permission == .denied) {
      final foreground = await Geolocator.requestPermission();
      if (foreground != .whileInUse && foreground != .always) {
        return foreground;
      }
    }

    Permission.locationAlways.request().ignore();

    const interval = Duration(milliseconds: 100);
    const timeout = Duration(seconds: 2);

    final stopwatch = Stopwatch()..start();
    var current = await Geolocator.checkPermission();
    while (current != .always && stopwatch.elapsed < timeout) {
      await Future<void>.delayed(interval);
      current = await Geolocator.checkPermission();
    }
    return current;
  },
  onLocationPermissionGranted: () async {
    ref.invalidate(appGroupSettingsWriterProvider, asReload: true);
    await ref.read(appGroupSettingsWriterProvider.future);
  },
  openNotificationSettings: () =>
      AppSettings.openAppSettings(type: .notification, asAnotherTask: true),
);

class PermissionRepository({
  required final FirebaseMessaging Function() _readMessaging,
  required final Future<LocationPermission> Function() _readLocationPermission,
  required final Future<LocationPermission> Function()
  _requestLocationPermission,
  required final Future<LocationPermission> Function()
  _requestAlwaysLocationPermission,
  required final Future<void> Function() _onLocationPermissionGranted,
  required final Future<void> Function() _openNotificationSettings,
}) {
  Future<OsNotificationPermission> getNotificationPermission() async {
    final settings = await _readMessaging().getNotificationSettings();
    return OsNotificationPermission.fromNotificationSettings(settings);
  }

  Future<LocationPermission> getLocationPermission() async =>
      _readLocationPermission();

  Future<bool> requestNotificationPermission() async {
    await _readMessaging().requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      providesAppNotificationSettings: true,
      provisional: false,
      sound: true,
    );
    // 要求の戻り値ではなく OS の権限状態そのものを正とする
    final permission = await getNotificationPermission();
    if (permission.isOsNotificationGranted) {
      return true;
    }
    // 一度拒否されると OS は権限ダイアログを表示しないため、設定アプリへ誘導する。
    // 設定変更の反映はフォアグラウンド復帰時の再確認に任せる
    if (permission.authorizationStatus == .denied) {
      await _openNotificationSettings();
    }
    return false;
  }

  Future<bool> requestCriticalAlertPermission() async {
    final settings = await _readMessaging().requestPermission(
      criticalAlert: true,
    );
    return settings.criticalAlert == .enabled;
  }

  Future<bool> requestForegroundLocationPermission() async {
    final permission = await _requestLocationPermission();
    final isGranted =
        permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
    if (isGranted) {
      await _onLocationPermissionGranted();
    }
    return isGranted;
  }

  Future<bool> requestBackgroundLocationPermission() async {
    final permission = await _requestAlwaysLocationPermission();
    final isGranted = permission == LocationPermission.always;
    if (isGranted) {
      await _onLocationPermissionGranted();
    }
    return isGranted;
  }
}
