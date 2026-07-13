import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_comment.freezed.dart';
part 'earthquake_telegram_comment.g.dart';

/// 電文に付随するコメント（固定付加文・自由付加文）
@freezed
abstract class EarthquakeTelegramComment with _$EarthquakeTelegramComment {
  const factory EarthquakeTelegramComment({
    required EarthquakeTelegramType type,
    required DateTime reportedAt,

    /// 固定付加文
    required String? additional,

    /// 自由付加文
    required String? free,
  }) = _EarthquakeTelegramComment;

  factory EarthquakeTelegramComment.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeTelegramCommentFromJson(json);
}

/// APIの電文リストからコメント（固定付加文・自由付加文）を持つ電文を抽出する
List<EarthquakeTelegramComment> extractTelegramComments(
  List<api.EarthquakeTelegram> telegrams,
) => telegrams
    .map((e) {
      final type = e.telegram.type.toEarthquakeTelegramTypeOrNull;
      final comments = e.comments;
      if (type == null || comments == null) {
        return null;
      }
      if (comments.additional == null && comments.free == null) {
        return null;
      }
      return EarthquakeTelegramComment(
        type: type,
        reportedAt: e.telegram.reportedAt,
        additional: comments.additional,
        free: comments.free,
      );
    })
    .nonNulls
    .toList();
