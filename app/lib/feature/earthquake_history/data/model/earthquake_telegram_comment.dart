import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_comment.freezed.dart';
part 'earthquake_telegram_comment.g.dart';

/// 電文に付随するコメント（固定付加文・自由付加文）
@freezed
abstract class EarthquakeTelegramComment with _$EarthquakeTelegramComment {
  const factory({
    required EarthquakeTelegramType type,
    required DateTime reportedAt,

    /// 固定付加文
    required String? additional,

    /// 自由付加文
    required String? free,
  }) = _EarthquakeTelegramComment;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeTelegramCommentFromJson(json);
}
