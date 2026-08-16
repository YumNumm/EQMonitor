import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/city_picker_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final region = NotificationRegionOption(
    code: '9011',
    name: '北海道道央',
    kana: 'ほっかいどうどうおう',
    cities: const [
      NotificationCityOption(code: '0110100', name: '札幌市', kana: 'さっぽろし'),
      NotificationCityOption(code: '0120200', name: '函館市', kana: 'はこだてし'),
    ],
  );

  Widget app() => ProviderScope(
    child: MaterialApp(home: CityPickerPage(region: region)),
  );

  testWidgets('観測点名やIDではなく正しい市区町村名を表示する', (tester) async {
    await tester.pumpWidget(app());

    expect(find.text('札幌市'), findsOneWidget);
    expect(find.text('0110100'), findsNothing);
    expect(find.text('札幌市中央区北2条'), findsNothing);
    final tile = tester.widget<ListTile>(
      find.ancestor(of: find.text('札幌市'), matching: find.byType(ListTile)),
    );
    expect(tile.minTileHeight, 48);
  });

  testWidgets('半角カナのふりがな検索で市区町村を絞り込む', (tester) async {
    await tester.pumpWidget(app());

    await tester.enterText(find.byType(SearchBar), 'ﾊｺﾀﾞﾃ');
    await tester.pump();

    expect(find.text('札幌市'), findsNothing);
    expect(find.text('函館市'), findsOneWidget);
  });

  testWidgets('検索結果がなくても地域全域を選択できる', (tester) async {
    await tester.pumpWidget(app());

    await tester.enterText(find.byType(SearchBar), '該当なし');
    await tester.pump();

    expect(find.text('北海道道央 全域'), findsOneWidget);
    expect(find.text('該当する市区町村がありません'), findsOneWidget);
  });
}
