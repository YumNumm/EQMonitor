import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_span_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'period selector retains selection when the checked option is tapped',
    (
      tester,
    ) async {
      final changes = <SeismicitySpan>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SeismicitySpanSelector(
              value: SeismicitySpan.p3m,
              onChanged: changes.add,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final group = tester.widget<M3EToggleButtonGroup>(
        find.byType(M3EToggleButtonGroup),
      );
      expect(group.selectedIndex, 1);

      await tester.tap(find.text('3ヶ月').first);
      await tester.pumpAndSettle();
      expect(changes, isEmpty);

      await tester.tap(find.text('12ヶ月').first);
      await tester.pumpAndSettle();
      expect(changes, [SeismicitySpan.p12m]);
    },
  );

  testWidgets('color selector maps visible options to their domain values', (
    tester,
  ) async {
    final changes = <SeismicityColorMode>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SeismicityColorModeSelector(
            value: SeismicityColorMode.elapsedTime,
            onChanged: changes.add,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('マグニチュード').first);
    await tester.pumpAndSettle();
    expect(changes, [SeismicityColorMode.magnitude]);
    expect(tester.takeException(), isNull);
  });
}
