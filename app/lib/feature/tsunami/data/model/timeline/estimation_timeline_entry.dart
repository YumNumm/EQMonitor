import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimation_timeline_entry.freezed.dart';

typedef EstimationFirstHeightTimeline =
    List<EstimationFirstHeightTimelineEntry>;
typedef EstimationMaxHeightTimeline = List<EstimationMaxHeightTimelineEntry>;

/// 推定到達第1波のタイムライン行。
@freezed
abstract class EstimationFirstHeightTimelineEntry
    with _$EstimationFirstHeightTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required DateTime? arrivalTime,
    required bool? isAlreadyArrived,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _EstimationFirstHeightTimelineEntry;
}

/// 推定最大波高のタイムライン行。
@freezed
abstract class EstimationMaxHeightTimelineEntry
    with _$EstimationMaxHeightTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required DateTime? dateTime,
    required double? value,
    required bool? isOver,
    required QualitativeHeight? qualitative,
    required bool? isObserving,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _EstimationMaxHeightTimelineEntry;
}
