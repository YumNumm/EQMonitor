import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
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
    final eewSettings = await (() async {
      try {
        return await ref.read(eewSettingsProvider.future);
      } on Object catch (e, st) {
        talker.error('[BackgroundLocation] read EEW settings failed', e, st);
        return null;
      }
    })();
    final earthquakeSettings = await (() async {
      try {
        return await ref.read(earthquakeNotificationSettingsProvider.future);
      } on Object catch (e, st) {
        talker.error(
          '[BackgroundLocation] read earthquake settings failed',
          e,
          st,
        );
        return null;
      }
    })();
    final shakeDetectionState = await (() async {
      try {
        return await ref.read(shakeDetectionSettingsProvider.future);
      } on Object catch (e, st) {
        talker.error(
          '[BackgroundLocation] read shake detection settings failed',
          e,
          st,
        );
        return null;
      }
    })();
    const policy = BackgroundLocationMonitoringPolicy();
    if (!policy.shouldMonitor(
      eewSettings: eewSettings,
      earthquakeSettings: earthquakeSettings,
      shakeDetectionState: shakeDetectionState,
    )) {
      return;
    }
    await BackgroundLocationTracker.startMonitoring();
  } on Object catch (e, st) {
    talker.error('[BackgroundLocation] ensureMonitoring failed', e, st);
  }
}

Future<void> _applyPendingLocation(Ref ref) async {
  try {
    final pending = await BackgroundLocationTracker.consumePendingLocation();
    if (pending == null) {
      return;
    }
    await _applyLocation(ref, pending.latitude, pending.longitude);
  } on Object catch (e, st) {
    talker.error('[BackgroundLocation] applyPendingLocation failed', e, st);
  }
}

Future<void> _applyLocation(Ref ref, double latitude, double longitude) async {
  try {
    final settings = await (() async {
      try {
        return await ref.read(eewSettingsProvider.future);
      } on Object catch (e, st) {
        talker.error('[BackgroundLocation] read EEW settings failed', e, st);
        return null;
      }
    })();
    final prevEewRegion = settings?.regions
        .where((r) => r.isCurrentLocation)
        .firstOrNull;
    final prevRegionCode = prevEewRegion?.regionId;
    final prevRegionName = prevEewRegion?.regionName;

    final earthquakeSettings = await (() async {
      try {
        return await ref.read(earthquakeNotificationSettingsProvider.future);
      } on Object catch (e, st) {
        talker.error(
          '[BackgroundLocation] read earthquake settings failed',
          e,
          st,
        );
        return null;
      }
    })();
    final prevEqRegion = earthquakeSettings?.regions
        .where((r) => r.isCurrentLocation)
        .firstOrNull;
    final prevCityCode = prevEqRegion?.cityCode;
    final prevCityName = prevEqRegion?.cityName;

    final resolver = await ref.read(jmaRegionResolverProvider.future);
    // EEW 用の area_forecast_local_eew コード
    final code = resolver.resolveRegionCode(latitude, longitude);
    if (code == null) {
      return;
    }
    final name = resolver.resolveRegionName(latitude, longitude);
    const retry = BackgroundLocationUpdateRetry();
    // 地震 (VXSE53) 用の市区町村 + 親一次細分化地域コード
    final earthquakeResolution = resolver.resolveEarthquakeRegion(
      latitude,
      longitude,
    );
    // 揺れ検知は市区町村コード (area_information_city) のみ必要。
    // earthquakeResolution は親 region 解決に失敗すると null になるため、
    // 揺れ検知用の cityCode は resolver から直接取得する。
    final shakeCityCode = resolver.resolveCityCode(latitude, longitude);

    // EEW リージョン更新
    var didUpdateEew = false;
    String? eewError;
    try {
      didUpdateEew = await retry.run(
        action: () => ref
            .read(eewSettingsProvider.notifier)
            .updateCurrentLocationRegion(regionCode: code, regionName: name),
      );
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] update EEW location failed', e, st);
      eewError = e.toString();
    }

    // 地震通知リージョン更新 (city まで解決できた場合のみ)
    var didUpdateEarthquake = false;
    String? earthquakeError;
    try {
      if (earthquakeResolution != null) {
        didUpdateEarthquake = await retry.run(
          action: () => ref
              .read(earthquakeNotificationSettingsProvider.notifier)
              .updateCurrentLocationRegion(
                regionCode: earthquakeResolution.regionCode,
                regionName: earthquakeResolution.regionName,
                cityCode: earthquakeResolution.cityCode,
                cityName: earthquakeResolution.cityName,
              ),
        );
      }
    } on Object catch (e, st) {
      talker.error(
        '[BackgroundLocation] update earthquake location failed',
        e,
        st,
      );
      earthquakeError = e.toString();
    }

    // 揺れ検知 sub_region 更新
    var didUpdateShake = false;
    String? shakeError;
    try {
      didUpdateShake = await retry.run(
        action: () => ref
            .read(shakeDetectionSettingsProvider.notifier)
            .updateCurrentLocationSubRegion(shakeCityCode),
      );
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] update shake location failed', e, st);
      shakeError = e.toString();
    }

    // デバッグ通知
    await _fireDebugNotifications(
      ref,
      latitude: latitude,
      longitude: longitude,
      prevRegionCode: prevRegionCode,
      prevRegionName: prevRegionName,
      newRegionCode: code,
      newRegionName: name,
      prevCityCode: prevCityCode,
      prevCityName: prevCityName,
      cityCode: earthquakeResolution?.cityCode,
      cityName: earthquakeResolution?.cityName,
      didUpdateEew: didUpdateEew,
      didUpdateEarthquake: didUpdateEarthquake,
      didUpdateShake: didUpdateShake,
      eewError: eewError,
      earthquakeError: earthquakeError,
      shakeError: shakeError,
    );
  } on Object catch (e, st) {
    talker.error('[BackgroundLocation] applyLocation failed', e, st);
  }
}

Future<void> _fireDebugNotifications(
  Ref ref, {
  required double latitude,
  required double longitude,
  required int? prevRegionCode,
  required String? prevRegionName,
  required int newRegionCode,
  required String? newRegionName,
  required String? prevCityCode,
  required String? prevCityName,
  required String? cityCode,
  required String? cityName,
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

    if (debugSettings.notifyRegion) {
      if (prevRegionCode != newRegionCode) {
        await plugin.show(
          id: notifId++,
          title: '[Debug] 細分区域 変化',
          body:
              '$prevRegionCode ($prevRegionName)\n'
              '→ $newRegionCode ($newRegionName)',
          notificationDetails: details,
        );
      }
      if (prevCityCode != cityCode) {
        await plugin.show(
          id: notifId++,
          title: '[Debug] 市区町村 変化',
          body:
              '$prevCityCode ($prevCityName)\n'
              '→ $cityCode ($cityName)',
          notificationDetails: details,
        );
      }
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
      String statusMark({required bool didUpdate, String? error}) =>
          error != null ? '✗' : (didUpdate ? '✓' : '-');
      final summary =
          'EEW:${statusMark(didUpdate: didUpdateEew, error: eewError)} '
          '地震:${statusMark(didUpdate: didUpdateEarthquake, error: earthquakeError)} '
          '揺れ:${statusMark(didUpdate: didUpdateShake, error: shakeError)}';
      final errors = [
        if (eewError != null) 'EEW: $eewError',
        if (earthquakeError != null) '地震: $earthquakeError',
        if (shakeError != null) '揺れ: $shakeError',
      ];
      await plugin.show(
        id: notifId,
        title: '[Debug] 通知API 更新',
        body:
            'region=$newRegionCode ($newRegionName)\n'
            'city=${cityCode ?? 'null'} (${cityName ?? ''})\n'
            '$summary'
            '${errors.isNotEmpty ? '\n${errors.join('\n')}' : ''}',
        notificationDetails: details,
      );
    }
  } on Object catch (e, st) {
    talker.error('[BackgroundLocation] fireDebugNotifications failed', e, st);
  }
}
