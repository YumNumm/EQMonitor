import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final station = ShindoDbStationNode(
    name: '長い観測点名を持つ震度データベース観測点',
    location: null,
    record: EarthquakeCatalogStationRecord(
      stationCode: 'TEST001',
      intensityClass: .sixLower,
      instrumentalIntensity: 5.7,
      observedAt: DateTime.utc(2024, 1, 1, 7, 10),
      observationCount: 123,
      maxAcceleration: const EarthquakeCatalogMaxAcceleration(
        synthesizedGal: 1234.56,
        nsGal: 987.65,
        ewGal: 876.54,
        udGal: null,
      ),
      maxAccelTime: DateTime.utc(2024, 1, 1, 7, 10, 12),
      periods: const EarthquakeCatalogPeriods(
        ns: EarthquakeCatalogPeriodComponent(
          maxAccelPeriodText: '0.25秒',
          predominantPeriodText: '1.50秒',
        ),
        ew: EarthquakeCatalogPeriodComponent(
          maxAccelPeriodText: '4.0Hz',
          predominantPeriodText: '欠測',
        ),
        ud: EarthquakeCatalogPeriodComponent(
          maxAccelPeriodText: null,
          predominantPeriodText: '0.30秒',
        ),
      ),
    ),
  );

  for (final brightness in Brightness.values) {
    for (final scenario in [
      (size: const Size(390, 844), scale: 1.0),
      (size: const Size(320, 480), scale: 2.0),
      (size: const Size(640, 320), scale: 2.0),
    ]) {
      testWidgets(
        '全項目のモーダルを末尾までスクロールできる '
        '${brightness.name} ${scenario.size} scale=${scenario.scale}',
        (tester) async {
          tester.view.devicePixelRatio = 1;
          tester.view.physicalSize = scenario.size;
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.view.resetPhysicalSize);

          final designSystem = brightness == .light
              ? DesignSystemThemeExtension.light()
              : DesignSystemThemeExtension.dark();
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(brightness: brightness).copyWith(
                extensions: [designSystem],
              ),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(scenario.scale),
                ),
                child: child ?? const SizedBox.shrink(),
              ),
              home: Scaffold(
                body: Builder(
                  builder: (context) => TextButton(
                    onPressed: () => showM3EModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: false,
                      useSafeArea: false,
                      style: const M3EBottomSheetStyle(
                        padding: EdgeInsets.zero,
                      ),
                      clipBehavior: .antiAlias,
                      builder: (_) =>
                          ShindoDbStationDetailSheet(station: station),
                    ),
                    child: const Text('開く'),
                  ),
                ),
              ),
            ),
          );
          await tester.tap(find.text('開く'));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(find.text(station.name), findsOneWidget);

          final lastLink = find.text('震度データについて(地震月報カタログ編)');
          await tester.scrollUntilVisible(lastLink, 100);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(lastLink.hitTestable(), findsOneWidget);
        },
      );
    }
  }
}
