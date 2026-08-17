import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'observation_timeline_entry.freezed.dart';

typedef ObservationFirstHeightTimeline =
    List<ObservationFirstHeightTimelineEntry>;
typedef ObservationMaxHeightTimeline = List<ObservationMaxHeightTimelineEntry>;

/// 観測到達第1波（地域/沖合局）のタイムライン行。
@freezed
abstract class ObservationFirstHeightTimelineEntry
    with _$ObservationFirstHeightTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required DateTime? arrivalTime,
    required WaveInitial? initial,
    required bool? isUnidentifiable,
    required bool? isMissing,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _ObservationFirstHeightTimelineEntry;
}

/// 観測最大波高のタイムライン行。
@freezed
abstract class ObservationMaxHeightTimelineEntry
    with _$ObservationMaxHeightTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required DateTime? dateTime,
    required double? value,
    required bool? isOver,
    required bool? isRising,
    required ObservationMaxHeightCondition? condition,
    required bool? isMissing,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _ObservationMaxHeightTimelineEntry;
}
