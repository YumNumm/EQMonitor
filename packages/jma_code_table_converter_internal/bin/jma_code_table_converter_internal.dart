import 'dart:io';

import 'package:jma_code_table_converter_internal/jma_code_table_converter_internal.dart';
import 'package:jma_code_table_converter_internal/src/jma_code_downloader.dart';
import 'package:jma_code_table_converter_internal/src/jma_html_parser.dart';
import 'package:jma_code_table_types/jma_code_table.pb.dart';

Future<void> main(List<String> arguments) async {
  print('===== JMA Code Table Converter =====');

  // 1. HTMLパーサーで個別コード表のURLを取得
  print('\n[1/6] Fetching code table URL from JMA website...');
  final parser = JmaHtmlParser();
  final (:url, :dateVersion) = await parser.fetchCodeTableUrl();
  print('URL: $url');
  print('Date version: $dateVersion');

  // 2. ZIPをダウンロード・SHA384計算・展開
  print('\n[2/6] Downloading and extracting ZIP file...');
  final downloader = JmaCodeDownloader();
  final downloadResult = await downloader.downloadAndExtract(
    url: url,
    outputDir: 'tmp',
  );
  print('XLS file: ${downloadResult.xlsFilePath}');

  // 3. PythonスクリプトでXLS→CSV変換
  print('\n[3/6] Converting XLS to CSV...');
  await _convertXlsToCsv(downloadResult.xlsFilePath);

  // 4. 既存の変換処理
  print('\n[4/6] Converting CSV to Protobuf...');
  final converter = JmaCodeTableConverter();
  final table = JmaCodeTable(
    header: JmaCodeTableHeader(
      dateVersion: dateVersion,
      fetchedAt: downloadResult.fetchedAt,
      sourceUrl: url,
      sha384: downloadResult.sha384Hash,
    ),
    areaForecastLocalEew: await converter.convert22(),
    areaInformationPrefectureEarthquake: await converter.convert23(),
    areaEpicenter: await converter.convert41(),
    areaEpicenterAbbreviation: await converter.convert42(),
    areaEpicenterDetail: await converter.convert43(),
  );

  // 5. 出力
  print('\n[5/6] Writing output files...');
  final outputDir = Directory('output');
  if (!outputDir.existsSync()) {
    outputDir.createSync();
  }
  for (final file in outputDir.listSync()) {
    file.deleteSync();
  }

  // JSON
  final jsonFile = File('output/jma_code_table.json');
  await jsonFile.writeAsString(table.toBuilder().writeToJson());
  print('JSON: output/jma_code_table.json');

  // Binary
  const binaryPath = 'output/jma_code_table.pb';
  final binaryFile = File(binaryPath);
  await binaryFile.writeAsBytes(table.writeToBuffer());
  print('Binary: $binaryPath');

  // 6. アセットにコピー
  print('\n[6/6] Copying to application assets...');
  const assetsPath = '../../app/assets/jma_code_table.pb';
  await File(binaryPath).copy(assetsPath);
  print('Copied to: $assetsPath');

  print('\n===== Done! =====');
  print('Header info:');
  print('  Date version: $dateVersion');
  print('  Fetched at: ${downloadResult.fetchedAt}');
  print('  Source URL: $url');
  print('  SHA384: ${downloadResult.sha384Hash}');
}

/// PythonスクリプトでXLSをCSVに変換
Future<void> _convertXlsToCsv(String xlsFilePath) async {
  const scriptDir = 'util/xls_to_csv';

  // uv sync
  print('Running uv sync...');
  var result = await Process.run(
    'uv',
    ['sync'],
    workingDirectory: scriptDir,
  );
  if (result.exitCode != 0) {
    throw Exception('uv sync failed: ${result.stderr}');
  }

  // uv run python3
  print('Running XLS to CSV conversion...');
  result = await Process.run(
    'uv',
    [
      'run',
      'python3',
      'src/xls_to_csv/main.py',
      '-i',
      '../../$xlsFilePath',
      '-o',
      '../../tmp/output',
    ],
    workingDirectory: scriptDir,
  );
  if (result.exitCode != 0) {
    throw Exception('XLS to CSV conversion failed: ${result.stderr}');
  }
  print('CSV files generated in tmp/');
}
