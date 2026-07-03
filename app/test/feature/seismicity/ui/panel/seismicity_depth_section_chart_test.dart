import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_depth_section_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('軸切替ボタンをタップしても例外なく再描画できる', (tester) async {
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
    ];

    await tester.pumpWidget(
      MaterialApp(home: SeismicityDepthSectionChart(events: events)),
    );
    expect(find.byType(SeismicityDepthSectionChart), findsOneWidget);

    await tester.tap(find.text('経度方向'));
    await tester.pumpAndSettle();
    expect(find.byType(SeismicityDepthSectionChart), findsOneWidget);
  });
}
