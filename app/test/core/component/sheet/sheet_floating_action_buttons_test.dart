import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sheet/sheet.dart';

void main() {
  testWidgets(
    'native toolbar follows sheet height and safe horizontal bounds',
    (
      tester,
    ) async {
      final animation = AnimationController(vsync: tester, value: 0.2);
      final controller = _AnimatedSheetController(animation);
      addTearDown(controller.dispose);
      addTearDown(animation.dispose);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: const EdgeInsets.fromLTRB(10, 24, 20, 0),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
          home: Scaffold(
            body: Stack(
              children: [
                SheetFloatingActionButtons(
                  controller: controller,
                  hasAppBar: false,
                  fab: const [
                    M3EVerticalFloatingToolbar(
                      expanded: true,
                      content: Icon(Icons.home),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      final toolbar = find.byType(M3EVerticalFloatingToolbar);
      final before = tester.getRect(toolbar);
      expect(before.right, 776);
      animation.value = 0.4;
      await tester.pump();
      final after = tester.getRect(toolbar);
      expect(before.bottom - after.bottom, closeTo(115.2, 0.01));
      expect(after.right, before.right);
      expect(tester.takeException(), isNull);
    },
  );
}

class _AnimatedSheetController extends SheetController {
  new(this.animation);

  @override
  final Animation<double> animation;
}
