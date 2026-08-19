import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('minIntensityLabel', () {
    test('震度0 は「すべて」', () {
      expect(JmaIntensity.zero.minIntensityLabel, 'すべて');
      expect(JmaIntensity.zero.minIntensityThresholdLabel, 'すべて');
    });

    test('震度1以上は数値ラベル', () {
      expect(JmaIntensity.four.minIntensityLabel, '震度4');
      expect(JmaIntensity.one.minIntensityThresholdLabel, '震度1以上');
    });
  });

  group('current location defaults', () {
    test('予報は震度4、地震情報は震度1', () {
      expect(currentLocationEewMinIntensity, JmaIntensity.four);
      expect(currentLocationEarthquakeMinIntensity, JmaIntensity.one);
    });
  });

  group('NotificationMinIntensityPolicy', () {
    const policy = NotificationMinIntensityPolicy();

    test('全国スロットは「すべて」を含む全選択肢', () {
      for (final kind in NotificationKind.values) {
        expect(
          policy.optionsOf(
            slotType: NotificationSlotType.nationwide,
            kind: kind,
          ),
          JmaIntensity.selectableValues,
        );
        expect(
          policy.floorOf(slotType: NotificationSlotType.nationwide, kind: kind),
          isNull,
        );
      }
    });

    test('現在地・地域の EEW は震度4以上のみ', () {
      for (final slotType in [
        NotificationSlotType.currentLocation,
        NotificationSlotType.region,
      ]) {
        expect(
          policy.optionsOf(slotType: slotType, kind: NotificationKind.eew),
          const [
            JmaIntensity.four,
            JmaIntensity.fiveLower,
            JmaIntensity.fiveUpper,
            JmaIntensity.sixLower,
            JmaIntensity.sixUpper,
            JmaIntensity.seven,
          ],
        );
      }
    });

    test('現在地・地域の地震情報は震度1以上のみ（「すべて」を含まない）', () {
      for (final slotType in [
        NotificationSlotType.currentLocation,
        NotificationSlotType.region,
      ]) {
        final options = policy.optionsOf(
          slotType: slotType,
          kind: NotificationKind.earthquake,
        );
        expect(options.first, JmaIntensity.one);
        expect(options, isNot(contains(allMinIntensity)));
      }
    });

    test('下限を下回る値は引き上げ、下限以上はそのまま', () {
      expect(
        policy.clamp(
          slotType: NotificationSlotType.region,
          kind: NotificationKind.eew,
          minIntensity: allMinIntensity,
        ),
        JmaIntensity.four,
      );
      expect(
        policy.clamp(
          slotType: NotificationSlotType.region,
          kind: NotificationKind.earthquake,
          minIntensity: allMinIntensity,
        ),
        JmaIntensity.one,
      );
      expect(
        policy.clamp(
          slotType: NotificationSlotType.currentLocation,
          kind: NotificationKind.eew,
          minIntensity: JmaIntensity.sixLower,
        ),
        JmaIntensity.sixLower,
      );
    });

    test('全国スロットと null はそのまま返す', () {
      expect(
        policy.clamp(
          slotType: NotificationSlotType.nationwide,
          kind: NotificationKind.eew,
          minIntensity: allMinIntensity,
        ),
        allMinIntensity,
      );
      expect(
        policy.clamp(
          slotType: NotificationSlotType.region,
          kind: NotificationKind.eew,
          minIntensity: null,
        ),
        isNull,
      );
    });
  });
}
