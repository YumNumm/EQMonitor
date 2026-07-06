import 'package:eqmonitor/core/component/chip/earthquake_type_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({
    EarthquakeType? earthquakeType,
    void Function(EarthquakeType?)? onChanged,
  }) => ProviderScope(
    child: MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: EarthquakeTypeFilterChip(
          earthquakeType: earthquakeType,
          onChanged: onChanged,
        ),
      ),
    ),
  );

  testWidgets('(a) dismiss でonChangedが呼ばれない', (tester) async {
    var callCount = 0;
    await tester.pumpWidget(wrap(onChanged: (_) => callCount++));
    await tester.pump();

    // Open the sheet
    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    // Tap the barrier (top-left corner, outside the bottom sheet)
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(callCount, 0, reason: 'dismiss should not call onChanged');
  });

  testWidgets('(b) 「すべて」タップでonChanged(null)が呼ばれる', (tester) async {
    EarthquakeType? received = EarthquakeType.normal;
    await tester.pumpWidget(
      wrap(
        earthquakeType: EarthquakeType.normal,
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

  testWidgets('(c) 種別タップで該当値が渡る', (tester) async {
    EarthquakeType? received;
    await tester.pumpWidget(wrap(onChanged: (v) => received = v));
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    await tester.tap(find.text('遠地地震'));
    await tester.pumpAndSettle();

    expect(
      received,
      EarthquakeType.distant,
      reason: 'Tapping a type item should pass the correct value',
    );
  });
}
