import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';

const JmaIntensity currentLocationEewMinIntensity = JmaIntensity.four;
const JmaIntensity currentLocationEarthquakeMinIntensity = JmaIntensity.one;

/// 最小の震度0。配信判定は `最小震度 <= イベント震度` のため常に条件を満たす。
const JmaIntensity allMinIntensity = JmaIntensity.zero;

/// スロット種別・通知種別ごとに選べる最小震度を決める。
class NotificationMinIntensityPolicy {
  const new();

  /// 現在地・地域スロットの最小震度の下限。
  ///
  /// 現在地と地域は「自分に関係のある揺れ」を知らせるスロットのため、EEW(予報) は
  /// 震度4以上、地震情報は震度1以上より低い閾値を選べない。「すべて」(震度0) を
  /// 選べるのは全国スロットのみ。
  JmaIntensity? floorOf({
    required NotificationSlotType slotType,
    required NotificationKind kind,
  }) => switch (slotType) {
    NotificationSlotType.nationwide => null,
    NotificationSlotType.currentLocation ||
    NotificationSlotType.region => switch (kind) {
      NotificationKind.eew => currentLocationEewMinIntensity,
      NotificationKind.earthquake => currentLocationEarthquakeMinIntensity,
    },
  };

  /// 選択できる最小震度の一覧を返す。
  List<JmaIntensity> optionsOf({
    required NotificationSlotType slotType,
    required NotificationKind kind,
  }) {
    final floor = floorOf(slotType: slotType, kind: kind);
    if (floor == null) {
      return JmaIntensity.selectableValues;
    }
    return JmaIntensity.selectableValues
        .where((i) => i.orderIndex >= floor.orderIndex)
        .toList();
  }

  /// [minIntensity] を下限まで引き上げる。
  ///
  /// 下限のないスロット、または [minIntensity] が null の場合はそのまま返す。
  JmaIntensity? clamp({
    required NotificationSlotType slotType,
    required NotificationKind kind,
    required JmaIntensity? minIntensity,
  }) {
    if (minIntensity == null) {
      return null;
    }
    final floor = floorOf(slotType: slotType, kind: kind);
    if (floor == null) {
      return minIntensity;
    }
    return minIntensity.orderIndex < floor.orderIndex ? floor : minIntensity;
  }
}

const NotificationMinIntensityPolicy notificationMinIntensityPolicy =
    NotificationMinIntensityPolicy();

extension NotificationMinIntensityLabel on JmaIntensity {
  String get minIntensityLabel => this == allMinIntensity ? 'すべて' : '震度$label';

  String get minIntensityThresholdLabel =>
      this == allMinIntensity ? 'すべて' : '震度$label以上';
}
