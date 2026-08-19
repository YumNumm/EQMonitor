import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiSlotOverrideConverter', () {
    test('converts SlotOverride to NotificationOverride', () {
      const apiOverride = api.SlotOverride(
        minJmaIntensity: api.MinJmaIntensity.value5minus,
        sound: 'alert_sound',
        interruptionLevel: api.InterruptionLevel.critical,
      );

      final override = apiOverride.toNotificationOverride();

      expect(override.minJmaIntensity, JmaIntensity.fiveLower);
      expect(override.sound, 'alert_sound');
      expect(override.interruptionLevel, InterruptionLevel.critical);
    });
  });

  group('InterruptionLevel converters', () {
    test('ApiInterruptionLevelConverter maps all values', () {
      expect(
        api.InterruptionLevel.passive.toAppInterruptionLevel,
        InterruptionLevel.passive,
      );
      expect(
        api.InterruptionLevel.active.toAppInterruptionLevel,
        InterruptionLevel.active,
      );
      expect(
        api.InterruptionLevel.timeSensitive.toAppInterruptionLevel,
        InterruptionLevel.timeSensitive,
      );
      expect(
        api.InterruptionLevel.critical.toAppInterruptionLevel,
        InterruptionLevel.critical,
      );
    });

    test('ApiDefaultInterruptionLevelConverter maps all values', () {
      expect(
        api.DefaultInterruptionLevel.passive.toAppInterruptionLevel,
        InterruptionLevel.passive,
      );
      expect(
        api.DefaultInterruptionLevel.active.toAppInterruptionLevel,
        InterruptionLevel.active,
      );
      expect(
        api.DefaultInterruptionLevel.timeSensitive.toAppInterruptionLevel,
        InterruptionLevel.timeSensitive,
      );
      expect(
        api.DefaultInterruptionLevel.critical.toAppInterruptionLevel,
        InterruptionLevel.critical,
      );
    });

    test('ApiNationwideInterruptionLevelConverter maps all values', () {
      expect(
        api.NationwideInterruptionLevel.passive.toAppInterruptionLevel,
        InterruptionLevel.passive,
      );
      expect(
        api.NationwideInterruptionLevel.active.toAppInterruptionLevel,
        InterruptionLevel.active,
      );
    });

    test('InterruptionLevelToApi maps to API types', () {
      expect(
        InterruptionLevel.passive.toApiInterruptionLevel,
        api.InterruptionLevel.passive,
      );
      expect(
        InterruptionLevel.active.toApiInterruptionLevel,
        api.InterruptionLevel.active,
      );
      expect(
        InterruptionLevel.timeSensitive.toApiInterruptionLevel,
        api.InterruptionLevel.timeSensitive,
      );
      expect(
        InterruptionLevel.critical.toApiInterruptionLevel,
        api.InterruptionLevel.critical,
      );
    });

    test('toApiNationwideInterruptionLevel maps every level', () {
      expect(
        InterruptionLevel.passive.toApiNationwideInterruptionLevel,
        api.NationwideInterruptionLevel.passive,
      );
      expect(
        InterruptionLevel.active.toApiNationwideInterruptionLevel,
        api.NationwideInterruptionLevel.active,
      );
      expect(
        InterruptionLevel.timeSensitive.toApiNationwideInterruptionLevel,
        api.NationwideInterruptionLevel.timeSensitive,
      );
      expect(
        InterruptionLevel.critical.toApiNationwideInterruptionLevel,
        api.NationwideInterruptionLevel.critical,
      );
    });

    test('toApiCurrentLocationInterruptionLevel maps every level', () {
      expect(
        InterruptionLevel.passive.toApiCurrentLocationInterruptionLevel,
        api.CurrentLocationInterruptionLevel.passive,
      );
      expect(
        InterruptionLevel.active.toApiCurrentLocationInterruptionLevel,
        api.CurrentLocationInterruptionLevel.active,
      );
      expect(
        InterruptionLevel.timeSensitive.toApiCurrentLocationInterruptionLevel,
        api.CurrentLocationInterruptionLevel.timeSensitive,
      );
      expect(
        InterruptionLevel.critical.toApiCurrentLocationInterruptionLevel,
        api.CurrentLocationInterruptionLevel.critical,
      );
    });

    test('ApiCurrentLocationInterruptionLevelConverter maps back', () {
      expect(
        api
            .CurrentLocationInterruptionLevel
            .timeSensitive
            .toAppInterruptionLevel,
        InterruptionLevel.timeSensitive,
      );
      expect(
        api.NationwideInterruptionLevel.critical.toAppInterruptionLevel,
        InterruptionLevel.critical,
      );
    });
  });

  group('NotificationOverrideToApi', () {
    test('converts back to API SlotOverride', () {
      const override = NotificationOverride(
        minJmaIntensity: JmaIntensity.fiveLower,
        sound: 'default',
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      final apiOverride = override.toApiSlotOverride();

      expect(apiOverride.minJmaIntensity, api.MinJmaIntensity.value5minus);
      expect(apiOverride.sound, 'default');
      expect(
        apiOverride.interruptionLevel,
        api.InterruptionLevel.timeSensitive,
      );
    });
  });
}
