import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_waveform_download_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// K-NET 観測点詳細画面
///
/// 観測点の加速度波形グラフ (NS / EW / UD) とヘッダ情報を表示する。
class KnetStationDetailPage extends HookConsumerWidget {
  const KnetStationDetailPage({
    required this.eventTimeMs,
    required this.stationCode,
    super.key,
  });

  final int eventTimeMs;
  final String stationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(knetWaveformDownloadProvider(eventTimeMs));
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      appBar: AppBar(
        title: Text(stationCode),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'ヘッダ編集',
            onPressed: () => unawaited(
              KnetHeaderEditRoute(
                eventTimeMs: eventTimeMs,
                stationCode: stationCode,
              ).push<void>(context),
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'N-S'),
            Tab(text: 'E-W'),
            Tab(text: 'U-D'),
          ],
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          final msg = e is KnetWaveformDownloadException
              ? e.message
              : 'データの取得に失敗しました';
          debugPrint('K-NET station detail error: $e\n$st');
          return Center(child: Text(msg));
        },
        data: (stationMap) {
          final records = stationMap[stationCode];
          if (records == null) {
            return const Center(child: Text('観測点データが見つかりません'));
          }

          final representative =
              records[KnetChannelDirection.ns] ?? records.values.first;
          final info = representative.stationInfo;
          final eqInfo = representative.earthquakeInfo;

          return Column(
            children: [
              _HeaderInfoCard(
                stationInfo: info,
                earthquakeInfo: eqInfo,
                record: representative,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children:
                      [
                        KnetChannelDirection.ns,
                        KnetChannelDirection.ew,
                        KnetChannelDirection.ud,
                      ].map((dir) {
                        final record = records[dir];
                        if (record == null) {
                          return Center(
                            child: Text(
                              '${dir.label} チャンネルのデータがありません',
                            ),
                          );
                        }
                        return _WaveformChart(record: record);
                      }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ヘッダ情報カード
class _HeaderInfoCard extends StatelessWidget {
  const _HeaderInfoCard({
    required this.stationInfo,
    required this.earthquakeInfo,
    required this.record,
  });

  final KnetStationInfo stationInfo;
  final KnetEarthquakeInfo? earthquakeInfo;
  final KnetRecord record;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fmt = DateFormat('yyyy/MM/dd HH:mm:ss');

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('観測点情報', style: textTheme.titleSmall),
            const SizedBox(height: 4),
            _InfoRow(
              label: '観測点コード',
              value: stationInfo.stationCode,
            ),
            _InfoRow(
              label: '緯度 / 経度',
              value:
                  '${stationInfo.latitude.toStringAsFixed(4)}°N  '
                  '${stationInfo.longitude.toStringAsFixed(4)}°E',
            ),
            _InfoRow(
              label: '標高',
              value: '${stationInfo.heightM.toStringAsFixed(1)} m',
            ),
            _InfoRow(
              label: 'サンプリング周波数',
              value: '${record.samplingFrequencyHz.toStringAsFixed(0)} Hz',
            ),
            _InfoRow(
              label: '計測時間',
              value: '${record.durationTimeSec.toStringAsFixed(1)} 秒',
            ),
            _InfoRow(
              label: '記録開始時刻',
              value: fmt.format(record.recordTime),
            ),
            if (earthquakeInfo != null) ...[
              const Divider(),
              Text('地震情報', style: textTheme.titleSmall),
              const SizedBox(height: 4),
              _InfoRow(
                label: '発生時刻',
                value: fmt.format(earthquakeInfo!.originTime),
              ),
              _InfoRow(
                label: '震源',
                value:
                    '${earthquakeInfo!.latitude.toStringAsFixed(2)}°N  '
                    '${earthquakeInfo!.longitude.toStringAsFixed(2)}°E  '
                    '深さ ${earthquakeInfo!.depthKm.toStringAsFixed(0)} km',
              ),
              _InfoRow(
                label: 'マグニチュード',
                value: 'M${earthquakeInfo!.magnitude.toStringAsFixed(1)}',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

/// 加速度波形グラフ (fl_chart)
class _WaveformChart extends StatelessWidget {
  const _WaveformChart({required this.record});

  final KnetRecord record;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final acc = record.accelerationGal;
    final dt = 1.0 / record.samplingFrequencyHz;

    // データ点が多い場合は間引く（最大 2000 点）
    const maxPoints = 2000;
    final step = math.max(1, (acc.length / maxPoints).ceil());

    final spots = <FlSpot>[];
    for (var i = 0; i < acc.length && spots.length < maxPoints; i += step) {
      spots.add(FlSpot(i * dt, acc[i]));
    }

    if (spots.isEmpty) {
      return const Center(child: Text('データなし'));
    }

    final maxY = acc.reduce((a, b) => a.abs() > b.abs() ? a : b).abs();
    // maxY が 0 の場合は 1.0 をデフォルト値として使用し、ゼロ除算・ゼロスケールを防ぐ
    final yLimit = maxY == 0 ? 1.0 : maxY * 1.1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      child: Column(
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                minY: -yLimit,
                maxY: yLimit,
                clipData: const FlClipData.all(),
                gridData: FlGridData(
                  horizontalInterval: yLimit / 4,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    strokeWidth: 0.5,
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    strokeWidth: 0.5,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '時刻 (秒)',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) => Text(
                        value.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '加速度 (gal)',
                      style: TextStyle(fontSize: 10),
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 48,
                      getTitlesWidget: (value, meta) => Text(
                        value.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    color: colorScheme.primary,
                    barWidth: 1,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '最大加速度: ${record.maxAccelerationGal.toStringAsFixed(2)} gal',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
