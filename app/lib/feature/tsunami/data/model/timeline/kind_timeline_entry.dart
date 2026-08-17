import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kind_timeline_entry.freezed.dart';

typedef KindTimeline = List<KindTimelineEntry>;

@freezed
abstract class KindTimelineEntry with _$KindTimelineEntry {
  const factory({
    // 追跡項目のフィールド
    required TsunamiWarningKind kind,
    // 電文メタ
    required String telegramId,
    required String? headline,
    required String title,
    required DateTime publishedAt,
    required DateTime? revokedAt,
  }) = _KindTimelineEntry;
}
