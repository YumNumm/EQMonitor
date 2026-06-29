import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiSlotResponseConverter', () {
    test('converts region slot with all fields', () {
      final response = api.SlotResponse(
        id: 'slot-1',
        slotType: api.SlotType.region,
        regionId: 130000,
        regionName: '東京都',
        cityCode: '1310100',
        cityName: '千代田区',
        displayOrder: 0,
        eewEnabled: true,
        eewMinIntensity: api.EewMinIntensity.value3,
        eewOverrides: [
          api.SlotOverride(
            minJmaIntensity: api.MinJmaIntensity.value5minus,
            sound: 'alert',
            interruptionLevel: api.InterruptionLevel.critical,
          ),
        ],
        earthquakeEnabled: true,
        earthquakeMinIntensity: api.EarthquakeMinIntensity.value4,
        earthquakeOverrides: null,
        createdAt: '2026-06-30T00:00:00Z',
        updatedAt: '2026-06-30T00:00:00Z',
      );

      final slot = response.toNotificationSlot();

      expect(slot.id, 'slot-1');
      expect(slot.slotType, NotificationSlotType.region);
      expect(slot.regionId, 130000);
      expect(slot.regionName, '東京都');
      expect(slot.cityCode, '1310100');
      expect(slot.cityName, '千代田区');
      expect(slot.displayOrder, 0);
      expect(slot.eewEnabled, isTrue);
      expect(slot.eewMinIntensity, JmaIntensity.three);
      expect(slot.eewOverrides, hasLength(1));
      expect(slot.eewOverrides!.first.minJmaIntensity, JmaIntensity.fiveLower);
      expect(slot.eewOverrides!.first.sound, 'alert');
      expect(
        slot.eewOverrides!.first.interruptionLevel,
        InterruptionLevel.critical,
      );
      expect(slot.earthquakeEnabled, isTrue);
      expect(slot.earthquakeMinIntensity, JmaIntensity.four);
      expect(slot.earthquakeOverrides, isNull);
    });

    test('converts current_location slot with nullable fields', () {
      final response = api.SlotResponse(
        id: 'slot-cl',
        slotType: api.SlotType.currentLocation,
        regionId: null,
        regionName: null,
        cityCode: null,
        cityName: null,
        displayOrder: 0,
        eewEnabled: true,
        eewMinIntensity: api.EewMinIntensity.value4,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
        createdAt: '2026-06-30T00:00:00Z',
        updatedAt: '2026-06-30T00:00:00Z',
      );

      final slot = response.toNotificationSlot();

      expect(slot.slotType, NotificationSlotType.currentLocation);
      expect(slot.regionId, isNull);
      expect(slot.regionName, isNull);
      expect(slot.eewEnabled, isTrue);
      expect(slot.eewMinIntensity, JmaIntensity.four);
      expect(slot.earthquakeEnabled, isFalse);
      expect(slot.earthquakeMinIntensity, isNull);
    });

    test('converts nationwide slot', () {
      final response = api.SlotResponse(
        id: 'slot-nw',
        slotType: api.SlotType.nationwide,
        regionId: null,
        regionName: null,
        cityCode: null,
        cityName: null,
        displayOrder: 1,
        eewEnabled: true,
        eewMinIntensity: api.EewMinIntensity.value5minus,
        eewOverrides: [],
        earthquakeEnabled: true,
        earthquakeMinIntensity: api.EarthquakeMinIntensity.value4,
        earthquakeOverrides: [],
        createdAt: '2026-06-30T00:00:00Z',
        updatedAt: '2026-06-30T00:00:00Z',
      );

      final slot = response.toNotificationSlot();

      expect(slot.slotType, NotificationSlotType.nationwide);
      expect(slot.displayOrder, 1);
      expect(slot.eewMinIntensity, JmaIntensity.fiveLower);
      expect(slot.earthquakeMinIntensity, JmaIntensity.four);
      expect(slot.eewOverrides, isEmpty);
      expect(slot.earthquakeOverrides, isEmpty);
    });
  });

  group('ApiSlotTypeConverter', () {
    test('converts all slot types', () {
      expect(
        api.SlotType.currentLocation.toAppSlotType,
        NotificationSlotType.currentLocation,
      );
      expect(
        api.SlotType.nationwide.toAppSlotType,
        NotificationSlotType.nationwide,
      );
      expect(
        api.SlotType.region.toAppSlotType,
        NotificationSlotType.region,
      );
    });
  });

  group('NotificationSlotType.label', () {
    test('returns correct labels', () {
      expect(NotificationSlotType.currentLocation.label, '現在地');
      expect(NotificationSlotType.nationwide.label, '全国');
      expect(NotificationSlotType.region.label, '地域');
    });
  });
}
