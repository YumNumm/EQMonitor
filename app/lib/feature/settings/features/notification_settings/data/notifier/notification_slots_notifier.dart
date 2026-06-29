import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slots_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationSlotsNotifier extends _$NotificationSlotsNotifier {
  static final putCurrentLocationMutation = Mutation<void>();
  static final deleteCurrentLocationMutation = Mutation<void>();
  static final putNationwideMutation = Mutation<void>();
  static final deleteNationwideMutation = Mutation<void>();
  static final addRegionMutation = Mutation<void>();
  static final updateRegionMutation = Mutation<void>();
  static final removeRegionMutation = Mutation<void>();

  @override
  Future<List<NotificationSlot>> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != DeviceProvisioningStatus.notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(notificationSlotRepositoryProvider.future);
    return repo.getSlots();
  }

  Future<void> putCurrentLocation({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.putCurrentLocation(
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    try {
      await BackgroundLocationTracker.startMonitoring();
    } on Object catch (e, st) {
      talker.error(
        '[NotificationSlots] BackgroundLocationTracker.startMonitoring',
        e,
        st,
      );
    }
    ref.invalidateSelf();
  }

  Future<void> deleteCurrentLocation() async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteCurrentLocation();
    ref.invalidateSelf();
    await _stopLocationTrackingIfUnused();
  }

  Future<void> putNationwide({
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.putNationwide(
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    ref.invalidateSelf();
  }

  Future<void> deleteNationwide() async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteNationwide();
    ref.invalidateSelf();
  }

  Future<void> addRegion({
    required int regionId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.addRegion(
      regionId: regionId,
      regionName: regionName,
      cityCode: cityCode,
      cityName: cityName,
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    ref.invalidateSelf();
  }

  Future<void> updateRegion({
    required String slotId,
    String? regionName,
    String? cityCode,
    String? cityName,
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.updateRegion(
      slotId: slotId,
      regionName: regionName,
      cityCode: cityCode,
      cityName: cityName,
      eewEnabled: eewEnabled,
      eewMinIntensity: eewMinIntensity,
      eewOverrides: eewOverrides,
      earthquakeEnabled: earthquakeEnabled,
      earthquakeMinIntensity: earthquakeMinIntensity,
      earthquakeOverrides: earthquakeOverrides,
    );
    ref.invalidateSelf();
  }

  Future<void> removeRegion({required String slotId}) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.removeRegion(slotId: slotId);
    ref.invalidateSelf();
  }

  Future<void> updateCurrentLocationRegion({
    required int regionCode,
    String? regionName,
  }) async {
    final current = await future;
    final existing = current
        .where((s) => s.slotType == NotificationSlotType.currentLocation)
        .firstOrNull;
    if (existing == null || existing.regionId == regionCode) {
      return;
    }
    // 現在地スロットの場合は putCurrentLocation で更新
    // （regionId はスロットの属性ではなく、位置情報更新時に別途処理される）
    ref.invalidateSelf();
  }

  Future<void> _stopLocationTrackingIfUnused() async {
    final current = state.value ?? [];
    final hasCurrentLocation = current.any(
      (s) => s.slotType == NotificationSlotType.currentLocation,
    );
    if (!hasCurrentLocation) {
      const lifecycle = BackgroundLocationMonitoringLifecycle();
      await lifecycle.stopIfUnused(
        eewSettings: null,
        earthquakeSettings: null,
        shakeDetectionState: null,
      );
    }
  }
}
