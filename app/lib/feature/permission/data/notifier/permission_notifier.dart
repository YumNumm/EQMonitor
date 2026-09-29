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
        await _reload();
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

  /// 再 build して OS から取得し直した最新の権限状態を返す。
  ///
  /// [Ref.invalidateSelf] は再 build を予約するだけなので、直後の `state` は
  /// 要求前の値のままになる。再 build 後の [future] を待って最新値を得る。
  Future<PermissionState> _reload() {
    ref.invalidateSelf();
    return future;
  }

  Future<bool> requestNotification() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestNotificationPermission();
    final next = await _reload();
    return next.isNotificationGranted;
  }

  Future<bool> requestCriticalAlert() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestCriticalAlertPermission();
    final next = await _reload();
    return next.isCriticalAlertGranted;
  }

  Future<bool> requestForegroundLocation() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestForegroundLocationPermission();
    final next = await _reload();
    return next.isForegroundLocationGranted;
  }

  Future<bool> requestBackgroundLocation() async {
    await ref
        .read(permissionRepositoryProvider)
        .requestBackgroundLocationPermission();
    final next = await _reload();
    return next.isBackgroundLocationGranted;
  }
}
