import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_cumulative_histogram_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('イベントが0件でも例外なく描画できる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SeismicityCumulativeHistogramChart(events: [])),
    );
    expect(find.byType(SeismicityCumulativeHistogramChart), findsOneWidget);
  });

  testWidgets('複数イベントで積算図とヒストグラムを描画する', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: 3,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityCumulativeHistogramChart(events: events)),
    );
    expect(find.byType(SeismicityCumulativeHistogramChart), findsOneWidget);
  });
}
