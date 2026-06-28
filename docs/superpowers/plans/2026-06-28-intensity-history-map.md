# 地域別 最大震度マップ 実装プラン

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 過去の地域ごとの最高震度を地図で俯瞰し、都道府県→市区町村→詳細とドリルダウンできる画面を新設する。

**Architecture:** `app/lib/feature/intensity_history/` に `eew_history`/`earthquake_history` 構成を踏襲して新設。既存 `eqmonitor_map`(PMTiles ベクタタイル)に `FillStyleLayer` を動的追加し、`['match',['get','code'],...]` 式で震度色を塗る。状態は Riverpod Notifier で Lv1(都道府県)/Lv2(市区町村)を管理。

**Tech Stack:** Flutter / Riverpod (riverpod_annotation) / Flutter Hooks / Freezed / MapLibre (maplibre) / paging_view / eqmonitor_api(生成済み・再生成しない)。

設計書: `docs/superpowers/specs/2026-06-28-intensity-history-map-design.md`

## Global Constraints

- `dart analyze` 警告ゼロ(CI 必須)。`dart format` 準拠。
- import は package import を使用(相対 import 不可)。
- 生成ファイル(`*.g.dart` / `*.freezed.dart`)はコミットする。コード生成は `dart run build_runner build`(worktree 直下 or melos)。
- **`packages/eqmonitor_api` は再生成しない**(本機能は生成済みクライアントのみ利用)。
- API クライアント取得は `ref.watch(apiClientProvider.future)` → `apiClient.earthquake`。
- 色は `ref.watch(intensityColorProvider)`(`IntensityColorModel`)。`colorModel.fromJmaIntensity(jma).background.toHexStringRGB()` で `#RRGGBB`。
- PR ベースブランチは `develop`、リポジトリは `YumNumm/EQMonitor`。

参照すべき既存実装(パターン元):
- repository/provider: `app/lib/feature/eew_history/data/repository/eew_list_repository.dart`
- 動的 FillStyleLayer + match 式 + add/removeLayer: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_region_intensity_layer.dart`
- queryLayers タップ判定 + fitBounds: `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`
- ページネーション DataSource: `app/lib/feature/eew_history/data/notifier/eew_list_data_source.dart`
- モーダル: `app/lib/feature/earthquake_history/ui/components/earthquake_history_map_popup.dart`
- ルート: `app/lib/core/router/router.dart`(`@TypedGoRoute`)
- HomeSheet 導線: `app/lib/page/home_page.dart` の `_SheetBody`
- 都道府県/市区町村コード階層: `app/lib/core/component/selector/city_selector.dart`
- API モデル: `packages/eqmonitor_api/lib/src/models/highest_intensity_item.dart`(`{code,name,intensity,count,earthquake}`)

API シグネチャ(確定):
- `apiClient.earthquake.getV2EarthquakeIntensityPrefectureHighest()` → `HttpResponse<HighestIntensityResponse>`(`HighestIntensityResponse{ items: List<HighestIntensityItem> }`)
- `apiClient.earthquake.getV2EarthquakeIntensityPrefectureCodeCityHighest(code: ...)` → 同上
- `apiClient.earthquake.getV2EarthquakeIntensityCityCode(code:, limit:, cursor:, sortBy:, sortOrder:, ...)` → `HttpResponse<IntensityCitySearchResponse>`(`items: List<IntensityCitySearchItem>`, `nextToken`)

---

## Task 0(検証): 地図コードと API コードの対応を確認

**目的:** `prefecture/highest` の `code` が地図レイヤ `areaForecastLocalE` のフィーチャ `code` と一致するか(=Lv1 を直接 match 塗りできるか)を確定し、不一致なら都道府県→細分区域コード展開の要否を判断する。

**Files:**
- 調査のみ(コード変更なし)

- [ ] **Step 1:** `forecastLocalEIntensityPairs`(`app/lib/feature/earthquake_history/data/model/earthquake_intensity.dart:52`)と `jma_map.pb` 上の `areaForecastLocalE` フィーチャ `code` の実値、`areaInformationPrefectureEarthquake` コードテーブルの `code` を突き合わせる。`app/lib/core/provider/map/jma_map_provider.dart` の `areaForecastLocalE` getter からフィーチャ code を列挙して確認。
- [ ] **Step 2:** 結論を Task 3 の match 式構築方針に反映:
  - **一致する場合** → Lv1 は `prefecture/highest` の code をそのまま match。
  - **一致しない場合** → `earthquake.prefectures[].code`(都道府県) と `.regions[].code`(細分区域=`areaForecastLocalE`) の対応表を `parameterSetProvider` から構築し、都道府県 code → 配下の細分区域 code 群へ展開して match。
- [ ] **Step 3:** 判明した対応関係を `intensity_history` ディレクトリ内にコメント or 純粋関数(Task 2)として固定化。

---

## Task 1: API モデルラッパと repository

**Files:**
- Create: `app/lib/feature/intensity_history/data/model/highest_intensity_entry.dart`
- Create: `app/lib/feature/intensity_history/data/model/city_intensity_page.dart`
- Create: `app/lib/feature/intensity_history/data/repository/intensity_highest_repository.dart`
- Test: `app/test/feature/intensity_history/intensity_highest_repository_test.dart`

**Interfaces:**
- Produces:
  - `HighestIntensityEntry { String code; String name; JmaIntensity intensity; int count; EarthquakePartial earthquake }`(`api.JmaIntensity` をそのまま保持。app 側 enum 変換が必要なら `intensityColorProvider` が受け取る型に合わせる)
  - `CityIntensityPage { List<IntensityCitySearchItem> items; String? nextToken }`
  - `IntensityHighestRepository.fetchPrefectureHighest() → Future<List<HighestIntensityEntry>>`
  - `IntensityHighestRepository.fetchCityHighest(String prefectureCode) → Future<List<HighestIntensityEntry>>`
  - `IntensityHighestRepository.fetchCityIntensityList({required String cityCode, String? cursor, required int limit}) → Future<CityIntensityPage>`
  - `@Riverpod(keepAlive:true) Future<IntensityHighestRepository> intensityHighestRepository(Ref ref)`

- [ ] **Step 1: 失敗するテストを書く** — `intensity_highest_repository_test.dart`。`api.EarthquakeApiClient` を Fake 化し、`fetchPrefectureHighest()` が `HighestIntensityResponse.items` を `HighestIntensityEntry` に変換して返すこと、`fetchCityIntensityList` が `items`/`nextToken` を `CityIntensityPage` に詰めることを検証(`eew_list_data_source_test.dart` の Fake パターン踏襲)。
- [ ] **Step 2:** `dart test` で未定義により FAIL を確認。
- [ ] **Step 3: モデルを実装** — `highest_intensity_entry.dart`(Freezed)。`HighestIntensityItem` → `HighestIntensityEntry` の `factory HighestIntensityEntry.fromApi(api.HighestIntensityItem)` を定義。`city_intensity_page.dart`(Freezed)。
- [ ] **Step 4: repository を実装** — `eew_list_repository.dart` 同様、`ref.watch(apiClientProvider.future)` → `apiClient.earthquake` を受け取る。各メソッドで API を呼び `.data.items.map(...)` で変換。`fetchCityIntensityList` は `getV2EarthquakeIntensityCityCode(code:, limit: limit.toString(), cursor: cursor)` を呼ぶ。
- [ ] **Step 5:** `dart run build_runner build` で `.freezed.dart`/`.g.dart` 生成。
- [ ] **Step 6:** `dart test app/test/feature/intensity_history/intensity_highest_repository_test.dart` PASS を確認。
- [ ] **Step 7: コミット** — `git add` 後 `feat(intensity-history): 最高震度 API の repository とモデルを追加`。

---

## Task 2: コードマッピング純粋関数

**Files:**
- Create: `app/lib/feature/intensity_history/data/model/region_code_mapping.dart`
- Test: `app/test/feature/intensity_history/region_code_mapping_test.dart`

**Interfaces:**
- Produces:
  - `String? prefectureCodeOfCity(String cityCode, List<EarthquakeParameterPrefectureItem> prefectures)` — 市区町村 code から所属都道府県 code を返す(`city.code` が `prefecture.code` を接頭辞に持つ規則、`city_selector.dart` の `substring(0,2)` ロジックに準拠)。
  - `List<String> regionCodesOfPrefecture(String prefectureCode, List<EarthquakeParameterPrefectureItem> prefectures)` — 都道府県配下の `areaForecastLocalE`(細分区域)code 群(Task 0 の結論次第。一致なら `[prefectureCode]` を返す簡易版)。
  - `List<String> cityCodesOfPrefecture(String prefectureCode, List<EarthquakeParameterPrefectureItem> prefectures)` — 都道府県配下の市区町村 code 群。

- [ ] **Step 1: 失敗するテストを書く** — ダミーの `EarthquakeParameterPrefectureItem`(code/regions/cities)を組み、各関数の戻り値を検証。
- [ ] **Step 2:** FAIL 確認。
- [ ] **Step 3: 実装** — Task 0 の結論を反映した純粋関数。
- [ ] **Step 4:** PASS 確認。
- [ ] **Step 5: コミット** — `feat(intensity-history): 地域コードマッピングの純粋関数を追加`。

---

## Task 3: フォーカス状態 Notifier と provider 群

**Files:**
- Create: `app/lib/feature/intensity_history/data/model/intensity_history_state.dart`
- Create: `app/lib/feature/intensity_history/data/notifier/intensity_history_controller.dart`
- Create: `app/lib/feature/intensity_history/data/notifier/prefecture_highest_provider.dart`
- Create: `app/lib/feature/intensity_history/data/notifier/city_highest_provider.dart`
- Test: `app/test/feature/intensity_history/intensity_history_controller_test.dart`

**Interfaces:**
- Consumes: Task 1 の `intensityHighestRepository`。
- Produces:
  - `IntensityHistoryState`(Freezed union): `Prefecture()` / `City({required String prefectureCode, required String prefectureName})`。
  - `@riverpod class IntensityHistoryController` — `build()→ const IntensityHistoryState.prefecture()`、`void focusPrefecture(String code, String name)`、`void backToPrefecture()`。
  - `@riverpod Future<List<HighestIntensityEntry>> prefectureHighest(Ref ref)`(repository 呼び出し、keepAlive)。
  - `@riverpod Future<List<HighestIntensityEntry>> cityHighest(Ref ref, String prefectureCode)`(family)。

- [ ] **Step 1: 失敗するテストを書く** — `ProviderContainer` で `IntensityHistoryController` の初期状態が `Prefecture`、`focusPrefecture` で `City(...)`、`backToPrefecture` で `Prefecture` に戻ることを検証。
- [ ] **Step 2:** FAIL 確認。
- [ ] **Step 3: 実装** — state(Freezed union)+ controller + 2 provider。
- [ ] **Step 4:** build_runner 生成 → PASS 確認。
- [ ] **Step 5: コミット** — `feat(intensity-history): フォーカス状態 Notifier と provider を追加`。

---

## Task 4: 震度 fill レイヤ(Lv1/Lv2)

**Files:**
- Create: `app/lib/feature/intensity_history/ui/layer/intensity_fill_layer.dart`
- Create: `app/lib/feature/intensity_history/ui/layer/intensity_fill_expression.dart`(match 式構築の純粋関数)
- Test: `app/test/feature/intensity_history/intensity_fill_expression_test.dart`

**Interfaces:**
- Consumes: Task 1 entries、Task 2 マッピング、`intensityColorProvider`。
- Produces:
  - `List<Object> buildIntensityMatchExpression(List<({String code, JmaIntensity intensity})> pairs, IntensityColorModel colorModel)` — `['match',['get','code'], code, color, ..., 'rgba(0,0,0,0)']`(`earthquake_history_region_intensity_layer.dart:87-108` を踏襲)。
  - `IntensityFillLayer`(HookConsumerWidget): `state` に応じて、Lv1 は `areaForecastLocalE` に、Lv2 は `areaInformationCityQuake` に `FillStyleLayer` を add/remove。`useEffect` で add、dispose で `removeLayer`(`earthquake_history_region_intensity_layer.dart` の構造を踏襲)。Lv2 時はディムオーバーレイ用 fill も追加。

- [ ] **Step 1: 失敗するテストを書く** — `buildIntensityMatchExpression` が pairs を `['match',['get','code'], 'A','#...', ..., 'rgba(0,0,0,0)']` 形に変換することを検証。
- [ ] **Step 2:** FAIL 確認。
- [ ] **Step 3: 実装** — `intensity_fill_expression.dart` の純粋関数。
- [ ] **Step 4:** PASS 確認。
- [ ] **Step 5: レイヤ Widget 実装** — `intensity_fill_layer.dart`。`belowLayerId` は `BaseLayer.areaForecastLocalELine.name` を指定(`earthquake_history` 準拠)。Lv2 のディムは非選択地域を半透明黒で覆う fill か、Lv1 fill の opacity を下げる。
- [ ] **Step 6:** `dart analyze` で当該ファイル警告ゼロ確認。
- [ ] **Step 7: コミット** — `feat(intensity-history): 震度 fill レイヤと match 式を追加`。

---

## Task 5: 市区町村詳細モーダル(サマリ + 過去地震一覧)

**Files:**
- Create: `app/lib/feature/intensity_history/data/notifier/city_intensity_list_data_source.dart`
- Create: `app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`
- Test: `app/test/feature/intensity_history/city_detail_modal_test.dart`

**Interfaces:**
- Consumes: Task 1 `fetchCityIntensityList`、Task 3 `cityHighest`(サマリ用)。
- Produces:
  - `CityIntensityListDataSource extends GroupedDataSource<String?, String, IntensityCitySearchItem>`(`eew_list_data_source.dart` 踏襲。`groupBy` は地震 originTime の `yyyy/MM/dd`、`load` で cursor ページング、limit 初回 20 / 追加 100)。
  - `@riverpod CityIntensityListDataSource cityIntensityListDataSource(Ref ref, String cityCode)`。
  - `Future<void> showCityDetailModal(BuildContext, {required String cityCode, required HighestIntensityEntry? summary})` — `showModalBottomSheet`(`isScrollControlled: true`)+ `DraggableScrollableSheet`。上部にサマリ(地域名/最高震度バッジ/件数/代表地震)、下部に `SliverGroupedPagingList` で過去地震一覧。

- [ ] **Step 1: 失敗するテストを書く** — DataSource の `groupBy`/`load`(Refresh/Append cursor 受け渡し)を Fake repository で検証(`eew_list_data_source_test.dart` 踏襲)。
- [ ] **Step 2:** FAIL 確認。
- [ ] **Step 3: DataSource 実装** → build_runner → PASS。
- [ ] **Step 4: モーダル Widget 実装** — サマリ + ページングリスト。震度バッジは既存 `intensityColorProvider` 利用。
- [ ] **Step 5: スモークテスト** — `city_detail_modal_test.dart` で `ProviderScope` override し、サマリの地域名が表示されることを検証(`eew_history_list_tile_test.dart` のセットアップ踏襲、`SharedPreferences.setMockInitialValues({})`)。
- [ ] **Step 6:** PASS + `dart analyze` 確認。
- [ ] **Step 7: コミット** — `feat(intensity-history): 市区町村詳細モーダルと過去地震一覧を追加`。

---

## Task 6: ページ本体(地図全面 + フローティングパネル + タップ + 戻る)

**Files:**
- Create: `app/lib/feature/intensity_history/ui/intensity_history_page.dart`
- Create: `app/lib/feature/intensity_history/ui/components/region_floating_panel.dart`
- Create: `app/lib/feature/intensity_history/ui/components/intensity_history_legend.dart`

**Interfaces:**
- Consumes: Task 3 controller/state/providers、Task 4 `IntensityFillLayer`、Task 5 `showCityDetailModal`、Task 2 マッピング。
- Produces:
  - `IntensityHistoryPage extends HookConsumerWidget`(引数 `String? initialPrefectureCode`, `String? initialCityCode`)。

- [ ] **Step 1:** `MapLibreMap`(既存 `map_style_util` のスタイル)を全面表示し `IntensityFillLayer` を重ねる。`Stack` 上部に `RegionFloatingPanel`(現在地域名/最高震度/件数)、隅に `IntensityHistoryLegend`、戻るボタン。
- [ ] **Step 2:** `onMapClick`/`queryLayers`(`earthquake_history_details_map_view.dart:234` 参照)でタップ地域 code を取得。Lv1 命中 → Task 2 で都道府県 code に正規化 → `controller.focusPrefecture(code,name)`。Lv2 命中(市区町村)→ `showCityDetailModal`。
- [ ] **Step 3:** Lv2 遷移時に当該都道府県の bounds へ `fitBounds`(`jmaMapProvider` から bounds 算出、`map_camera` の既存 fitBounds 利用)。`backToPrefecture` 時は全国へズームアウト。
- [ ] **Step 4:** `PopScope` で端末バックを Lv2→Lv1 に割り当て(Lv1 のときは通常 pop)。
- [ ] **Step 5:** `initialPrefectureCode` 指定時は初期 `focusPrefecture`、`initialCityCode` 指定時はさらに `showCityDetailModal` を `addPostFrameCallback` で自動表示。
- [ ] **Step 6:** `dart analyze` 警告ゼロ確認。
- [ ] **Step 7: コミット** — `feat(intensity-history): 地図ページ・フローティングパネル・タップ/戻る制御を追加`。

---

## Task 7: ルーティング + HomeSheet 導線 + ディープリンク

**Files:**
- Modify: `app/lib/core/router/router.dart`(`@TypedGoRoute<IntensityHistoryRoute>` 追加)
- Modify: `app/lib/page/home_page.dart`(`_SheetBody` のアクションカードに ListTile 追加)
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_map_popup.dart`(「この地域の最大震度履歴」アクション追加)

**Interfaces:**
- Consumes: Task 6 `IntensityHistoryPage`。
- Produces: `IntensityHistoryRoute({String? prefectureCode, String? cityCode})`(path `/intensity-history`)。

- [ ] **Step 1:** `router.dart` に `IntensityHistoryRoute` を追加(`prefectureCode`/`cityCode` を query パラメータで受け、`build` で `IntensityHistoryPage(initialPrefectureCode:..., initialCityCode:...)` を返す。`EarthquakeHistoryRoute` の `$extra`/`:param` パターン参照)。
- [ ] **Step 2:** `dart run build_runner build` で `router.g.dart` 再生成。
- [ ] **Step 3:** `home_page.dart` の `_SheetBody` アクションカードに `ListTile(leading: Icon(Icons.map...), title: Text('都道府県別 最大震度'), onTap: () => const IntensityHistoryRoute().push(context))` を追加。
- [ ] **Step 4:** `earthquake_history_map_popup.dart` に「この地域の最大震度履歴」ボタンを追加。市区町村ポップアップなら `IntensityHistoryRoute(prefectureCode: prefCode, cityCode: cityCode)`、地域ポップアップなら `prefectureCode` のみを渡して `push`。
- [ ] **Step 5:** `dart analyze` 警告ゼロ確認。
- [ ] **Step 6: コミット** — `feat(intensity-history): ルート・HomeSheet導線・ディープリンクを追加`。

---

## Task 8: 仕上げ(analyze / format / test 全体)

- [ ] **Step 1:** `cd app && dart analyze lib` 警告ゼロ。`dart analyze packages/eqmonitor_api/lib` も確認(変更していないこと)。
- [ ] **Step 2:** `dart format`(差分のあるファイルのみ)。
- [ ] **Step 3:** `flutter test test/feature/intensity_history/` 全 PASS。
- [ ] **Step 4:** 受け入れ条件(設計書 §10)1〜5 を手動チェックリストで確認。
- [ ] **Step 5: コミット**(差分があれば) — `chore(intensity-history): format と analyze 対応`。

---

## Self-Review チェック結果

- **Spec coverage:** 設計書 §3(レンダリング)=Task 4、§4(構成)=Task 1〜6、§5(状態)=Task 3、§6(ナビ/導線/ディープリンク)=Task 7、§7(エラー/空)=Task 1/5/6 内、§8(テスト)=各 Task の test。漏れなし。
- **Placeholder scan:** 「適切なエラー処理」等の曖昧表現なし。Task 0 の不確定要素は明示的な検証タスクとして分離。
- **Type consistency:** `HighestIntensityEntry` / `CityIntensityPage` / `IntensityHistoryState`(`Prefecture`/`City`)/ `focusPrefecture`/`backToPrefecture`/`buildIntensityMatchExpression` を全 Task で統一。
