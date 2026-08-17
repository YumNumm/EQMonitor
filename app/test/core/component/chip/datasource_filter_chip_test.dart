import 'package:eqmonitor/core/component/chip/datasource_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  Widget wrap({
    EarthquakeDataSource? datasource,
    ValueChanged<EarthquakeDataSource?>? onChanged,
  }) => ProviderScope(
    child: MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: DatasourceFilterChip(
          datasource: datasource,
          onChanged: onChanged,
        ),
      ),
    ),
  );

  testWidgets('(a) dismiss でonChangedが呼ばれない', (tester) async {
    var callCount = 0;
    await tester.pumpWidget(wrap(onChanged: (_) => callCount++));
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(callCount, 0, reason: 'dismiss should not call onChanged');
  });

  testWidgets('(b) 「すべて」タップでonChanged(null)が呼ばれる', (tester) async {
    EarthquakeDataSource? received = EarthquakeDataSource.jmaIntensityDatabase;
    await tester.pumpWidget(
      wrap(
        datasource: EarthquakeDataSource.jmaIntensityDatabase,
        onChanged: (v) => received = v,
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    await tester.tap(find.text('すべて'));
    await tester.pumpAndSettle();

    expect(received, isNull, reason: '「すべて」should call onChanged(null)');
  });

  testWidgets('(c) データソース項目タップで該当値が渡る', (tester) async {
    EarthquakeDataSource? received;
    await tester.pumpWidget(wrap(onChanged: (v) => received = v));
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    await tester.tap(find.text('震度データベース'));
    await tester.pumpAndSettle();

    expect(
      received,
      EarthquakeDataSource.jmaIntensityDatabase,
      reason: 'Tapping a datasource item should pass the correct value',
    );
  });
}
