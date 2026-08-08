# EQMonitor Map ベースレイヤー残件 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1589 のベースレイヤー縦切りに残る MVT extent 伝播、祖先 fallback の重複描画、Flutter Scene camera 契約を、自動テストで受け入れ可能な状態へ閉じる。

**Architecture:** MVT source layer の `extent` を layer geometry の metadata として保持し、各 `tile × layer × material` node の行列へ渡す。要求 cover は変更せず、cache の fallback 結果だけを安定順の render tile 列へ正規化して同一祖先を一度だけ描画する。Flutter Scene は恒等 camera に統一し、正射影を含む `viewProjection × model` を node transform へ焼き込む契約を BaseMap、spike、preflight で共有する。

**Tech Stack:** Flutter master pin (`4dacd3fc91d96262a33e5c598e17d816f0b35641`)、Dart、flutter_scene (`7f71993b7e2a0ab1d2f59726a406098709be7291`)、vector_math、flutter_test、mise

## Global Constraints

- 対象は Issue #1589 の残件だけとする。#1590 の foundation model、Node/Element reconciler、FrameSnapshot、性能観測、公開 `MapScene` API は変更しない。
- 対象 platform は iOS/Android、北固定・真上視点・正射影 2D のままとし、bearing、pitch、perspective、3D を追加しない。
- app が検証済みの `VerifiedPmTilesSource` を渡す境界、欠損 tile=`null`、破損等=typed exception、整数 zoom mesh、非整数 zoom の行列 scale、線幅の逆補正、float32 頂点、miter join、butt cap、`tile × layer × material` batch を変更しない。
- MVT extent は source layer 宣言値を正本とする。宣言省略時に decoder が MVT 仕様既定値 4096 を解決した後は、その実値を geometry と render 行列へ渡し、renderer 独自の 4096 fallback を持たない。
- fallback の重複排除は render node 展開だけへ適用する。要求 cover の件数・順序、visible tile count、decode request、exact→子4枚→最寄り祖先の探索順、world wrap の別 copy は維持する。
- Flutter Scene camera の正式契約は「恒等 `scene.NodeCamera` + `viewProjection × model` を node の `localTransform` へ焼き込む」とする。未描画の `NodeCamera` + `FlutterSceneOrthographicProjection` 経路は併存させない。
- 物理 device、simulator、golden、E2E はこの branch の受け入れから明示的に除外する。代替として checked-in fixture、純粋行列 test、fallback resolver unit test、fake adapter による camera 配線 test、既存 Flutter test/analyze を実行し、GPU/platform 上の残余 risk は README と knowledge に記録する。
- Flutter/Dart command はすべて `mise exec --` 経由で実行する。新しい依存 package は追加しない。
- `dynamic`/`Object` の新規利用、`!`、Widget 内の関数/getter、class 内 private method、固定値による fail-open、feature 単位 Scene Node を追加しない。2引数以上の新規 API は名前付き引数にする。
- production code の各 task は RED→GREEN の順に進め、task ごとに対象 test、format、`git diff --check`を通して review 可能な単位で commit する。

---

### Task 1: MVT source layer extent を geometry と render 行列へ伝播する

**Files:**

- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- Modify: `packages/eqmonitor_map/lib/src/geo/tile_matrix.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart`
- Modify: `packages/eqmonitor_map/test/geo/tile_matrix_test.dart`

**Interfaces:**

- Consumes: `MvtLayer.extent: int`（`decodeMvtTile`が宣言値または仕様既定値を解決済み）、`viewProjectionMatrixFor({required MapCamera camera, required MapViewport viewport}) -> Matrix4`、`tileMatrixFor({required UnwrappedTileId tileId, required double zoom, required int extent}) -> Matrix4`。
- Produces: `BaseMapTileLayerGeometry.extent: int?`（source layer 不在時だけ `null`）、`baseMapTileViewProjectionMatrixFor({required MapCamera camera, required MapViewport viewport, required UnwrappedTileId tileId, required double zoom, required int extent}) -> Matrix4`。`BaseMapView` は mesh がある layer の非 null extent をこの関数へ渡す。

- [ ] **Step 1: 異なる extent を持つ source layer の failing decode test を書く**

  `base_map_tile_decoder_test.dart` の合成 MVT に `countries(extent: 2048)` と `areaForecastLocalE(extent: 8192)` を同居させ、同じ source を使う Fill/Line は同じ extent、別 source は別 extent、欠損 source は `null` になることを固定する。

  ```dart
  test('preserves each source layer extent on every derived style layer', () {
    final tile = _builder.buildTile(
      layers: [
        _builder.buildLayer(
          name: 'countries',
          extent: 2048,
          features: [_buildFeatureTriangle()],
        ),
        _builder.buildLayer(
          name: 'areaForecastLocalE',
          extent: 8192,
          features: [_buildFeatureTriangle()],
        ),
      ],
    );

    final geometry = decodeBaseMapTileSync(tile, _limits);
    final extents = {
      for (final layer in geometry.layers) layer.styleLayerId: layer.extent,
    };

    expect(extents['countriesFill'], 2048);
    expect(extents['countriesLine'], 2048);
    expect(extents['areaForecastLocalEFill'], 8192);
    expect(extents['areaForecastLocalELine'], 8192);
    expect(extents['areaForecastLocalEewLine'], isNull);
    expect(extents['areaInformationCityQuakeLine'], isNull);
  });
  ```

- [ ] **Step 2: decode test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart --plain-name 'preserves each source layer extent on every derived style layer'`

  Expected: FAIL（`BaseMapTileLayerGeometry` に `extent` getter が存在しない）。

- [ ] **Step 3: layer geometry に source layer extent を保持する最小実装を行う**

  base class と Fill/Line constructor に nullable extent を追加する。nullable は「該当 source layer が tile に存在しない」という既存の sparse semantics を表し、renderer の fallback 値には使わない。

  ```dart
  sealed class BaseMapTileLayerGeometry {
    const BaseMapTileLayerGeometry({
      required this.styleLayerId,
      required this.extent,
    });

    final String styleLayerId;
    final int? extent;
  }

  final class BaseMapTileFillLayerGeometry
      extends BaseMapTileLayerGeometry {
    const BaseMapTileFillLayerGeometry({
      required super.styleLayerId,
      required super.extent,
      required this.meshes,
    });

    final List<FillMesh> meshes;
  }
  ```

  `decodeBaseMapTileSync` では background を除く spec ごとに `sourceLayerName` を local 変数へ取り、`_findLayer` の結果を Fill/Line mesh builder と constructor の両方へ渡す。source layer が存在すれば feature が空でも `layer.extent` を保持し、不在時だけ `null` にする。`spec.sourceLayerName!` は追加せず、null branch は `StateError` にする。

  ```dart
  final sourceLayerName = spec.sourceLayerName;
  if (sourceLayerName == null) {
    throw StateError('${spec.styleLayerId} has no source layer.');
  }
  final sourceLayer = _findLayer(tile, sourceLayerName);
  layers.add(
    BaseMapTileFillLayerGeometry(
      styleLayerId: spec.styleLayerId,
      extent: sourceLayer?.extent,
      meshes: _buildFillMeshes(layer: sourceLayer, builder: fillBuilder),
    ),
  );
  ```

- [ ] **Step 4: layer extent から合成行列まで通る failing characterization test を書く**

  `tile_matrix_test.dart` に公開 pure function の期待を先に書く。2048 の tile-local 中心 `(1024, 1024)` と 4096 の中心 `(2048, 2048)` が同じ clip 座標へ写り、誤って 4096 固定に戻すと前者だけずれる test にする。

  ```dart
  test('uses the supplied MVT extent when composing the render matrix', () {
    const camera = MapCamera(
      centerLongitude: 0,
      centerLatitude: 0,
      zoom: 0,
    );
    final viewport = MapViewport(
      logicalSize: const Size(512, 512),
      devicePixelRatio: 1,
    );
    const tileId = UnwrappedTileId(
      wrap: 0,
      canonical: CanonicalTileId(z: 0, x: 0, y: 0),
    );

    final extent2048 = baseMapTileViewProjectionMatrixFor(
      camera: camera,
      viewport: viewport,
      tileId: tileId,
      zoom: camera.zoom,
      extent: 2048,
    );
    final extent4096 = baseMapTileViewProjectionMatrixFor(
      camera: camera,
      viewport: viewport,
      tileId: tileId,
      zoom: camera.zoom,
      extent: 4096,
    );

    final center2048 = extent2048.transform3(Vector3(1024, 1024, 0));
    final center4096 = extent4096.transform3(Vector3(2048, 2048, 0));
    expect(center2048.x, closeTo(center4096.x, 1e-12));
    expect(center2048.y, closeTo(center4096.y, 1e-12));
    expect(center2048.z, closeTo(center4096.z, 1e-12));
  });
  ```

- [ ] **Step 5: matrix test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/geo/tile_matrix_test.dart --plain-name 'uses the supplied MVT extent when composing the render matrix'`

  Expected: FAIL（`baseMapTileViewProjectionMatrixFor` が未定義）。

- [ ] **Step 6: 合成行列 API を追加し BaseMapView を layer extent 駆動へ変更する**

  `tile_matrix.dart` に double 精度の合成を一箇所へ集約する。

  ```dart
  Matrix4 baseMapTileViewProjectionMatrixFor({
    required MapCamera camera,
    required MapViewport viewport,
    required UnwrappedTileId tileId,
    required double zoom,
    required int extent,
  }) => viewProjectionMatrixFor(camera: camera, viewport: viewport).multiplied(
    tileMatrixFor(
      tileId: tileId,
      zoom: zoom,
      extent: extent,
    ),
  );
  ```

  `base_map_view.dart` から `mvtDefaultExtent` import と固定値コメントを削除する。`_nodesFor` は対象 `styleLayerId` の `BaseMapTileLayerGeometry` を取得し、mesh が空なら node を作らない。mesh があるのに `extent == null` なら contract violation として `StateError` にし、非 null extent を `(wrap, canonical tile, extent)` key の transform cache と上記 API へ渡す。異なる extent の layer が同じ tile を共有しても行列を共有しない。

  ```dart
  final extent = layerGeometry.extent;
  if (meshes.isEmpty) {
    return const [];
  }
  if (extent == null) {
    throw StateError(
      '${layerGeometry.styleLayerId} has meshes without an MVT extent.',
    );
  }
  final transform = transformFor(extent);
  ```

- [ ] **Step 7: extent の対象 test を GREEN にする**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart test/geo/tile_matrix_test.dart`

  Expected: PASS（2048/8192 が geometry に残り、行列の center が extent 非依存で一致する）。

- [ ] **Step 8: format、差分確認、commit を行う**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- dart format lib/src/tile/base_map_tile_decoder.dart lib/src/geo/tile_matrix.dart lib/src/widget/base_map_view.dart test/tile/base_map_tile_decoder_test.dart test/geo/tile_matrix_test.dart
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map
  git add packages/eqmonitor_map
  git commit -m "Fix: MVT extentを描画行列へ伝播"
  ```

### Task 2: fallback の render tile を決定的に重複排除する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/base_map_render_tile_resolver.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`

**Interfaces:**

- Consumes: ordered `List<OverscaledTileId> requestedCover` と `BaseMapTileCache.lookupWithFallback({required String sourceInstanceId, required CanonicalTileId tileId, required int maxParentSteps}) -> BaseMapTileFallbackResult`。
- Produces: immutable `BaseMapRenderTile({required UnwrappedTileId tileId, required BaseMapTileGeometry geometry})` と `BaseMapRenderTileResolver.resolve({required List<OverscaledTileId> requestedCover, required String sourceInstanceId, required BaseMapTileCache cache, required int maxParentSteps}) -> List<BaseMapRenderTile>`。結果 key は `(wrap, canonical)` で、最初に現れた render tile の位置を保持する。

- [ ] **Step 1: 同一祖先、順序、world wrap を固定する failing unit test を書く**

  helper で z4 ancestor を cache し、その z5 children 2枚を要求 cover に置く。祖先は1件、cover は入力のまま2件、最初の cover entry の位置に出ることを assert する。さらに同じ canonical ancestor でも wrap 0/1 は2件残す。

  ```dart
  test('deduplicates one ancestor selected by multiple requested tiles', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const geometry = BaseMapTileGeometry(layers: []);
    const ancestor = CanonicalTileId(z: 4, x: 7, y: 6);
    final token = cache.beginDecode();
    cache.put(
      sourceInstanceId: 'source-a',
      tileId: ancestor,
      geometry: geometry,
      token: token,
    );
    final requestedCover = [
      OverscaledTileId(overscaledZ: 5, canonical: ancestor.children()[0], wrap: 0),
      OverscaledTileId(overscaledZ: 5, canonical: ancestor.children()[1], wrap: 0),
    ];

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: requestedCover,
      sourceInstanceId: 'source-a',
      cache: cache,
      maxParentSteps: 2,
    );

    expect(requestedCover, hasLength(2));
    expect(rendered, hasLength(1));
    expect(
      rendered.single.tileId,
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
    );
  });
  ```

  同ファイルに次も独立 test として追加する。

  - exact hit は requested cover 順を維持する。
  - 子4枚 fallback は `CanonicalTileId.children()` 順に展開する。
  - 同一 canonical ancestor の wrap 0 と wrap 1 は重複排除しない。
  - miss は render tile を追加しない。
  - 同じ入力を2回 resolve すると同じ tile ID 列になる。

- [ ] **Step 2: resolver test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_render_tile_resolver_test.dart`

  Expected: FAIL（resolver と render tile 型が未定義）。

- [ ] **Step 3: ordered set semantics の resolver を実装する**

  Dart の挿入順 `Map` を使い、key に `UnwrappedTileId` を使う。exact/parent/children のどれも同じ `putIfAbsent` 経路へ入れ、最初に選ばれた geometry と順序を後続 fallback で上書きしない。

  ```dart
  @immutable
  final class BaseMapRenderTile {
    const BaseMapRenderTile({required this.tileId, required this.geometry});

    final UnwrappedTileId tileId;
    final BaseMapTileGeometry geometry;
  }

  final class BaseMapRenderTileResolver {
    const BaseMapRenderTileResolver();

    List<BaseMapRenderTile> resolve({
      required List<OverscaledTileId> requestedCover,
      required String sourceInstanceId,
      required BaseMapTileCache cache,
      required int maxParentSteps,
    }) {
      if (maxParentSteps < 0) {
        throw ArgumentError.value(
          maxParentSteps,
          'maxParentSteps',
          'must be non-negative',
        );
      }
      final rendered = <UnwrappedTileId, BaseMapTileGeometry>{};
      for (final requested in requestedCover) {
        final fallback = cache.lookupWithFallback(
          sourceInstanceId: sourceInstanceId,
          tileId: requested.canonical,
          maxParentSteps: maxParentSteps,
        );
        switch (fallback) {
          case BaseMapTileFallbackMiss():
            continue;
          case BaseMapTileFallbackExact(:final geometry):
            rendered.putIfAbsent(requested.toUnwrapped(), () => geometry);
          case BaseMapTileFallbackParent(:final tileId, :final geometry):
            final unwrapped = UnwrappedTileId(
              wrap: requested.wrap,
              canonical: tileId,
            );
            rendered.putIfAbsent(unwrapped, () => geometry);
          case BaseMapTileFallbackChildren(:final children):
            final childIds = requested.canonical.children();
            for (var index = 0; index < childIds.length; index++) {
              final unwrapped = UnwrappedTileId(
                wrap: requested.wrap,
                canonical: childIds[index],
              );
              rendered.putIfAbsent(unwrapped, () => children[index]);
            }
        }
      }
      return [
        for (final entry in rendered.entries)
          BaseMapRenderTile(tileId: entry.key, geometry: entry.value),
      ];
    }
  }
  ```

  `maxParentSteps < 0` は cache 探索へ渡す前に `ArgumentError` とし、隠れた補正値へ丸めない。

- [ ] **Step 4: BaseMapView の node 展開だけを resolver 出力へ切り替える**

  `_refresh` の `cover`、`_visibleTileCount = cover.length`、`_requestMissingDecodes(cover)` は変更しない。`_rebuildSceneNodes` 冒頭で resolver を呼び、layer 外側・resolved render tile 内側の順で node を作る。

  ```dart
  final renderTiles = const BaseMapRenderTileResolver().resolve(
    requestedCover: cover,
    sourceInstanceId: source.sourceInstanceId,
    cache: _cache,
    maxParentSteps: limits.maxParentFallbackSteps,
  );

  for (final spec in baseMapLayerSpecs) {
    if (spec.kind == BaseMapLayerKind.background) {
      continue;
    }
    for (final renderTile in renderTiles) {
      nodes.addAll(
        _nodesFor(
          spec: spec,
          wrap: renderTile.tileId.wrap,
          tileId: renderTile.tileId.canonical,
          geometry: renderTile.geometry,
          materialsByStyleLayerId: materialsByStyleLayerId,
          transformFor: (extent) => transformFor(
            renderTile.tileId.wrap,
            renderTile.tileId.canonical,
            extent,
          ),
        ),
      );
    }
  }
  ```

  これにより半透明 material を将来使っても同じ祖先を重ねず、world copy と layer 順は維持する。

- [ ] **Step 5: fallback cache と resolver の test を GREEN にする**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_cache_test.dart test/tile/base_map_render_tile_resolver_test.dart`

  Expected: PASS（探索順の既存 test と render 重複排除 test の両方が通る）。

- [ ] **Step 6: format、差分確認、commit を行う**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- dart format lib/src/tile/base_map_render_tile_resolver.dart lib/src/widget/base_map_view.dart test/tile/base_map_render_tile_resolver_test.dart
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map
  git add packages/eqmonitor_map
  git commit -m "Fix: 祖先fallbackの重複描画を排除"
  ```

### Task 3: 恒等 Scene camera と node transform の正式契約へ統一する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_clip_space_camera.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_clip_space_camera_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/scene_spike_camera.dart`
- Delete: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_orthographic_projection.dart`
- Delete: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_orthographic_projection_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_adapter.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_spike_controller.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/base_map_material_preflight_view.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/scene_spike_camera_test.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_spike_controller_test.dart`

**Interfaces:**

- Produces: `FlutterSceneClipSpaceCamera.createCamera() -> scene.NodeCamera` と `FlutterSceneClipSpaceCamera.nodeTransform({required model_math.Matrix4 viewProjection, required model_math.Matrix4 model}) -> scene_math.Matrix4`。
- Changes: `SceneSpikeControllerAdapter.applyViewProjection({required model_math.Matrix4 viewProjection}) -> void`。`FlutterSceneSpikeController.attach/resize` が logical aspect ratio ごとの正射影行列を adapter へ渡す。
- Retires: `FlutterSceneOrthographicProjection` と、custom projection を `scene.NodeCamera` に直接設定する経路。

- [ ] **Step 1: camera と行列合成の failing contract test を書く**

  camera node と projection が identity で、node transform が double 精度で `viewProjection × model` を合成した後に scene 用 Matrix4 へ変換されることを固定する。

  ```dart
  test('uses an identity Scene camera and bakes projection into the node', () {
    const contract = FlutterSceneClipSpaceCamera();
    final camera = contract.createCamera();
    final viewProjection = model_math.Matrix4.diagonal3Values(0.5, 0.25, 1);
    final model = model_math.Matrix4.translationValues(4, 8, 0);

    expect(
      camera.node.localTransform.storage,
      scene_math.Matrix4.identity().storage,
    );
    expect(camera.projection.getProjectionMatrix(2).storage,
        scene_math.Matrix4.identity().storage);
    expect(
      contract.nodeTransform(
        viewProjection: viewProjection,
        model: model,
      ).storage,
      viewProjection.multiplied(model).storage,
    );
  });
  ```

- [ ] **Step 2: camera contract test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/flutter_scene_clip_space_camera_test.dart`

  Expected: FAIL（`FlutterSceneClipSpaceCamera` が未定義）。

- [ ] **Step 3: 共通 camera contract を実装する**

  identity projection は新規ファイル内の package-private top-level class とし、利用側は `FlutterSceneClipSpaceCamera` だけを見る。node transform は `vector_math_64` の積を先に計算し、最後に `vector_math` へ一度だけ変換する。

  ```dart
  final class FlutterSceneClipSpaceCamera {
    const FlutterSceneClipSpaceCamera();

    scene.NodeCamera createCamera() => scene.NodeCamera(
      scene.Node(),
      const _IdentitySceneProjection(),
    );

    scene_math.Matrix4 nodeTransform({
      required model_math.Matrix4 viewProjection,
      required model_math.Matrix4 model,
    }) => scene_math.Matrix4.fromList(
      viewProjection.multiplied(model).storage,
    );
  }

  final class _IdentitySceneProjection implements scene.CameraProjection {
    const _IdentitySceneProjection();

    @override
    scene_math.Matrix4 getProjectionMatrix(double aspectRatio) =>
        scene_math.Matrix4.identity();
  }
  ```

  doc comment に、custom material の `Vertex()` が受け取る `world_position` は既に clip/NDC であること、line の `half_width_ndc` 契約と対になること、Scene camera 側で再度 projection しないことを書く。

- [ ] **Step 4: BaseMap を共通 camera contract の consumer にする**

  `_IdentityCameraProjection` を `base_map_view.dart` から削除する。controller の camera は `FlutterSceneClipSpaceCamera.createCamera()` で作る。Task 1 の double 精度 `baseMapTileViewProjectionMatrixFor` の返り値を `model`、double 精度の恒等行列を `viewProjection` として `FlutterSceneClipSpaceCamera.nodeTransform` へ渡し、scene 用 Matrix4 への最終変換を共通化する。行列積を二重適用しない test expectation を維持する。

- [ ] **Step 5: spike adapter/controller を node transform 駆動へ変更する failing fake test を書く**

  `flutter_scene_spike_controller_test.dart` の fake adapter に `appliedViewProjections` を追加し、attach で1回、aspect ratio が変わる resize で更新、同じ size/DPR では追加しないことを assert する。

  ```dart
  expect(adapter.appliedViewProjections, hasLength(1));
  expect(
    adapter.appliedViewProjections.single.storage,
    projection.matrixFor(aspectRatio: 2).storage,
  );

  controller.resize(
    logicalSize: const Size(300, 300),
    devicePixelRatio: 2,
  );
  expect(adapter.appliedViewProjections, hasLength(2));
  expect(
    adapter.appliedViewProjections.last.storage,
    projection.matrixFor(aspectRatio: 1).storage,
  );
  ```

- [ ] **Step 6: spike と preflight を正式 camera 契約へ移す**

  `SceneSpikeControllerAdapter` に次を追加する。

  ```dart
  void applyViewProjection({required model_math.Matrix4 viewProjection});
  ```

  `FlutterSceneSpikeController.attach` は adapter attach 後、`resize` は logical size 変更時に `_projection.matrixFor(aspectRatio: width / height)` を渡す。`FlutterSceneSpikeAdapter` は左の built-in material node、右の custom material node、新しく rebuild した両 node の各 model translation に `FlutterSceneClipSpaceCamera.nodeTransform` を適用する。view projection 未設定の状態で custom/rebuild node を作ろうとした場合は `StateError` とし、identity 値で黙って代替しない。

  `createSceneSpikeCameraSetup()` は純粋 `EqmonitorOrthographicProjection` と identity Scene camera を返す。`BaseMapMaterialPreflightView` も MediaQuery の aspect ratio から同じ projection を作り、三角形 node の `localTransform` へ合成行列を設定する。logical size が変わったときは Scene を再構築せず node transform だけを更新する。

  旧 `FlutterSceneOrthographicProjection` 本体と専用 test を削除し、`scene_spike_camera_test.dart` は次を検証する。

  - camera node/projection は identity。
  - pure `EqmonitorOrthographicProjection` は overlay と node transform で同じ instance を使う。
  - aspect ratio 2 と 1 で node transform が期待する x scale に変わる。

- [ ] **Step 7: camera/spike の automated test を GREEN にする**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/flutter_scene_clip_space_camera_test.dart test/flutter_scene/scene_spike_camera_test.dart test/flutter_scene/flutter_scene_spike_controller_test.dart test/renderer/eqmonitor_orthographic_projection_test.dart test/renderer/spike_screen_projector_test.dart`

  Expected: PASS。GPU pixel の assert、device、simulator は使わない。

- [ ] **Step 8: format、差分確認、commit を行う**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- dart format lib/src/flutter_scene lib/src/widget/base_map_view.dart test/flutter_scene
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map
  git add packages/eqmonitor_map
  git commit -m "Refactor: Flutter Scene camera契約を統一"
  ```

### Task 4: 自動受け入れと文書の事実を残件解消後へ更新する

**Files:**

- Modify: `packages/eqmonitor_map/README.md`
- Modify: `docs/todo/800_eqmonitor_map_deferred_verification.md`
- Create: `docs/knowledge/20260809_flutter_scene_clip_space_camera.md`

**Interfaces:**

- Consumes: Tasks 1-3 の test 名、正式 camera contract、削除済み残件。
- Produces: 自動検証済み範囲と未実施 platform 検証を混同しない README、未完了項目だけを持つ deferred verification 文書、再利用可能な camera 配線 knowledge。

- [ ] **Step 1: README の stale な状態説明を具体的な受け入れ結果へ置き換える**

  次を事実として記載する。

  - Line flood の原因は custom attribute slot/stride で、`texCoords` と NDC 半線幅へ移行済み。原因未特定・未修正という現行 warning は削除する。
  - source layer ごとの extent は decode→`BaseMapTileLayerGeometry.extent`→layer node 行列へ伝播し、2048/8192 fixture で検証済み。
  - fallback は要求 cover/decode を保ったまま `(wrap, canonical render tile)` で重複排除し、半透明 material でも同一祖先を重ねないことを unit test で検証済み。
  - 正式 camera は identity Scene camera + node transform で、spike/preflight の旧 custom `NodeCamera` projection 経路は削除済み。
  - Issue #1589 の受け入れでは device/simulator/E2E を実施していない。過去の iOS simulator 観測は履歴として残すが、今回の extent/fallback/camera 修正を画面で確認済みとは書かない。
  - Android/iOS GPU、surface lifecycle、実際の pinch、fallback の目視、非4096 archive の画面表示は platform risk として残る。

- [ ] **Step 2: deferred verification 文書から完了した残件だけを除く**

  `docs/todo/800_eqmonitor_map_deferred_verification.md` から以下だけを削除する。

  - `BaseMapTileGeometry` が extent を運ばず 4096 固定だった項目。
  - 同一祖先 fallback の重複描画項目。
  - `NodeCamera + EqmonitorOrthographicProjection` が黒画面になる未修正 section。

  properties/feature ID、join/cap/dash、scissor、varint、実 tile hole fixture、6 byte packing、label/remote/attestation/hit test/HUD、widget/golden、performance、物理端末 smoke は削除しない。camera の歴史的原因と正式契約は todo に残さず新しい knowledge へ移す。

- [ ] **Step 3: camera 契約を knowledge に記録する**

  `docs/knowledge/20260809_flutter_scene_clip_space_camera.md` に次を500行以内で書く。

  ```markdown
  # Flutter Sceneの2D cameraは恒等cameraとnode transformで配線する

  ## 契約

  `scene.NodeCamera`のprojectionは恒等にし、CPUのdouble精度で
  `clip = viewProjection * model * position`を合成してから、各nodeの
  `localTransform`へ一度だけ渡す。custom materialのline押し出しはclip/NDC
  空間で行うため、半線幅もviewport由来のNDC単位にする。

  ## 禁止する経路

  `FlutterSceneOrthographicProjection`を`NodeCamera`へ直接設定する旧spike経路は
  このpinで可視出力を生成しなかったため再導入しない。cameraとnodeの両方へ
  projectionを設定して二重変換しない。

  ## 自動確認

  cd packages/eqmonitor_map
  mise exec -- flutter test test/flutter_scene test/geo/tile_matrix_test.dart
  ```

  physical GPU の可視性はこの unit test から推論できないため、物理端末 smoke の未完了 status も明記する。

- [ ] **Step 4: package 全体の自動検証を実行する**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- dart format --output=none --set-exit-if-changed lib test
  mise exec -- flutter analyze
  mise exec -- flutter test

  cd ../pmtiles_v3
  mise exec -- flutter analyze
  mise exec -- dart test

  cd ../seismicity_pmtiles
  mise exec -- flutter analyze
  mise exec -- dart test

  cd ../../app
  mise exec -- flutter analyze

  cd ..
  git diff --check
  ```

  Expected: 全 command PASS。device 一覧取得、`flutter run`、integration test、golden、E2E は実行しない。

- [ ] **Step 5: scope と文書差分を確認して commit する**

  `git --no-pager diff --stat` と `git --no-pager diff` で次を確認する。

  - #1590 foundation files、app production files、PMTiles reader production filesに差分がない。
  - completed residual だけが deferred verification 文書から消えている。
  - README は automated と過去の simulator 観測を分け、今回の修正を実機確認済みと表現していない。
  - 未確定マーカー、内容を省いた実装指示、未定の型名がない。

  ```bash
  git add packages/eqmonitor_map/README.md docs/todo/800_eqmonitor_map_deferred_verification.md docs/knowledge/20260809_flutter_scene_clip_space_camera.md
  git commit -m "Docs: ベースレイヤー残件の検証結果を記録"
  ```

---

## Acceptance Matrix

| Issue #1589 residual | Automated substitute | Remaining platform risk |
|---|---|---|
| per-layer MVT extent | 2048/8192 MVT fixture + geometry assertion + tile-local center-to-clip matrix test | 非4096 production archive のGPU画面表示は未確認 |
| ancestor fallback duplicate | exact/children/parent/miss/wrap/determinism resolver unit tests +既存 cache探索順test | pinch 中の祖先差し替えを画面では未確認 |
| camera wiring | identity camera contract matrix test + fake adapter attach/resize test + spike projection unit tests | iOS/Android の pinned Flutter Scene が実際に rasterize することは未確認 |
| regression | eqmonitor_map 全test、pmtiles_v3/seismicity_pmtiles test、app/3 package analyze | device lifecycle、GPU resource rebuild、performance は別の deferred verification |

## Completion Criteria

- `BaseMapView` から renderer 固有の `mvtDefaultExtent` 参照がなく、mesh を持つ各 layer の decode 済み extent が node transform に使われる。
- 同じ `(world wrap, canonical ancestor)` は1 layerにつき1回だけ node 展開される。異なる wrap、layer、要求 cover、decode request は統合されない。
- BaseMap、spike、preflight が同じ identity Scene camera contract を使い、`FlutterSceneOrthographicProjection` は repository に残らない。
- README、deferred verification、knowledge が自動確認済み範囲と未確認 platform risk を正確に表す。
- 指定した format/analyze/unit test が通り、device/simulator/E2E を受け入れ blocker にしていない。
