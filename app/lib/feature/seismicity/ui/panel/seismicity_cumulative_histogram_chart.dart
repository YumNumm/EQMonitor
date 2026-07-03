import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_cumulative_binning.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// 回数積算図(上段、LineChart)と日別ヒストグラム(下段、BarChart)の併記。
class SeismicityCumulativeHistogramChart extends StatelessWidget {
  const SeismicityCumulativeHistogramChart({required this.events, super.key});

  final List<SeismicityEvent> events;

  static const SeismicityCumulativeBinning _binning =
      SeismicityCumulativeBinning();

  @override
  Widget build(BuildContext context) {
    final bins = _binning.bin(events);
    if (bins.isEmpty) {
      return const Center(child: Text('選択範囲にイベントがありません'));
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 16, 4),
            child: LineChart(
              LineChartData(
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < bins.length; i++)
                        FlSpot(
                          i.toDouble(),
                          bins[i].cumulativeCount.toDouble(),
                        ),
                    ],
                    dotData: const FlDotData(show: false),
                    isCurved: false,
                    barWidth: 2,
                    color: colorScheme.primary,
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '積算件数',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  bottomTitles: const AxisTitles(),
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
            child: BarChart(
              BarChartData(
                barGroups: [
                  for (var i = 0; i < bins.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: bins[i].count.toDouble(),
                          color: colorScheme.secondary,
                          width: 4,
                        ),
                      ],
                    ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '日別件数',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, _) => Text(
                        v.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: const Text(
                      '日',
                      style: TextStyle(fontSize: 10),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final index = v.toInt();
                        if (index < 0 || index >= bins.length) {
                          return const SizedBox.shrink();
                        }
                        final date = bins[index].date;
                        return Text(
                          '${date.month}/${date.day}',
                          style: const TextStyle(fontSize: 8),
                        );
                      },
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
