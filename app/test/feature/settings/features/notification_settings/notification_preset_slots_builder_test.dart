import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_slots_builder.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const builder = NotificationPresetSlotsBuilder();

  test('recommended は現在地のみ (EEW4 / 地震1)', () {
    final slots = builder.build(NotificationPreset.recommended);
    expect(slots, hasLength(1));
    expect(slots.single.slotType, NotificationSlotType.currentLocation);
    expect(slots.single.eewMinIntensity, JmaIntensity.four);
    expect(slots.single.earthquakeMinIntensity, JmaIntensity.one);
  });

  test('all は現在地 + 全国 (全国は すべて/すべて)', () {
    final slots = builder.build(NotificationPreset.all);
    expect(slots.map((s) => s.slotType), [
      NotificationSlotType.currentLocation,
      NotificationSlotType.nationwide,
    ]);
    final nationwide = slots[1];
    expect(nationwide.eewMinIntensity, JmaIntensity.zero);
    expect(nationwide.earthquakeMinIntensity, JmaIntensity.zero);
  });

  test('none は空', () {
    expect(builder.build(NotificationPreset.none), isEmpty);
  });

  test('custom は現在地のみ', () {
    final slots = builder.build(NotificationPreset.custom);
    expect(slots, hasLength(1));
    expect(slots.single.slotType, NotificationSlotType.currentLocation);
  });
}
