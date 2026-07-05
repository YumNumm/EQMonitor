# 地震履歴機能 全面修正 + 機能追加 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴機能のリファクタ回帰バグ(地域フィルタ無反応・City検索例外・リアルタイム反映停止・フィルタ未転送)を修正し、データ層が対応済みの未露出機能(4種地域ピッカー・震央フィルタ・マップ表示モード)を実装する。

**Architecture:** 既存の Riverpod + Freezed + paging_view 構成を維持。データ層(`earthquake_history_data_source.dart`)→ repository の転送修正、UI層(persistent delegate / chips)の欠落分岐復旧、Home シートの data_source 統合によるレガシー notifier 削除。

**Tech Stack:** Flutter 3.44 / Dart 3.11, Riverpod (code-gen), Freezed, paging_view, MapLibre, SharedPreferences

**Spec:** `docs/superpowers/specs/2026-07-05-earthquake-history-fixes-design.md`

## Global Constraints

- `dart analyze` 警告ゼロ(CLAUDE.md)。`dart format` 済みでコミット。
- Freezed/Riverpod 注釈変更後は `melos run generate`(または対象パッケージで `dart run build_runner build --delete-conflicting-outputs`)を実行し、生成ファイルをコミットに含める。
- コミットは develop へ直接。backend サブモジュールポインタに触れない。
- クロスパッケージ import は package import(相対不可)。
- UI 文言は日本語。既存の designSystem / チップのスタイルパターンを踏襲。
- テストは `app/test/feature/earthquake_history/` 配下。既存テストの mock パターン(`earthquake_history_statuses_test.dart` 等)を先に読んで踏襲する。
- 既存の挙動で仕様と明記のないものを変えない(例: All スコープのみ realtime 反映、は仕様として維持)。

---

### Task 1: データ層 `_fetch` の修正(City検索 + フィルタ転送)

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart:127-233`(`_fetch`)
- Test: `app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart`(新規)

**Interfaces:**
- Consumes: `EarthquakeHistoryRepository.searchByCity({required String code, ...})`(実装済み・現状未使用)、各 search 系の `statuses` 引数、`fetchEarthquakeList` の `statuses`/`datasource`/`telegramTypes`/`latitudeGte`/`latitudeLte`/`longitudeGte`/`longitudeLte` 引数(すべて実装済み)
- Produces: `_fetch` が全パラメータ型で正しい repository メソッドに正しい引数を渡すこと(後続タスクの前提)

- [ ] **Step 1: 失敗するテストを書く**

`EarthquakeHistoryRepository` をモックし(既存テストの mock 手法を踏襲。mocktail が依存にあればそれを使用、なければ手書き Fake)、以下を検証する:

```dart
// earthquake_history_data_source_fetch_test.dart の検証項目
// 1. EarthquakeHistoryParameterCity(cityCode: '4720100', ...) で
//    load(Refresh) → repository.searchByCity が code: '4720100' で呼ばれる
//    (searchByRegion は呼ばれない)
// 2. EarthquakeHistoryParameterAll(statuses: [TelegramStatus.correction], datasource: ...,
//    telegramTypes: [...], latitudeGte: 30, longitudeLte: 145, ...) で
//    fetchEarthquakeList に statuses/datasource/telegramTypes/latitudeGte/latitudeLte/
//    longitudeGte/longitudeLte がそのまま渡る
// 3. EarthquakeHistoryParameterPrefecture(statuses: [...]) で searchByPrefecture に statuses が渡る
//    (region/station も同様のケースを1つずつ)
```

`EarthquakeHistoryDataSource` を直接 new して `load(Refresh())` を await する(プロバイダ経由不要)。

- [ ] **Step 2: テスト実行して失敗を確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart`
Expected: FAIL(searchByCity が呼ばれない / statuses が null)

- [ ] **Step 3: `_fetch` を修正**

```dart
// EarthquakeHistoryParameterAll 分岐: 以下を追加
        statuses: parameter.statuses,
        datasource: parameter.datasource,
        telegramTypes: parameter.telegramTypes,
        latitudeGte: parameter.latitudeGte,
        latitudeLte: parameter.latitudeLte,
        longitudeGte: parameter.longitudeGte,
        longitudeLte: parameter.longitudeLte,

// EarthquakeHistoryParameterCity 分岐: searchByRegion → searchByCity に変更
      EarthquakeHistoryParameterCity(:final String cityCode) =>
        _repository.searchByCity(
          code: cityCode,
          ...

// Region/Prefecture/City/Station の4分岐すべてに追加:
          statuses: parameter.statuses,
```

- [ ] **Step 4: テスト実行して成功を確認**

Run: 同上
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart app/test/feature/earthquake_history/earthquake_history_data_source_fetch_test.dart
git commit -m "fix(earthquake_history): City検索の誤エンドポイントとフィルタ未転送を修正"
```

---

### Task 2: 既定ソート降順化と upsert のソート順対応

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart:36-42`(既定パラメータ)
- Modify: `app/lib/feature/home/data/provider/home_earthquake_history_parameter_provider.dart`(`.asc` → `.desc`。ファイル内の全生成箇所)
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart:235-252`(`upsertItems`)
- Test: `app/test/feature/earthquake_history/earthquake_history_upsert_test.dart`(新規)

**Interfaces:**
- Consumes: `GroupedDataSource` の `notifier.values` / `insertItem(int index, T item)` / `updateItem(int index, ...)`(paging_view)
- Produces: `upsertItems(List<EarthquakePartial>)` — sortBy == .eventId なら asc/desc 両対応で正しい位置に挿入。sortBy がそれ以外なら従来どおり no-op。

注: `rg "sortOrder: \.asc|SortOrder\.asc" app/lib` で既定生成箇所を洗い出し、**ユーザーが明示選択した値を保存する経路以外の「既定値」をすべて `.desc` に**変更すること。

- [ ] **Step 1: 失敗するテストを書く**

```dart
// earthquake_history_upsert_test.dart の検証項目
// eventId 降順 (desc) のデータソースに:
//   1. 既存より新しい eventId を upsert → index 0 に挿入される
//   2. 既存と同じ eventId を upsert → その位置で置換される
// eventId 昇順 (asc) のデータソースに:
//   3. 既存より新しい eventId を upsert → 末尾に挿入される
// sortBy: .magnitude の場合:
//   4. upsert しても items が変化しない (no-op)
```

- [ ] **Step 2: テスト実行して失敗を確認**

Run: `cd app && flutter test test/feature/earthquake_history/earthquake_history_upsert_test.dart`
Expected: FAIL(asc で早期 return され items 不変)

- [ ] **Step 3: `upsertItems` を実装**

```dart
  void upsertItems(List<EarthquakePartial> newItems) {
    if (_parameter.sortBy != .eventId) {
      // eventId 以外のソートでは挿入位置が確定できないため反映しない
      return;
    }
    final isDesc = _parameter.sortOrder == .desc;
    for (final item in newItems) {
      final currentItems = [...notifier.values];
      final index = currentItems.indexWhere(
        (e) => e.earthquake.eventId == item.earthquake.eventId,
      );
      if (index != -1) {
        updateItem(index, (_) => item);
        continue;
      }
      // eventId 比較で挿入位置を決める(desc: 大きい順 / asc: 小さい順)
      final insertAt = currentItems.indexWhere(
        (e) => isDesc
            ? e.earthquake.eventId.compareTo(item.earthquake.eventId) < 0
            : e.earthquake.eventId.compareTo(item.earthquake.eventId) > 0,
      );
      insertItem(insertAt == -1 ? currentItems.length : insertAt, item);
    }
  }
```

既定パラメータの変更(2ファイル): `sortOrder: .asc` → `sortOrder: .desc`。

- [ ] **Step 4: テスト実行して成功を確認 + 既存テストの回帰確認**

Run: `cd app && flutter test test/feature/earthquake_history/`
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git commit -m "fix(earthquake_history): 既定ソートを新しい順に修正しupsertをソート順対応に"
```

---

### Task 3: 地域名解決ヘルパー

**Files:**
- Create: `app/lib/feature/earthquake_history/data/provider/region_name_resolver.dart`
- Test: `app/test/feature/earthquake_history/region_name_resolver_test.dart`(新規)

**Interfaces:**
- Consumes: `jmaParameterProvider`(`app/lib/feature/parameter/...`)の `earthquake`(`EarthquakeParameter`: prefectures → regions → cities → stations 階層)
- Produces:
  ```dart
  /// 純粋関数。見つからなければ null。
  String? resolveRegionName({
    required EarthquakeParameter parameter,
    required RegionSearchType searchType,
    required String code,
  });

  /// AsyncValue でラップした riverpod プロバイダ(UI用)
  @riverpod
  Future<String?> regionName(Ref ref, RegionSearchType searchType, String code);
  ```
  名称は `LocalizedName` を持つ場合 `.ja`(既存コードの表示慣行に合わせる。`CitySelector` が name をどう表示しているか確認して同じフィールドを使う)。

- [ ] **Step 1: 失敗するテストを書く**

```dart
// region_name_resolver_test.dart
// 手組みの EarthquakeParameter(1都道府県→1地域→1市→1観測点)を用意し:
// 1. prefecture コードで都道府県名が引ける
// 2. region コードで細分化地域名が引ける
// 3. city コードで市区町村名が引ける
// 4. station コードで観測点名が引ける
// 5. 存在しないコードで null
```

- [ ] **Step 2: テスト実行して失敗を確認**

Run: `cd app && flutter test test/feature/earthquake_history/region_name_resolver_test.dart`
Expected: FAIL(関数未定義でコンパイルエラー)

- [ ] **Step 3: 実装**

```dart
String? resolveRegionName({
  required EarthquakeParameter parameter,
  required RegionSearchType searchType,
  required String code,
}) {
  switch (searchType) {
    case RegionSearchType.prefecture:
      return parameter.prefectures
          .firstWhereOrNull((p) => p.code == code)?.name; // 実フィールド名に合わせる
    case RegionSearchType.region:
      return parameter.prefectures
          .expand((p) => p.regions)
          .firstWhereOrNull((r) => r.code == code)?.name;
    case RegionSearchType.city:
      return parameter.prefectures
          .expand((p) => p.regions)
          .expand((r) => r.cities)
          .firstWhereOrNull((c) => c.code == code)?.name;
    case RegionSearchType.station:
      return parameter.prefectures
          .expand((p) => p.regions)
          .expand((r) => r.cities)
          .expand((c) => c.stations)
          .firstWhereOrNull((s) => s.code == code)?.name;
  }
}
```

(`name` の実型は `EarthquakeParameter*Item` の定義を読んで合わせる。`LocalizedName` なら `.ja` を返す。)
プロバイダは `jmaParameterProvider.future` を await して純粋関数に委譲。riverpod 生成後 `melos run generate`。

- [ ] **Step 4: テスト成功を確認**、**Step 5: コミット**

```bash
git commit -m "feat(earthquake_history): 地域コードから名称を解決するヘルパーを追加"
```

---

### Task 4: 地域フィルタの復旧とチップ表示制御

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart`(chips 構築全体: 64-295 付近)
- Create: `app/lib/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart`(パラメータ再構築の純粋ロジック)
- Test: `app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart`(新規)

**Interfaces:**
- Consumes: `RegionIntensityResult`(`({RegionSearchType searchType, String code, String name, JmaIntensity? intensityGte, JmaIntensity? intensityLte})`)、Task 3 の `regionNameProvider`
- Produces:
  ```dart
  extension EarthquakeHistoryParameterX on EarthquakeHistoryParameter {
    /// 地域選択結果を反映した新パラメータ(共通フィルタは引き継ぐ)
    EarthquakeHistoryParameter withRegion(RegionIntensityResult result);
    /// 地域指定を外して All に戻す(共通フィルタは引き継ぐ)
    EarthquakeHistoryParameterAll toAll();
    /// 現在の地域コード/種別(All なら null)
    (RegionSearchType, String)? get regionSelection;
  }
  ```

- [ ] **Step 1: 失敗するテストを書く**

```dart
// earthquake_history_parameter_x_test.dart
// 1. All(magnitudeGte: 5, statuses: [...]) .withRegion(prefecture '32', 震度3〜5弱)
//    → EarthquakeHistoryParameterPrefecture(prefectureCode: '32',
//       intensityGte: three, intensityLte: fiveLower, magnitudeGte: 5, statuses 引き継ぎ,
//       sortBy: .eventId, sortOrder: 元の sortOrder)
// 2. searchType ごと(region/city/station)に正しい sealed 型になる
// 3. Prefecture(...).withRegion(city ...) → City に切り替わり共通フィルタ引き継ぎ
// 4. Prefecture(...).toAll() → All、共通フィルタ引き継ぎ、intensityGte/Lte は破棄しない(引き継ぐ)
// 5. withRegion 時 sortBy は .eventId に強制される(地域系APIは eventId ソートのみ)
```

- [ ] **Step 2: 失敗を確認**(コンパイルエラー)

- [ ] **Step 3: extension を実装**

`withRegion` は `switch (result.searchType)` で各 factory を呼ぶ。共通フィルタ(magnitude/depth/originTime/lpgm/statuses/earthquakeType/epicenterCodes/datasource/telegramTypes/latlng)は現パラメータから引き継ぎ、`intensityGte/Lte` は `result` の値で上書き、`sortBy: .eventId`、`sortOrder` は現値を維持。`toAll` は既存の delegate 内の null 分岐のコピー相当をロジックとして移設。

- [ ] **Step 4: delegate を修正**

1. `RegionIntensityFilterChip` の `onChanged`:
   ```dart
   onChanged: (result) {
     onChanged(result == null ? parameter.toAll() : parameter.withRegion(result));
   },
   ```
2. チップに `regionName` を渡す: delegate を `ConsumerWidget` 系にし(すでに ref が取れる構造ならそのまま)、`regionSelection` が非 null のとき `ref.watch(regionNameProvider(type, code))` の値を渡す(ロード中/失敗時はコードをそのまま渡す)。
3. 地域絞り込み中(`parameter is! EarthquakeHistoryParameterAll`)は `DatasourceFilterChip` / `TelegramTypeFilterChip` / `LatLngFilterChip` の3エントリを chips 配列に**含めない**。
4. ソートチップ: 地域絞り込み中は `SortFilterChip` に代えて並び順のみのトグル(`sortBy` 固定表示 + `sortOrder` 切替)。実装は `SortFilterChip` に `bool sortByLocked` パラメータを追加し、モーダル内の `RadioGroup<EarthquakeSortBy>` を `sortByLocked` のとき非表示にするのが最小差分。

- [ ] **Step 5: テスト + 手動確認**

Run: `cd app && flutter test test/feature/earthquake_history/ && dart analyze --no-fatal-warnings lib/feature/earthquake_history lib/core/component/chip`
Expected: PASS / No issues

- [ ] **Step 6: コミット**

```bash
git commit -m "fix(earthquake_history): 地域フィルタ選択が反映されない問題を修正しAPI非対応チップを制御"
```

---

### Task 5: 一覧タイルの地域名表示(TODO解消)

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart:129-165`(`_AreaIntensityChip` 周辺)

**Interfaces:**
- Consumes: Task 3 の `regionNameProvider` / Task 4 の `regionSelection`

- [ ] **Step 1: 実装**

`// TOOD(YumNumm):` コメントを削除し、`searchParameter` から `regionSelection` を取り、`ref.watch(regionNameProvider(type, code))` で名称解決。`AsyncData` で名称、それ以外(ロード中/エラー/null)はコードをフォールバック表示。タイルが `ConsumerWidget` でなければ該当チップ部分だけ Consumer でラップ。

- [ ] **Step 2: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib/feature/earthquake_history && flutter test test/feature/earthquake_history/`
(このタイルの既存テスト `debug_earthquake_history_list_tile_page` はデバッグ画面。既存テストが通ることを確認)

```bash
git commit -m "fix(earthquake_history): 一覧の地域震度チップに地域名を表示"
```

---

### Task 6: 推計震度カードの注意文言表示

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/estimated_intensity_notice_dialog.dart`(本文を新ウィジェットに委譲)
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_intensity_card.dart:73-79`(Placeholder 置換)

**Interfaces:**
- Produces: `class EstimatedIntensityNoticeContent extends StatelessWidget`(引数なし。箇条書き注意文言 + 気象庁リンクを表示。文言はダイアログから**そのまま移設**、変更しない)

- [ ] **Step 1: 文言・`_BulletText`・リンク処理をダイアログから `EstimatedIntensityNoticeContent` に移設**(ダイアログは `content: EstimatedIntensityNoticeContent()` に)
- [ ] **Step 2: `earthquake_intensity_card.dart` の `.estimated` 分岐を置換**

```dart
.estimated => const Padding(
  padding: EdgeInsets.symmetric(vertical: 8),
  child: EstimatedIntensityNoticeContent(),
),
```

- [ ] **Step 3: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib/feature/earthquake_history`

```bash
git commit -m "fix(earthquake_history): 推計震度モードのPlaceholderを注意文言表示に置換"
```

---

### Task 7: 震源レイヤーのアイコン再登録ガード

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart:47-114`

- [ ] **Step 1: 画像登録を分離**

`addImageFromAssets(id: _iconId, ...)` を専用の `useEffect`(依存: style/controller のみ。earthquake/displayMode/parameter に依存しない)に移す。他レイヤー(`earthquake_history_station_intensity_layer.dart` 等)の画像登録の扱いを読み、同じパターン(登録済みチェック or try-catch を画像登録のみに分離)に合わせる。layer/source の再構築 useEffect は画像登録の完了に依存させる(既存の `useMapOperationQueue` パターンがあればそれで直列化)。

- [ ] **Step 2: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib/feature/earthquake_history`

```bash
git commit -m "fix(earthquake_history): 震源アイコンの重複登録でマーカーが消えうる問題を修正"
```

---

### Task 8: Home シートの data_source 統合とレガシー削除

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`(読み込み済みアイテムの公開)
- Modify: `app/lib/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart:100-130`
- Delete: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart` + `.g.dart`
- Test: 既存の `app/test/feature/earthquake_history/` でレガシー notifier を参照するテストがあれば data_source ベースに書き換え(`rg "earthquakeHistoryProvider|EarthquakeHistoryNotifier" app/test`)

**Interfaces:**
- Produces: `EarthquakeHistoryDataSource` にロード済みアイテムを公開する読み取り口。paging_view の `GroupedDataSource` は内部に `notifier`(値リスト)を持つ — 公開APIを確認し、`List<EarthquakePartial> get items => notifier.values.toList()` のような getter と、変更通知(`notifier` が `Listenable`/`ValueListenable` なら `Listenable get itemsListenable`)を公開する。
- Consumes: Home シートは `earthquakeHistoryDataSourceProvider(param)` を watch(`AsyncValue<EarthquakeHistoryDataSource>`)。

- [ ] **Step 1: paging_view の `GroupedDataSource`/`DataSource` の公開APIを確認**(`~/.pub-cache` または paging_view パッケージソース)。items 取得と変更購読の正攻法を特定する。
- [ ] **Step 2: `EarthquakeHistoryDataSource` に items 公開を追加**(Step 1 の正攻法で。独自 getter が不要なら追加しない)
- [ ] **Step 3: Home シートを移行**

`ref.watch(earthquakeHistoryProvider(param))` → `ref.watch(earthquakeHistoryDataSourceProvider(param))`。`AsyncData` のとき data_source の items 先頭から現行と同じ件数を `HomeEarthquakeList(earthquakes: ...)` に渡す。items の変更で再描画されるよう `ListenableBuilder`(または `useListenable`)で購読。エラー時の再読み込みは `ref.invalidate(earthquakeHistoryDataSourceProvider(param))` を維持。

- [ ] **Step 4: レガシー削除**

`earthquake_history_notifier.dart` / `.g.dart` を削除し、`rg "earthquakeHistoryProvider|EarthquakeHistoryNotifier" app/` が 0 件になることを確認。参照テストがあれば data_source ベースへ移行。

- [ ] **Step 5: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib && flutter test test/feature/earthquake_history/`
Expected: No issues / PASS

```bash
git commit -m "refactor(earthquake_history): Homeシートをdata_sourceに統合しレガシーnotifierを削除"
```

---

### Task 9: 地域ピッカーの4種対応(細分化地域・観測点)

**Files:**
- Create: `app/lib/core/component/selector/region_selector.dart`
- Create: `app/lib/core/component/selector/station_selector.dart`
- Modify: `app/lib/core/component/chip/region_intensity_filter_chip.dart:120-260` 付近(ピッカーページの ChoiceChip 群とセレクタ切替)

**Interfaces:**
- Consumes: `parameterSetProvider` の `earthquake.prefectures`(→ `.regions` → `.cities` → `.stations`)。既存 `CitySelector`(`app/lib/core/component/selector/city_selector.dart`)の widget 構成・検索UI・onSelected シグネチャを踏襲。
- Produces:
  - `RegionSelector`: 細分化地域を選択し `(code, name)` を返す(CitySelector と同じコールバック型)
  - `StationSelector`: 観測点を選択し `(code, name)` を返す。観測点は数が多いため CitySelector 同様の検索フィールド必須
  - ピッカーページ: ChoiceChip「都道府県 / 細分化地域 / 市区町村 / 観測点」の4択。選択に応じて `PrefectureSelector` / `RegionSelector` / `CitySelector` / `StationSelector` を切替。戻り値 `RegionIntensityResult` の `searchType` に `.region` / `.station` が入る

- [ ] **Step 1: `CitySelector` を読み、同一パターンで `RegionSelector` / `StationSelector` を実装**(データ展開階層だけが異なる)
- [ ] **Step 2: ピッカーページの ChoiceChip を4択に拡張し、セレクタ切替の `switch` に2ケース追加**
- [ ] **Step 3: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib/core/component`
Expected: No issues(Task 4 の extension テストで `.region`/`.station` の sealed 変換は担保済み)

```bash
git commit -m "feat(earthquake_history): 地域ピッカーに細分化地域・観測点を追加"
```

---

### Task 10: 震央地名フィルタチップ

**Files:**
- Create: `app/lib/core/component/chip/epicenter_filter_chip.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_parameter_persistent_delegate.dart`(chips 配列に order 12 で追加)

**Interfaces:**
- Consumes: `parameterSetProvider` の `jmaCodeTable.codeTables.areaEpicenter`(`List<JmaCodeTableItem>`; `code` / `name` / `kana`)。パラメータ側は `List<int>? epicenterCodes`(コードの型変換: `JmaCodeTableItem.code` が String なら `int.parse`)。
- Produces:
  ```dart
  class EpicenterFilterChip extends ConsumerWidget {
    const EpicenterFilterChip({this.epicenterCodes, this.onChanged, super.key});
    final List<int>? epicenterCodes;
    final void Function(List<int>?)? onChanged;
  }
  ```
  タップでマルチ選択モーダル(検索フィールド + CheckboxListTile、`StatusFilterChip`/`TelegramTypeFilterChip` のモーダル構成を踏襲)。選択0件で確定 → `onChanged(null)`。チップラベル: 1件なら震央名、複数なら「震央名 他N」。onDeleted で `onChanged(null)`。

- [ ] **Step 1: 既存のマルチ選択チップ(`StatusFilterChip` 等)を読み、同一パターンで実装**
- [ ] **Step 2: delegate に追加**

```dart
(
  order: 12,
  isActive: parameter.epicenterCodes != null,
  chip: EpicenterFilterChip(
    epicenterCodes: parameter.epicenterCodes,
    onChanged: (codes) => onChanged(parameter.copyWith(epicenterCodes: codes)),
  ),
),
```

(全スコープ表示: `epicenterCodes` は全APIが対応済みのため非表示制御の対象外)

- [ ] **Step 3: 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib && flutter test test/feature/earthquake_history/`

```bash
git commit -m "feat(earthquake_history): 震央地名による絞り込みチップを追加"
```

---

### Task 11: マップ表示モード切替

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`(`EarthquakeHistoryMapConfig` 追加)
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart`(既存 build/save のままで型が通ることを確認)
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_details_map_layer_modal.dart`(切替UI追加)
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart:171-187`(設定値の配線)
- Test: `app/test/feature/earthquake_history/earthquake_history_config_test.dart`(新規: JSON round-trip)

**Interfaces:**
- Produces:
  ```dart
  @freezed
  abstract class EarthquakeHistoryMapConfig with _$EarthquakeHistoryMapConfig {
    const factory EarthquakeHistoryMapConfig({
      @Default(EarthquakeHistoryFillMode.auto) EarthquakeHistoryFillMode fillMode,
      @Default(StationDisplayMode.maxFocused) StationDisplayMode stationDisplayMode,
      @Default(HypocenterDisplayMode.zoomFade) HypocenterDisplayMode hypocenterDisplayMode,
    }) = _EarthquakeHistoryMapConfig;
    factory EarthquakeHistoryMapConfig.fromJson(Map<String, dynamic> json) => ...;
  }
  // EarthquakeHistoryConfig に追加:
  //   @Default(EarthquakeHistoryMapConfig()) EarthquakeHistoryMapConfig map,
  ```
  注意: 既存の永続化 JSON に `map` キーは無い → `@Default` 必須(fromJson 互換)。`EarthquakeHistoryConfig` の `list` は `required` のままにし、既存 JSON との互換を壊さない。

- [ ] **Step 1: 失敗するテストを書く**(JSON round-trip: `map` キー無しの旧 JSON から fromJson して既定値が入る / toJson→fromJson で値保持)
- [ ] **Step 2: モデル追加 + `melos run generate`**
- [ ] **Step 3: モーダルに切替UIを追加**

`earthquake_history_details_map_layer_modal.dart` に3つの選択列を追加(既存の現在地トグルの下)。各 enum に日本語ラベル拡張を追加:

```dart
// earthquake_history_config_model.dart に extension
extension EarthquakeHistoryFillModeX on EarthquakeHistoryFillMode {
  String get label => switch (this) {
    .none => '塗りつぶしなし',
    .auto => '自動',
    .region => '地域ごと',
    .city => '市区町村ごと',
  };
}
extension StationDisplayModeX on StationDisplayMode {
  String get label => switch (this) {
    .maxFocused => '最大震度を強調',
    .normal => '通常',
    .allMinimized => 'すべて縮小',
  };
}
extension HypocenterDisplayModeX on HypocenterDisplayMode {
  String get label => switch (this) {
    .zoomFade => 'ズームで自動調整',
    .alwaysOpaque => '常に表示',
    .belowStations => '観測点の下に表示',
  };
}
```

UI は `SegmentedButton` または `RadioListTile`(モーダル内の既存スタイルに合わせる)。変更時 `earthquakeHistoryConfigProvider` の notifier `save(config.copyWith.map(...))`。

- [ ] **Step 4: map_view への配線**

`earthquake_history_details_map_view.dart` で `ref.watch(earthquakeHistoryConfigProvider)` から `map` 設定を取り、`EarthquakeHistoryFillLayer(fillMode: ...)` / `EarthquakeHistoryStationIntensityLayer(stationDisplayMode: ...)` / hypocenter レイヤーの `displayMode` に渡す(各レイヤーのコンストラクタ引数名は実装を読んで合わせる)。設定変更が開いている地図に反映されること(レイヤー再構築の useEffect 依存に設定値を追加)。

- [ ] **Step 5: 検証 + コミット**

Run: `cd app && flutter test test/feature/earthquake_history/ && dart analyze --no-fatal-warnings lib/feature/earthquake_history`

```bash
git commit -m "feat(earthquake_history): マップ表示モード(塗り/観測点/震央)の切替設定を追加"
```

---

### Task 12: クリーンアップ

**Files:**
- Delete: `app/lib/feature/earthquake_history/data/model/earthquake_list_response.dart`(+ 生成ファイルがあれば)
- Modify: `app/lib/feature/settings/children/config/debug/earthquake_history/debug_earthquake_history_list_tile_page.dart:186-206`(未使用 `_searchAreaSamples` 削除)
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`(`designatedRegionSearchType` / `designatedRegionCode` / `designatedRegionName` の3フィールド削除 + `melos run generate`)
- Modify: `app/test/feature/earthquake_history/earthquake_history_statuses_test.dart:11`(未使用 import 削除。Task 8 で削除済みならスキップ)

- [ ] **Step 1: 各削除を実施し、`rg` で参照ゼロを確認**(`EarthquakeListResponse|toEarthquakeListResponse|_searchAreaSamples|designatedRegion` が app/ 内 0 件)
- [ ] **Step 2: `melos run generate` → 検証 + コミット**

Run: `cd app && dart analyze --no-fatal-warnings lib test && flutter test test/feature/earthquake_history/`

```bash
git commit -m "chore(earthquake_history): デッドコード(旧レスポンス型・デッド設定フィールド)を削除"
```

---

### Task 13: 全体検証

- [ ] **Step 1:** リポジトリルートで `melos run analyze` → 警告ゼロ(ベースコミット時点で存在した `home_configuration_model.dart` の `invalid_annotation_target` 警告6件は本作業のスコープ外・既知として扱う。それ以外がゼロであること)
- [ ] **Step 2:** `melos run test:flutter` → 全テスト PASS
- [ ] **Step 3:** `dart format --set-exit-if-changed app/lib/feature/earthquake_history app/lib/core/component app/test/feature/earthquake_history` で差分ゼロ(差分があれば format してコミット)
- [ ] **Step 4:** 最終コミット(未コミット差分があれば)

---

## Self-Review 済み事項

- 仕様カバレッジ: 設計書 A-1〜A-3(Task 1-2)、B-1〜B-5(Task 4-7 + Task 3 基盤)、C(Task 8)、D-1〜D-3(Task 9-11)、E(Task 8, 12)、F(各タスク内 + Task 13)。
- Task 4 は Task 3 に依存。Task 5 は Task 3/4 に依存。Task 9/10 は Task 4 の delegate 変更後が望ましい(コンフリクト回避のため直列実行)。
- 型整合: `RegionIntensityResult` は record 型(実定義確認済み)。sealed パラメータの factory シグネチャは実ファイルから転記。
