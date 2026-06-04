import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_notification_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
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

  /// バックグラウンド位置更新時に現在地エントリの region/city を更新する。
  /// 現在地エントリが存在しない場合は何もしない（追加はユーザー操作で行う）。
  /// 更新が実行された場合は true、変化なしまたはスキップの場合は false を返す。
  ///
  /// 地震通知は一次細分化地域コード (`area_information_city` の親 region) と
  /// 市区町村コードの両方で配信制御するため、両者を更新する。
  Future<bool> updateCurrentLocationRegion({
    required int regionCode,
    String? regionName,
    String? cityCode,
    String? cityName,
  }) async {
    final current = await future;
    final existing = current.regions
        .where((r) => r.isCurrentLocation)
        .firstOrNull;
    if (existing == null ||
        (existing.regionId == regionCode && existing.cityCode == cityCode)) {
      return false;
    }

    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = [
      ...current.regions.where((r) => !r.isCurrentLocation),
      existing.copyWith(
        regionId: regionCode,
        regionName: regionName,
        cityCode: cityCode,
        cityName: cityName,
      ),
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

  /// 現在地エントリを新規追加する。
  ///
  /// 呼び出し側 (picker) が `resolveEarthquakeRegion` で region+city を解決済の
  /// 前提。引数省略時は region=0 (全国フォールバック) で追加する。
  Future<void> addCurrentLocationRegion({
    int regionCode = 0,
    String? regionName,
    String? cityCode,
    String? cityName,
    JmaIntensity minIntensity = JmaIntensity.four,
  }) async {
    final current = state.requireValue;
    talker.debug(
      '[Earthquake] addCurrentLocationRegion: regions=${current.regions.length}, '
      'hasCurrentLocation=${current.regions.any((r) => r.isCurrentLocation)}, '
      'regionCode=$regionCode, cityCode=$cityCode',
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
        cityCode: cityCode,
        cityName: cityName,
        isCurrentLocation: true,
        minJmaIntensity: minIntensity,
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
        try {
          await BackgroundLocationTracker.startMonitoring();
        } on Object catch (e, st) {
          talker.error(
            '[Earthquake] BackgroundLocationTracker.startMonitoring',
            e,
            st,
          );
        }
      case Failure(:final exception):
        talker.error('[Earthquake] putEarthquakeRegions failure', exception);
        throw exception;
    }
  }

  Future<void> addRegion({
    required int regionId,
    required String regionName,
    required JmaIntensity minIntensity,
    String? cityCode,
    String? cityName,
  }) async {
    final current = state.requireValue;
    // 同一 (regionId, cityCode) の重複を防ぐ。cityCode が NULL の region 単位
    // 設定と、cityCode 指定の city 単位設定は別エントリとして扱う。
    if (current.regions.any(
      (r) =>
          !r.isCurrentLocation &&
          r.regionId == regionId &&
          r.cityCode == cityCode,
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
        cityCode: cityCode,
        cityName: cityName,
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
    String? cityCode,
  }) async {
    final current = state.requireValue;
    final deviceId = await ref.read(deviceIdProvider.future);
    final repo = await ref.read(
      deviceNotificationSettingsRepositoryProvider.future,
    );
    final updated = current.regions
        .where(
          (r) =>
              !(r.regionId == regionId &&
                  r.isCurrentLocation == isCurrentLocation &&
                  r.cityCode == cityCode),
        )
        .toList();
    final result = await repo.putEarthquakeRegions(
      deviceId: deviceId,
      regions: updated,
    );
    switch (result) {
      case Success(:final value):
        final nextSettings = current.copyWith(regions: value);
        state = AsyncData(nextSettings);
        if (isCurrentLocation && !value.any((r) => r.isCurrentLocation)) {
          final eewSettings = await (() async {
            try {
              return await ref.read(eewSettingsProvider.future);
            } on Object catch (e, st) {
              talker.error('[Earthquake] read EEW settings failed', e, st);
              return null;
            }
          })();
          final shakeDetectionState = await (() async {
            try {
              return await ref.read(shakeDetectionSettingsProvider.future);
            } on Object catch (e, st) {
              talker.error(
                '[Earthquake] read shake detection settings failed',
                e,
                st,
              );
              return null;
            }
          })();
          const lifecycle = BackgroundLocationMonitoringLifecycle();
          await lifecycle.stopIfUnused(
            eewSettings: eewSettings,
            earthquakeSettings: nextSettings,
            shakeDetectionState: shakeDetectionState,
          );
        }
      case Failure(:final exception):
        throw exception;
    }
  }
}
