import 'dart:convert';

import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

/// 気象庁技術資料ページのHTMLパーサー
class JmaHtmlParser {
  /// 気象庁技術資料ページのURL
  static const String tecMaterialUrl =
      'https://xml.kishou.go.jp/tec_material.html';

  /// 個別コード表のZIPファイルURLを取得する
  ///
  /// Returns: (url, dateVersion) のタプル
  /// - url: ZIPファイルのURL (例: https://xml.kishou.go.jp/jmaxml_20251120_Code.zip)
  /// - dateVersion: yyyyMMdd形式の日付 (例: 20251120)
  Future<({String url, String dateVersion})> fetchCodeTableUrl() async {
    final response = await http.get(Uri.parse(tecMaterialUrl));
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch tec_material.html: ${response.statusCode}',
      );
    }

    final document = html_parser.parse(utf8.decode(response.bodyBytes));

    // 「個別コード表」リンクを検索
    final links = document.querySelectorAll('a');
    for (final link in links) {
      final href = link.attributes['href'];
      if (href == null) continue;

      // jmaxml_yyyyMMdd_Code.zip パターンにマッチするリンクを探す
      final match = RegExp(r'jmaxml_(\d{8})_Code\.zip').firstMatch(href);
      if (match != null) {
        final dateVersion = match.group(1)!;
        final url = href.startsWith('http')
            ? href
            : 'https://xml.kishou.go.jp/$href';
        return (url: url, dateVersion: dateVersion);
      }
    }

    throw Exception('個別コード表のリンクが見つかりませんでした');
  }
}
