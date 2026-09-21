import 'dart:ui' show SemanticsAction, SemanticsActionEvent;

import 'package:eqmonitor/core/component/expansion/expandable_section.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'header announces and toggles expansion without merging body actions',
    (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      try {
        final changes = <bool>[];
        var bodyTaps = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableSection(
                title: const Text('詳細'),
                onExpansionChanged: changes.add,
                children: [
                  TextButton(
                    onPressed: () => bodyTaps++,
                    child: const Text('内容を選択'),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('内容を選択'), findsNothing);
        final header = tester.getSemantics(find.text('詳細'));
        expect(
          header,
          isSemantics(
            label: '詳細',
            isButton: true,
            hasExpandedState: true,
            isExpanded: false,
            hasTapAction: true,
          ),
        );
        tester.binding.performSemanticsAction(
          SemanticsActionEvent(
            viewId: tester.view.viewId,
            nodeId: header.id,
            type: SemanticsAction.tap,
          ),
        );
        await tester.pumpAndSettle();
        expect(changes, [true]);
        expect(find.text('内容を選択'), findsOneWidget);
        expect(
          tester.getSemantics(find.text('詳細')),
          isSemantics(
            label: '詳細',
            isButton: true,
            hasExpandedState: true,
            isExpanded: true,
            hasTapAction: true,
          ),
        );

        await tester.tap(find.text('内容を選択'));
        await tester.pumpAndSettle();
        expect(bodyTaps, 1);
        expect(changes, [true]);
        await tester.tap(find.text('詳細'));
        await tester.pumpAndSettle();
        expect(changes, [true, false]);
        expect(find.text('内容を選択'), findsNothing);
      } finally {
        semantics.dispose();
      }
    },
  );

  testWidgets(
    'initial expansion and keyboard toggling retain independent state',
    (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableSection(
              initiallyExpanded: true,
              title: Text('設定'),
              children: [Text('設定内容')],
            ),
          ),
        ),
      );
      expect(find.text('設定内容'), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.text('設定内容'), findsNothing);
      await tester.sendKeyEvent(LogicalKeyboardKey.space);
      await tester.pumpAndSettle();
      expect(find.text('設定内容'), findsOneWidget);
      expect(
        tester
            .widget<M3EExpandableSegmentedItem>(
              find.byType(M3EExpandableSegmentedItem),
            )
            .isExpanded,
        isTrue,
      );
    },
  );

  testWidgets('large text wraps title and subtitle with optional adornments', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2.5)),
            child: ListView(
              children: const [
                SizedBox(
                  width: 320,
                  child: ExpandableSection(
                    initiallyExpanded: true,
                    title: Text('長い見出しを折り返して表示する設定項目'),
                    subtitle: Text('拡大された説明文も省略せずに表示する'),
                    leading: Icon(Icons.settings),
                    trailing: Icon(Icons.info_outline),
                    children: [Text('展開された内容')],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('展開された内容'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
