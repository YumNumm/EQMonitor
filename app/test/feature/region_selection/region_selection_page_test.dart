import 'dart:async';

import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_map_metadata.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_catalog_provider.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_map_metadata_provider.dart';
import 'package:eqmonitor/feature/region_selection/ui/component/region_selection_map.dart';
import 'package:eqmonitor/feature/region_selection/ui/page/region_selection_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

const cities = [
  RegionOption(
    kind: .city,
    code: '1320600',
    name: '府中市',
    kana: 'ふちゅうし',
    parentName: '東京都',
  ),
  RegionOption(
    kind: .city,
    code: '3420800',
    name: '府中市',
    kana: 'ふちゅうし',
    parentName: '広島県',
  ),
];

void main() {
  testWidgets('旧packの地図と一覧を切り替えても選択を保持し、古いcallbackは解除済み項目を戻さない', (
    tester,
  ) async {
    const first = RegionOption(kind: .epicenter, code: '100', name: '石狩地方北部');
    const second = RegionOption(kind: .epicenter, code: '350', name: '東京都２３区');
    List<RegionOption>? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith((ref) async => [first, second]),
          mapConfigurationProvider.overrideWith(_MapConfiguration.new),
          regionMapMetadataProvider.overrideWith(
            (ref) async => const RegionMapMetadata(layers: []),
          ),
        ],
        child: MaterialApp(
          home: RegionSelectionPage(
            request: const RegionSelectionRequest(
              kinds: [.epicenter],
              mode: .multiple,
              initialSelection: [first],
              allowEmpty: true,
            ),
            onConfirmed: (value) => result = value,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('地図'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Asset Packを更新'), findsOneWidget);
    expect(find.text('選択中（1）'), findsOneWidget);
    final delayedSelection = tester
        .widget<RegionSelectionMap>(find.byType(RegionSelectionMap))
        .onSelected;
    await tester.tap(find.text('すべて解除'));
    await tester.pump();
    delayedSelection(second);
    await tester.pump();
    await tester.tap(find.text('一覧'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('決定'));
    expect(result, [second]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('地域検索workerの失敗を表示し再試行できる', (tester) async {
    var attempts = 0;
    final pending = Completer<JmaMapIsolate>();
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          mapConfigurationProvider.overrideWith(_MapConfiguration.new),
          regionMapMetadataProvider.overrideWith(
            (ref) async => const RegionMapMetadata(layers: []),
          ),
          jmaMapIsolateProvider.overrideWith((ref) {
            attempts++;
            if (attempts == 1) throw Exception('worker unavailable');
            return pending.future;
          }),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: RegionSelectionMap(
              kind: .city,
              catalog: cities,
              selected: const [],
              onSelected: (_) {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('再試行'), findsOneWidget);
    await tester.tap(find.text('再試行'));
    await tester.pump();
    await tester.pump();
    expect(attempts, 2);
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    pending.completeError(Exception('disposed'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
  testWidgets('複数選択を同名市の親表示で区別して決定する', (tester) async {
    List<RegionOption>? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith((ref) async => cities),
        ],
        child: MaterialApp(
          home: RegionSelectionPage(
            request: const RegionSelectionRequest(
              kinds: [.city],
              mode: .multiple,
            ),
            onConfirmed: (selected) {
              result = selected;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('府中市').first);
    await tester.pump();
    await tester.tap(find.text('府中市').at(1));
    await tester.pump();
    expect(find.text('選択中（2）'), findsOneWidget);
    await tester.tap(find.text('決定'));
    expect(result, cities);
  });

  testWidgets('種別と検索を切り替えても複数選択を保持し個別解除できる', (tester) async {
    const prefecture = RegionOption(kind: .prefecture, code: '13', name: '東京都');
    List<RegionOption>? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith(
            (ref) async => [prefecture, ...cities],
          ),
        ],
        child: MaterialApp(
          home: RegionSelectionPage(
            request: RegionSelectionRequest(
              kinds: const [.prefecture, .city],
              mode: .multiple,
              initialSelection: [cities.first],
            ),
            onConfirmed: (selected) {
              result = selected;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, '都道府県'));
    await tester.pump();
    await tester.tap(find.text('東京都').first);
    await tester.pump();
    expect(find.text('選択中（2）'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, '市区町村'));
    await tester.enterText(find.byType(SearchBar), 'ﾌﾁｭｳ');
    await tester.pump();
    await tester.tap(find.byTooltip('東京都の選択を解除'));
    await tester.pump();
    await tester.tap(find.text('決定'));
    expect(result, [cities.first]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('単一選択は置換し明示的な全解除を返す', (tester) async {
    List<RegionOption>? result;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith((ref) async => cities),
        ],
        child: MaterialApp(
          home: RegionSelectionPage(
            request: RegionSelectionRequest(
              kinds: const [.city],
              initialSelection: [cities.first],
              allowEmpty: true,
            ),
            onConfirmed: (selected) {
              result = selected;
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('府中市').at(1));
    await tester.pump();
    await tester.tap(find.text('決定'));
    expect(result, [cities.last]);
    await tester.tap(find.text('すべて解除'));
    await tester.pump();
    await tester.tap(find.text('決定'));
    expect(result, isEmpty);
  });

  testWidgets('読込中から検索結果なしへ移行し初期検索語を保持する', (tester) async {
    final completer = Completer<List<RegionOption>>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith((ref) => completer.future),
        ],
        child: const MaterialApp(
          home: RegionSelectionPage(
            request: RegionSelectionRequest(initialQuery: '存在しない地域'),
          ),
        ),
      ),
    );
    expect(find.byType(M3ECircularProgressIndicator), findsOneWidget);
    completer.complete(cities);
    await tester.pumpAndSettle();
    expect(find.text('該当する地域がありません'), findsOneWidget);
    expect(find.text('存在しない地域'), findsOneWidget);
  });
}

final class _MapConfiguration extends MapConfigurationNotifier {
  @override
  Future<MapConfiguration> build() async => const MapConfiguration(
    theme: .light,
    styleString: '{"version":8,"sources":{},"layers":[]}',
  );
}
