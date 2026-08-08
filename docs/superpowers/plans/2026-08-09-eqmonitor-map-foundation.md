# EQMonitor Map Foundation Implementation Plan

> **For agentic workers:** implement one Task at a time with `superpowers:subagent-driven-development`. Do not start the next Task until the current Task has one pushed commit.

**Goal:** Issue #1590 として、Flutter Sceneや具体的な地物payloadから独立した宣言scene、frame snapshot、atomic revision、canonical render order、versioned packed render contract、bounded performance observationを公開する。

**Architecture:** foundationはimmutable declaration tree、1 frame 1 clock capture、source-instance付きatomic revision、caller-supplied phase policy、versioned packed packet/batch、aggregate-first performance collectorを所有する。Flutter Scene依存はadapter境界の外へ出さない。

**References:** KEVi `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f` のsnapshot/phase-local order/reverse hit-test/bounded metricsと、dashmap `a6ff92edd999e922f81d26d209d8f589faee3fd0` のtyped-data CPU job/tile batch/bounded workを採用する。Miller projection、global declaration order、mutable setter layer、domainによる直接Scene所有は採用しない。

**Path convention:** 各Taskの`Files`は`packages/eqmonitor_map/`からの相対path。`../../docs/...`だけrepository rootの`docs/...`を指す。

## Invariants

- Scopeは#1590のみ。#1591 PMTiles I/O、#1593 Scene/GPU lifecycle、#1595 seismic payload、#1596 app/Home integrationを先取りしない。
- `labelForeground`以外のphaseを推測せず、positive version付きcaller policyを正本にする。
- runtime foundation型はWidget、GeoJSON、Style JSON、network client、Flutter Scene/scene型を保持しない。
- 手書き`operator ==(Object)`/`hashCode`は禁止。単一値はvalidated extension type、複合valueはprivate Freezed factory、typed bytes/layoutはnamed comparatorを使う。
- list/typed-data/generic stateは入力aliasからdeep-ownする。`dynamic`/`Object`（許可済みMap以外）、`!`、`print()`、class内private methodを追加しない。
- full/deltaはcandidate digest検証とdeep ownership成功後だけsingle assignmentする。active Aへのwrong-source B deltaはA current/latchを変更しない。
- sortはphase→phase内宣言順→source→overscaled tile→feature。compatibleな連続packetだけをbatch化し、packet別transform tableを保持する。
- performanceはschema/domainを集約前に検証し、aggregateへ全sampleを入れた後だけdetailed sampling/rate-limit/dropを行う。
- device/simulator/golden/E2Eは実施しない。pure test、package analyze、public compile、import isolation、BaseMap regressionを必須gateにする。
- 各Taskのsequenceは唯一で、tests作成→RED→implementation→必要時build_runner→format/analyze→GREEN→root diff-check→exact add→1 commit→pushの順を変えない。

---

### Task 1: node key/type primitives

**Files:** Create `lib/src/foundation/map_node_identity.dart`; Create `test/foundation/map_node_key_test.dart`。

**Contract:** `createMapNodeKey({required value})`、`createMapNodeTypeId({required value})`。trim済み非空のvalidated extension typeとし、同値equality/hash・型混同不可を固定する。

**Sequence (one commit):**

1. testを作成し、次を実行する。Expected RED: creator未定義でFAIL。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_node_key_test.dart
```
2. primitivesだけを実装し、次を実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_node_identity.dart test/foundation/map_node_key_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_node_key_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_node_identity.dart packages/eqmonitor_map/test/foundation/map_node_key_test.dart
git commit -m "Feat: 地図node keyを追加"
git push
```
Expected GREEN: focused/library PASS、format/analyze/diff clean。

### Task 2: node identity model/classifier

**Files:** Modify `lib/src/foundation/map_node_identity.dart`; Create `test/foundation/map_node_identity_test.dart`。

**Contract:** private Freezed factoryを持つ`createMapNodeIdentity({required key, required type})`、`MapNodeIdentityChange`、`classifyMapNodeIdentity(...)`。同key+typeだけretainする。

**Sequence (one commit):**

1. testを作成し、次を実行する。Expected RED: identity creator未定義でFAIL。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_node_identity_test.dart
```
2. model/classifierを実装し、次を実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_node_identity.dart test/foundation/map_node_identity_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_node_key_test.dart test/foundation/map_node_identity_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_node_identity.dart packages/eqmonitor_map/lib/src/foundation/map_node_identity.freezed.dart packages/eqmonitor_map/test/foundation/map_node_identity_test.dart
git commit -m "Feat: 地図node identityを追加"
git push
```
Expected GREEN: keyとidentityの全focused regression PASS、format/analyze/diff clean。

### Task 3: immutable declaration tree

**Files:** Create `lib/src/foundation/map_node.dart`; Create `lib/src/foundation/map_scene.dart`; Create `test/foundation/map_node_ownership_test.dart`。

**Contract:** sealed `MapNode`、`MapDeclarationNode`、`MapScene`。全childrenをdefensive copyし、nested childもimmutable nodeだけに限定する。

**Sequence (one commit):**

1. outer/inner list alias mutationとunmodifiable getterのtestを作りREDを実行する。Expected RED:型未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_node_ownership_test.dart
```
2. declaration treeを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_node.dart lib/src/foundation/map_scene.dart test/foundation/map_node_ownership_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_node_ownership_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_node.dart packages/eqmonitor_map/lib/src/foundation/map_scene.dart packages/eqmonitor_map/test/foundation/map_node_ownership_test.dart
git commit -m "Feat: immutable地図scene treeを追加"
git push
```
Expected GREEN: ownership/library PASS、format/analyze/diff clean。

### Task 4: element lifecycle contract

**Files:** Create `lib/src/foundation/map_element.dart`; Create `test/foundation/map_element_lifecycle_test.dart`。

**Contract:** `MapElement.identity/mount/update/unmount`、`MapElementFactory.create({required node})`。test fakeでlifecycle callを記録する。

**Sequence (one commit):**

1. lifecycle fake testを作りREDを実行する。Expected RED: interface未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_element_lifecycle_test.dart
```
2. interfaceだけ実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_element.dart test/foundation/map_element_lifecycle_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_element_lifecycle_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_element.dart packages/eqmonitor_map/test/foundation/map_element_lifecycle_test.dart
git commit -m "Feat: 地図element lifecycleを追加"
git push
```
Expected GREEN: focused/library PASS、format/analyze/diff clean。

### Task 5: retain/reorder reconciler

**Files:** Create `lib/src/foundation/map_child_reconciler.dart`; Create `test/foundation/map_child_reconciler_retain_test.dart`。

**Contract:** `MapChildReconciler.elements`、`reconcile({required nodes, required factory})`。same identityをretainし宣言順へreorderし、node deep equalityを呼ばない。

**Sequence (one commit):**

1. retain/reorder failing testを作りREDを実行する。Expected RED: reconciler未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_child_reconciler_retain_test.dart
```
2. retain pathを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_child_reconciler.dart test/foundation/map_child_reconciler_retain_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_child_reconciler_retain_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart packages/eqmonitor_map/test/foundation/map_child_reconciler_retain_test.dart
git commit -m "Feat: 同一node elementをretain"
git push
```
Expected GREEN: retain/library PASS、format/analyze/diff clean。

### Task 6: atomic replace/unmount reconciler

**Files:** Modify `lib/src/foundation/map_child_reconciler.dart`; Create `test/foundation/map_child_reconciler_replace_test.dart`。

**Contract:** same key/different typeはunmount old→mount new、removedは旧逆順、`unmountAll`二回目はno-op。duplicate next keyはlifecycleを一件も呼ばずrejectする。

**Sequence (one commit):**

1. replace/remove/duplicate testを作りREDを実行する。Expected RED: behavior不足でFAIL。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/map_child_reconciler_replace_test.dart
```
2. candidate orderを先に検証してsingle swapし、全reconciler regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_child_reconciler.dart test/foundation/map_child_reconciler_replace_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/map_child_reconciler_retain_test.dart test/foundation/map_child_reconciler_replace_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_child_reconciler.dart packages/eqmonitor_map/test/foundation/map_child_reconciler_replace_test.dart
git commit -m "Feat: element置換をatomicに適用"
git push
```
Expected GREEN: retain/replace/library PASS、format/analyze/diff clean。

### Task 7: typed monotonic clock

**Files:** Create `lib/src/foundation/frame/map_clock.dart`; Create `test/foundation/frame/map_clock_test.dart`。

**Contract:** `createMapClockDomainId`、`createMapClockCapture`、`MapClock.capture()`、`SystemMapClock.start({required domain})`。captureだけがUTC wall timeと同一Stopwatch elapsedを取得する。

**Sequence (one commit):**

1. invalid domain/local DateTime/negative monotonic/single-stopwatch testを作りREDを実行する。Expected RED:型未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_clock_test.dart
```
2. validated extension typeとprivate capture constructorを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/frame/map_clock.dart test/foundation/frame/map_clock_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_clock_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame/map_clock.dart packages/eqmonitor_map/test/foundation/frame/map_clock_test.dart
git commit -m "Feat: typed frame clockを追加"
git push
```
Expected GREEN: clock/library PASS、format/analyze/diff clean。

### Task 8: source instance/content digest primitives

**Files:** Create `lib/src/foundation/revision/map_source_identity.dart`; Create `test/foundation/revision/map_source_identity_test.dart`。

**Contract:** `createMapSourceInstanceId`、`createMapContentDigest`。trim済み非空の別extension typeとし、same textでも型混同不可。

**Sequence (one commit):**

1. validation/equality/type separation testを作りREDを実行する。Expected RED: creators未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_source_identity_test.dart
```
2. primitivesを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_source_identity.dart test/foundation/revision/map_source_identity_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_source_identity_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_source_identity.dart packages/eqmonitor_map/test/foundation/revision/map_source_identity_test.dart
git commit -m "Feat: 地図source identityを追加"
git push
```
Expected GREEN: source/library PASS、format/analyze/diff clean。

### Task 9: frame revision stamp model

**Files:** Create `lib/src/foundation/frame/map_frame_revision.dart`; Create `test/foundation/frame/map_frame_revision_model_test.dart`。

**Contract:** `createMapFrameSourceRevisionStamp(sourceInstanceId,revision,contentDigest)`、`createMapFrameLayerRevisionStamp(sourceInstanceId,ownerKey,revision)`、sealed Freezed `MapFrameRevisionStamp`、`MapFrameRevisionScope`。

**Sequence (one commit):**

1. required source/digest、negative revision、alias-safe value testを作りREDを実行する。Expected RED: model未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_frame_revision_model_test.dart
```
2. private Freezed factoriesとvalidated creatorsを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_frame_revision.dart test/foundation/frame/map_frame_revision_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_frame_revision_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.dart packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.freezed.dart packages/eqmonitor_map/test/foundation/frame/map_frame_revision_model_test.dart
git commit -m "Feat: frame revision stampを追加"
git push
```
Expected GREEN: model/library PASS、format/analyze/diff clean。

### Task 10: frame revision canonicalizer

**Files:** Modify `lib/src/foundation/frame/map_frame_revision.dart`; Create `test/foundation/frame/map_frame_revision_canonicalizer_test.dart`。

**Contract:** `canonicalizeMapFrameRevisions`はscope(source→layer)→sourceInstanceId→ownerKeyでsortし、同identity重複をrejectしてowned listを返す。

**Sequence (one commit):**

1. ordering/duplicate/input alias testを作りREDを実行する。Expected RED: canonicalizer未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_frame_revision_canonicalizer_test.dart
```
2. pure canonicalizerを実装し全frame-revision regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/frame/map_frame_revision.dart test/foundation/frame/map_frame_revision_canonicalizer_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_frame_revision_model_test.dart test/foundation/frame/map_frame_revision_canonicalizer_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_revision.dart packages/eqmonitor_map/test/foundation/frame/map_frame_revision_canonicalizer_test.dart
git commit -m "Feat: frame revisionをcanonical化"
git push
```
Expected GREEN: model/canonicalizer/library PASS、format/analyze/diff clean。

### Task 11: single-capture frame snapshot

**Files:** Create `lib/src/foundation/frame/map_frame_snapshot.dart`; Create `test/foundation/frame/map_frame_snapshot_test.dart`。

**Contract:** `MapAppLifecycle`、`MapFrameSnapshot`、`captureMapFrameSnapshot(...)`。clockを1回だけcaptureし、camera/viewport/canonical revisions/contextをdeep-ownする。

**Sequence (one commit):**

1. counting clock、negative frame/context、alias mutation testを作りREDを実行する。Expected RED: capture未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/frame/map_frame_snapshot_test.dart
```
2. public raw constructorなしでcapture関数を実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/frame/map_frame_snapshot.dart test/foundation/frame/map_frame_snapshot_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/frame/map_frame_snapshot_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame/map_frame_snapshot.dart packages/eqmonitor_map/test/foundation/frame/map_frame_snapshot_test.dart
git commit -m "Feat: frame snapshotを一回の時刻取得で固定"
git push
```
Expected GREEN: snapshot/library PASS、format/analyze/diff clean。

### Task 12: revision metadata creators

**Files:** Create `lib/src/foundation/revision/map_revision.dart`; Create `test/foundation/revision/map_revision_metadata_test.dart`。

**Contract:** `createMapFullRevision(source,revision,digest)`、`createMapDeltaRevision(source,baseRevision,targetRevision,targetDigest)`。negative revision、target<=baseをrejectする。

**Sequence (one commit):**

1. metadata validation testを作りREDを実行する。Expected RED: creators未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_metadata_test.dart
```
2. private Freezed factoriesとcreatorsを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_metadata_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_metadata_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart packages/eqmonitor_map/lib/src/foundation/revision/map_revision.freezed.dart packages/eqmonitor_map/test/foundation/revision/map_revision_metadata_test.dart
git commit -m "Feat: revision metadataを型定義"
git push
```
Expected GREEN: metadata/library PASS、format/analyze/diff clean。

### Task 13: committed/result/resync models

**Files:** Modify `lib/src/foundation/revision/map_revision.dart`; Create `test/foundation/revision/map_revision_result_model_test.dart`。

**Contract:** `createMapCommittedRevision<TState>`、`createMapFullResyncRequest`、`MapRevisionRejectReason`、sealed `MapRevisionApplyResult<TState>`のdata modelだけを追加する。

**Sequence (one commit):**

1. model shapeとrequired fieldsのcompile/value testを作りREDを実行する。Expected RED: models未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_result_model_test.dart
```
2. private Freezed factoriesでmodelsを実装し、metadata regressionも実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_result_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_metadata_test.dart test/foundation/revision/map_revision_result_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart packages/eqmonitor_map/lib/src/foundation/revision/map_revision.freezed.dart packages/eqmonitor_map/test/foundation/revision/map_revision_result_model_test.dart
git commit -m "Feat: revision結果modelを追加"
git push
```
Expected GREEN: metadata/model/library PASS、format/analyze/diff clean。

### Task 14: revision result factories/invariants

**Files:** Modify `lib/src/foundation/revision/map_revision.dart`; Create `test/foundation/revision/map_revision_result_factory_test.dart`。

**Contract:** exact factories `committed/idempotentNoOp/rejected`とderived `requiresFullResync`。committed+reason、rejected+null reason等の不可能状態を生成不能にする。

**Sequence (one commit):**

1. 全variant/current/reason/request invariant testを作りREDを実行する。Expected RED: factories未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_result_factory_test.dart
```
2. factories/getterを実装し、同fileの全既存focused testを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_result_factory_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_metadata_test.dart test/foundation/revision/map_revision_result_model_test.dart test/foundation/revision/map_revision_result_factory_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart packages/eqmonitor_map/lib/src/foundation/revision/map_revision.freezed.dart packages/eqmonitor_map/test/foundation/revision/map_revision_result_factory_test.dart
git commit -m "Feat: revision結果factoryを検証"
git push
```
Expected GREEN: revision model/factory/library PASS、format/analyze/diff clean。

### Task 15: revision state ownership boundary

**Files:** Create `lib/src/foundation/revision/map_revision_state_owner.dart`; Create `test/foundation/revision/map_revision_state_owner_test.dart`。

**Contract:** `MapRevisionCandidate<TState>(state,digest)`、`MapRevisionStateOwner<TState>.own({required candidate})`。outer map/inner list双方をdeep-ownするfakeで契約を固定する。

**Sequence (one commit):**

1. mutable nested alias testを作りREDを実行する。Expected RED: owner contract未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_state_owner_test.dart
```
2. generic boundaryだけを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_state_owner.dart test/foundation/revision/map_revision_state_owner_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_state_owner_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_state_owner.dart packages/eqmonitor_map/test/foundation/revision/map_revision_state_owner_test.dart
git commit -m "Feat: revision state ownership境界を追加"
git push
```
Expected GREEN: ownership/library PASS、format/analyze/diff clean。

### Task 16: full revision atomic commit

**Files:** Create `lib/src/foundation/revision/map_revision_commit_store.dart`; Create `test/foundation/revision/map_revision_full_commit_test.dart`。

**Contract:** `MapRevisionCommitStore(owner)`、`current`、`commitFull(metadata,validateAndBuild)`。builder→candidate digest→revision→owner→single assignment順を固定する。

**Sequence (one commit):**

1. first/newer/stale/equal same/equal conflict/digest mismatch/builder throw/owner throw/alias testを作りREDを実行する。Expected RED: store未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_full_commit_test.dart
```
2. full pathだけ実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_full_commit_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_full_commit_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_full_commit_test.dart
git commit -m "Feat: full revisionをdigest検証後commit"
git push
```
Expected GREEN: full/library PASS、format/analyze/diff clean。

### Task 17: exact-base delta atomic commit

**Files:** Modify `lib/src/foundation/revision/map_revision_commit_store.dart`; Create `test/foundation/revision/map_revision_delta_commit_test.dart`。

**Contract:** `commitDelta`はsame source/exact base/target digestを検証し、returned candidateだけをowner経由でcommitする。

**Sequence (one commit):**

1. 4→5 success、wrong digest、stale、builder/owner throw、nested alias testを作りREDを実行する。Expected RED: delta path未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_delta_commit_test.dart
```
2. delta pathを実装しstore全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_delta_commit_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_full_commit_test.dart test/foundation/revision/map_revision_delta_commit_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_delta_commit_test.dart
git commit -m "Feat: exact revision deltaをatomic適用"
git push
```
Expected GREEN: full/delta/library PASS、format/analyze/diff clean。

### Task 18: resync latch and wrong-source isolation

**Files:** Modify `lib/src/foundation/revision/map_revision_commit_store.dart`; Create `test/foundation/revision/map_revision_resync_test.dart`。

**Contract:** no-current/gap/branchはgetterと同一requestをlatchする。active AへのB deltaはbuilder未実行でA current/latch不変、既存A requestまたはnullを返す。

**Sequence (one commit):**

1. no-current、A4 gap latch、B wrong-source no-latch/latch、failed/equal full保持、A6 newer full解除→A6→7 delta fixtureを作りREDを実行する。Expected RED: latch behavior不足。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/revision/map_revision_resync_test.dart
```
2. latchを実装しstore全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_resync_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/revision/map_revision_full_commit_test.dart test/foundation/revision/map_revision_delta_commit_test.dart test/foundation/revision/map_revision_resync_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision/map_revision_resync_test.dart
git commit -m "Feat: delta gapをfull resyncへlatch"
git push
```
Expected GREEN: full/delta/resync/library PASS、format/analyze/diff clean。

### Task 19: render phase model

**Files:** Create `lib/src/foundation/render/map_render_phase.dart`; Create `test/foundation/render/map_render_phase_model_test.dart`。

**Contract:** `createMapRenderPhaseId`、唯一の固定ID `MapRenderPhaseId.labelForeground`、raw public constructorなしの`MapRenderPhasePolicy` model。

**Sequence (one commit):**

1. phase ID validation/valueとpolicy type annotation testを作りREDを実行する。Expected RED: model未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_phase_model_test.dart
```
2. extension typeとprivate policy modelを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_phase.dart test/foundation/render/map_render_phase_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_phase_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_phase.dart packages/eqmonitor_map/test/foundation/render/map_render_phase_model_test.dart
git commit -m "Feat: 描画phase modelを追加"
git push
```
Expected GREEN: phase model/library PASS、format/analyze/diff clean。

### Task 20: phase policy validator

**Files:** Modify `lib/src/foundation/render/map_render_phase.dart`; Create `test/foundation/render/map_render_phase_policy_test.dart`。

**Contract:** `createMapRenderPhasePolicy(version,orderedPhases)`と`rankOf`。version<=0、empty/duplicate、labelForeground欠落、unknown lookupをrejectする。

**Sequence (one commit):**

1. validation/caller order/alias testを作りREDを実行する。Expected RED: creator/rank未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_phase_policy_test.dart
```
2. validator/rank mapを実装しphase全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_phase.dart test/foundation/render/map_render_phase_policy_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_phase_model_test.dart test/foundation/render/map_render_phase_policy_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_phase.dart packages/eqmonitor_map/test/foundation/render/map_render_phase_policy_test.dart
git commit -m "Feat: version付き描画phase順を追加"
git push
```
Expected GREEN: phase model/policy/library PASS、format/analyze/diff clean。

### Task 21: canonical render sort key

**Files:** Create `lib/src/foundation/render/map_render_sort_key.dart`; Create `test/foundation/render/map_render_sort_key_test.dart`。

**Contract:** `MapRenderSortKey(phasePolicyVersion,phase,declarationOrderWithinPhase,sourceOrder,overscaledTileOrder,featureOrder)`、`compareMapRenderSortKeys`、`reverseMapRenderSortKeysForHitTest`。

**Sequence (one commit):**

1. exact precedence、negative fields、phase interleave禁止、reverse fixtureを作りREDを実行する。Expected RED: sort API未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_sort_key_test.dart
```
2. pure comparator/reverse helperを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_sort_key.dart test/foundation/render/map_render_sort_key_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_sort_key_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_sort_key.dart packages/eqmonitor_map/test/foundation/render/map_render_sort_key_test.dart
git commit -m "Feat: 描画順をcanonical key化"
git push
```
Expected GREEN: sort/library PASS、format/analyze/diff clean。

### Task 22: vertex attribute catalog

**Files:** Create `lib/src/foundation/render/map_vertex_attribute.dart`; Create `test/foundation/render/map_vertex_attribute_test.dart`。

**Contract:** semantics=`position2D/position3D/normal3D/colorRgba8/texCoord2D/lineExtrude2D/featureIdUint32`、formats=`float32x2/x3/x4/uint8x4Normalized/uint16x2/uint32`、`byteLength/scalarAlignment`、attribute layout。

**Sequence (one commit):**

1. exact enum set、size/alignment、negative offset testを作りREDを実行する。Expected RED: catalog未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_vertex_attribute_test.dart
```
2. exhaustive catalog/layout creatorを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_vertex_attribute.dart test/foundation/render/map_vertex_attribute_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_vertex_attribute_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_vertex_attribute.dart packages/eqmonitor_map/test/foundation/render/map_vertex_attribute_test.dart
git commit -m "Feat: packed頂点attribute形式を追加"
git push
```
Expected GREEN: attribute/library PASS、format/analyze/diff clean。

### Task 23: packed layout model/catalog

**Files:** Create `lib/src/foundation/render/map_packed_mesh_layout.dart`; Create `test/foundation/render/map_packed_mesh_layout_model_test.dart`。

**Contract:** topology=`points/lineList/lineStrip/triangleList/triangleStrip`、byte order=`little/big`、index=`uint16/uint32`、raw public constructorなしの`MapPackedMeshLayout`。

**Sequence (one commit):**

1. exact enum setとrequired model fields compile testを作りREDを実行する。Expected RED: model未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_packed_mesh_layout_model_test.dart
```
2. enum/model skeletonを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_packed_mesh_layout.dart test/foundation/render/map_packed_mesh_layout_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_packed_mesh_layout_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh_layout.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_layout_model_test.dart
git commit -m "Feat: packed layout modelを追加"
git push
```
Expected GREEN: layout model/library PASS、format/analyze/diff clean。

### Task 24: packed layout validator/comparator

**Files:** Modify `lib/src/foundation/render/map_packed_mesh_layout.dart`; Create `test/foundation/render/map_packed_mesh_layout_validation_test.dart`。

**Contract:** `createMapPackedMeshLayout`と`haveCompatibleMapPackedMeshLayouts`。positive version/stride、nonempty unique semantic、strict offset order、scalar alignment、range nonoverlap/bounds、stride max alignment、index widthを検証する。

**Sequence (one commit):**

1. 全invalid axis、defensive attributes、all-field comparator testを作りREDを実行する。Expected RED: validator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_packed_mesh_layout_validation_test.dart
```
2. validated creator/named comparatorを実装しlayout全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_packed_mesh_layout.dart test/foundation/render/map_packed_mesh_layout_validation_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_packed_mesh_layout_model_test.dart test/foundation/render/map_packed_mesh_layout_validation_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh_layout.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_layout_validation_test.dart
git commit -m "Feat: packed layoutを厳密検証"
git push
```
Expected GREEN: layout model/validation/library PASS、format/analyze/diff clean。

### Task 25: immutable packed mesh

**Files:** Create `lib/src/foundation/render/map_packed_mesh.dart`; Create `test/foundation/render/map_packed_mesh_test.dart`。

**Contract:** `createMapPackedMesh(payloadVersion,layout,vertexBytes,vertexCount,indexBytes,indexCount)`。index format iff bytes/count、byte length divisibility、deep ownershipを検証する。

**Sequence (one commit):**

1. invalid iff/length/countとvertex/index alias mutation testを作りREDを実行する。Expected RED: creator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_packed_mesh_test.dart
```
2. validated private constructorとtyped-data copyを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_packed_mesh.dart test/foundation/render/map_packed_mesh_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_packed_mesh_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_test.dart
git commit -m "Feat: immutable packed meshを追加"
git push
```
Expected GREEN: mesh/library PASS、format/analyze/diff clean。

### Task 26: render key/material models

**Files:** Create `lib/src/foundation/render/map_render_packet.dart`; Create `test/foundation/render/map_render_value_model_test.dart`。

**Contract:** private Freezed-backed `createMapRenderPipelineKey`、`createMapRenderBatchKey(version,nodeKey,scopeKey,materialKey,phasePolicyVersion,phase)`とprivate-constructor `MapMaterialParameterBlock` model。

**Sequence (one commit):**

1. positive versions/nonempty keys/phase-policy fields/value semantics compile testを作りREDを実行する。Expected RED: models未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_value_model_test.dart
```
2. models/creatorsを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_packet.dart test/foundation/render/map_render_value_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_value_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.dart packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.freezed.dart packages/eqmonitor_map/test/foundation/render/map_render_value_model_test.dart
git commit -m "Feat: render key modelを追加"
git push
```
Expected GREEN: render value model/library PASS、format/analyze/diff clean。

### Task 27: material content comparator

**Files:** Modify `lib/src/foundation/render/map_render_packet.dart`; Create `test/foundation/render/map_material_parameter_test.dart`。

**Contract:** `createMapMaterialParameterBlock(version,bytes)`と`haveEqualMapMaterialParameterContent(left,right)`。bytesをdeep-ownし、versionとbyte contentを比較する。identityやrecordの暗黙`==`へ依存しない。

**Sequence (one commit):**

1. nonpositive version、alias mutation、equal/different bytes/version testを作りREDを実行する。Expected RED: creator/comparator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_material_parameter_test.dart
```
2. validated creator/named comparatorを実装し同fileの既存model regressionも実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_packet.dart test/foundation/render/map_material_parameter_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_value_model_test.dart test/foundation/render/map_material_parameter_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.dart packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.freezed.dart packages/eqmonitor_map/test/foundation/render/map_material_parameter_test.dart
git commit -m "Feat: material parameterをcontent比較"
git push
```
Expected GREEN: render model/material/library PASS、format/analyze/diff clean。

### Task 28: render packet creator

**Files:** Modify `lib/src/foundation/render/map_render_packet.dart`; Create `test/foundation/render/map_render_packet_test.dart`。

**Contract:** `createMapRenderPacket(contractVersion,sortKey,batchKey,pipeline,mesh,modelTransform,materialParameters)`。16 finite Float64 transform、positive version、sort/batch phaseとpolicy version一致を検証する。

**Sequence (one commit):**

1. transform length/NaN/infinity/alias、phase/policy mismatch testを作りREDを実行する。Expected RED: packet creator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_packet_test.dart
```
2. private packet constructorとdefensive transform copyを実装し同fileの全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/render/map_render_packet.dart test/foundation/render/map_render_packet_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_value_model_test.dart test/foundation/render/map_material_parameter_test.dart test/foundation/render/map_render_packet_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.dart packages/eqmonitor_map/lib/src/foundation/render/map_render_packet.freezed.dart packages/eqmonitor_map/test/foundation/render/map_render_packet_test.dart
git commit -m "Feat: version付きrender packetを追加"
git push
```
Expected GREEN: render value/material/packet/library PASS、format/analyze/diff clean。

### Task 29: render batch/compatibility models

**Files:** Create `lib/src/foundation/render/map_render_batch.dart`; Create `test/foundation/render/map_render_batch_model_test.dart`。

**Contract:** public immutable `MapRenderBatchCompatibility`、`mapRenderBatchCompatibilityOf({required packet})`、type-annotatable `MapRenderBatch`、raw public batch constructorなし。compatibility fieldsはcontract/payload/batch key/phase/policy/layout/pipeline/material。

**Sequence (one commit):**

1. 全field compile、packet/transform 1:1 model shape、public compatibility type testを作りREDを実行する。Expected RED: models未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_batch_model_test.dart
```
2. private constructorsとimmutable gettersだけ実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_batch_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_model_test.dart
git commit -m "Feat: render batch modelを追加"
git push
```
Expected GREEN: batch model/library PASS、format/analyze/diff clean。

### Task 30: validated render batch factory

**Files:** Modify `lib/src/foundation/render/map_render_batch.dart`; Create `test/foundation/render/map_render_batch_factory_test.dart`。

**Contract:** `createMapRenderBatch(version,policy,packets)`はnonempty、canonical order、unique sort key、全packet compatibilityを検証する。transformだけcompatibilityから除外する。

**Sequence (one commit):**

1. empty/noncanonical/duplicate/nonpositive versionに加え、contract version、mesh payload version、batch key phase/policy、layout、pipeline version/key、material version/content bytesの各single mismatch reject testをparameterizedで作りREDを実行する。Expected RED: factory未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_batch_factory_test.dart
```
2. `haveCompatibleMapPackedMeshLayouts`と`haveEqualMapMaterialParameterContent`を使うfactoryを実装しbatch既存regressionも実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_factory_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_batch_model_test.dart test/foundation/render/map_render_batch_factory_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_factory_test.dart
git commit -m "Feat: 描画batch互換条件を検証"
git push
```
Expected GREEN: batch model/factory/library PASS、format/analyze/diff clean。

### Task 31: exact multi-transform grouping

**Files:** Modify `lib/src/foundation/render/map_render_batch.dart`; Create `test/foundation/render/map_render_batch_builder_test.dart`。

**Contract:** `buildCanonicalRenderBatches(version,policy,packets)`はstable sort後のcompatibleな連続packetだけをfactoryへ渡す。packet別`instanceTransforms`は1:1同順immutable。

**Sequence (one commit):**

1. canonical A/A→1、sort後もA/B/A→3、transformだけ異なるA/A→1、phase/policy key mismatch reject fixtureを作りREDを実行する。Expected RED: builder未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/render/map_render_batch_builder_test.dart
```
2. canonical groupingを実装しbatch全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_builder_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/render/map_render_batch_model_test.dart test/foundation/render/map_render_batch_factory_test.dart test/foundation/render/map_render_batch_builder_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_builder_test.dart
git commit -m "Feat: 描画packetをcanonical batch化"
git push
```
Expected GREEN: batch model/factory/builder/library PASS、format/analyze/diff clean。

### Task 32: render submission/adapter model

**Files:** Create `lib/src/renderer/map_render_batch_adapter.dart`; Create `test/renderer/map_render_submission_model_test.dart`。

**Contract:** `createMapRenderSubmission(frame,batches)`、`MapRenderBatchAdapter.submit({required submission})`。submissionはframeとbatchesをdeep-ownし、Scene型を含まない。

**Sequence (one commit):**

1. model ownershipとlocal adapter fake compile testを作りREDを実行する。Expected RED: submission/adapter未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/renderer/map_render_submission_model_test.dart
```
2. production model/interfaceだけ実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/renderer/map_render_batch_adapter.dart test/renderer/map_render_submission_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/renderer/map_render_submission_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer/map_render_submission_model_test.dart
git commit -m "Feat: render submission境界を追加"
git push
```
Expected GREEN: submission/library PASS、format/analyze/diff clean。

### Task 33: public submission validator/recording contract

**Files:** Modify `lib/src/renderer/map_render_batch_adapter.dart`; Create `test/renderer/support/recording_map_render_batch_adapter.dart`; Create `test/renderer/map_render_batch_adapter_contract_test.dart`。

**Contract:** public `validateMapRenderSubmission({required submission})`はbatch version/phase/policy/order不整合をrejectする。recording fakeはtest supportだけに置き、render object count=batch countを固定する。

**Sequence (one commit):**

1. contract testとsupport fakeを作り、support file自体ではなく次のtest fileだけを実行する。Expected RED: validator/behavior未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/renderer/map_render_batch_adapter_contract_test.dart
```
2. validatorを実装し、production test filesだけをGREEN実行する。support fileを直接command引数にしない。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/renderer/map_render_batch_adapter.dart test/renderer/support/recording_map_render_batch_adapter.dart test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/renderer/map_render_submission_model_test.dart test/renderer/map_render_batch_adapter_contract_test.dart test/eqmonitor_map_library_test.dart
cd ../..
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
git diff --check
git add packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer/support/recording_map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer/map_render_batch_adapter_contract_test.dart
git commit -m "Feat: Scene非依存描画adapter契約を追加"
git push
```
Expected GREEN: submission/adapter/library PASS、isolation/format/analyze/diff clean。

### Task 34: performance schema/unit primitives

**Files:** Create `lib/src/foundation/performance/map_performance_metric.dart`; Create `test/foundation/performance/map_performance_schema_test.dart`。

**Contract:** `createMapPerformanceSchemaVersion` validated extension typeと`MapPerformanceMetricUnit.duration/count/bytes`。

**Sequence (one commit):**

1. positive schema version、value equality/hash、exact unit enum testを作りREDを実行する。Expected RED: schema/unit未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_schema_test.dart
```
2. primitivesを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_metric.dart test/foundation/performance/map_performance_schema_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_schema_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart packages/eqmonitor_map/test/foundation/performance/map_performance_schema_test.dart
git commit -m "Feat: 性能schemaとunitを追加"
git push
```
Expected GREEN: schema/library PASS、format/analyze/diff clean。

### Task 35A: duration performance metric catalog

**Files:** Modify `lib/src/foundation/performance/map_performance_metric.dart`; Create `test/foundation/performance/map_performance_catalog_test.dart`。

**Contract:** `MapPerformanceMetricKind`と`mapPerformanceMetricUnitOf(kind)`のduration subset。exact names: `frameReconciliation/tileCover/labelPlacement/renderSubmission/tileRequestQueueWait/tileRequestExecution/decodeQueueWait/decodeExecution/meshBuildQueueWait/meshBuildExecution/gpuUploadQueueWait/gpuUploadExecution/gpuSubmission/gpuCompletion/flutterBuild/flutterRaster/flutterFrameBudgetOverrun/instrumentationOverhead`。

**Sequence (one commit):**

1. exact duration enum setとexhaustive duration unit mapping testを作りREDを実行する。Expected RED: catalog未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_catalog_test.dart
```
2. catalog/switchを実装しschema regressionも実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_metric.dart test/foundation/performance/map_performance_catalog_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_schema_test.dart test/foundation/performance/map_performance_catalog_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart packages/eqmonitor_map/test/foundation/performance/map_performance_catalog_test.dart
git commit -m "Feat: duration性能metricを固定"
git push
```
Expected GREEN: schema/duration catalog/library PASS、format/analyze/diff clean。

### Task 35B: count/bytes performance metric catalog

**Files:** Modify `lib/src/foundation/performance/map_performance_metric.dart`; Create `test/foundation/performance/map_performance_count_bytes_catalog_test.dart`。

**Contract:** catalogへcount=`cacheHit/cacheMiss/tileQueueDepth/gpuBucketCount/labelCandidateCount/labelAcceptedCount`、bytes=`currentCpuBytes/peakCpuBytes/currentGpuBytes/peakGpuBytes/requestBytes/decodeBytes`を追加し、unit mapperを全enumでexhaustiveにする。

**Sequence (one commit):**

1. exact count/bytes enum set、各unit、duration mapping非退行testを作りREDを実行する。Expected RED: count/bytes catalog未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_count_bytes_catalog_test.dart
```
2. catalog/switchを拡張しschema/duration/count/bytes全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_metric.dart test/foundation/performance/map_performance_count_bytes_catalog_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_schema_test.dart test/foundation/performance/map_performance_catalog_test.dart test/foundation/performance/map_performance_count_bytes_catalog_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_metric.dart packages/eqmonitor_map/test/foundation/performance/map_performance_count_bytes_catalog_test.dart
git commit -m "Feat: count bytes性能metricを固定"
git push
```
Expected GREEN: schema/full catalog/library PASS、format/analyze/diff clean。

### Task 36: typed performance sample factories

**Files:** Create `lib/src/foundation/performance/map_performance_sample.dart`; Create `test/foundation/performance/map_performance_sample_test.dart`。

**Contract:** `MapPerformanceSample.duration/count/bytes(schemaVersion,clockDomain,kind,monotonicAt,value)`。metric-unit mismatch、negative time/valueをrejectする。

**Sequence (one commit):**

1. 各factory successと全unit mismatch testを作りREDを実行する。Expected RED: sample未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_sample_test.dart
```
2. private Freezed factoryとunit-specific creatorsを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/performance/map_performance_sample.dart test/foundation/performance/map_performance_sample_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_sample_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_sample.dart packages/eqmonitor_map/lib/src/foundation/performance/map_performance_sample.freezed.dart packages/eqmonitor_map/test/foundation/performance/map_performance_sample_test.dart
git commit -m "Feat: typed性能sampleを追加"
git push
```
Expected GREEN: sample/library PASS、format/analyze/diff clean。

### Task 37: version/domain typed performance event

**Files:** Create `lib/src/foundation/performance/map_performance_event.dart`; Create `test/foundation/performance/map_performance_event_test.dart`。

**Contract:** `createMapPerformanceEvent(frameSequence,sample,fixtureId?,nodeKey?,operationId?)`。schema/domainはsampleからtyped getterで公開し、negative frameとblank optional provenanceをrejectする。

**Sequence (one commit):**

1. getter/provenance/validation testを作りREDを実行する。Expected RED: event creator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_event_test.dart
```
2. immutable event creatorを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_event.dart test/foundation/performance/map_performance_event_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_event_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_event.dart packages/eqmonitor_map/test/foundation/performance/map_performance_event_test.dart
git commit -m "Feat: 性能event provenanceを追加"
git push
```
Expected GREEN: event/library PASS、format/analyze/diff clean。

### Task 38: performance policy model primitives

**Files:** Create `lib/src/foundation/performance/map_performance_policy.dart`; Create `test/foundation/performance/map_performance_policy_model_test.dart`。

**Contract:** observation=`off/aggregate/detailed`、drop=`dropOldest/dropNewest`、`createMapFrameBudget({required duration})`、raw public constructorなしの`MapPerformancePolicy` type。

**Sequence (one commit):**

1. exact enums、positive frame budget、policy type annotation testを作りREDを実行する。Expected RED: model未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_policy_model_test.dart
```
2. enums/budget/private policy modelを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_policy.dart test/foundation/performance/map_performance_policy_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_policy_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_policy.dart packages/eqmonitor_map/test/foundation/performance/map_performance_policy_model_test.dart
git commit -m "Feat: 性能観測policy modelを追加"
git push
```
Expected GREEN: policy model/library PASS、format/analyze/diff clean。

### Task 39: validated performance policy creator

**Files:** Modify `lib/src/foundation/performance/map_performance_policy.dart`; Create `test/foundation/performance/map_performance_policy_validation_test.dart`。

**Contract:** `createMapPerformancePolicy`はschema/domain/level/window/percentiles/snapshot interval/reservoir/sample cadence/event interval/buffer/drop/frame budgetを全requiredにする。暗黙defaultなし。

**Sequence (one commit):**

1. positive duration/capacity、percentile `(0,100]` sorted unique、snapshot<=window、defensive list testを作りREDを実行する。Expected RED: creator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_policy_validation_test.dart
```
2. validated creatorを実装しpolicy全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_policy.dart test/foundation/performance/map_performance_policy_validation_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_policy_model_test.dart test/foundation/performance/map_performance_policy_validation_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_policy.dart packages/eqmonitor_map/test/foundation/performance/map_performance_policy_validation_test.dart
git commit -m "Feat: 性能観測policyを検証"
git push
```
Expected GREEN: policy model/validation/library PASS、format/analyze/diff clean。

### Task 40: metric aggregate snapshot models

**Files:** Create `lib/src/foundation/performance/map_metric_aggregate.dart`; Create `test/foundation/performance/map_metric_aggregate_model_test.dart`。

**Contract:** `createMapPercentileValue`、`createMapMetricAggregate(count,sum,min,max,percentiles,percentileSampleCount,percentileDroppedCount)`はraw mutable collectionsを公開しない。

**Sequence (one commit):**

1. required fields、invalid counts、percentile alias testを作りREDを実行する。Expected RED: models未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_metric_aggregate_model_test.dart
```
2. validated private constructorsとimmutable gettersを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_metric_aggregate.dart test/foundation/performance/map_metric_aggregate_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_metric_aggregate_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_metric_aggregate.dart packages/eqmonitor_map/test/foundation/performance/map_metric_aggregate_model_test.dart
git commit -m "Feat: 性能aggregate modelを追加"
git push
```
Expected GREEN: aggregate model/library PASS、format/analyze/diff clean。

### Task 41: bounded metric accumulator

**Files:** Modify `lib/src/foundation/performance/map_metric_aggregate.dart`; Create `test/foundation/performance/map_metric_accumulator_test.dart`。

**Contract:** `MapMetricAccumulator(maxSamples).add(sample)`、`snapshot(percentiles)`。count/sum/min/maxは全sample、nearest-rank percentileはbounded deterministic reservoirを使う。

**Sequence (one commit):**

1. `[1,2,3,4]` exact aggregate、capacity overflow、sample/dropped counts、determinism testを作りREDを実行する。Expected RED: accumulator未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_metric_accumulator_test.dart
```
2. sequence-mod-capacity accumulatorを実装しaggregate全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_metric_aggregate.dart test/foundation/performance/map_metric_accumulator_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_metric_aggregate_model_test.dart test/foundation/performance/map_metric_accumulator_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_metric_aggregate.dart packages/eqmonitor_map/test/foundation/performance/map_metric_accumulator_test.dart
git commit -m "Feat: 性能metricを有界集約"
git push
```
Expected GREEN: aggregate model/accumulator/library PASS、format/analyze/diff clean。

### Task 42: collector/result model shell

**Files:** Create `lib/src/foundation/performance/map_performance_collector.dart`; Create `test/foundation/performance/map_performance_collector_model_test.dart`。

**Contract:** `MapPerformanceRecordResult.accepted/aggregated/ignored/rejected`、`MapPerformanceCollector(policy,windowStartedAt)`、read-only `acceptedCount/aggregatedCount/ignoredCount/rejectedCount/rateLimitedCount/droppedCount/bufferedEventCount`。completed snapshotsはsnapshot型導入後のTask 45でresultへ追加する。

**Sequence (one commit):**

1. result variant invariants、collector initial state、negative start testを作りREDを実行する。Expected RED: shell未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_collector_model_test.dart
```
2. behaviorを先取りせずresult/collector shellを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_collector_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_collector_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_collector_model_test.dart
git commit -m "Feat: 性能collector modelを追加"
git push
```
Expected GREEN: collector model/library PASS、format/analyze/diff clean。

### Task 43: collector validation/observation behavior

**Files:** Modify `lib/src/foundation/performance/map_performance_collector.dart`; Create `test/foundation/performance/map_performance_collector_validation_test.dart`。

**Contract:** `record(event)`はschema/domain mismatchとmonotonic逆行を集約前にtyped rejectする。off=ignored、aggregate=aggregateだけ、detailed=aggregate+event candidate。

**Sequence (one commit):**

1. mismatch/rollback不変、3 observation levels testを作りREDを実行する。Expected RED: record behavior未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_collector_validation_test.dart
```
2. validation→level→aggregateの順で実装しcollector全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_collector_validation_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_collector_model_test.dart test/foundation/performance/map_performance_collector_validation_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_collector_validation_test.dart
git commit -m "Feat: 性能sampleのversionとclockを検証"
git push
```
Expected GREEN: collector model/validation/library PASS、format/analyze/diff clean。

### Task 44: performance snapshot model

**Files:** Create `lib/src/foundation/performance/map_performance_snapshot.dart`; Create `test/foundation/performance/map_performance_snapshot_model_test.dart`。

**Contract:** `createMapPerformanceSnapshot(schemaVersion,clockDomain,windowStartedAt,windowEndedAt,isPartial,metrics,counters)`。metrics/countersはdefensive immutable、window end>start。

**Sequence (one commit):**

1. field validationとnested map/list alias testを作りREDを実行する。Expected RED: snapshot未定義。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_snapshot_model_test.dart
```
2. validated snapshot creatorを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_snapshot.dart test/foundation/performance/map_performance_snapshot_model_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_snapshot_model_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_snapshot.dart packages/eqmonitor_map/test/foundation/performance/map_performance_snapshot_model_test.dart
git commit -m "Feat: 性能snapshot modelを追加"
git push
```
Expected GREEN: snapshot model/library PASS、format/analyze/diff clean。

### Task 45: auto-advance partial/final windows

**Files:** Modify `lib/src/foundation/performance/map_performance_collector.dart`; Create `test/foundation/performance/map_performance_window_test.dart`。

**Contract:** `record`はvalid sampleを受理する前にsample timeまでwindowをauto-advanceし、Task 42 resultへ追加するimmutable `completedSnapshots`を返す。`takePartialSnapshot(at)`はnullable snapshotを返し、resetせず同時刻二回目はnull。`advanceWindows(until)`はeventなしでも空windowを順にfinalizeする。

**Sequence (one commit):**

1. start t0/window10/snapshot2 fixtureを作る: record t1,t2→t2 partial count2、same t2 partial null、record t3→t4 partial count3、record exactly t10は先にfinal `[0,10)` count3を返してsampleを`[10,20)`へ入れる、second record t10は再finalizeせずactive count2、t12 partial count2、record t31は`[10,20)` count2と`[20,30)` emptyを順に返してから`[30,40)`へsampleを入れる。Expected RED: auto-advance未実装。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_window_test.dart
```
2. validation後・aggregate前のauto-advance、partial cadence、completed-only resetを実装しcollector既存regressionも実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_window_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_collector_model_test.dart test/foundation/performance/map_performance_collector_validation_test.dart test/foundation/performance/map_performance_snapshot_model_test.dart test/foundation/performance/map_performance_window_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_window_test.dart
git commit -m "Feat: 性能windowを境界前進"
git push
```
Expected GREEN: collector validation/window/library PASS、format/analyze/diff clean。

### Task 46: aggregate-first bounded detailed delivery

**Files:** Modify `lib/src/foundation/performance/map_performance_collector.dart`; Create `test/foundation/performance/map_performance_delivery_test.dart`。

**Contract:** `drainEvents()`とdetailed counters。aggregate.add後だけframe sampling→kind別rate-limit→ListQueue drop policyを適用する。

**Sequence (one commit):**

1. same kind 2 samples inside min intervalでaggregate count2/buffer1/rateLimited1、sampling、dropOldest/newest、capacity、drain ownership testを作りREDを実行する。Expected RED: delivery未実装。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_performance_delivery_test.dart
```
2. aggregate-first deliveryを実装しcollector全focused regressionを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_delivery_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_performance_collector_model_test.dart test/foundation/performance/map_performance_collector_validation_test.dart test/foundation/performance/map_performance_snapshot_model_test.dart test/foundation/performance/map_performance_window_test.dart test/foundation/performance/map_performance_delivery_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart packages/eqmonitor_map/test/foundation/performance/map_performance_delivery_test.dart
git commit -m "Feat: 性能eventを集約後に有界配信"
git push
```
Expected GREEN: collector validation/window/delivery/library PASS、format/analyze/diff clean。

### Task 47: FrameTiming samples/frame budget

**Files:** Create `lib/src/foundation/performance/map_frame_timing_samples.dart`; Create `test/foundation/performance/map_frame_timing_samples_test.dart`; Create `test/foundation/performance/map_performance_metric_coverage_test.dart`。

**Contract:** `mapFrameTimingSamples(timing,schemaVersion,clockDomain,monotonicAt,frameBudget)`。build/rasterと`max(totalSpan-frameBudget,zero)`を`flutterFrameBudgetOverrun`へ変換する。

**Sequence (one commit):**

1. synthetic timing、異なるbudget、zero floor、全required metric coverage testを作りREDを実行する。Expected RED: converter/coverage不足。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart
```
2. wall clockを読まないconverterを実装しGREEN gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_frame_timing_samples.dart test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/performance/map_frame_timing_samples_test.dart test/foundation/performance/map_performance_metric_coverage_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance/map_frame_timing_samples.dart packages/eqmonitor_map/test/foundation/performance/map_frame_timing_samples_test.dart packages/eqmonitor_map/test/foundation/performance/map_performance_metric_coverage_test.dart
git commit -m "Feat: FrameTiming性能sampleを追加"
git push
```
Expected GREEN: timing/coverage/library PASS、format/analyze/diff clean。

### Task 48: public inventory core/frame/revision chunk

**Files:** Modify `lib/eqmonitor_map.dart`; Reference existing `lib/src/geo/map_viewport.dart`; Create `test/foundation/foundation_public_api_test.dart`。

**Contract:** package entrypointだけをimportし、次を各1 closureで実行する: `createMapNodeKey`、`createMapNodeTypeId`、`createMapNodeIdentity`、`MapNodeIdentity` type、`classifyMapNodeIdentity`、`MapNodeIdentityChange.values`、`MapNode` type、`MapDeclarationNode`、`MapScene`、`MapElement.identity/mount/update/unmount`、`MapElementFactory.create`、`MapChildReconciler.elements/reconcile/unmountAll`、`createMapClockDomainId`、`createMapClockCapture`、`MapClock.capture`、`SystemMapClock.start`、`createMapSourceInstanceId`、`createMapContentDigest`、`createMapFrameSourceRevisionStamp`、`createMapFrameLayerRevisionStamp`、`MapFrameRevisionStamp` type、`MapFrameRevisionScope.values`、`canonicalizeMapFrameRevisions`、`MapAppLifecycle.values`、`MapFrameSnapshot` type、`captureMapFrameSnapshot`、`MapViewport`、`createMapFullRevision`、`createMapDeltaRevision`、`createMapCommittedRevision`、`createMapFullResyncRequest`、`MapRevisionRejectReason.values`、`MapRevisionApplyResult.committed/idempotentNoOp/rejected/requiresFullResync`、`MapRevisionCandidate`、`MapRevisionStateOwner.own`、`MapRevisionCommitStore.current/commitFull/commitDelta/fullResyncRequest/needsFullResync/resyncAfterRevision`。

**Sequence (one commit):**

1. `src/` importなしのcore/revision closuresとlocal `MapClock/MapElementFactory/MapRevisionStateOwner` fakesを作りREDを実行する。Expected RED: exports不足。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/foundation_public_api_test.dart --plain-name "core frame revision public inventory"
```
2. Task 1–18 filesに加え、既存pathをentrypointへexactに`export 'src/geo/map_viewport.dart';`として明示exportする。`MapViewport` closureはこのexportが欠落するとcompile failureになるため、pathとinventoryを同じGREEN gateで検証する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/eqmonitor_map.dart test/foundation/foundation_public_api_test.dart
rg -n "^export 'src/geo/map_viewport.dart';$" lib/eqmonitor_map.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/eqmonitor_map.dart packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart
git commit -m "Feat: core revision APIを公開"
git push
```
Expected GREEN: core inventory/library PASS、format/analyze/diff clean。

### Task 49: public inventory render chunk

**Files:** Modify `lib/eqmonitor_map.dart`; Modify `test/foundation/foundation_public_api_test.dart`。

**Contract:** 次を各1 closureで追加する: `createMapRenderPhaseId`、`MapRenderPhaseId.labelForeground`、`createMapRenderPhasePolicy`、`MapRenderPhasePolicy.rankOf`、`MapRenderSortKey`、`compareMapRenderSortKeys`、`reverseMapRenderSortKeysForHitTest`、`MapVertexAttributeSemantic.values`、`MapVertexAttributeFormat.values/byteLength/scalarAlignment`、`MapVertexAttributeLayout`、`MapPrimitiveTopology.values`、`MapPackedByteOrder.values`、`MapIndexFormat.values`、`createMapPackedMeshLayout`、`haveCompatibleMapPackedMeshLayouts`、`createMapPackedMesh`、`createMapRenderPipelineKey`、`createMapMaterialParameterBlock`、`haveEqualMapMaterialParameterContent`、`createMapRenderBatchKey`、`createMapRenderPacket`、`MapRenderBatchCompatibility`、`mapRenderBatchCompatibilityOf`、`MapRenderBatch` type、`createMapRenderBatch`、`MapRenderBatch.instanceTransforms`、`buildCanonicalRenderBatches`、`createMapRenderSubmission`、`MapRenderSubmission` type、`MapRenderBatchAdapter.submit`、`validateMapRenderSubmission`。

**Internal boundary:** private Freezed factories、compatibility comparison helper、stable grouping helper、recording test supportはexport/inventory対象外。`MapRenderBatchCompatibility`、`mapRenderBatchCompatibilityOf`、submission validatorはpublicで必ずinventory対象。

**Sequence (one commit):**

1. render closuresとlocal adapter fakeを追加しREDを実行する。Expected RED: render exports不足。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/foundation_public_api_test.dart --plain-name "render public inventory"
```
2. Task 19–33 production filesを明示exportし、既存core chunkを含む同file全体をGREEN実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/eqmonitor_map.dart test/foundation/foundation_public_api_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/eqmonitor_map.dart packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart
git commit -m "Feat: render foundation APIを公開"
git push
```
Expected GREEN: core/render inventory/library PASS、format/analyze/diff clean。

### Task 50: public inventory performance chunk

**Files:** Modify `lib/eqmonitor_map.dart`; Modify `test/foundation/foundation_public_api_test.dart`。

**Contract:** 次を各1 closureで追加する: `createMapPerformanceSchemaVersion`、`MapPerformanceMetricUnit.values`、`MapPerformanceMetricKind.values`、`mapPerformanceMetricUnitOf`、`MapPerformanceSample.duration/count/bytes`、`createMapPerformanceEvent`とeventの`schemaVersion/clockDomain` getters、`MapPerformanceObservationLevel.values`、`MapPerformanceDropPolicy.values`、`createMapFrameBudget`、`createMapPerformancePolicy`、`createMapPercentileValue`、`createMapMetricAggregate`、`MapMetricAccumulator.add/snapshot`、`MapPerformanceRecordResult.accepted/aggregated/ignored/rejected/completedSnapshots`、`MapPerformanceCollector`、`record`、`acceptedCount/aggregatedCount/ignoredCount/rejectedCount/rateLimitedCount/droppedCount/bufferedEventCount`、`createMapPerformanceSnapshot`、`takePartialSnapshot`、`advanceWindows`、`drainEvents`、`mapFrameTimingSamples`。

**Internal boundary:** accumulator reservoir replacement helper、window rollover helper、rate-limit helperはprivateでexportしない。それ以外の上記creator/type/memberは漏れなくinventoryへ置く。

**Sequence (one commit):**

1. performance closuresを追加しREDを実行する。Expected RED: performance exports不足。
```bash
cd packages/eqmonitor_map
mise exec -- flutter test test/foundation/foundation_public_api_test.dart --plain-name "performance public inventory"
```
2. Task 34–47 production filesを明示exportし、3 chunk全体をGREEN実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/eqmonitor_map.dart test/foundation/foundation_public_api_test.dart
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/eqmonitor_map.dart packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart
git commit -m "Feat: performance foundation APIを公開"
git push
```
Expected GREEN: core/render/performance inventory/library PASS、format/analyze/diff clean。

### Task 51: foundation contract documentation

**Files:** Modify `README.md`; Create `../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`。

**Contract:** 実装範囲、検証command、KEVi/dashmap pinと採用/不採用、caller phase、source isolation、packed compatibility、auto-advance windows、aggregate-first delivery、#1591/#1593/#1595/#1596 owner、device未実施を記録する。

**Sequence (one commit):**

1. knowledge fileを作る前にREDを実行する。Expected RED: file不存在でFAIL。
```bash
cd packages/eqmonitor_map
rg -n '^## Foundation contract$' ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
```
2. README/knowledgeを作成しpackage regressionとdoc markerをGREEN実行する。
```bash
cd packages/eqmonitor_map
rg -n '^## Foundation contract$' ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
mise exec -- dart format --output=none --set-exit-if-changed lib test
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation/foundation_public_api_test.dart test/widget/base_map_view_test.dart test/eqmonitor_map_library_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/README.md docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git commit -m "Docs: 地図foundation運用知見を記録"
git push
```
Expected GREEN: marker/public/BaseMap/library PASS、format/analyze/diff clean。

### Task 52: final package/BaseMap verification record

**Files:** Modify `../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`。

**Contract:** 欠陥は該当Taskへ戻してそのfile/test/commit境界で直す。このTaskは最終automated evidenceとdevice未実施riskだけを追記する。

**Sequence (one commit):**

1. marker追記前にREDを実行する。Expected RED: marker不存在でFAIL。
```bash
cd packages/eqmonitor_map
rg -n '^## Final automated verification$' ../../docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
```
2. markerと実行結果欄を追記し、次の全gateを実行する。
```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib test
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub test/foundation test/renderer/map_render_submission_model_test.dart test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter test --no-pub test/widget/base_map_view_test.dart test/tile/base_map_render_plan_builder_test.dart test/tile/base_map_tile_decoder_test.dart test/geo/tile_matrix_test.dart
mise exec -- flutter test --no-pub
cd ../..
if rg -n "package:(flutter_scene|scene)/" packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
rg -n '^## Final automated verification$' docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git diff --check
git add docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git commit -m "Test: 地図foundation検証を確定"
git push
```
Expected GREEN: generated output committed、format/analyze/foundation/adapter/BaseMap/full package/isolation/doc marker/diffすべてPASS。device/simulator/golden/E2Eは未実施として記録する。
