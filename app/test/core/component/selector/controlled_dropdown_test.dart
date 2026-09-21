import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'external selection updates are silent and user callbacks stay current',
    (
      tester,
    ) async {
      final firstCalls = <List<M3EDropdownItem<int?>>>[];
      final secondCalls = <List<M3EDropdownItem<int?>>>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlledDropdown<int?>(
              items: const [
                M3EDropdownItem(value: null, label: '指定なし', selected: true),
                M3EDropdownItem(value: 1, label: '1'),
              ],
              onSelectionChanged: firstCalls.add,
            ),
          ),
        ),
      );
      final controller = tester
          .widget<M3EDropdownMenu<(int?,)>>(
            find.byType(M3EDropdownMenu<(int?,)>),
          )
          .controller;
      expect(controller?.selectedValues, [(null,)]);
      expect(firstCalls, isEmpty);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlledDropdown<int?>(
              items: const [
                M3EDropdownItem(value: null, label: '指定なし'),
                M3EDropdownItem(value: 1, label: '1', selected: true),
              ],
              onSelectionChanged: secondCalls.add,
            ),
          ),
        ),
      );
      expect(controller?.selectedValues, [(1,)]);
      expect(firstCalls, isEmpty);
      expect(secondCalls, isEmpty);
      controller?.toggleOnly(controller.items.last);
      expect(controller?.selectedValues, [(1,)]);
      expect(secondCalls, isEmpty);
      controller?.toggleOnly(controller.items.first);
      expect(firstCalls, isEmpty);
      expect(secondCalls, hasLength(1));
      expect(secondCalls.single.map((item) => item.value), [null]);
      await tester.pump();
      controller?.openDropdown();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlledDropdown<int?>(
              enabled: false,
              items: const [
                M3EDropdownItem(value: null, label: '指定なし', selected: true),
                M3EDropdownItem(value: 1, label: '1'),
              ],
              onSelectionChanged: secondCalls.add,
            ),
          ),
        ),
      );
      expect(controller?.isOpen, isFalse);
      controller?.toggleOnly(controller.items.last);
      expect(secondCalls, hasLength(1));
      expect(controller?.selectedValues, [(null,)]);
      await tester.pump();
      expect(tester.takeException(), isNull);
    },
  );
}
