# Intensity History Area Detail Modal Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 震度履歴マップの都道府県・市区町村詳細モーダルを共通化し、`EarthquakeHistoryNotifier` で該当地域の地震一覧を表示する。

**Architecture:** `showPrefectureDetailModal` と `showCityDetailModal` は公開 API として分け、内部の bottom sheet・サマリ・一覧は `city_detail_modal.dart` 内の共通 private Widget に集約する。一覧取得は `EarthquakeHistoryParameter.prefecture/city` と `earthquakeHistoryProvider(parameter)` を使い、追加読み込みは `EarthquakeHistoryNotifier.fetchNextData()` に委譲する。

**Tech Stack:** Flutter, Dart, Riverpod 3 generator providers, go_router_builder, existing `EarthquakeHistoryNotifier`, existing `EarthquakeHistoryListTile`, `flutter_test`.

## Global Constraints

- 常に日本語で答える。
- Flutter / Dart に関するコマンドは常に `mise exec --` 経由で実行する。
- 固定値・ランダム値で生命に関わる情報を補完しない。
- `dynamic`、`Object` 型は `Map<String, dynamic>` 以外で使わない。
- Null assertion operator `!` は新規コードで使わない。
- Widget に関数やゲッターを定義しない。
- クラス内のプライベートメソッドは追加しない。
- リスト表示には `ListView.builder` または `SliverList` を使用する。
- テキストを含む要素に固定の高さを数値指定しない。
- `print()` は使わない。
- 2つ以上の引数を持つ関数・クラスは名前付き引数を使う。
- 既存の unrelated dirty changes は戻さない。
- コミットメッセージは英語1単語の prefix と日本語の短い説明にする。

---

## File Structure

- Modify `app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`
  - `showPrefectureDetailModal` を追加する。
  - `showCityDetailModal` を既存呼び出し互換のまま残す。
  - 内部を `_AreaDetailModal`, `_AreaDetailSummarySection`, `_AreaEarthquakeListSection`, `_AreaDetailType` に分ける。
  - `earthquakeHistoryProvider(parameter)` の `AsyncValue<PaginatedResponse<EarthquakePartial>>` を表示する。
- Modify `app/lib/feature/intensity_history/ui/components/region_floating_panel.dart`
  - 都道府県タップ時に `UnimplementedError` を投げず `showPrefectureDetailModal` を呼ぶ。
  - コンパクトな見た目は維持し、詳細表示可能な tappable affordance を追加する。
- Modify `app/test/feature/intensity_history/city_detail_modal_test.dart`
  - 市区町村モーダルの未実装 placeholder 消滅、一覧、都道府県モーダル、空、エラー、追加読み込みを検証する。
- Modify `app/test/feature/intensity_history/region_floating_panel_test.dart`
  - 都道府県フォーカス中にパネルタップでモーダルが開くことを検証する。

---

### Task 1: 地域詳細モーダルを共通化して Notifier 一覧を表示する

**Files:**
- Modify: `app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`
- Test: `app/test/feature/intensity_history/city_detail_modal_test.dart`

**Interfaces:**
- Consumes: `earthquakeHistoryProvider(EarthquakeHistoryParameter)`, `EarthquakeHistoryNotifier.fetchNextData()`, `EarthquakeHistoryListTile`, `EarthquakeHistoryDetailsRoute`.
- Produces:
  - `Future<void> showPrefectureDetailModal(BuildContext context, {required String prefectureCode, required String prefectureName, HighestIntensityEntry? summary})`
  - Existing `Future<void> showCityDetailModal(BuildContext context, {required String cityCode, required String cityName, required String regionName, HighestIntensityEntry? summary})`

- [ ] **Step 1: Write the failing tests**

Add these imports to `city_detail_modal_test.dart`:

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
```

Add these test helpers:

```dart
class _FakeEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return PaginatedResponse(
      items: [_earthquakePartialForList(parameter)],
      nextToken: null,
    );
  }
}

class _EmptyEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return const PaginatedResponse(items: [], nextToken: null);
  }
}

class _ErrorEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    throw Exception('network failed');
  }
}

class _PagedEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    return PaginatedResponse(
      items: [_earthquakePartialForList(parameter)],
      nextToken: 'next-token',
    );
  }
}

EarthquakePartial _earthquakePartialForList(
  EarthquakeHistoryParameter parameter,
) {
  final earthquake = EarthquakePartialNormal(
    eventId: '20240101000000',
    status: TelegramStatus.normal,
    originTime: DateTime(2024, 1, 1, 16, 10),
    originTimePrecision: OriginTimePrecision.minute,
    arrivalTime: DateTime(2024, 1, 1, 16, 11),
    dataSources: const [EarthquakeDataSource.jma],
    hypocenter: const EarthquakeHypocenter(
      code: '123',
      name: '能登半島沖',
      coordinates: null,
      magnitude: EarthquakeMagnitude.value(value: 7.6),
      depth: EarthquakeDepth.shallow(),
      detailedCode: null,
      detailedName: null,
    ),
    intensity: const EarthquakeIntensityPartial(
      maxIntensity: JmaIntensity.seven,
      maxLpgmIntensity: null,
    ),
    earthquakeType: EarthquakeType.normal,
    telegramTypes: const [EarthquakeTelegramType.vxse53],
    estimatedIntensityTileUrl: null,
  );
  return switch (parameter) {
    EarthquakeHistoryParameterPrefecture() => EarthquakePartialPrefecture(
      prefectureIntensity: JmaIntensity.sixLower,
      earthquake: earthquake,
    ),
    EarthquakeHistoryParameterCity() => EarthquakePartialRegion(
      regionIntensity: JmaIntensity.fiveUpper,
      earthquake: earthquake,
    ),
    _ => earthquake,
  };
}

typedef _OpenModal = void Function(BuildContext context);

Widget _modalTestApp({required _OpenModal onPressed}) {
  return MaterialApp(
    theme: ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[
        DesignSystemThemeExtension.light(),
      ],
    ),
    home: Scaffold(
      body: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => onPressed(context),
          child: const Text('open'),
        ),
      ),
    ),
  );
}
```

Add these tests:

```dart
testWidgets('市区町村モーダルで地震一覧が表示される', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.city(
            cityCode: '1720400',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
      ],
      child: _modalTestApp(
        onPressed: (context) => showCityDetailModal(
          context,
          cityCode: '1720400',
          cityName: '輪島市',
          regionName: '石川県',
        ),
      ),
    ),
  );

  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.text('輪島市'), findsOneWidget);
  expect(find.text('石川県'), findsOneWidget);
  expect(find.text('観測した地震'), findsOneWidget);
  expect(find.text('能登半島沖'), findsOneWidget);
  expect(find.textContaining('未実装'), findsNothing);
}

testWidgets('都道府県モーダルで地震一覧が表示される', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.prefecture(
            prefectureCode: '1700',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
      ],
      child: _modalTestApp(
        onPressed: (context) => showPrefectureDetailModal(
          context,
          prefectureCode: '1700',
          prefectureName: '石川県',
        ),
      ),
    ),
  );

  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.text('石川県'), findsOneWidget);
  expect(find.text('観測した地震'), findsOneWidget);
  expect(find.text('能登半島沖'), findsOneWidget);
}

testWidgets('地震一覧が空の場合は空表示になる', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.city(
            cityCode: '1720400',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_EmptyEarthquakeHistoryNotifier.new),
      ],
      child: _modalTestApp(
        onPressed: (context) => showCityDetailModal(
          context,
          cityCode: '1720400',
          cityName: '輪島市',
          regionName: '石川県',
        ),
      ),
    ),
  );

  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.text('この地域で観測された地震はありません'), findsOneWidget);
});

testWidgets('地震一覧の取得に失敗した場合は再読み込み導線を表示する', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.city(
            cityCode: '1720400',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_ErrorEarthquakeHistoryNotifier.new),
      ],
      child: _modalTestApp(
        onPressed: (context) => showCityDetailModal(
          context,
          cityCode: '1720400',
          cityName: '輪島市',
          regionName: '石川県',
        ),
      ),
    ),
  );

  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.byType(ErrorCard), findsOneWidget);
});

testWidgets('続きがある場合はさらに読み込むボタンを表示する', (tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        earthquakeHistoryProvider(
          const EarthquakeHistoryParameter.city(
            cityCode: '1720400',
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ).overrideWith(_PagedEarthquakeHistoryNotifier.new),
      ],
      child: _modalTestApp(
        onPressed: (context) => showCityDetailModal(
          context,
          cityCode: '1720400',
          cityName: '輪島市',
          regionName: '石川県',
        ),
      ),
    ),
  );

  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();

  expect(find.text('さらに読み込む'), findsOneWidget);
});
```

- [ ] **Step 2: Run tests to verify RED**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/intensity_history/city_detail_modal_test.dart
```

Expected: FAIL because `showPrefectureDetailModal` is undefined, the old city modal still shows the placeholder instead of `能登半島沖`, and the empty/error/append UI does not exist.

- [ ] **Step 3: Implement the common modal**

In `city_detail_modal.dart`, add imports:

```dart
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
```

Add `_AreaDetailType`:

```dart
enum _AreaDetailType {
  prefecture(label: '都道府県'),
  city(label: '市区町村');

  const _AreaDetailType({required this.label});
  final String label;
}
```

Create `EarthquakeHistoryParameter` with exact sort values:

```dart
const sortBy = EarthquakeSortBy.eventId;
const sortOrder = SortOrder.desc;
```

City:

```dart
EarthquakeHistoryParameter.city(
  cityCode: cityCode,
  sortBy: sortBy,
  sortOrder: sortOrder,
)
```

Prefecture:

```dart
EarthquakeHistoryParameter.prefecture(
  prefectureCode: prefectureCode,
  sortBy: sortBy,
  sortOrder: sortOrder,
)
```

The modal body must be `DraggableScrollableSheet` plus `CustomScrollView`.
Use `SliverList.builder` for earthquake items.
For each item:

```dart
EarthquakeHistoryListTile(
  item: item,
  searchParameter: parameter,
  dense: true,
  visualDensity: VisualDensity.compact,
  showBackgroundColor: false,
  onTap: () async => EarthquakeHistoryDetailsRoute(
    eventId: item.earthquake.eventId,
  ).push<void>(context),
)
```

State behavior:

- `AsyncLoading` with no previous value: centered `CircularProgressIndicator.adaptive`.
- `AsyncError` with no previous value: `ErrorCard(error: error, onReload: () async => ref.invalidate(earthquakeHistoryProvider(parameter)))`.
- `AsyncData` with empty `items`: show `この地域で観測された地震はありません`.
- `nextToken != null`: show `OutlinedButton.icon(icon: Icon(Icons.expand_more_rounded), label: Text('さらに読み込む'))` and call `fetchNextData()`.
- If `valueOrNull` exists while refreshing/reloading, keep showing existing items.

Summary rules:

- Put parent region text above the city name only when `parentAreaName != null`.
- Align title text left.
- Show `最高震度を観測した地震: ${entry.count}件` only when summary exists.
- If hypocenter name is null or empty, display `震源不明`.
- Do not display an empty `Text`.

- [ ] **Step 4: Run tests to verify GREEN**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/intensity_history/city_detail_modal_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

Run:

```bash
git add app/lib/feature/intensity_history/ui/components/city_detail_modal.dart app/test/feature/intensity_history/city_detail_modal_test.dart
git commit -m "feat: 地域詳細モーダルに地震一覧を表示"
```

---

### Task 2: フローティングパネルから都道府県詳細モーダルを開く

**Files:**
- Modify: `app/lib/feature/intensity_history/ui/components/region_floating_panel.dart`
- Test: `app/test/feature/intensity_history/region_floating_panel_test.dart`

**Interfaces:**
- Consumes: `showPrefectureDetailModal(BuildContext context, {required String prefectureCode, required String prefectureName, HighestIntensityEntry? summary})` from Task 1.
- Produces: `RegionFloatingPanel` no longer throws `UnimplementedError` on prefecture panel tap.

- [ ] **Step 1: Write the failing test**

Add these imports:

```dart
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_search_response.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart';
```

Add this fake notifier:

```dart
class _FakeEarthquakeHistoryNotifier extends EarthquakeHistoryNotifier {
  @override
  Future<PaginatedResponse<EarthquakePartial>> build(
    EarthquakeHistoryParameter parameter,
  ) async {
    final earthquake = EarthquakePartialNormal(
      eventId: '20240101000000',
      status: TelegramStatus.normal,
      originTime: DateTime(2024, 1, 1, 16, 10),
      originTimePrecision: OriginTimePrecision.minute,
      arrivalTime: DateTime(2024, 1, 1, 16, 11),
      dataSources: const [EarthquakeDataSource.jma],
      hypocenter: const EarthquakeHypocenter(
        code: '123',
        name: '能登半島沖',
        coordinates: null,
        magnitude: EarthquakeMagnitude.value(value: 7.6),
        depth: EarthquakeDepth.shallow(),
        detailedCode: null,
        detailedName: null,
      ),
      intensity: const EarthquakeIntensityPartial(
        maxIntensity: JmaIntensity.seven,
        maxLpgmIntensity: null,
      ),
      earthquakeType: EarthquakeType.normal,
      telegramTypes: const [EarthquakeTelegramType.vxse53],
      estimatedIntensityTileUrl: null,
    );
    return PaginatedResponse(
      items: [
        EarthquakePartialPrefecture(
          prefectureIntensity: JmaIntensity.sixLower,
          earthquake: earthquake,
        ),
      ],
      nextToken: null,
    );
  }
}
```

Add this test:

```dart
testWidgets('都道府県フォーカス状態でタップすると都道府県詳細モーダルが開く', (tester) async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      app_prefs.sharedPreferencesProvider.overrideWithValue(
        app_prefs.SharedPreferencesAsync(preferences),
      ),
      prefectureHighestProvider.overrideWith(_FakePrefectureHighest.new),
      earthquakeHistoryProvider(
        const EarthquakeHistoryParameter.prefecture(
          prefectureCode: '0400',
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
        ),
      ).overrideWith(_FakeEarthquakeHistoryNotifier.new),
    ],
  );
  addTearDown(container.dispose);

  container
      .read(intensityHistoryControllerProvider.notifier)
      .focusPrefecture(code: '0400', name: '宮城県');

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: const Scaffold(body: Center(child: RegionFloatingPanel())),
      ),
    ),
  );
  await tester.pumpAndSettle();

  await tester.tap(find.text('宮城県'));
  await tester.pumpAndSettle();

  expect(tester.takeException(), isNull);
  expect(find.text('観測した地震'), findsOneWidget);
  expect(find.text('能登半島沖'), findsOneWidget);
});
```

- [ ] **Step 2: Run test to verify RED**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/intensity_history/region_floating_panel_test.dart
```

Expected: FAIL because the tap throws the current `UnimplementedError` for the missing prefecture detail modal.

- [ ] **Step 3: Implement panel connection and light visual polish**

Modify `region_floating_panel.dart`:

- Replace the current `throw UnimplementedError` branch with:

```dart
await showPrefectureDetailModal(
  context,
  prefectureCode: prefectureCode,
  prefectureName: prefectureName,
  summary: prefectureEntry,
);
```

- Preserve the compact card, highest intensity icon, and count display.
- Add `Semantics(button: true, label: '$displayNameの詳細を表示', child: existingInkWell)` around the existing tappable area.

- [ ] **Step 4: Run test to verify GREEN**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/intensity_history/region_floating_panel_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

Run:

```bash
git add app/lib/feature/intensity_history/ui/components/region_floating_panel.dart app/test/feature/intensity_history/region_floating_panel_test.dart
git commit -m "fix: 都道府県詳細モーダルを開く"
```

---

### Task 3: 最終検証と整形

**Files:**
- Modify only files touched by Tasks 1-2 if formatting requires it.

**Interfaces:**
- Consumes: all completed implementation commits.
- Produces: formatted, analyzed, tested branch.

- [ ] **Step 1: Format edited Dart files**

Run:

```bash
mise exec -- dart format app/lib/feature/intensity_history/ui/components/city_detail_modal.dart app/lib/feature/intensity_history/ui/components/region_floating_panel.dart app/test/feature/intensity_history/city_detail_modal_test.dart app/test/feature/intensity_history/region_floating_panel_test.dart
```

- [ ] **Step 2: Run focused tests**

Run:

```bash
mise exec -- flutter test --no-pub app/test/feature/intensity_history/city_detail_modal_test.dart app/test/feature/intensity_history/region_floating_panel_test.dart
```

Expected: PASS.

- [ ] **Step 3: Run focused analyze**

Run:

```bash
mise exec -- flutter analyze --no-pub app/lib/feature/intensity_history/ui/components/city_detail_modal.dart app/lib/feature/intensity_history/ui/components/region_floating_panel.dart app/test/feature/intensity_history/city_detail_modal_test.dart app/test/feature/intensity_history/region_floating_panel_test.dart
```

Expected: no issues for the edited files.

- [ ] **Step 4: Check diff scope**

Run:

```bash
git --no-pager diff --stat origin/develop...HEAD
git --no-pager diff --name-only origin/develop...HEAD
```

Expected: changes are limited to the plan file, modal, floating panel, and their tests.

- [ ] **Step 5: Commit final formatting if needed**

If formatting or final polish changed files after Task 2, run:

```bash
git add app/lib/feature/intensity_history/ui/components/city_detail_modal.dart app/lib/feature/intensity_history/ui/components/region_floating_panel.dart app/test/feature/intensity_history/city_detail_modal_test.dart app/test/feature/intensity_history/region_floating_panel_test.dart
git commit -m "style: 地域詳細モーダル実装を整形"
```

If there are no changes, do not create an empty commit.
