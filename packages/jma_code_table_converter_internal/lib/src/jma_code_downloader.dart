import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// JMAコードテーブルのダウンロード結果
class DownloadResult {
  DownloadResult({
    required this.sha384Hash,
    required this.xlsFilePath,
    required this.fetchedAt,
  });

  /// ZIPファイルのSHA384ハッシュ（16進数文字列）
  final String sha384Hash;

  /// 展開されたXLSファイルのパス
  final String xlsFilePath;

  /// 取得時刻（ISO8601形式）
  final String fetchedAt;
}

/// JMAコードテーブルのダウンローダー
class JmaCodeDownloader {
  /// ZIPファイルをダウンロードし、XLSファイルを展開する
  ///
  /// [url] ダウンロード元URL
  /// [outputDir] 出力ディレクトリ
  Future<DownloadResult> downloadAndExtract({
    required String url,
    required String outputDir,
  }) async {
    final fetchedAt = DateTime.now().toUtc().toIso8601String();

    // ディレクトリを作成
    final dir = Directory(outputDir);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
    dir.createSync(recursive: true);

    // ZIPファイルをダウンロード
    print('Downloading: $url');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to download ZIP: ${response.statusCode}');
    }

    final zipBytes = response.bodyBytes;

    // SHA384ハッシュを計算
    final sha384Hash = sha384.convert(zipBytes).toString();
    print('SHA384: $sha384Hash');

    // ZIPファイルを保存
    final zipPath = '$outputDir/code_table.zip';
    await File(zipPath).writeAsBytes(zipBytes);

    // ZIPを展開
    final archive = ZipDecoder().decodeBytes(zipBytes);
    String? xlsFilePath;

    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content;

        // Shift_JISのファイル名をデコード
        final decodedName = _decodeShiftJisFilename(filename);
        final outputPath = '$outputDir/$decodedName';

        await File(outputPath).writeAsBytes(data);
        print('Extracted: $decodedName');

        // XLSファイルを探す
        if (decodedName.endsWith('.xls')) {
          xlsFilePath = outputPath;
        }
      }
    }

    if (xlsFilePath == null) {
      throw Exception('XLSファイルが見つかりませんでした');
    }

    return DownloadResult(
      sha384Hash: sha384Hash,
      xlsFilePath: xlsFilePath,
      fetchedAt: fetchedAt,
    );
  }

  /// Shift_JISエンコードされたファイル名をデコード（簡易版）
  String _decodeShiftJisFilename(String filename) {
    // archiveパッケージはShift_JISを正しくデコードできない場合があるため、
    // 既知のファイル名パターンで置換
    if (filename.endsWith('.xls') && !filename.endsWith('.xlsx')) {
      // 日本語ファイル名の場合は固定名を使用
      return '地震火山関連コード表.xls';
    }
    return filename;
  }
}
