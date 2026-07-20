# 地震履歴詳細シート 近傍地震一覧 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細シートに、震源位置と深さによる近傍地震を最大5件表示し、探索範囲・並び順の変更と全件表示を可能にする。

**Architecture:** 検索条件を `NearbyEarthquakeQuery` に集約し、Riverpod family provider が既存 Repository の地震一覧 API を呼ぶ。UI は provider を監視するカードとして構成し、既存の `EarthquakeHistoryListTile`、探索パラメータシート、地震履歴一覧ルートを再利用する。

**Tech Stack:** Flutter、Dart、Riverpod code generation、Freezed、flutter_hooks、go_router、flutter_test。

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- `StatefulWidget`、`dynamic`、`Object`、null assertion (`!`) を新規利用しない。
- Widget に関数や getter を定義せず、ロジックは Data / Provider 層へ分離する。
- API エラーの例外文字列を UI に直接表示しない。
- 既存 API、ルート、Preferences キーは変更しない。
- 生成ファイルは `dart run build_runner build --delete-conflicting-outputs` で更新する。

---

### Task 1: 近傍地震検索条件と Provider

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/nearby_earthquake_query.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart`
- Generate: `app/lib/feature/earthquake_history/data/model/nearby_earthquake_query.freezed.dart`
- Generate: `app/lib/feature/earthquake_history/data/provider/nearby_earthquakes_provider.g.dart`
- Test: `app/test/feature/earthquake_history/data/nearby_earthquake_query_test.dart`
- Test: `app/test/feature/earthquake_history/data/nearby_earthquakes_provider_test.dart`

**Interfaces:**
- Consumes: `EarthquakeHistoryRepository.fetchEarthquakeList`、`NearbyEarthquakeParameter`、`EarthquakeSortBy`、`SortOrder`。
- Produces: `NearbyEarthquakeQuery`、`nearbyEarthquakesProvider(NearbyEarthquakeQuery query)` → `Future<List<EarthquakePartial>>`。

- [ ] **Step 1: 検索範囲の失敗テストを書く**

```dart
test('初期値は緯度経度±0.5度と深さ±50kmに変換される', () {
  const query = NearbyEarthquakeQuery(
    excludeEventId: 'current',
    latitude: 35,
    longitude: 139,
    depth: 40,
    parameter: NearbyEarthquakeParameter(),
    sortBy: EarthquakeSortBy.maxIntensity,
    sortOrder: SortOrder.desc,
  );
  expect(query.latitudeGte, 34.5);
  expect(query.latitudeLte, 35.5);
  expect(query.longitudeGte, 138.5);
  expect(query.longitudeLte, 139.5);
  expect(query.depthGte, 0);
  expect(query.depthLte, 90);
});
```

極域・日付変更線・深さ上限の clamp と `depth: null` も別テストにする。

- [ ] **Step 2: テストが未実装で失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/nearby_earthquake_query_test.dart`

Expected: `NearbyEarthquakeQuery` が存在しないため FAIL。

- [ ] **Step 3: 最小の query モデルと範囲 getter を実装する**

```dart
@freezed
abstract class NearbyEarthquakeQuery with _$NearbyEarthquakeQuery {
  const factory NearbyEarthquakeQuery({
    required String excludeEventId,
    required double latitude,
    required double longitude,
    required int? depth,
    required NearbyEarthquakeParameter parameter,
    required EarthquakeSortBy sortBy,
    required SortOrder sortOrder,
  }) = _NearbyEarthquakeQuery;
  const NearbyEarthquakeQuery._();
}
```

緯度 `[-90, 90]`、経度 `[-180, 180]`、深さ `[0, 2000]` の getter を追加する。

- [ ] **Step 4: query テストを通す**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/nearby_earthquake_query_test.dart`

Expected: PASS。

- [ ] **Step 5: Provider の失敗テストを書く**

Repository provider を override し、`limit: 6` と query の上下限・並び順が渡ること、自身を除外して最大5件になることを検証する。

- [ ] **Step 6: Provider テストが未実装で失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/nearby_earthquakes_provider_test.dart`

Expected: provider が存在しないため FAIL。

- [ ] **Step 7: Provider を実装して生成する**

```dart
@riverpod
Future<List<EarthquakePartial>> nearbyEarthquakes(
  Ref ref,
  NearbyEarthquakeQuery query,
) async {
  final repository = await ref.watch(earthquakeHistoryRepositoryProvider.future);
  final response = await repository.fetchEarthquakeList(
    limit: 6,
    latitudeGte: query.latitudeGte,
    latitudeLte: query.latitudeLte,
    longitudeGte: query.longitudeGte,
    longitudeLte: query.longitudeLte,
    depthGte: query.depthGte,
    depthLte: query.depthLte,
    sortBy: query.sortBy,
    sortOrder: query.sortOrder,
  );
  return response.items
      .where((item) => item.eventId != query.excludeEventId)
      .take(5)
      .toList();
}
```

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 8: Provider と query のテストを通す**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/nearby_earthquake_query_test.dart test/feature/earthquake_history/data/nearby_earthquakes_provider_test.dart`

Expected: PASS。

- [ ] **Step 9: Data 層をコミットする**

```bash
git add app/lib/feature/earthquake_history/data app/test/feature/earthquake_history/data
git commit -m 'feat: 近傍地震の検索条件と取得処理を追加'
```

### Task 2: 近傍地震カードと探索パラメータシート

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/nearby_earthquake_card.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/nearby_earthquake_parameter_sheet.dart`
- Test: `app/test/feature/earthquake_history/ui/components/nearby_earthquake_card_test.dart`
- Test: `app/test/feature/earthquake_history/ui/components/nearby_earthquake_parameter_sheet_test.dart`

**Interfaces:**
- Consumes: `nearbyEarthquakesProvider`、`EarthquakeHistoryListTile`、`EarthquakeHistoryRoute`、`EarthquakeHistoryDetailsRoute`。
- Produces: `NearbyEarthquakeCard({required Earthquake earthquake})`。

- [ ] **Step 1: カードの状態別表示の失敗テストを書く**

座標不明で非表示、loading で indicator、error で固定文言と再試行、空配列で空表示、6件相当の provider 結果でも最大5タイルを検証する。Provider は `overrideWith` し、実 API は呼ばない。

- [ ] **Step 2: カードテストが未実装で失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/components/nearby_earthquake_card_test.dart`

Expected: `NearbyEarthquakeCard` が存在しないため FAIL。

- [ ] **Step 3: カードを private Widget 群で実装する**

`HookConsumerWidget` の state は `NearbyEarthquakeParameter`、`EarthquakeSortBy.maxIntensity`、`SortOrder.desc` の3つに限定する。結果一覧は `ListView.separated(shrinkWrap: true, physics: NeverScrollableScrollPhysics())` を使う。ハンドラは inline closure とし、Widget メソッドを作らない。

- [ ] **Step 4: カードテストを通す**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/components/nearby_earthquake_card_test.dart`

Expected: PASS。

- [ ] **Step 5: パラメータシートの失敗テストを書く**

初期値の表示、深さ不明時の深さスライダー非表示、「適用」で `NearbyEarthquakeParameter` を返すことを検証する。

- [ ] **Step 6: 現行 StatefulWidget に対するテスト結果を確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/components/nearby_earthquake_parameter_sheet_test.dart`

Expected: 挙動テストは PASS。これは HookWidget 化前の characterization test とする。

- [ ] **Step 7: シートを HookWidget へ置き換える**

3つの値を `useState` で保持し、既存の表示文言・範囲・戻り値を変えない。

- [ ] **Step 8: UI テストを再実行する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/components/nearby_earthquake_card_test.dart test/feature/earthquake_history/ui/components/nearby_earthquake_parameter_sheet_test.dart`

Expected: PASS。

- [ ] **Step 9: UI をコミットする**

```bash
git add app/lib/feature/earthquake_history/ui/components app/test/feature/earthquake_history/ui/components
git commit -m 'feat: 近傍地震カードを追加'
```

### Task 3: 詳細シート統合と最終検証

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`
- Modify: `app/test/feature/earthquake_history/ui/earthquake_details_source_toggle_widget_test.dart`

**Interfaces:**
- Consumes: `NearbyEarthquakeCard`。
- Produces: 詳細シートから近傍地震一覧へ到達できる統合済み UI。

- [ ] **Step 1: 詳細シート統合の失敗テストを書く**

既存詳細画面テストの provider override に近傍地震 provider を加え、座標ありの地震で「この震源の近傍で発生した地震」が表示されることを検証する。

- [ ] **Step 2: 統合前に失敗することを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/earthquake_details_source_toggle_widget_test.dart`

Expected: 近傍地震見出しが見つからず FAIL。

- [ ] **Step 3: 詳細シートへカードを配置する**

`earthquake_history_details_page.dart` で `NearbyEarthquakeCard(earthquake: earthquake)` を広告の後、電文一覧ボタンの前へ追加する。

- [ ] **Step 4: 統合テストを通す**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/earthquake_details_source_toggle_widget_test.dart`

Expected: PASS。

- [ ] **Step 5: format、analyze、関連テストを実行する**

```bash
cd app
mise exec -- dart format lib/feature/earthquake_history test/feature/earthquake_history
mise exec -- flutter analyze lib/feature/earthquake_history test/feature/earthquake_history
mise exec -- flutter test test/feature/earthquake_history
```

Expected: analyze 0 issues、全テスト PASS。

- [ ] **Step 6: 差分検査と統合コミットを行う**

```bash
git diff --check
git add app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart app/test/feature/earthquake_history/ui/earthquake_details_source_toggle_widget_test.dart
git commit -m 'feat: 地震詳細に近傍地震一覧を表示'
```
