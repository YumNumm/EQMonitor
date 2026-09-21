import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/sort_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('depth range keeps rounding and confirms both bounds', (
    tester,
  ) async {
    (int?, int?)? received;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: DepthFilterChip(
            onChanged: (min, max) => received = (min, max),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();
    tester
        .widget<M3ERangeSlider>(find.byType(M3ERangeSlider))
        .onChanged
        ?.call(
          const RangeValues(24, 116),
        );
    await tester.pumpAndSettle();
    await tester.tap(find.text('完了'));
    await tester.pumpAndSettle();
    expect(received, (20, 120));
  });

  testWidgets('sort order retains a selection when current toggle is tapped', (
    tester,
  ) async {
    (EarthquakeSortBy, SortOrder)? received;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: Scaffold(
          body: SortFilterChip(
            onChanged: (by, order) => received = (by, order),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(M3EToggleButtonGroup));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(M3EToggleButton, '降順 ↓').hitTestable(),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<M3EToggleButtonGroup>(find.byType(M3EToggleButtonGroup))
          .selectedIndex,
      SortOrder.values.indexOf(SortOrder.desc),
    );
    await tester.tap(
      find.widgetWithText(M3EToggleButton, '昇順 ↑').hitTestable(),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('完了'));
    await tester.pumpAndSettle();
    expect(received, (EarthquakeSortBy.eventId, SortOrder.asc));
  });
}
