import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'first_height_timeline_entry.freezed.dart';

typedef FirstHeightTimeline = List<FirstHeightTimelineEntry>;

@freezed
abstract class FirstHeightTimelineEntry with _$FirstHeightTimelineEntry {
  const factory FirstHeightTimelineEntry({
    // 追跡項目のフィールド
    required DateTime? arrivalTime,
    required FirstHeightCondition? condition,
    required Revise? revise,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _FirstHeightTimelineEntry;
}
