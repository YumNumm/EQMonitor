import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_forecast_threshold_policy.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const localValues = [
    JmaIntensity.zero,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  group('EewForecastThresholdPolicy.valuesFor', () {
    test('current location uses the local threshold values', () {
      expect(
        EewForecastThresholdPolicy.valuesFor(
          NotificationSlotType.currentLocation,
        ),
        localValues,
      );
    });

    test('region uses the local threshold values', () {
      expect(
        EewForecastThresholdPolicy.valuesFor(NotificationSlotType.region),
        localValues,
      );
    });

    test('nationwide includes intensity one through three', () {
      expect(
        EewForecastThresholdPolicy.valuesFor(NotificationSlotType.nationwide),
        const [
          JmaIntensity.zero,
          JmaIntensity.one,
          JmaIntensity.two,
          JmaIntensity.three,
          JmaIntensity.four,
          JmaIntensity.fiveLower,
          JmaIntensity.fiveUpper,
          JmaIntensity.sixLower,
          JmaIntensity.sixUpper,
          JmaIntensity.seven,
        ],
      );
    });
  });

  group('EewForecastThresholdPolicy.selectedValueFor', () {
    test('keeps an allowed threshold', () {
      expect(
        EewForecastThresholdPolicy.selectedValueFor(
          slotType: NotificationSlotType.currentLocation,
          value: JmaIntensity.four,
        ),
        JmaIntensity.four,
      );
    });

    test('keeps null without converting it to all', () {
      expect(
        EewForecastThresholdPolicy.selectedValueFor(
          slotType: NotificationSlotType.region,
          value: null,
        ),
        isNull,
      );
    });

    test('rejects low thresholds for current location and region', () {
      for (final slotType in const [
        NotificationSlotType.currentLocation,
        NotificationSlotType.region,
      ]) {
        for (final value in const [
          JmaIntensity.one,
          JmaIntensity.two,
          JmaIntensity.three,
        ]) {
          expect(
            () => EewForecastThresholdPolicy.selectedValueFor(
              slotType: slotType,
              value: value,
            ),
            throwsStateError,
          );
        }
      }
    });

    test('rejects unknown threshold variants for every slot', () {
      for (final slotType in NotificationSlotType.values) {
        for (final value in const [
          JmaIntensity.unknown,
          JmaIntensity.fiveUnknown,
          JmaIntensity.sixUnknown,
        ]) {
          expect(
            () => EewForecastThresholdPolicy.selectedValueFor(
              slotType: slotType,
              value: value,
            ),
            throwsStateError,
          );
        }
      }
    });
  });
}
