import 'dart:convert';

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
/// [eventTimeMs] は DateTime.millisecondsSinceEpoch（URL パラメータとして使用）
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

  final eventTime = DateTime.fromMillisecondsSinceEpoch(eventTimeMs);
  final zipUrl = knetAllZipUrl(eventTime);

  final bytes = await client.fetchBytes(zipUrl);
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

    final content = file.content;
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

  if (result.isEmpty) {
    throw const KnetWaveformDownloadException(
      'ZIPファイルに有効な波形データが含まれていませんでした。',
    );
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
