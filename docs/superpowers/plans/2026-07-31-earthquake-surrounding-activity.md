# Earthquake Surrounding Activity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 規模の大きな通常地震の詳細画面から、発生前後の周辺地震を地図・最大震度別時間グラフ・一覧で追跡できる機能を実装する。

**Architecture:** 既存地震履歴 API を `eventId` カーソルで全ページ取得し、アプリ側の純粋ロジックで `originTime`、深さ、大圏距離を厳密に絞り込む。取得結果は query 単位の Riverpod Provider で共有し、概要カード、専用画面、地図、グラフ、一覧は同じ完全なデータセットから派生させる。リアルタイム地震イベントは表示中 Provider を無効化し、直前の完全な値を保ったまま再取得する。

**Tech Stack:** Flutter 3.44、Dart 3.11、Riverpod 3、flutter_hooks、Freezed、go_router_builder、MapLibre、fl_chart、flutter_test

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- `EarthquakeType.normal` かつ `originTime`・震源座標を持ち、`M6.0以上` または `最大震度5弱以上` の基準地震だけに入口を表示する。
- 時系列の判定・ビニング・表示順には必ず `originTime` を使用し、`eventId` は識別・重複排除・API cursor・同時刻の第2ソートに限定する。
- 初期条件は発生1日前〜7日後、半径25km、深さ±20km。前側30日、後側365日、半径200km、深さ±200kmを上限とする。
- 取得途中のページを確定結果として公開しない。固定値・推測値・ランダムデータへフォールバックしない。
- `dynamic`、`Object`、`!`、`print()`、StatefulWidget を新規コードで使用しない。
- 複数引数は名前付きにし、ロジックとイベントハンドラを Widget の private method に置かない。
- Light / Dark、拡大文字、Semantics、loading / error / empty / refreshing をテストする。

---

## File Structure

### Data models and logic

- `app/lib/feature/earthquake_history/data/model/earthquake_activity_query.dart`: 基準地震と検索条件、期間境界。
- `app/lib/feature/earthquake_history/data/model/earthquake_activity_dataset.dart`: 完全取得済み一覧と取得時刻。
- `app/lib/feature/earthquake_history/data/model/earthquake_activity_summary.dart`: 前後件数、最大震度、最大M、最終発生時刻。
- `app/lib/feature/earthquake_history/data/model/earthquake_activity_bin.dart`: 時間ビンと震度区分別件数。
- `app/lib/feature/earthquake_history/data/model/earthquake_activity_bin_interval.dart`: 1h / 6h / 1d / 1w と自動選択。
- `app/lib/feature/earthquake_history/data/model/earthquake_activity_intensity_category.dart`: 震度0〜7、強弱不明、情報なし。
- `app/lib/feature/earthquake_history/data/logic/earthquake_activity_eligibility.dart`: 概要カード表示可否。
- `app/lib/feature/earthquake_history/data/logic/earthquake_activity_bounds_calculator.dart`: 半径の外接矩形。
- `app/lib/feature/earthquake_history/data/logic/earthquake_activity_filter.dart`: originTime・距離・深さ・種別の厳密判定。
- `app/lib/feature/earthquake_history/data/logic/earthquake_activity_summary_builder.dart`: 概要集計。
- `app/lib/feature/earthquake_history/data/logic/earthquake_activity_binner.dart`: 最大震度別時間ビン。

### Repository and providers

- `app/lib/feature/earthquake_history/data/repository/earthquake_activity_repository.dart`: 既存 Repository の全ページ取得と完全結果の組み立て。
- `app/lib/feature/earthquake_history/data/provider/earthquake_activity_provider.dart`: query family、進捗、手動更新、リアルタイム無効化。

### UI

- `app/lib/feature/earthquake_history/ui/components/earthquake_activity_card.dart`: 詳細画面の概要カード。
- `app/lib/feature/earthquake_history/ui/earthquake_activity_page.dart`: 専用画面と操作状態。
- `app/lib/feature/earthquake_history/ui/components/earthquake_activity_map.dart`: コンパクト MapLibre host。
- `app/lib/feature/earthquake_history/ui/layer/earthquake_activity_map_layer.dart`: 半径、基準地震、周辺地震の GeoJSON layers。
- `app/lib/feature/earthquake_history/ui/action/earthquake_activity_map_action.dart`: 地図タップと詳細遷移。
- `app/lib/feature/earthquake_history/ui/components/earthquake_activity_chart.dart`: fl_chart 積み上げ棒グラフ。
- `app/lib/feature/earthquake_history/ui/components/earthquake_activity_settings_sheet.dart`: 半径・深さ・ビン間隔。
- `app/lib/core/router/router.dart`: `EarthquakeActivityRoute`。
- `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`: 概要カードの配置。

### Tests

- `app/test/feature/earthquake_history/data/earthquake_activity_query_test.dart`
- `app/test/feature/earthquake_history/data/earthquake_activity_filter_test.dart`
- `app/test/feature/earthquake_history/data/earthquake_activity_aggregation_test.dart`
- `app/test/feature/earthquake_history/data/earthquake_activity_repository_test.dart`
- `app/test/feature/earthquake_history/data/earthquake_activity_provider_test.dart`
- `app/test/feature/earthquake_history/ui/components/earthquake_activity_card_test.dart`
- `app/test/feature/earthquake_history/ui/components/earthquake_activity_chart_test.dart`
- `app/test/feature/earthquake_history/ui/earthquake_activity_page_test.dart`
- `app/test/feature/earthquake_history/ui/layer/earthquake_activity_map_layer_test.dart`

---

### Task 1: Query, eligibility, and geographic bounds

**Files:**
- Create the query, eligibility, bounds calculator files listed above.
- Test: `earthquake_activity_query_test.dart`, `earthquake_activity_filter_test.dart`

**Interfaces:**
- Produces `EarthquakeActivityQuery`, `EarthquakeActivityEligibility.isEligible(Earthquake)`, and `EarthquakeActivityBoundsCalculator.calculate(...)`.

- [ ] **Step 1: Write failing eligibility and boundary tests**

```dart
test('通常地震かつ M6.0 なら対象', () {
  expect(const EarthquakeActivityEligibility().isEligible(earthquake), isTrue);
});

test('実効終了時刻は発生365日後と現在時刻の早い方', () {
  expect(query.effectiveEnd(now: now), originTime.add(const Duration(days: 365)));
});
```

- [ ] **Step 2: Run the focused tests and confirm undefined-type failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_query_test.dart test/feature/earthquake_history/data/earthquake_activity_filter_test.dart`

- [ ] **Step 3: Implement immutable query, eligibility, and bounds**

```dart
@freezed
abstract class EarthquakeActivityQuery with _$EarthquakeActivityQuery {
  const factory EarthquakeActivityQuery({
    required String baseEventId,
    required DateTime baseOriginTime,
    required double latitude,
    required double longitude,
    required int? depth,
    @Default(1) int beforeDays,
    @Default(7) int afterDays,
    @Default(25) int radiusKm,
    required int? depthOffsetKm,
  }) = _EarthquakeActivityQuery;
  const EarthquakeActivityQuery._();
}
```

Validate constructor inputs through a public `EarthquakeActivityQueryValidator`; derive `start`, `effectiveEnd(now:)`, clamped depth bounds, and API `Date` bounds without using `eventId` as time.

- [ ] **Step 4: Generate code and run focused tests**

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_query_test.dart test/feature/earthquake_history/data/earthquake_activity_filter_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/data app/test/feature/earthquake_history/data
git commit -m "feat: 周辺地震活動の検索条件を追加"
```

### Task 2: Exact filtering, summaries, and time bins

**Files:**
- Create the dataset, summary, bin, interval, category, filter, summary builder, and binner files listed above.
- Test: `earthquake_activity_filter_test.dart`, `earthquake_activity_aggregation_test.dart`

**Interfaces:**
- Consumes `EarthquakeActivityQuery` and `List<EarthquakePartial>`.
- Produces `EarthquakeActivityDataset`, `EarthquakeActivitySummary`, and `List<EarthquakeActivityBin>`.

- [ ] **Step 1: Add failing tests for exact great-circle filtering and every intensity category**

```dart
test('矩形内でも半径25km外は除外する', () {
  final result = filter.apply(query: query, candidates: [inside, outside], now: now);
  expect(result.map((e) => e.eventId), ['inside']);
});

test('震度0・強弱不明・情報なしを失わず6時間ビンへ集計する', () {
  final bins = binner.build(items: items, query: query, interval: .sixHours, now: now);
  expect(bins.expand((e) => e.counts.values).reduce((a, b) => a + b), items.length);
});
```

- [ ] **Step 2: Run tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_filter_test.dart test/feature/earthquake_history/data/earthquake_activity_aggregation_test.dart`

- [ ] **Step 3: Implement pure logic classes**

```dart
class EarthquakeActivityFilter {
  const EarthquakeActivityFilter();
  List<EarthquakePartialNormal> apply({
    required EarthquakeActivityQuery query,
    required List<EarthquakePartial> candidates,
    required DateTime now,
  });
}

class EarthquakeActivityBinner {
  const EarthquakeActivityBinner();
  List<EarthquakeActivityBin> build({
    required List<EarthquakePartialNormal> items,
    required EarthquakeActivityQuery query,
    required EarthquakeActivityBinInterval interval,
    required DateTime now,
  });
}
```

Use the haversine formula, inclusive start/end bounds, `originTime` ordering, `eventId` dedupe, and depth-unknown rules from the design. Maxima ignore unknown values; all-unknown summaries expose `null`.

- [ ] **Step 4: Run aggregation tests**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_filter_test.dart test/feature/earthquake_history/data/earthquake_activity_aggregation_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/data app/test/feature/earthquake_history/data
git commit -m "feat: 周辺地震活動の集計ロジックを追加"
```

### Task 3: Paginated repository and Riverpod state

**Files:**
- Create `earthquake_activity_repository.dart`, `earthquake_activity_provider.dart` and generated files.
- Test: `earthquake_activity_repository_test.dart`, `earthquake_activity_provider_test.dart`

**Interfaces:**
- Produces `Future<EarthquakeActivityDataset> EarthquakeActivityRepository.fetch(...)`.
- Produces `earthquakeActivityProvider(query)` and `earthquakeActivityProgressProvider(query)`.

- [ ] **Step 1: Write failing pagination, duplicate cursor, progress, and stale-value tests**

```dart
test('nextToken が null になるまで全ページを取得してから公開する', () async {
  final dataset = await repository.fetch(query: query, now: now, onProgress: progress.add);
  expect(spy.cursors, [null, 'page-2']);
  expect(dataset.items.map((e) => e.eventId), ['newer', 'older']);
  expect(progress, [2, 3]);
});
```

- [ ] **Step 2: Run focused tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_repository_test.dart test/feature/earthquake_history/data/earthquake_activity_provider_test.dart`

- [ ] **Step 3: Implement pagination and Provider families**

```dart
Future<EarthquakeActivityDataset> fetch({
  required EarthquakeActivityQuery query,
  required DateTime now,
  required void Function(int fetchedCount) onProgress,
}) async {
  // request limit 100, EarthquakeType.normal, Date bounds, bounding box,
  // depth bounds, sortBy eventId only for cursor compatibility
}
```

Reject repeated cursors with a typed `StateError`, filter only after every page succeeds, and store `fetchedAt`. Provider refresh must preserve `AsyncValue.value` while loading and expose query-specific progress separately.

- [ ] **Step 4: Generate and run repository/provider tests**

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_activity_repository_test.dart test/feature/earthquake_history/data/earthquake_activity_provider_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/data app/test/feature/earthquake_history/data
git commit -m "feat: 周辺地震活動を全ページ取得"
```

### Task 4: Detail summary card and typed route

**Files:**
- Create `earthquake_activity_card.dart`.
- Modify `earthquake_history_details_page.dart`, `router.dart` and generated router.
- Test: `earthquake_activity_card_test.dart` and existing details-page tests.

**Interfaces:**
- Consumes initial `EarthquakeActivityQuery` and summary builder.
- Produces `EarthquakeActivityRoute(eventId: String)`.

- [ ] **Step 1: Write failing eligibility, state, summary, and navigation Widget tests**

```dart
testWidgets('M6.0の通常地震に前後件数と最大値を表示する', (tester) async {
  await pumpCard(tester, earthquake: eligible, dataset: dataset);
  expect(find.text('周辺の地震活動'), findsOneWidget);
  expect(find.text('前1日 2件'), findsOneWidget);
  expect(find.text('発生後7日 5件'), findsOneWidget);
});
```

- [ ] **Step 2: Run tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/components/earthquake_activity_card_test.dart`

- [ ] **Step 3: Implement the card and route**

Use a `HookConsumerWidget`, fixed user-facing error copy, retry invalidation, cached-data timestamp, and no raw exception. Insert the card before the existing nearby-earthquake card.

- [ ] **Step 4: Generate router/provider code and run tests**

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/components/earthquake_activity_card_test.dart test/feature/earthquake_history/ui/earthquake_history_details_nearby_card_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/core/router app/lib/feature/earthquake_history app/test/feature/earthquake_history
git commit -m "feat: 地震詳細に周辺活動カードを追加"
```

### Task 5: Activity chart and settings controls

**Files:**
- Create `earthquake_activity_chart.dart`, `earthquake_activity_settings_sheet.dart`.
- Test: `earthquake_activity_chart_test.dart`, `earthquake_activity_page_test.dart`.

**Interfaces:**
- Chart consumes bins and returns a selected bin through `ValueChanged<EarthquakeActivityBin?>`.
- Settings returns an immutable settings value containing radius, optional depth offset, and interval.

- [ ] **Step 1: Write failing chart semantics, tap-selection, and settings tests**

```dart
testWidgets('棒のSemanticsに時間帯と震度別件数を含める', (tester) async {
  await pumpChart(tester, bins: bins);
  expect(find.bySemanticsLabel(contains('7月28日 16時から 6時間、合計9件')), findsOneWidget);
});
```

- [ ] **Step 2: Run tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/components/earthquake_activity_chart_test.dart test/feature/earthquake_history/ui/earthquake_activity_page_test.dart`

- [ ] **Step 3: Implement fl_chart stacking and HookWidget settings**

Use `BarChartRodStackItem` for every category, theme-derived colors, a visible base-event marker, horizontal scrolling for dense bins, and selection independent of color. The settings sheet offers only the approved discrete values.

- [ ] **Step 4: Run chart/settings tests**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/components/earthquake_activity_chart_test.dart test/feature/earthquake_history/ui/earthquake_activity_page_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/ui app/test/feature/earthquake_history/ui
git commit -m "feat: 周辺地震活動グラフを追加"
```

### Task 6: Compact MapLibre distribution map

**Files:**
- Create `earthquake_activity_map.dart`, `earthquake_activity_map_layer.dart`, `earthquake_activity_map_action.dart`.
- Test: `earthquake_activity_map_layer_test.dart`.

**Interfaces:**
- Layer consumes base earthquake, filtered items, selected bin, and radius.
- Action consumes a `MapEventClick`, `MapController`, and items; it opens a bottom sheet with a typed details route.

- [ ] **Step 1: Write failing GeoJSON and style tests**

```dart
test('GeoJSONに基準地震・半径円・周辺地震と震度categoryを含める', () {
  final json = const EarthquakeActivityMapGeoJsonBuilder().build(query: query, items: items);
  expect(json, contains('base-event'));
  expect(json, contains('radius-boundary'));
  expect(json, contains('fiveLower'));
});
```

- [ ] **Step 2: Run layer tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/layer/earthquake_activity_map_layer_test.dart`

- [ ] **Step 3: Implement lifecycle-safe sources, layers, camera, and Action**

Follow the existing map operation queue and `MapGeoJsonSourceUpdater` lifecycle. Use `MapController.queryLayers(event.screenPoint)` to confirm a hit, then select the nearest filtered event by great-circle distance in `EarthquakeActivityMapAction`; do not put tap logic in the Widget.

- [ ] **Step 4: Run layer tests and existing map lifecycle tests**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/layer/earthquake_activity_map_layer_test.dart test/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer_lifecycle_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history/ui app/test/feature/earthquake_history/ui
git commit -m "feat: 周辺地震活動の分布地図を追加"
```

### Task 7: Assemble the dedicated page and realtime refresh

**Files:**
- Create `earthquake_activity_page.dart`.
- Modify `earthquake_activity_provider.dart` for `realtimeEventsProvider` listening.
- Test: `earthquake_activity_page_test.dart`, `earthquake_activity_provider_test.dart`.

**Interfaces:**
- Page owns before/after days, radius, depth offset, interval, and selected bin in hooks.
- Provider invalidates only active query families on earthquake upsert/delete events.

- [ ] **Step 1: Write failing page-control and realtime tests**

```dart
testWidgets('前日・翌日・初期範囲ボタンを上限内で反映する', (tester) async {
  await pumpPage(tester, base: base, dataset: dataset);
  await tester.tap(find.text('前日を表示'));
  expect(capturedQuery.beforeDays, 2);
});

test('earthquake upsertで表示中queryを再取得する', () async {
  controller.add(upsertEvent);
  await container.pump();
  expect(fetchCount, 2);
});
```

- [ ] **Step 2: Run tests and confirm failures**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/earthquake_activity_page_test.dart test/feature/earthquake_history/data/earthquake_activity_provider_test.dart`

- [ ] **Step 3: Implement the page, list filtering, refresh, and realtime invalidation**

Render header, current conditions, compact map, chart, lazy event list, fixed data-scope note, progress, empty, error, refreshing, and stale-result states. Effective future end is disabled at `min(base+365d, now)`.

- [ ] **Step 4: Run page/provider tests**

Run: `mise exec -- flutter test test/feature/earthquake_history/ui/earthquake_activity_page_test.dart test/feature/earthquake_history/data/earthquake_activity_provider_test.dart`

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/earthquake_history app/test/feature/earthquake_history
git commit -m "feat: 周辺地震活動画面を完成"
```

### Task 8: Full generation, quality gates, and documentation audit

**Files:**
- Modify generated Dart files from build_runner.
- Modify the design or plan only if implementation reveals an approved-contract mismatch.

- [ ] **Step 1: Generate and format**

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `mise exec -- dart format app/lib/feature/earthquake_history app/test/feature/earthquake_history app/lib/core/router`

- [ ] **Step 2: Run focused feature tests**

Run: `mise exec -- flutter test test/feature/earthquake_history/data test/feature/earthquake_history/ui`

- [ ] **Step 3: Run analyzer**

Run from repository root: `mise exec -- dart run melos run analyze`

- [ ] **Step 4: Run workspace tests**

Run from repository root: `mise exec -- dart run melos run test`

- [ ] **Step 5: Audit the diff against every design requirement**

Run: `git --no-pager diff origin/develop...HEAD --stat`

Run: `git --no-pager diff --check origin/develop...HEAD`

Confirm eligibility, exact `originTime`, all-page completeness, no partial counts, bounds, category total, controls, map, chart, list, realtime, stale cache, accessibility, and scope note have direct test evidence.

- [ ] **Step 6: Commit generated or verification fixes**

```bash
git add app docs/superpowers
git commit -m "test: 周辺地震活動の回帰検証を追加"
```

### Task 9: Publish PR and run Deploy App workflow

**Files:** None unless CI reveals a defect.

- [ ] **Step 1: Push the `codex/earthquake-surrounding-activity` branch**

Run: `git push -u origin codex/earthquake-surrounding-activity`

- [ ] **Step 2: Create a ready PR against `develop`**

Title: `feat: 周辺の地震活動画面を追加`

Body must summarize UI, exact filtering/pagination, realtime refresh, tests, data-coverage limitation, and include the design/plan paths.

- [ ] **Step 3: Wait for required PR checks and fix failures**

Run: `gh pr checks --watch`

- [ ] **Step 4: Dispatch `deploy-app.yaml` for the PR branch**

Run: `gh workflow run deploy-app.yaml --ref codex/earthquake-surrounding-activity -f ios=true -f android=true -f external=false`

- [ ] **Step 5: Verify the workflow run reaches a terminal successful state**

Run: `gh run list --workflow deploy-app.yaml --branch codex/earthquake-surrounding-activity --limit 1`

Run: `gh run watch <run-id> --exit-status`
