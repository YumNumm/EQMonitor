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
    return permission;
  },
  onLocationPermissionGranted: () async {
    ref.invalidate(appGroupSettingsWriterProvider, asReload: true);
    await ref.read(appGroupSettingsWriterProvider.future);
  },
);

class PermissionRepository({
  required final FirebaseMessaging Function() _readMessaging,
  required final Future<LocationPermission> Function()
  _requestLocationPermission,
  required final Future<LocationPermission> Function()
  _requestAlwaysLocationPermission,
  required final Future<void> Function() _onLocationPermissionGranted,
}) {
  Future<OsNotificationPermission> getNotificationPermission() async {
    final settings = await _readMessaging().getNotificationSettings();
    return OsNotificationPermission.fromNotificationSettings(settings);
  }

  Future<LocationPermission> getLocationPermission() async =>
      Geolocator.checkPermission();

  Future<bool> requestNotificationPermission() async {
    final messaging = _readMessaging();
    Future<bool> check() async {
      final settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        providesAppNotificationSettings: true,
        provisional: false,
        sound: true,
      );
      final authorizationStatus = settings.authorizationStatus;
      if (authorizationStatus == .authorized) {
        return true;
      }
      return false;
    }

    final isGranted = await check();
    if (isGranted) {
      return true;
    }
    // open notification settings page
    await AppSettings.openAppSettings(
      type: .notification,
      asAnotherTask: true,
    );
    return await check();
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
