import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/depth_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpDepthText(
    WidgetTester tester, {
    required EarthquakeDepth? depth,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DepthText(depth: depth)),
      ),
    );
  }

  testWidgets('shallow: "深さ" + "ごく浅い"', (tester) async {
    await pumpDepthText(tester, depth: const EarthquakeDepth.shallow());

    expect(find.text('深さごく浅い'), findsOneWidget);
  });

  testWidgets('value: "深さ" + "<値>km"', (tester) async {
    await pumpDepthText(tester, depth: const EarthquakeDepth.value(value: 30));

    expect(find.text('深さ30km'), findsOneWidget);
  });

  testWidgets('over700km: "深さ" + "700km以上"', (tester) async {
    await pumpDepthText(tester, depth: const EarthquakeDepth.over700km());

    expect(find.text('深さ700km以上'), findsOneWidget);
  });

  testWidgets('unknown: "深さ" + "調査中"', (tester) async {
    await pumpDepthText(tester, depth: const EarthquakeDepth.unknown());

    expect(find.text('深さ調査中'), findsOneWidget);
  });

  testWidgets('null: "深さ" + "調査中"', (tester) async {
    await pumpDepthText(tester, depth: null);

    expect(find.text('深さ調査中'), findsOneWidget);
  });
}
