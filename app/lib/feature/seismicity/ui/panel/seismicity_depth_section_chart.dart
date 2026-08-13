import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_depth_projection.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 深さ断面図(緯度方向 / 経度方向の投影切替)。
///
/// Y軸(深さ)は下向きが正のため `reversed: true` 相当の表示にするために
/// 深さを負の値としてプロットし、`maxY` を 0 に固定する。`minY` は
/// fl_chart のオートスケールに委ねる(明示的には設定しない)。
class SeismicityDepthSectionChart extends HookWidget {
  const SeismicityDepthSectionChart({required this.events, super.key});

  final List<SeismicityEvent> events;

  static const SeismicityDepthProjection _projection =
      SeismicityDepthProjection();

  @override
  Widget build(BuildContext context) {
    final axis = useState(SeismicityDepthProjectionAxis.latitude);
    final points = _projection.project(events: events, axis: axis.value);
    final colorScheme = context.designSystem.colorTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SegmentedButton<SeismicityDepthProjectionAxis>(
            segments: const [
              ButtonSegment(
                value: SeismicityDepthProjectionAxis.latitude,
                label: Text('緯度方向'),
              ),
              ButtonSegment(
                value: SeismicityDepthProjectionAxis.longitude,
                label: Text('経度方向'),
              ),
            ],
            selected: {axis.value},
            onSelectionChanged: (selected) => axis.value = selected.single,
          ),
        ),
        Expanded(
          child: points.isEmpty
              ? const Center(child: Text('深さが既知のイベントがありません'))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        for (final point in points)
                          ScatterSpot(point.axisValue, -point.depth),
                      ],
                      maxY: 0,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          axisNameWidget: const Text(
                            '深さ (km)',
                            style: TextStyle(fontSize: 10),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 36,
                            getTitlesWidget: (v, _) => Text(
                              (-v).toStringAsFixed(0),
                              style: const TextStyle(fontSize: 8),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text(
                            axis.value == SeismicityDepthProjectionAxis.latitude
                                ? '緯度'
                                : '経度',
                            style: const TextStyle(fontSize: 10),
                          ),
                          sideTitles: SideTitles(
                            showTitles: true,
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
                          bottom: BorderSide(color: colorScheme.outline),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
