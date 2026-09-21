import 'dart:async';

import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_catalog_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/page/earthquake_history_search_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('読み込み中から検索結果なしに遷移する', (tester) async {
    final result = Completer<List<RegionOption>>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith(
            (ref) => result.future,
          ),
        ],
        child: const MaterialApp(
          home: EarthquakeHistorySearchPage(initialQuery: '東京'),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    result.complete(const []);
    await tester.pumpAndSettle();
    expect(find.textContaining('該当する地域がありません'), findsOneWidget);
    expect(find.text('東京'), findsOneWidget);
  });

  testWidgets('例外の詳細を表示せず読み込み失敗と再試行を案内する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          regionCatalogProvider().overrideWith(
            (ref) => Future.error(StateError('internal error details')),
          ),
        ],
        child: const MaterialApp(
          home: EarthquakeHistorySearchPage(initialQuery: '東京'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('地域情報を読み込めませんでした'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.textContaining('internal error details'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
