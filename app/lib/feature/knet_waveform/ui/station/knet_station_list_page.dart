import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_waveform_download_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 観測点の各チャンネルを横断した最大加速度 (gal) を返す。
double _maxAcceleration(Map<KnetChannelDirection, KnetRecord> records) {
  if (records.isEmpty) {
    return 0;
  }
  return records.values
      .map((r) => r.maxAccelerationGal)
      .reduce((a, b) => a > b ? a : b);
}

/// K-NET 観測点一覧画面
///
/// 指定した地震の ZIP をダウンロード・解凍・パースし、
/// 観測点コード・緯度経度・最大加速度を一覧表示する。
class KnetStationListPage extends ConsumerWidget {
  const KnetStationListPage({required this.eventTimeMs, super.key});

  final int eventTimeMs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(knetWaveformDownloadProvider(eventTimeMs));

    return Scaffold(
      appBar: AppBar(
        title: const Text('観測点一覧'),
      ),
      body: async.when(
        loading: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('波形データをダウンロード中...'),
            ],
          ),
        ),
        error: (e, st) {
          final msg = e is KnetWaveformDownloadException
              ? e.message
              : 'データの取得に失敗しました';
          debugPrint('K-NET waveform download error: $e\n$st');
          return _ErrorView(
            message: msg,
            onRetry: () => ref.invalidate(
              knetWaveformDownloadProvider(eventTimeMs),
            ),
          );
        },
        data: (stationMap) => _StationListView(
          stationMap: stationMap,
          eventTimeMs: eventTimeMs,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'データの取得に失敗しました',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StationListView extends StatelessWidget {
  const _StationListView({
    required this.stationMap,
    required this.eventTimeMs,
  });

  final KnetStationRecords stationMap;
  final int eventTimeMs;

  @override
  Widget build(BuildContext context) {
    // maxAcc をソート前に一度だけ計算してキャッシュする
    final sorted =
        stationMap.entries
            .map(
              (e) => (
                stationCode: e.key,
                records: e.value,
                maxAcc: _maxAcceleration(e.value),
              ),
            )
            .toList()
          ..sort((a, b) => b.maxAcc.compareTo(a.maxAcc));

    return ListView.separated(
      itemCount: sorted.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final entry = sorted[index];
        final stationCode = entry.stationCode;
        final records = entry.records;
        final maxAcc = entry.maxAcc;

        // 代表レコード（NS 優先、無ければ最初の成分）
        final representative =
            records[KnetChannelDirection.ns] ?? records.values.first;
        final info = representative.stationInfo;

        return ListTile(
          leading: const Icon(Icons.sensors),
          title: Text(stationCode),
          subtitle: Text(
            '${info.latitude.toStringAsFixed(4)}°N  '
            '${info.longitude.toStringAsFixed(4)}°E\n'
            '最大加速度: ${maxAcc.toStringAsFixed(1)} gal',
          ),
          isThreeLine: true,
          trailing: const Icon(Icons.chevron_right),
          onTap: () => unawaited(
            KnetStationDetailRoute(
              eventTimeMs: eventTimeMs,
              stationCode: stationCode,
            ).push<void>(context),
          ),
        );
      },
    );
  }
}
