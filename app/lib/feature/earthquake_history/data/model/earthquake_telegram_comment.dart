import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:extensions/extensions.dart';
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

/// 詳細画面に表示するコメント行を選択する
///
/// - VXSE53 があれば最新（reportedAt基準）の53をベースに採用、
///   なければ最新の51と52を結合
/// - VXSE61 / VXSE62 のコメントは追加で表示（タイプごとに最新）
/// - 各電文から固定付加文（additional）→自由付加文（free）の順に収集し、
///   半角化のうえ同一文言は重複除去する
List<String> selectTelegramCommentLines(
  List<EarthquakeTelegramComment> comments,
) {
  EarthquakeTelegramComment? latestOf(EarthquakeTelegramType type) {
    EarthquakeTelegramComment? latest;
    for (final comment in comments) {
      if (comment.type != type) {
        continue;
      }
      if (latest == null || comment.reportedAt.isAfter(latest.reportedAt)) {
        latest = comment;
      }
    }
    return latest;
  }

  final vxse53 = latestOf(EarthquakeTelegramType.vxse53);
  final base = vxse53 != null
      ? [vxse53]
      : [
          latestOf(EarthquakeTelegramType.vxse51),
          latestOf(EarthquakeTelegramType.vxse52),
        ].nonNulls.toList();

  final selected = [
    ...base,
    latestOf(EarthquakeTelegramType.vxse61),
    latestOf(EarthquakeTelegramType.vxse62),
  ].nonNulls;

  final lines = <String>[];
  for (final comment in selected) {
    for (final text in [comment.additional, comment.free]) {
      if (text == null || text.isEmpty) {
        continue;
      }
      final line = text.toHalfWidth;
      if (!lines.contains(line)) {
        lines.add(line);
      }
    }
  }
  return lines;
}
