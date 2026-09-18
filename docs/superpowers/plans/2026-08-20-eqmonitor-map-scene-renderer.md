# eqmonitor_map: foundation 契約経由の Scene renderer 実装計画

**Goal:** Issue #1593（`[map] 06-scene-renderer`）— `BaseMapView` の描画経路を
foundation の render 契約（`MapPackedMesh` → `MapRenderPacket` → `MapRenderBatch` →
`MapRenderBatchAdapter`）経由へ移し、GPU resource の世代管理と context recovery を入れる。

**現状（この計画の起点）:** `_BaseMapController._rebuildSceneNodes` が
`BaseMapLayerRenderPlan` から直接 `scene.Mesh`/`scene.Node` を組み、`sceneGraph` を
毎回 `removeAll()` して詰め替えている。foundation の `MapScene`/`MapRenderBatch`/
`MapRenderBatchAdapter` は実装・テスト済みだが**描画経路から一切参照されていない**。
`MapRenderBatchAdapter` の実装は spike と test の recording fake だけ。

## Architecture

```text
BaseMapTileCache (decode 済み FillMesh/LineMesh, Scene 非依存)
  → BaseMapPackedMeshCache          … tile 単位で MapPackedMesh を安定 identity で保持
  → buildBaseMapRenderPackets       … sortKey / batchKey / pipeline / uniform を確定
  → buildCanonicalRenderBatches     … layer ごとに 1 batch へ結合（foundation 既存）
  → createMapRenderSubmission(frame) … MapFrameSnapshot を同梱
  → MapRenderBatchAdapter.submit
      └─ FlutterSceneBaseMapAdapter … batch → scene.Mesh/Node（flutter_scene/ 内に隔離）
           └─ MapGpuResourceLedger  … contextGeneration と frames-in-flight で retire
```

Scene 型は `flutter_scene/` の adapter 内だけに現れる。`renderer/` 配下は
`dart:typed_data` と foundation 型だけを扱い、`flutter_scene` を import しない。

## 契約（この計画で確定する版）

### Packed mesh layout（`version: 1`）

| 用途 | topology | stride | attributes | index |
|---|---|---|---|---|
| fill | triangleList | 8 | `position2D` float32x2 @0 | uint16 |
| line | triangleList | 16 | `position2D` float32x2 @0, `lineExtrude2D` float32x2 @8 | uint16 |

`position2D` は **tile-local 座標**（world へ CPU 展開しない。設計正本「頂点 buffer は
tile-local 座標のまま保持し、world 座標へ CPU で展開しない」）。z 成分は持たせない
（`FillMesh`/`LineMesh` が 2 成分しか持たないため。3 成分への拡張は Scene の
`MeshGeometry.fromArrays` が要求する制約であり adapter 側で埋める）。

`lineExtrude2D` は **clip/NDC Y-up 済み**の押し出し法線とする。`LineMeshBuilder` の
出力は tile-local Y-down なので、Y 反転はこの packer で行う。従来 Y 反転を
`base_map_geometry_factory.dart` が行っていたが、packed mesh を「adapter が byte を
そのまま GPU へ載せるだけ」の境界にするため CPU 側へ移す。

### Material parameter block（`version: 1`、little-endian float32）

| pipeline | bytes | 内容 |
|---|---|---|
| `base-map-fill` | 16 | r, g, b, a |
| `base-map-line` | 24 | r, g, b, a, halfWidthNdcX, halfWidthNdcY |

zoom/viewport 依存値は **CPU で確定して uniform へ渡す**（#1593 要件 5）。shader 内で
zoom 補間しない。`half_width_ndc` は `halfLineWidthNdcFor` の既存換算をそのまま使う。

### Sort key（`phasePolicyVersion: 1`）

phase policy は `[base, labelForeground]`。base map は全て `base`（rank 0）。

| field | 値 |
|---|---|
| `declarationOrderWithinPhase` | `baseMapLayerSpecs` の非 background 行の index |
| `sourceOrder` | 0（base map source は 1 つ） |
| `overscaledTileOrder` | plan 中の tile 初出順 index |
| `featureOrder` | layer 内の mesh segment index |

`batchKey` は `scopeKey = sourceInstanceId`、`materialKey = styleLayerId`。tile 識別子を
key へ入れない — 入れると tile ごとに batch が割れ、`instanceTransforms` で
tile 群をまとめる設計（`tile × layer × material` 単位 batch）が崩れる。

### GPU resource の identity

`MapRenderPacket` は GPU resource id を持たない。adapter は **`MapPackedMesh` の
instance identity** を GPU resource の key にする。そのため
`BaseMapPackedMeshCache` は同じ `(sourceInstanceId, CanonicalTileId)` に対して
同じ `MapPackedMesh` instance を返し続ける責務を持つ（従来の `_TileSceneMeshCache`
が GPU mesh に対して負っていた責務を、CPU 側の packed mesh へ引き上げる）。

## Global Constraints

- 上限値は呼び出し側が渡す。adapter/packer 内に固定 fallback を置かない。
- `renderer/` は `flutter_scene` を import しない（CI で機械的に確認する test を置く）。
- GPU 呼び出しを含む経路は unit test で叩かない。既存 `base_map_geometry_factory_test`
  と同じく、引数組み立てを pure 関数へ切り出してそこだけ検証する。
- 実機/simulator の可視確認は本計画では**実施しない**。README へ「未実施」と事実で書く。
- コミット prefix は英語1語 + 日本語1行。

## Tasks

### Task 1: fill/line の packed mesh packer — 完了
- Create: `lib/src/renderer/base_map_packed_mesh.dart`
- Create: `test/renderer/base_map_packed_mesh_test.dart`
- layout 定数 2 つ、`packBaseMapFillMesh` / `packBaseMapLineMesh`。
- byte 列の完全一致、stride、vertexCount/indexCount、Y 反転、空 mesh の拒否。

### Task 2: packed mesh cache（安定 identity）— 完了
- Create: `lib/src/renderer/base_map_packed_mesh_cache.dart`
- Create: `test/renderer/base_map_packed_mesh_cache_test.dart`
- `(sourceInstanceId, CanonicalTileId)` → layer 別 packed mesh。LRU、`maxEntries`。
- 同一 key で `identical` な instance を返すこと、eviction、`clear`。

### Task 3: GPU resource ledger（Scene 非依存）— 完了
- Create: `lib/src/renderer/map_gpu_resource_ledger.dart`
- Create: `test/renderer/map_gpu_resource_ledger_test.dart`
- `contextGeneration` 変更で全 handle を retire、frames-in-flight 世代で遅延解放、
  retire 済み handle の再利用は fail closed。

### Task 4: packet / submission builder — 完了
- Create: `lib/src/renderer/base_map_render_submission_builder.dart`
- Create: `test/renderer/base_map_render_submission_builder_test.dart`
- plans + frame snapshot → `MapRenderSubmission`。canonical 順、layer ごと 1 batch、
  fill/line の layout 分離、`instanceTransforms` の tile 対応、uniform bytes。

### Task 5: Flutter Scene adapter — 完了
- Create: `lib/src/flutter_scene/flutter_scene_base_map_adapter.dart`
- Create: `test/flutter_scene/flutter_scene_base_map_adapter_test.dart`
- `MapRenderBatchAdapter` 実装。packed mesh bytes → `MeshGeometry.fromArrays` 引数の
  組み立ては pure 関数へ切り出して test する。material param bytes の decode も pure。
- ledger 経由で contextGeneration をまたいだ GPU resource 再利用を禁止する。

### Task 6: `BaseMapView` の配線差し替え — 完了
- Modify: `lib/src/widget/base_map_view.dart`
- `_TileSceneMeshCache` を削除し、packed mesh cache + submission builder + adapter へ。
- `MapClock` 注入、frame number、`MapAppLifecycle`、`contextGeneration` を
  `MapFrameSnapshot` へ集約。background で GPU を捨て、foreground で CPU mesh から再構築。

### Task 7: 境界 test と doc — 完了
- Create: `test/renderer/renderer_scene_independence_test.dart`（`renderer/` が
  `flutter_scene` を import していないことを source 走査で確認）
- Modify: `packages/eqmonitor_map/README.md`、`docs/todo/800_...deferred_verification.md`

## Completion Checklist

- [x] `BaseMapView` が `MapRenderBatchAdapter.submit` 経由でのみ Scene node を作る
- [x] `renderer/` に `flutter_scene` import が無いことを test が保証する
      (`test/renderer/renderer_scene_independence_test.dart`)
- [x] contextGeneration 変更後の GPU resource 再利用が fail closed
      (`MapGpuResourceLedger.beginFrame` が全 handle を retire)
- [x] background→foreground で GPU を捨てて CPU mesh から再構築する経路がある
      (`map_render_lifecycle_policy.dart` + `BaseMapPackedMeshCache`)
- [x] zoom/viewport 依存値が CPU 確定の uniform bytes として渡る
      (`base_map_material_parameters.dart`)
- [x] `mise exec -- flutter test`(561 件)と `dart analyze . --fatal-infos`
      (診断 0 件)が green
- [x] 実機/simulator 未実施を README と `docs/todo/800_...` へ事実として記録

## 未達(#1593 の完了条件のうち残るもの)

- [ ] 実機または simulator の smoke を README へ事実記録する。**このセッションでは
      実施していない。** 上の checklist が示すのは自動 test と analyze だけである。
- [ ] spike / preflight surface(`FlutterSceneSpikeView`、
      `BaseMapMaterialPreflightView`、`createSceneSpikeCameraSetup`)の可視出力確認と
      削除・再配線。計画の Out of scope ではなく、#1593 本体の残りである。
