import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_notification_settings_notifier.g.dart';

@riverpod
class EarthquakeNotificationSettingsNotifier
    extends _$EarthquakeNotificationSettingsNotifier {
  static final saveSettingsMutation = Mutation<void>();
  static final updateRegionsMutation = Mutation<void>();

  @override
  Future<EarthquakeNotificationSettings> build() async {
    final deviceId = await ref.watch(deviceIdProvider.future);
    final repo = await ref.watch(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final (settingsResult, regionsResult) = await (
      repo.getEarthquakeSettings(deviceId),
      repo.getEarthquakeRegions(deviceId),
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
    final result = await repo.patchEarthquakeSettings(
      deviceId: deviceId,
      enabled: enabled,
      criticalThreshold: current.criticalThreshold,
      estimatedIntensityEnabled: current.estimatedIntensityEnabled,
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
    final result = await repo.patchEarthquakeSettings(
      deviceId: deviceId,
      enabled: current.enabled,
      criticalThreshold: threshold,
      estimatedIntensityEnabled: current.estimatedIntensityEnabled,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> setEstimatedIntensityEnabled({required bool enabled}) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final result = await repo.patchEarthquakeSettings(
      deviceId: deviceId,
      enabled: current.enabled,
      criticalThreshold: current.criticalThreshold,
      estimatedIntensityEnabled: enabled,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  /// バックグラウンド位置更新時に現在地エントリのregionIdを更新する。
  /// 現在地エントリが存在しない場合は何もしない（追加はユーザー操作で行う）。
  /// 更新が実行された場合は true、変化なしまたはスキップの場合は false を返す。
  Future<bool> updateCurrentLocationRegion({
    required int regionCode,
    String? regionName,
  }) async {
    final current = state.requireValue;
    final existing =
        current.regions.where((r) => r.isCurrentLocation).firstOrNull;
    if (existing == null || existing.regionId == regionCode) {
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
    final result = await repo.putEarthquakeRegions(
      deviceId: deviceId,
      regions: updated,
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(current.copyWith(regions: value));
        return true;
      case Failure(:final exception):
        talker.error(
          '[Earthquake] updateCurrentLocationRegion failure',
          exception,
        );
        throw exception;
    }
  }

  Future<void> addCurrentLocationRegion() async {
    final current = state.requireValue;
    talker.debug(
      '[Earthquake] addCurrentLocationRegion: regions=${current.regions.length}, '
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
      const NotificationRegion(
        regionId: 0,
        regionName: null,
        isCurrentLocation: true,
        minJmaIntensity: JmaIntensity.four,
      ),
    ];
    final result = await repo.putEarthquakeRegions(
      deviceId: deviceId,
      regions: updated,
    );
    talker.debug('[Earthquake] putEarthquakeRegions result: $result');
    switch (result) {
      case Success(:final value):
        talker.debug(
          '[Earthquake] putEarthquakeRegions success: regions=${value.length}',
        );
        state = AsyncData(current.copyWith(regions: value));
      case Failure(:final exception):
        talker.error('[Earthquake] putEarthquakeRegions failure', exception);
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
    final result = await repo.putEarthquakeRegions(
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
    final result = await repo.putEarthquakeRegions(
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
}
