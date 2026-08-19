import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:extensions/extensions.dart';

/// 電文コメントの抽出・選択を行う。
class EarthquakeTelegramCommentSelector {
  const new();

  /// APIの電文リストからコメント（固定付加文・自由付加文）を持つ電文を抽出する
  List<EarthquakeTelegramComment> extract(
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
  List<String> selectLines(List<EarthquakeTelegramComment> comments) {
    final vxse53 = _latestOf(comments, EarthquakeTelegramType.vxse53);
    final base = vxse53 != null
        ? [vxse53]
        : [
            _latestOf(comments, EarthquakeTelegramType.vxse51),
            _latestOf(comments, EarthquakeTelegramType.vxse52),
          ].nonNulls.toList();

    final selected = [
      ...base,
      _latestOf(comments, EarthquakeTelegramType.vxse61),
      _latestOf(comments, EarthquakeTelegramType.vxse62),
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

  EarthquakeTelegramComment? _latestOf(
    List<EarthquakeTelegramComment> comments,
    EarthquakeTelegramType type,
  ) {
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
}
