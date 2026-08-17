import 'package:html/parser.dart' as html_parser;

/// Apache style directory listing HTML から エントリ名一覧を抽出するパーサー
class KnetDirectoryParser {
  const new _();

  /// HTML から相対リンク（末尾 `/` 付きディレクトリ）の名前一覧を返す
  ///
  /// 親ディレクトリへのリンク（絶対パスまたは `Parent Directory`）は除外する。
  /// [html] Apache 形式のディレクトリ一覧 HTML
  static List<String> parseEntries(String html) {
    final document = html_parser.parse(html);
    final anchors = document.querySelectorAll('ul li a');
    final entries = <String>[];
    for (final anchor in anchors) {
      final href = anchor.attributes['href'];
      if (href == null) {
        continue;
      }
      // 絶対パスは親ディレクトリへのリンクなので除外
      if (href.startsWith('/')) {
        continue;
      }
      // ディレクトリ以外（末尾に `/` がないもの）は除外
      if (!href.endsWith('/')) {
        continue;
      }
      // 末尾のスラッシュを除いた名前を追加
      entries.add(href.substring(0, href.length - 1));
    }
    return entries;
  }

  /// HTML からファイルリンク（末尾 `/` なし）の名前一覧を返す
  ///
  /// 親ディレクトリへのリンク（絶対パス）は除外する。
  static List<String> parseFiles(String html) {
    final document = html_parser.parse(html);
    final anchors = document.querySelectorAll('ul li a');
    final entries = <String>[];
    for (final anchor in anchors) {
      final href = anchor.attributes['href'];
      if (href == null || href.startsWith('/') || href.endsWith('/')) {
        continue;
      }
      entries.add(href);
    }
    return entries;
  }

  /// 年一覧ページ HTML から年のリストを返す
  ///
  /// 昇順ソート（古い順）で返す。
  static List<int> parseYears(String html) {
    return parseEntries(html).map(int.tryParse).whereType<int>().toList()
      ..sort();
  }

  /// 月一覧ページ HTML から月番号のリストを返す
  ///
  /// 昇順ソート（1月から）で返す。
  static List<int> parseMonths(String html) {
    return parseEntries(html).map(int.tryParse).whereType<int>().toList()
      ..sort();
  }

  /// 記録一覧ページ HTML から地震発生時刻（ローカル時刻）のリストを返す
  ///
  /// 各エントリは `YYYYMMDDHHmmss` 形式のディレクトリ名として表現される。
  /// パース失敗したエントリは除外する。
  static List<DateTime> parseRecords(String html) {
    final entries = parseEntries(html);
    final records = <DateTime>[];
    for (final entry in entries) {
      final dt = _parseTimestamp(entry);
      if (dt != null) {
        records.add(dt);
      }
    }
    return records;
  }

  static DateTime? _parseTimestamp(String s) {
    if (s.length != 14) {
      return null;
    }
    final year = int.tryParse(s.substring(0, 4));
    final month = int.tryParse(s.substring(4, 6));
    final day = int.tryParse(s.substring(6, 8));
    final hour = int.tryParse(s.substring(8, 10));
    final minute = int.tryParse(s.substring(10, 12));
    final second = int.tryParse(s.substring(12, 14));
    if (year == null ||
        month == null ||
        day == null ||
        hour == null ||
        minute == null ||
        second == null) {
      return null;
    }
    return DateTime(year, month, day, hour, minute, second);
  }
}
