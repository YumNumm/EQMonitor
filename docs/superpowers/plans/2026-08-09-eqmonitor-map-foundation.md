# EQMonitor Map Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1590 として、Flutter Scene と具体的な地物 payload から独立した宣言 scene、frame snapshot、atomic revision、canonical render order、versioned packed render contract、bounded performance observation を公開する。

**Architecture:** `foundation/` は defensive ownership を持つ sealed `MapNode` tree と key/type reconciler、1 frame 1 clock capture、generic revision storeを所有する。render contract は caller-supplied phase policy、versioned vertex layout/pipeline/material/transform、canonical batch compatibilityを明示し、Scene非依存adapterへ渡す。performance collectorはtyped schema/clock domainを検証し、全sampleを先にwindow集約してからdetailed eventだけをsampling/rate-limit/bounded bufferへ流す。

**Tech Stack:** Flutter master `4dacd3fc91d96262a33e5c598e17d816f0b35641`、Dart 3.11、Freezed 3、`dart:typed_data`、`dart:collection`、vector_math、flutter_test、mise。既存Flutter Scene pin `7f71993b7e2a0ab1d2f59726a406098709be7291`はfoundationからimportしない。

## Global Constraints

- 対象はIssue #1590だけ。#1591のPMTiles I/O/isolate transport、#1593の実Scene/GPU lifecycle、#1595の観測点・波・現在地payload、#1596のapp/Home/controllerを先取りしない。
- 欠落している `docs/superpowers/specs/2026-08-07-eqmonitor-map-seismicity-github-issues.md` と未列挙phaseを推測しない。明記済み `labelForeground` 以外はversioned caller-supplied `MapRenderPhasePolicy`を正本にする。
- runtime型はWidget、GeoJSON、Style JSON、network client、Flutter Scene/scene型を保持しない。JSON serializationをhot pathへ追加しない。
- `MapNode`はsealedかつ`@immutable`、nested childrenを再帰的にimmutable nodeへ限定し、constructorでlistをdefensive copyする。reconcileはkey + explicit typeだけを比較し、node tree deep equality/hashをhot pathで呼ばない。
- full/delta builderは両方 `MapRevisionCandidate<TState>` を返す。storeへ注入した `MapRevisionStateOwner<TState>` がdeep immutable ownershipを確立し、candidate digestをmetadata/target digestと照合した後だけatomic commitする。
- no-current、gap/branch、latched resultはstore getterと同じrequestを返す。active Aへのwrong-source B deltaはcurrent/latchを一切変更せず、既存A request（なければnull）を返してBによるresync DoSを防ぐ。
- sortは `phase → phase内宣言順 → source → overscaled tile → feature` のみ。phase跨ぎinterleave、非連続material結合、Feature単位Scene Nodeは禁止。hit-testは同じkeyの逆順。
- packed contractはcontract/layout/pipeline/material version、topology、byte order、attribute semantic/format/offset、index有無、transform、material parameter bytesを明示する。adapterはphase/layout/pipeline/version/material互換な連続packetだけを1 batchへする。
- performanceはtyped schema version + clock domain、observation level、aggregation window、percentile、snapshot interval、sample reservoir上限、event buffer上限、drop policyを必須入力にする。version/domain不一致は集約前にrejectする。
- queue wait/execution、GPU submission/completion、Flutter `FrameTiming` build/raster/vsync、cache hit/miss、current/peak bytes、request/decode bytes、tile queue、GPU bucket、label candidate/acceptedをtyped metricとして扱う。snapshotはmetricごとのcount/sum/min/max/percentileを持つ。
- detailed eventのsampling/rate-limit/dropより前にaggregateへ記録する。rate-limitによりaggregate countが欠落してはならない。
- KEVi pin `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f` からUI/render snapshot、phase内宣言順、逆順hit-test、bounded/rate-limited metricsを採用する。Miller projection、global declaration order、mutable setter layer、全frame再描画は不採用。
- dashmap pin `a6ff92edd999e922f81d26d209d8f589faee3fd0` からpure typed-data CPU job、tile batch、bounded in-flight/apply budget、GPUなしtestを採用する。domainの直接`Scene`所有、subsystem別`DateTime.now()`、mutable streamer APIは不採用。
- 新規依存なし。Flutter/Dart commandは必ず `mise exec --`。class内private method、`dynamic`/`Object`（許可済みmap以外）、`!`、`print()`を追加しない。2引数以上は名前付き引数。
- 手書き `operator ==(Object)` / `hashCode` は追加しない。単一値はvalidation付きprivate extension type、複合値はprivate Freezed factory + validated creator、typed bytesはnamed content comparatorを使う。全Taskでbuild_runnerを実行しgenerated fileを同logical commitへ含める。
- device/simulator/golden/E2Eは実施しない。pure tests、全public constructor compile、`flutter_scene`/`scene` import isolation、BaseMap regression、package analyze/testで代替する。
- 各Taskは手書き差分約30〜100行の1 logical commitを目安とする。対象test、format、`git diff --check`後にcommitし、毎commit `git push`。実装完了までPRは作らない。

---

### Task 1: Node identity value objectsを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_node_identity.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_node_identity_test.dart`

**Interfaces:** `createMapNodeKey({required String value})`, `createMapNodeTypeId({required String value})`, private Freezed factoryを持つ `createMapNodeIdentity({required key, required type})`, `classifyMapNodeIdentity(...)`。

- [ ] 空/空白ID reject、同値の `==`/`hashCode`、同key+type retain、どちらか違えばreplaceのfailing testを書く。
- [ ] RED: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/map_node_identity_test.dart`（型未定義）。
- [ ] IDはtrim済み非空を要求するprivate extension type + validated creator、identityはprivate Freezed factoryにする。手書きObject equality/hashを使わない。

```dart
MapNodeIdentityChange classifyMapNodeIdentity({
  required MapNodeIdentity previous,
  required MapNodeIdentity next,
}) => previous == next ? MapNodeIdentityChange.retain : MapNodeIdentityChange.replace;
```

- [ ] GREEN/生成/commit:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_node_identity.dart test/foundation/map_node_identity_test.dart
mise exec -- flutter test test/foundation/map_node_identity_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_node_identity.dart packages/eqmonitor_map/lib/src/foundation/map_node_identity.freezed.dart packages/eqmonitor_map/test/foundation/map_node_identity_test.dart
git commit -m "Feat: 地図node identityを追加"
git push
```

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_node_identity_test.dart
```

Expected: FAIL（Task 1の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_node_identity.dart test/foundation/map_node_identity_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_node_identity_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 1 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/map_node_identity.dart packages/eqmonitor_map/lib/src/foundation/map_node_identity.freezed.dart packages/eqmonitor_map/test/foundation/map_node_identity_test.dart
git commit -m "Feat: 地図node identityを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 1B: source identity/content digest valueを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_source_identity.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_source_identity_test.dart`

**Interfaces:** `createMapSourceInstanceId({required String value})`, `createMapContentDigest({required String value})`。

- [ ] 空/空白reject、trim normalization、同値equality/hash、sourceとdigestの型混同不可をtestする。private extension type + validated creatorを使う。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_source_identity_test.dart
```

Expected: FAIL（source identity未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_source_identity.dart test/foundation/revision/map_source_identity_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_source_identity_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 1B testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_source_identity.dart packages/eqmonitor_map/test/foundation/revision/map_source_identity_test.dart
git commit -m "Feat: 地図source identityを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 2: sealed immutable MapNode/MapSceneを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_node.dart`
- Create: `packages/eqmonitor_map/lib/src/foundation/map_scene.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_node_ownership_test.dart`

**Interfaces:** sealed `MapNode`, `MapDeclarationNode({required MapNodeIdentity identity, required List<MapNode> children})`, `MapScene({required List<MapNode> children})`。

- [ ] 元children list変更、nested child list変更、返却listへのaddがscene/nodeを変更できないfailing testを書く。全nodeが `@immutable` であることをcompileさせる。
- [ ] RED: `mise exec -- flutter test test/foundation/map_node_ownership_test.dart`。
- [ ] `MapNode`、`MapDeclarationNode`、`MapScene`をすべて `@immutable` にし、manual factoryで各階層を `List<MapNode>.unmodifiable(List.of(children))` に所有させる。sealed制約により子もimmutable `MapNode`以外を受け取れない。

```dart
@immutable
sealed class MapNode {
  const MapNode({required this.identity, required this.children});
  final MapNodeIdentity identity;
  final List<MapNode> children;
}
```

- [ ] format/test/diff-check後、`git commit -m "Feat: immutable地図scene treeを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_node_ownership_test.dart
```

Expected: FAIL（Task 2の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_node.dart lib/src/foundation/map_scene.dart test/foundation/map_node_ownership_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_node_ownership_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 2 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/map_node.dart packages/eqmonitor_map/lib/src/foundation/map_scene.dart packages/eqmonitor_map/test/foundation/map_node_ownership_test.dart
git commit -m "Feat: immutable地図scene treeを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 3: MapElement lifecycle interfaceを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_element.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_element_lifecycle_test.dart`

**Interfaces:** `MapElement.identity`, `mount/update/unmount`, `MapElementFactory.create({required node})`。

- [ ] recording fakeがmount/update/unmountを型安全に記録するfailing compile testを書く。
- [ ] REDを同testで確認する。
- [ ] interfaceだけを実装し、network/GPU/async commandを持たせない。

```dart
abstract interface class MapElement {
  MapNodeIdentity get identity;
  void mount({required MapNode node});
  void update({required MapNode node});
  void unmount();
}
```

- [ ] format/test/diff-check後、`git commit -m "Feat: 地図element lifecycleを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_element_lifecycle_test.dart
```

Expected: FAIL（Task 3の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_element.dart test/foundation/map_element_lifecycle_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_element_lifecycle_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 3 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/map_element.dart packages/eqmonitor_map/test/foundation/map_element_lifecycle_test.dart
git commit -m "Feat: 地図element lifecycleを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 4: retain/reorder reconcileを実装する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_child_reconciler_retain_test.dart`

**Interfaces:** `MapChildReconciler.elements`, `reconcile({required nodes, required factory})`。

- [ ] `[a,b]→[b,a]` がmount追加なしで両方updateし、elements順だけ変えるfailing testを書く。
- [ ] RED確認後、next key indexとprevious key indexを作り、same identityは既存elementをretain/updateする。
- [ ] listはunmodifiable getterで公開し、node equalityは呼ばない。
- [ ] format/test/diff-check後、`git commit -m "Feat: 同一node elementをretain" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_child_reconciler_retain_test.dart
```

Expected: FAIL（Task 4の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_child_reconciler.dart test/foundation/map_child_reconciler_retain_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_child_reconciler_retain_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 4 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart packages/eqmonitor_map/test/foundation/map_child_reconciler_retain_test.dart
git commit -m "Feat: 同一node elementをretain"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 5: replace/unmountと重複key atomic rejectを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_child_reconciler_replace_test.dart`

**Interfaces:** Task 4にreplace/removeと `unmountAll()` を追加。

- [ ] same key/different typeが `unmount old→mount new`、removed elementが旧逆順unmount、二回目unmountAllがno-opのtestを書く。
- [ ] duplicate next sibling keyが一件もlifecycleを呼ばず `ArgumentError` のtestを書く。
- [ ] 全next keyを先に検証してcandidate element orderを作り、成功後にinternal listを1回で交換する。
- [ ] format/test/diff-check後、`git commit -m "Feat: element置換をatomicに適用" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_child_reconciler_replace_test.dart
```

Expected: FAIL（Task 5の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_child_reconciler.dart test/foundation/map_child_reconciler_replace_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_child_reconciler_replace_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 5 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart packages/eqmonitor_map/test/foundation/map_child_reconciler_replace_test.dart
git commit -m "Feat: element置換をatomicに適用"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 6: typed clock domainとsingle captureを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/frame/map_clock.dart`
- Create: `packages/eqmonitor_map/test/foundation/frame/map_clock_test.dart`

**Interfaces:** `createMapClockDomainId({required value})`, `MapClockCapture`, `MapClock.capture()`, `SystemMapClock.start({required domain})`。

- [ ] domain equality/hash、空domain/local DateTime/負monotonic reject、System capture monotonic非減少をtestする。
- [ ] RED確認後、domainはvalidation付きprivate extension type、captureはvalidated private constructorで実装する。capture自体にvalue equality/hash contractは付与せず、手書きObject equality/hashも追加しない。

```dart
abstract interface class MapClock { MapClockCapture capture(); }
```

`SystemMapClock.capture()`だけが `DateTime.now().toUtc()` と同じStopwatchのelapsedを取得する。
- [ ] format/test/diff-check後、`git commit -m "Feat: typed frame clockを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_clock_test.dart
```

Expected: FAIL（Task 6の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_clock.dart test/foundation/frame/map_clock_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_clock_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 6 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/frame/map_clock.dart packages/eqmonitor_map/test/foundation/frame/map_clock_test.dart
git commit -m "Feat: typed frame clockを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 7: canonical frame revision stampを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.dart`
- Create: `packages/eqmonitor_map/test/foundation/frame/map_frame_revision_test.dart`

**Interfaces:** `MapFrameSourceRevisionStamp({sourceInstanceId, revision, contentDigest})`, `MapFrameLayerRevisionStamp({sourceInstanceId, ownerKey, revision})`, sealed Freezed `MapFrameRevisionStamp`, canonicalizer。

- [ ] source stampのsourceInstanceId/contentDigest必須、負revision、重複identity reject、source→layer→sourceInstanceId→ownerKey sort、alias mutation不可能をtestする。
- [ ] RED後、canonicalizerがdefensive copyを返すよう実装する。
- [ ] GREEN/生成/commit:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_frame_revision.dart test/foundation/frame/map_frame_revision_test.dart
mise exec -- flutter test test/foundation/frame/map_frame_revision_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.dart packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.freezed.dart packages/eqmonitor_map/test/foundation/frame/map_frame_revision_test.dart
git commit -m "Feat: frame revisionをcanonical化"
git push
```

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_frame_revision_test.dart
```

Expected: FAIL（Task 7の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_frame_revision.dart test/foundation/frame/map_frame_revision_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_frame_revision_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 7 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.dart packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.freezed.dart packages/eqmonitor_map/test/foundation/frame/map_frame_revision_test.dart
git commit -m "Feat: frame revisionをcanonical化"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 8: MapFrameSnapshotを1 capture/frameで構築する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/frame/map_frame_snapshot.dart`
- Create: `packages/eqmonitor_map/test/foundation/frame/map_frame_snapshot_test.dart`

**Interfaces:** `MapAppLifecycle`, immutable `MapFrameSnapshot`, `captureMapFrameSnapshot({clock, frameSequence, camera, viewport, revisions, lifecycle, sceneContextGeneration})`。

- [ ] counting fake clockが1回だけ呼ばれ、wall/monotonic/domain/camera/viewport/revisions/contextを同一snapshotへ固定するtestを書く。
- [ ] 負frame/context rejectを追加しRED確認。
- [ ] public constructorを置かずcapture関数だけがvalidated private constructorでimmutable snapshotを作る。snapshot自体にvalue equality/hash contractは付与しない。revisionはTask 7 canonicalizerのowned listを使う。
- [ ] format/test/diff-check後、`git commit -m "Feat: frame snapshotを一回の時刻取得で固定" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_frame_snapshot_test.dart
```

Expected: FAIL（Task 8の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_frame_snapshot.dart test/foundation/frame/map_frame_snapshot_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_frame_snapshot_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 8 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_snapshot.dart packages/eqmonitor_map/test/foundation/frame/map_frame_snapshot_test.dart
git commit -m "Feat: frame snapshotを一回の時刻取得で固定"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 9A: revision metadataを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_test.dart`

**Interfaces:** Task 1Bのsource/digestを消費する `MapFullRevision`, `MapDeltaRevision.targetDigest`。

- [ ] 負revision、`target<=base` rejectをtestする。deltaは `targetDigest` をrequiredにする。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_test.dart
```

Expected: FAIL（Task 9Aの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 9A testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart packages/eqmonitor_map/test/foundation/revision/map_revision_test.dart
git commit -m "Feat: revision metadataを型定義"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 9B: committed/result/resync requestを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_result_test.dart`

**Interfaces:** `MapCommittedRevision<TState>` はこのTaskで生成し、result factoriesとderived getterを公開する。

- [ ] result factories `committed/idempotentNoOp/rejected` の `current`, `reason`, `fullResyncRequest`, derived `requiresFullResync` が全variantで整合するtestを書く。
- [ ] RED後、sealed resultとprivate variant constructorを実装し、public exact factoryだけから生成する。不可能な組合せ（committed+reason、rejected+reason null）を型とfactoryで拒否し、手書きObject equality/hashは追加しない。

```dart
enum MapRevisionRejectReason {
  candidateDigestMismatch,
  staleFull,
  conflictingEqualRevision,
  deltaWithoutFull,
  sourceMismatch,
  staleDelta,
  gap,
  branch,
  resyncLatched,
}

factory MapDeltaRevision({
  required MapSourceInstanceId source,
  required int baseRevision,
  required int targetRevision,
  required MapContentDigest targetDigest,
});

bool get requiresFullResync => fullResyncRequest != null;
```

`committed` はnon-null currentとnull request、`idempotentNoOp` はnon-null currentと既存request、`rejected` はnullable current、non-null reason、store getterと同一のnullable requestを受け取るexact factoryにする。

- [ ] format/test/diff-check後、`git commit -m "Feat: revision結果とresync要求を型定義" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_result_test.dart
```

Expected: FAIL（Task 9Bの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_result_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_result_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 9B testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart packages/eqmonitor_map/test/foundation/revision/map_revision_result_test.dart
git commit -m "Feat: revision結果とresync要求を型定義"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 10: revision candidate ownership境界を追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_state_owner.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_state_owner_test.dart`

**Interfaces:** `MapRevisionCandidate<TState>({required state, required digest})`, `MapRevisionStateOwner<TState>.own({required candidate})`。

- [ ] mutable `Map<String, List<int>>` candidateをouter mapとinner listの両方でdeep-ownするfake owner testを書く。元outer/inner alias変更がowned stateへ反映されず、owned outer/inner変更がthrowすることを固定。
- [ ] RED後、generic interfaceとcandidateだけを実装する。storeはcandidate stateを直接保存しない契約をdoc commentへ明記。

```dart
abstract interface class MapRevisionStateOwner<TState> {
  TState own({required TState candidate});
}
```

- [ ] format/test/diff-check後、`git commit -m "Feat: revision state ownership境界を追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_state_owner_test.dart
```

Expected: FAIL（Task 10の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision_state_owner.dart test/foundation/revision/map_revision_state_owner_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_state_owner_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 10 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_state_owner.dart packages/eqmonitor_map/test/foundation/revision/map_revision_state_owner_test.dart
git commit -m "Feat: revision state ownership境界を追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 11: full candidate digest検証とatomic commitを実装する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_full_commit_test.dart`

**Interfaces:** `MapRevisionCommitStore<TState>({required owner})`, `current`, `commitFull({required metadata, required MapRevisionCandidate<TState> Function() validateAndBuild})`。

- [ ] first full commit後にcandidate元aliasを変更してもcurrent不変、owner throw/build throwでcurrent不変のtestを書く。
- [ ] candidate.digest != metadata.digestは `candidateDigestMismatch` reject、lower stale、equal same digest no-op、equal different digest conflict、新sourceはsuccess後だけ交換をtestする。
- [ ] RED後、builder→digest照合→revision判定→owner→single assignment順で実装する。no-opでもbuilder/digest検証は行う。

```dart
MapRevisionApplyResult<TState> commitFull({
  required MapFullRevision metadata,
  required MapRevisionCandidate<TState> Function() validateAndBuild,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: full revisionをdigest検証後commit" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_full_commit_test.dart
```

Expected: FAIL（Task 11の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_full_commit_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_full_commit_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 11 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_full_commit_test.dart
git commit -m "Feat: full revisionをdigest検証後commit"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 12: exact-base delta commitを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_delta_commit_test.dart`

**Interfaces:** `commitDelta({required metadata, required MapRevisionCandidate<TState> Function(TState current) validateAndBuild})`。

- [ ] exact base 4→5がcandidate target digest/stateをownership後commitし、commit後のcandidate outer/inner alias変更がcurrentへ届かないtestを書く。
- [ ] candidate digestと `MapDeltaRevision.targetDigest` 不一致、builder/owner throw、stale targetがcurrentを変更しないtestを書く。
- [ ] RED後、current stateをbuilderへ渡すが、returned stateだけをowner経由でcommitする。old digestを引き継がない。

```dart
MapRevisionApplyResult<TState> commitDelta({
  required MapDeltaRevision metadata,
  required MapRevisionCandidate<TState> Function(TState current)
      validateAndBuild,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: exact revision deltaをatomic適用" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_delta_commit_test.dart
```

Expected: FAIL（Task 12の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_delta_commit_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_delta_commit_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 12 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_delta_commit_test.dart
git commit -m "Feat: exact revision deltaをatomic適用"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 13: no-current/source/gap/branch resync latchを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_resync_test.dart`

**Interfaces:** `fullResyncRequest`, `needsFullResync`, `resyncAfterRevision` getters。

- [ ] delta-before-fullはrequest(source, after:null)、gap/branchはcurrent source + after current revisionをstore/result双方へ設定するtestを書く。
- [ ] active source A/current revision 4でlatchなしの時にwrong-source B deltaを渡すと、builder未実行・current A不変・result request null・getter nullになるfixtureを書く。Aのgapでrequest(A, after:4)をlatchした後のB deltaはbuilder未実行・current/latch不変・resultがgetterと同じ既存A requestを返すことも固定する。B requestへ交換してA復旧を妨げる経路を禁止する。
- [ ] latch中delta resultのrequestがgetterと同値、equal full no-op/failed builder/digest mismatchは解除しないことをtestする。さらにA revision 6のvalid newer fullでA latchを解除し、直後のexact-base A 6→7 deltaがcommitされる一連のfixtureを必須にする。valid new-source full commitによるsource交換は成功後だけlatchを解除する。
- [ ] RED後、resultの `requiresFullResync` は同じrequestのnullable性だけから導出する。requestを返しつつgetter falseになる経路を作らない。

```dart
MapFullResyncRequest? get fullResyncRequest => _fullResyncRequest;
bool get needsFullResync => fullResyncRequest != null;
int? get resyncAfterRevision => fullResyncRequest?.afterRevision;
```

- [ ] format/test/diff-check後、`git commit -m "Feat: delta gapをfull resyncへlatch" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_resync_test.dart
```

Expected: FAIL（Task 13の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_resync_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_resync_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 13 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_resync_test.dart
git commit -m "Feat: delta gapをfull resyncへlatch"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 14: versioned caller-supplied phase policyを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_phase.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_phase_test.dart`

**Interfaces:** `createMapRenderPhaseId({required value})`, `MapRenderPhaseId.labelForeground`, `MapRenderPhasePolicy(version, orderedPhases)`, `rankOf({required phase})`。

- [ ] version<=0、empty/duplicate、labelForeground欠落、unknown lookup rejectとcaller orderをtestする。
- [ ] RED後、IDはvalidation付きprivate extension type、policyはvalidated private constructorとdefensive ordered list/rank mapで実装する。固定phaseはlabelForegroundだけで、手書きObject equality/hashは追加しない。
- [ ] format/test/diff-check後、`git commit -m "Feat: version付き描画phase順を追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_phase_test.dart
```

Expected: FAIL（Task 14の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_phase.dart test/foundation/render/map_render_phase_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_phase_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 14 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_phase.dart packages/eqmonitor_map/test/foundation/render/map_render_phase_test.dart
git commit -m "Feat: version付き描画phase順を追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 15: canonical RenderSortKeyを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_sort_key.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_sort_key_test.dart`

**Interfaces:** `MapRenderSortKey(phasePolicyVersion, phase, declarationOrderWithinPhase, sourceOrder, overscaledTileOrder, featureOrder)`, `compareMapRenderSortKeys(...)`、`reverseMapRenderSortKeysForHitTest(...)`。

- [ ] 5段階sort、phase policy version mismatch、負field、duplicate key reject、reverse hit-testをtestする。
- [ ] RED後、comparatorは上記field以外を読まず、unknown phaseをpolicy errorにする。
- [ ] format/test/diff-check後、`git commit -m "Feat: canonical描画順を固定" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_sort_key_test.dart
```

Expected: FAIL（Task 15の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_sort_key.dart test/foundation/render/map_render_sort_key_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_sort_key_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 15 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_sort_key.dart packages/eqmonitor_map/test/foundation/render/map_render_sort_key_test.dart
git commit -m "Feat: canonical描画順を固定"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 16: vertex attribute format descriptorを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_vertex_attribute.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_vertex_attribute_test.dart`

**Interfaces:** `MapVertexAttributeSemantic`, `MapVertexAttributeFormat`, `MapVertexAttributeLayout(semantic, format, byteOffset)`、formatの`byteLength`/`scalarAlignment`、`validateMapVertexAttributeLayout(...)`。

- [ ] formatごとのexact byte length（float32x2/x3/x4、uint8x4Normalized、uint16x2、uint32）、負offset、semantic equalityをtestする。
- [ ] RED後、format byte lengthはexhaustive switchで返し、custom byte countを許可しない。

```dart
int mapVertexAttributeByteLength({required MapVertexAttributeFormat format}) =>
    switch (format) {
      .float32x2 => 8,
      .float32x3 => 12,
      .float32x4 => 16,
      .uint8x4Normalized => 4,
      .uint16x2 => 4,
      .uint32 => 4,
    };
```

- [ ] format/test/diff-check後、`git commit -m "Feat: packed頂点attribute形式を追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_vertex_attribute_test.dart
```

Expected: FAIL（Task 16の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_vertex_attribute.dart test/foundation/render/map_vertex_attribute_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_vertex_attribute_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 16 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_vertex_attribute.dart packages/eqmonitor_map/test/foundation/render/map_vertex_attribute_test.dart
git commit -m "Feat: packed頂点attribute形式を追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 17: topology/byte-order/indexを含むpacked layoutを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh_layout.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_packed_mesh_layout_test.dart`

**Interfaces:** `MapPrimitiveTopology`, `MapPackedByteOrder`, `MapIndexFormat`, `MapPackedMeshLayout(version, topology, byteOrder, vertexStrideBytes, attributes, indexFormat)`、`haveCompatibleMapPackedMeshLayouts({required left, required right})`。

- [ ] topologyは `points/lineList/lineStrip/triangleList/triangleStrip`、byte orderは `little/big`、indexは `uint16/uint32` だけに固定する。attribute formatは `float32x2/x3/x4/uint8x4Normalized/uint16x2/uint32`、semanticは `position2D/position3D/normal3D/colorRgba8/texCoord2D/lineExtrude2D/featureIdUint32` だけにする。
- [ ] nonpositive version/stride、空/duplicate semantic、strict offset order、format scalar alignment、range nonoverlap、offset+size<=stride、stride max alignment、index widthをtestする。
- [ ] RED後、attributesをdefensive copyし、validated private constructorからだけ生成する。batch互換判定には全fieldを比較するnamed `haveCompatibleMapPackedMeshLayouts({required left, required right})` を使い、手書きObject equality/hashは追加しない。

```dart
factory MapPackedMeshLayout({
  required int version,
  required MapPrimitiveTopology topology,
  required MapPackedByteOrder byteOrder,
  required int vertexStrideBytes,
  required List<MapVertexAttributeLayout> attributes,
  required MapIndexFormat? indexFormat,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: packed mesh layoutをversion化" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_packed_mesh_layout_test.dart
```

Expected: FAIL（Task 17の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_packed_mesh_layout.dart test/foundation/render/map_packed_mesh_layout_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_packed_mesh_layout_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 17 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh_layout.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_layout_test.dart
git commit -m "Feat: packed mesh layoutをversion化"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 18: index iffとimmutable bytesを持つMapPackedMeshを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_packed_mesh_test.dart`

**Interfaces:** `MapPackedMesh(payloadVersion, layout, vertexBytes, vertexCount, indexBytes?, indexCount)`。

- [ ] nonpositive payloadVersion、alias mutation/返却view mutation、vertex length、indexed layoutならindexBytes non-null/count>0、non-indexedならindexBytes null/count==0、index byte lengthをtestする。
- [ ] RED後、bytesを `Uint8List.fromList(...).asUnmodifiableView()` で所有する。layout.byteOrderの変換は行わずadapter contractへ渡す。

```dart
final hasIndexLayout = layout.indexFormat != null;
final hasIndexPayload = indexBytes != null && indexCount > 0;
if (hasIndexLayout != hasIndexPayload) {
  throw ArgumentError('index payload must exist iff layout is indexed');
}
```

- [ ] format/test/diff-check後、`git commit -m "Feat: immutable packed meshを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_packed_mesh_test.dart
```

Expected: FAIL（Task 18の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_packed_mesh.dart test/foundation/render/map_packed_mesh_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_packed_mesh_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 18 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_test.dart
git commit -m "Feat: immutable packed meshを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 19: transform/material/pipeline付きrender packetを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_packet_test.dart`

**Interfaces:** private Freezed factoriesで検証する `createMapRenderPipelineKey(...)` / `createMapRenderBatchKey(...)`、`createMapMaterialParameterBlock(...)`、named `haveEqualMapMaterialParameterContent({required left, required right})`、`createMapRenderPacket(...)`。

- [ ] 16要素Float64 transformとmaterial bytesのalias mutation、nonpositive versions、sort keyとbatch keyのphase/policyVersion不一致をfactoryでrejectし、material bytesのidentityでなくcontent equalityをtestする。
- [ ] RED後、transform/parameter bytesをdefensive unmodifiable copyする。pipeline/batch keyの全field value equality/hashはFreezed生成へ限定し、material bytesはnamed content comparatorだけで比較する。手書きObject equality/hashは追加しない。
- [ ] packetはactual Flutter Scene Material/Matrix型をimportしない。

```dart
factory MapRenderPacket({
  required int contractVersion,
  required MapRenderSortKey sortKey,
  required MapRenderBatchKey batchKey,
  required MapRenderPipelineKey pipeline,
  required MapPackedMesh mesh,
  required Float64List modelTransform,
  required MapMaterialParameterBlock materialParameters,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: version付きrender packetを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_packet_test.dart
```

Expected: FAIL（Task 19の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_packet.dart test/foundation/render/map_render_packet_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_packet_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 19 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.dart packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.freezed.dart packages/eqmonitor_map/test/foundation/render/map_render_packet_test.dart
git commit -m "Feat: version付きrender packetを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 20A: validated batch factoryを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_batch_test.dart`

**Interfaces:** raw public constructorを持たない `createMapRenderBatch({version, policy, packets})`, `instanceTransforms`（packetsと1:1同順）。

- [ ] factoryがnonempty/canonical order/unique sort key/全compatibilityを検証する。空、非canonical、sort key重複をrejectし、異なるtransformのcompatible packetsを受理してtransform tableがpacketと1:1同順になるtestを書く。
- [ ] 同batch keyでもpacket contract version、mesh payload version、phase、phase policy version、layout、pipeline version/key、material parameter version/content bytesのどれかが違えば別batchになるtestをparameterizedで書く。nonpositive batch versionもrejectする。
- [ ] RED後、次のcompatibility recordを全fieldから構築し、factoryへ渡された全packetが同一compatibilityであることを検証する。

```dart
typedef MapRenderBatchCompatibility = ({
  int contractVersion,
  int meshPayloadVersion,
  MapRenderBatchKey batchKey,
  MapRenderPhaseId phase,
  int phasePolicyVersion,
  MapPackedMeshLayout layout,
  MapRenderPipelineKey pipeline,
  MapMaterialParameterBlock materialParameters,
});
```

- [ ] record自体の暗黙`==`だけで判定せず、layoutは`haveCompatibleMapPackedMeshLayouts`、materialは`haveEqualMapMaterialParameterContent`、残りはtyped value equalityで比較する。
- [ ] transformはcompatibilityから意図的に除外しpacket別immutable multi-transform tableへ保持する。batch packet/transform listをdefensive copyする。format/test/diff-check後、`git commit -m "Feat: 描画batch互換条件を固定" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_batch_test.dart
```

Expected: FAIL（Task 20Aの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_batch_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 20A testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_test.dart
git commit -m "Feat: 描画batch互換条件を固定"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 20B: exact multi-transform groupingを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_batch_builder_test.dart`

**Interfaces:** `buildCanonicalRenderBatches({required version, required policy, required packets})`。

- [ ] inputを`compareMapRenderSortKeys`でstable canonical sortし、同一compatibilityの連続packetだけをTask 20A factoryへ渡す。sort key重複はgrouping前にrejectする。
- [ ] canonical A/A→1 batch、A/B/A→3 batchesを固定fixtureでtestする。A/B/Aはsort後もA/B/Aとなるsort keyを明示し、非連続Aを誤って統合しないことを固定する。
- [ ] transformだけが異なるcompatible A/A→1 batchをtestし、`instanceTransforms`がcanonical packet列と1:1・同順・immutableであることを検証する。
- [ ] packet phaseと`MapRenderBatchKey.phase`、packet policy versionと`MapRenderBatchKey.phasePolicyVersion`が不一致ならgrouping前にrejectする。phase/policyをbatch keyへ含めるTask 19 invariantを緩和しない。
- [ ] format/test/diff-check後、`git commit -m "Feat: 描画packetをcanonical batch化" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_batch_builder_test.dart
```

Expected: FAIL（Task 20Bのbuilder・grouping・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_builder_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_batch_builder_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 20B testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_builder_test.dart
git commit -m "Feat: 描画packetをcanonical batch化"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 21: Scene非依存adapter fake contractを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/support/recording_map_render_batch_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/map_render_batch_adapter_contract_test.dart`

**Interfaces:** `MapRenderBatchAdapter.submit({required frame, required batches})`, immutable `MapRenderSubmission`。

- [ ] fakeが1 frame/immutable batchesを記録し、render object countがpacket数ではなくbatch数になるtestを書く。
- [ ] version/phase/order不整合submissionをfake validatorがrejectするtestを書く。
- [ ] RED後、productionはinterface/submission/validatorだけ、recording fakeはtest supportだけに置く。
- [ ] format/test後、両import grepを実行する。

```bash
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
```

- [ ] diff-check後、`git commit -m "Feat: Scene非依存描画adapter契約を追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/renderer/support/recording_map_render_batch_adapter.dart test/renderer/map_render_batch_adapter_contract_test.dart
```

Expected: FAIL（Task 21の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/renderer/map_render_batch_adapter.dart test/renderer/support/recording_map_render_batch_adapter.dart test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/renderer/support/recording_map_render_batch_adapter.dart test/renderer/map_render_batch_adapter_contract_test.dart test/eqmonitor_map_library_test.dart
cd ../..
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
git diff --check
```

Expected: Task 21 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer/support/recording_map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer/map_render_batch_adapter_contract_test.dart
git commit -m "Feat: Scene非依存描画adapter契約を追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 22A: typed performance schema/sampleを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_sample_test.dart`

**Interfaces:** `createMapPerformanceSchemaVersion({required value})`, unit-specific `MapPerformanceSample.duration/count/bytes(...)`。

- [ ] schema versionはvalidation付きprivate extension typeでequality/hash/positive validationを得る。sample clock domain、非負value、metric-unit mismatch rejectをtestする。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_sample_test.dart
```

Expected: FAIL（Task 22Aの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_metric.dart test/foundation/performance/map_performance_sample_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_sample_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 22A testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart packages/eqmonitor_map/test/foundation/performance/map_performance_sample_test.dart
git commit -m "Feat: 性能sample schemaを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 22B: performance metric/Event catalogを固定する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_catalog_test.dart`

**Interfaces:** `MapPerformanceMetricUnit`, exact enum/unit mapping、version/domain typed `MapPerformanceEvent(frameSequence,sample,fixtureId?,nodeKey?,operationId?)`。

- [ ] metric enumへ次をexactに列挙する。

```dart
enum MapPerformanceMetricKind {
  frameReconciliation,
  tileCover,
  labelPlacement,
  renderSubmission,
  tileRequestQueueWait,
  tileRequestExecution,
  decodeQueueWait,
  decodeExecution,
  meshBuildQueueWait,
  meshBuildExecution,
  gpuUploadQueueWait,
  gpuUploadExecution,
  gpuSubmission,
  gpuCompletion,
  flutterBuild,
  flutterRaster,
  flutterFrameBudgetOverrun,
  cacheHit,
  cacheMiss,
  currentCpuBytes,
  peakCpuBytes,
  currentGpuBytes,
  peakGpuBytes,
  requestBytes,
  decodeBytes,
  tileQueueDepth,
  gpuBucketCount,
  labelCandidateCount,
  labelAcceptedCount,
  instrumentationOverhead,
}
```

- [ ] RED後、metric unitはexhaustive switch、sample factoryは対応unit以外をrejectする。durationはmicroseconds、count/bytesはintとして保持する。eventはsampleのschemaVersion/clockDomainをそのままtyped getterで公開し、fixture/node provenanceを任意で保持する。

```dart
factory MapPerformanceSample.duration({
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required MapPerformanceMetricKind kind,
  required Duration monotonicAt,
  required Duration value,
});
```
- [ ] format/test/diff-check後、`git commit -m "Feat: typed性能metricを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_catalog_test.dart
```

Expected: FAIL（Task 22Bの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_metric.dart test/foundation/performance/map_performance_catalog_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_catalog_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 22B testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart packages/eqmonitor_map/test/foundation/performance/map_performance_catalog_test.dart
git commit -m "Feat: typed性能metricを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 23: observation/aggregation policyを追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_policy.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_policy_test.dart`

**Interfaces:** `MapPerformanceObservationLevel.off/aggregate/detailed`, `MapPerformanceDropPolicy`, `createMapFrameBudget({required duration})`, `MapPerformancePolicy(...)`。

- [ ] policyがschemaVersion、clockDomain、level、aggregationWindow、percentiles、snapshotInterval、maxSamplesPerMetricPerWindow、detailedSampleEveryNFrames、eventMinInterval、eventBufferCapacity、dropPolicyを全てrequiredにするcompile testを書く。
- [ ] duration/capacityとframe budget正値、percentile `(0,100]` sorted unique、snapshotInterval<=aggregationWindowをtestする。
- [ ] RED後、listをdefensive copyし暗黙defaultを作らない。

```dart
factory MapPerformancePolicy({
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required MapPerformanceObservationLevel level,
  required Duration aggregationWindow,
  required List<double> percentiles,
  required Duration snapshotInterval,
  required int maxSamplesPerMetricPerWindow,
  required int detailedSampleEveryNFrames,
  required Duration eventMinInterval,
  required int eventBufferCapacity,
  required MapPerformanceDropPolicy dropPolicy,
  required MapFrameBudget frameBudget,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: 性能観測policyをversion化" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_policy_test.dart
```

Expected: FAIL（Task 23の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_policy.dart test/foundation/performance/map_performance_policy_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_policy_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 23 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_policy.dart packages/eqmonitor_map/test/foundation/performance/map_performance_policy_test.dart
git commit -m "Feat: 性能観測policyをversion化"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 24: count/sum/min/max/percentile aggregateを実装する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_metric_aggregate.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_metric_aggregate_test.dart`

**Interfaces:** `MapMetricAggregate`, `MapPercentileValue`, `MapMetricAccumulator.add({required sample})`, `snapshot({required percentiles})`。

- [ ] values `[1,2,3,4]` のcount=4/sum=10/min=1/max=4/p50=2/p95=4をnearest-rankでtestする。
- [ ] reservoir上限超過でもcount/sum/min/maxは全sample、percentileはbounded deterministic reservoir、`percentileSampleCount`/`percentileDroppedCount`を公開するtestを書く。
- [ ] RED後、sequence modulo capacityによるdeterministic replacementを使いrandomを使わない。

```dart
@immutable
final class MapMetricAggregate {
  final int count;
  final int sum;
  final int min;
  final int max;
  final List<MapPercentileValue> percentiles;
  final int percentileSampleCount;
  final int percentileDroppedCount;
}
```

- [ ] format/test/diff-check後、`git commit -m "Feat: 性能metricを有界集約" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_metric_aggregate_test.dart
```

Expected: FAIL（Task 24の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_metric_aggregate.dart test/foundation/performance/map_metric_aggregate_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_metric_aggregate_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 24 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_metric_aggregate.dart packages/eqmonitor_map/test/foundation/performance/map_metric_aggregate_test.dart
git commit -m "Feat: 性能metricを有界集約"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 25: version/domain検証とobservation levelをcollectorへ実装する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_collector_validation_test.dart`

**Interfaces:** `MapPerformanceRecordResult.accepted/ignored/rejected/aggregated`, `MapPerformanceCollector(policy, windowStartedAt)`, `record({required MapPerformanceEvent event})`。

- [ ] schema version mismatch/clock domain mismatch/monotonic逆行がtyped rejectとなりaggregate/bufferを変更しないtestを書く。
- [ ] `off`はignored、`aggregate`はaggregateのみ、`detailed`はaggregateとevent候補の両方になるtestを書く。
- [ ] RED後、validation→observation level→aggregateの順で実装する。record resultはaccepted/ignored/rejected理由を持つ。

```dart
MapPerformanceRecordResult record({
  required MapPerformanceEvent event,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: 性能sampleのversionとclockを検証" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_collector_validation_test.dart
```

Expected: FAIL（Task 25の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_collector_validation_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_collector_validation_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 25 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_collector_validation_test.dart
git commit -m "Feat: 性能sampleのversionとclockを検証"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 26A: partial/final multiwindow snapshot timelineを実装する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_window_test.dart`

**Interfaces:** `MapPerformanceSnapshot({schemaVersion, clockDomain, windowStartedAt, windowEndedAt, isPartial, metrics, counters})`, `takePartialSnapshot(...)`, `advanceWindows(...)`。

- [ ] `windowStartedAt=t0`、window=10s、snapshot interval=2sの固定timelineを書く。t1/t2に各1 sampleをrecord→t2 `takePartialSnapshot`は`[t0,t2] isPartial=true,count=2`、t3に1 sample→t4 partialはcount=3で、どちらのpartialもaggregateをresetしない。
- [ ] t11 `advanceWindows`はまず`[t0,t10) isPartial=false,count=3`だけを返してcompleted windowをresetする。その後t11に1 sampleをrecordし、t12 partialは`[t10,t12] count=1`。t31 `advanceWindows`は`[t10,t20) count=1`、`[t20,t30) count=0`の2 final snapshotをこの順で返し、active windowを`[t30,t40)`へ進めることをexactにtestする。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_window_test.dart
```

Expected: FAIL（Task 26Aの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_window_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_window_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 26A testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_window_test.dart
git commit -m "Feat: 性能window snapshotを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 26B: aggregate-before-rate-limit bounded deliveryを実装する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_delivery_test.dart`

**Interfaces:** `drainEvents()` と detailed counters。

- [ ] 同kind 2sampleがeventMinInterval内でもaggregate count=2、detailed buffer=1、rateLimited=1になるtestを書く。
- [ ] deterministic frame sampling、dropOldest/dropNewest、capacity、snapshot interval、aggregation window reset、percentileをtestする。
- [ ] RED後、aggregate.addを先に実行し、その後だけdetailed sampling→kind別rate-limit→`ListQueue` drop policyを適用する。

```dart
final sample = event.sample;
final accumulator = accumulators.putIfAbsent(
  sample.kind,
  () => MapMetricAccumulator(
    maxSamples: policy.maxSamplesPerMetricPerWindow,
  ),
);
accumulator.add(sample: sample);
if (policy.level != MapPerformanceObservationLevel.detailed) {
  return MapPerformanceRecordResult.aggregated();
}
return recordDetailedEvent(event: event);
```

- [ ] snapshotはschema/domain/window start/end、全metric aggregate、accepted/ignored/rejected/rateLimited/dropped/buffered countsをdefensive immutableに持つ。
- [ ] format/test/diff-check後、`git commit -m "Feat: 性能eventを集約後に有界配信" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_delivery_test.dart
```

Expected: FAIL（Task 26Bの新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_delivery_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_delivery_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 26B testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_delivery_test.dart
git commit -m "Feat: 性能eventを集約後に有界配信"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 27: FrameTiming変換と必須metric coverageを固定する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_frame_timing_samples.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_frame_timing_samples_test.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_metric_coverage_test.dart`

**Interfaces:** `mapFrameTimingSamples({required FrameTiming timing, required schemaVersion, required clockDomain, required monotonicAt, required MapFrameBudget frameBudget})`。

- [ ] synthetic `FrameTiming` からbuild/rasterと `max(totalSpan - frameBudget, zero)` のframe budget overrunを作り、注入budget差で結果が変わるtestを書く。
- [ ] queue/execution pairs、GPU submit/completion、cache/bytes/tile queue/bucket/labelsの必須metric集合がenumに全て存在するcoverage testを書く。
- [ ] RED後、FrameTimingのtimestamp差をDuration metricへ変換し、wall clockを取得せず、曖昧なvsync overrun名を使わない。

```dart
List<MapPerformanceSample> mapFrameTimingSamples({
  required FrameTiming timing,
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required Duration monotonicAt,
  required MapFrameBudget frameBudget,
});
```

- [ ] format/test/diff-check後、`git commit -m "Feat: FrameTiming性能sampleを追加" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart
```

Expected: FAIL（Task 27の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_frame_timing_samples.dart test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 27 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/src/foundation/performance/map_frame_timing_samples.dart packages/eqmonitor_map/test/foundation/performance/map_frame_timing_samples_test.dart packages/eqmonitor_map/test/foundation/performance/map_performance_metric_coverage_test.dart
git commit -m "Feat: FrameTiming性能sampleを追加"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 28: MapViewportを含む全public constructor compile gateを追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Create: `packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart`

**Interfaces:** `package:eqmonitor_map/eqmonitor_map.dart`だけでfoundation全型を利用可能にする。

- [ ] `src/` importなしで次の全public creator/constructor/comparator/validatorを `<void Function()>` inventoryへ1件ずつ列挙して実行するcompile testを書く。

```text
Task 1: createMapNodeKey / createMapNodeTypeId / createMapNodeIdentity / classifyMapNodeIdentity / MapNodeIdentityChange.values
Task 2: MapNode type annotation / MapDeclarationNode / MapScene
Task 3: MapElement type annotation / MapElement.identity+mount+update+unmount / MapElementFactory.create
Task 4-5: MapChildReconciler / elements / reconcile / unmountAll
Task 6: createMapClockDomainId / MapClockCapture type annotation / MapClock.capture / SystemMapClock.start
Task 7: MapFrameSourceRevisionStamp / MapFrameLayerRevisionStamp / MapFrameRevisionStamp type annotation / MapFrameRevisionScope.values / canonicalizeMapFrameRevisions
Task 8: MapAppLifecycle.values / MapFrameSnapshot type annotation / captureMapFrameSnapshot / MapViewport
Task 9A: MapFullRevision / MapDeltaRevision
Task 9B: MapCommittedRevision / MapFullResyncRequest / MapRevisionRejectReason.values / MapRevisionApplyResult.committed / idempotentNoOp / rejected / requiresFullResync
Task 10: MapRevisionCandidate / MapRevisionStateOwner.own
Task 11-13: MapRevisionCommitStore / current / commitFull / commitDelta / fullResyncRequest / needsFullResync / resyncAfterRevision
Task 14: createMapRenderPhaseId / MapRenderPhaseId.labelForeground / MapRenderPhasePolicy / rankOf
Task 15: MapRenderSortKey / compareMapRenderSortKeys / reverseMapRenderSortKeysForHitTest
Task 16: MapVertexAttributeSemantic.values / MapVertexAttributeFormat.values / MapVertexAttributeLayout / byteLength / scalarAlignment / validateMapVertexAttributeLayout
Task 17: MapPrimitiveTopology.values / MapPackedByteOrder.values / MapIndexFormat.values / MapPackedMeshLayout / haveCompatibleMapPackedMeshLayouts
Task 18: MapPackedMesh
Task 19: createMapRenderPipelineKey / createMapMaterialParameterBlock / haveEqualMapMaterialParameterContent / createMapRenderBatchKey / createMapRenderPacket
Task 20A-20B: MapRenderBatch type annotation / createMapRenderBatch / instanceTransforms / buildCanonicalRenderBatches
Task 21: MapRenderSubmission / MapRenderBatchAdapter.submit
Task 22A: createMapPerformanceSchemaVersion / MapPerformanceSample.duration / count / bytes
Task 22B: MapPerformanceMetricUnit.values / MapPerformanceMetricKind.values / MapPerformanceEvent
Task 23: MapPerformanceObservationLevel.values / MapPerformanceDropPolicy.values / createMapFrameBudget / MapPerformancePolicy
Task 24: MapPercentileValue / MapMetricAggregate / MapMetricAccumulator / add / snapshot
Task 25: MapPerformanceRecordResult.accepted / ignored / rejected / aggregated / MapPerformanceCollector / record
Task 26A-26B: MapPerformanceSnapshot / takePartialSnapshot / advanceWindows / drainEvents
Task 27: mapFrameTimingSamples
```

上記の `/` 区切りをまとめて1 closureにせず、各symbol/memberをコメントではない `final constructors = <void Function()>[() { ... }, ...];` または `final declarations = <void Function()>[() { ... }, ...];` へ必ず1件ずつ展開する。type annotationだけの項目もlocal variable/parameterへ代入してcompileさせ、abstract memberはlocal fake経由で呼ぶ。両inventoryの全closureをloop実行するため、Task 1–27のexport漏れ・constructor/member rename・Task間の生成ownerずれはcompileまたはtest failureになる。

- [ ] local fakeでabstract `MapClock`, `MapRevisionStateOwner`, `MapElementFactory`, `MapRenderBatchAdapter`もpublic signatureからimplement可能にする。
- [ ] REDで `MapViewport` と新foundation exportが不足することを確認する。
- [ ] `eqmonitor_map.dart`へ `src/geo/map_viewport.dart` とTask 1–27（9B/22B/26Bを含む）のpublic filesを明示exportする。
- [ ] `mise exec -- dart run build_runner build --delete-conflicting-outputs`、format、public test、diff-check後、`git commit -m "Feat: 地図foundation公開APIを確定" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/foundation_public_api_test.dart
```

Expected: FAIL（Task 28の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/eqmonitor_map.dart test/foundation/foundation_public_api_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
```

Expected: Task 28 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/lib/eqmonitor_map.dart packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart
git commit -m "Feat: 地図foundation公開APIを確定"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 29: foundation contract知見と後続境界を記録する

**Files:**
- Modify: `packages/eqmonitor_map/README.md`
- Create: `docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`

**Interfaces:** 実装済み範囲、検証command、後続ownerを文書化。

- [ ] READMEへsingle frame capture、generic owned revision、caller phase、packed compatibility、aggregate-before-rate-limitを記録する。
- [ ] knowledgeへKEVi/dashmap pinと採用/不採用、missing phase正本への対処、typed schema/domain reject、#1591/#1593/#1595/#1596境界を記録する。
- [ ] 未実装項目だけをREADME TODOへ残し、device/simulator未実施を明記する。
- [ ] diff-check後、`git commit -m "Docs: 地図foundation運用知見を記録" && git push`。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
rg -n "Foundation contract" ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
```

Expected: FAIL（Task 29の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format --output=none --set-exit-if-changed lib test
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/widget/base_map_view_test.dart
cd ../..
git diff --check
```

Expected: Task 29 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add packages/eqmonitor_map/README.md docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git commit -m "Docs: 地図foundation運用知見を記録"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。

### Task 30: package全体とBaseMap regressionを検証する

**Files:**
- Modify: `docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`

Verificationで欠陥を検出した場合は該当Taskへ戻し、そのTaskのfile/test/commit境界で修正する。このTaskは最終結果と残余device riskだけをknowledgeへ追記する。

**Interfaces:** public compile、ownership/revision/render/performance、import isolation、既存BaseMapを検証。

- [ ] 生成/format:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib test
cd ../..
git diff --check
```

- [ ] focused/public/BaseMap:

```bash
cd packages/eqmonitor_map
mise exec -- flutter test --no-pub test/foundation test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter test --no-pub test/widget/base_map_view_test.dart test/tile/base_map_render_plan_builder_test.dart test/tile/base_map_tile_decoder_test.dart test/geo/tile_matrix_test.dart
```

- [ ] isolation（両package名）:

```bash
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
```

- [ ] full package:

```bash
cd packages/eqmonitor_map
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub
cd ../..
git diff --check
git status --short
git --no-pager diff --stat origin/fix/eqmonitor-map-base-layer-residuals...HEAD
```

Expected: analyze clean、全test PASS、app file差分なし。既知のapp全体2,852 warningをpackage gateへ混ぜない。

- [ ] verification修正がある場合だけ約30〜100行のlogical commitへ分割し、各commitを `Test: 地図foundation検証を確定` 形式でpushする。最後にworktree clean、local/remote一致を確認する。

**Round-2 required self-contained gate:**

- [ ] RED:

```bash
cd packages/eqmonitor_map
rg -n "Final automated verification" ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
```

Expected: FAIL（Task 30の新規型・assert・verification markerが未実装）。

- [ ] GREEN/regression/format/analyze/diff:

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format --output=none --set-exit-if-changed lib test
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/widget/base_map_view_test.dart
cd ../..
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
git diff --check
```

Expected: Task 30 testと既存library regressionがPASS、format/analyze/diffがclean。

- [ ] exact add/commit/push:

```bash
git add docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git commit -m "Test: 地図foundation検証を確定"
git push
```

Expected: 30–100 handwritten lines目安の1 logical commitがoriginへpush済み。
