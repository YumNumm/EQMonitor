import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

const JmaIntensity currentLocationEewMinIntensity = JmaIntensity.four;
const JmaIntensity currentLocationEarthquakeMinIntensity = JmaIntensity.one;

/// 最小の震度0。配信判定は `最小震度 <= イベント震度` のため常に条件を満たす。
const JmaIntensity allMinIntensity = JmaIntensity.zero;

extension NotificationMinIntensityLabel on JmaIntensity {
  String get minIntensityLabel =>
      this == allMinIntensity ? 'すべて' : '震度$label';

  String get minIntensityThresholdLabel =>
      this == allMinIntensity ? 'すべて' : '震度$label以上';
}

extension NotificationSlotTypeFixedMinIntensity on NotificationSlotType {
  /// 現在地はプリセットの前提条件のため最小震度を固定する。
  JmaIntensity? fixedMinIntensity(NotificationKind kind) => switch (this) {
    .currentLocation => switch (kind) {
      .eew => currentLocationEewMinIntensity,
      .earthquake => currentLocationEarthquakeMinIntensity,
    },
    .nationwide || .region => null,
  };
}
