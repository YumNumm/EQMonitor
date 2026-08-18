import 'dart:io';

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
  requestAlwaysLocationPermission: requestAlwaysLocationPermission,
  onLocationPermissionGranted: () async {
    ref.invalidate(appGroupSettingsWriterProvider, asReload: true);
    await ref.read(appGroupSettingsWriterProvider.future);
  },
);

/// 「常に許可」(バックグラウンド位置情報) を要求する。
///
/// Apple 系プラットフォームでは `Geolocator.requestPermission()` が使えない:
/// - 権限が未決定でない場合は何もせず現在の状態を返す
///   (= 使用中の許可を得た後に呼んでも昇格ダイアログが出ない)
/// - `NSLocationWhenInUseUsageDescription` があると常に
///   `requestWhenInUseAuthorization` しか呼ばない
///
/// そのため permission_handler 経由で `requestAlwaysAuthorization` を呼ぶ。
/// Android は geolocator が `ACCESS_BACKGROUND_LOCATION` への昇格に対応している
/// ため、そのまま `Geolocator.requestPermission()` を使う。
Future<LocationPermission> requestAlwaysLocationPermission() async {
  if (!Platform.isIOS && !Platform.isMacOS) {
    return Geolocator.requestPermission();
  }
  // iOS では「使用中の許可」がないと「常に許可」を要求できないため、先に要求する
  if (await Geolocator.checkPermission() == LocationPermission.denied) {
    final foreground = await Geolocator.requestPermission();
    if (foreground != LocationPermission.whileInUse &&
        foreground != LocationPermission.always) {
      return foreground;
    }
  }

  // permission_handler の戻り値は信用できない:
  // 要求のたびに `CLLocationManager` を生成するため、昇格前の
  // `authorizedWhenInUse` が届くデリゲート通知で `denied` を返してしまう。
  // 逆に、使用中の許可済みからの昇格ではダイアログが出ず
  // (= provisional always) 通知が来ないこともあり、その場合は完了しない。
  // そのため要求だけ投げて、OS のステータス自体を見て判定する。
  Permission.locationAlways.request().ignore();
  return _waitForAlwaysAuthorization();
}

/// `requestAlwaysAuthorization` の結果が OS に反映されるまで待つ。
///
/// 使用中の許可済みから昇格する場合、ダイアログを挟まずに
/// `authorizedAlways` (provisional always) になるため、短い待機で確定する。
/// 昇格しなかった場合はタイムアウトして現在のステータスを返す。
Future<LocationPermission> _waitForAlwaysAuthorization() async {
  const interval = Duration(milliseconds: 100);
  const timeout = Duration(seconds: 2);

  final stopwatch = Stopwatch()..start();
  var permission = await Geolocator.checkPermission();
  while (permission != LocationPermission.always &&
      stopwatch.elapsed < timeout) {
    await Future<void>.delayed(interval);
    permission = await Geolocator.checkPermission();
  }
  return permission;
}

class PermissionRepository {
  const new({
    required FirebaseMessaging Function() readMessaging,
    required Future<LocationPermission> Function() requestLocationPermission,
    required Future<LocationPermission> Function()
    requestAlwaysLocationPermission,
    required Future<void> Function() onLocationPermissionGranted,
  }) : _readMessaging = readMessaging,
       _requestLocationPermission = requestLocationPermission,
       _requestAlwaysLocationPermission = requestAlwaysLocationPermission,
       _onLocationPermissionGranted = onLocationPermissionGranted;

  final FirebaseMessaging Function() _readMessaging;
  final Future<LocationPermission> Function() _requestLocationPermission;
  final Future<LocationPermission> Function() _requestAlwaysLocationPermission;
  final Future<void> Function() _onLocationPermissionGranted;

  Future<OsNotificationPermission> getNotificationPermission() async {
    final settings = await _readMessaging().getNotificationSettings();
    return settings.toOsNotificationPermission();
  }

  Future<LocationPermission> getLocationPermission() async {
    return Geolocator.checkPermission();
  }

  Future<bool> requestNotificationPermission() async {
    final settings = await _readMessaging().requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<bool> requestCriticalAlertPermission() async {
    final settings = await _readMessaging().requestPermission(
      criticalAlert: true,
    );
    return settings.criticalAlert == AppleNotificationSetting.enabled;
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
