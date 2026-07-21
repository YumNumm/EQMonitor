# MapLibre Layer Lifecycle Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** MapLibre の全 source/image/layer 操作を監査し、可変データ更新・非同期初期化・cleanup 競合で描画が消失または復旧不能になる不具合を修正する。

**Architecture:** source/image/layer の初期登録を style lifecycle に限定し、GeoJSON は `updateGeoJsonSource`、filter は `updateFilter`、paint/layout は layer 単位の差し替えで更新する。共通 helper は GeoJSON 更新の重複抑止・初期化待機と、独立 cleanup の二点だけに限定する。

**Tech Stack:** Flutter 3.44、Dart 3.11、flutter_hooks、Riverpod 3、MapLibre、flutter_test。

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- source/image/layer の再登録は、既存 API で定義更新できない場合だけ許可する。
- cleanup の一件失敗で後続 cleanup を止めない。
- production code を変更する前に対応する failing test を実行する。
- 既存の未コミット差分と backend submodule は変更しない。

---

### Task 1: MapLibre lifecycle 共通 helper

**Files:**
- Create: `app/lib/core/util/map/map_geo_json_source_updater.dart`
- Create: `app/lib/core/util/map/remove_map_style_resources.dart`
- Create: `app/test/core/util/map/map_geo_json_source_updater_test.dart`
- Create: `app/test/core/util/map/remove_map_style_resources_test.dart`
- Create: `app/test/core/util/map/fake_style_controller.dart`

**Interfaces:**
- Produces: `MapGeoJsonSourceUpdater.update({required StyleController styleController, required String sourceId, required String geoJson, required Future<void>? initialization, required bool Function() isDisposed})`。
- Produces: `removeMapStyleResources({required StyleController styleController, List<String> layerIds, List<String> sourceIds, List<String> imageIds})`。

- [ ] **Step 1: GeoJSON updater の failing test を追加する**

```dart
test('初期化完了後に一度だけ GeoJSON を更新する', () async {
  final style = FakeStyleController();
  final init = Completer<void>();
  final updater = MapGeoJsonSourceUpdater();
  final update = updater.update(
    styleController: style,
    sourceId: 'source',
    geoJson: '{"type":"FeatureCollection","features":[]}',
    initialization: init.future,
    isDisposed: () => false,
  );
  expect(style.updatedGeoJsonSources, isEmpty);
  init.complete();
  await update;
  await updater.update(
    styleController: style,
    sourceId: 'source',
    geoJson: '{"type":"FeatureCollection","features":[]}',
    initialization: Future<void>.value(),
    isDisposed: () => false,
  );
  expect(style.updatedGeoJsonSources, hasLength(1));
});
```

- [ ] **Step 2: cleanup の failing test を追加する**

```dart
test('先頭 layer の削除失敗後も残りの layer/source/image を削除する', () async {
  final style = FakeStyleController(failingLayerIds: {'first'});
  await removeMapStyleResources(
    styleController: style,
    layerIds: const ['first', 'second'],
    sourceIds: const ['source'],
    imageIds: const ['image'],
  );
  expect(style.removedLayerIds, ['first', 'second']);
  expect(style.removedSourceIds, ['source']);
  expect(style.removedImageIds, ['image']);
});
```

- [ ] **Step 3: RED を確認する**

Run: `cd app && mise exec -- flutter test test/core/util/map/map_geo_json_source_updater_test.dart test/core/util/map/remove_map_style_resources_test.dart`

Expected: helper が未定義のため FAIL。

- [ ] **Step 4: helper を最小実装する**

```dart
class MapGeoJsonSourceUpdater {
  String? _latestGeoJson;

  Future<void> update({
    required StyleController styleController,
    required String sourceId,
    required String geoJson,
    required Future<void>? initialization,
    required bool Function() isDisposed,
  }) async {
    await initialization;
    if (isDisposed() || _latestGeoJson == geoJson) return;
    await styleController.updateGeoJsonSource(id: sourceId, data: geoJson);
    _latestGeoJson = geoJson;
  }

  void reset() => _latestGeoJson = null;
}
```

`removeMapStyleResources` は layer、source、image の順に全 ID を巡回し、各呼び出しを独立した `try/on Exception` で実行する。

- [ ] **Step 5: GREEN を確認する**

Run: `cd app && mise exec -- flutter test test/core/util/map/map_geo_json_source_updater_test.dart test/core/util/map/remove_map_style_resources_test.dart`

Expected: PASS。

- [ ] **Step 6: helper をコミットする**

```bash
git add app/lib/core/util/map app/test/core/util/map
git commit -m "fix: MapLibre更新と破棄の共通処理を追加"
```

---

### Task 2: Seismicity source lifecycle

**Files:**
- Modify: `app/lib/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart`
- Modify: `app/test/feature/seismicity/ui/layer/seismicity_epicenter_layer_test.dart`

**Interfaces:**
- Consumes: `MapGeoJsonSourceUpdater`、`removeMapStyleResources`。
- Produces: style load ごとの一回限りの source/layer 登録と、events/tick ごとの GeoJSON 更新。

- [ ] **Step 1: builder と lifecycle の failing tests を追加する**

`SeismicityEpicenterGeoJsonBuilder.build({required List<SeismicityEvent> events, required DateTime now})` が feature 数と座標・プロパティを保持すること、events 更新時に source/layer の再登録が不要な updater 入力を生成できることを検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd app && mise exec -- flutter test test/feature/seismicity/ui/layer/seismicity_epicenter_layer_test.dart`

Expected: builder が未定義のため FAIL。

- [ ] **Step 3: 初期化と更新を分離する**

```dart
final disposed = useRef(false);
final initFuture = useRef<Future<void>?>(null);
final updater = useMemoized(MapGeoJsonSourceUpdater.new);

useEffect(() {
  if (styleController == null) return null;
  disposed.value = false;
  initFuture.value = enqueue(() async {
    await styleController.addSource(
      const GeoJsonSource(id: _sourceId, data: _emptyGeoJson),
    );
    if (disposed.value) return;
    await styleController.addLayer(buildLayer(colorMode));
  });
  return () {
    disposed.value = true;
    updater.reset();
    unawaited(enqueue(() => removeMapStyleResources(
      styleController: styleController,
      layerIds: const [_layerId],
      sourceIds: const [_sourceId],
    )));
  };
}, [styleController]);
```

events/tick effect は `MapGeoJsonSourceUpdater.update` のみ実行する。色モード変更 effect は source を維持して layer のみ差し替える。

- [ ] **Step 4: GREEN と既存テストを確認する**

Run: `cd app && mise exec -- flutter test test/feature/seismicity`

Expected: PASS。

- [ ] **Step 5: seismicity をコミットする**

```bash
git add app/lib/feature/seismicity app/test/feature/seismicity
git commit -m "fix: seismicityレイヤーの更新をsource差し替えに分離"
```

---

### Task 3: 地震履歴 GeoJSON lifecycle

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`
- Create: `app/test/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer_lifecycle_test.dart`
- Create: `app/test/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer_lifecycle_test.dart`
- Create: `app/test/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer_lifecycle_test.dart`
- Create: `app/test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`

**Interfaces:**
- Consumes: lifecycle helpers from Task 1。
- Produces: earthquake/tree/color/display-mode 更新時の source/image 再登録を排除した各レイヤー。

- [ ] **Step 1: 各 GeoJSON builder の更新回帰テストを追加する**

震源、誤差 Polygon、観測点、震度DB観測点について、入力変更で GeoJSON が変わる一方、source ID と image ID が不変であることを検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/layer`

Expected: 現行の private builder または lifecycle API では更新契約を検証できず FAIL。

- [ ] **Step 3: source/image 初期化を style lifecycle に限定する**

各 Widget で `initFuture`、`disposed`、`MapGeoJsonSourceUpdater` を保持する。earthquake/tree/color/display mode はデータ更新 effect に移し、parameter や label 表示は layer だけを差し替える。画像は style ごとに一度だけ登録する。

- [ ] **Step 4: cleanup を共通 helper へ置き換える**

station label、icon、circle、source の削除は独立して全件試行する。部分初期化後の cleanup でも後続 source 削除が実行されるようにする。

- [ ] **Step 5: GREEN を確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/layer`

Expected: PASS。

- [ ] **Step 6: 地震履歴をコミットする**

```bash
git add app/lib/feature/earthquake_history/ui/layer app/test/feature/earthquake_history/ui/layer
git commit -m "fix: 地震履歴レイヤーのsource再登録を解消"
```

---

### Task 4: 津波詳細 GeoJSON lifecycle

**Files:**
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart`
- Create: `app/test/feature/tsunami/ui/components/tsunami_map_geo_json_builder_test.dart`

**Interfaces:**
- Consumes: lifecycle helpers from Task 1。
- Produces: 予報区、震源、観測点 source を style ごとに一度だけ登録し、tsunami state 更新を GeoJSON 差し替えで反映する。

- [ ] **Step 1: 3種類の GeoJSON builder 回帰テストを追加する**

予報区の warning kind、震源座標、観測点の高さ・色・名称が state 更新後の GeoJSON に反映されることを検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd app && mise exec -- flutter test test/feature/tsunami/ui/components/tsunami_map_geo_json_builder_test.dart`

Expected: testable builder が未定義のため FAIL。

- [ ] **Step 3: builder を UI から分離し、source 更新 effect を追加する**

source は空 FeatureCollection で初期化し、JMA parameter 未取得時も Widget lifecycle を維持する。parameter 到着後または tsunami 更新後に updater で差し替える。warning kind ごとの layer filter は固定のため再作成しない。

- [ ] **Step 4: GREEN を確認する**

Run: `cd app && mise exec -- flutter test test/feature/tsunami`

Expected: PASS。

- [ ] **Step 5: 津波詳細をコミットする**

```bash
git add app/lib/feature/tsunami app/test/feature/tsunami
git commit -m "fix: 津波詳細レイヤーのGeoJSON更新を分離"
```

---

### Task 5: 全レイヤー cleanup 監査と修正

**Files:**
- Modify: `app/lib/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart`
- Modify: `app/lib/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart`
- Modify: `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`
- Modify: `app/lib/feature/home/ui/component/map/layer/shake_detection_layer.dart`
- Create: `docs/knowledge/20260720_maplibre_layer_lifecycle.md`

**Interfaces:**
- Consumes: `removeMapStyleResources`。
- Produces: 全 MapLibre layer について、一件の削除失敗で後続 resource が残留しない cleanup。

- [ ] **Step 1: 全操作箇所を再検索して監査表を確定する**

Run: `rg -l 'addSource\(|addLayer\(|removeSource\(|removeLayer\(|updateGeoJsonSource\(' app/lib --glob '*.dart'`

各ファイルを「安全な静的」「安全な update 分離」「source 再作成修正済み」「cleanup 修正対象」に分類する。

- [ ] **Step 2: cleanup helper の回帰テストを対象リソース数で拡張する**

複数 layer と複数 source の途中失敗でも、全 ID が順番どおり試行されることを追加する。

- [ ] **Step 3: grouped cleanup を helper へ置換する**

EEW震源、P/S波、強震モニタ、揺れ検知を含む全該当箇所で layer → source の順序を明示する。既に個別 cleanup 済みの実装は変更しない。

- [ ] **Step 4: knowledge を記録する**

規約、代表コード、監査用 `rg`、focused test コマンドを `docs/knowledge/20260720_maplibre_layer_lifecycle.md` に記載する。

- [ ] **Step 5: focused tests を実行する**

Run: `cd app && mise exec -- flutter test test/core/util/map test/feature/seismicity test/feature/earthquake_history/ui/layer test/feature/tsunami`

Expected: PASS。

- [ ] **Step 6: cleanup 監査をコミットする**

```bash
git add app/lib/feature docs/knowledge/20260720_maplibre_layer_lifecycle.md app/test
git commit -m "fix: MapLibreレイヤーの破棄を全件独立化"
```

---

### Task 6: 全体検証と draft PR

**Files:**
- No planned file changes; scoped defects found by verification return to the owning task.

**Interfaces:**
- Consumes: all previous tasks。
- Produces: verified branch and draft PR。

- [ ] **Step 1: format を実行する**

Run: `cd app && mise exec -- dart format lib/core/util/map lib/feature/seismicity lib/feature/earthquake_history/ui/layer lib/feature/tsunami test/core/util/map test/feature/seismicity test/feature/earthquake_history/ui/layer test/feature/tsunami`

- [ ] **Step 2: focused tests を再実行する**

Run: `cd app && mise exec -- flutter test test/core/util/map test/feature/seismicity test/feature/earthquake_history/ui/layer test/feature/tsunami`

Expected: PASS。

- [ ] **Step 3: analyze を実行する**

Run: `cd app && mise exec -- flutter analyze`

Expected: 0 issues。既存の無関係 failure がある場合は touched seam の analyze を追加し、双方を記録する。

- [ ] **Step 4: repository gates を実行する**

Run: `git diff --check develop...HEAD`

Run: `git status --short`

Expected: whitespace error なし、未コミット差分なし。

- [ ] **Step 5: PR 前レビューを実施する**

仕様適合、全操作箇所の監査漏れ、非同期 race、テストの実効性を diff 上で再確認し、指摘があれば修正・再検証する。

- [ ] **Step 6: push と draft PR を作成する**

Branch: `codex/fix-map-layer-lifecycle`

PR title: `fix: MapLibreレイヤーのライフサイクルを修正`

PR body には原因、修正対象、監査で安全と判断したパターン、RED/GREEN テスト、最終検証結果を記載する。
