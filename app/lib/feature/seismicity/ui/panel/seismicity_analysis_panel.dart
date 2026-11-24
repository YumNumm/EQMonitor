import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_mt_chart.dart';
import 'package:material_ui/material_ui.dart';

/// 矩形選択で得られたイベント一覧の分析パネル(3タブ)。
class const SeismicityAnalysisPanel({
  required final List<SeismicityEvent> events,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '選択範囲: ${events.length}件',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          const TabBar(
            tabs: [
              Tab(text: 'M-T 図'),
              Tab(text: '積算/ヒストグラム'),
              Tab(text: '深さ断面'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SeismicityMtChart(events: events),
                SeismicityCumulativeHistogramChart(events: events),
                SeismicityDepthSectionChart(events: events),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
