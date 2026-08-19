# dashmap 調査レポート

## 1. Overview

`bdero/dashmap` は、`flutter_scene` 上で動くライブ 3D ワールドマップのデモアプリです。README は「terrain-RGB elevation tile + 衛星画像 + OSM building extrusion + 物理 sky + globe wrap」を主眼としており、EQMonitor が構築中の PMTiles/MVT ベースの 2D base map renderer とは入力データと初期目的が大きく異なります。

- 参照 repo: `https://github.com/bdero/dashmap`
- 取得状態: `/tmp/refs/dashmap` へ `--depth 50` clone 成功
- 最新 commit: `a6ff92edd999e922f81d26d209d8f589faee3fd0`
- 最新 commit 日時: `2026-08-06T23:59:09-07:00`
- Author: `Brandon DeRosier <x@bdero.me>`
- License: MIT (`LICENSE`)
- Dart SDK: `^3.13.0-256.0.dev`
- Flutter SDK: lockfile 上 `>=3.44.0`
- `flutter_scene`: `pubspec.yaml` では `../../flutter_scene/packages/flutter_scene` の path 依存、`pubspec.lock` 上の package version は `0.18.1`
- `flutter_gpu_shaders`: `0.5.1`

README の scope は次のとおりです。

```markdown
# Dashmap

A live 3D world-map demo built on [flutter_scene](https://pub.dev/packages/flutter_scene). Fly over real terrain streamed from open data, with satellite imagery draped on the surface, extruded OpenStreetMap buildings in cities, and a physical sky whose sun drives the lighting and shadows. Zoom out far enough and the flat map wraps onto the whole planet.
```

根拠: `README.md`, `LICENSE`, `pubspec.yaml`, `pubspec.lock`, `git log -1`。

## 2. Data Pipeline

dashmap は PMTiles/MVT を使っていません。確認した範囲では、主な入力は次です。

- Elevation: AWS Open Data Terrarium raster tile (`https://s3.amazonaws.com/elevation-tiles-prod/terrarium/{z}/{x}/{y}.png`)
- Imagery: Esri World Imagery raster tile (`https://server.arcgisonline.com/.../{z}/{y}/{x}`)
- Buildings: Overpass API の JSON (`way["building"](...);out geom`)
- Search: Photon API
- Local cache: raster は raw bytes、building は gzipped JSON

`lib/map/tiles/tile_source.dart`:

```dart
static const esriWorldImagery = ImagerySource(
  name: 'Esri World Imagery',
  urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  attribution:
      'Imagery (c) Esri, Maxar, Earthstar Geographics, and the GIS community',
  maxZoom: 19,
);
```

`lib/map/tiles/tile_fetcher.dart` は HTTP fetch に 20 秒 timeout を置き、任意の `TileByteCache` を read-through/write-through で使います。PNG/JPEG decode は `dart:ui` の `instantiateImageCodec` と `toByteData` を使うため、コメント上も「main isolate で必要」とされています。

```dart
/// Fetches and decodes raster tiles over HTTP, reading through the optional
/// [cache] so every downloaded tile persists to disk and revisited areas never
/// re-hit the network. Requests carry a hard deadline; a hung connection must
/// fail fast or it pins one of the streamer's in-flight slots and streaming
/// grinds to a halt. Decoding to a `ui.Image` and reading its pixels must
/// happen on the main isolate for now.
```

ただし、elevation RGBA から heightfield mesh を作る処理と、building footprint から extrusion mesh を作る処理は native で `Isolate.run` に逃がしています。Web は isolate なしの同期 fallback です。

`lib/map/terrain/tile_mesh_worker.dart`:

```dart
Future<HeightfieldMesh> runTileMeshJob(TileMeshJob job) {
  if (kIsWeb) return Future.value(buildTileMesh(job));
  return Isolate.run(() => buildTileMesh(job));
}
```

`lib/map/buildings/building_worker.dart`:

```dart
Future<List<BuildingMesh>> runBuildingMeshJob(BuildingMeshJob job) {
  if (kIsWeb) return Future.value(buildBuildingTileChunks(job));
  return Isolate.run(() => buildBuildingTileChunks(job));
}
```

Overpass JSON の parse は `OverpassClient.fetchBuildings` 内で `parseBuildings(response.body)` を同期実行しています。`parseBuildings` の doc comment は worker-safe と書いていますが、現実の fetch path では別 isolate へ送っている箇所は確認できませんでした。

## 3. Geometry Generation

### Terrain

terrain は raster elevation を `Heightfield` に変換し、固定 resolution の格子 mesh を生成します。各 vertex は `+X east`, `+Y up`, `+Z north`、UV は tile normalized `(u, v)` です。normal は finite difference で生成し、index は `Uint16List` です。

`lib/map/terrain/heightfield_mesh.dart`:

```dart
positions
  ..add((u - 0.5) * groundSize) // +X east
  ..add(displayHeight(u, v)) // +Y up
  ..add((0.5 - v) * groundSize); // +Z north (v = 0 is the north edge)
```

tile 境界の隙間対策として、perimeter vertex を下へ複製する skirt を追加できます。

```dart
/// Adds a vertical apron around the tile border, dropped [skirtDepth] below each
/// edge vertex, so a hairline gap to a neighboring tile is filled by geometry
/// rather than showing the background. Emitted double-sided so it hides the
/// crack from any grazing angle.
```

これは EQMonitor の MVT line/fill の tile buffer clip 問題を直接解くものではありませんが、「tile 境界の見た目はデータ任せにせず、renderer 側で明示的な境界処理を持つ」という点は再利用できます。

### Buildings

建物は Overpass の way geometry を lon/lat ring として parse し、tile center 基準の Mercator meter へ変換します。建物ごとに terrain heightfield を sample し、ring 上の最低地盤に `baseY` を置き、OSM の `height` / `building:levels` / default height で `topY` を決めます。

`lib/map/buildings/building_worker.dart`:

```dart
final baseY =
    (minGround - job.referenceElevation - 2.0) * job.verticalScale;
final topY =
    baseY +
    (building.height + 2.0) * job.verticalScale +
    // Tiny deterministic height jitter so identical default-height rows
    // don't read as one slab.
    (building.id % 7) * 0.15 * job.verticalScale;
```

mesh 生成は roof cap + wall quads です。roof cap は自前の O(n^2) ear clipping、holes は未対応です。

`lib/map/buildings/building_mesh.dart`:

```dart
/// Extrudes and batches [footprints] into one mesh. Rings are normalized to
/// counterclockwise in (east, north); degenerate or self-intersecting rings
/// that fail to triangulate are skipped. TODO(building-holes): multipolygon
/// relations (courtyards) are not yet handled; only outer ways are extruded.
```

```dart
final capTriangles = _earClip(ring);
if (capTriangles.isEmpty) continue;
```

mesh は `kBuildingChunkVertexBudget = 24000` で chunk 分割され、GPU upload は frame ごとに 1 chunk ずつ行われます。

```dart
/// Upper bound on vertices per emitted mesh chunk. A dense downtown tile
/// batches to hundreds of thousands of vertices, and the interleave/pack in
/// the engine's geometry upload runs on the main isolate; splitting into
/// chunks applied one per frame turns one long hitch into a short amortized
/// trickle.
const int kBuildingChunkVertexBudget = 24000;
```

### Fill / Line / Extrusion

dashmap には MVT fill layer、MVT line layer、line stroking 実装はありません。したがって次は unknown です。

- MVT polygon triangulation
- MVT line join/cap/stroke
- line width の画面空間・world 空間・NDC 空間の扱い
- MVT tile buffer の polygon/line clipping
- vector tile extent の扱い

確認した対象: `lib/map/**`, `assets/*.fmat`, `test/*` を検索し、`pmtiles`, `mvt`, `stroke`, `Polyline`, `line`, `clip`, `simplif`, `scissor` の関連実装を確認しました。line は UI 文言やコメント以外に vector line renderer としては見つかりませんでした。

## 4. Materials / Shaders

custom material は `.fmat` 2本です。

- `assets/globe_terrain.fmat`: lit terrain、satellite imagery texture、globe wrap vertex 処理
- `assets/globe_solid.fmat`: lit solid color、buildings 用、同じ globe wrap vertex 処理

登録は build hook で `buildMaterials` を呼ぶだけです。

`hook/build.dart`:

```dart
await buildMaterials(
  buildInput: config,
  buildOutput: output,
  assetMode: MaterialAssetMode.dataAssetsIfAvailable,
);
```

material load と uniform/texture 設定は `loadFmatMaterial` と `material.parameters` です。

`lib/map/terrain/terrain_streamer.dart`:

```dart
final material = await loadFmatMaterial('assets/globe_terrain.fmat');
```

```dart
r.material.parameters.setTexture(
  'imagery',
  texture.gpuTexture,
  sampler: texture.sampledSampler,
);
```

`assets/globe_terrain.fmat` の parameters:

```glsl
parameters: [
  { type: sampler2d, name: imagery, hint: default_white },
  { type: vec2, name: curve_center, default: [0.0, 0.0] },
  { type: float, name: focus_merc_yn, default: 0.0 },
  { type: float, name: roughness, hint: range(0.0, 1.0, 0.01), default: 0.95 },
],
```

`assets/globe_solid.fmat` の parameters:

```glsl
parameters: [
  { type: vec2, name: curve_center, default: [0.0, 0.0] },
  { type: float, name: focus_merc_yn, default: 0.0 },
  { type: vec4, name: base_color, hint: source_color, default: [0.82, 0.8, 0.78, 1.0] },
  { type: float, name: metallic, hint: range(0.0, 1.0, 0.01), default: 0.0 },
  { type: float, name: roughness, hint: range(0.0, 1.0, 0.01), default: 0.85 },
],
```

globe wrap は vertex shader で `vertex.world_position` と `vertex.world_normal` を書き換えます。大きな絶対 Mercator 値を shader 内で差し引かないよう、CPU 側で `curve_center` と `focus_merc_yn` を渡し、相対値中心で計算しています。

`assets/globe_terrain.fmat`:

```glsl
vec2 rel = vertex.world_position.xz - material_params.curve_center;
float yn = material_params.focus_merc_yn + rel.y / RE;
float phi = 2.0 * atan(exp(yn)) - HALF_PI;          // vertex latitude
float phi0 = 2.0 * atan(exp(material_params.focus_merc_yn)) - HALF_PI;
float dlam = rel.x / RE;                            // longitude delta
```

EQMonitor の現行 `packages/eqmonitor_map/assets/base_map_line.fmat` も shader-space の理解が重要です。現行コードは `vertex.world_position` が実質 NDC 相当になった後に `vertex.uv * half_width_ndc` を足す設計へ修正済みです。dashmap からは「material parameter がどの座標空間で効くかを `.fmat` 内の vertex stage と Scene camera wiring で必ず検証する」という教訓が取れます。

## 5. Camera / Coordinates / Depth

dashmap は perspective camera、yaw/pitch orbit、altitude zoom、keyboard pan、fly-to を持ちます。EQMonitor の初期設計である orthographic / north locked / 2D only とは異なります。

`lib/map/map_camera.dart`:

```dart
PerspectiveCamera build(FloatingOrigin origin) {
  final near = (distance * 0.02).clamp(5.0, 400000.0);
  final far = distance * 30 + 200000;
  return PerspectiveCamera(
    fovRadiansY: fovRadiansY,
    position: eye(origin),
    target: targetPoint(origin),
    fovNear: near,
    fovFar: far,
  );
}
```

座標系は Web Mercator meter + floating origin です。horizontal origin を camera focus 近傍へ rebase し、既存 mesh 自体は再生成せず node transform を再計算します。

`lib/map/geo/floating_origin.dart`:

```dart
/// Keeps the rendered world centered near the camera so kilometer-scale
/// coordinates stay inside float32 precision. The world frame is Web Mercator
/// projected meters relative to a moving [lon]/[lat] origin: East is `+X`, Up is
/// `+Y`, North is `+Z`
```

`lib/map/map_screen.dart`:

```dart
if (origin.horizontalDistance(camera.focusLon, camera.focusLat) >
    _rebaseThreshold) {
  origin.rebaseTo(camera.focusLon, camera.focusLat);
  streamer.recomputeTransforms();
  buildings.recomputeTransforms();
}
```

render ordering は明示的な phase sort ではなく、3D scene の depth と node visibility が中心です。terrain/buildings は lit material、back-face culling、depth buffer 前提の描画です。globe wrap により Flutter Scene の通常 bounds/frustum culling が効かないため、node の `frustumCulled = false` にした上で sphere horizon culling を独自に行います。

`lib/map/terrain/terrain_streamer.dart`:

```dart
..visible = _renderSet.contains(r.id)
// The globe wrap displaces vertices far from the flat bounds the
// engine culls against, so opt out of frustum culling.
..frustumCulled = false;
```

`lib/map/geo/horizon_cull.dart` は球面 horizon cap で far side を保守的に cull します。

## 6. Labels / Text

地図ラベルの描画はありません。確認した範囲では text は HUD、settings panel、search panel、attribution、error card など Flutter UI overlay だけです。GPU text も `TextPainter` による map label overlay もありません。

したがって、EQMonitor の「label anchor + Flutter `TextPainter` overlay」方針に対して直接流用できる label placement / collision / glyph atlas の実装はありません。

## 7. Performance Techniques

dashmap で確認できた性能上の工夫は次です。

1. Quadtree LOD / screen-space error: `TileSelector` が camera distance、FOV、viewport height、tile geometric error から refine を決定。
2. Coarse-to-fine stand-in: 子 tile が全部 ready になるまで親 tile を表示し、穴や overlap を避ける。
3. In-flight cap: terrain は `maxInFlight = 8`、building は `maxInFlight = 6`、Overpass live query は semaphore で `maxLiveQueries = 2`。
4. Apply budget: terrain は 1 frame に最大 3 tile、building は 1 frame に 1 chunk だけ GPU upload。
5. Worker isolate: elevation mesh と building extrusion mesh は native で `Isolate.run`。
6. Chunking: building は `24000` vertex budget で chunk 化し、dense downtown の upload hitch を分散。
7. Disk cache: raster raw bytes と building gzipped JSON を永続化し、cache miss 時だけ network。
8. Retry backoff: failed tile を exponential backoff で再試行。
9. Texture clamp: imagery texture は `clampToEdge`、mipmap なし。
10. Floating origin: camera focus から離れたら origin rebase し、float32 precision を維持。
11. Manual horizon culling: globe wrap で engine frustum culling を切る代わりに sphere visibility を計算。
12. Reduced cadence: LOD selection / streaming bookkeeping / material curve writes を約 15Hz (`66ms`) に制限し、GPU apply は毎 frame drain。

特に `TileSelector` の「render set は overlap なし、load set は ancestor pyramid を含む」という構造は、EQMonitor の tile fallback 仕様と近いです。

`lib/map/terrain/tile_selector.dart`:

```dart
/// Tiles to display this frame, chosen so they tile the ground with no
/// overlap: a node is shown subdivided only when all of its children are
/// ready, otherwise the node itself stands in.
final List<TileId> render;
```

## 8. EQMonitor への直接適用候補（優先順）

### P0: MVT extent を geometry / transform へ伝搬する

- dashmap: raster tile の `TileId.z` と `WebMercator.projectedTileSize(id.z)` から tile mesh の物理サイズを毎 tile で一貫して決めています。入力データのスケールを「どこかの固定値」に隠さず、mesh job に明示的に渡します。該当: `lib/map/terrain/terrain_streamer.dart`, `lib/map/terrain/tile_mesh_worker.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decoder.dart` は layer の `extent` を読みますが、`packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は `_combinedTransformFor` で `mvtDefaultExtent` を `tileMatrixFor` へ渡しています。`packages/eqmonitor_map/lib/src/geo/tile_matrix.dart` の doc comment は「extentはMVT layerが宣言する値をそのまま渡す。定数化しない」と書いていますが、`BaseMapTileGeometry` が extent を保持しないため現状は固定値です。
- 具体策: `BaseMapTileLayerGeometry` または layer geometry metadata に `extent` を保持し、`_nodesFor` / `_combinedTransformFor` を layer 単位の extent で計算できる形へ変える。layer ごとに extent が異なる MVT を拒否する policy にする場合も、decode 時に検証して明示的な typed error にする。
- 既知問題への効果: archive/layer が 4096 以外の extent を持つ場合、座標スケール不一致で巨大化・画面 flood・tile boundary ずれが起き得ます。ocean flood の第一候補として検証価値が高いです。

### P0: tile clip / buffer overdraw policy を renderer に持つ

- dashmap: vector tile clip はありませんが、terrain では texture sampler を `clampToEdge` にし、mesh skirt で tile 境界の隙間を renderer 側で隠します。該当: `lib/map/terrain/terrain_streamer.dart`, `lib/map/terrain/heightfield_mesh.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/mesh/line_mesh_builder.dart` は ring/line の中心線から stroke mesh を作りますが、tile buffer edge の scissor/clip はありません。README も「no scissor/clip at tile buffer edges」を既知問題にしています。
- 具体策: MVT buffer を含む source geometry は decode で保持しつつ、描画 mesh は tile visible rect `[0, extent]` に対する clip policy を持つ。Flutter Scene に scissor が使えるかは未確認なので、まず CPU side の line/polygon clip、または shader discard 用 clip rect uniform の可否を spike する。line は stroke 前 clip と stroke 後 clip の見た目が違うため、MapLibre 相当を参照して仕様化する。
- 既知問題への効果: buffer 内の境界線や polygon edge が隣接 tile 領域へ広く overdraw している場合、ocean flood / tile edge artifact の軽減に直結し得ます。

### P0: line width の座標空間を regression test 化する

- dashmap: line renderer はありません。ただし globe shader は `curve_center` と `focus_merc_yn` を通じて「vertex shader がどの空間で position を変更しているか」を明示し、大きな絶対値を避けています。該当: `assets/globe_terrain.fmat`, `assets/globe_solid.fmat`
- EQMonitor today: `packages/eqmonitor_map/assets/base_map_line.fmat` と `packages/eqmonitor_map/lib/src/flutter_scene/base_map_material_library.dart` は、旧 `half_width_world` 由来の flood を避けるため `half_width_ndc` に修正済みです。ただし README には line layer 由来の ocean flood が未解決として残っています。
- 具体策: `BaseMapMaterialLibrary.halfLineWidthNdcFor` の unit test に加え、shader path を GPU smoke で固定する。例えば 1px/2px 線の screen-space bounding box を debug capture で検証し、viewport resize と zoom 変更で線幅が変わらないことを確認する。custom attribute を避けて `texCoords` に extrude を載せる現行方針も、再発防止として report ではなく test/knowledge に固定する。
- 既知問題への効果: 線幅の座標空間取り違えは flood の直接原因になり得ます。現行修正が全 path で効いているか、layer/material instance ごとに確認する価値があります。

### P1: GPU upload / node apply を frame budget 化する

- dashmap: terrain は `_ready` から 1 frame 最大 `applyBudget = 3` tile、building は 1 frame 1 chunk だけ `MeshGeometry.fromArrays` します。該当: `lib/map/terrain/terrain_streamer.dart`, `lib/map/buildings/building_streamer.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は `_TileSceneMeshCache` で tile mesh の再 upload は避けていますが、`_rebuildSceneNodes` は refresh ごとに `sceneGraph.removeAll()` → `addAll(nodes)` です。
- 具体策: tile/layer/material key の render object を保持し、visibility/transform/material parameter の更新と、new mesh upload を command queue で分離する。decode 完了 tile の upload は frame budget を設ける。gesture 中は transform 更新だけに寄せ、node graph 全消し再追加を避ける。
- 効果: pan/pinch 時の hitch と Scene graph churn を減らし、将来の label/dynamic layer と併存しやすくなります。

### P1: ancestor stand-in / render cut の不変条件を明文化する

- dashmap: `TileSelector` は render set が重ならないこと、子が揃うまでは親を stand-in にすることを unit test しています。該当: `lib/map/terrain/tile_selector.dart`, `test/tile_selector_test.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は `BaseMapTileCache.lookupWithFallback` を使い、README にも祖先 fallback の unit test 済みとあります。
- 具体策: cover → fallback resolution → render node list の段階で「同じ screen area を親子で重複描画しない」「欠けがある場合の優先順位」を property/test 化する。line/fill flood の切り分けでも、重複 tile 描画による見かけの濃さや塗り潰しを除外できます。

### P1: retry/backoff と known-absent の扱いを source policy 化する

- dashmap: failed tile は exponential backoff、sparse/empty は cache に残します。該当: `lib/map/terrain/terrain_streamer.dart`, `lib/map/buildings/building_streamer.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` は tile bytes `null` を `_knownAbsentTiles` に追加して再読込を避けます。decode error は `debugPrint` で tile miss のまま進めます。
- 具体策: base map の欠損、decode error、semantic error を区別する typed state を持つ。生命に関わる dynamic/hazard source では fail closed、base map では fallback/placeholder など policy を分離する。

### P2: 将来 3D 用に floating origin / Mercator meter path を参考にする

- dashmap: focus 近傍へ horizontal origin を rebase し、mesh は local meter、node transform を再計算します。該当: `lib/map/geo/floating_origin.dart`, `lib/map/map_screen.dart`
- EQMonitor today: `packages/eqmonitor_map/lib/src/geo/tile_matrix.dart` は double のまま `viewProjection * tileMatrix` を合成し、最後に float32 へ丸める設計です。2D orthographic では十分ですが、将来の 3D terrain / underground hypocenter / fault plane では meter 系 Z と Mercator scale の扱いが重要です。
- 具体策: 3D camera TODO では dashmap の `FloatingOrigin` と `MapCamera` を参考に、地理座標、Mercator meter、altitude meter、render-local float の境界を先に固定する。ただし現行 2D base map の pixel-based MapLibre 互換行列へ無理に混ぜない。

### P2: building extrusion の worker/chunking は将来の 3D hazard 表現に転用可能

- dashmap: footprint を worker-safe DTO にし、extrusion mesh を chunk 化して UI isolate で段階 upload します。該当: `lib/map/buildings/building_worker.dart`, `lib/map/buildings/building_mesh.dart`
- EQMonitor today: fault plane、underground hypocenter、terrain は deferred。
- 具体策: fault plane / hypocenter volume など 3D mesh は、UI isolate で mesh を組まず、worker output を flat typed buffer として返し、upload budget を通す設計にする。

## 9. Things NOT to Copy

1. Live third-party data source を render path に入れること。dashmap は Esri/AWS/Overpass/Photon へ live HTTP しますが、EQMonitor の base map は Asset Pack attestation と PMTiles digest/sidecar 検証が前提です。未検証 network tile を renderer が直接読む構造はコピーしない。
2. OSM default height / deterministic jitter。dashmap は見た目のために `defaultHeight = 8.0` や `(building.id % 7) * 0.15` を使います。EQMonitor は生命に関わる情報を扱うため、震源・断層・hazard 表現で推測値や乱数的 jitter を事実のように描かない。
3. GeoJSON/JSON を hot render path に置くこと。dashmap の building cache は gzipped JSON、Overpass parse は `Map<String, dynamic>` です。EQMonitor の design doc は「描画経路で GeoJSON や JSON serialization を使わない」と明記しています。
4. StatefulWidget 中心の大きな screen controller。dashmap の `MapScreen` は demo として妥当ですが、EQMonitor の Flutter 規約では HookWidget/HookConsumerWidget、layered repository/provider、Action/Flow 分離が必要です。
5. Building holes 未対応 ear clipping を MVT polygon fill へ流用すること。EQMonitor の `FillMeshBuilder` はすでに `dart_earcut` と ring winding/holes を扱っています。dashmap の `_earClip` は hole-free building roof 専用です。
6. 3D perspective / globe wrap を初期 2D renderer に混ぜること。dashmap の camera と shader は魅力的ですが、EQMonitor の初期 scope は north-locked orthographic です。3D 化は projection abstraction が固まった後の deferred task にするべきです。
7. `frustumCulled = false` を無条件に真似ること。dashmap は globe wrap で bounds が壊れるため manual horizon culling とセットで無効化しています。EQMonitor の 2D tile は通常の bounds/culling を活かせる可能性があり、無効化だけをコピーすると描画負荷が増えます。
8. unbounded disk cache。dashmap の `TileByteCache` には `TODO(cache-eviction)` があり、長時間 roaming で数百 MB 蓄積する可能性を自認しています。EQMonitor の Asset Pack / PMTiles cache は manifest policy と size limit を持つべきです。

## まとめ

dashmap は EQMonitor の MVT fill/line renderer の直接の参考実装ではありません。PMTiles/MVT、line stroking、MVT extent、tile buffer clipping、label placement はほぼ unknown です。

一方で、Flutter Scene 実運用としては、`.fmat` build hook、`loadFmatMaterial` と uniform/texture 更新、worker isolate での mesh build、GPU upload の frame budget 化、floating origin、quadtree LOD/fallback、texture/tile edge の明示的対策が具体的に参考になります。

既知の ocean flood / line-width / tile-clip 問題に最も近い lesson は、dashmap の vector 実装そのものではなく、(1) 入力 tile のスケール値を固定値にしない、(2) shader の座標空間を material parameter と一緒に検証する、(3) tile 境界 overdraw を renderer policy として持つ、の 3点です。
