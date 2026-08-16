import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

final ThemeData _testTheme = ThemeData.light().copyWith(
  extensions: [DesignSystemThemeExtension.light()],
);

void main() {
  testWidgets('イベントが0件の場合はフォールバック表示になる', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme,
        home: const SeismicityCumulativeHistogramChart(events: []),
      ),
    );
    expect(find.byType(SeismicityCumulativeHistogramChart), findsOneWidget);
    expect(find.byType(LineChart), findsNothing);
    expect(find.byType(BarChart), findsNothing);
    expect(find.text('選択範囲にイベントがありません'), findsOneWidget);
  });

  testWidgets('間に空白日を挟む3日間で積算図とヒストグラムを描画する', (tester) async {
    // 1/1 に2件、1/2 に0件(空白日)、1/3 に1件。
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1, 3),
        magnitude: 4,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 1, 20),
        magnitude: 3,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'c',
        originTime: DateTime.utc(2026, 1, 3, 5),
        magnitude: 5,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme,
        home: SeismicityCumulativeHistogramChart(events: events),
      ),
    );

    final lineChart = tester.widget<LineChart>(find.byType(LineChart));
    final cumulativeSpots = lineChart.data.lineBarsData.single.spots;
    // 1/1, 1/2, 1/3 の3日分。
    expect(cumulativeSpots, hasLength(3));
    expect(cumulativeSpots[0].x, 0);
    expect(cumulativeSpots[0].y, 2); // 1/1: 2件 → 積算2
    expect(cumulativeSpots[1].x, 1);
    expect(cumulativeSpots[1].y, 2); // 1/2: 空白日 → 積算据え置き
    expect(cumulativeSpots[2].x, 2);
    expect(cumulativeSpots[2].y, 3); // 1/3: 1件 → 積算3

    final barChart = tester.widget<BarChart>(find.byType(BarChart));
    final groups = barChart.data.barGroups;
    expect(groups, hasLength(3));
    expect(groups[0].barRods.single.toY, 2); // 1/1: 2件
    expect(groups[1].barRods.single.toY, 0); // 1/2: 0件(空白日)
    expect(groups[2].barRods.single.toY, 1); // 1/3: 1件
  });
}
