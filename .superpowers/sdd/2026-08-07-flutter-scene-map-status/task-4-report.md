# Task 4: eqmonitor_map の検証状況調査

調査日: 2026-08-07

対象:

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/**`
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/README.md`
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/example/README.md`
- `/home/yumnumm/EQMonitor/.github/workflows/**`
- `/home/yumnumm/EQMonitor/docs/todo/800_eqmonitor_map_deferred_verification.md`
- `/home/yumnumm/EQMonitor/docs/todo/770_existing_eqmonitor_flutter_test_failures.md`
- `git --no-pager log --oneline -40 -- packages/eqmonitor_map`

## 結論

`eqmonitor_map` は unit/pure 関数レベルでは広くテストされており、MVT decode、Fill/Line mesh、tile cover、tile cache、projection、Flutter Scene adapter 引数、Scene spike lifecycle まで自動検証がある。一方で、`BaseMapView` の実描画そのもの、GPU upload、golden、物理端末 profile/release、pinch zoom、性能、label/動的 layer は未検証またはスコープ外として明示的に延期されている。

「base layer PMTiles drawing works」と言える範囲は限定的。最新の flood/Line 幅修正コミットは入っているが、その修正後の simulator/実機 smoke 証跡は README/TODO 上まだ確認できないため、現時点では「iOS simulator で Fill と pan/tile差し替えは過去に目視確認済み。Line の flood は原因修正コミットがあるが、修正後の実機/目視回帰確認は未完了」という表現が妥当。

## 1. 自動テストで覆われている範囲

`packages/eqmonitor_map/test` には `_test.dart` が 22 ファイルあり、`test(` は合計 196 件だった。

### geo

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/geo/map_camera_test.dart`
  - `MapCamera` の Freezed equality/copyWith、Web Mercator world center。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/geo/map_mercator_projection_test.dart`
  - zoom scale/worldSize、WGS84 <-> normalized round-trip、緯度 clamp、日付変更線 wrap、非 finite 入力拒否。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/geo/map_viewport_test.dart`
  - aspect ratio、DPR保持、value equality、invalid size/DPR rejection。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/geo/tile_id_test.dart`
  - canonical/overscaled/unwrapped tile ID、ancestor/descendant scaling、children、wrap を含む equality。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/geo/tile_matrix_test.dart`
  - tile local -> world matrix、wrap shift、viewProjection 合成のscreen corner、DPR非依存、origin rebasing による float32 precision。

### tile / PMTiles / MVT

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/tile_cover_calculator_test.dart`
  - integer/fractional zoom、min/max clamp、overscale、aspect ratio、日付変更線の正/負 wrap、距離順 sort、tie-break。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/base_map_tile_cache_test.dart`
  - sourceInstanceId+tile key、zoom window eviction、非対称 lower zoom retention、LRU、decode token cancellation、exact/children/parent fallback。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/mvt/mvt_decoder_test.dart`
  - tracked fixture 2 件:
    - `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/mvt/fixtures/earthquake_tsunami_all_z6_x59_y27.mvt`
    - `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/mvt/fixtures/earthquake_tsunami_all_z7_x112_y56.mvt`
  - synthetic geometry: Point/MultiPoint/LineString/MultiLineString/Polygon/hole、layer extent、unknown field、properties/id の読み飛ばし。
  - limit enforcement: layer/feature/ring/vertex/command/name 上限。
  - malformed rejection: truncated varint、length overflow、unsupported wire type、required field欠落、version、geometry command異常。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart`
  - `baseMapLayerSpecs` の draw order/source layer 名。
  - synthetic tile から Fill/Line geometry を生成する経路。
  - Polygon を Line layer では closed loop として扱うこと、LineString は閉じないこと、欠損 source layer は empty mesh。
  - `BaseMapTileDecoder.decode` の `Isolate.run` wrapper が sync core と一致すること。

### mesh

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/mesh/fill_mesh_builder_test.dart`
  - square triangulation、hole 付き polygon、複数 exterior、面積保存、hole 内 triangle なし、segment splitting、Uint16 boundary、degenerate/limit/non-polygon rejection。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/mesh/line_mesh_builder_test.dart`
  - straight line、duplicate point removal、right-angle miter、miter limit clamp、closed loop wrap-around、degenerate rings、multiple rings no cross-ring triangle、segment splitting、invalid args。
  - flood の初期仮説だった ring boundary bridging はこのテストでかなり強く否定されている。

### renderer / spike pure model

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/renderer/eqmonitor_orthographic_projection_test.dart`
  - north-up orthographic matrix、depth clipping、invalid dimensions rejection。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/renderer/spike_screen_projector_test.dart`
  - clip -> logical pixel projection、resize、invalid size/DPR/clip rejection。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/renderer/spike_mesh_frame_test.dart`
  - partial update dirty range、immutable typed arrays、invalid range/index/non-finite rejection。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/renderer/scene_spike_lifecycle_test.dart`
  - detached/active/background/rebuilding/disposed の transition table、idempotent/missing transition、resource generation、invalid state rejection。

### flutter_scene adapter

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/flutter_scene/base_map_geometry_factory_test.dart`
  - GPU 呼び出しは避け、`MeshGeometry.fromArrays` 直前の pure args を検証。
  - Fill/Line positions の 2D -> 3D 展開、Uint16 indices の非コピー。
  - Line extrudes を `texCoords` としてそのまま渡すこと。
  - `halfLineWidthNdcFor` による logical px -> NDC 半線幅換算。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/flutter_scene/flutter_scene_orthographic_projection_test.dart`
  - Flutter Scene projection wrapper が pure projection へ委譲すること。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/flutter_scene/scene_spike_camera_test.dart`
  - camera standoff/depthHalfExtent、camera node transform、projection instance reuse。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/flutter_scene/flutter_scene_spike_controller_test.dart`
  - metrics counter、mesh update validator、async initialization/rebuild generation、dispose/detach/background/foreground、partial update resume/stop、exception counter、remount owner。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/flutter_scene/spike_label_painter_test.dart`
  - `TextPainter` label overlay の anchor center layout。

### widget

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/widget/base_map_view_test.dart`
  - `BaseMapView` 本体ではなく、gesture callback から分離された pure 関数だけを検証。
  - pan の center 移動、pinch scale -> zoom、min/max clamp、canonical zoom floor/clamp。

### library smoke

- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/test/eqmonitor_map_library_test.dart`
  - package identity と supported platforms。

## 2. 自動テストで未カバー / deferred の範囲

`/home/yumnumm/EQMonitor/docs/todo/800_eqmonitor_map_deferred_verification.md` と README で延期が明示されているもの:

- Performance HUD と、metrics 収集自体の CPU/memory overhead・event drop 検証。
- pan、pinch zoom、loading、degraded 表示の Widget test。
- 固定 PMTiles、viewport、DPR、theme、text scale を使う Fill/Line/label の Golden test。
- frame、queue待機、decode、mesh build、GPU、cache の benchmark と回帰閾値。
- 物理 iOS/Android 端末 profile/release での manual smoke。
- procedural mesh、custom material、`TextPainter` overlay、回転、partial update、background/foreground、resource rebuild、dispose/remount、exception counter/log の実端末確認。
- properties(tag/key/value) と feature ID の decode。
- bevel/round join、round cap、dash、`linesofar`。
- Douglas-Peucker 等の頂点間引き。
- tile buffer 領域の scissor/clip。
- 非正規 varint の明示拒否。
- production base source layer 名で、hole を含む実 tile fixture。
- 反転法線 fallback の正式テスト。
- label 描画、動的 layer、remote source、Asset Pack 以外の source、attestation、hit test。
- `BaseMapTileGeometry` への MVT extent 伝播。
- 同じ祖先 fallback tile が複数 visible tile に使われた場合の重複描画排除。

README の `BaseMapView` 実機/simulator確認結果では、Task 10 時点で iPhone 17 Pro simulator (iOS 27.0) で以下は確認済み:

- 本番相当 PMTiles override で日本の海岸線が Fill として描画される。
- 1本指 pan で camera 中心が動き、地物が追従し、HUD の `visibleTiles` / `decoding` が変化して 0 に収束する。
- zoom は archive header の範囲 `[0, 8]` で clamp される。

未確認:

- pinch zoom。
- background 色の視覚確認。
- 線幅・色・tile境界の見た目。
- iOS/Android 物理端末。
- 祖先 fallback が実画面で効く場面。

## 3. CI

### PR entrypoint

`/home/yumnumm/EQMonitor/.github/workflows/pr-flutter-check.yaml`

- `on: pull_request` 全 branch と `merge_group`。
- `changes` job で path filter を実行。
- `flutter-analyze`: `needs.changes.outputs.flutter == 'true'` のとき。
- `flutter-test`: `needs.changes.outputs.flutter == 'true'` のとき。
- `integration-test`: `needs.changes.outputs.flutter == 'true'` のとき。
- `eqmonitor-map-scene-spike`: `needs.changes.outputs.eqmonitor_map_scene_spike == 'true'` のとき。
- `status-check` は上記 jobs の failure/cancelled を拾って失敗する。skipped は失敗扱いではない。

### Path filters

`/home/yumnumm/EQMonitor/.github/workflows/wc-changes.yaml`

- `flutter` は `app/**`, `packages/**`, `tools/**`, root `pubspec.*`, `mise.*`, `analysis_options.yaml`, Flutter workflow 群で true。
- `eqmonitor_map_scene_spike` は以下で true:
  - `packages/eqmonitor_map/**`
  - `.gitignore`
  - `mise.toml`, `mise.lock`, `pubspec.lock`
  - scene spike workflow / PR workflow / changes workflow

したがって `packages/eqmonitor_map/**` を触る PR では、通常の Flutter analyze/test と Scene Spike build job の両方が走る。

### Flutter test job

`/home/yumnumm/EQMonitor/.github/workflows/wc-check-dart-test.yaml`

- `workflow_call` 専用。
- Ubuntu 24.04。
- `mise exec -- dart pub get --enforce-lockfile`。
- `mise exec -- dart run melos exec --dir-exists=test --concurrency=4 -- 'mise exec -- flutter test --dart-define=CI=true --file-reporter="json:test_report.log"'`
- `(app|packages/**)/test_report.log` を `dorny/test-reporter` へ渡す。

`eqmonitor_map` は test directory を持つ package なので、この job の対象になる。

### Flutter analyze job

`/home/yumnumm/EQMonitor/.github/workflows/wc-check-dart-analyze.yaml`

- `workflow_call` 専用。
- Ubuntu 24.04。
- `mise exec -- dart pub get --enforce-lockfile`。
- `invertase/github-action-dart-analyzer` を `working-directory: app` で実行。
- `tools/eqmonitor_custom_lints` の unit test も実行。

`eqmonitor_map` 単体の analyze は通常 analyze job ではなく、下記 Scene Spike job に明示的にある。

### EQMonitor Map Scene Spike job

`/home/yumnumm/EQMonitor/.github/workflows/wc-check-eqmonitor-map-scene-spike.yaml`

- `workflow_call` 専用。PR では `pr-flutter-check.yaml` から呼ばれる。
- Android job:
  - Ubuntu 24.04。
  - `mise` で `flutter java`。
  - `flutter precache --android`。
  - `packages/eqmonitor_map/example` で `flutter pub get --enforce-lockfile`。
  - `mise exec -- flutter analyze --no-pub --fatal-infos packages/eqmonitor_map`。
  - example の Android profile/release APK build。
- iOS job:
  - macOS 26。
  - `mise` で `flutter`。
  - `flutter precache --ios`。
  - `packages/eqmonitor_map/example` で `flutter pub get --enforce-lockfile`。
  - example の iOS profile/release build `--no-codesign`。

この job は build gate であり、manual smoke や screenshot/golden、物理端末確認は行わない。

## 4. Recent fix commits

`git --no-pager log --oneline -40 -- packages/eqmonitor_map` の先頭付近:

- `14916951f Fix: 半線幅をNDC単位へ換算しLineが画面を覆う不具合を解消`
  - `base_map_line.fmat`, `base_map_material_library.dart`, `base_map_view.dart`, `base_map_geometry_factory_test.dart` を変更。
  - line width を viewport 依存の NDC uniform として扱う修正。
- `32377f2f3 Fix: 押し出し法線をtexCoordsで渡しLineが描画されない不具合を解消`
  - `setCustomAttribute('extrude')` ではなく `MeshGeometry.fromArrays(texCoords:)` で extrude を渡す修正。
  - `base_map_geometry_factory.dart` の doc comment でも、custom attribute が shader に届かず position が読まれていた実験結果が記録されている。
- `5d395868f Fix: spec.colorをlayerごとに反映しflood発生元を診断する`
  - layer ごとの material instance 化と README/TODO 更新。
- `ec3461a52 Test: LineMeshBuilderの複数ring feature向けring境界不変条件を追加`
  - ring boundary bridging 仮説を regression test 化。
- `fdfe0d5c6 Fix: BaseMapTileCacheのzoom窓を非対称にし、深い祖先fallbackを保持する`
  - pinch zoom などの zoom jump で祖先 fallback を残す修正。

注意: `/home/yumnumm/EQMonitor/docs/todo/800_eqmonitor_map_deferred_verification.md` と README には、flood の真因や「未修正」記述が残っているが、最新 log ではその後に `texCoords` 修正と半線幅 NDC 修正が入っている。したがって docs は一部 stale になっている可能性が高い。ただし、修正後の simulator/物理端末 smoke 成功記録は見つからなかった。

## 5. 現在のテスト実行結果

実行を試みたコマンド:

```bash
cd /home/yumnumm/EQMonitor/packages/eqmonitor_map
mise exec -- flutter test --no-pub
```

結果: 失敗。テスト本体は実行されていない。

エラー:

```text
Error: cannot run without a dependency on either "package:flutter_test" or "package:test".
Ensure the following lines are present in your pubspec.yaml:

dev_dependencies:
  flutter_test:
    sdk: flutter
```

`pubspec.yaml` には `flutter_test` が存在するため、`--no-pub` か workspace dependency resolution の状態に起因して package 単体で `.dart_tool` が解決できていない可能性が高い。read-only 指示のため、追加の `dart pub get` / `flutter pub get` は実行していない。

副作用メモ: `mise exec` の起動時に未導入 tool (`github:rorkai/App-Store-Connect-CLI`) の install と `hk install --mise` が走り、git hook の install ログが出た。repository tracked file の変更は意図していない。

## 6. 重要な open correctness issues

### 高: MVT extent が `BaseMapView` で固定 4096 のまま

`/home/yumnumm/EQMonitor/packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は `tileMatrixFor(... extent: mvtDefaultExtent)` を使っている。`BaseMapTileGeometry` が layer/tile の実 extent を保持していないため、4096 以外の extent を持つ archive/source layer では縮尺が壊れる。現在の実 archive は全 layer `extent=4096` と記録されているため現時点の本番相当 archive では顕在化しないが、設計正本の「MVT extent は layer 宣言値を読む」に反する。

### 高: 最新 flood/Line 修正後の実画面 smoke が未確認

flood/line 不具合については recent commits で原因修正が入っている:

- custom attribute ではなく `texCoords` で extrude を渡す。
- half line width を NDC に換算して viewport 変化時にも再適用する。

ただし README/TODO 上は、修正後に iOS simulator/物理端末で「海が Line 色で塗られない」「Line layer が意図した幅と色で見える」「background が見える」「tile boundary に隙間/重複がない」を再確認した記録がない。生命に関わる地図表示の基盤としては、修正コミットだけではなく目視/スクリーンショット evidence が必要。

### 中: `NodeCamera + EqmonitorOrthographicProjection` 経路の描画不能疑い

`docs/todo/800_eqmonitor_map_deferred_verification.md` は、`scene_spike_camera.dart` と同型の `scene.NodeCamera + EqmonitorOrthographicProjection` 配線で可視レンダリングが出ない、と記録している。`BaseMapView` は `_IdentityCameraProjection + viewProjectionMatrixFor を node へ焼き込む方式` なので直接の base map blocker ではないが、Scene spike / material preflight の信頼性には影響する。

### 中: 同じ祖先 fallback tile の重複描画排除なし

tile cover の複数 tile が同じ祖先へ fallback した場合、`_rebuildSceneNodes` は同じ geometry/node を複数回描く可能性がある。TODO では不透明色なら見た目に出にくいが、半透明色導入時は排除が必要とされている。現在の layer spec が常に不透明である前提に依存している。

### 中: tile buffer 領域の clip/scissor なし

MVT extent を超える buffer 領域の頂点も Fill/Line mesh に含まれ、描画側で clip していない。tile 境界の重複/はみ出し確認が golden/manual smoke として未実施であることと合わせて、境界品質の保証はまだ弱い。

### 中: widget/golden/performance/manual coverage が薄い

`BaseMapView` 本体の widget test はなく、gesture pure 関数のみ。Golden test もない。GPU upload/performance benchmark/physical profile/release smoke も deferred。CI は build gate までで、描画結果の correctness gate ではない。

### 低から中: properties/feature ID 未decode、style/semantics/hit test 未対応

現在の base layer Fill/Line 表示だけなら成立するが、将来の label/hit test/semantics/動的 layer では properties/feature ID が必要になる。README の初期スコープには label/typed dynamic layer/hit test が含まれるが、現状は `BaseMapView` の base layer 範囲外。

## 7. `docs/todo/770_existing_eqmonitor_flutter_test_failures.md` との関係

この TODO は app 側 `eqmonitor` suite の既存 18 failures を記録したもので、`eqmonitor_map` package 単体のテスト失敗ではない。`wc-check-dart-test.yaml` は melos で test dir を持つ全 package/app を走らせるため、app suite の既存 failure が残っている場合は PR 全体の Flutter test gate に影響し得る。ただしこの TODO の失敗内訳は theme/settings/feed/background location 等で、`eqmonitor_map` の correctness とは直接関係しない。

## 8. Confidence: "base layer PMTiles drawing works"

信頼度: 中の下。

根拠:

- unit/pure tests は広く、MVT decode、mesh、tile cover/cache、projection、Scene adapter 引数に対する回帰検出力は高い。
- Task 10 時点で iOS simulator の実 PMTiles override による Fill/pan/tile差し替えは目視確認済み。
- flood/Line 問題の原因は recent commits で修正されているように見える。

制約:

- 最新 flood/Line 修正後の simulator/実機 smoke 記録がない。
- `flutter test` は今回 read-only 条件下では実行完了できていない。
- golden/widget/manual/performance/physical device が deferred。
- MVT extent 固定、tile buffer clip なし、fallback 重複描画などの既知の correctness debt が残る。

推奨する claim:

> Base layer PMTiles drawing has a solid unit-tested foundation, and Fill/pan rendering was previously observed in an iOS simulator. Recent fixes address the known Line flood root causes, but final confidence requires rerunning simulator/physical smoke after those fixes, especially Line color/width, background, tile boundaries, and pinch zoom.
