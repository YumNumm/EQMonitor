import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final ThemeData _testTheme = ThemeData.light().copyWith(
  extensions: [DesignSystemThemeExtension.light()],
);

void main() {
  testWidgets('深さが既知のイベントが0件(全欠測)の場合はフォールバック表示になる', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: null,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme,
        home: SeismicityDepthSectionChart(events: events),
      ),
    );

    expect(find.byType(ScatterChart), findsNothing);
    expect(find.text('深さが既知のイベントがありません'), findsOneWidget);
  });

  testWidgets('イベントが0件でもフォールバック表示になる', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme,
        home: const SeismicityDepthSectionChart(events: []),
      ),
    );

    expect(find.byType(ScatterChart), findsNothing);
    expect(find.text('深さが既知のイベントがありません'), findsOneWidget);
  });

  testWidgets('深さ欠測イベントを除外し、軸切替で緯度→経度へ切り替わる', (tester) async {
    final events = [
      SeismicityEvent(
        eventId: 'a',
        originTime: DateTime.utc(2026, 1, 1),
        magnitude: 4,
        depth: 30,
        latitude: 35,
        longitude: 139,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'b',
        originTime: DateTime.utc(2026, 1, 2),
        magnitude: 4,
        depth: null,
        latitude: 36,
        longitude: 140,
        maxIntensity: null,
      ),
      SeismicityEvent(
        eventId: 'c',
        originTime: DateTime.utc(2026, 1, 3),
        magnitude: 4,
        depth: 50,
        latitude: 37,
        longitude: 141,
        maxIntensity: null,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme,
        home: SeismicityDepthSectionChart(events: events),
      ),
    );
    expect(find.byType(SeismicityDepthSectionChart), findsOneWidget);

    // 初期状態(緯度方向): 深さ欠測の 'b' を除いた2点、y は深さの符号反転。
    var chart = tester.widget<ScatterChart>(find.byType(ScatterChart));
    var spots = chart.data.scatterSpots;
    expect(spots, hasLength(2));
    expect(spots[0].x, 35);
    expect(spots[0].y, -30);
    expect(spots[1].x, 37);
    expect(spots[1].y, -50);

    await tester.tap(find.text('経度方向'));
    await tester.pumpAndSettle();

    // 軸切替後: x が緯度から経度の値へ切り替わる。
    chart = tester.widget<ScatterChart>(find.byType(ScatterChart));
    spots = chart.data.scatterSpots;
    expect(spots, hasLength(2));
    expect(spots[0].x, 139);
    expect(spots[0].y, -30);
    expect(spots[1].x, 141);
    expect(spots[1].y, -50);
  });
}
