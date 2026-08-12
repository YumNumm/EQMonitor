import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

/// M-T図(時間 × マグニチュードの点プロット)。
class SeismicityMtChart extends StatelessWidget {
  const SeismicityMtChart({required this.events, super.key});

  final List<SeismicityEvent> events;

  @override
  Widget build(BuildContext context) {
    final withMagnitude = events.where((e) => e.magnitude != null).toList()
      ..sort((a, b) => a.originTime.compareTo(b.originTime));

    if (withMagnitude.isEmpty) {
      return const Center(child: Text('マグニチュードが既知のイベントがありません'));
    }

    final firstTime = withMagnitude.first.originTime;
    final spots = [
      for (final event in withMagnitude)
        ScatterSpot(
          event.originTime.difference(firstTime).inHours.toDouble(),
          event.magnitude!,
        ),
    ];
    final colorScheme = context.designSystem.colorTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: spots,
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: const Text('M', style: TextStyle(fontSize: 10)),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (v, _) => Text(
                  v.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 8),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text(
                '経過時間 (h)',
                style: TextStyle(fontSize: 10),
              ),
              sideTitles: SideTitles(
                showTitles: true,
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
            border: Border(bottom: BorderSide(color: colorScheme.outline)),
          ),
        ),
      ),
    );
  }
}
