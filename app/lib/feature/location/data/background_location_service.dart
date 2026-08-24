import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/widget_timeline_reloader.dart';
import 'package:eqmonitor/feature/location/data/background_location_debug_settings_provider.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/location/data/logic/background_location_sync_lease.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';
import 'package:eqmonitor/feature/location/data/provider/device_location_sync_scope_provider.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
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
class BackgroundLocationSyncCoordinator {
  const new();

  Future<void> ensureMonitoring(Ref ref) async {
    try {
      final List<NotificationSlot>? slots = await (() async {
        try {
          return await ref.read(notificationSlotsProvider.future);
        } on Object catch (e, st) {
          talker.error('[BackgroundLocation] read slots failed', e, st);
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
      await const BackgroundLocationMonitoringLifecycle().reconcile(
        slots: slots,
        shakeDetectionState: shakeDetectionState,
      );
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] ensureMonitoring failed', e, st);
    }
  }

  Future<void> applyPendingLocation(Ref ref) async {
    try {
      final pendingByUpdateId = <String, PendingLocationMessage>{};
      final consumersByUpdateId = <String, Set<PendingLocationConsumer>>{};
      for (final consumer in PendingLocationConsumer.values) {
        final pending = await BackgroundLocationTracker.peekPendingLocation(
          consumer: consumer,
        );
        if (pending != null) {
          pendingByUpdateId[pending.updateId] = pending;
          consumersByUpdateId
              .putIfAbsent(
                pending.updateId,
                () => <PendingLocationConsumer>{},
              )
              .add(consumer);
        }
      }
      for (final entry in pendingByUpdateId.entries) {
        await applyPendingMessage(
          ref,
          pending: entry.value,
          consumers: consumersByUpdateId[entry.key] ?? const {},
        );
      }
    } on Object catch (e, st) {
      talker.error('[BackgroundLocation] applyPendingLocation failed', e, st);
    }
  }

  Future<void> applyPendingMessage(
    Ref ref, {
    required PendingLocationMessage pending,
    Set<PendingLocationConsumer> consumers = const {
      PendingLocationConsumer.deviceLocation,
      PendingLocationConsumer.appEffects,
    },
  }) async {
    DeviceLocationSyncResult? deviceLocationResult;
    String? deviceLocationError;
    if (consumers.contains(PendingLocationConsumer.deviceLocation)) {
      try {
        deviceLocationResult = await syncDeviceLocation(
          ref,
          pending: pending,
        );
        final shouldAcknowledge = switch (deviceLocationResult) {
          DeviceLocationSyncResult.sent ||
          DeviceLocationSyncResult.unchanged ||
          DeviceLocationSyncResult.disabled => true,
          DeviceLocationSyncResult.uninitialized ||
          DeviceLocationSyncResult.noPending => false,
        };
        if (shouldAcknowledge) {
          await acknowledgePendingLocation(
            updateId: pending.updateId,
            consumer: PendingLocationConsumer.deviceLocation,
          );
        }
      } on Object catch (e, st) {
        talker.error('[BackgroundLocation] device location sync failed', e, st);
        deviceLocationError = e.toString();
      }
    }

    if (!consumers.contains(PendingLocationConsumer.appEffects)) {
      return;
    }
    final applied = await applyLocation(
      ref,
      latitude: pending.latitude,
      longitude: pending.longitude,
      deviceLocationResult: deviceLocationResult,
      deviceLocationError: deviceLocationError,
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

  Future<DeviceLocationSyncResult> syncDeviceLocation(
    Ref ref, {
    required PendingLocationMessage pending,
  }) async {
    final stateRepository = ref.read(
      deviceLocationSyncStateRepositoryProvider,
    );
    final scope = await ref.read(deviceLocationSyncScopeProvider.future);
    if (await stateRepository.readAvailability() ==
        DeviceLocationSyncAvailability.uninitialized) {
      final slots = await ref.read(notificationSlotsProvider.future);
      await stateRepository.writeAvailability(
        slots.any(
              (slot) => slot.slotType == NotificationSlotType.currentLocation,
            )
            ? DeviceLocationSyncAvailability.enabled
            : DeviceLocationSyncAvailability.disabled,
      );
    }
    final resolver = await ref.read(jmaRegionResolverProvider.future);
    final repository = await ref.read(
      notificationSlotRepositoryProvider.future,
    );
    final service = DeviceLocationSyncService(
      scope: scope,
      leaseManager: const BackgroundLocationSyncLeaseManager(),
      stateRepository: stateRepository,
      resolvePayload: ({required latitude, required longitude}) async {
        final resolution = resolver.resolveEarthquakeRegion(
          latitude,
          longitude,
        );
        if (resolution == null) {
          return null;
        }
        return DeviceLocationPayload(
          region: resolution.regionCode.toString(),
          city: resolution.cityCode,
          tsunamiForecastRegion: resolver.resolveTsunamiForecastRegionCode(
            latitude,
            longitude,
          ),
        );
      },
      sendPayload: ({required payload}) async {
        final region = int.tryParse(payload.region);
        if (region == null) {
          throw StateError('Device Location region must be numeric');
        }
        await repository.putDeviceLocation(
          region: region,
          city: payload.city,
          tsunamiForecastRegion: payload.tsunamiForecastRegion,
        );
      },
    );
    final result = await service.syncPending(
      location: PendingDeviceLocation(
        updateId: pending.updateId,
        latitude: pending.latitude,
        longitude: pending.longitude,
        accuracy: pending.accuracy,
        timestampMillis: pending.timestampMillis,
      ),
    );
    if (result == DeviceLocationSyncResult.sent) {
      ref.invalidate(notificationSlotsProvider);
    }
    return result;
  }

  Future<bool> applyLocation(
    Ref ref, {
    required double latitude,
    required double longitude,
    DeviceLocationSyncResult? deviceLocationResult,
    String? deviceLocationError,
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
      // 揺れ検知は市区町村コード (area_information_city) のみ必要。
      // earthquakeResolution は親 region 解決に失敗すると null になるため、
      // 揺れ検知用の cityCode は resolver から直接取得する。
      final shakeCityCode = resolver.resolveCityCode(latitude, longitude);

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

      final didUpdateEew =
          deviceLocationResult == DeviceLocationSyncResult.sent;
      final eewError = deviceLocationError;
      final didUpdateEarthquake = didUpdateEew;
      const String? earthquakeError = null;

      // ホーム画面ウィジェット「現在地」表示用に App Group へ現在地の
      // 一次細分化地域を反映する（iOS のみ）。
      final didSyncAppGroup = await syncCurrentLocationToAppGroup(
        ref,
        resolution: resolution,
      );

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
        didUpdateShake: didUpdateShake,
        eewError: eewError,
        earthquakeError: earthquakeError,
        shakeError: shakeError,
      );
      return shakeError == null && didSyncAppGroup;
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
