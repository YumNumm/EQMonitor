import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/config/permission/model/permission_state.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_notifier.g.dart';

@Riverpod(keepAlive: true)
class PermissionNotifier extends _$PermissionNotifier {
  @override
  PermissionStateModel build() {
    ref.listen(appLifeCycleProvider, (_, next) {
      if (next == AppLifecycleState.resumed) {
        initialize();
      }
    });
    return const PermissionStateModel();
  }

  Future<void> initialize() async {
    final notificationPermission =
        await ref.read(firebaseMessagingProvider).getNotificationSettings();
    await ref
        .read(firebaseMessagingProvider)
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
        );
    state = PermissionStateModel(
      notification: switch (notificationPermission.authorizationStatus) {
        AuthorizationStatus.authorized ||
        AuthorizationStatus.provisional =>
          true,
        _ => false,
      },
      criticalAlert: notificationPermission.criticalAlert ==
          AppleNotificationSetting.enabled,
      backgroundLocation:
          await Permission.locationAlways.status == PermissionStatus.granted,
      location:
          await Permission.locationWhenInUse.status == PermissionStatus.granted,
    );
  }

  Future<bool> notificationPermission() async {
    final status = await Permission.notification.status;
    return status == PermissionStatus.granted;
  }

  Future<void> requestNotificationPermission() async {
    final result = await ref.read(firebaseMessagingProvider).requestPermission(
          announcement: true,
          criticalAlert: true,
          carPlay: true,
        );
    if (result.authorizationStatus == AuthorizationStatus.denied) {
      // 設定画面に遷移する
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
    await initialize();
  }

  Future<void> requestLocationWhenInUsePermission() async {
    final status = await Permission.locationWhenInUse.request();
    log(
      'Permission requested: locationWhenInUse, status: $status',
      name: 'PermissionNotifier',
    );
    if (status == PermissionStatus.permanentlyDenied) {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    }
    ref.invalidateSelf();
  }

  Future<void> requestLocationAlwaysPermission() async {
    final status = await Permission.locationAlways.request();
    log(
      'Permission requested: locationAlways, status: $status',
      name: 'PermissionNotifier',
    );
    if (status == PermissionStatus.permanentlyDenied) {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    }

    ref.invalidateSelf();
  }
}
