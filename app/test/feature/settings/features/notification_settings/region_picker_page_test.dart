import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_region_catalog_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/region_picker_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final catalog = NotificationRegionCatalog(
    regions: [
      NotificationRegionOption(
        code: '9011',
        name: '北海道道央',
        kana: 'ほっかいどうどうおう',
        cities: const [],
      ),
      NotificationRegionOption(
        code: '9012',
        name: '北海道道南',
        kana: 'ほっかいどうどうなん',
        cities: const [],
      ),
    ],
    unmappedCityCodes: const [],
  );

  Widget app() => ProviderScope(
    overrides: [
      notificationRegionCatalogProvider.overrideWith((ref) async => catalog),
    ],
    child: const MaterialApp(home: RegionPickerPage()),
  );

  testWidgets('IDを表示せず48px以上のコンパクトな地域行を表示する', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('北海道道央'), findsOneWidget);
    expect(find.text('9011'), findsNothing);
    final tile = tester.widget<ListTile>(
      find.ancestor(of: find.text('北海道道央'), matching: find.byType(ListTile)),
    );
    expect(tile.minTileHeight, 48);
    expect(tile.visualDensity, VisualDensity.compact);
  });

  testWidgets('カタカナのふりがな検索で地域を絞り込む', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(SearchBar), 'ドウナン');
    await tester.pump();

    expect(find.text('北海道道央'), findsNothing);
    expect(find.text('北海道道南'), findsOneWidget);
  });
}
