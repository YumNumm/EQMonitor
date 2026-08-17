import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_region_map_selection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/notification_region_map_selection_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  const city = NotificationCityOption(
    code: '0720100',
    name: '福島市',
    kana: 'ふくしまし',
  );
  final region = NotificationRegionOption(
    code: '250',
    name: '福島県中通り',
    kana: 'ふくしまけんなかどおり',
    cities: const [city],
  );

  testWidgets('全国では地図タップの案内だけを表示する', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationRegionMapSelectionCard(
            selection: const NotificationRegionMapNationwide(),
            isResolving: false,
            onDecideRegion: () {},
            onDecideCity: () {},
            onBackToRegion: () {},
          ),
        ),
      ),
    );

    expect(find.text('地図をタップして地域を選択'), findsOneWidget);
    expect(find.textContaining('250'), findsNothing);
  });

  testWidgets('regionでは地域全域を決定できる', (tester) async {
    var decided = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationRegionMapSelectionCard(
            selection: NotificationRegionMapFocused(region: region),
            isResolving: false,
            onDecideRegion: () => decided = true,
            onDecideCity: () {},
            onBackToRegion: () {},
          ),
        ),
      ),
    );

    expect(find.text('福島県中通り'), findsOneWidget);
    await tester.tap(find.text('この地域全域を選択'));
    expect(decided, isTrue);
  });

  testWidgets('市区町村では市区町村決定とregionへ戻る操作を提供する', (tester) async {
    var cityDecided = false;
    var wentBack = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NotificationRegionMapSelectionCard(
            selection: NotificationRegionMapCitySelected(
              region: region,
              city: city,
            ),
            isResolving: false,
            onDecideRegion: () {},
            onDecideCity: () => cityDecided = true,
            onBackToRegion: () => wentBack = true,
          ),
        ),
      ),
    );

    expect(find.text('福島市'), findsOneWidget);
    expect(find.textContaining('0720100'), findsNothing);
    await tester.tap(find.text('この市区町村を選択'));
    await tester.tap(find.text('地域全域の選択に戻る'));
    expect(cityDecided, isTrue);
    expect(wentBack, isTrue);
  });
}
