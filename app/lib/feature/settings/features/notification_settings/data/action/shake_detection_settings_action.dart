import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/current_location_permission_action.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/shake_detection_slot_entry_resolver.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class const ShakeDetectionSettingsAction() {
  Future<void> save(WidgetRef ref, List<ShakeDetectionEntry> entries) async {
    try {
      await ShakeDetectionSettingsNotifier.saveMutation.run(ref, (tsx) async {
        await tsx.get(shakeDetectionSettingsProvider.notifier).save(entries);
      });
    } on Object {
      // The mutation listener displays the error; saved state is retained.
    }
  }

  Future<void> updateSlot(
    WidgetRef ref, {
    required NotificationSlot slot,
    bool? enabled,
    ShakeDetectionLevel? minLevel,
  }) async {
    final state = ref.read(shakeDetectionSettingsProvider).value;
    if (state == null) {
      return;
    }
    await save(
      ref,
      const ShakeDetectionSlotEntryResolver().upsert(
        entries: state.entries,
        slot: slot,
        enabled: enabled,
        minLevel: minLevel,
      ),
    );
  }

  Future<void> setSlotEnabled(
    WidgetRef ref, {
    required NotificationSlot slot,
    required bool enabled,
  }) async {
    if (enabled && slot.slotType == .currentLocation) {
      final permission = ref.read(backgroundLocationPermissionProvider).value;
      if (permission != .always &&
          !await const CurrentLocationPermissionAction().request(ref)) {
        return;
      }
    }
    await updateSlot(ref, slot: slot, enabled: enabled);
  }

  Future<void> detachSlot(
    WidgetRef ref, {
    required NotificationSlot slot,
  }) async {
    final state = ref.read(shakeDetectionSettingsProvider).value;
    final slots = ref.read(notificationSlotsProvider).value;
    if (state == null || slots == null) {
      return;
    }
    final entries = const ShakeDetectionSlotEntryResolver().detach(
      entries: state.entries,
      slot: slot,
      remainingSlots: slots.where((s) => s.id != slot.id).toList(),
    );
    if (entries.length == state.entries.length) {
      return;
    }
    await ShakeDetectionSettingsNotifier.saveMutation.run(ref, (tsx) async {
      await tsx.get(shakeDetectionSettingsProvider.notifier).save(entries);
    });
  }

  static final refreshLocationMutation = Mutation<void>();

  Future<void> refreshLocation(WidgetRef ref) async {
    await refreshLocationMutation.run(ref, (tsx) async {
      await tsx.get(currentDeviceLocationProvider.notifier).refresh();
    });
  }
}
