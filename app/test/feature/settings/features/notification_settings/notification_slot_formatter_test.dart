import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/formatter/notification_slot_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationSlotFormatter.intensityLabel', () {
    test('formats all supported threshold labels', () {
      const expected = {
        JmaIntensity.zero: 'すべて',
        JmaIntensity.one: '震度1',
        JmaIntensity.two: '震度2',
        JmaIntensity.three: '震度3',
        JmaIntensity.four: '震度4',
        JmaIntensity.fiveLower: '震度5弱',
        JmaIntensity.fiveUpper: '震度5強',
        JmaIntensity.sixLower: '震度6弱',
        JmaIntensity.sixUpper: '震度6強',
        JmaIntensity.seven: '震度7',
      };

      for (final MapEntry(key: intensity, value: label) in expected.entries) {
        expect(NotificationSlotFormatter.intensityLabel(intensity), label);
      }
    });

    test('rejects unknown threshold variants', () {
      for (final value in const [
        JmaIntensity.unknown,
        JmaIntensity.fiveUnknown,
        JmaIntensity.sixUnknown,
      ]) {
        expect(
          () => NotificationSlotFormatter.intensityLabel(value),
          throwsStateError,
        );
      }
    });
  });

  group('NotificationSlotFormatter slot text', () {
    test('formats current location', () {
      const slot = NotificationSlot(
        id: 'current',
        slotType: NotificationSlotType.currentLocation,
        regionId: null,
        regionName: null,
        cityCode: null,
        cityName: null,
        displayOrder: 0,
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
      );

      expect(NotificationSlotFormatter.displayName(slot), '現在地');
      expect(
        NotificationSlotFormatter.thresholdSubtitle(slot),
        '現在地でこの震度以上が予想された場合に通知します',
      );
    });

    test('formats a prefecture-wide region', () {
      const slot = NotificationSlot(
        id: 'prefecture',
        slotType: NotificationSlotType.region,
        regionId: 130000,
        regionName: '東京都',
        cityCode: null,
        cityName: null,
        displayOrder: 1,
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
      );

      expect(NotificationSlotFormatter.displayName(slot), '東京都');
      expect(
        NotificationSlotFormatter.thresholdSubtitle(slot),
        '東京都でこの震度以上が予想された場合に通知します',
      );
    });

    test('joins a prefecture and city without whitespace', () {
      const slot = NotificationSlot(
        id: 'city',
        slotType: NotificationSlotType.region,
        regionId: 130000,
        regionName: '東京都',
        cityCode: '1310400',
        cityName: '新宿区',
        displayOrder: 2,
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
      );

      expect(NotificationSlotFormatter.displayName(slot), '東京都新宿区');
      expect(
        NotificationSlotFormatter.thresholdSubtitle(slot),
        '東京都新宿区でこの震度以上が予想された場合に通知します',
      );
    });

    test('formats nationwide', () {
      const slot = NotificationSlot(
        id: 'nationwide',
        slotType: NotificationSlotType.nationwide,
        regionId: null,
        regionName: null,
        cityCode: null,
        cityName: null,
        displayOrder: 3,
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.one,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
      );

      expect(NotificationSlotFormatter.displayName(slot), '全国');
      expect(
        NotificationSlotFormatter.thresholdSubtitle(slot),
        '全国でこの震度以上が予想された場合に通知します',
      );
    });

    test('rejects a region without its name', () {
      const slot = NotificationSlot(
        id: 'invalid',
        slotType: NotificationSlotType.region,
        regionId: 130000,
        regionName: null,
        cityCode: null,
        cityName: null,
        displayOrder: 4,
        eewEnabled: true,
        eewMinIntensity: JmaIntensity.four,
        eewOverrides: null,
        earthquakeEnabled: false,
        earthquakeMinIntensity: null,
        earthquakeOverrides: null,
      );

      expect(
        () => NotificationSlotFormatter.displayName(slot),
        throwsStateError,
      );
    });
  });
}
