import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/nearby_earthquake_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/nearby_earthquake_parameter_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('初期探索範囲を表示し、適用時に値を返す', (tester) async {
    await _pumpHost(tester);
    final context = tester.element(find.byType(Scaffold));

    final resultFuture = showModalBottomSheet<NearbyEarthquakeParameter>(
      context: context,
      builder: (context) => const NearbyEarthquakeParameterSheet(
        initial: NearbyEarthquakeParameter(
          latitudeOffset: 1.2,
          longitudeOffset: 1.3,
          depthOffset: 80,
        ),
        hasDepth: true,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('±1.2°'), findsOneWidget);
    expect(find.text('±1.3°'), findsOneWidget);
    expect(find.text('±80km'), findsOneWidget);

    await tester.tap(find.text('適用'));
    await tester.pumpAndSettle();

    expect(
      await resultFuture,
      const NearbyEarthquakeParameter(
        latitudeOffset: 1.2,
        longitudeOffset: 1.3,
        depthOffset: 80,
      ),
    );
  });

  testWidgets('深さ不明時は深さ範囲を表示しない', (tester) async {
    await _pumpHost(tester);
    final context = tester.element(find.byType(Scaffold));

    showModalBottomSheet<NearbyEarthquakeParameter>(
      context: context,
      builder: (context) => const NearbyEarthquakeParameterSheet(
        initial: NearbyEarthquakeParameter(),
        hasDepth: false,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('深さ範囲'), findsNothing);
  });
}

Future<void> _pumpHost(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [DesignSystemThemeExtension.light()],
      ),
      home: const Scaffold(body: SizedBox.expand()),
    ),
  );
}
