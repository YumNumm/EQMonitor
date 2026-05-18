import 'dart:math';

import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_analysis.dart';
import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_result.dart';
import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_station_analysis_provider.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_waveform_parser/knet_waveform_parser.dart';

/// 観測点波形・スペクトル解析ページ
class KnetStationWaveformPage extends HookConsumerWidget {
  const KnetStationWaveformPage({required this.result, super.key});

  final KnetStationResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(knetStationAnalysisProvider(result));
    final navIndex = useState(0);
    final waveType = useState(0); // 0=加速度 1=速度 2=変位
    final intensity = JmaIntensityFromRawKnetInt.fromRawKnetInt(result.rawInt);
    final dirs = result.record.channelDirections;
    final tabCount = dirs.length.clamp(1, 3);
    final tabController = useTabController(initialLength: tabCount);

    return Scaffold(
      appBar: AppBar(
        title: Text(result.stationCode),
        bottom: navIndex.value == 0
            ? TabBar(
                controller: tabController,
                tabs: List.generate(
                  tabCount,
                  (i) => Tab(text: dirs[i].label),
                ),
              )
            : null,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex.value,
        onDestinationSelected: (i) => navIndex.value = i,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: '波形',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'スペクトル',
          ),
          NavigationDestination(
            icon: Icon(Icons.waterfall_chart),
            label: 'フーリエ',
          ),
        ],
      ),
      body: [
        // ── 波形ビュー ──
        Column(
          children: [
            _MetricsHeader(
              result: result,
              intensity: intensity,
              analysis: analysisAsync.asData?.value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('加速度 (gal)')),
                  ButtonSegment(value: 1, label: Text('速度 (cm/s)')),
                  ButtonSegment(value: 2, label: Text('変位 (cm)')),
                ],
                selected: {waveType.value},
                onSelectionChanged: (s) => waveType.value = s.first,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: List.generate(
                  tabCount,
                  (ch) => _buildWaveformChart(
                    context,
                    ch,
                    waveType.value,
                    analysisAsync,
                  ),
                ),
              ),
            ),
          ],
        ),
        // ── 応答スペクトルビュー ──
        _SpectrumView(analysis: analysisAsync),
        // ── フーリエスペクトルビュー ──
        _FourierView(analysis: analysisAsync),
      ][navIndex.value],
    );
  }

  Widget _buildWaveformChart(
    BuildContext context,
    int ch,
    int waveType,
    AsyncValue<KnetStationAnalysis> analysisAsync,
  ) {
    final record = result.record;
    if (waveType == 0) {
      // 加速度は analysis 不要（即表示）
      return _WaveformChart(record: record, channelIndex: ch);
    }
    return analysisAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('解析エラー: $e')),
      data: (analysis) {
        final data = waveType == 1
            ? analysis.velocity
            : analysis.displacement;
        final unit = waveType == 1 ? 'cm/s' : 'cm';
        if (ch >= data.length) {
          return const Center(child: Text('データなし'));
        }
        return _TimeSeriesChart(
          data: data[ch],
          unit: unit,
          dt: 1.0 / record.samplingFrequencyHz,
        );
      },
    );
  }
}

// ── ヘッダ（震度・PGA/PGV/PGD/SI） ──────────────────────────────────────

class _MetricsHeader extends StatelessWidget {
  const _MetricsHeader({
    required this.result,
    required this.intensity,
    required this.analysis,
  });

  final KnetStationResult result;
  final JmaIntensity intensity;
  final KnetStationAnalysis? analysis;

  @override
  Widget build(BuildContext context) {
    final info = result.stationInfo;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 震度アイコン
            JmaIntensityIcon(
              intensity: intensity,
              type: IntensityIconType.filled,
              size: 64,
            ),
            const SizedBox(width: 12),
            // 観測点情報
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
                    '計測震度 ${result.rawInt.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 16,
                    children: [
                      _MetricChip(
                        label: 'PGA',
                        value: '${result.maxAccelGal.toStringAsFixed(2)} gal',
                      ),
                      if (analysis != null) ...[
                        _MetricChip(
                          label: 'PGV',
                          value:
                              '${_maxOf(analysis!.pgv).toStringAsFixed(2)} cm/s',
                        ),
                        _MetricChip(
                          label: 'PGD',
                          value:
                              '${_maxOf(analysis!.pgd).toStringAsFixed(2)} cm',
                        ),
                        _MetricChip(
                          label: 'SI',
                          value:
                              '${analysis!.siValue.toStringAsFixed(2)} cm/s',
                        ),
                      ] else
                        const _MetricChip(
                          label: 'PGV/PGD/SI',
                          value: '計算中…',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _maxOf(List<double> values) =>
      values.isEmpty ? 0.0 : values.reduce(max);
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

// ── 加速度波形チャート（バイアス除去済み） ────────────────────────────────

class _WaveformChart extends StatelessWidget {
  const _WaveformChart({required this.record, required this.channelIndex});

  final KnetCsvRecord record;
  final int channelIndex;

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
    final bias = _computeBias(pts, record, channelIndex);

    final data = <double>[];
    for (final pt in pts) {
      if (pt.accelerationsGal.length <= channelIndex) {
        continue;
      }
      data.add(pt.accelerationsGal[channelIndex] - bias);
    }
    return _TimeSeriesChart(
      data: data,
      unit: 'gal',
      dt: 1.0 / record.samplingFrequencyHz,
    );
  }
}

// ── 汎用 時系列チャート ───────────────────────────────────────────────────

class _TimeSeriesChart extends StatelessWidget {
  const _TimeSeriesChart({
    required this.data,
    required this.unit,
    required this.dt,
  });

  final List<double> data;
  final String unit;
  final double dt;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('データなし'));
    }

    // 間引き: 画面幅 800px に対してサンプル数が多い場合は間引く
    const maxPoints = 2000;
    final step = (data.length / maxPoints).ceil().clamp(1, data.length);
    final spots = <FlSpot>[];
    var minY = double.infinity;
    var maxY = double.negativeInfinity;

    for (var i = 0; i < data.length; i += step) {
      final y = data[i];
      final t = i * dt;
      spots.add(FlSpot(t, y));
      if (y < minY) {
        minY = y;
      }
      if (y > maxY) {
        maxY = y;
      }
    }

    final pad = ((maxY - minY) * 0.1).abs().clamp(0.1, double.infinity);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
      child: LineChart(
        LineChartData(
          minY: minY - pad,
          maxY: maxY + pad,
          clipData: const FlClipData.all(),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              dotData: const FlDotData(show: false),
              barWidth: 1,
              color: colorScheme.primary,
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: Text(
                unit,
                style: const TextStyle(fontSize: 10),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 52,
                getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 8),
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
                interval: _niceInterval(spots.last.x),
                getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(0),
                  style: const TextStyle(fontSize: 8),
                ),
              ),
            ),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(color: colorScheme.outline),
              left: BorderSide(color: colorScheme.outline),
            ),
          ),
          gridData: FlGridData(
            getDrawingHorizontalLine: (v) => FlLine(
              color: colorScheme.outlineVariant,
              strokeWidth: 0.5,
            ),
            getDrawingVerticalLine: (v) => FlLine(
              color: colorScheme.outlineVariant,
              strokeWidth: 0.5,
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => spots
                  .map(
                    (s) => LineTooltipItem(
                      '${s.y.toStringAsFixed(2)} $unit',
                      const TextStyle(fontSize: 11),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        duration: Duration.zero,
      ),
    );
  }

  static double _niceInterval(double maxT) {
    if (maxT <= 30) {
      return 5;
    }
    if (maxT <= 120) {
      return 20;
    }
    if (maxT <= 300) {
      return 60;
    }
    return 120;
  }
}

// ── 応答スペクトルビュー ─────────────────────────────────────────────────

class _SpectrumView extends StatelessWidget {
  const _SpectrumView({required this.analysis});

  final AsyncValue<KnetStationAnalysis> analysis;

  @override
  Widget build(BuildContext context) {
    return analysis.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('解析エラー: $e')),
      data: (a) => _SpectrumChart(spectrum: a.responseSpectrum5pct),
    );
  }
}

class _SpectrumChart extends HookWidget {
  const _SpectrumChart({required this.spectrum});

  final ResponseSpectrumResult spectrum;

  @override
  Widget build(BuildContext context) {
    final selected = useState(0); // 0=Sa 1=Sv 2=Sd
    final cs = Theme.of(context).colorScheme;
    final sp = spectrum;
    final (vals, unit, label) = switch (selected.value) {
      1 => (sp.sv, 'cm/s', '速度応答スペクトル Sv (h=5%)'),
      2 => (sp.sd, 'cm', '変位応答スペクトル Sd (h=5%)'),
      _ => (sp.sa, 'gal', '加速度応答スペクトル Sa (h=5%)'),
    };

    // log10 変換した周期を X 軸に使用
    final spots = <FlSpot>[];
    for (var i = 0; i < sp.periods.length; i++) {
      if (vals[i] > 0 && sp.periods[i] > 0) {
        spots.add(FlSpot(log(sp.periods[i]) / ln10, vals[i]));
      }
    }

    var maxY = vals.isEmpty ? 1.0 : vals.reduce(max);
    if (maxY <= 0) {
      maxY = 1.0;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('Sa (gal)')),
              ButtonSegment(value: 1, label: Text('Sv (cm/s)')),
              ButtonSegment(value: 2, label: Text('Sd (cm)')),
            ],
            selected: {selected.value},
            onSelectionChanged: (s) => selected.value = s.first,
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 8, 0),
          child: Text(label, style: Theme.of(context).textTheme.labelSmall),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: maxY * 1.1,
                clipData: const FlClipData.all(),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    dotData: const FlDotData(show: false),
                    color: cs.primary,
                    isCurved: true,
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '周期 T (s)',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.5,
                      getTitlesWidget: (v, _) {
                        final t = pow(10, v);
                        return Text(
                          t < 1.0
                              ? t.toStringAsFixed(2)
                              : t.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 8),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      unit,
                      style: const TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 52,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(color: cs.outline),
                    left: BorderSide(color: cs.outline),
                  ),
                ),
                gridData: FlGridData(
                  getDrawingHorizontalLine: (v) =>
                      FlLine(color: cs.outlineVariant, strokeWidth: 0.5),
                  getDrawingVerticalLine: (v) =>
                      FlLine(color: cs.outlineVariant, strokeWidth: 0.5),
                ),
              ),
              duration: Duration.zero,
            ),
          ),
        ),
      ],
    );
  }
}

// ── フーリエスペクトルビュー ──────────────────────────────────────────────

class _FourierView extends StatelessWidget {
  const _FourierView({required this.analysis});

  final AsyncValue<KnetStationAnalysis> analysis;

  @override
  Widget build(BuildContext context) {
    return analysis.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('解析エラー: $e')),
      data: (a) => _FourierChart(spectrum: a.fourierSpectrum),
    );
  }
}

class _FourierChart extends StatelessWidget {
  const _FourierChart({required this.spectrum});

  final FourierSpectrumResult spectrum;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final freqs = spectrum.frequencies;
    final amps = spectrum.amplitudes;

    final spots = <FlSpot>[];
    var maxAmp = 0.0;
    for (var i = 0; i < freqs.length; i++) {
      if (freqs[i] > 0 && amps[i] > 0) {
        spots.add(FlSpot(log(freqs[i]) / ln10, amps[i]));
        if (amps[i] > maxAmp) {
          maxAmp = amps[i];
        }
      }
    }
    if (maxAmp <= 0) {
      maxAmp = 1;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
          child: Text(
            'フーリエ振幅スペクトル (最大 PGA チャンネル)',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: maxAmp * 1.1,
                clipData: const FlClipData.all(),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    dotData: const FlDotData(show: false),
                    barWidth: 1.5,
                    color: cs.secondary,
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '周波数 (Hz)',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.5,
                      getTitlesWidget: (v, _) {
                        final f = pow(10, v);
                        return Text(
                          f < 10.0 ? f.toStringAsFixed(1) : f.toStringAsFixed(0),
                          style: const TextStyle(fontSize: 8),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      'gal·s',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 52,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(color: cs.outline),
                    left: BorderSide(color: cs.outline),
                  ),
                ),
                gridData: FlGridData(
                  getDrawingHorizontalLine: (v) =>
                      FlLine(color: cs.outlineVariant, strokeWidth: 0.5),
                  getDrawingVerticalLine: (v) =>
                      FlLine(color: cs.outlineVariant, strokeWidth: 0.5),
                ),
              ),
              duration: Duration.zero,
            ),
          ),
        ),
      ],
    );
  }
}
