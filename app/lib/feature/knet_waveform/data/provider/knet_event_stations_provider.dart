import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_result.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_client_provider.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_progress_provider.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'knet_event_stations_provider.g.dart';

/// イベント時刻に対応するすべての観測点の CSV を取得し震度計算結果を返す
@riverpod
Future<List<KnetStationResult>> knetEventStations(
  Ref ref,
  DateTime eventTime,
) async {
  final client = await ref.watch(knetDownloadClientProvider.future);
  if (client == null) {
    throw StateError('認証情報が設定されていません');
  }

  final csvMap = await client.downloadAndExtractCsv(
    eventTime,
    onReceiveProgress: (received, total) {
      if (!ref.mounted) {
        return;
      }
      ref
          .read(knetDownloadProgressProvider(eventTime).notifier)
          .update(received, total);
    },
  );

  const parser = KnetCsvParser();
  final results = <KnetStationResult>[];

  for (final entry in csvMap.entries) {
    try {
      final record = parser.parse(entry.value);
      if (record.stationInfo == null) {
        continue;
      }
      final calc = KnetIntensityCalculator(
        samplingFrequencyHz: record.samplingFrequencyHz,
      );
      final rawInt = calc.calculate(record);
      results.add(
        KnetStationResult(
          filename: entry.key,
          record: record,
          rawInt: rawInt,
        ),
      );
    } on Exception {
      // 個別ファイルのパースエラーはスキップ
    }
  }

  results.sort((a, b) => b.rawInt.compareTo(a.rawInt));
  return results;
}
