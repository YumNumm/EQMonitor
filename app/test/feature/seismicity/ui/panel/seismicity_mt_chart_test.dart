import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_mt_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('イベントが0件でも例外なく描画できる', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SeismicityMtChart(events: [])),
    );
    expect(find.byType(SeismicityMtChart), findsOneWidget);
    expect(find.byType(ScatterChart), findsNothing);
    expect(find.text('マグニチュードが既知のイベントがありません'), findsOneWidget);
  });

  testWidgets('マグニチュードが全て欠測の場合はフォールバック表示になる', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: null,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: null,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityMtChart(events: events)),
    );
    expect(find.byType(ScatterChart), findsNothing);
    expect(find.text('マグニチュードが既知のイベントがありません'), findsOneWidget);
  });

  testWidgets('マグニチュード欠測イベントを除外して描画する', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4.5,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: null,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'c',
        originTime: DateTime.utc(2026, 1, 2, 12),
        magnitude: 5.2,
        depth: 10,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityMtChart(events: events)),
    );

    final chart = tester.widget<ScatterChart>(find.byType(ScatterChart));
    final spots = chart.data.scatterSpots;

    // マグニチュード欠測の 'b' を除いた2点のみが描画される。
    expect(spots, hasLength(2));
    // 'a' は基準時刻(先頭イベント)からの経過時間0時間、M4.5。
    expect(spots[0].x, 0);
    expect(spots[0].y, 4.5);
    // 'c' は 'a' から 36時間後、M5.2。
    expect(spots[1].x, 36);
    expect(spots[1].y, 5.2);
  });
}
