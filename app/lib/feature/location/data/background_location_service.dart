import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_location_service.g.dart';

/// エンジン稼働中（フォアグラウンド/バックグラウンド）での位置更新と、
/// killed状態でheadless runnerが永続化した位置情報の両方をEEW設定に反映する。
///
/// 起動時に1度だけ pending 位置を取り出し、続けて live ストリームを listen する。
/// `keepAlive: true` のため、boot 時に `ref.read` で1度だけ起動する想定。
@Riverpod(keepAlive: true)
Stream<void> backgroundLocationService(Ref ref) async* {
  // killed状態で永続化された位置を最優先で反映する。
  await _applyPendingLocation(ref);
  yield null;

  // 現在地リージョンが既に登録されているなら毎回 startMonitoring を再宣言し、
  // 端末再起動などで監視が落ちていても復帰させる。
  await _ensureMonitoring(ref);

  await for (final update in BackgroundLocationTracker.locationStream) {
    await _applyLocation(ref, update.latitude, update.longitude);
    yield null;
  }
}

Future<void> _ensureMonitoring(Ref ref) async {
  try {
    final settings = await ref.read(eewSettingsProvider.future);
    if (!settings.regions.any((r) => r.isCurrentLocation)) {
      return;
    }
    await BackgroundLocationTracker.startMonitoring();
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}

Future<void> _applyPendingLocation(Ref ref) async {
  try {
    await ref.read(eewSettingsProvider.future);
    final pending = await BackgroundLocationTracker.consumePendingLocation();
    if (pending == null) {
      return;
    }
    await _applyLocation(ref, pending.latitude, pending.longitude);
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}

Future<void> _applyLocation(Ref ref, double latitude, double longitude) async {
  try {
    final settings = await ref.read(eewSettingsProvider.future);
    await ref.read(earthquakeNotificationSettingsProvider.future);
    await ref.read(shakeDetectionSettingsProvider.future);
    final prevRegionCode = settings.regions
        .where((r) => r.isCurrentLocation)
        .firstOrNull
        ?.regionId;

    final resolver = await ref.read(jmaRegionResolverProvider.future);
    // EEW 用の area_forecast_local_eew コード
    final code = resolver.resolveRegionCode(latitude, longitude);
    if (code == null) {
      return;
    }
    final name = resolver.resolveRegionName(latitude, longitude);
    // 地震 (VXSE53) 用の市区町村 + 親一次細分化地域コード
    final earthquakeResolution = resolver.resolveEarthquakeRegion(
      latitude,
      longitude,
    );
    final cityCode = earthquakeResolution?.cityCode;

    // EEW リージョン更新
    var didUpdateEew = false;
    String? eewError;
    try {
      didUpdateEew = await ref
          .read(eewSettingsProvider.notifier)
          .updateCurrentLocationRegion(regionCode: code, regionName: name);
    } on Object catch (e) {
      eewError = e.toString();
    }

    // 地震通知リージョン更新 (city まで解決できた場合のみ)
    var didUpdateEarthquake = false;
    String? earthquakeError;
    try {
      if (earthquakeResolution != null) {
        didUpdateEarthquake = await ref
            .read(earthquakeNotificationSettingsProvider.notifier)
            .updateCurrentLocationRegion(
              regionCode: earthquakeResolution.regionCode,
              regionName: earthquakeResolution.regionName,
              cityCode: earthquakeResolution.cityCode,
              cityName: earthquakeResolution.cityName,
            );
      }
    } on Object catch (e) {
      earthquakeError = e.toString();
    }

    // 揺れ検知 sub_region 更新
    var didUpdateShake = false;
    String? shakeError;
    try {
      didUpdateShake = await ref
          .read(shakeDetectionSettingsProvider.notifier)
          .updateCurrentLocationSubRegion(cityCode);
    } on Object catch (e) {
      shakeError = e.toString();
    }

    // デバッグ通知
    await _fireDebugNotifications(
      ref,
      latitude: latitude,
      longitude: longitude,
      prevRegionCode: prevRegionCode,
      newRegionCode: code,
      cityCode: cityCode,
      didUpdateEew: didUpdateEew,
      didUpdateEarthquake: didUpdateEarthquake,
      didUpdateShake: didUpdateShake,
      eewError: eewError,
      earthquakeError: earthquakeError,
      shakeError: shakeError,
    );
  } on Object {
    // バックグラウンドサービスのエラーはサイレントに無視する
  }
}

Future<void> _fireDebugNotifications(
  Ref ref, {
  required double latitude,
  required double longitude,
  required int? prevRegionCode,
  required int newRegionCode,
  required String? cityCode,
  required bool didUpdateEew,
  required bool didUpdateEarthquake,
  required bool didUpdateShake,
  required String? eewError,
  required String? earthquakeError,
  required String? shakeError,
}) async {
  try {
    final debugSettings = ref.read(backgroundLocationDebugSettingsProvider);
    if (!debugSettings.notifyLatLng &&
        !debugSettings.notifyRegion &&
        !debugSettings.notifyPrefecture &&
        !debugSettings.notifyApiUpdate) {
      return;
    }

    final plugin = FlutterLocalNotificationsPlugin();
    var notifId = DateTime.now().millisecondsSinceEpoch & 0xFFFF;
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'bgl_debug',
        'バックグラウンド位置デバッグ',
        importance: Importance.low,
        priority: Priority.low,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: false,
      ),
    );

    if (debugSettings.notifyLatLng) {
      await plugin.show(
        id: notifId++,
        title: '[Debug] 位置更新',
        body:
            'lat=${latitude.toStringAsFixed(4)}, lon=${longitude.toStringAsFixed(4)}',
        notificationDetails: details,
      );
    }

    if (debugSettings.notifyRegion && prevRegionCode != newRegionCode) {
      await plugin.show(
        id: notifId++,
        title: '[Debug] 細分区域 変化',
        body: '$prevRegionCode → $newRegionCode',
        notificationDetails: details,
      );
    }

    if (debugSettings.notifyPrefecture) {
      final prevPref = prevRegionCode != null ? prevRegionCode ~/ 1000 : null;
      final newPref = newRegionCode ~/ 1000;
      if (prevPref != newPref) {
        await plugin.show(
          id: notifId++,
          title: '[Debug] 都道府県コード 変化',
          body: '$prevPref → $newPref',
          notificationDetails: details,
        );
      }
    }

    if (debugSettings.notifyApiUpdate) {
      final eewStatus = eewError != null
          ? '✗($eewError)'
          : (didUpdateEew ? '✓' : '-');
      final eqStatus = earthquakeError != null
          ? '✗($earthquakeError)'
          : (didUpdateEarthquake ? '✓' : '-');
      final shakeStatus = shakeError != null
          ? '✗($shakeError)'
          : (didUpdateShake ? '✓' : '-');
      await plugin.show(
        id: notifId,
        title: '[Debug] 通知API 更新',
        body:
            'region=$newRegionCode, city=${cityCode ?? 'null'}\n'
            'EEW:$eewStatus 地震:$eqStatus 揺れ:$shakeStatus',
        notificationDetails: details,
      );
    }
  } on Object {
    // デバッグ通知失敗はサイレントに無視する
  }
}
