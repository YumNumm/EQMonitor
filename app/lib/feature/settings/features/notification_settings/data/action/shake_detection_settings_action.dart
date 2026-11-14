import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
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

  static final locationPermissionMutation = Mutation<void>();

  Future<void> requestLocationPermission(WidgetRef ref) async {
    try {
      await locationPermissionMutation.run(ref, (tsx) async {
        final repository = tsx.get(permissionRepositoryProvider);
        final granted = await repository.requestBackgroundLocationPermission();
        if (!granted) await repository.openLocationSettings();
      });
      ref.invalidate(backgroundLocationPermissionProvider);
    } on Object {
      // Keep the permission guidance visible when permission cannot be requested.
    }
  }

  static final refreshLocationMutation = Mutation<void>();

  Future<void> refreshLocation(WidgetRef ref) async {
    await refreshLocationMutation.run(ref, (tsx) async {
      await tsx.get(currentDeviceLocationProvider.notifier).refresh();
    });
  }
}
