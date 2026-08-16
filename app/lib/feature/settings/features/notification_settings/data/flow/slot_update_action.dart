import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'slot_update_action.g.dart';

@riverpod
SlotUpdateAction slotUpdateAction(Ref ref) => SlotUpdateAction();

class SlotUpdateAction {
  Future<void> execute(
    WidgetRef ref,
    NotificationSlot slot, {
    bool? eewEnabled,
    JmaIntensity? eewMinIntensity,
    bool? earthquakeEnabled,
    JmaIntensity? earthquakeMinIntensity,
  }) async {
    final resolvedEewEnabled = eewEnabled ?? slot.eewEnabled;
    final resolvedEewMinIntensity = eewMinIntensity ?? slot.eewMinIntensity;
    final resolvedEarthquakeEnabled =
        earthquakeEnabled ?? slot.earthquakeEnabled;
    final resolvedEarthquakeMinIntensity =
        earthquakeMinIntensity ?? slot.earthquakeMinIntensity;

    switch (slot.slotType) {
      case NotificationSlotType.currentLocation:
        await NotificationSlotsNotifier.putCurrentLocationMutation.run(
          ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .putCurrentLocation(
                  eewEnabled: resolvedEewEnabled,
                  eewOverrides: slot.eewOverrides,
                  earthquakeEnabled: resolvedEarthquakeEnabled,
                  earthquakeOverrides: slot.earthquakeOverrides,
                );
          },
        );
      case NotificationSlotType.nationwide:
        await NotificationSlotsNotifier.putNationwideMutation.run(
          ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .putNationwide(
                  eewEnabled: resolvedEewEnabled,
                  eewMinIntensity: resolvedEewMinIntensity,
                  eewOverrides: slot.eewOverrides,
                  earthquakeEnabled: resolvedEarthquakeEnabled,
                  earthquakeMinIntensity: resolvedEarthquakeMinIntensity,
                  earthquakeOverrides: slot.earthquakeOverrides,
                );
          },
        );
      case NotificationSlotType.region:
        await NotificationSlotsNotifier.updateRegionMutation.run(
          ref,
          (tsx) async {
            await tsx
                .get(notificationSlotsProvider.notifier)
                .updateRegion(
                  slotId: slot.id,
                  eewEnabled: resolvedEewEnabled,
                  eewMinIntensity: resolvedEewMinIntensity,
                  eewOverrides: slot.eewOverrides,
                  earthquakeEnabled: resolvedEarthquakeEnabled,
                  earthquakeMinIntensity: resolvedEarthquakeMinIntensity,
                  earthquakeOverrides: slot.earthquakeOverrides,
                );
          },
        );
    }
  }
}
