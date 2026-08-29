import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShakeDetectionSettingsNotifier extends _$ShakeDetectionSettingsNotifier {
  static final addCurrentLocationMutation = Mutation<void>();
  static final removeEntryMutation = Mutation<void>();
  static final updateLevelMutation = Mutation<void>();

  @override
  Future<ShakeDetectionState> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired) {
      throw StateError('Device not provisioned');
    }
    final apiClient = await ref.watch(apiClientProvider.future);
    final (entriesResponse, subRegionsResponse) = await (
      apiClient.device.getV2DeviceMeSettingsShakeDetection(),
      apiClient.device.getV2DeviceMeSettingsShakeDetectionSubRegions(),
    ).wait;
    final rawEntries = entriesResponse.data.map((r) => r.toModel()).toList();
    final subRegions = subRegionsResponse.data
        .map(
          (r) => ShakeDetectionSubRegion(id: r.id, code: r.code, name: r.name),
        )
        .toList();
    return (
      entries: _resolveNames(rawEntries, subRegions),
      availableSubRegions: subRegions,
    );
  }

  Future<bool> updateCurrentLocationSubRegion(String? cityCode) async {
    final current = await future;
    final existing = current.entries
        .where((e) => e.isCurrentLocation)
        .firstOrNull;
    if (existing == null) {
      return false;
    }

    final newSubRegionId = cityCode == null
        ? null
        : current.availableSubRegions
              .where((s) => s.code == cityCode)
              .map((s) => s.id)
              .firstOrNull;

    if (existing.subRegionId == newSubRegionId) {
      return false;
    }

    final apiClient = await ref.read(apiClientProvider.future);
    final updated = current.entries.map((e) {
      return e.isCurrentLocation ? e.copyWith(subRegionId: newSubRegionId) : e;
    }).toList();
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: updated.map((e) => e.toApiRequest()).toList(),
    );
    final value = response.data.map((r) => r.toModel()).toList();
    state = AsyncData((
      entries: _resolveNames(value, current.availableSubRegions),
      availableSubRegions: current.availableSubRegions,
    ));
    return true;
  }

  Future<void> addCurrentLocation({
    ShakeDetectionLevel level = ShakeDetectionLevel.medium,
  }) async {
    final current = state.requireValue;
    if (current.entries.any((e) => e.isCurrentLocation)) {
      return;
    }
    final apiClient = await ref.read(apiClientProvider.future);
    final updated = [
      ...current.entries,
      ShakeDetectionEntry(
        id: '',
        subRegionId: null,
        subRegionName: null,
        minLevel: level,
        isCurrentLocation: true,
      ),
    ];
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: updated.map((e) => e.toApiRequest()).toList(),
    );
    final value = response.data.map((r) => r.toModel()).toList();
    state = AsyncData((
      entries: _resolveNames(value, current.availableSubRegions),
      availableSubRegions: current.availableSubRegions,
    ));
    final slots = await (() async {
      try {
        return await ref.read(notificationSlotsProvider.future);
      } on Object catch (e, st) {
        talker.error('[ShakeDetection] read notification slots failed', e, st);
        return null;
      }
    })();
    await const BackgroundLocationMonitoringLifecycle().reconcile(
      slots: slots,
      shakeDetectionState: state.requireValue,
    );
  }

  Future<void> removeEntry(String entryId) async {
    final current = state.requireValue;
    final apiClient = await ref.read(apiClientProvider.future);
    final updated = current.entries.where((e) => e.id != entryId).toList();
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: updated.map((e) => e.toApiRequest()).toList(),
    );
    final value = response.data.map((r) => r.toModel()).toList();
    final nextState = (
      entries: _resolveNames(value, current.availableSubRegions),
      availableSubRegions: current.availableSubRegions,
    );
    state = AsyncData(nextState);
    final slots = await (() async {
      try {
        return await ref.read(notificationSlotsProvider.future);
      } on Object catch (e, st) {
        talker.error('[ShakeDetection] read notification slots failed', e, st);
        return null;
      }
    })();
    await const BackgroundLocationMonitoringLifecycle().reconcile(
      slots: slots,
      shakeDetectionState: nextState,
    );
  }

  Future<void> updateLevel(String entryId, ShakeDetectionLevel newLevel) async {
    final current = state.requireValue;
    final apiClient = await ref.read(apiClientProvider.future);
    final updated = current.entries.map((e) {
      return e.id == entryId ? e.copyWith(minLevel: newLevel) : e;
    }).toList();
    final response = await apiClient.device.putV2DeviceMeSettingsShakeDetection(
      body: updated.map((e) => e.toApiRequest()).toList(),
    );
    final value = response.data.map((r) => r.toModel()).toList();
    state = AsyncData((
      entries: _resolveNames(value, current.availableSubRegions),
      availableSubRegions: current.availableSubRegions,
    ));
  }

  List<ShakeDetectionEntry> _resolveNames(
    List<ShakeDetectionEntry> entries,
    List<ShakeDetectionSubRegion> subRegions,
  ) => entries.map((e) {
    final name = subRegions
        .where((s) => s.id == e.subRegionId)
        .map((s) => s.name)
        .firstOrNull;
    return e.copyWith(subRegionName: name);
  }).toList();
}
