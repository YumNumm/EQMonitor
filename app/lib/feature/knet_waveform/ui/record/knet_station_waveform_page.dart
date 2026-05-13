import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 観測点波形チャートページ
class KnetStationWaveformPage extends HookWidget {
  const KnetStationWaveformPage({required this.result, super.key});

  final KnetStationResult result;

  @override
  Widget build(BuildContext context) {
    final dirs = result.record.channelDirections;
    final tabCount = dirs.length.clamp(1, 3);
    final tabController = useTabController(initialLength: tabCount);
    final intensity = JmaIntensityFromRawKnetInt.fromRawKnetInt(result.rawInt);

    return Scaffold(
      appBar: AppBar(
        title: Text(result.stationCode),
        bottom: TabBar(
          controller: tabController,
          tabs: List.generate(
            tabCount,
            (i) => Tab(text: dirs[i].label),
          ),
        ),
      ),
      body: Column(
        children: [
          _IntensityHeader(result: result, intensity: intensity),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: List.generate(
                tabCount,
                (i) => _WaveformChart(record: result.record, channelIndex: i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntensityHeader extends StatelessWidget {
  const _IntensityHeader({required this.result, required this.intensity});

  final KnetStationResult result;
  final JmaIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final info = result.stationInfo;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (info != null)
                  Text(
                    '緯度 ${info.latitude.toStringAsFixed(4)}  '
                    '経度 ${info.longitude.toStringAsFixed(4)}  '
                    '標高 ${info.heightM.toStringAsFixed(0)} m',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                Text(
                  '最大加速度: ${result.maxAccelGal.toStringAsFixed(2)} gal',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Text('計測震度', style: Theme.of(context).textTheme.labelSmall),
              Text(
                result.rawInt.toStringAsFixed(1),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '震度${intensity.mainText}${intensity.suffix}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaveformChart extends StatelessWidget {
  const _WaveformChart({required this.record, required this.channelIndex});

  final KnetCsvRecord record;
  final int channelIndex;

  /// バイアス (gal) を計算する
  ///
  /// CSV の #Offset が非ゼロならそれを使用。
  /// ゼロの場合は先頭 10% サンプルの平均を代替バイアスとする。
  static double _computeBias(
    List<KnetCsvDataPoint> pts,
    KnetCsvRecord record,
    int chIdx,
  ) {
    if (chIdx < record.offsets.length && record.offsets[chIdx] != 0.0) {
      return record.offsets[chIdx];
    }
    final preCount = (pts.length * 0.1).round().clamp(1, pts.length);
    var sum = 0.0;
    for (var i = 0; i < preCount; i++) {
      if (pts[i].accelerationsGal.length > chIdx) {
        sum += pts[i].accelerationsGal[chIdx];
      }
    }
    return sum / preCount;
  }

  @override
  Widget build(BuildContext context) {
    final pts = record.dataPoints;
    if (pts.isEmpty) {
      return const Center(child: Text('データなし'));
    }

    // バイアス除去: CSV の #Offset 値を使用。0 の場合は先頭 10% の平均で推定
    final bias = _computeBias(pts, record, channelIndex);

    final spots = <FlSpot>[];
    var minY = double.infinity;
    var maxY = double.negativeInfinity;

    for (final pt in pts) {
      if (pt.accelerationsGal.length <= channelIndex) {
        continue;
      }
      final y = pt.accelerationsGal[channelIndex] - bias;
      spots.add(FlSpot(pt.relativeTimeSec, y));
      if (y < minY) {
        minY = y;
      }
      if (y > maxY) {
        maxY = y;
      }
    }

    if (spots.isEmpty) {
      return const Center(child: Text('データなし'));
    }

    final padding = ((maxY - minY) * 0.1).abs().clamp(1.0, double.infinity);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      child: LineChart(
        LineChartData(
          minY: minY - padding,
          maxY: maxY + padding,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              dotData: const FlDotData(show: false),
              barWidth: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: const Text('gal', style: TextStyle(fontSize: 10)),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 9),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text(
                '時刻 (s)',
                style: TextStyle(fontSize: 10),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 9),
                ),
              ),
            ),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(),
        ),
        duration: Duration.zero,
      ),
    );
  }
}
