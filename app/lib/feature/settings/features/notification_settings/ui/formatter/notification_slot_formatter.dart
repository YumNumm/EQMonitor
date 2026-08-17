import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

abstract final class NotificationSlotFormatter {
  static String intensityLabel(JmaIntensity intensity) => switch (intensity) {
    .zero => 'すべて',
    .one => '震度1',
    .two => '震度2',
    .three => '震度3',
    .four => '震度4',
    .fiveLower => '震度5弱',
    .fiveUpper => '震度5強',
    .sixLower => '震度6弱',
    .sixUpper => '震度6強',
    .seven => '震度7',
    .unknown || .fiveUnknown || .sixUnknown => throw StateError(
      '$intensity is not a valid notification threshold',
    ),
  };

  static String displayName(NotificationSlot slot) => switch (slot.slotType) {
    .currentLocation => '現在地',
    .nationwide => '全国',
    .region => switch (slot.regionName) {
      final String regionName when regionName.isNotEmpty =>
        '$regionName${slot.cityName ?? ''}',
      _ => throw StateError('region name is required for a region slot'),
    },
  };

  static String thresholdSubtitle(NotificationSlot slot) =>
      '${displayName(slot)}でこの震度以上が予想された場合に通知します';
}
