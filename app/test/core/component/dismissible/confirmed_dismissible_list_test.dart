import 'dart:async';
import 'dart:ui' show SemanticsAction, SemanticsActionEvent;

import 'package:eqmonitor/core/component/dismissible/confirmed_dismissible_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'a delayed rejected save restores the middle row and scroll offset',
    (
      tester,
    ) async {
      final result = Completer<bool>();
      final dismissed = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConfirmedDismissibleList<String>(
              items: List.generate(30, (index) => '項目 $index'),
              itemId: (item) => item,
              itemBuilder: (_, item) => ListTile(title: Text(item)),
              style: const M3EDismissibleCardStyle(direction: .endToStart),
              onDismiss: (item) {
                dismissed.add(item);
                return result.future;
              },
            ),
          ),
        ),
      );
      await tester.drag(find.byType(ListView), const Offset(0, -350));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('項目 10'));
      await tester.pumpAndSettle();
      final offset = tester
          .state<ScrollableState>(find.byType(Scrollable))
          .position
          .pixels;
      await tester.drag(find.text('項目 10'), const Offset(-700, 0));
      await tester.pumpAndSettle();
      expect(dismissed, ['項目 10']);
      expect(find.text('項目 10'), findsNothing);
      expect(find.text('項目 11'), findsOneWidget);

      // Finish after the native fly-out and collapse controllers have disposed.
      result.complete(false);
      await tester.pumpAndSettle();
      expect(find.text('項目 10'), findsOneWidget);
      expect(find.text('項目 11'), findsOneWidget);
      expect(
        tester.state<ScrollableState>(find.byType(Scrollable)).position.pixels,
        offset,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'a successful save waits for authoritative data without deleting another row',
    (
      tester,
    ) async {
      final result = Completer<bool>();
      final items = ValueNotifier(['first', 'middle', 'last']);
      final tapped = <String>[];
      addTearDown(items.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ValueListenableBuilder<List<String>>(
              valueListenable: items,
              builder: (_, values, _) => ConfirmedDismissibleList<String>(
                items: values,
                itemId: (item) => item,
                itemBuilder: (_, item) => ListTile(title: Text(item)),
                style: const M3EDismissibleCardStyle(direction: .endToStart),
                onDismiss: (_) => result.future,
                onTap: tapped.add,
              ),
            ),
          ),
        ),
      );
      await tester.drag(find.text('middle'), const Offset(-700, 0));
      await tester.pumpAndSettle();
      result.complete(true);
      await tester.pumpAndSettle();
      expect(find.text('middle'), findsNothing);
      expect(find.text('first'), findsOneWidget);
      expect(find.text('last'), findsOneWidget);

      await tester.tap(find.text('last'));
      expect(tapped, ['last']);
      items.value = ['first', 'last'];
      await tester.pumpAndSettle();
      expect(find.text('middle'), findsNothing);
      expect(find.text('first'), findsOneWidget);
      expect(find.text('last'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('screen readers can dismiss a row without a swipe gesture', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      final dismissed = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ConfirmedDismissibleList<String>(
              items: const ['first', 'last'],
              itemId: (item) => item,
              itemBuilder: (_, item) => ListTile(title: Text(item)),
              onDismiss: (item) async {
                dismissed.add(item);
                return true;
              },
            ),
          ),
        ),
      );
      final node = tester.getSemantics(find.text('first'));
      expect(node, isSemantics(label: 'first', hasDismissAction: true));
      tester.binding.performSemanticsAction(
        SemanticsActionEvent(
          viewId: tester.view.viewId,
          nodeId: node.id,
          type: SemanticsAction.dismiss,
        ),
      );
      await tester.pumpAndSettle();
      expect(dismissed, ['first']);
      expect(find.text('first'), findsNothing);
      expect(find.text('last'), findsOneWidget);
      expect(tester.takeException(), isNull);
    } finally {
      semantics.dispose();
    }
  });
}
