import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_preset_slots_builder.g.dart';

@riverpod
NotificationPresetSlotsBuilder notificationPresetSlotsBuilder(Ref ref) =>
    const NotificationPresetSlotsBuilder();

/// プリセットごとの通知スロット構成を組み立てる。
class NotificationPresetSlotsBuilder {
  const NotificationPresetSlotsBuilder();

  static const _currentLocation = NotificationSlotDraft(
    slotType: NotificationSlotType.currentLocation,
    displayOrder: 0,
    eewEnabled: true,
    eewMinIntensity: currentLocationEewMinIntensity,
    earthquakeEnabled: true,
    earthquakeMinIntensity: currentLocationEarthquakeMinIntensity,
  );

  static const _nationwide = NotificationSlotDraft(
    slotType: NotificationSlotType.nationwide,
    displayOrder: 1,
    eewEnabled: true,
    eewMinIntensity: allMinIntensity,
    earthquakeEnabled: true,
    earthquakeMinIntensity: allMinIntensity,
  );

  List<NotificationSlotDraft> build(NotificationPreset preset) =>
      switch (preset) {
        NotificationPreset.recommended || NotificationPreset.custom => const [
          _currentLocation,
        ],
        NotificationPreset.all => const [_currentLocation, _nationwide],
        NotificationPreset.none => const [],
      };
}
