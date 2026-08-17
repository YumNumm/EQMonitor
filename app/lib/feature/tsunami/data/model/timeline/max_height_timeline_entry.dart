import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'max_height_timeline_entry.freezed.dart';

typedef MaxHeightTimeline = List<MaxHeightTimelineEntry>;

@freezed
abstract class MaxHeightTimelineEntry with _$MaxHeightTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required double? value,
    required bool? isOver,
    required QualitativeHeight? qualitative,
    required bool? isImportant,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _MaxHeightTimelineEntry;
}
