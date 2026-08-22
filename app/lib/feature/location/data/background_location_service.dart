import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/widget_timeline_reloader.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
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
  const coordinator = BackgroundLocationSyncCoordinator();
  // killed状態で永続化された位置を最優先で反映する。
  await coordinator.applyPendingLocation(ref);
  yield null;

  // 現在地リージョンが既に登録されているなら毎回 startMonitoring を再宣言し、
  // 端末再起動などで監視が落ちていても復帰させる。
  await coordinator.ensureMonitoring(ref);

  await for (final update in BackgroundLocationTracker.locationStream) {
    await coordinator.applyLocation(ref, update.latitude, update.longitude);
    yield null;
  }
}

/// 位置情報の更新を通知スロット・揺れ検知設定・App Group・デバッグ通知へ
/// 反映するコーディネーター。
///
/// [Ref] はコンストラクタではなく各メソッドの引数として受け取る。
class BackgroundLocationSyncCoordinator {
  const new();

  Future<void> ensureMonitoring(Ref ref) async {
    try {
      final slots = await (() async {
        try {
          return await ref.read(notificationSlotsProvider.future);
        } on Object catch (e, st) {
          talker.error('[BackgroundLocation] read slots failed', e, st);
          return <NotificationSlot>[];
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
      final hasCurrentLocation = slots.any(
        (s) => s.slotType == NotificationSlotType.currentLocation,
      );
      final hasShakeCurrentLocation =
          shakeDetectionState?.entries.any((e) => e.isCurrentLocation) ?? false;
      if (!hasCurrentLocation && !hasShakeCurrentLocation) {
        return;
      }
      await BackgroundLocationTracker.startMonitoring();
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] ensureMonitoring failed', e, st);
    }
  }

  Future<void> applyPendingLocation(Ref ref) async {
    try {
      final pending = await BackgroundLocationTracker.consumePendingLocation();
      if (pending == null) {
        return;
      }
      await applyLocation(ref, pending.latitude, pending.longitude);
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] applyPendingLocation failed', e, st);
    }
  }

  Future<void> applyLocation(Ref ref, double latitude, double longitude) async {
    try {
      final slots = await (() async {
        try {
          return await ref.read(notificationSlotsProvider.future);
        } on Object catch (e, st) {
          talker.error('[BackgroundLocation] read slots failed', e, st);
          return <NotificationSlot>[];
        }
      })();
      final currentLocationSlot = slots
          .where((s) => s.slotType == NotificationSlotType.currentLocation)
          .firstOrNull;
      final prevRegionCode = currentLocationSlot?.regionId;
      final prevRegionName = currentLocationSlot?.regionName;
      // 統合スロットモデルでは EEW / 地震情報のリージョンが1つに統合されているため、
      // city 情報も同じ current_location スロットから取得する。
      final prevCityCode = currentLocationSlot?.cityCode;
      final prevCityName = currentLocationSlot?.cityName;

      final resolver = await ref.read(jmaRegionResolverProvider.future);
      const retry = BackgroundLocationUpdateRetry();
      // 揺れ検知は市区町村コード (area_information_city) のみ必要。
      // earthquakeResolution は親 region 解決に失敗すると null になるため、
      // 揺れ検知用の cityCode は resolver から直接取得する。
      final shakeCityCode = resolver.resolveCityCode(latitude, longitude);
      final tsunamiForecastRegionCode = resolver
          .resolveTsunamiForecastRegionCode(latitude, longitude);

      // スロットリージョン更新（EEW と地震情報が統合されたので1回で済む）
      EarthquakeRegionResolution? earthquakeResolution;
      var didUpdateEew = false;
      String? eewError;
      try {
        didUpdateEew = await retry.run(
          action: () async {
            final resolution = resolver.resolveEarthquakeRegion(
              latitude,
              longitude,
            );
            earthquakeResolution = resolution;
            if (resolution == null) {
              throw StateError('AreaForecastLocalE could not be resolved');
            }
            return ref
                .read(notificationSlotsProvider.notifier)
                .updateCurrentLocationRegion(
                  regionCode: resolution.regionCode,
                  regionName: resolution.regionName,
                  cityCode: resolution.cityCode,
                  tsunamiForecastRegionCode: tsunamiForecastRegionCode,
                );
          },
        );
      } on Object catch (e, st) {
        talker.error('[BackgroundLocation] update slot location failed', e, st);
        eewError = e.toString();
      }
      final resolution = earthquakeResolution;

      // 地震情報は統合スロットで一緒に更新されるため、個別更新不要。
      final didUpdateEarthquake = didUpdateEew;
      const String? earthquakeError = null;

      // ホーム画面ウィジェット「現在地」表示用に App Group へ現在地の
      // 一次細分化地域を反映する（iOS のみ）。
      await syncCurrentLocationToAppGroup(ref, resolution);

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
        talker.error(
          '[BackgroundLocation] update shake location failed',
          e,
          st,
        );
        shakeError = e.toString();
      }

      if (resolution == null) {
        return;
      }

      // デバッグ通知
      await fireDebugNotifications(
        ref,
        latitude: latitude,
        longitude: longitude,
        prevRegionCode: prevRegionCode,
        prevRegionName: prevRegionName,
        newRegionCode: resolution.regionCode,
        newRegionName: resolution.regionName,
        prevCityCode: prevCityCode,
        prevCityName: prevCityName,
        cityCode: resolution.cityCode,
        cityName: resolution.cityName,
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

  Future<void> syncCurrentLocationToAppGroup(
    Ref ref,
    EarthquakeRegionResolution? resolution,
  ) async {
    if (!Platform.isIOS) {
      return;
    }
    try {
      final prefs = await ref.read(appGroupPreferencesProvider.future);
      final changed = await AppGroupSettingsWriter.writeCurrentLocationRegion(
        prefs,
        regionCode: resolution?.regionCode,
        regionName: resolution?.regionName,
      );
      if (changed) {
        await WidgetTimelineReloader.reload();
      }
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] sync app group failed', e, st);
    }
  }

  Future<void> fireDebugNotifications(
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
      final debugSettings = ref
          .read(backgroundLocationDebugSettingsProvider)
          .value;
      if (debugSettings == null ||
          (!debugSettings.notifyLatLng &&
              !debugSettings.notifyRegion &&
              !debugSettings.notifyPrefecture &&
              !debugSettings.notifyApiUpdate)) {
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
        final summary =
            'EEW:${BackgroundLocationDebugStatusMark.mark(didUpdate: didUpdateEew, error: eewError)} '
            '地震:${BackgroundLocationDebugStatusMark.mark(didUpdate: didUpdateEarthquake, error: earthquakeError)} '
            '揺れ:${BackgroundLocationDebugStatusMark.mark(didUpdate: didUpdateShake, error: shakeError)}';
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
}

/// デバッグ通知本文の更新状況マーク（✓/✗/-）を組み立てる。
class BackgroundLocationDebugStatusMark {
  static String mark({required bool didUpdate, String? error}) =>
      error != null ? '✗' : (didUpdate ? '✓' : '-');
}
