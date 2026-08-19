import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/permission/data/model/permission_state.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permission_notifier.g.dart';

/// アプリで利用する権限の状態を保持する Notifier。
///
/// 初期化時とフォアグラウンド復帰時に OS の権限状態を読み取る。
@Riverpod(keepAlive: true)
class PermissionNotifier extends _$PermissionNotifier {
  static final requestNotificationMutation = Mutation<bool>();
  static final requestCriticalAlertMutation = Mutation<bool>();
  static final requestForegroundLocationMutation = Mutation<bool>();
  static final requestBackgroundLocationMutation = Mutation<bool>();

  @override
  Future<PermissionState> build() async {
    ref.listen(appLifecycleProvider, (_, next) async {
      if (next == AppLifecycleState.resumed) {
        await refresh();
      }
    });
    return loadFromOs();
  }

  Future<PermissionState> loadFromOs() async {
    final repository = ref.read(permissionRepositoryProvider);
    final notification = await repository.getNotificationPermission();
    final location = await repository.getLocationPermission();
    return PermissionState(
      isNotificationGranted: notification.isOsNotificationGranted,
      isCriticalAlertSupported: notification.isCriticalAlertSupported,
      isCriticalAlertGranted: notification.isCriticalAlertGranted,
      isForegroundLocationGranted:
          location == LocationPermission.whileInUse ||
          location == LocationPermission.always,
      isBackgroundLocationGranted: location == LocationPermission.always,
    );
  }

  Future<void> refresh() async {
    state = AsyncData(await loadFromOs());
  }

  Future<bool> requestNotification() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestNotificationPermission();
    await refresh();
    return state.requireValue.isNotificationGranted;
  }

  Future<bool> requestCriticalAlert() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestCriticalAlertPermission();
    await refresh();
    return state.requireValue.isCriticalAlertGranted;
  }

  Future<bool> requestForegroundLocation() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestForegroundLocationPermission();
    await refresh();
    return state.requireValue.isForegroundLocationGranted;
  }

  Future<bool> requestBackgroundLocation() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestBackgroundLocationPermission();
    await refresh();
    return state.requireValue.isBackgroundLocationGranted;
  }
}
