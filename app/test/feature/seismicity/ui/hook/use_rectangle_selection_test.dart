import 'package:eqmonitor/feature/seismicity/ui/hook/use_rectangle_selection.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('十分な距離のドラッグでは endDrag が矩形を返す', (tester) async {
    late RectangleSelectionState selection;
    await tester.pumpWidget(
      HookBuilder(
        builder: (context) {
          selection = useRectangleSelection();
          return const SizedBox.expand();
        },
      ),
    );

    selection.startDrag(const Offset(0, 0));
    selection.updateDrag(const Offset(100, 100));
    final rect = selection.endDrag();

    expect(rect, Rect.fromLTRB(0, 0, 100, 100));
  });

  testWidgets(
    '退化した(ほぼ動いていない)矩形の場合 endDrag は null を返す',
    (tester) async {
      late RectangleSelectionState selection;
      await tester.pumpWidget(
        HookBuilder(
          builder: (context) {
            selection = useRectangleSelection();
            return const SizedBox.expand();
          },
        ),
      );

      selection.startDrag(const Offset(50, 50));
      selection.updateDrag(const Offset(51, 50));
      final rect = selection.endDrag();

      expect(rect, isNull);
    },
  );

  testWidgets('endDrag はドラッグ開始前は null を返す', (tester) async {
    late RectangleSelectionState selection;
    await tester.pumpWidget(
      HookBuilder(
        builder: (context) {
          selection = useRectangleSelection();
          return const SizedBox.expand();
        },
      ),
    );

    expect(selection.endDrag(), isNull);
  });
}
