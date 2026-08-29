# EQMonitor Map Earthquake Overlay Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 実地震データのJMA区域塗りと観測点円を、`EQMonitor Map (Flutter Scene)` デバッグ画面のベース地図へFlutter Scene/GPUで重ねる。

**Architecture:** MVT decode時に区域code付きpolygonを保持し、app非依存のimmutable snapshotからexact tileだけを選択してFill packetと単一のstation instance batchを組み立てる。単一Scene compositorが透過phaseを管理し、app側は最新地震詳細とテーマ色をsnapshotへ変換して`BaseMapView`へ渡す。

**Tech Stack:** Flutter/Dart、Riverpod 3、Freezed、flutter_scene fork、Flutter GPU raw shader、PMTiles/MVT、iOS Simulator

**Spec:** `docs/superpowers/specs/2026-08-23-eqmonitor-map-earthquake-overlay-design.md`

## Global Constraints

- Flutter/Dartコマンドはすべて `mise exec --` 経由で実行する。
- 本番コードを書く前に、その振る舞いを示すテストを追加してREDを確認する。生成コードとshader設定は、直接テストできる最初のconsumer境界で検証する。
- `eqmonitor_map` はappの `Earthquake`、`EarthquakeIntensity`、`JmaIntensity`、MapLibre、GeoJSONへ依存しない。
- MVTはfield順を仮定せず二段階decodeし、不正なtag/valueはtile全体をtyped exceptionでfail closedする。
- overlayはexact canonical tileだけを使い、親・子・異revisionへfallbackしない。
- zoom 6未満はregion、zoom 6以上はcity、stationはzoom 6以上だけを描画する。city欠損時にregionへfallbackしない。
- Scene所有者は1つとし、透過priorityはbase=0、region=100、city=200、station=300、label=400とする。
- observation instance layoutはcorner `float32x2/stride 8`、instanceはcenter `float32x2@0`、color `float32x4@8`、radius `float@24`、stride 28とする。
- `ObservationFrame` uniformはstd140 vec4×2の32 byte。radius/stroke/viewportはlogical pixelでDPRを掛けない。
- 同じ `StaticInstanceGeometry` を複数nodeへ共有しない。snapshot置換・background・surface generation変更・disposeではframes-in-flight後に `retire()` する。
- loading、event切替、error、震度なしでは旧overlayを消す。不完全coverageを完全な震度分布として表示しない。
- 既存MapLibre経路は変更・削除しない。
- `app/ios/Runner/Frameworks/LiveActivityUtil.xcframework/Info.plist` の既存変更は対象外であり、stage・commitしない。
- PR/Issueを作る場合はYumNumm orgだけを対象にし、`--repo YumNumm/<repo>`を明示する。本計画はPR作成を含まない。
- 1コミット30〜100行を目安に分割し、英語1語prefix＋日本語要約でcommitし、作業branchへpushする。

## File Structure

| Path | Responsibility |
|---|---|
| `third_party/flutter_scene/packages/flutter_scene/lib/src/node.dart` | 公開透過sort priority |
| `third_party/flutter_scene/packages/flutter_scene/lib/src/render/render_scene.dart` | node priorityを保持するflat render item |
| `third_party/flutter_scene/packages/flutter_scene/lib/src/scene_encoder.dart` | priority優先、同priority内depth順の透過sort |
| `packages/eqmonitor_map/lib/src/tile/mvt/*` | property付きMVT decode |
| `packages/eqmonitor_map/lib/src/tile/earthquake_area_tile_geometry.dart` | code付き区域geometry |
| `packages/eqmonitor_map/lib/src/tile/earthquake_overlay_exact_tile_resolver.dart` | exact tile選択とcoverage入力 |
| `packages/eqmonitor_map/lib/src/overlay/earthquake_map_overlay_snapshot.dart` | app非依存公開snapshot |
| `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_controller.dart` | snapshot revision/source lifecycle |
| `packages/eqmonitor_map/lib/src/renderer/earthquake_area_render_submission_builder.dart` | 区域Fill packet |
| `packages/eqmonitor_map/lib/src/renderer/observation_point_batch_builder.dart` | station instance bytes/uniform |
| `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart` | 単一Scene compositorとGPU resource owner |
| `packages/eqmonitor_map/lib/src/widget/base_map_view.dart` | tile/camera/overlay統合 |
| `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart` | domain modelからsnapshotへのpure変換 |
| `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart` | 最新地震選択・詳細取得・generation |
| `app/lib/feature/settings/children/config/debug/eqmonitor_map/*` | debug UIとcoverage banner |

---

### Task 1: Flutter Scene translucent sort priority

**Files:**
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/node.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/render/render_scene.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/components/mesh_component.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/components/instanced_mesh_component.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/scene_encoder.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/test/scene_encoder_test.dart`
- Modify: `third_party/flutter_scene` gitlink in EQMonitor

**Interfaces:**
- Produces: `Node.translucentSortPriority: int`、既定値0。
- Produces: translucent comparator `priority ASC` → `depth DESC`。
- Preserves: opaque comparatorとpriority 0だけの既存描画順。

- [ ] **Step 1: RED testを書く**

`scene_encoder_test.dart`へ、公開pure comparatorを通じて次を固定する。

```dart
test('translucent priority wins over camera depth', () {
  final records = sortSceneTranslucentRecordsForTesting([
    (priority: 300, depth: 100.0, id: 'station'),
    (priority: 100, depth: 1.0, id: 'region'),
  ]);
  expect(records.map((record) => record.id), ['region', 'station']);
});

test('equal translucent priority remains back to front', () {
  final records = sortSceneTranslucentRecordsForTesting([
    (priority: 0, depth: 1.0, id: 'near'),
    (priority: 0, depth: 100.0, id: 'far'),
  ]);
  expect(records.map((record) => record.id), ['far', 'near']);
});
```

- [ ] **Step 2: REDを確認する**

Run: `cd third_party/flutter_scene && mise exec -- flutter test test/scene_encoder_test.dart`

Expected: priority API/comparatorが未定義でFAIL。

- [ ] **Step 3: 最小実装を追加する**

```dart
// Node
int translucentSortPriority = 0;

// RenderItem
int translucentSortPriority = 0;

// SceneEncoder translucent preparation
records.sort((a, b) {
  final byPriority = a.item.translucentSortPriority.compareTo(
    b.item.translucentSortPriority,
  );
  return byPriority != 0 ? byPriority : b.depth.compareTo(a.depth);
});
```

通常meshとinstanced meshのrefresh時にnode値をRenderItemへ必ず写す。testing helperは本番comparatorそのものを利用し、テスト専用の複製ロジックを作らない。

- [ ] **Step 4: GREENとfork回帰を確認する**

Run: `cd third_party/flutter_scene && mise exec -- flutter test test/scene_encoder_test.dart test/static_instance_geometry_test.dart`

Run: `cd third_party/flutter_scene && mise exec -- dart analyze packages/flutter_scene`

- [ ] **Step 5: forkとgitlinkをcommit・pushする**

fork branchは `codex/eqmonitor-map-translucent-priority` とし、YumNumm remoteへpushする。EQMonitorではgitlinkだけを別commitにする。

Commit: `feat: 透過描画のphase優先度を追加`

Commit: `deps: flutter_sceneの透過優先度対応へ更新`

---

### Task 2: MVT string properties and bounded tags

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_tile.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decode_limits.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decoder.dart`
- Modify: `packages/eqmonitor_map/test/tile/mvt/support/mvt_fixture_builder.dart`
- Modify: `packages/eqmonitor_map/test/tile/mvt/mvt_decoder_test.dart`
- Modify generated: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decode_limits.freezed.dart`
- Modify all explicit `MvtDecodeLimits(...)` call sites

**Interfaces:**
- Produces: `MvtFeature.properties: Map<String, String>` as unmodifiable.
- Produces limits: `maxKeysPerLayer`, `maxValuesPerLayer`, `maxTagsPerFeature`, `maxPropertyStringBytes`。
- Production debug values: 64 keys、20000 values、64 tags、256 UTF-8 bytes。

- [ ] **Step 1: field-orderと異常系のRED testsを書く**

```dart
test('resolves tags when features precede keys and values', () {
  final tile = decodeMvtTile(
    fixture.layer(
      fields: [
        fixture.feature(tags: [0, 0], propertiesBeforeGeometry: true),
        fixture.key('code'),
        fixture.stringValue('130010'),
      ],
    ),
    limits: limits,
  );
  expect(tile.layers.single.features.single.properties, {'code': '130010'});
});
```

別testで奇数tags、table外index、重複key、Value複数field、不正UTF-8、string byte上限、keys/values/tags件数上限が `MvtDecodeException` になることをliteral fixtureで確認する。non-string Valueは正常decodeし、対応propertyをmapへ入れない。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/mvt/mvt_decoder_test.dart`

Expected: properties/新limits未定義または期待map不一致でFAIL。

- [ ] **Step 3: layer二段階decodeを実装する**

```dart
final class MvtFeature {
  const new({
    required this.type,
    required this.rings,
    required this.properties,
  });
  final MvtGeometryType type;
  final List<Int32List> rings;
  final Map<String, String> properties;
}
```

layer readerはraw feature bytes、keys、validated valuesを最後まで保持し、その後にfeature tagsを解決する。length-delimited payload長は `readLengthDelimited()` で確保する前にreader APIから検査できるようにする。

- [ ] **Step 4: codegenとGREENを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/mvt/mvt_decoder_test.dart test/tile/base_map_tile_decoder_test.dart`

- [ ] **Step 5: commitする**

Commit: `feat: MVT文字列propertyを上限付きでdecode`

---

### Task 3: Coded earthquake area geometry

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/earthquake_area_tile_geometry.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- Modify: `packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart`

**Interfaces:**
- Consumes: `MvtFeature.properties` from Task 2。
- Produces:

```dart
final class CodedFillGeometry {
  const new({required this.code, required this.meshes});
  final String code;
  final List<FillMesh> meshes;
}

final class EarthquakeAreaTileLayerGeometry {
  const new({required this.extent, required this.features});
  final int? extent;
  final List<CodedFillGeometry> features;
}

final class EarthquakeAreaTileGeometry {
  const new({required this.forecastRegions, required this.cities});
  final EarthquakeAreaTileLayerGeometry forecastRegions;
  final EarthquakeAreaTileLayerGeometry cities;
}
```

`BaseMapTileGeometry`へ `earthquakeAreas` を追加する。

- [ ] **Step 1: RED testsを書く**

fixtureで `areaForecastLocalE.code=130` と `areaInformationCityQuake.regioncode=131016` を持つpolygonを作り、codeとmeshが対応すること、Uint16 segmentation後も同code配下に複数meshが残ること、code欠損/non-stringはbase meshを残して区域featureだけ除外されることを確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart`

- [ ] **Step 3: decode worker内で区域geometryを構築する**

region/cityは元feature単位で `FillMeshBuilder` を呼び、集約base meshから逆算しない。source layer欠損時のextentはnull、存在時は宣言extentを保持する。collectionはunmodifiableにする。

- [ ] **Step 4: GREENを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/base_map_tile_decoder_test.dart test/tile/mvt/mvt_decoder_test.dart`

- [ ] **Step 5: commitする**

Commit: `feat: 区域code付き震度Fill geometryを保持`

---

### Task 4: Exact overlay tile resolver and coverage

**Files:**
- Create: `packages/eqmonitor_map/lib/src/tile/earthquake_overlay_exact_tile_resolver.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_coverage.dart`
- Create: `packages/eqmonitor_map/test/tile/earthquake_overlay_exact_tile_resolver_test.dart`
- Create: `packages/eqmonitor_map/test/overlay/earthquake_overlay_coverage_test.dart`

**Interfaces:**
- Consumes: `BaseMapTileCache` and Task 3 area geometry。
- Produces:

```dart
EarthquakeOverlayExactTileResult resolveEarthquakeOverlayExactTile({
  required UnwrappedTileId requestedTile,
  required String sourceInstanceId,
  required BaseMapTileCache cache,
  required EarthquakeAreaLayerMode mode,
});

sealed class EarthquakeOverlayCoverage {
  const factory EarthquakeOverlayCoverage.hidden() = EarthquakeOverlayHidden;
  const factory EarthquakeOverlayCoverage.incomplete({
    required int requestedTileCount,
    required int readyTileCount,
    required int missingOrInvalidCodeCount,
  }) = EarthquakeOverlayIncomplete;
  const factory EarthquakeOverlayCoverage.complete({
    required int requestedTileCount,
  }) = EarthquakeOverlayComplete;
}
```

- [ ] **Step 1: exact-only RED testsを書く**

requested z7 tileがなくparent z6だけcacheにあるfixtureでresultがmissになること、exact source identityだけhitすること、region/city extentとrequested unwrapped tileを保持することを確認する。coverageは0要求時hidden、missing tile/codeが1件でもincomplete、全ready/valid時だけcompleteを確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/earthquake_overlay_exact_tile_resolver_test.dart test/overlay/earthquake_overlay_coverage_test.dart`

- [ ] **Step 3: direct cache lookupだけで実装する**

`BaseMapRenderTileResolver` や `maxParentSteps` をimportしない。city modeでcity layerがnullでもregionを返さない。

- [ ] **Step 4: GREENを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/tile/earthquake_overlay_exact_tile_resolver_test.dart test/overlay/earthquake_overlay_coverage_test.dart`

- [ ] **Step 5: commitする**

Commit: `feat: 震度overlayをexact tileだけで解決`

---

### Task 5: Public overlay snapshot and revision controller

**Files:**
- Create: `packages/eqmonitor_map/lib/src/overlay/earthquake_map_overlay_snapshot.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_controller.dart`
- Create: `packages/eqmonitor_map/test/overlay/earthquake_map_overlay_snapshot_test.dart`
- Create: `packages/eqmonitor_map/test/overlay/earthquake_overlay_controller_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**

```dart
EarthquakeMapOverlaySnapshot createEarthquakeMapOverlaySnapshot({
  required String sourceId,
  required int revision,
  required double regionToCityZoom,
  required double stationMinZoom,
  required List<EarthquakeAreaStyle> regionStyles,
  required List<EarthquakeAreaStyle> cityStyles,
  required List<EarthquakeObservationPoint> stations,
});

EarthquakeOverlayCommitResult commitEarthquakeOverlaySnapshot({
  required EarthquakeMapOverlaySnapshot? current,
  required EarthquakeMapOverlaySnapshot next,
});
```

公開型のfieldはspecの名前・型どおりとし、factory関数でvalidation/unmodifiable化する。

- [ ] **Step 1: validationとrevisionのRED testsを書く**

空ID/code、負revision、NaN/Infinity、座標範囲外、非正radius、opacity範囲外、重複region/city/station IDを拒否する。same sourceのrevision低下はrejected/current維持、same revisionはtheme置換としてaccepted、別sourceはatomic replaceを確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay/earthquake_map_overlay_snapshot_test.dart test/overlay/earthquake_overlay_controller_test.dart`

- [ ] **Step 3: immutable modelとcontroller pure logicを実装する**

`dynamic`/`Object`/`!`を使わず、typed resultでaccepted/rejectedを表現する。app固有importがないことを保つ。

- [ ] **Step 4: GREENとpublic APIを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay test/eqmonitor_map_library_test.dart test/renderer/renderer_scene_independence_test.dart`

- [ ] **Step 5: commitする**

Commit: `feat: 地震overlay snapshot契約を公開`

---

### Task 6: Earthquake Fill packets and single Scene compositor

**Files:**
- Create: `packages/eqmonitor_map/assets/earthquake_area_fill.fmat`
- Modify: `packages/eqmonitor_map/hook/build.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/earthquake_area_render_submission_builder.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/map_scene_frame_submission.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- Replace usages of: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_base_map_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/earthquake_area_render_submission_builder_test.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`

**Interfaces:**
- Consumes: exact results, snapshot styles, existing base `MapRenderSubmission`。
- Produces: `MapSceneFrameSubmission(baseMap, earthquakeFill, observationBatch)` and one adapter owner。
- Material key: `earthquake-area-fill`。

- [ ] **Step 1: render order/material RED testsを書く**

region style `0x80FF0000, opacity 0.6` が非premultiplied RGB `(1,0,0)` とalpha `0.5*0.6` のparameterになること、zoom境界でregion/cityの片方だけがpacket化されること、unknown phase/materialとpriority不一致がsubmit前にfailすることを確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/earthquake_area_render_submission_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

- [ ] **Step 3: Fill builder、fmat、compositorを実装する**

```fmat
material {
  name: "EarthquakeAreaFill",
  shading_model: unlit,
  blending: transparent,
  culling: none,
  parameters: [
    { type: vec4, name: fill_color, hint: source_color,
      default: [1.0, 1.0, 1.0, 0.6] },
  ],
}
fragment {
  void Surface(inout MaterialInputs material) {
    material.base_color = material_params.fill_color;
    PrepareMaterial(material);
  }
}
```

RGBへopacityを掛けず、alphaだけCPU側で `color.alpha * opacity` にする。adapterだけが `Scene.removeAll/addAll` を呼び、base=0/region=100/city=200をnodeへ設定する。

- [ ] **Step 4: GREENを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/earthquake_area_render_submission_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart test/flutter_scene/flutter_scene_base_map_adapter_test.dart`

- [ ] **Step 5: commitする**

Commit: `feat: 震度Fillを単一Scene compositorへ統合`

---

### Task 7: Observation point GPU instance batch

**Files:**
- Create: `packages/eqmonitor_map/assets/earthquake_observation.vert`
- Create: `packages/eqmonitor_map/assets/earthquake_observation.frag`
- Create: `packages/eqmonitor_map/shaders/earthquake_overlay.shaderbundle.json`
- Modify: `packages/eqmonitor_map/hook/build.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/observation_point_batch.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/observation_point_batch_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/observation_point_batch_builder_test.dart`
- Extend: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`

**Interfaces:**
- Consumes: `EarthquakeObservationPoint`, camera, viewport。
- Produces one `StaticInstanceGeometry`, one node, priority 300。
- Produces exact 28-byte instance stride and 32-byte `ObservationFrame` uniform。

- [ ] **Step 1: byte/projection/lifecycle RED testsを書く**

Tokyo station `(139.6917, 35.6895)` のnormalized Mercatorをhand-derived toleranceで確認し、little-endian byte offsets 0/8/24、instance stride 28、uniform offsets 0/4/8/16/20/24を検査する。date-line差がnearest worldへwrapされるpure projection、radiusがlogical pixelのままNDCへ変換されること、0 stationでbatchなし、1 geometry/1 node、frames-in-flight後のretireを確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/observation_point_batch_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

- [ ] **Step 3: builder、raw shader、resource ownerを実装する**

vertex bufferはquad4頂点/index6個。fragmentは円外discard、1 logical pixel白stroke、smoothstep AA、premultiplied出力。`buildTargetShaderBundleJson` は `TargetShaderBundleAssetMode.dataAssetsRequired`、GLES 300で追加する。snapshot revisionが同じcamera updateではinstance bytes/geometryを再生成せずuniformだけ更新する。

- [ ] **Step 4: GREENを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/observation_point_batch_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze . --fatal-infos`

- [ ] **Step 5: commitする**

Commit: `feat: 観測点を単一GPU instance batchで描画`

---

### Task 8: BaseMapView overlay integration and coverage callback

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify generated: `packages/eqmonitor_map/lib/src/widget/base_map_view.freezed.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_view_test.dart`
- Create: `packages/eqmonitor_map/test/widget/base_map_overlay_frame_builder_test.dart`

**Interfaces:**
- Adds to `BaseMapView`: `EarthquakeMapOverlaySnapshot? earthquakeOverlay` and `ValueChanged<EarthquakeOverlayCoverage>? onEarthquakeOverlayCoverageChanged`。
- Consumes Tasks 4–7 and submits one `MapSceneFrameSubmission` per frame。

- [ ] **Step 1: pure frame decision RED testsを書く**

`buildBaseMapOverlayFrame`相当のpure boundaryに対して、zoom 5.999はregion/no station、zoom 6はcity+station、null snapshotはhidden、same source revision低下は旧snapshot維持、event/source切替はatomic replace、backgroundではsubmitなし/retire予約を確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/widget/base_map_view_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

- [ ] **Step 3: controllerへoverlay lifecycleを接続する**

tile decode error/source layer欠損/code欠損をcoverageへ反映し、callbackは値が変わった時だけ通知する。`BaseMapView`内で新しいprivate logic methodを増やさず、pure builder/resource ownerを別ファイルへ置く。base map fallbackは従来どおり、overlayだけexact resolverを使う。

- [ ] **Step 4: codegen、GREEN、package全体を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd packages/eqmonitor_map && mise exec -- flutter test`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze . --fatal-infos`

- [ ] **Step 5: commitする**

Commit: `feat: BaseMapViewへ地震overlay lifecycleを接続`

---

### Task 9: App snapshot conversion, latest provider, and debug UI

**Files:**
- Create: `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart`
- Create generated: `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.g.dart`
- Create: `app/test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart`
- Create: `app/test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

**Interfaces:**
- Consumes: latest list ordered by event ID descending, `earthquakeHistoryDetailsProvider(eventId)`, `activeColorSetProvider.intensity`。
- Produces typed presentation with `overlay == null` for loading/switch/error/no-intensity and non-null only for current complete data generation。
- Snapshot values: `regionToCityZoom=6`、`stationMinZoom=6`、Fill opacity 0.6、最大震度観測点radius 6.7 logical pixels、その他radius 4.0 logical pixels。

- [ ] **Step 1: conversion/provider/presentation RED testsを書く**

同一region/city codeが複数震度にあるfixtureで最大震度のstyleだけに属すること、regionは `intensity.regions` のcodeだけを使うこと、station ID/code/coordinate/color/radiusを確認する。metadata最大 `reportedAt` UTC microsecondsをrevisionにし、metadata空はtyped unavailable。event A detail待機中にlistがevent Bへ変わりAが完了してもoverlayを公開しないこと、loading/error/no intensity/incomplete coverageのbanner分岐を確認する。

- [ ] **Step 2: REDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

- [ ] **Step 3: pure builder、provider、debug画面を実装する**

```dart
@riverpod
class LatestEarthquakeOverlay extends _$LatestEarthquakeOverlay {
  int _generation = 0;

  @override
  Future<LatestEarthquakeOverlayData> build() async {
    final generation = ++_generation;
    final page = await ref.watch(
      earthquakeHistoryProvider(liveMonitorLatestParameter).future,
    );
    final eventId = const LiveMonitorLatestEarthquakeSelector()
        .selectEventId(page.items);
    if (eventId == null) {
      return const LatestEarthquakeOverlayData.noEarthquake();
    }
    final earthquake = await ref.watch(
      earthquakeHistoryDetailsProvider(eventId).future,
    );
    if (generation != _generation) {
      return const LatestEarthquakeOverlayData.superseded();
    }
    return EarthquakeMapOverlayBuilder().build(earthquake: earthquake);
  }
}
```

providerの生成中/再取得中はAsyncValueの旧dataを表示に使わずoverlayをnullにする。UI errorは例外全文を表示せず、短い日本語メッセージにする。bannerはevent ID、発生時刻、statusとoverlay状態を表示する。

- [ ] **Step 4: codegen、GREEN、対象analyzeを確認する**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

Run: `cd app && mise exec -- flutter analyze lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart lib/feature/settings/children/config/debug/eqmonitor_map`

- [ ] **Step 5: commitする**

Commit: `feat: 最新地震をFlutter Scene地図へ接続`

---

### Task 10: Asset Pack validation, platform smoke, and knowledge record

**Files:**
- Create: `docs/knowledge/20260823_eqmonitor_map_earthquake_overlay.md`
- Create only if unresolved work remains: `docs/todo/{level}_{title}.md`

**Interfaces:**
- Consumes: completed Tasks 1–9。
- Produces: reproducible Asset Pack version/digest、event/code coverage、Simulator result、remaining risk。

- [ ] **Step 1: verified Asset Packをstageする**

Run: `mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled`

記録する: archive version、SHA-256/digest、source path。network/sandboxで失敗した場合は同じcommandの権限昇格を要求し、固定値へfallbackしない。

- [ ] **Step 2: 表示対象eventとtile codeをdiagnostic確認する**

最新震度1以上eventのregion code、zoom 6以上city `regioncode`、station数を記録し、可視tileに実在することを既存MVT decoderまたは最小のread-only diagnostic testで確認する。city欠損をrenderer defectと誤判定しない。

- [ ] **Step 3: 自動検証を実行する**

Run: `cd third_party/flutter_scene && mise exec -- flutter test`

Run: `cd packages/eqmonitor_map && mise exec -- flutter test && mise exec -- dart analyze . --fatal-infos`

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

Run: `cd app && mise exec -- flutter analyze lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart lib/feature/settings/children/config/debug/eqmonitor_map`

- [ ] **Step 4: iOS Simulator smokeを実行する**

デバッグ画面でbase/Fill/stationを同時確認し、pan/pinch追従、zoom 6境界、background/foreground復帰、coverage banner、連続Scene/GPU例外なしを画面とlogで確認する。SimulatorでFlutter GPU固有表示が確認不能なら成功扱いにせず、環境制約と必要な実機確認を記録する。

- [ ] **Step 5: knowledgeを記録してcommit・pushする**

knowledgeには実行command、Asset Pack前提、透過priority、premultiply契約、instance lifecycle、検証結果を500行以内で記載する。

Commit: `docs: 地震overlayのGPU検証知見を記録`

## Completion Checklist

- [ ] 実地震データの地域または市区町村が震度色で塗られる。
- [ ] 観測点円が同じcamera上の対応位置へ表示される。
- [ ] region/city/stationのzoom境界と透過順が固定される。
- [ ] event切替・error・incomplete coverageで旧/部分overlayを完全表示しない。
- [ ] `eqmonitor_map` にapp/MapLibre/GeoJSON依存がない。
- [ ] fork/package/appの対象テストと解析が成功する。
- [ ] platform smokeの環境・結果・残リスクがknowledgeへ残る。
- [ ] 対象外のInfo.plist変更を含めず、全実装commitが作業branchへpushされる。
