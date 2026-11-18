import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/widget_timeline_reloader.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_consumers_repository.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
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

  await for (final update in BackgroundLocationTracker.pendingLocationStream) {
    await coordinator.applyPendingMessage(ref, pending: update);
    yield null;
  }
}

/// 位置情報の更新を通知スロット・揺れ検知設定・App Group・デバッグ通知へ
/// 反映するコーディネーター。
///
/// [Ref] はコンストラクタではなく各メソッドの引数として受け取る。
class const BackgroundLocationSyncCoordinator() {
  /// 位置情報の監視を、端末に保存済みの状態から宣言し直す。
  ///
  /// 通知スロットは前回値、揺れ検知の「現在地」条件は端末の保存値で判定し、
  /// 起動時に揺れ検知の設定をサーバーから取得しない。
  Future<void> ensureMonitoring(Ref ref) async {
    try {
      final (slots, isShakeCurrentLocationEnabled) = await (
        readSlots(ref),
        readShakeCurrentLocationEnabled(ref),
      ).wait;
      await const BackgroundLocationMonitoringLifecycle().reconcile(
        slots: slots,
        isShakeCurrentLocationEnabled: isShakeCurrentLocationEnabled,
      );
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] ensureMonitoring failed', e, st);
    }
  }

  Future<List<NotificationSlot>?> readSlots(Ref ref) async {
    try {
      return await ref.read(notificationSlotsProvider.future);
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] read slots failed', e, st);
      return null;
    }
  }

  /// 揺れ検知の「現在地」条件が有効かを、サーバーへ問い合わせずに返す。
  ///
  /// 判定できない場合は null を返し、呼び出し側は監視を止めない。
  Future<bool?> readShakeCurrentLocationEnabled(Ref ref) async {
    try {
      final isAvailable = await ref.read(
        isShakeDetectionNotificationAvailableProvider.future,
      );
      if (!isAvailable) {
        // 利用できない端末では、保存値に関係なく無効として確定させる。
        // サーバー側の無効化が未確認なら、この構築の中で一度だけ行う。
        await ref.read(shakeDetectionSettingsProvider.future);
        return false;
      }
    } on Object catch (e, st) {
      // 利用可否が分からない（ロール未取得など）場合は、保存値で判定する。
      talker.info(
        '[BackgroundLocation] shake detection availability is unknown',
        e,
        st,
      );
    }
    final consumers = ref.read(deviceLocationConsumersRepositoryProvider);
    await consumers.restoreStoredShake();
    final isEnabled = await consumers.readShakeCurrentLocationEnabled();
    if (isEnabled != null) {
      return isEnabled;
    }
    // 保存値がない端末（更新直後など）は、headless と共有している
    // 「現在地の送信が有効」の保存値で代用する。有効なら監視を維持し、
    // 無効はスロット・揺れ検知の両方がないと確認できたときだけ保存される。
    return switch (await consumers.storage.readAvailability()) {
      DeviceLocationSyncAvailability.enabled => true,
      DeviceLocationSyncAvailability.disabled => false,
      DeviceLocationSyncAvailability.uninitialized => null,
    };
  }

  Future<void> applyPendingLocation(Ref ref) async {
    try {
      final pending = await BackgroundLocationTracker.peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      );
      if (pending != null) {
        await applyPendingMessage(ref, pending: pending);
      }
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] applyPendingLocation failed', e, st);
    }
  }

  Future<void> applyPendingMessage(
    Ref ref, {
    required PendingLocationMessage pending,
    Set<PendingLocationConsumer> consumers = const {
      PendingLocationConsumer.appEffects,
    },
  }) async {
    if (!consumers.contains(PendingLocationConsumer.appEffects)) {
      return;
    }
    final applied = await applyLocation(
      ref,
      latitude: pending.latitude,
      longitude: pending.longitude,
    );
    if (applied) {
      await acknowledgePendingLocation(
        updateId: pending.updateId,
        consumer: PendingLocationConsumer.appEffects,
      );
    }
  }

  Future<void> acknowledgePendingLocation({
    required String updateId,
    required PendingLocationConsumer consumer,
  }) async {
    try {
      await BackgroundLocationTracker.acknowledgePendingLocation(
        updateId: updateId,
        consumer: consumer,
      );
    } on Object catch (e, st) {
      talker.error(
        '[BackgroundLocation] ${consumer.name} acknowledge failed',
        e,
        st,
      );
    }
  }

  Future<bool> applyLocation(
    Ref ref, {
    required double latitude,
    required double longitude,
  }) async {
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
      EarthquakeRegionResolution? resolution;
      try {
        resolution = await retry.run(
          action: () async {
            final resolved = resolver.resolveEarthquakeRegion(
              latitude,
              longitude,
            );
            if (resolved == null) {
              throw StateError('AreaForecastLocalE could not be resolved');
            }
            return resolved;
          },
        );
      } on Object catch (e, st) {
        talker.error('[BackgroundLocation] resolve app effects failed', e, st);
      }

      const didUpdateEew = false;
      const String? eewError = null;
      const didUpdateEarthquake = false;
      const String? earthquakeError = null;

      // ホーム画面ウィジェット「現在地」表示用に App Group へ現在地の
      // 一次細分化地域を反映する（iOS のみ）。
      final didSyncAppGroup = await syncCurrentLocationToAppGroup(
        ref,
        resolution: resolution,
      );

      if (resolution == null) {
        return false;
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
        eewError: eewError,
        earthquakeError: earthquakeError,
      );
      return didSyncAppGroup;
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] applyLocation failed', e, st);
      return false;
    }
  }

  Future<bool> syncCurrentLocationToAppGroup(
    Ref ref, {
    required EarthquakeRegionResolution? resolution,
  }) async {
    if (!Platform.isIOS) {
      return true;
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
      return true;
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] sync app group failed', e, st);
      return false;
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
    required String? eewError,
    required String? earthquakeError,
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
            '揺れ:共通現在地を使用';
        final errors = [
          if (eewError != null) 'EEW: $eewError',
          if (earthquakeError != null) '地震: $earthquakeError',
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
