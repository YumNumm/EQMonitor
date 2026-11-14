import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';

final class const ShakeDetectionSlotEntryResolver() {
  static const defaultMinLevel = ShakeDetectionLevel.medium;

  // 揺れ検知の地域条件は細分化地域単位。市区町村指定の通知地域も
  // 親の細分化地域コード(3桁)で対応付ける。
  String? regionCodeOf(NotificationSlot slot) =>
      slot.regionId?.toString().padLeft(3, '0');

  bool isConfigurable(NotificationSlot slot) =>
      slot.slotType != .region || regionCodeOf(slot) != null;

  bool matches({
    required ShakeDetectionEntry entry,
    required NotificationSlot slot,
  }) => switch (slot.slotType) {
    .currentLocation => entry.targetType == .currentLocation,
    .nationwide => entry.targetType == .nationwide,
    .region =>
      entry.targetType == .region &&
          entry.regionCode != null &&
          entry.regionCode == regionCodeOf(slot),
  };

  ShakeDetectionEntry? find({
    required List<ShakeDetectionEntry> entries,
    required NotificationSlot slot,
  }) => entries.where((entry) => matches(entry: entry, slot: slot)).firstOrNull;

  List<ShakeDetectionEntry> upsert({
    required List<ShakeDetectionEntry> entries,
    required NotificationSlot slot,
    bool? enabled,
    ShakeDetectionLevel? minLevel,
  }) {
    if (!isConfigurable(slot)) {
      throw StateError('Notification slot has no subdivision region code');
    }
    if (find(entries: entries, slot: slot) == null) {
      return [
        ...entries,
        ShakeDetectionEntry(
          id: '',
          targetType: switch (slot.slotType) {
            .currentLocation => .currentLocation,
            .nationwide => .nationwide,
            .region => .region,
          },
          regionCode: slot.slotType == .region ? regionCodeOf(slot) : null,
          enabled: enabled ?? true,
          minLevel: minLevel ?? defaultMinLevel,
        ),
      ];
    }
    return [
      for (final entry in entries)
        if (matches(entry: entry, slot: slot))
          entry.copyWith(
            enabled: enabled ?? entry.enabled,
            minLevel: minLevel ?? entry.minLevel,
          )
        else
          entry,
    ];
  }

  List<ShakeDetectionEntry> detach({
    required List<ShakeDetectionEntry> entries,
    required NotificationSlot slot,
    required List<NotificationSlot> remainingSlots,
  }) {
    final isShared = remainingSlots.any(
      (remaining) =>
          remaining.slotType == slot.slotType &&
          (slot.slotType != .region ||
              regionCodeOf(remaining) == regionCodeOf(slot)),
    );
    if (isShared) {
      return entries;
    }
    return [
      for (final entry in entries)
        if (!matches(entry: entry, slot: slot)) entry,
    ];
  }
}
