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

  group('fixedMinIntensity', () {
    test('現在地は EEW=4 / 地震=1 に固定', () {
      expect(
        NotificationSlotType.currentLocation.fixedMinIntensity(
          NotificationKind.eew,
        ),
        JmaIntensity.four,
      );
      expect(
        NotificationSlotType.currentLocation.fixedMinIntensity(
          NotificationKind.earthquake,
        ),
        JmaIntensity.one,
      );
    });

    test('全国・地域は固定しない', () {
      expect(
        NotificationSlotType.nationwide.fixedMinIntensity(NotificationKind.eew),
        isNull,
      );
      expect(
        NotificationSlotType.region.fixedMinIntensity(
          NotificationKind.earthquake,
        ),
        isNull,
      );
    });
  });
}
