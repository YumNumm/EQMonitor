import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

abstract final class EewForecastThresholdPolicy {
  static const List<JmaIntensity> localValues = [
    JmaIntensity.zero,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  static const List<JmaIntensity> nationwideValues = [
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
  ];

  static List<JmaIntensity> valuesFor(NotificationSlotType slotType) =>
      switch (slotType) {
        .currentLocation || .region => localValues,
        .nationwide => nationwideValues,
      };

  static JmaIntensity? selectedValueFor({
    required NotificationSlotType slotType,
    required JmaIntensity? value,
  }) {
    if (value == null) {
      return null;
    }
    if (!valuesFor(slotType).contains(value)) {
      throw StateError('$value is not valid for $slotType');
    }
    return value;
  }
}
