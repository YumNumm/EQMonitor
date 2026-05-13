import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:knet_api_client/knet_api_client.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_waveform_download_provider.g.dart';

/// 観測点コードでグループ化した K-NET 強震記録マップ
///
/// key: 観測点コード (e.g. "IBR011")
/// value: チャンネル方向別の KnetRecord
typedef KnetStationRecords = Map<String, Map<KnetChannelDirection, KnetRecord>>;

/// 指定した地震発生時刻の ZIP をダウンロード・解凍・パースし、
/// 観測点コードでグループ化した記録マップを返す @riverpod provider
///
/// [eventTimeMs] は DateTime.millisecondsSinceEpoch（UTC 基準）。
/// knetAllZipUrl は JST の年月日時分秒を期待するため、UTC+9h に変換して渡す。
@riverpod
Future<KnetStationRecords> knetWaveformDownload(
  Ref ref,
  int eventTimeMs,
) async {
  final client = await ref.watch(knetDownloadClientProvider.future);
  if (client == null) {
    throw const KnetWaveformDownloadException(
      '認証情報が未設定です。設定画面から BOSAI 認証情報を入力してください。',
    );
  }

  // knetAllZipUrl の _format* ヘルパーは DateTime の各フィールド (year/month/day/hour 等)
  // を直接読むため、JST (UTC+9) の DateTime として渡す必要がある。
  // isUtc: true で UTC として解釈したうえで +9h することで、
  // 端末ロケールによらず JST の年月日時分秒が得られる。
  final eventTime = DateTime.fromMillisecondsSinceEpoch(
    eventTimeMs,
    isUtc: true,
  ).add(const Duration(hours: 9));
  final zipUrl = knetAllZipUrl(eventTime);

  final bytes = await client.fetchBytes(zipUrl);

  // ZIP 解凍 + パースは重い処理のため Isolate で実行する
  final result = await Isolate.run(() => _parseZipBytes(bytes));

  if (result.isEmpty) {
    throw const KnetWaveformDownloadException(
      'ZIPファイルに有効な波形データが含まれていませんでした。',
    );
  }

  return result;
}

/// ZIP バイト列を解凍・パースして観測点レコードマップを返す純粋関数。
///
/// UI isolate をブロックしないよう [Isolate.run] から呼び出す。
KnetStationRecords _parseZipBytes(List<int> bytes) {
  final archive = ZipDecoder().decodeBytes(bytes);
  const parser = KnetAsciiParser();
  final result = <String, Map<KnetChannelDirection, KnetRecord>>{};

  for (final file in archive.files) {
    if (file.isDirectory) {
      continue;
    }
    // K-NET ASCII ファイルは .NS / .EW / .UD の拡張子を持つ
    final name = file.name;
    final dot = name.lastIndexOf('.');
    if (dot < 0) {
      continue;
    }
    final ext = name.substring(dot + 1).toUpperCase();
    if (ext != 'NS' && ext != 'EW' && ext != 'UD') {
      continue;
    }

    final content = file.content as List<int>;
    if (content.isEmpty) {
      continue;
    }

    final text = utf8.decode(content, allowMalformed: true);

    try {
      final record = parser.parse(text);
      final stationCode = record.stationInfo.stationCode;
      result.putIfAbsent(stationCode, () => {})[record.direction] = record;
    } on KnetParseException {
      // パース失敗はスキップ
    }
  }

  return result;
}

/// K-NET 波形ダウンロード・パースエラー
class KnetWaveformDownloadException implements Exception {
  const KnetWaveformDownloadException(this.message);
  final String message;

  @override
  String toString() => 'KnetWaveformDownloadException: $message';
}
