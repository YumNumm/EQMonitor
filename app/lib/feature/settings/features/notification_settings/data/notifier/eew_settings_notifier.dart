import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
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
    );
    switch (result) {
      case Success(:final value):
        state = AsyncData(value.copyWith(regions: current.regions));
      case Failure(:final exception):
        throw exception;
    }
  }

  Future<void> addCurrentLocationRegion() async {
    final current = state.requireValue;
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
      case Failure(:final exception):
        throw exception;
    }
  }
}
