import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_settings_notifier.g.dart';

@riverpod
class EewSettingsNotifier extends _$EewSettingsNotifier {
  static final saveSettingsMutation = Mutation<void>();
  static final updateRegionsMutation = Mutation<void>();
  static final saveLiveActivityMutation = Mutation<void>();

  @override
  Future<EewNotificationSettings> build() async {
    final deviceId = await ref.watch(deviceIdProvider.future);
    final repo = await ref.watch(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final (settingsResult, regionsResult) = await (
      repo.getEewSettings(deviceId),
      repo.getEewRegions(deviceId),
    ).wait;
    final settings = switch (settingsResult) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    final regions = switch (regionsResult) {
      Success(:final value) => value,
      Failure(:final exception) => throw exception,
    };
    return settings.copyWith(regions: regions);
  }

  Future<void> setEnabled({required bool enabled}) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final result = await repo.patchEewSettings(
      deviceId: deviceId,
      enabled: enabled,
      criticalThreshold: current.criticalThreshold,
      startLiveActivity: current.startLiveActivity,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> setCriticalThreshold(JmaIntensity? threshold) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final result = await repo.patchEewSettings(
      deviceId: deviceId,
      enabled: current.enabled,
      criticalThreshold: threshold,
      startLiveActivity: current.startLiveActivity,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> setStartLiveActivity({required bool startLiveActivity}) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final result = await repo.patchEewSettings(
      deviceId: deviceId,
      enabled: current.enabled,
      criticalThreshold: current.criticalThreshold,
      startLiveActivity: startLiveActivity,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> addCurrentLocationRegion({
    int regionCode = 0,
    String? regionName,
  }) async {
    final current = state.requireValue;
    talker.debug(
      '[EEW] addCurrentLocationRegion: regions=${current.regions.length}, '
      'hasCurrentLocation=${current.regions.any((r) => r.isCurrentLocation)}',
    );
    if (current.regions.any((r) => r.isCurrentLocation)) {
      return;
    }
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = [
      ...current.regions,
      NotificationRegion(
        regionId: regionCode,
        regionName: regionName,
        isCurrentLocation: true,
        minJmaIntensity: JmaIntensity.four,
      ),
    ];
    final result = await repo.putEewRegions(
      deviceId: deviceId,
      regions: updated,
    );
    talker.debug('[EEW] putEewRegions result: $result');
    switch (result) {
      case Success(:final value):
        talker.debug('[EEW] putEewRegions success: regions=${value.length}');
        state = AsyncData(current.copyWith(regions: value));
        // 現在地リージョンを追加した直後に、ネイティブ側の重大な位置変化監視を開始する。
        // これがないとAndroidのPendingIntent/iOSのSLCが登録されず、
        // 以降の位置更新が一切届かない。
        try {
          await BackgroundLocationTracker.startMonitoring();
        } on Object catch (e, st) {
          talker.error('[EEW] BackgroundLocationTracker.startMonitoring', e, st);
        }
      case Failure(:final exception):
        talker.error('[EEW] putEewRegions failure', exception);
        throw exception;
    }
  }

  /// バックグラウンド位置更新時に現在地エントリのregionIdを更新する。
  /// PK衝突を避けるため実際の細分区域コード（9011等）を使用する。
  /// 更新が実行された場合は true、変化なしでスキップした場合は false を返す。
  Future<bool> updateCurrentLocationRegion({
    required int regionCode,
    String? regionName,
  }) async {
    final current = await future;
    final existing = current.regions.firstWhere(
      (r) => r.isCurrentLocation,
      orElse: () => NotificationRegion(
        regionId: regionCode,
        regionName: regionName,
        isCurrentLocation: true,
        minJmaIntensity: JmaIntensity.four,
      ),
    );

    if (existing.regionId == regionCode) {
      return false;
    }

    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = [
      ...current.regions.where((r) => !r.isCurrentLocation),
      existing.copyWith(regionId: regionCode, regionName: regionName),
    ];
    final result = await repo.putEewRegions(
      deviceId: deviceId,
      regions: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(current.copyWith(regions: value));
        return true;
      case Failure(:final exception):
        talker.error('[EEW] updateCurrentLocationRegion failure', exception);
        throw exception;
    }
  }

  Future<void> addRegion({
    required int regionId,
    required String regionName,
    required JmaIntensity minIntensity,
  }) async {
    final current = state.requireValue;
    if (current.regions.any(
      (r) => !r.isCurrentLocation && r.regionId == regionId,
    )) {
      return;
    }
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = [
      ...current.regions,
      NotificationRegion(
        regionId: regionId,
        regionName: regionName,
        isCurrentLocation: false,
        minJmaIntensity: minIntensity,
      ),
    ];
    final result = await repo.putEewRegions(
      deviceId: deviceId,
      regions: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(current.copyWith(regions: value));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> removeRegion({
    required int regionId,
    required bool isCurrentLocation,
  }) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = current.regions
        .where(
          (r) => !(r.regionId == regionId &&
              r.isCurrentLocation == isCurrentLocation),
        )
        .toList();
    final result = await repo.putEewRegions(
      deviceId: deviceId,
      regions: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(current.copyWith(regions: value));
        // 現在地リージョンを取り除いた場合は重大な位置変化監視も停止する。
        if (isCurrentLocation && !value.any((r) => r.isCurrentLocation)) {
          try {
            await BackgroundLocationTracker.stopMonitoring();
          } on Object catch (e, st) {
            talker.error(
              '[EEW] BackgroundLocationTracker.stopMonitoring',
              e,
              st,
            );
          }
        }
      case Failure(:final exception):
        throw exception;
    }
  }
}
