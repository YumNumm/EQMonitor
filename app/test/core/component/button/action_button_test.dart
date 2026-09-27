import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('disabled action cannot fire and enabled action fires once', (
    tester,
  ) async {
    var calls = 0;
    for (final enabled in [false, true]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActionButton(
              onPressed: () => calls++,
              isEnabled: enabled,
              child: const Text('実行'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('実行'));
      await tester.pumpAndSettle();
      expect(calls, enabled ? 1 : 0);
    }
  });
}
