import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({
    List<TelegramStatus>? statuses,
    void Function(List<TelegramStatus>?)? onChanged,
  }) => ProviderScope(
    child: MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: StatusFilterChip(statuses: statuses, onChanged: onChanged),
      ),
    ),
  );

  testWidgets('(a) 1つだけ選択時、その項目のCheckboxListTileがenabled == false', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(statuses: [TelegramStatus.normal]));
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    final normalTile = tester.widget<CheckboxListTile>(
      find.ancestor(
        of: find.text('通常'),
        matching: find.byType(CheckboxListTile),
      ),
    );
    expect(normalTile.enabled, isFalse);

    final trainingTile = tester.widget<CheckboxListTile>(
      find.ancestor(
        of: find.text('訓練'),
        matching: find.byType(CheckboxListTile),
      ),
    );
    expect(trainingTile.enabled, isTrue);

    final testTile = tester.widget<CheckboxListTile>(
      find.ancestor(
        of: find.text('試験'),
        matching: find.byType(CheckboxListTile),
      ),
    );
    expect(testTile.enabled, isTrue);
  });

  testWidgets('(b) 2つ以上選択時、全てのCheckboxListTileがenabled == true', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(statuses: [TelegramStatus.normal, TelegramStatus.training]),
    );
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    final tiles = tester
        .widgetList<CheckboxListTile>(find.byType(CheckboxListTile))
        .toList();
    for (final tile in tiles) {
      expect(tile.enabled, isTrue);
    }
  });
}
