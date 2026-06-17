import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_download_progress_provider.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_event_stations_provider.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// K-NET イベントの観測点一覧ページ
class KnetRecordListPage extends ConsumerWidget {
  const KnetRecordListPage({required this.eventTime, super.key});

  final DateTime eventTime;

  static final _dtFmt = DateFormat('yyyy/MM/dd HH:mm:ss');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsAsync = ref.watch(knetEventStationsProvider(eventTime));

    return Scaffold(
      appBar: AppBar(
        title: Text('観測点一覧 — ${_dtFmt.format(eventTime)}'),
      ),
      body: stationsAsync.when(
        loading: () => _DownloadProgressView(eventTime: eventTime),
        error: (e, st) => _ErrorView(message: e.toString()),
        data: (stations) {
          if (stations.isEmpty) {
            return const Center(child: Text('観測点データが見つかりません'));
          }
          return ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, i) {
              final s = stations[i];
              final intensity = JmaIntensityFromRawKnetInt.fromRawKnetInt(
                s.rawInt,
              );
              return ListTile(
                leading: JmaIntensityIcon(
                  intensity: intensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                title: Text(s.stationCode),
                subtitle: s.stationInfo != null
                    ? Text(
                        '緯度: ${s.stationInfo!.latitude.toStringAsFixed(4)}  '
                        '経度: ${s.stationInfo!.longitude.toStringAsFixed(4)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : null,
                trailing: Text(
                  '${s.maxAccelGal.toStringAsFixed(1)} gal',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () =>
                    KnetStationWaveformRoute($extra: s).push<void>(context),
              );
            },
          );
        },
      ),
    );
  }
}

class _DownloadProgressView extends ConsumerWidget {
  const _DownloadProgressView({required this.eventTime});

  final DateTime eventTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(knetDownloadProgressProvider(eventTime));

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (progress == null) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('ディレクトリ一覧を取得中…'),
            ] else ...[
              _buildProgressBar(context, progress),
              const SizedBox(height: 12),
              _buildProgressText(context, progress),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context,
    ({int received, int total}) p,
  ) {
    final value = p.total > 0 ? p.received / p.total : null;
    return Column(
      children: [
        LinearProgressIndicator(value: value),
        const SizedBox(height: 8),
        if (value != null)
          Text(
            '${(value * 100).toStringAsFixed(0)} %',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }

  Widget _buildProgressText(
    BuildContext context,
    ({int received, int total}) p,
  ) {
    final recv = _fmtBytes(p.received);
    final total = p.total > 0 ? _fmtBytes(p.total) : '不明';
    return Text(
      'ダウンロード中: $recv / $total',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  static String _fmtBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
