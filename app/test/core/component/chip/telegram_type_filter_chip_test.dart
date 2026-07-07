import 'package:eqmonitor/core/component/chip/telegram_type_filter_chip.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget wrap({
    List<EarthquakeTelegramType>? telegramTypes,
    ValueChanged<List<EarthquakeTelegramType>?>? onChanged,
  }) => ProviderScope(
    child: MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: TelegramTypeFilterChip(
          telegramTypes: telegramTypes,
          onChanged: onChanged,
        ),
      ),
    ),
  );

  testWidgets('(a) 1つだけ選択時、その項目のCheckboxListTileがenabled == false', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(telegramTypes: [EarthquakeTelegramType.vxse51]),
    );
    await tester.pump();

    await tester.tap(find.byType(RawChip));
    await tester.pumpAndSettle();

    final vxse51Tile = tester.widget<CheckboxListTile>(
      find.ancestor(
        of: find.text('震度速報'),
        matching: find.byType(CheckboxListTile),
      ),
    );
    expect(vxse51Tile.enabled, isFalse);

    final vxse52Tile = tester.widget<CheckboxListTile>(
      find.ancestor(
        of: find.text('震源に関する情報'),
        matching: find.byType(CheckboxListTile),
      ),
    );
    expect(vxse52Tile.enabled, isTrue);
  });

  testWidgets('(b) 2つ以上選択時、全てのCheckboxListTileがenabled == true', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        telegramTypes: [
          EarthquakeTelegramType.vxse51,
          EarthquakeTelegramType.vxse52,
        ],
      ),
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
