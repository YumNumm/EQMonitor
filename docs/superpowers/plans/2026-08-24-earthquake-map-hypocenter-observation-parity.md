# Earthquake Map Hypocenter and Observation Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Flutter Scene / GPU のデバッグ地図で、実地震の区域 Fill、観測点、震源 sprite を同じ camera 上へ原子的に描画し、震源への camera 移動と iOS / Android runtime parity を完成させる。

**Architecture:** app は地震 domain model と画像 asset を、version stamp 付きの immutable overlay snapshot へ変換する。`eqmonitor_map` は app 非依存の atlas / sprite / camera contract と、base・Fill・観測点・sprite を一つの Scene frame へ送る typed layer submission を所有する。Flutter Scene adapter は texture、quad topology、instance geometry、node の pin と fence retirement を分離し、candidate 失敗時は旧 overlay を残さず base-only へ fail closed する。

**Tech Stack:** Flutter / Dart、Riverpod 3、flutter_hooks、flutter_scene fork、Flutter GPU raw shader / DataAssets、PMTiles / MVT、iOS Simulator、Android emulator

**Spec:** `docs/superpowers/specs/2026-08-24-earthquake-map-hypocenter-observation-parity-design.md`

## Global Constraints

- Flutter / Dart コマンドはすべて `mise exec --` 経由で実行する。
- 各挙動は TDD で RED を確認してから本番コードを変更する。生成コードと shader は最初の実 consumer 境界でも検証する。
- `eqmonitor_map` は app の `Earthquake`、`JmaIntensity`、asset path、MapLibre、GeoJSON に依存しない。
- 単一 `sourceId / revision` compatibility alias は残さない。package、app、coverage、debug presentation を一つの version stamp contract へ同時に移行する。
- `MapOverlayVersionStamp` は source identity / incarnation、data sequence / digest、render generation / digest を保持する。同一 sequence または generation で digest が変わる入力は拒否する。
- snapshot は full replacement とする。loading、event switch、error、no intensity、candidate resource failure では旧地震 overlay を消す。
- sprite atlas の ABI は top-left、tight RGBA8888、straight alpha、sRGB、2 physical pixel extruded padding、texel-center UV、linear clamp とする。package に暗黙上限を置かず、caller 必須 limits で検証する。
- sprite は atlas / material / zoom policy pair ごとに一つの instance batch、一つの geometry、一つの node にまとめる。camera-only 更新では texture / topology / instance を再生成しない。
- 描画順は `base < earthquake Fill < observation point < hypocenter sprite < label` とする。
- texture、quad topology、instance geometry、node の所有権を分離する。Scene から外した resource は GPU completion fence 後に一度だけ retire する。
- camera command は typed result を返し、attach 前、二重 attach、dispose 後、invalid input、supersede を区別する。command success は frame schedule までであり tile load 完了ではない。
- coverage は commit 済み version stamp と atomic に通知する。source layer absent は verified semantic-empty evidence がない限り incomplete のままとする。
- 既存 MapLibre 地震詳細は本計画では変更・削除しない。
- `app/ios/Runner/Frameworks/LiveActivityUtil.xcframework/Info.plist` の既存変更は対象外であり、stage・commitしない。
- PR / Issue を作る場合は YumNumm org だけを対象にし、`--repo YumNumm/<repo>` を明示する。本計画は PR 作成を含まない。
- 1コミット30〜100行を目安に分け、英語1語 prefix と日本語要約で commit し、作業 branch へ push する。

## Target File Structure

| Path | Responsibility |
|---|---|
| `packages/eqmonitor_map/lib/src/foundation/revision/map_source_identity.dart` | source identity / content digest の型付き文字列 |
| `packages/eqmonitor_map/lib/src/overlay/map_overlay_version_stamp.dart` | data / render version の不変 contract と遷移検証 |
| `packages/eqmonitor_map/lib/src/overlay/map_sprite_atlas.dart` | atlas / region / limits と pixel ABI |
| `packages/eqmonitor_map/lib/src/overlay/map_point_sprite_feature.dart` | generic sprite feature |
| `packages/eqmonitor_map/lib/src/overlay/map_zoom_scalar_policy.dart` | linear / step zoom policy |
| `packages/eqmonitor_map/lib/src/geo/map_camera_bounds.dart` | antimeridian 対応 bounds |
| `packages/eqmonitor_map/lib/src/geo/map_camera_bounds_fitter.dart` | pure fitBounds 計算 |
| `packages/eqmonitor_map/lib/src/widget/map_view_camera_controller.dart` | 公開 camera command / committed state |
| `packages/eqmonitor_map/lib/src/renderer/map_scene_frame_submission.dart` | 一 frame の typed layer list |
| `packages/eqmonitor_map/lib/src/renderer/map_sprite_batch*.dart` | sprite grouping、ABI、uniform、reuse |
| `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_sprite_resource_owner.dart` | texture / topology / instance pin と fence retirement |
| `packages/eqmonitor_map/assets/earthquake_sprite.{vert,frag}` | sprite shader |
| `app/lib/feature/earthquake_history/data/provider/earthquake_map_sprite_atlas_provider.dart` | app asset decode と atlas 構築 |
| `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart` | domain から versioned snapshot への pure 変換 |
| `app/lib/feature/settings/children/config/debug/eqmonitor_map/*` | camera action、version / count / coverage 表示 |

## Execution and Parallelization Graph

```text
Task 1 version stamp
  ├─ Task 2 atlas / feature ─ Task 3 compositor ─ Task 5 sprite batch ─ Task 6 GPU owner ─ Task 7 app integration ─ Task 8 UI
  └─ Task 4 camera / clock ────────────────────────────────────────────────────────────────────────────────┘
```

同じworktreeで同じfileを並行編集しない。Task 1後は次の独立ownershipだけを並行化する。

- Task 2のpackage overlay value filesと、Task 4のgeo fitter / app clock adapter。
  `eqmonitor_map.dart`とdebug pageはintegration ownerが両agent完了後に順番に統合する。
- Task 5のflutter_scene build-hook reflection helperと、eqmonitor_mapのCPU sprite batch /
  shader source。fork commit / push完了後にintegration ownerがgitlinkとhook callを接続する。
- Task 6のflutter_scene shared topology APIと、eqmonitor_map resource ledgerのfake / RED
  tests。fork APIの最終signatureをintegration ownerが固定してからproduction ownerへ渡す。
- Task 7のpure atlas packer testsと、Task 8のpackage coverage resolver foundation。
  provider / debug page integrationはTask 7 commit後に一人のownerが行う。

各parallel laneは独立file ownershipをbriefへ列挙する。task-scoped review、fix round、commit、
gitlink更新はintegration順に行い、review未承認の差分を次の共有fileへ重ねない。

---

### Task 1: Data / render version stamp への完全移行

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/revision/map_source_identity.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/map_overlay_version_stamp.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_map_overlay_snapshot.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_controller.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_coverage.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_coverage_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/observation_point_batch.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/observation_point_batch_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_builder.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_digest_builder.dart`
- Create: `app/lib/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.dart`
- Create generated: `app/lib/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.g.dart`
- Modify: `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart`
- Modify: `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart`
- Create: `app/test/feature/earthquake_history/data/earthquake_map_overlay_digest_builder_test.dart`
- Modify corresponding package/app tests

**Interfaces:**

```dart
final class MapSourceIncarnation {
  final String value;
}

final class MapOverlayVersionStamp {
  final MapSourceIdentity sourceIdentity;
  final MapSourceIncarnation sourceIncarnation;
  final int dataSequence;
  final String dataDigest;
  final int renderGeneration;
  final String renderDigest;
}
```

`MapSourceIdentity` は既存の `MapSourceInstanceId` / `MapContentDigest` と同じ
foundation fileへ追加する非空のtyped valueである。app producerではevent IDを
source identityとし、provider / pipeline lifecycleごとに発行するopaque UUID v7文字列を
`MapSourceIncarnation`とする。UUIDはhazard dataやfallback値には使わず、incarnationの
識別だけに使う。production factoryとtest factoryをRiverpodでDIし、process-local
`Object` identityやhashを公開契約に使わない。同じevent内のcanonical data変更はdata
sequence、theme等の現存render input変更はrender generationで表す。別の
`AsyncGenerationOwner`でsource switch、provider dispose、clock source switch後のlate
completionを拒否する。

- [ ] **Step 1: version value と遷移の RED tests を追加する**

空 identity / incarnation / digest、負数、同一 data sequence・異 digest、同一 render generation・異 digest、低い sequence / generation、theme-only の render generation 上昇、完全同一 stamp の idempotent 受理を固定する。coverageはhidden / loading / incomplete / completeを持ち、stampなしはhiddenだけ、stamp付きloading以降はcommit candidateと同じstampだけを許可する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay/earthquake_map_overlay_snapshot_test.dart test/overlay/earthquake_overlay_controller_test.dart test/overlay/earthquake_overlay_coverage_test.dart test/renderer/observation_point_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Expected: `MapOverlayVersionStamp` 未定義または旧 revision expectation で FAIL。

- [ ] **Step 2: package contract を最小実装する**

factory で全文字列の非空、sequence / generation の非負を検証し、value equality を実装する。`EarthquakeMapOverlaySnapshot`、coverage、observation reuse key は stamp を一つだけ保持し、旧 `sourceId`、`revision`、`snapshotRevision` field / alias を削除する。

遷移は source identity / incarnation が変われば full replacement を受理し、同 source では次を満たす入力だけ受理する。

```text
next.dataSequence >= current.dataSequence
same dataSequence => same dataDigest
next.renderGeneration >= current.renderGeneration
same renderGeneration => same renderDigest
```

- [ ] **Step 3: app の canonical digest と generation を RED tests で固定する**

現存するregion / city / station / hypocenter source dataの入力順が異なっても同じdata digest、canonical dataが変わればreportedAtが同値でもdata sequenceが単調増加すること、theme色だけならdata versionを維持してrender generation / digestが変化すること、event switch後のlate resultはpublishされないことを確認する。provider / pipelineを再生成した同一eventは新incarnationとしてsequence 0から受理され、旧incarnationのlate resultは拒否される。SHA-256 は app 既存の `crypto` を使い、canonical UTF-8 record を field tag・length・sorted stable ID 付きで構築する。atlas / zoom policy / display settingのrender digest testはcontract実装後のTask 7で追加する。

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_overlay_digest_builder_test.dart test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

Expected: 旧 revision API または digest 未実装で FAIL。

- [ ] **Step 4: app producer / presentation を stamp へ移行する**

providerはincarnation内で直前のcanonical data / render digestを保持し、digest変更時だけ各単調counterを進めてbuilderへ明示stampを渡す。reportedAtをsequenceとして直接使わない。source switch / disposeではasync generationをcancelする。debug presentation は coverage stamp と overlay stamp が完全一致するときだけ coverage を適用する。例外文字列や stack trace は利用者向け banner に出さない。

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 5: targeted GREEN と静的解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay test/renderer/observation_point_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib test/overlay test/renderer/observation_point_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_overlay_digest_builder_test.dart test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`

Run: `cd app && mise exec -- dart analyze lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart`

- [ ] **Step 6: package / appを別commitにして各commit後にpushする**

Commit: `feat: overlay version stamp契約を追加`

Commit: `refactor: packageの旧revision契約を削除`

Commit: `refactor: appをdata render versionへ移行`

---

### Task 2: Generic sprite atlas / feature / zoom policy contract

**Files:**
- Create: `packages/eqmonitor_map/lib/src/overlay/map_sprite_atlas.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/map_point_sprite_feature.dart`
- Create: `packages/eqmonitor_map/lib/src/overlay/map_zoom_scalar_policy.dart`
- Create: `packages/eqmonitor_map/test/overlay/map_sprite_atlas_test.dart`
- Create: `packages/eqmonitor_map/test/overlay/map_point_sprite_feature_test.dart`
- Create: `packages/eqmonitor_map/test/overlay/map_zoom_scalar_policy_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_map_overlay_snapshot.dart`
- Modify: `packages/eqmonitor_map/test/overlay/earthquake_map_overlay_snapshot_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`

**Interfaces:**

```dart
MapSpriteAtlas createMapSpriteAtlas({
  required MapSourceIdentity identity,
  required int width,
  required int height,
  required Uint8List rgbaBytes,
  required List<MapSpriteRegion> regions,
  required MapSpriteAtlasLimits limits,
});

MapZoomLinearRange createMapZoomLinearRange(...);
MapZoomStep createMapZoomStep(...);
MapPointSpriteFeature createMapPointSpriteFeature(...);
```

- [ ] **Step 1: atlas ABI の RED tests を追加する**

2×2 top-left orientation、straight-alpha 0.5、tight byte count、defensive copy、UV finite / 0..1、logical size positive、duplicate ID、dimension / byte / region caller limits、2px extruded padding region の texel-center UV を literal bytes で固定する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay/map_sprite_atlas_test.dart`

Expected: atlas API 未定義で FAIL。

- [ ] **Step 2: atlas value を実装する**

入力 bytes / regions は defensive copy して unmodifiable にする。`MapSpriteRegion.normalizedUv` は padding を含めず atlas の texel center を指す。identity は caller が content digest を含む `MapSourceIdentity` として渡す。

- [ ] **Step 3: zoom policy / feature の RED tests を追加する**

linear の zoom 3 / 20 / 範囲外 clamp、step の threshold 直前 / 一致 / 直後、NaN / infinity、size positive、opacity 0..1、longitude / latitude、feature ID / region ID / priority を検証する。既存 MapLibre fixture `0.15@z3 -> 0.4@z20` と `opacity 1 below z8 / 0.6 at z8` を比較する。

- [ ] **Step 4: zoom policy / feature と snapshot validation を実装する**

snapshot へ `MapSpriteAtlas? spriteAtlas` と `List<MapPointSpriteFeature> sprites` を追加する。atlas null + non-empty sprites、unknown region、duplicate feature ID を factory で拒否する。異なる policy pair の数を caller 必須 `maxSpritePolicyBatches` と照合する。

- [ ] **Step 5: GREEN と解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib/src/overlay test/overlay`

- [ ] **Step 6: value型 / snapshotを別commitにして各commit後にpushする**

Commit: `feat: map sprite atlas契約を追加`

Commit: `feat: map zoom policyとsprite featureを追加`

Commit: `feat: 地震snapshotへsprite入力を追加`

---

### Task 3: Scene frame を typed layer list へ拡張

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/renderer/map_scene_frame_submission.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/map_scene_render_phase_policy.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_render_submission_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/earthquake_area_render_submission_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/observation_point_batch.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_builder.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`
- Modify: `packages/eqmonitor_map/test/renderer/base_map_render_submission_builder_test.dart`
- Modify: `packages/eqmonitor_map/test/renderer/earthquake_area_render_submission_builder_test.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_overlay_frame_builder_test.dart`

**Interfaces:**

```dart
sealed class MapSceneLayerSubmission {
  MapFrameSnapshot get frame;
  MapSceneLogicalSourceKey get logicalSourceKey;
  MapSceneComponentKey get componentKey;
  MapOverlayVersionStamp? get overlayVersion;
  int get phasePolicyVersion;
  int get phase;
  int get orderWithinPhase;
}

final class MapSceneMeshLayerSubmission extends MapSceneLayerSubmission {
  final MapRenderBatch batch;
  final MapSceneMeshLayerKind kind;
}

enum MapSceneInstanceLayerKind { observationPoint, pointSprite }

abstract interface class MapSceneInstanceBatch {
  MapFrameSnapshot get frame;
  MapSceneBatchKey get batchKey;
  int get phasePolicyVersion;
  int get phase;
}

final class MapSceneInstanceLayerSubmission extends MapSceneLayerSubmission {
  final MapSceneInstanceLayerKind kind;
  final MapSceneInstanceBatch batch;
}

final class MapSceneFrameSubmission {
  final MapFrameSnapshot frame;
  final List<MapSceneLayerSubmission> layers;
}
```

`MapSceneLogicalSourceKey`と`MapSceneComponentKey`は非空のtyped valueで、layer
wrapperが必ず保持する。baseは`base-map / base`、地震はlogical source
`earthquake-history`の下で`region-fill`、`city-fill`、`observation-point`、
`hypocenter-sprite`をcomponent keyにする。同一logical sourceのoverlay layerは
全て同一`MapOverlayVersionStamp`を持たなければならず、mixed frameを拒否する。
一wrapperは一mesh batchまたは一instance batchだけを持つ。identityは
`(logicalSourceKey, componentKey, batchKey)`で一意とし、同componentの異なるsprite
policy batchは異なるbatch keyとして許可する。canonical comparatorはphase、
`orderWithinPhase`、logical source key、component key、batch keyの順とする。
`MapSceneFrameLimits.maxNodeCount`をcaller必須とし、mesh batch内packet nodeを含む
canonical draw node総数を制限する。adapterはcanonical layer / packet順に全nodeへ
0始まりのstrictly increasing draw rankを割り当て、そのrankをFlutter Scene
`Node.translucentSortPriority`へ設定する。同phase / 同depthでもScene encoder後の順序を
維持し、phase固定priorityは使わない。

phase policyはroadmapと同じpackage-neutral taxonomyへ置換する。

```text
baseLandFill=0
underlayHazardFill=20
underlayHazardLine=30
baseAdministrativeLine=40
overlayHazardFill=100
overlayHazardLine=110
dynamicWaveFill=200
dynamicWaveLine=210
livePoint=300
sprite=350
foregroundLabel=400
```

base mapのFill batchは`baseLandFill`、Line batchは`baseAdministrativeLine`へ分ける。
地震region / city Fillは`overlayHazardFill`、観測点は`livePoint`、震源は`sprite`を
使う。これにより次subprojectの推計震度Fill / Lineを行政境界線より下へ挿入できる。

- [ ] **Step 1: generic order / validation の RED tests を追加する**

base land、underlay hazard、base administrative line、overlay hazard、dynamic wave、live point、sprite、label の canonical order、frame identity、logical source / component / batch keyの空値、同logical source内のmixed version stamp、重複identity tuple、負のorder、policy version、phase mismatch、max node count超過、両方の region + city、unknown mesh pipeline を拒否する。同componentのdistinct batch keyは許可する。base batchだけでoverlay layerが空のbase-only submissionは許可する。同phase / 同camera depthの複数layerと一mesh batch内複数packetをFlutter Scene comparatorへ通し、割当済みdraw rank順が維持されることも固定する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/base_map_render_submission_builder_test.dart test/renderer/earthquake_area_render_submission_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

Expected: layer list / sprite phase 未定義で FAIL。

- [ ] **Step 2: phase policy v3 と layer list を実装する**

地震固有phaseを増やさず、上記generic taxonomyでphase policyを更新する。`buildBaseMapRenderPackets`はbase FillとLineへ別phaseを割り当て、地震builderはoverlay hazard Fillとlive pointを使う。固定 field `baseMap / earthquakeFill / observationBatch` を削除し、全 layer を immutable list で所有する。

- [ ] **Step 3: builder / adapter を list contract へ移行する**

adapter は sealed layer wrapper と `MapSceneInstanceLayerKind` を exhaustive switch し、kindとconcrete batch型の不一致をtyped errorにする。canonical node planを先に展開してstrictly increasing draw rankを確定し、全preflight完了後だけSceneをmutationする。sprite実装前はpointSprite kindを受ける型だけ用意し、未構築batchを生成しない。

- [ ] **Step 4: GREEN と解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/base_map_render_submission_builder_test.dart test/renderer/earthquake_area_render_submission_builder_test.dart test/renderer/observation_point_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib/src/renderer lib/src/flutter_scene test/widget/base_map_overlay_frame_builder_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart`

- [ ] **Step 5: phase / submission / adapterを別commitにして各commit後にpushする**

Commit: `refactor: Scene phaseを汎用taxonomyへ移行`

Commit: `refactor: Scene frameをtyped layer listへ拡張`

Commit: `refactor: Scene adapterをlayer listへ移行`

---

### Task 4: 公開 camera controller と fitBounds

**Files:**
- Create: `packages/eqmonitor_map/lib/src/geo/map_camera_bounds.dart`
- Create: `packages/eqmonitor_map/lib/src/geo/map_camera_bounds_fitter.dart`
- Create: `packages/eqmonitor_map/lib/src/widget/map_view_camera_controller.dart`
- Create: `packages/eqmonitor_map/test/geo/map_camera_bounds_fitter_test.dart`
- Create: `packages/eqmonitor_map/test/geo/fixtures/maplibre_fit_bounds_fixtures.dart`
- Create: `packages/eqmonitor_map/test/widget/map_view_camera_controller_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_view_test.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `app/lib/core/util/map/app_map_clock.dart`
- Create: `app/lib/core/provider/clock/map_clock_source_identity_provider.dart`
- Create generated: `app/lib/core/provider/clock/map_clock_source_identity_provider.g.dart`
- Create: `app/test/core/util/map/app_map_clock_test.dart`
- Create: `app/test/core/provider/clock/map_clock_source_identity_provider_test.dart`
- Modify: `app/lib/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.dart`
- Modify: `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart`
- Modify: `app/test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_clock_integration_test.dart`

**Interfaces:**

```dart
sealed class MapCameraCommandResult {}
final class MapCameraCommandSucceeded extends MapCameraCommandResult {
  final int generation;
  final MapCamera committedCamera;
}
sealed class MapCameraCommandFailure extends MapCameraCommandResult {}

final class MapViewCameraController {
  MapCamera? get committedCamera;
  ValueListenable<MapCamera?> get committedCameraListenable;
  Future<MapCameraCommandResult> moveTo({required MapCamera camera});
  Future<MapCameraCommandResult> fitBounds({
    required MapCameraBounds bounds,
    required EdgeInsets padding,
  });
}
```

- [ ] **Step 1: pure bounds fitter の RED tests を追加する**

通常 bounds、antimeridian (`west > east`)、asymmetric padding、DPR 1 / 3 で同じ logical result、viewport resize、min / max clamp、不正 / 空 viewport を固定する。MapLibre parity expected center / zoomは現行MapLibre camera APIを固定viewport / padding / boundsで実行して採取したliteral値としてchecked-in fixtureへ置き、採取したmaplibre package version、coordinate convention、採取コマンドをfile commentへ記録する。GPU fitter自身からexpected値を生成しない。zoom absolute error `<= 1e-6`、projected center error `<= 0.5 logical px` を assertion にする。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/geo/map_camera_bounds_fitter_test.dart`

Expected: bounds / fitter API 未定義で FAIL。

- [ ] **Step 2: bounds / fitter を実装する**

Mercator Y と最短 wrapped X interval で center / zoom を算出し、padding を引いた logical viewport を使う。非 finite、緯度範囲外、padding が viewport を消費する入力は typed invalid result にする。

- [ ] **Step 3: controller lifecycle / command の RED tests を追加する**

attach 前、single attach、double attach、detach / reattach、dispose 後、committed getter / listenable、new command による未commit command supersede、gesture と command の同一 clamp、source switch camera preservation を fake host で固定する。

- [ ] **Step 4: controller と BaseMapView integration を実装する**

`BaseMapView.cameraController` は optional caller-owned inputとし、`MapClock clock`はcaller必須入力に変更する。内部`SystemMapClock`生成を削除し、一frameで一回だけ注入clockをcaptureする。host は command generation を `_BaseMapController` の一つの camera mutation pathへ送り、frame schedule 後に successを返す。view disposeでdetachし、controller自体はdisposeしない。再attach時はcontrollerのcommitted cameraをinitial cameraより優先する。

appには`DateTime Function()`を受けてUTC化する`AppMapUtcWallSource`と、
`AppClock.now()` / `SystemMonotonicSource`から`SystemMapClock.withSources`を構成する
`createAppMapClock`を置く。debug pageはrealtime / time-shift / replay mode identityが
変わると新しいclock instanceを作って`BaseMapView`へ渡す。clock instance変更で未完了の
async generationをcancelしてmap controllerを再生成する一方、外部camera controllerの
committed cameraを維持する。通常のreplay tickだけではclock sourceを再生成しない。
`mapClockSourceIdentityProvider`はrealtime / time-shift offset / replay sessionのsource
identityを公開し、latest earthquake overlayとsource incarnation providerがwatchする。
mode identity変更では新overlay incarnationを発行してAsyncGenerationOwnerをcancelし、
旧modeのdetail / atlas Future完了を拒否する。通常のreplay tickは同source identityを維持する。

- [ ] **Step 5: GREEN と解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/geo/map_camera_bounds_fitter_test.dart test/widget/map_view_camera_controller_test.dart test/widget/base_map_view_test.dart test/tile/tile_cover_calculator_test.dart`

Run: `cd app && mise exec -- flutter test test/core/util/map/app_map_clock_test.dart test/core/provider/clock/map_clock_source_identity_provider_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_clock_integration_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib/src/geo lib/src/widget test/geo/map_camera_bounds_fitter_test.dart test/widget/map_view_camera_controller_test.dart`

Run: `cd app && mise exec -- dart analyze lib/core/util/map/app_map_clock.dart lib/core/provider/clock/map_clock_source_identity_provider.dart lib/feature/earthquake_history/data/provider/earthquake_overlay_source_incarnation_provider.dart lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart test/core/util/map/app_map_clock_test.dart test/core/provider/clock/map_clock_source_identity_provider_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_clock_integration_test.dart`

- [ ] **Step 6: fitter / controller / app clockを別commitにして各commit後にpushする**

Commit: `feat: map camera bounds fitterを追加`

Commit: `feat: GPU地図のcamera controllerを公開`

Commit: `feat: AppClockをGPU地図へ注入`

---

### Task 5: Sprite batch、instance ABI、shader contract

**Files:**
- Create: `packages/eqmonitor_map/lib/src/renderer/map_sprite_batch.dart`
- Create: `packages/eqmonitor_map/lib/src/renderer/map_sprite_batch_builder.dart`
- Create: `packages/eqmonitor_map/test/renderer/map_sprite_batch_builder_test.dart`
- Create: `packages/eqmonitor_map/assets/earthquake_sprite.vert`
- Create: `packages/eqmonitor_map/assets/earthquake_sprite.frag`
- Create: `packages/eqmonitor_map/shaders/earthquake_overlay.shaderinterface.json`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/map_shader_interface_manifest.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/map_shader_interface_manifest_test.dart`
- Modify: `packages/eqmonitor_map/shaders/earthquake_overlay.shaderbundle.json`
- Modify: `packages/eqmonitor_map/hook/build.dart`
- Modify: `packages/eqmonitor_map/pubspec.yaml`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_builder.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_overlay_frame_builder_test.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/fmat/target_shader_bundle.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/build_hooks.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/test/target_shader_bundle_test.dart`
- Modify: `third_party/flutter_scene` gitlink in EQMonitor

**ABI:**

```text
quad vertex: corner float32x2, stride 8
instance: centerMercator float32x2 @0
          uvRect float32x4 @8
          logicalSize float32x2 @24
          opacity float32 @32
          priority float32 @36
instance stride: 40 bytes, little endian
SpriteFrame: cameraWorld vec4 @0, viewportZoom vec4 @16,
             sizePolicy vec4 @32, opacityPolicy vec4 @48
uniform byte length: 64
```

- [ ] **Step 1: grouping / ABI / reuse の RED tests を追加する**

deterministic feature priority + ID order、policy pair grouping、caller max batch overrun、exact 40-byte values / offsets、64-byte uniform、nearest date-line wrap、logical pixel size、zoom clamp / step equality、zero sprite、same batch digest camera-only instance reuse、different digest replacementを固定する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/map_sprite_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Expected: sprite batch API 未定義で FAIL。

- [ ] **Step 2: immutable batch builder を実装する**

batch key は atlas digest、material ABI version、size / opacity policy canonical digestを含む。instance bytesは所有copyを保持し、同一 batch digestなら前 batchのinstance generationを再利用してframe uniformだけ差し替える。

- [ ] **Step 3: shader と pure reference tests を実装する**

vertex は wrapped Mercator中心とlogical viewportでquadを展開し、policy uniformからsize / opacityを評価する。fragment は straight sample RGBへsample alphaとfeature opacityを一度だけ掛けてpremultiplied outputを返す。manual gamma変換、DPR再乗算、depth write、cullingは使わない。

- [ ] **Step 4: compiled reflection と public interface manifestを一致させる**

symbols は `MapSpriteVertex` / `MapSpriteFragment` とし、observationと同じbundleへ追加する。native `flutter_gpu.Shader`はuniform blockのsize / offset以外にvertex input / sampler typeを公開せず、compiled FlatBufferのtexture reflectionもname / set / bindingまでしか保持しないため、存在しないtype reflection APIを前提にしない。代わりにflutter_scene build hookへ`interfaceManifestFileName`を追加し、compiled shader bundle FlatBufferが持つ全backendのinput name / type / offset、uniform block / member offset、sampled-image bindingのname / set / bindingをsourceの`shaderinterface.json`とbuild時に完全一致検証する。不一致ならbuildを失敗させる。`sampler2D`型そのものはchecked-in shader sourceのstrict declaration parser testで固定し、compiler成功と組み合わせる。cube / array samplerを同等とみなさない。

同じinterface JSONをpackage assetとして同梱し、`MapShaderInterfaceManifest`がdefensiveにparseする。runtime preflightはこのbuild検証済みmanifestとCPU `VertexLayoutDescriptor` / instance constants / expected sampled-image bindingを照合し、shader symbolとnative uniform size / offsetを実shaderから照合する。sampler 2D型はsource parser testの保証でありruntime reflectionではないことをAPI docに明記する。これによりpublic APIで取得できないreflectionを推測せず、source / build-time / runtime native reflectionの境界を明示する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/map_sprite_batch_builder_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Run: `cd third_party/flutter_scene && mise exec -- flutter test test/target_shader_bundle_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/map_shader_interface_manifest_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib/src/renderer lib/src/flutter_scene/map_shader_interface_manifest.dart test/renderer/map_sprite_batch_builder_test.dart test/flutter_scene/map_shader_interface_manifest_test.dart`

- [ ] **Step 5: fork reflection helperをcommit・pushする**

fork branchでbuild-time compiled reflectionとinterface manifestの照合helper / testだけを
commitし、YumNumm remoteへpushする。

Commit: `feat: shader interface manifest検証を追加`

- [ ] **Step 6: 親gitlinkとpackage実装を分割して各commit後にpushする**

Commit: `deps: flutter_sceneのshader検証APIへ更新`

Commit: `feat: GPU map sprite batchを追加`

Commit: `build: map sprite shader契約を追加`

---

### Task 6: Flutter Scene sprite resource owner と atomic integration

**Files:**
- Create: `third_party/flutter_scene/packages/flutter_scene/lib/src/geometry/static_instance_topology.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/src/geometry/static_instance_geometry.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/lib/scene.dart`
- Create: `third_party/flutter_scene/packages/flutter_scene/test/static_instance_topology_test.dart`
- Modify: `third_party/flutter_scene/packages/flutter_scene/test/static_instance_geometry_test.dart`
- Modify: `third_party/flutter_scene` gitlink in EQMonitor
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_sprite_resource_owner.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/map_gpu_probe.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_sprite_resource_owner_test.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/map_gpu_probe_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/flutter_scene_map_adapter.dart`
- Modify: `packages/eqmonitor_map/lib/src/flutter_scene/earthquake_overlay_material_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/test/flutter_scene/flutter_scene_map_adapter_test.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_overlay_frame_builder_test.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_view_test.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`

**Fork API:**

```dart
final class StaticInstanceTopology {
  void prepare();
  bool get isPrepared;
  void retire();
}

final class StaticInstanceGeometry extends Geometry {
  factory withTopology({
    required StaticInstanceTopology topology,
    required Float32List instanceData,
    required int instanceCount,
    required VertexLayoutDescriptor layout,
  });
  void prepare();
}
```

`StaticInstanceTopology.prepare()`はvertex / index buffer、geometryの`prepare()`は
instance bufferをRenderPassなしでeager uploadする。`bind()`は未prepareなら従来互換で
prepareするが、eqmonitor_map adapterはcandidate prepare中に必ず明示呼出しする。
topologyは複数geometryから共有でき、geometry retireはinstance参照だけを解放し、
topology retireは全consumer pinがなくなった後だけ行う。

**Resource keys:**

```text
texture  = (contextGeneration, atlasDigest)
topology = (contextGeneration, sprite ABI version, material version)
instance = (contextGeneration, batchGeneration)
node     = committed frame
```

`MapSpriteRendererLimits`はcaller必須の`maxActiveAtlases`、
`maxTopologyVariants`、`maxPolicyBatches`を持つ。`F=maxFramesInFlight`、`A`、`T`、`B`を
各limitとすると、owner counterの上限を次に固定する。

```text
live texture pins       <= A * (F + 1)
live topology pins      <= T * (F + 1)
live instance geometry  <= B * (F + 1)
active sprite nodes     <= B
pending-retire nodes    <= B * F
```

debug configurationはatlasにnormal / low-precisionを同梱するため`A=1`、現subprojectの
policy pair一つで`T=1, B=1`を明示する。packageに既定値を置かない。

runtime failure / ABI gate用に、通常描画contractと分離したtyped probeを用意する。

```dart
enum MapGpuFaultPoint { atlasUpload, shaderInterface, frameSubmit }
enum MapSpriteAtlasProbeFixture { production, orientation2x2, alphaHalf, edgeBleed }

final class MapGpuProbeConfiguration {
  final MapGpuFaultPoint? faultPoint;
  final MapSpriteAtlasProbeFixture atlasFixture;
}

final class MapGpuResourceCounterSnapshot {
  // texture / topology / instance / nodeごとのactive、pendingRetire、
  // upload、retire count
}
```

`BaseMapView`はnullable probe configuration、resource counter callback、
`MapGpuProbeController`を受ける。nullはproduction経路で分岐 / allocationを増やさない。
controllerの`invalidateRendererContextGeneration()`はapp-owned context generationを
一回進め、既存resourceをfence retirementへ送り再描画をscheduleする。このprobeはnative
GPU context / surfaceを再生成せず、resource lifecycle faultのsimulationに限定する。faultは
指定pointで一回だけ同期throwし、必ず
base-only fail closedへ到達する。appはdebug map surfaceかつcompile-time
`EQMONITOR_MAP_GPU_PROBE=true`の時だけprobe UIを構築し、通常surfaceでは有効化できない。

- [ ] **Step 1: fork shared topology / eager prepare の RED tests を追加する**

一topologyを二つのinstance geometryが共有しvertex / index uploadが一回だけ、各instance
uploadは一回ずつ、prepare失敗がScene mutation前に同期throw、geometry retire後も別consumer
がtopologyを使用可能、最後のtopology retireがidempotentであることをfake allocator境界で
固定する。

Run: `cd third_party/flutter_scene && mise exec -- flutter test test/static_instance_topology_test.dart test/static_instance_geometry_test.dart`

Expected: topology / eager prepare API未定義で FAIL。

- [ ] **Step 2: fork APIを実装・検証し、fork commitをpushする**

既存`StaticInstanceGeometry` constructorの挙動は維持し、shared topology constructorを追加する。
CPU dataはupload後に解放し、retire後のprepare / bind / drawをfail closedする。公開APIを
`scene.dart`からexportする。

Run: `cd third_party/flutter_scene && mise exec -- flutter test test/static_instance_topology_test.dart test/static_instance_geometry_test.dart`

Run: `cd third_party/flutter_scene && mise exec -- dart analyze packages/flutter_scene --fatal-infos`

Commit: `feat: instance topology共有とeager uploadを追加`

fork branchをYumNumm remoteへpushし、EQMonitorのgitlink更新を独立commit・pushする。

Commit: `deps: flutter_sceneのinstance resource APIへ更新`

- [ ] **Step 3: resource transaction の RED tests を追加する**

同atlasでrender generation / station / instance変更後のtexture upload 0、same batch instance reuse、different batch instance-only upload、shared atlas consumer片方削除、candidate preflight / texture upload / submit失敗、source / context / background / dispose後のfence retirement、retire exactly onceを fake resource / completion barrier で固定する。各frameでatlas / topology / 全policy batchを入れ替えるworst caseを`F+2` frame駆動し、texture / topology / instance / nodeのactive、pending-retire、upload、retire counterが上記式を越えないことを検証する。limit超過candidateはScene mutation前にtyped failureとする。

typed probe testは各faultがexactly once発火しbase-only commit、counter snapshot通知、
renderer context generation invalidationによる世代上昇と旧resource fence retirementを固定する。probe nullでは
fault branch / fixture atlas / counter callbackが一度も呼ばれないことを確認する。

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/flutter_scene_sprite_resource_owner_test.dart test/flutter_scene/map_gpu_probe_test.dart test/flutter_scene/flutter_scene_map_adapter_test.dart test/widget/base_map_overlay_frame_builder_test.dart`

Expected: sprite owner / pin API 未定義で FAIL。

- [ ] **Step 4: texture / topology / instance pin ledgerを実装する**

既存 public `Texture2D.fromPixels`、`ShaderMaterial.setTexture`、`TextureSampling` を使う。samplingは`mipmaps: false`、min / mag linear、address mode clamp-to-edge、anisotropy 1に固定し、2px paddingを越えるmipmap bleedを発生させない。prepareはcandidate pinだけを作り、commitでconsumer所有へ移し、rollbackでcandidate pinだけをreleaseする。`StaticInstanceGeometry`はrefcount 0かつcompletion fence後に`retire()`し、明示dispose APIのない`Texture2D` / topology wrapperは同じ条件でownerの強参照を一度だけ解放する。

- [ ] **Step 5: shader reflection preflight と material bindingを実装する**

Scene mutation前にTask 5のbuild検証済みinterface manifestでvertex attributes、40-byte stride / offsets、sampled-image binding name / set / bindingを検証し、実shaderのsymbolと64-byte uniform member offsetsをnative reflectionで検証する。`sampler2D` declarationはTask 5のsource parser testで保証する。candidate texture / topology / instanceを全てeager prepareする。`ShaderMaterial`はalpha blending、opaque false、culling noneとする。

- [ ] **Step 6: adapter / frame ownerへ原子的に統合する**

adapterは全 mesh / observation / sprite preflightとresource prepare後にnode listを構築し、最後に一度だけSceneを置換する。失敗時はcandidate pinをrollbackし、base-onlyをcommitして旧station / sprite nodeを除去する。旧consumer pinはfence完了後にreleaseする。

- [ ] **Step 7: GREEN と解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene test/widget/base_map_overlay_frame_builder_test.dart test/widget/base_map_view_test.dart`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze lib/src/flutter_scene lib/src/renderer test/flutter_scene`

- [ ] **Step 8: resource owner / adapter integrationを別commitにして各commit後にpushする**

Commit: `feat: Flutter Scene sprite resource所有を実装`

Commit: `feat: Scene adapterへsprite batchを統合`

---

### Task 7: App atlas provider と震源 sprite 変換

**Files:**
- Create: `app/lib/feature/earthquake_history/data/provider/earthquake_map_sprite_atlas_provider.dart`
- Create generated: `app/lib/feature/earthquake_history/data/provider/earthquake_map_sprite_atlas_provider.g.dart`
- Create: `app/lib/feature/earthquake_history/data/logic/earthquake_map_sprite_atlas_builder.dart`
- Create: `app/test/feature/earthquake_history/data/earthquake_map_sprite_atlas_builder_test.dart`
- Modify: `app/lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart`
- Modify: `app/lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart`
- Modify: `app/test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart`
- Modify: `app/test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart`

- [ ] **Step 1: atlas packing の RED tests を追加する**

2×2 orientation fixture、alpha 0.5、normal / low-precision regionの2px edge extrusion、texel-center UV、caller limits、SHA-256 identity、入力 image buffer mutationからの独立を pure builderで固定する。

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_sprite_atlas_builder_test.dart`

Expected: builder未定義で FAIL。

- [ ] **Step 2: asset decode provider / pure atlas builderを実装する**

providerは `normal_hypocenter.png` と `low_precise_hypocenter.png` をroot bundleから一度だけdecodeし、`rawStraightRgba`へ変換してpure builderへ渡す。decodeをwidget build内で行わない。atlas limitsはdebug configurationから明示し、decode / pack失敗はtyped AsyncErrorとして旧overlayをpublishしない。

- [ ] **Step 3: hypocenter conversion の RED tests を追加する**

有限かつ範囲内の`CoordinateLatLng`だけが `hypocenter:<eventId>` / normal region featureになること、missing / unknown / NaN / infinity / 緯度経度範囲外で固定位置を作らないこと、既存parameterのsize `0.15@z3 -> 0.4@z20` とfade `1 below z8 / 0.6 at z8`、station deterministic orderを固定する。atlas / zoom policy / display settingだけが変わるfixtureではdata sequence / digestを維持しrender generation / digestだけが進むこともここで固定する。

- [ ] **Step 4: builder / providerをatlas付きsnapshotへ接続する**

`EarthquakeHistoryMapLayerParameter`をbuilder入力にし、generic zoom policyへ変換する。data digestは座標を含み、render digestはatlas / zoom policies /色 /表示設定を含む。event Bへ切替後にevent Aのatlas / detail Futureが完了してもAをpublishしない。

- [ ] **Step 5: codegen、GREEN、解析を確認する**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data/earthquake_map_sprite_atlas_builder_test.dart test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart`

Run: `cd app && mise exec -- dart analyze lib/feature/earthquake_history/data test/feature/earthquake_history/data`

- [ ] **Step 6: atlas / domain変換を別commitにして各commit後にpushする**

Commit: `feat: 地震map sprite atlasを構築`

Commit: `feat: 地震震源をGPU sprite入力へ変換`

---

### Task 8: Debug UI の camera action と診断表示

**Files:**
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel.dart`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action.dart`
- Create generated: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action.g.dart`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action.dart`
- Create generated: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action.g.dart`
- Modify: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page_test.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel_test.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action_test.dart`
- Create: `app/test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action_test.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_coverage.dart`
- Modify: `packages/eqmonitor_map/lib/src/overlay/earthquake_overlay_coverage_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/renderer/base_map_overlay_frame_owner.dart`
- Modify: `packages/eqmonitor_map/lib/src/tile/earthquake_overlay_exact_tile_resolver.dart`
- Modify: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/test/overlay/earthquake_overlay_coverage_test.dart`
- Modify: `packages/eqmonitor_map/test/tile/earthquake_overlay_exact_tile_resolver_test.dart`
- Modify: `packages/eqmonitor_map/test/widget/base_map_overlay_frame_builder_test.dart`

- [ ] **Step 1: presentation / action の RED tests を追加する**

一致するstampのhidden / loading / incomplete / completeだけを表示し、data sequence / render generation、region / city / station / sprite counts、coverage、current zoomを表示することを固定する。震源座標ありかつcommitted cameraありだけ`震源へ移動` actionをenableにする。1 tapにつきexactly one command、widget rebuildでは0 command、buttonは座標がある限り再利用可能とする。command targetはcenterだけをvalidated hypocenterへ置換しzoomは直前のcommitted cameraから厳密に維持する。committed cameraがない場合はactionをdisableし、直接Actionを呼んだ場合はtyped not-ready resultにする。固定zoomへfallbackしない。command failureは短いdeveloper向けmessageにする。

Run: `cd app && mise exec -- flutter test test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel_test.dart test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page_test.dart`

Expected: camera controller UI / version count表示がなく FAIL。

- [ ] **Step 2: coverage diagnostic modelを追加する**

visible canonical tile、authoritative empty、source layer absent、missing / invalid property、decode / schema failure、unresolved code、station、sprite countをimmutable diagnosticにする。exact resolver入力はcache hit、scheduler pending、PMTiles directoryでknown absent、decode failureを明示し、単なるcache missをloadingとして扱う。PMTiles directoryにcanonical tile entryがない場合だけauthoritative empty、present tileのrequired source layer absentはinvalid schema、explicit empty source layerはauthoritative emptyとしてliteral fixturesを分ける。verified evidenceがないsource layer absentはcompleteへ数えず、現Asset Packで水域等を推測しない。exact tile、material、textureのいずれかを準備中なら同じcandidate stampでloadingを通知し、commit後に同じstampのcomplete / incompleteへ原子的に置換する。candidate失敗またはsource switchではhiddenへ戻す。

- [ ] **Step 3: debug pageへcontrollerとactionを接続する**

pageが`MapViewCameraController`を所有・disposeし、`BaseMapView`へ渡す。current zoomはcommitted camera listenableから読む。`EqmonitorMapCameraAction`を`@riverpod`でDIし、pageはtap時にだけActionを呼ぶ。Actionはcontroller / validated coordinateをnamed引数で受け、`ref`や`BuildContext`を保持しない。bannerはWrap /可変高さを使い、例外全文や固定高さを置かない。

compile-time probe flag有効時だけ、fault point、atlas fixture、renderer context generation invalidation、resource
counter snapshotを操作 / 表示する可変高panelを追加する。fixture atlasは震源sprite textureだけを
置換し、event / Fill / stationは実API入力を維持する。flag無効時はpanelもprobe controllerも
構築しない。各selector / button eventは`EqmonitorMapGpuProbeAction`として別fileへ切り出し
Riverpod DIする。

- [ ] **Step 4: GREEN と解析を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/overlay/earthquake_overlay_coverage_test.dart test/tile/earthquake_overlay_exact_tile_resolver_test.dart test/widget/base_map_overlay_frame_builder_test.dart test/widget/map_view_camera_controller_test.dart`

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `cd app && mise exec -- flutter test test/feature/settings/children/config/debug/eqmonitor_map`

Run: `cd app && mise exec -- dart analyze lib/feature/settings/children/config/debug/eqmonitor_map test/feature/settings/children/config/debug/eqmonitor_map`

- [ ] **Step 5: coverage / Action / UIを別commitにして各commit後にpushする**

Commit: `feat: 地震overlay coverage診断を追加`

Commit: `feat: GPU地図の震源移動Actionを追加`

Commit: `feat: GPU地図へ震源移動と診断表示を追加`

---

### Task 9: 全自動回帰、asset staging、知見記録

**Files:**
- Modify when new durable finding exists: `docs/knowledge/20260824_flutter_gpu_map_sprite.md`
- Create only for unresolved implementation debt: `docs/todo/{level}_{title}.md`

- [ ] **Step 1: generated / format差分を確定する**

Run: `mise exec -- dart format packages/eqmonitor_map/lib packages/eqmonitor_map/test app/lib/core/util/map app/lib/core/provider/clock/map_clock_source_identity_provider.dart app/lib/core/provider/clock/map_clock_source_identity_provider.g.dart app/lib/feature/earthquake_history/data app/lib/feature/settings/children/config/debug/eqmonitor_map app/test/core/util/map app/test/core/provider/clock/map_clock_source_identity_provider_test.dart app/test/feature/earthquake_history/data app/test/feature/settings/children/config/debug/eqmonitor_map`

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 2: Asset Pack をstagingする**

Run: `mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled`

archive version、archive SHA-256、PMTiles SHA-256をruntime ledgerへ記録する。取得失敗時に別assetや固定dataへfallbackしない。

- [ ] **Step 3: package全体を検証する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test`

Run: `cd packages/eqmonitor_map && mise exec -- dart analyze --fatal-infos`

- [ ] **Step 4: flutter_scene fork回帰を検証する**

Run: `cd third_party/flutter_scene && mise exec -- flutter test`

Run: `cd third_party/flutter_scene && mise exec -- dart analyze packages/flutter_scene --fatal-infos`

- [ ] **Step 5: app対象回帰を検証する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/data test/feature/settings/children/config/debug/eqmonitor_map test/feature/map/base_map_pmtiles_repository_test.dart`

Run: `cd app && mise exec -- dart analyze --fatal-infos lib/core/util/map lib/core/provider/clock/map_clock_source_identity_provider.dart lib/feature/earthquake_history/data lib/feature/settings/children/config/debug/eqmonitor_map test/core/util/map test/core/provider/clock/map_clock_source_identity_provider_test.dart test/feature/earthquake_history/data test/feature/settings/children/config/debug/eqmonitor_map`

- [ ] **Step 6: resource / security sanityを確認する**

Run: `rg -n "print\(|dynamic\b|Object\b|sourceId|snapshotRevision|\.revision\b|normal_hypocenter|low_precise_hypocenter" packages/eqmonitor_map/lib app/lib/feature/earthquake_history/data app/lib/feature/settings/children/config/debug/eqmonitor_map`

`Object`はcatch境界や既存typed identity以外に新規導入しない。旧 revision alias、asset pathのpackage漏れ、widget build内decode、固定/random fallbackがないことを差分で確認する。

- [ ] **Step 7: durable findingをknowledgeへ記録し、commit・pushする**

Flutter GPU texture origin / premultiply / DataAssets / Simulator・Android差異に再利用可能な知見が判明した場合、再現コマンド付きで500行以内に記録する。未解決debtがある場合だけAGENTS.md規約のtodoを作る。

Commit: `docs: Flutter GPU sprite検証知見を記録`

---

### Task 10: iOS / Android runtime parity gate

**Runtime inputs:**
- verified bundled Asset Pack
- latest real earthquake API data with coordinate and observations
- iOS Simulator Metal / Impeller debug mode（visual / gesture）
- iOS physical device Metal / Impeller profile mode（performance / resource）
- Android emulator or device Impeller profile mode

- [ ] **Step 1: 操作権を調整する**

Simulator / emulatorへagentが入力する直前にユーザーへ通知する。ユーザーが操作中なら入力せず、操作完了後にscreenshot / logをread-only採取する。

- [ ] **Step 2: iOS Simulator debug visual gateを検証する**

次をscreenshotとtimestamp付きlogで確認する。

```text
base + region Fill + station + hypocenter
zoom 5.999: region visible、city hidden、station hidden
zoom 6.000: region hidden、city visible、station visible
pan / pinch追従
震源へ移動
event switch
background 30秒 / foreground
platform lifecycleで実際に観測したsurface / native context recreation
source switch / dispose後にtexture / topology / instance / nodeの
active / pending-retire / upload / retire counterがTask 6の式以内
fixture fault injectionによるatlas upload / shader interface / submit failureでbase-only
Scene / GPU exceptionが連続しない
```

iOS SimulatorはFlutter toolchain上debug modeのみ対応するため、profile evidenceとして
扱わない。

probe flag有効buildでpanelからorientation2x2、alphaHalf、edgeBleedを順に選び、上下方向、
alpha、隣接texel bleedをscreenshot化する。production atlasへ戻して実eventの震源を再確認する。
atlasUpload、shaderInterface、frameSubmit faultを一つずつarmし、一回だけbase-onlyへ
fail closedした後のretryで実overlayが復帰することを確認する。renderer context generation
invalidation buttonを一回押し、simulation上のgenerationとcounterの遷移をledgerへ記録する。

- [ ] **Step 3: iOS physical device profile gateを検証する**

同じevent / camera / lifecycle matrixをphysical iOS deviceのprofile modeで実行し、
frame timing、texture / topology / instance / node counter、failure injection、context
recreationを記録する。probeのrenderer generation invalidationをnative context recreationの
証拠に流用しない。physical deviceを利用できない場合、またはiOSでnative context recreationを
観測できない場合は本subprojectを未完了とする。

- [ ] **Step 4: Android profile runtimeを同じmatrixで検証する**

`adb logcat`でImpeller使用を確認し、同じevent / camera / viewport条件で描画、fault injection、Activity / surface lifecycleによるnative context recreationを確認する。Vulkan / OpenGLESの断定はactual log evidenceがある場合だけ行う。

- [ ] **Step 5: camera / visual parityを判定する**

既存MapLibre fixtureと同一bounds / viewport / paddingで、zoom誤差 `<=1e-6`、center projected logical-pixel誤差 `<=0.5px` を記録する。atlas 2×2、alpha 0.5、edge regionで上下反転、二重premultiply、neighbor bleedがないことを両platformで確認する。

- [ ] **Step 6: completion gateを適用する**

市区町村、観測点、震源、zoom 6境界、camera action、failure injection、actual native context recreation、profile modeのいずれかにevidenceがなければ本subprojectは未完了と記録し、固定値やfake eventで成功扱いにしない。fault injectionとrenderer generation invalidationは失敗 / lifecycle経路の検証だけに使い、正常描画の成功根拠は実API event、native context recreationの根拠はplatform log / lifecycle evidenceに限定する。実装不具合は同planのfix taskとしてTDDで直し、reviewと全自動回帰を再実行する。

---

## Final Review Gate

- [ ] 全taskのscope reviewerが spec compliance と code quality を承認した。
- [ ] 最終whole-branch reviewerが、version遷移、atomic fail-closed、resource lifetime、camera semantics、atlas ABIを重点確認した。
- [ ] reviewer指摘は最大5 fix round以内に解消し、最終reviewerが再承認した。
- [ ] Task 9の全自動検証結果とTask 10のplatform別runtime evidenceをledgerへ残した。
- [ ] `git --no-pager diff develop...HEAD` と `git status --short` を確認し、対象外Info.plist以外の未commit変更がない。
- [ ] 全commitを作業branchへpushした。
