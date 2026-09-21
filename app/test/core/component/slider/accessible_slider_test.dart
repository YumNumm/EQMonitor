import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/slider/accessible_range_slider.dart';
import 'package:eqmonitor/core/component/slider/accessible_slider.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('slider exposes current value and bounded increase action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      double? received;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccessibleSlider(
              value: 9,
              min: 0,
              max: 10,
              divisions: 5,
              onChanged: (next) => received = next,
            ),
          ),
        ),
      );
      final node = tester.getSemantics(find.byType(AccessibleSlider));
      expect(node.getSemanticsData().value, '9.0');
      node.owner?.performAction(
        node.id,
        SemanticsAction.increase,
      );
      expect(received, 10);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('range thumbs expose independent bounds and cannot cross', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      RangeValues? received;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AccessibleRangeSlider(
              value: const RangeValues(4, 5),
              max: 10,
              divisions: 5,
              onChanged: (next) => received = next,
            ),
          ),
        ),
      );
      final start = tester.getSemantics(find.bySemanticsLabel('下限'));
      start.owner?.performAction(
        start.id,
        SemanticsAction.increase,
      );
      expect(received, const RangeValues(5, 5));
      final end = tester.getSemantics(find.bySemanticsLabel('上限'));
      end.owner?.performAction(
        end.id,
        SemanticsAction.decrease,
      );
      expect(received, const RangeValues(4, 4));
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('determinate progress exposes its percentage', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AccessibleCircularProgressIndicator(value: 0.42),
          ),
        ),
      );
      expect(
        tester
            .getSemantics(find.bySemanticsLabel('読み込み中'))
            .getSemanticsData()
            .value,
        '42%',
      );
    } finally {
      semantics.dispose();
    }
  });
}
