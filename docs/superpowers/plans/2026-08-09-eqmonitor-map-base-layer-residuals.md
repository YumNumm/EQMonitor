# EQMonitor Map ベースレイヤー残件 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1589 のベースレイヤー縦切りに残る MVT extent 伝播、祖先 fallback の重複描画、camera 配線の support boundary を、自動テストで受け入れ可能な状態へ閉じる。

**Architecture:** MVT source layer の `extent` を layer geometry metadata として保持し、単一のScene非依存entry `buildBaseMapRenderPlans(...)` がfallback解決とlayer plan構築を所有して、最終tile ID・extent・zoomを各 `tile × layer × material` node の行列へ渡す。要求 cover は変更せず、cache の fallback 結果だけを安定順の render tile 列へ正規化し、同一祖先を一度だけ描画する。camera は実描画済みの BaseMap 経路、すなわち恒等 `scene.NodeCamera` と node の `viewProjection × tileMatrix` を #1589 の正式経路に限定し、未解決の spike/preflight は #1593 の lifecycle/renderer 作業へ分離する。

**Tech Stack:** Flutter master pin (`4dacd3fc91d96262a33e5c598e17d816f0b35641`)、Dart、flutter_scene (`7f71993b7e2a0ab1d2f59726a406098709be7291`)、vector_math、flutter_test、mise

## Global Constraints

- 対象は Issue #1589 の残件だけとする。#1590 の foundation model、Node/Element reconciler、FrameSnapshot、性能観測、公開 `MapScene` API は変更しない。
- #1593 が所有する Scene renderer 一般化、GPU lifecycle、context recovery、spike/preflight の再配線は実装しない。#1589 では BaseMap の既存 identity-camera + node-transform 経路だけを正式と文書化する。
- 対象 platform は iOS/Android、北固定・真上視点・正射影 2D のままとし、bearing、pitch、perspective、3D を追加しない。
- app が検証済みの `VerifiedPmTilesSource` を渡す境界、欠損 tile=`null`、破損等=typed exception、整数 zoom mesh、非整数 zoom の行列 scale、線幅の逆補正、float32 頂点、miter join、butt cap、`tile × layer × material` batch を変更しない。
- MVT extent は source layer 宣言値を正本とする。宣言省略時に decoder が MVT 仕様既定値 4096 を解決した後は、その実値を geometry と render 行列へ渡し、renderer 独自の 4096 fallback を持たない。
- fallback の重複排除は render node 展開だけへ適用する。要求 cover の件数・順序、visible tile count、decode request、exact→子4枚→最寄り祖先の探索順、world wrap の別 copy は維持する。
- 物理 device、simulator、golden、E2E はこの branch の受け入れから明示的に除外する。checked-in fixture、純粋行列 test、fallback resolver unit test、既存 Flutter test/analyze で代替し、GPU/platform 上の残余 risk を README と knowledge に記録する。
- 過去の iOS simulator screenshot は過去時点の BaseMap 観測記録であり、この計画による extent、fallback、camera support boundary の変更を検証する証拠として扱わない。
- Flutter/Dart command はすべて `mise exec --` 経由で実行する。新しい依存 package は追加しない。
- `dynamic`/`Object` の新規利用、`!`、Widget 内の関数/getter、class 内 private method、固定値による fail-open、feature 単位 Scene Node を追加しない。2引数以上の新規 API は名前付き引数にする。
- 各 logical commit は約30〜100行を目安に分け、RED→GREEN、対象 test、format、`git diff --check`を通す。最初の実装 commit 後に `git push -u origin fix/eqmonitor-map-base-layer-residuals`、以降は commit ごとに `git push`する。PR 作成はstack全体の実装review後に行う。

---

### Task 1: MVT source layer extent を geometry と render matrix 契約へ伝播する

**Files:**

- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- Modify: `packages/eqmonitor_map/lib/src/geo/tile_matrix.dart`
- Modify: `packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart`
- Modify: `packages/eqmonitor_map/test/tile/base_map_tile_cache_test.dart`
- Modify: `packages/eqmonitor_map/test/geo/tile_matrix_test.dart`

**Interfaces:**

- Consumes: `MvtLayer.extent: int`（`decodeMvtTile`が宣言値または仕様既定値を解決済み）、`viewProjectionMatrixFor({required MapCamera camera, required MapViewport viewport}) -> Matrix4`、`tileMatrixFor({required UnwrappedTileId tileId, required double zoom, required int extent}) -> Matrix4`。
- Produces: `BaseMapTileLayerGeometry.extent: int?`（source layer 不在時だけ `null`）、`baseMapTileViewProjectionMatrixFor({required MapCamera camera, required MapViewport viewport, required UnwrappedTileId tileId, required double zoom, required int extent}) -> Matrix4`。mesh がある layer は必ず非 null extent を node transform に使う。

- [ ] **Step 1: source layer ごとの extent を要求する failing decode test を書く**

  `base_map_tile_decoder_test.dart` の合成 MVT に `countries(extent: 2048)` と `areaForecastLocalE(extent: 8192)` を同居させる。同じ source を使う Fill/Line は同じ extent、別 source は別 extent、欠損 source は `null` になることを固定する。

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

    expect(extents, {
      'countriesFill': 2048,
      'countriesLine': 2048,
      'areaForecastLocalEFill': 8192,
      'areaForecastLocalEewLine': null,
      'areaForecastLocalELine': 8192,
      'areaInformationCityQuakeLine': null,
    });
  });
  ```

- [ ] **Step 2: decode test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart --plain-name 'preserves each source layer extent on every derived style layer'`

  Expected: FAIL（`BaseMapTileLayerGeometry` に `extent` getter が存在しない）。

- [ ] **Step 3: layer geometry に resolved extent を保持する**

  base class と Fill/Line constructor に `required int? extent` を追加する。nullable は「該当 source layer が tile に存在しない」という既存 sparse semantics だけを表し、renderer の fallback 値には使わない。

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

  `decodeBaseMapTileSync` は background 以外の spec で source layer を一度解決し、その `extent` と同じ layer から作った mesh を constructor へ渡す。source layer が存在すれば feature が空でも extent を保持する。

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

- [ ] **Step 4: direct constructor を使う cache sentinel を型変更へ追従させる**

  repository 全体を `rg -n 'BaseMapTile(Fill|Line)LayerGeometry\(' packages/eqmonitor_map` で検索する。`base_map_tile_cache_test.dart` の `_geometry` は MVT defaultを暗黙利用せず、sentinel contract として非 nullの `extent: 4096` を明記する。

  ```dart
  BaseMapTileGeometry _geometry(int marker) {
    return BaseMapTileGeometry(
      layers: [
        BaseMapTileFillLayerGeometry(
          styleLayerId: 'countriesFill',
          extent: 4096,
          meshes: [
            FillMesh(
              positions: Float32List.fromList([marker.toDouble(), 0]),
              indices: Uint16List.fromList([0]),
              vertexCount: 1,
            ),
          ],
        ),
      ],
    );
  }
  ```

  cache key test で返却された sentinel の `extent == 4096` もassertし、cache が metadata を失わないことを固定する。

  ```dart
  final result = cache.get(sourceInstanceId: 'a', tileId: tileId);
  if (result == null) {
    fail('expected the cached geometry');
  }
  final layer = result.layers.single as BaseMapTileFillLayerGeometry;
  expect(layer.extent, 4096);
  expect(_markerOf(result), 1);
  ```

- [ ] **Step 5: decode/cache boundary を GREEN にし、最初の logical commit を作る**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart test/tile/base_map_tile_cache_test.dart
  mise exec -- dart format lib/src/tile/base_map_tile_decoder.dart test/tile/base_map_tile_decoder_test.dart test/tile/base_map_tile_cache_test.dart
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map/lib/src/tile packages/eqmonitor_map/test/tile
  git add packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart packages/eqmonitor_map/test/tile/base_map_tile_cache_test.dart
  git commit -m "Fix: MVT extentをgeometryへ保持"
  git push -u origin fix/eqmonitor-map-base-layer-residuals
  ```

- [ ] **Step 6: 非4096 extent の failing render matrix test を書く**

  `tile_matrix_test.dart` で、2048 の tile-local 中心 `(1024, 1024)` と 4096 の中心 `(2048, 2048)` が同じ clip 座標へ写ることを検証する。2048側へ4096を誤って渡す実装ではこのtestが失敗する。

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

- [ ] **Step 7: render matrix test を実行して RED を確認する**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/geo/tile_matrix_test.dart --plain-name 'uses the supplied MVT extent when composing the render matrix'`

  Expected: FAIL（`baseMapTileViewProjectionMatrixFor` が未定義）。

- [ ] **Step 8: extent を必須入力にする合成行列 API を実装する**

  `tile_matrix.dart` に double精度の合成を一箇所へ集約する。

  ```dart
  Matrix4 baseMapTileViewProjectionMatrixFor({
    required MapCamera camera,
    required MapViewport viewport,
    required UnwrappedTileId tileId,
    required double zoom,
    required int extent,
  }) => viewProjectionMatrixFor(camera: camera, viewport: viewport).multiplied(
    tileMatrixFor(tileId: tileId, zoom: zoom, extent: extent),
  );
  ```

- [ ] **Step 9: render boundary を GREEN にし、2つ目の logical commit を作る**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test test/geo/tile_matrix_test.dart test/tile/base_map_tile_decoder_test.dart test/tile/base_map_tile_cache_test.dart
  mise exec -- dart format lib/src/geo/tile_matrix.dart test/geo/tile_matrix_test.dart
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map/lib/src/geo packages/eqmonitor_map/test/geo
  git add packages/eqmonitor_map/lib/src/geo/tile_matrix.dart packages/eqmonitor_map/test/geo/tile_matrix_test.dart
  git commit -m "Fix: MVT extentを描画行列へ伝播"
  git push
  ```

### Task 2: fallback render tile を決定的に重複排除する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/base_map_render_tile_resolver.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/base_map_render_plan_builder.dart`
- Create: `packages/eqmonitor_map/test/tile/support/base_map_render_tile_test_support.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_parent_test.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_selection_test.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_identity_test.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_render_plan_builder_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`

**Interfaces:**

- Consumes: ordered `List<OverscaledTileId> requestedCover` と `BaseMapTileCache.lookupWithFallback({required String sourceInstanceId, required CanonicalTileId tileId, required int maxParentSteps}) -> BaseMapTileFallbackResult`。
- Produces: immutable `BaseMapRenderTile({required UnwrappedTileId tileId, required BaseMapTileGeometry geometry})` と `BaseMapRenderTileResolver.resolve({required List<OverscaledTileId> requestedCover, required String sourceInstanceId, required BaseMapTileCache cache, required int maxParentSteps}) -> List<BaseMapRenderTile>`。key は `UnwrappedTileId` で、最初に現れた render tile の位置を保持する。
- Produces: `BaseMapTileTransformInput({required UnwrappedTileId tileId, required double zoom, required int extent})`、`BaseMapLayerRenderPlan({required BaseMapTileGeometry tileGeometry, required BaseMapTileLayerGeometry layerGeometry, required BaseMapTileTransformInput transformInput})`、`buildBaseMapRenderPlans({required List<OverscaledTileId> requestedCover, required String sourceInstanceId, required BaseMapTileCache cache, required int maxParentSteps, required double zoom}) -> List<BaseMapLayerRenderPlan>`。Flutter Scene型を含めない。
- Scope: `buildBaseMapRenderPlans(...)` はresolver→内部builderを呼ぶ唯一のpackage-visible orchestration entryとし、回帰testと `BaseMapView` は同じnamed argument一式でこの関数を直接呼ぶ。内部 `_BaseMapRenderPlanBuilder` を外部から呼ばない。このrender planは #1589 runtime seamであり、#1590のfoundation model、public `MapScene` API、Node/Element reconcilerには昇格させない。

- [ ] **Step 1: 共通 test helper と parent重複排除の failing test を書く**

  `base_map_render_tile_test_support.dart` に cache helper を置く。

  ```dart
  const sourceId = 'source-a';

  void putGeometry({
    required BaseMapTileCache cache,
    required CanonicalTileId tileId,
  }) {
    cache.put(
      sourceInstanceId: sourceId,
      tileId: tileId,
      geometry: const BaseMapTileGeometry(layers: []),
      token: cache.beginDecode(),
    );
  }

  OverscaledTileId requested({required CanonicalTileId tileId, int wrap = 0}) =>
      OverscaledTileId(overscaledZ: tileId.z, wrap: wrap, canonical: tileId);
  ```

  `base_map_render_tile_resolver_parent_test.dart` に最初の behavior test を置く。

  ```dart
  import 'support/base_map_render_tile_test_support.dart';

  test('deduplicates one ancestor selected by multiple requested tiles', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 7, y: 6);
    putGeometry(cache: cache, tileId: ancestor);
    final cover = [
      requested(tileId: ancestor.children()[0]),
      requested(tileId: ancestor.children()[1]),
    ];

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(cover, hasLength(2));
    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
    ]);
  });
  ```

- [ ] **Step 2: exact順、miss、children順の failing tests を先に追加する**

  `base_map_render_tile_resolver_selection_test.dart` に置き、共通helperをimportする。この時点ではresolver production codeを書かない。

  ```dart
  test('keeps exact hits in requested cover order', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const first = CanonicalTileId(z: 5, x: 3, y: 4);
    const second = CanonicalTileId(z: 5, x: 2, y: 4);
    putGeometry(cache: cache, tileId: first);
    putGeometry(cache: cache, tileId: second);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [requested(tileId: first), requested(tileId: second)],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: first),
      const UnwrappedTileId(wrap: 0, canonical: second),
    ]);
  });

  test('omits a fallback miss', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const tileId = CanonicalTileId(z: 5, x: 3, y: 4);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [requested(tileId: tileId)],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered, isEmpty);
  });

  test('expands a four-child fallback in CanonicalTileId.children order', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const parent = CanonicalTileId(z: 4, x: 1, y: 2);
    final children = parent.children();
    for (final child in children) {
      putGeometry(cache: cache, tileId: child);
    }

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [requested(tileId: parent, wrap: 2)],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      for (final child in children)
        UnwrappedTileId(wrap: 2, canonical: child),
    ]);
  });

  ```

- [ ] **Step 3: wrap分離とrepeat determinism の failing tests も先に追加する**

  `base_map_render_tile_resolver_identity_test.dart` に置き、共通helperをimportする。ここまでresolver production codeは未作成のままにする。

  ```dart
  test('keeps the same canonical ancestor in distinct world wraps', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 1, y: 2);
    final child = ancestor.children().first;
    putGeometry(cache: cache, tileId: ancestor);

    final rendered = const BaseMapRenderTileResolver().resolve(
      requestedCover: [
        requested(tileId: child, wrap: 0),
        requested(tileId: child, wrap: 1),
      ],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(rendered.map((tile) => tile.tileId), [
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
      const UnwrappedTileId(wrap: 1, canonical: ancestor),
    ]);
  });

  test('returns the same ordered tile IDs for repeated resolution', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const first = CanonicalTileId(z: 5, x: 3, y: 4);
    const second = CanonicalTileId(z: 5, x: 2, y: 4);
    putGeometry(cache: cache, tileId: first);
    putGeometry(cache: cache, tileId: second);
    final cover = [requested(tileId: first), requested(tileId: second)];
    const resolver = BaseMapRenderTileResolver();

    final firstRun = resolver.resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );
    final secondRun = resolver.resolve(
      requestedCover: cover,
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
    );

    expect(
      secondRun.map((tile) => tile.tileId),
      firstRun.map((tile) => tile.tileId).toList(),
    );
  });

  test('rejects a negative parent fallback limit', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );

    expect(
      () => const BaseMapRenderTileResolver().resolve(
        requestedCover: const [],
        sourceInstanceId: sourceId,
        cache: cache,
        maxParentSteps: -1,
      ),
      throwsArgumentError,
    );
  });
  ```

- [ ] **Step 4: resolver の全behavior testをまとめて RED にする**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test \
    test/tile/base_map_render_tile_resolver_parent_test.dart \
    test/tile/base_map_render_tile_resolver_selection_test.dart \
    test/tile/base_map_render_tile_resolver_identity_test.dart
  ```

  Expected: 3ファイルとも FAIL（`BaseMapRenderTileResolver` / `BaseMapRenderTile` が未定義）。3つすべてのREDを確認するまでresolverのbranchを実装しない。

- [ ] **Step 5: ordered set semantics の resolver を実装する**

  Dart の挿入順 `Map` と `putIfAbsent` を使い、exact、parent、children の全variantを同じ `UnwrappedTileId` keyへ正規化する。

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
        throw ArgumentError.value(maxParentSteps, 'maxParentSteps');
      }
      final rendered = <UnwrappedTileId, BaseMapTileGeometry>{};
      for (final requestedTile in requestedCover) {
        final fallback = cache.lookupWithFallback(
          sourceInstanceId: sourceInstanceId,
          tileId: requestedTile.canonical,
          maxParentSteps: maxParentSteps,
        );
        switch (fallback) {
          case BaseMapTileFallbackMiss():
            continue;
          case BaseMapTileFallbackExact(:final geometry):
            rendered.putIfAbsent(requestedTile.toUnwrapped(), () => geometry);
          case BaseMapTileFallbackParent(:final tileId, :final geometry):
            final unwrapped = UnwrappedTileId(
              wrap: requestedTile.wrap,
              canonical: tileId,
            );
            rendered.putIfAbsent(unwrapped, () => geometry);
          case BaseMapTileFallbackChildren(:final children):
            final childIds = requestedTile.canonical.children();
            for (var index = 0; index < childIds.length; index++) {
              final unwrapped = UnwrappedTileId(
                wrap: requestedTile.wrap,
                canonical: childIds[index],
              );
              rendered.putIfAbsent(unwrapped, () => children[index]);
            }
        }
      }
      return List.unmodifiable([
        for (final entry in rendered.entries)
          BaseMapRenderTile(tileId: entry.key, geometry: entry.value),
      ]);
    }
  }
  ```

- [ ] **Step 6: resolver の全behavior testを GREEN にし、test群と実装を同じcommitにする**

  commit履歴でも「productionだけが先、behavior testが後」に見えないよう、Step 1〜5の3 testファイル・helper・resolverを1つのTDD単位としてstageする。この境界は全behaviorのRED証跡を保つため、30〜100行の目安よりatomicityを優先する。

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test \
    test/tile/base_map_render_tile_resolver_parent_test.dart \
    test/tile/base_map_render_tile_resolver_selection_test.dart \
    test/tile/base_map_render_tile_resolver_identity_test.dart \
    test/tile/base_map_tile_cache_test.dart
  mise exec -- dart format \
    lib/src/tile/base_map_render_tile_resolver.dart \
    test/tile/support/base_map_render_tile_test_support.dart \
    test/tile/base_map_render_tile_resolver_parent_test.dart \
    test/tile/base_map_render_tile_resolver_selection_test.dart \
    test/tile/base_map_render_tile_resolver_identity_test.dart
  cd ../..
  git diff --check
  git add \
    packages/eqmonitor_map/lib/src/tile/base_map_render_tile_resolver.dart \
    packages/eqmonitor_map/test/tile/support/base_map_render_tile_test_support.dart \
    packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_parent_test.dart \
    packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_selection_test.dart \
    packages/eqmonitor_map/test/tile/base_map_render_tile_resolver_identity_test.dart
  git commit -m "Fix: fallback描画単位を決定的に解決"
  git push
  ```

- [ ] **Step 7: 共通orchestration entryの Scene非依存 failing regression test を書く**

  `base_map_render_plan_builder_test.dart` で、`dart:typed_data`、mesh/decode limit型、decoder/cache、`package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart`、`mvt/support/mvt_fixture_builder.dart`、`support/base_map_render_tile_test_support.dart` をimportする。testはresolverとbuilderを個別に呼ばず、productionの `BaseMapView` と同じ `buildBaseMapRenderPlans(...)` だけを呼ぶ。`extent: 2048` のMVTを実際にdecodeし、そのgeometryを祖先tileとしてcacheする。z5の兄弟2枚から同じz4祖先へfallbackさせ、最終planが「祖先のunwrapped tile ID」「decoded layer extent」「現在zoom」を同じtransform入力に束ねることを固定する。

  ```dart
  const builder = MvtFixtureBuilder();
  const limits = BaseMapTileDecodeLimits(
    mvtLimits: MvtDecodeLimits(
      maxLayers: 16,
      maxFeaturesPerLayer: 64,
      maxRingsPerFeature: 16,
      maxVerticesPerRing: 256,
      maxCommandsPerFeature: 1024,
      maxLayerNameBytes: 64,
    ),
    fillLimits: FillMeshBuilderLimits(
      maxHolesPerPolygon: 16,
      maxVerticesPerFeature: 4096,
      maxVerticesPerSegment: 65536,
    ),
    lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 65536),
    lineMiterLimit: 4,
  );

  test('uses fallback tile ID and decoded extent as matrix input', () {
    final feature = builder.buildFeature(
      geomType: MvtFixtureBuilder.geomTypePolygon,
      rawCommands: [
        ...builder.moveTo([(0, 0)]),
        ...builder.lineTo([(2048, 0), (-2048, 2048)]),
        ...builder.closePath(),
      ],
    );
    final geometry = decodeBaseMapTileSync(
      builder.buildTile(
        layers: [
          builder.buildLayer(
            name: 'countries',
            extent: 2048,
            features: [feature],
          ),
        ],
      ),
      limits,
    );
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const ancestor = CanonicalTileId(z: 4, x: 7, y: 6);
    cache.put(
      sourceInstanceId: sourceId,
      tileId: ancestor,
      geometry: geometry,
      token: cache.beginDecode(),
    );
    final plans = buildBaseMapRenderPlans(
      requestedCover: [
        requested(tileId: ancestor.children()[0]),
        requested(tileId: ancestor.children()[1]),
      ],
      sourceInstanceId: sourceId,
      cache: cache,
      maxParentSteps: 2,
      zoom: 5.25,
    );
    expect(
      plans.map((plan) => plan.layerGeometry.styleLayerId),
      ['countriesFill', 'countriesLine'],
    );
    final countriesFill = plans.singleWhere(
      (plan) => plan.layerGeometry.styleLayerId == 'countriesFill',
    );

    expect(
      countriesFill.transformInput.tileId,
      const UnwrappedTileId(wrap: 0, canonical: ancestor),
    );
    expect(countriesFill.transformInput.extent, 2048);
    expect(countriesFill.transformInput.zoom, 5.25);
    expect(countriesFill.layerGeometry.extent, 2048);
  });

  test('rejects a mesh-bearing layer without an extent', () {
    final cache = BaseMapTileCache(
      maxEntries: 16,
      maxParentFallbackSteps: 2,
    );
    const tileId = CanonicalTileId(z: 0, x: 0, y: 0);
    cache.put(
      sourceInstanceId: sourceId,
      tileId: tileId,
      geometry: BaseMapTileGeometry(
        layers: [
          BaseMapTileFillLayerGeometry(
            styleLayerId: 'countriesFill',
            extent: null,
            meshes: [
              FillMesh(
                positions: Float32List.fromList([0, 0, 1, 0, 0, 1]),
                indices: Uint16List.fromList([0, 1, 2]),
                vertexCount: 3,
              ),
            ],
          ),
        ],
      ),
      token: cache.beginDecode(),
    );

    expect(
      () => buildBaseMapRenderPlans(
        requestedCover: [requested(tileId: tileId)],
        sourceInstanceId: sourceId,
        cache: cache,
        maxParentSteps: 2,
        zoom: 0,
      ),
      throwsA(
        isA<StateError>().having(
          (error) => error.message,
          'message',
          'countriesFill has meshes without an MVT extent.',
        ),
      ),
    );
  });
  ```

- [ ] **Step 8: 共通orchestration entryの regression test を RED にする**

  Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_render_plan_builder_test.dart`

  Expected: FAIL（`buildBaseMapRenderPlans`、`BaseMapLayerRenderPlan`、`BaseMapTileTransformInput` が未定義）。resolverはすでにGREENなので、このREDはresolver→plan構築の共通entryだけを示す。

- [ ] **Step 9: Scene非依存の orchestration entry と内部builderを実装する**

  `base_map_render_plan_builder.dart` は Flutter Scene 型をimportしない。package-visibleな入口は `buildBaseMapRenderPlans(...)` 一つだけで、ここがresolverを呼び、その結果をprivateな `_BaseMapRenderPlanBuilder` へ渡す。内部builderはlayer順を `baseMapLayerSpecs`、tile順をresolver出力から得て、meshがあるlayerだけをplanにする。meshがあるのにextentがない状態は黙って4096へfallbackせず失敗させる。

  ```dart
  @immutable
  final class BaseMapTileTransformInput {
    const BaseMapTileTransformInput({
      required this.tileId,
      required this.zoom,
      required this.extent,
    });

    final UnwrappedTileId tileId;
    final double zoom;
    final int extent;
  }

  @immutable
  final class BaseMapLayerRenderPlan {
    const BaseMapLayerRenderPlan({
      required this.tileGeometry,
      required this.layerGeometry,
      required this.transformInput,
    });

    final BaseMapTileGeometry tileGeometry;
    final BaseMapTileLayerGeometry layerGeometry;
    final BaseMapTileTransformInput transformInput;
  }

  List<BaseMapLayerRenderPlan> buildBaseMapRenderPlans({
    required List<OverscaledTileId> requestedCover,
    required String sourceInstanceId,
    required BaseMapTileCache cache,
    required int maxParentSteps,
    required double zoom,
  }) {
    final renderTiles = const BaseMapRenderTileResolver().resolve(
      requestedCover: requestedCover,
      sourceInstanceId: sourceInstanceId,
      cache: cache,
      maxParentSteps: maxParentSteps,
    );
    return const _BaseMapRenderPlanBuilder().build(
      renderTiles: renderTiles,
      zoom: zoom,
    );
  }

  final class _BaseMapRenderPlanBuilder {
    const _BaseMapRenderPlanBuilder();

    List<BaseMapLayerRenderPlan> build({
      required List<BaseMapRenderTile> renderTiles,
      required double zoom,
    }) {
      final plans = <BaseMapLayerRenderPlan>[];
      for (final spec in baseMapLayerSpecs) {
        if (spec.kind == BaseMapLayerKind.background) {
          continue;
        }
        for (final renderTile in renderTiles) {
          final layer = renderTile.geometry.layers.singleWhere(
            (candidate) => candidate.styleLayerId == spec.styleLayerId,
          );
          final meshes = switch (layer) {
            BaseMapTileFillLayerGeometry(:final meshes) => meshes,
            BaseMapTileLineLayerGeometry(:final meshes) => meshes,
          };
          if (meshes.isEmpty) {
            continue;
          }
          final extent = layer.extent;
          if (extent == null) {
            throw StateError(
              '${layer.styleLayerId} has meshes without an MVT extent.',
            );
          }
          plans.add(
            BaseMapLayerRenderPlan(
              tileGeometry: renderTile.geometry,
              layerGeometry: layer,
              transformInput: BaseMapTileTransformInput(
                tileId: renderTile.tileId,
                zoom: zoom,
                extent: extent,
              ),
            ),
          );
        }
      }
      return List.unmodifiable(plans);
    }
  }
  ```

- [ ] **Step 10: 共通orchestration entryの regression test を GREEN にしてcommitする**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test test/tile/base_map_render_plan_builder_test.dart
  mise exec -- dart format lib/src/tile/base_map_render_plan_builder.dart test/tile/base_map_render_plan_builder_test.dart
  cd ../..
  git diff --check
  git add packages/eqmonitor_map/lib/src/tile/base_map_render_plan_builder.dart packages/eqmonitor_map/test/tile/base_map_render_plan_builder_test.dart
  git commit -m "Fix: fallbackとextentを描画計画へ統合"
  git push
  ```

- [ ] **Step 11: BaseMapView を検証済みrender planへ配線する**

  `base_map_view.dart` は `package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart` をimportする。`_refresh` の `cover`、`_visibleTileCount = cover.length`、`_requestMissingDecodes(cover)` は変更しない。`_rebuildSceneNodes` は Step 7 のtestと同じ `buildBaseMapRenderPlans(...)` を同じnamed argument一式で一度だけ呼ぶ。resolverや内部builderを直接呼ばない。既存のfallback variant switch、layer/tileの再解決、`mvtDefaultExtent` importと固定値コメントを削除し、BaseMapViewはplanの `transformInput` だけを行列関数へ渡す。

  transform cacheのkeyは `(UnwrappedTileId, int extent)` とする。`zoom` は1回の `_rebuildSceneNodes` 中では `_camera.zoom` で固定され、`BaseMapTileTransformInput.zoom` としてplanに含まれる。`baseMapTileViewProjectionMatrixFor` のdouble精度行列は最後に一度だけ `scene_math.Matrix4.fromList` へ変換する。

  ```dart
  final plans = buildBaseMapRenderPlans(
    requestedCover: cover,
    sourceInstanceId: source.sourceInstanceId,
    cache: _cache,
    maxParentSteps: limits.maxParentFallbackSteps,
    zoom: _camera.zoom,
  );
  final transformCache = <(UnwrappedTileId, int), scene_math.Matrix4>{};
  scene_math.Matrix4 transformFor(BaseMapTileTransformInput input) =>
      transformCache.putIfAbsent(
        (input.tileId, input.extent),
        () => scene_math.Matrix4.fromList(
          baseMapTileViewProjectionMatrixFor(
            camera: _camera,
            viewport: viewport,
            tileId: input.tileId,
            zoom: input.zoom,
            extent: input.extent,
          ).storage,
        ),
      );
  final nodes = <scene.Node>[
    for (final plan in plans)
      ..._nodesFor(
        plan: plan,
        materialsByStyleLayerId: materialsByStyleLayerId,
        transform: transformFor(plan.transformInput),
      ),
  ];
  ```

  `_nodesFor` は `plan.tileGeometry` をGPU mesh cacheへ、`plan.transformInput.tileId.canonical` をcache keyへ渡し、`plan.layerGeometry.styleLayerId` のmeshだけを選ぶ。tile ID・extent・layer順はここで再計算しない。

  ```dart
  final meshesByLayer = _sceneMeshCache.getOrBuild(
    sourceInstanceId: source.sourceInstanceId,
    tileId: plan.transformInput.tileId.canonical,
    geometry: plan.tileGeometry,
    geometryFactory: _geometryFactory,
    materialsByStyleLayerId: materialsByStyleLayerId,
  );
  final meshes = meshesByLayer[plan.layerGeometry.styleLayerId];
  if (meshes == null || meshes.isEmpty) {
    return const [];
  }
  ```

- [ ] **Step 12: Scene非依存境界とBaseMapView integrationを検証し、commitする**

  ```bash
  cd packages/eqmonitor_map
  mise exec -- flutter test \
    test/tile/base_map_render_tile_resolver_parent_test.dart \
    test/tile/base_map_render_tile_resolver_selection_test.dart \
    test/tile/base_map_render_tile_resolver_identity_test.dart \
    test/tile/base_map_render_plan_builder_test.dart \
    test/tile/base_map_tile_cache_test.dart \
    test/tile/base_map_tile_decoder_test.dart \
    test/geo/tile_matrix_test.dart \
    test/widget/base_map_view_test.dart
  mise exec -- dart format lib/src/widget/base_map_view.dart
  cd ../..
  git diff --check
  git --no-pager diff -- packages/eqmonitor_map/lib/src/widget/base_map_view.dart
  git add packages/eqmonitor_map/lib/src/widget/base_map_view.dart
  git commit -m "Refactor: extentとfallbackの描画解決を統合"
  git push
  ```

### Task 3: BaseMap camera support boundary と検証結果を文書化する

**Files:**

- Modify: `packages/eqmonitor_map/README.md`
- Modify: `docs/todo/800_eqmonitor_map_deferred_verification.md`
- Create: `docs/knowledge/20260809_flutter_scene_base_map_camera.md`

**Interfaces:**

- Formal route: `BaseMapView` の恒等 `scene.NodeCamera` + `baseMapTileViewProjectionMatrixFor(...)` を node `localTransform` へ一度だけ設定する経路。
- Unsupported in #1589: `createSceneSpikeCameraSetup()` が返す `NodeCamera + FlutterSceneOrthographicProjection`、`FlutterSceneSpikeView`、`BaseMapMaterialPreflightView` の可視描画。これらの実装修正・削除は #1593 で lifecycle/context recovery と一緒に扱う。

- [ ] **Step 1: README を現在の自動受け入れ結果へ更新する**

  次を事実として記載する。

  - Line flood の原因は custom attribute slot/stride で、`texCoords` と NDC 半線幅へ移行済み。原因未特定・未修正という現行 warning は削除する。
  - source layer ごとの extent は decode→`BaseMapTileLayerGeometry.extent`→Scene非依存render plan→layer node行列へ伝播し、2048/8192 fixture、祖先fallbackを通したtransform入力、行列testで検証済み。
  - fallback は要求 cover/decode を保ったまま `UnwrappedTileId` で重複排除し、同一祖先を重ねないことを unit test で検証済み。
  - #1589 の正式 camera は BaseMap の identity Scene camera + node transform だけである。
  - spike/preflight の custom NodeCamera projection は可視出力未確認の diagnostic pathであり、#1589 の supported route ではない。削除・再配線・resize/lifecycle検証は #1593 の対象である。
  - 今回は device/simulator/E2E を実施していない。過去の iOS simulator evidence は当時の BaseMap Fill/pan 観測履歴に限られ、今回の extent/fallback/camera boundary を検証しない。
  - Android/iOS GPU、実際の pinch、祖先fallbackの画面差し替え、非4096 archive表示は残余platform riskである。

- [ ] **Step 2: deferred verification 文書から完了した残件だけを除く**

  `docs/todo/800_eqmonitor_map_deferred_verification.md` から次だけを削除する。

  - geometry が extent を運ばず renderer が4096固定だった項目。
  - 同一祖先 fallback の重複描画項目。

  spike camera の未描画事実は「#1589ではBaseMapだけを正式化し、spike/preflightは#1593」と更新して残す。properties/feature ID、join/cap/dash、scissor、varint、実tile hole fixture、6 byte packing、label/remote/attestation/hit test/HUD、widget/golden、performance、物理端末 smoke は削除しない。

- [ ] **Step 3: BaseMap camera 契約を knowledge に記録する**

  `docs/knowledge/20260809_flutter_scene_base_map_camera.md` に次を500行以内で書く。

  ```markdown
  # BaseMapのFlutter Scene camera契約

  ## #1589で正式な経路

  `scene.NodeCamera`のprojectionは恒等にし、CPUのdouble精度で
  `clip = viewProjection * tileMatrix * position`を合成してから、各nodeの
  `localTransform`へ一度だけ渡す。custom materialのline押し出しはclip/NDC
  空間で行うため、半線幅もviewport由来のNDC単位にする。

  ## #1589で正式ではない経路

  spike/preflightの`NodeCamera + FlutterSceneOrthographicProjection`はこのpinで
  可視出力を確認できていない。BaseMapの成立根拠にせず、#1593でGPU lifecycle、
  context recovery、resizeと一緒に扱う。

  ## 自動確認

  cd packages/eqmonitor_map
  mise exec -- flutter test test/geo/tile_matrix_test.dart test/tile/base_map_render_plan_builder_test.dart
  ```

- [ ] **Step 4: repositoryの自動受け入れを実行する**

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

  Expected: 全command PASS。device一覧取得、`flutter run`、integration test、golden、E2Eは実行しない。

- [ ] **Step 5: scope と文書差分を確認する**

  ```bash
  git --no-pager diff --stat
  git --no-pager diff
  git status --short
  ```

  Expected:

  - #1590 foundation files、#1593 Scene/spike/preflight production files、app production files、PMTiles reader production filesに差分がない。
  - 完了した extent/fallback residual だけが deferred verification から消え、spike/platform risk は残る。
  - README は automated result、過去 simulator 観測、今回未実施のplatform確認を別々に記載する。
  - 未確定マーカーや内容を省いた実装指示がない。

- [ ] **Step 6: 文書commitを作ってpushする**

  ```bash
  git add packages/eqmonitor_map/README.md docs/todo/800_eqmonitor_map_deferred_verification.md docs/knowledge/20260809_flutter_scene_base_map_camera.md
  git commit -m "Docs: ベースレイヤー残件の検証結果を記録"
  git push
  ```

---

## Acceptance Matrix

| Issue #1589 residual | Automated substitute | Remaining platform risk |
|---|---|---|
| per-layer MVT extent | 2048/8192 MVT fixture、cache metadata test、tile-local center-to-clip matrix test | 非4096 production archive のGPU表示は未確認 |
| ancestor fallback duplicate | parent重複、exact順、children順、miss、wrap、repeat determinism の literal unit tests +既存cache探索順test | pinch中の祖先差し替えを画面では未確認 |
| camera wiring | decoded extent 2048 + ancestor fallbackから最終 `tileId/extent/zoom` のtransform入力を作るrender-plan test、BaseMap identity camera + node transformのコード・README・knowledge整合、tile matrix test | spike/preflight、resize、surface lifecycle、GPU可視性は#1593 |
| regression | eqmonitor_map全test、pmtiles_v3/seismicity_pmtiles test、app/3 package analyze | device lifecycle、GPU resource rebuild、performanceは別のdeferred verification |

## Completion Criteria

- `BaseMapView` から renderer 固有の `mvtDefaultExtent` 参照がなく、meshを持つ各layerのdecode済みextentがnode transformに使われる。
- `BaseMapView` と回帰testは同じ `buildBaseMapRenderPlans(...)` を呼び、このentryが確定したfallback後tile ID・extent・zoomをそのまま `baseMapTileViewProjectionMatrixFor` へ渡す。Widget内にresolver→builderの重複経路を持たない。
- 同じ `(world wrap, canonical ancestor)` は1 layerにつき1回だけnode展開される。異なるwrap、layer、要求cover、decode requestは統合されない。
- #1589の正式camera経路がBaseMap identity camera + node transformに限定され、spike/preflightを修正済み・確認済みと表現しない。
- README、deferred verification、knowledgeが自動確認済み範囲、過去simulator履歴、未確認platform riskを正確に分ける。
- 指定したformat/analyze/unit testが通り、device/simulator/E2Eを受け入れblockerにしていない。
