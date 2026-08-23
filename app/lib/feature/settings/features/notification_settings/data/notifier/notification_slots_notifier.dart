import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_slots_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationSlotsNotifier extends _$NotificationSlotsNotifier {
  @override
  Future<List<NotificationSlot>> build() async {
    final status = await ref.watch(deviceProvisioningProvider.future);
    if (status != .notRequired) {
      throw StateError('Device not provisioned');
    }
    final repo = await ref.watch(notificationSlotRepositoryProvider.future);
    final slots = await repo.getSlots();
    await ref
        .read(deviceLocationSyncStateRepositoryProvider)
        .writeAvailability(
          slots.any(
                (slot) => slot.slotType == NotificationSlotType.currentLocation,
              )
              ? DeviceLocationSyncAvailability.enabled
              : DeviceLocationSyncAvailability.disabled,
        );
    return slots;
  }

  static final putCurrentLocationMutation = Mutation<void>();

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
    await ref
        .read(deviceLocationSyncStateRepositoryProvider)
        .writeAvailability(DeviceLocationSyncAvailability.enabled);
    await _startBackgroundLocationMonitoring();
    ref.invalidateSelf();
  }

  static final replaceSlotsMutation = Mutation<void>();

  Future<void> replaceSlots(List<NotificationSlotDraft> slots) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    final replacedSlots = await repo.replaceSlots(slots);
    final hasCurrentLocation = replacedSlots.any(
      (slot) => slot.slotType == NotificationSlotType.currentLocation,
    );
    await ref
        .read(deviceLocationSyncStateRepositoryProvider)
        .writeAvailability(
          hasCurrentLocation
              ? DeviceLocationSyncAvailability.enabled
              : DeviceLocationSyncAvailability.disabled,
        );
    if (hasCurrentLocation) {
      await _startBackgroundLocationMonitoring();
    }
    ref.invalidateSelf();
  }

  Future<void> _startBackgroundLocationMonitoring() async {
    try {
      await BackgroundLocationTracker.startMonitoring();
    } on Object catch (e, st) {
      talker.error(
        '[NotificationSlots] BackgroundLocationTracker.startMonitoring',
        e,
        st,
      );
    }
  }

  static final deleteCurrentLocationMutation = Mutation<void>();

  Future<void> deleteCurrentLocation() async {
    final currentSlots = await future;
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteCurrentLocation();
    await ref
        .read(deviceLocationSyncStateRepositoryProvider)
        .writeAvailability(DeviceLocationSyncAvailability.disabled);
    final slotsWithoutCurrentLocation = currentSlots
        .where((s) => s.slotType != NotificationSlotType.currentLocation)
        .toList();
    final shakeDetectionState = ref.read(shakeDetectionSettingsProvider).value;
    const lifecycle = BackgroundLocationMonitoringLifecycle();
    await lifecycle.stopIfUnused(
      slots: slotsWithoutCurrentLocation,
      shakeDetectionState: shakeDetectionState,
    );
    ref.invalidateSelf();
  }

  static final putNationwideMutation = Mutation<void>();

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

  static final deleteNationwideMutation = Mutation<void>();

  Future<void> deleteNationwide() async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.deleteNationwide();
    ref.invalidateSelf();
  }

  static final addRegionMutation = Mutation<void>();

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

  static final updateRegionMutation = Mutation<void>();

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

  static final removeRegionMutation = Mutation<void>();

  Future<void> removeRegion({required String slotId}) async {
    final repo = await ref.read(notificationSlotRepositoryProvider.future);
    await repo.removeRegion(slotId: slotId);
    ref.invalidateSelf();
  }
}
