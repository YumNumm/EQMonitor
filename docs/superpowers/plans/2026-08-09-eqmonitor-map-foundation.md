# EQMonitor Map Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1590 として、Flutter Scene や具体的な地物 payload に依存しない宣言的 scene identity、frame snapshot、atomic revision、canonical render order、packed render contract、性能観測の土台を公開する。

**Architecture:** `foundation/` は不変な宣言モデルと、key + 明示的 node type だけで更新種別を決める軽量 Element reconciler を所有する。frame は注入 clock を一度だけ capture し、動的な内容は generic `MapRevisionCommitStore<TState>` が完全検証済み candidate を atomic commit する。描画側は caller-supplied の versioned phase policy から唯一の sort key を作り、Scene 非依存の packed packet を連続範囲だけ batch 化して adapter へ渡す。性能 event は明示 policy に従い deterministic sampling、種類別 rate limit、固定容量 buffer で集約する。

**Tech Stack:** Flutter master `4dacd3fc91d96262a33e5c598e17d816f0b35641`、Dart 3.11、Freezed 3、`dart:typed_data`、`dart:collection`、flutter_test、mise（Flutter Scene pin `7f71993b7e2a0ab1d2f59726a406098709be7291` は既存 BaseMap のみで、本 foundation から import しない）

## Global Constraints

- 対象は Issue #1590 だけとする。#1591 の PMTiles I/O / worker payload transport、#1593 の実 Flutter Scene Geometry/Material/GPU lifecycle、#1595 の観測点・波・現在地等の concrete payload、#1596 の app/Home/controller 統合を実装しない。
- 欠落している参照正本 `docs/superpowers/specs/2026-08-07-eqmonitor-map-seismicity-github-issues.md` や未列挙の phase を推測で補わない。明記済みの `labelForeground` 以外は `MapRenderPhasePolicy` の versioned caller-supplied 順序を正本にする。
- `MapNode` は Widget 型、GeoJSON、Style JSON、network、GPU resource を保持しない。同じ key + node type のみ retain、同じ key + 異なる type は replace とする。hot path は node tree の deep equality/hash を使わない。
- revision store は state を generic に保ち、#1595 の Feature 型・fresh/stale/expired policy を先取りしない。candidate builder 完了前に current state、revision、digest、resync latch を変更しない。
- delta は `targetRevision > baseRevision`、current との厳密な base 一致を要求する。gap/branch 後は latch 時点より新しい authoritative full commit だけが latch を解除し、equal digest no-op や validation failure では解除しない。
- 描画順は `phase → phase内宣言順 → source → overscaled tile → feature` のみ。phase 跨ぎ interleave、非連続 material batch の結合、Feature 単位 Scene Node を禁止する。label/leader line caller は必ず `MapRenderPhaseId.labelForeground` を使う。
- packed mesh、render packet/batch は version を必須にし、JSON serialization と Flutter Scene 型を持たない。typed bytes は constructor で defensive copy + unmodifiable view にし、別名参照からの mutation を防ぐ。
- performance policy は buffer capacity、sampling、snapshot interval、event interval、drop policy を全て明示入力にする。random sampling、無制限 queue、暗黙 default、固定値 fallback を追加しない。
- KEVi は commit `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f` の UI/render snapshot、phase内宣言順、逆順 hit-test、bounded/rate-limited metrics の着想を採用する。Miller projection、global declaration order、mutable setter layer、全 frame 再描画は採用しない。
- dashmap は commit `a6ff92edd999e922f81d26d209d8f589faee3fd0` の pure typed-data CPU job、tile単位 batching、bounded in-flight/apply budget、GPUなし unit test の分離を採用する。domain が `Scene`/`Node` を直接所有する構造、`DateTime.now()` の subsystem 別取得、mutable private streamer を foundation API へ持ち込まない。
- 新規依存は追加しない。Flutter/Dart command は常に `mise exec --` 経由。class 内 private method、`dynamic`/`Object`（許可済み map 以外）、`!`、`print()` を追加しない。2引数以上は名前付き引数にする。
- 物理 device、simulator、golden、全 E2E は受け入れ対象外。pure Dart/Flutter unit、public API compile、Flutter Scene import gate、既存 BaseMap regression で代替する。
- 1 logical commit は手書き差分約30〜100行を目安にする。Freezed生成物は対応sourceと同じcommitへ置く。各commit前に対象test、format、`git diff --check`、各commit後に `git push` を実行する。PRはstack全体のreview後に作る。

---

### Task 1: 公開 MapScene / MapNode identity を定義する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_node.dart`
- Create: `packages/eqmonitor_map/lib/src/foundation/map_scene.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_node_test.dart`

**Interfaces:**
- Produces: `MapNodeKey(String value)`, `MapNodeTypeId(String value)`, `MapNode.identity`, `MapNode.children`, `MapScene(children:)`, `classifyMapNodeIdentity({required previous, required next}) -> MapNodeIdentityChange`.

- [ ] **Step 1: identity と immutable children の failing test を書く**

```dart
test('retains only the same key and explicit node type', () {
  final key = MapNodeKey('base-map');
  expect(
    classifyMapNodeIdentity(
      previous: MapNodeIdentity(key: key, type: MapNodeTypeId('source')),
      next: MapNodeIdentity(key: key, type: MapNodeTypeId('source')),
    ),
    MapNodeIdentityChange.retain,
  );
  expect(
    classifyMapNodeIdentity(
      previous: MapNodeIdentity(key: key, type: MapNodeTypeId('source')),
      next: MapNodeIdentity(key: key, type: MapNodeTypeId('line')),
    ),
    MapNodeIdentityChange.replace,
  );
});
```

`MapNodeKey('')`、空白のみの type、同じ key でも別 type、元の children list を変更しても `MapScene.children` が変わらないことも同じfileで固定する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/map_node_test.dart`

Expected: FAIL（foundation 型が未定義）。

- [ ] **Step 3: 最小の宣言モデルを実装する**

```dart
abstract interface class MapNode {
  MapNodeIdentity get identity;
  List<MapNode> get children;
}

enum MapNodeIdentityChange { retain, replace }

MapNodeIdentityChange classifyMapNodeIdentity({
  required MapNodeIdentity previous,
  required MapNodeIdentity next,
}) => previous == next
    ? MapNodeIdentityChange.retain
    : MapNodeIdentityChange.replace;
```

`MapNodeKey` / `MapNodeTypeId` は非空trim済み文字列を要求する manual immutable value object、`MapNodeIdentity` / `MapScene` は Freezed とする。`MapScene` factory へ渡された list は unmodifiable copy に固定する。

- [ ] **Step 4: GREEN、生成、commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/map_node.dart lib/src/foundation/map_scene.dart test/foundation/map_node_test.dart
mise exec -- flutter test test/foundation/map_node_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation packages/eqmonitor_map/test/foundation/map_node_test.dart
git commit -m "Feat: 地図sceneのidentity契約を追加"
git push
```

### Task 2: key/type ベースの MapElement reconciler を追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/map_element.dart`
- Create: `packages/eqmonitor_map/test/foundation/map_element_test.dart`

**Interfaces:**
- Consumes: `MapNode`, `MapNodeIdentity`, `classifyMapNodeIdentity`.
- Produces: `MapElement`, `MapElementFactory.create({required MapNode node})`, `MapChildReconciler.reconcile({required nodes, required factory})`, `MapChildReconciler.unmountAll()`.

- [ ] **Step 1: lifecycle order の failing test を書く**

```dart
test('updates, reorders, replaces, and unmounts by key and type', () {
  final events = <String>[];
  final reconciler = MapChildReconciler();
  reconciler.reconcile(nodes: [node('a', 'fill'), node('b', 'line')], factory: fakeFactory(events));
  reconciler.reconcile(nodes: [node('b', 'line'), node('a', 'circle')], factory: fakeFactory(events));
  expect(events, [
    'mount:a:fill', 'mount:b:line',
    'update:b:line', 'unmount:a:fill', 'mount:a:circle',
  ]);
});
```

duplicate sibling key は lifecycle を一件も変更せず `ArgumentError`、`unmountAll` は逆順かつ二回目no-opになることも検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/map_element_test.dart`

Expected: FAIL（`MapChildReconciler` 未定義）。

- [ ] **Step 3: 一階層reconcilerを実装する**

```dart
abstract interface class MapElement {
  MapNodeIdentity get identity;
  void mount({required MapNode node});
  void update({required MapNode node});
  void unmount();
}

abstract interface class MapElementFactory {
  MapElement create({required MapNode node});
}
```

`reconcile` は next sibling key の重複を最初に検証し、既存を key lookup、retain は `update`、replace は `unmount → create → mount`、消えたelementは旧順の逆順でunmountする。新しい順序を内部listへ一回でcommitし、子treeは各concrete elementが別の `MapChildReconciler` で所有する。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/map_element.dart test/foundation/map_element_test.dart
mise exec -- flutter test test/foundation/map_element_test.dart test/foundation/map_node_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/map_element.dart packages/eqmonitor_map/test/foundation/map_element_test.dart
git commit -m "Feat: Node identityでElementをreconcile"
git push
```

### Task 3: wall / monotonic を同時取得する MapClock 境界を作る

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/frame/map_clock.dart`
- Create: `packages/eqmonitor_map/test/foundation/frame/map_clock_test.dart`

**Interfaces:**
- Produces: `MapClock.capture() -> MapClockCapture`, `SystemMapClock.start({required String clockDomain})`.

- [ ] **Step 1: clock domain と入力検証の failing test を書く**

```dart
test('capture carries UTC wall time and one monotonic domain', () {
  final clock = SystemMapClock.start(clockDomain: 'renderer-process');
  final first = clock.capture();
  final second = clock.capture();
  expect(first.wallNowUtc.isUtc, isTrue);
  expect(second.monotonicNow >= first.monotonicNow, isTrue);
  expect(second.clockDomain, first.clockDomain);
});
```

空domain、local `DateTime`、負monotonic durationをrejectする constructor testも追加する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/frame/map_clock_test.dart`

Expected: FAIL（clock 型が未定義）。

- [ ] **Step 3: 注入可能clockを実装する**

```dart
abstract interface class MapClock {
  MapClockCapture capture();
}

final class SystemMapClock implements MapClock {
  factory SystemMapClock.start({required String clockDomain}) =>
      SystemMapClock(clockDomain: clockDomain, stopwatch: Stopwatch()..start());

  @override
  MapClockCapture capture() => MapClockCapture(
    wallNowUtc: DateTime.now().toUtc(),
    monotonicNow: stopwatch.elapsed,
    clockDomain: clockDomain,
  );
}
```

`MapClockCapture` は validation 付きimmutable型とし、processを跨ぐserialize APIを持たせない。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/frame/map_clock.dart test/foundation/frame/map_clock_test.dart
mise exec -- flutter test test/foundation/frame/map_clock_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame packages/eqmonitor_map/test/foundation/frame
git commit -m "Feat: frame用clock captureを追加"
git push
```

### Task 4: frame ごとに一回だけ capture する MapFrameSnapshot を作る

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/frame/map_frame_snapshot.dart`
- Create: `packages/eqmonitor_map/test/foundation/frame/map_frame_snapshot_test.dart`

**Interfaces:**
- Consumes: `MapClock`, `MapCamera`, `MapViewport`.
- Produces: `MapFrameRevisionStamp`, `MapAppLifecycle`, `MapFrameSnapshot`, `captureMapFrameSnapshot(...)`.

- [ ] **Step 1: single-capture の failing test を書く**

```dart
test('captures the clock exactly once and freezes canonical revisions', () {
  final clock = CountingMapClock(fixedCapture);
  final snapshot = captureMapFrameSnapshot(
    clock: clock,
    frameSequence: 7,
    camera: camera,
    viewport: viewport,
    revisions: [layerRevision, sourceRevision],
    lifecycle: MapAppLifecycle.foreground,
    sceneContextGeneration: 3,
  );
  expect(clock.captureCount, 1);
  expect(snapshot.wallNowUtc, fixedCapture.wallNowUtc);
  expect(snapshot.revisions, [sourceRevision, layerRevision]);
});
```

同じ `(scope, ownerKey)` の重複、負revision/frame/context generationをrejectするtestも追加する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/frame/map_frame_snapshot_test.dart`

Expected: FAIL（snapshot型が未定義）。

- [ ] **Step 3: immutable snapshot と純粋なcapture関数を実装する**

```dart
MapFrameSnapshot captureMapFrameSnapshot({
  required MapClock clock,
  required int frameSequence,
  required MapCamera camera,
  required MapViewport viewport,
  required List<MapFrameRevisionStamp> revisions,
  required MapAppLifecycle lifecycle,
  required int sceneContextGeneration,
}) {
  final capture = clock.capture();
  final canonicalRevisions = canonicalizeMapFrameRevisions(revisions: revisions);
  return MapFrameSnapshot(
    frameSequence: frameSequence,
    wallNowUtc: capture.wallNowUtc,
    monotonicNow: capture.monotonicNow,
    clockDomain: capture.clockDomain,
    camera: camera,
    viewport: viewport,
    revisions: canonicalRevisions,
    lifecycle: lifecycle,
    sceneContextGeneration: sceneContextGeneration,
  );
}
```

Freezed生成型にし、revisionは `source` → `layer`、次にowner keyでsortしたunmodifiable copyとする。

- [ ] **Step 4: GREEN、生成、commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib/src/foundation/frame/map_frame_snapshot.dart test/foundation/frame/map_frame_snapshot_test.dart
mise exec -- flutter test test/foundation/frame/map_clock_test.dart test/foundation/frame/map_frame_snapshot_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/frame packages/eqmonitor_map/test/foundation/frame
git commit -m "Feat: frame snapshotを一回の時刻取得で固定"
git push
```

### Task 5: revision metadata と typed apply result を定義する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_test.dart`

**Interfaces:**
- Produces: `MapSourceInstanceId`, `MapContentDigest`, `MapFullRevision`, `MapDeltaRevision`, `MapRevisionCandidate<TState>`, `MapCommittedRevision<TState>`, `MapRevisionApplyResult<TState>.committed/.idempotentNoOp/.rejected`, outcome/reject enums.

- [ ] **Step 1: metadata invariant の failing test を書く**

```dart
test('requires an increasing delta and explicit full digest', () {
  expect(() => MapDeltaRevision(source: source, baseRevision: 4, targetRevision: 4), throwsArgumentError);
  expect(() => MapContentDigest(''), throwsArgumentError);
  expect(MapFullRevision(source: source, revision: 0, digest: digest).revision, 0);
});
```

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/revision/map_revision_test.dart`

Expected: FAIL（revision型が未定義）。

- [ ] **Step 3: version非依存のgeneric metadataを実装する**

```dart
enum MapRevisionApplyOutcome { committed, idempotentNoOp, rejected }

enum MapRevisionRejectReason {
  staleFull,
  conflictingEqualRevision,
  deltaWithoutFull,
  sourceMismatch,
  staleDelta,
  gap,
  branch,
  resyncLatched,
}
```

ID/digestは非空value object、revisionは0以上、delta constructorは `targetRevision > baseRevision` を必須にする。`MapRevisionCandidate<TState>` は検証済みcandidate stateとそのcanonical digestを保持する。`MapRevisionApplyResult<TState>` は commit後のcurrent、outcome、nullable reason、`requiresFullResync`をimmutableに保持する。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision.dart test/foundation/revision/map_revision_test.dart
mise exec -- flutter test test/foundation/revision/map_revision_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision packages/eqmonitor_map/test/foundation/revision
git commit -m "Feat: atomic revisionの型契約を追加"
git push
```

### Task 6: authoritative full snapshot を atomic commit する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_full_commit_test.dart`

**Interfaces:**
- Consumes: Task 5 metadata.
- Produces: `MapRevisionCommitStore<TState>.commitFull({required metadata, required validateAndBuild})`.

- [ ] **Step 1: full snapshot state machine の failing test を書く**

```dart
test('commits only after candidate validation completes', () {
  final store = MapRevisionCommitStore<List<int>>();
  store.commitFull(metadata: full(1, 'a'), validateAndBuild: () => const [1]);
  expect(
    () => store.commitFull(
      metadata: full(2, 'b'),
      validateAndBuild: () => throw const FormatException('invalid payload'),
    ),
    throwsFormatException,
  );
  expect(store.current?.revision, 1);
  expect(store.current?.state, const [1]);
});
```

lower revision reject、equal+same digest no-op、equal+different digest conflict、新sourceはcandidate成功後だけ交換するtestを分けて追加する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/revision/map_revision_full_commit_test.dart`

Expected: FAIL（store未定義）。

- [ ] **Step 3: candidate-first / assignment-once の store を実装する**

```dart
MapRevisionApplyResult<TState> commitFull({
  required MapFullRevision metadata,
  required TState Function() validateAndBuild,
}) {
  final candidate = validateAndBuild();
  final currentBefore = _current;
  if (currentBefore != null && currentBefore.source == metadata.source) {
    if (metadata.revision < currentBefore.revision) {
      return MapRevisionApplyResult.rejected(
        current: currentBefore,
        reason: MapRevisionRejectReason.staleFull,
        requiresFullResync: false,
      );
    }
    if (metadata.revision == currentBefore.revision) {
      if (metadata.digest == currentBefore.digest) {
        return MapRevisionApplyResult.idempotentNoOp(current: currentBefore);
      }
      return MapRevisionApplyResult.rejected(
        current: currentBefore,
        reason: MapRevisionRejectReason.conflictingEqualRevision,
        requiresFullResync: false,
      );
    }
  }
  final committed = MapCommittedRevision(
    source: metadata.source,
    revision: metadata.revision,
    digest: metadata.digest,
    state: candidate,
  );
  _current = committed;
  return MapRevisionApplyResult.committed(current: committed);
}
```

no-op時はcandidateではなく既存currentを返す。新sourceは上記same-source分岐へ入らず、candidate構築成功後にだけ `_current` を置換する。class内private methodを作らない。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_full_commit_test.dart
mise exec -- flutter test test/foundation/revision/map_revision_test.dart test/foundation/revision/map_revision_full_commit_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision packages/eqmonitor_map/test/foundation/revision/map_revision_full_commit_test.dart
git commit -m "Feat: full snapshotをatomic commit"
git push
```

### Task 7: delta の厳密適用と full-resync latch を実装する

**Files:**
- Modify: `packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_delta_commit_test.dart`
- Create: `packages/eqmonitor_map/test/foundation/revision/map_revision_resync_test.dart`

**Interfaces:**
- Produces: `commitDelta({required MapDeltaRevision metadata, required MapRevisionCandidate<TState> Function(TState current) validateAndBuild})`, `needsFullResync`, `resyncAfterRevision`.

- [ ] **Step 1: exact delta と rollback の failing test を書く**

```dart
test('applies only an exact-base delta after validation', () {
  final store = seededStore(revision: 4, state: const [1]);
  final applied = store.commitDelta(
    metadata: delta(base: 4, target: 5),
    validateAndBuild: (current) => MapRevisionCandidate(
      state: [...current, 2],
      digest: MapContentDigest('revision-5'),
    ),
  );
  expect(applied.current?.revision, 5);
  expect(applied.current?.state, const [1, 2]);
});
```

builder throw、target stale/duplicate、source mismatch、delta-before-fullが既存stateを変更しないtestも追加する。

- [ ] **Step 2: gap/branch latch と解除条件の failing test を書く**

```dart
test('gap latches until a newer authoritative full commit succeeds', () {
  final store = seededStore(revision: 4, state: const [1]);
  expect(store.commitDelta(metadata: delta(base: 6, target: 7), validateAndBuild: append).reason, MapRevisionRejectReason.gap);
  expect(store.needsFullResync, isTrue);
  expect(store.commitFull(metadata: full(4, 'a'), validateAndBuild: () => const [1]).outcome, MapRevisionApplyOutcome.idempotentNoOp);
  expect(store.needsFullResync, isTrue);
  store.commitFull(metadata: full(8, 'b'), validateAndBuild: () => const [8]);
  expect(store.needsFullResync, isFalse);
});
```

`base < current < target` branch、malformed/new full builder throw、new source full成功でのみ解除も検証する。

- [ ] **Step 3: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/revision/map_revision_delta_commit_test.dart test/foundation/revision/map_revision_resync_test.dart`

Expected: FAIL（delta/latch未実装）。

- [ ] **Step 4: delta state machine を実装する**

評価順は current存在 → latch → source一致 → stale target → gap/branch → exact base とする。exact baseだけがbuilderを呼び、成功後にstate/revisionを一度代入する。gap/branchはstateを変えず `resyncAfterRevision = current.revision` を設定する。full commitは同sourceなら `revision > resyncAfterRevision`、別sourceなら検証済みcommit成功時だけ latchをclearする。

```dart
MapRevisionApplyResult<TState> commitDelta({
  required MapDeltaRevision metadata,
  required MapRevisionCandidate<TState> Function(TState current)
      validateAndBuild,
}) {
  final currentBefore = _current;
  if (currentBefore == null) {
    return MapRevisionApplyResult.rejected(
      current: null,
      reason: MapRevisionRejectReason.deltaWithoutFull,
      requiresFullResync: true,
    );
  }
  if (_resyncAfterRevision != null) {
    return MapRevisionApplyResult.rejected(
      current: currentBefore,
      reason: MapRevisionRejectReason.resyncLatched,
      requiresFullResync: true,
    );
  }
  if (metadata.source != currentBefore.source) {
    return MapRevisionApplyResult.rejected(
      current: currentBefore,
      reason: MapRevisionRejectReason.sourceMismatch,
      requiresFullResync: true,
    );
  }
  if (metadata.targetRevision <= currentBefore.revision) {
    return MapRevisionApplyResult.rejected(
      current: currentBefore,
      reason: MapRevisionRejectReason.staleDelta,
      requiresFullResync: false,
    );
  }
  final isGap = metadata.baseRevision > currentBefore.revision;
  final isBranch = metadata.baseRevision < currentBefore.revision;
  if (isGap || isBranch) {
    _resyncAfterRevision = currentBefore.revision;
    return MapRevisionApplyResult.rejected(
      current: currentBefore,
      reason: isGap ? MapRevisionRejectReason.gap : MapRevisionRejectReason.branch,
      requiresFullResync: true,
    );
  }
  final candidate = validateAndBuild(currentBefore.state);
  final committed = MapCommittedRevision(
    source: currentBefore.source,
    revision: metadata.targetRevision,
    digest: candidate.digest,
    state: candidate.state,
  );
  _current = committed;
  return MapRevisionApplyResult.committed(current: committed);
}
```

- [ ] **Step 5: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/revision/map_revision_commit_store.dart test/foundation/revision/map_revision_delta_commit_test.dart test/foundation/revision/map_revision_resync_test.dart
mise exec -- flutter test test/foundation/revision
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/revision/map_revision_commit_store.dart packages/eqmonitor_map/test/foundation/revision
git commit -m "Feat: delta gapをfull resyncへlatch"
git push
```

### Task 8: versioned caller-supplied render phase policy を定義する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_phase.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_phase_test.dart`

**Interfaces:**
- Produces: `MapRenderPhaseId`, `MapRenderPhaseId.labelForeground`, `MapRenderPhasePolicy`, `rankOf({required phase})`.

- [ ] **Step 1: 明示phase順の failing test を書く**

```dart
test('uses the versioned caller order and requires labelForeground', () {
  final policy = MapRenderPhasePolicy(
    version: 7,
    orderedPhases: [MapRenderPhaseId('base'), MapRenderPhaseId.labelForeground],
  );
  expect(policy.rankOf(phase: MapRenderPhaseId('base')), 0);
  expect(policy.rankOf(phase: MapRenderPhaseId.labelForeground), 1);
});
```

version <= 0、空順序、重複、`labelForeground`欠落、未知phase lookupをrejectする。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/render/map_render_phase_test.dart`

Expected: FAIL（phase policy未定義）。

- [ ] **Step 3: 未列挙phaseを持たないpolicyを実装する**

```dart
final class MapRenderPhaseId {
  const MapRenderPhaseId._(this.value);

  static const labelForeground = MapRenderPhaseId._('labelForeground');
  factory MapRenderPhaseId(String value) => validateMapRenderPhaseId(value: value);

  final String value;
}
```

`MapRenderPhasePolicy` は defensive unmodifiable copy と rank mapを構築し、固定するのは明記済み `labelForeground` の存在だけにする。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_phase.dart test/foundation/render/map_render_phase_test.dart
mise exec -- flutter test test/foundation/render/map_render_phase_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render packages/eqmonitor_map/test/foundation/render
git commit -m "Feat: version付き描画phase順を追加"
git push
```

### Task 9: canonical RenderSortKey と逆順 hit-test を固定する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_sort_key.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_sort_key_test.dart`

**Interfaces:**
- Consumes: `MapRenderPhasePolicy`.
- Produces: `MapRenderSortKey`, `compareMapRenderSortKeys({required policy, required left, required right})`, `sortMapRenderKeysForHitTest(...)`.

- [ ] **Step 1: 全field順とphase非interleaveの failing test を書く**

```dart
test('sorts only by the canonical five-part key', () {
  final sorted = [...keys]..sort(
    (left, right) => compareMapRenderSortKeys(policy: policy, left: left, right: right),
  );
  expect(sorted, [baseDeclaration0, baseDeclaration1, overlay, label]);
  expect(
    sortMapRenderKeysForHitTest(policy: policy, keys: sorted),
    sorted.reversed.toList(),
  );
});
```

key fieldは `phase`, `declarationOrderWithinPhase`, `sourceOrder`, `overscaledTileOrder`, `featureOrder`。全数値の負値、policy version不一致、同一key重複をrejectするtestを追加する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/render/map_render_sort_key_test.dart`

Expected: FAIL（sort key未定義）。

- [ ] **Step 3: canonical comparatorを実装する**

```dart
int compareMapRenderSortKeys({
  required MapRenderPhasePolicy policy,
  required MapRenderSortKey left,
  required MapRenderSortKey right,
}) {
  final fields = [
    (policy.rankOf(phase: left.phase), policy.rankOf(phase: right.phase)),
    (left.declarationOrderWithinPhase, right.declarationOrderWithinPhase),
    (left.sourceOrder, right.sourceOrder),
    (left.overscaledTileOrder, right.overscaledTileOrder),
    (left.featureOrder, right.featureOrder),
  ];
  for (final (a, b) in fields) {
    final result = a.compareTo(b);
    if (result != 0) return result;
  }
  return 0;
}
```

hit-test helperはcanonical昇順を検証してからreverse copyを返す。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_sort_key.dart test/foundation/render/map_render_sort_key_test.dart
mise exec -- flutter test test/foundation/render/map_render_phase_test.dart test/foundation/render/map_render_sort_key_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render packages/eqmonitor_map/test/foundation/render
git commit -m "Feat: canonical描画順を固定"
git push
```

### Task 10: versioned packed mesh runtime 型を追加する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_packed_mesh_test.dart`

**Interfaces:**
- Produces: `MapPackedMeshLayout`, `MapPackedMesh`, typed `Uint8List` vertex/index payload.

- [ ] **Step 1: byte layout と alias safety の failing test を書く**

```dart
test('validates layout lengths and owns immutable bytes', () {
  final source = Uint8List.fromList([1, 2, 3, 4]);
  final mesh = MapPackedMesh(
    layout: MapPackedMeshLayout(version: 1, vertexStrideBytes: 4, indexElementBytes: 2),
    vertexBytes: source,
    indexBytes: Uint8List.fromList([0, 0]),
    vertexCount: 1,
    indexCount: 1,
  );
  source[0] = 9;
  expect(mesh.vertexBytes, [1, 2, 3, 4]);
  expect(() => mesh.vertexBytes[0] = 8, throwsUnsupportedError);
});
```

version/stride/count負値、vertex/index byte長不一致、index幅が0/2/4以外をrejectする。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/render/map_packed_mesh_test.dart`

Expected: FAIL（packed mesh未定義）。

- [ ] **Step 3: Scene非依存packed型を実装する**

constructor内で `vertexCount * vertexStrideBytes` と `indexCount * indexElementBytes` の完全一致を検証し、両byte列を `Uint8List.fromList(...).asUnmodifiableView()` へ変換する。JSON、`TransferableTypedData`、Flutter Scene Geometry変換は追加しない。

```dart
factory MapPackedMesh({
  required MapPackedMeshLayout layout,
  required Uint8List vertexBytes,
  required Uint8List indexBytes,
  required int vertexCount,
  required int indexCount,
}) {
  if (vertexCount < 0 || indexCount < 0) {
    throw ArgumentError('mesh counts must be non-negative');
  }
  if (vertexBytes.lengthInBytes != vertexCount * layout.vertexStrideBytes) {
    throw ArgumentError.value(vertexBytes.lengthInBytes, 'vertexBytes');
  }
  if (indexBytes.lengthInBytes != indexCount * layout.indexElementBytes) {
    throw ArgumentError.value(indexBytes.lengthInBytes, 'indexBytes');
  }
  return MapPackedMesh.owned(
    layout: layout,
    vertexBytes: Uint8List.fromList(vertexBytes).asUnmodifiableView(),
    indexBytes: Uint8List.fromList(indexBytes).asUnmodifiableView(),
    vertexCount: vertexCount,
    indexCount: indexCount,
  );
}
```

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_packed_mesh.dart test/foundation/render/map_packed_mesh_test.dart
mise exec -- flutter test test/foundation/render/map_packed_mesh_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_packed_mesh.dart packages/eqmonitor_map/test/foundation/render/map_packed_mesh_test.dart
git commit -m "Feat: version付きpacked meshを追加"
git push
```

### Task 11: 連続packetだけを render batch にまとめる

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart`
- Create: `packages/eqmonitor_map/test/foundation/render/map_render_batch_test.dart`

**Interfaces:**
- Consumes: `MapNodeKey`, `MapRenderSortKey`, `MapPackedMesh`.
- Produces: `MapRenderBatchKey`, `MapRenderPacket`, `MapRenderBatch`, `buildCanonicalRenderBatches({required policy, required packets})`.

- [ ] **Step 1: A/B/Aを再結合しない failing test を書く**

```dart
test('batches only adjacent equal keys after canonical sorting', () {
  final batches = buildCanonicalRenderBatches(
    policy: policy,
    packets: [packet(order: 2, batch: 'a'), packet(order: 1, batch: 'b'), packet(order: 0, batch: 'a')],
  );
  expect(batches.map((batch) => batch.key.scopeKey), ['a', 'b', 'a']);
  expect(batches.map((batch) => batch.packets.length), [1, 1, 1]);
});
```

隣接A/Aは1 batch、同一sort keyはreject、packet/batch listはunmodifiableであることも検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/render/map_render_batch_test.dart`

Expected: FAIL（batch planner未定義）。

- [ ] **Step 3: tile/layer/material単位のbatch契約を実装する**

`MapRenderBatchKey` は version、drawable `MapNodeKey`、caller-supplied non-empty scope key/material keyを保持する。plannerはpacketをcanonical sortし、隣接する同一batch keyだけを同じ `MapRenderBatch` へappendする。adapterはpacketごとではなくbatchごとにresource/nodeを作る契約をdoc commentへ明記する。

```dart
List<MapRenderBatch> buildCanonicalRenderBatches({
  required MapRenderPhasePolicy policy,
  required List<MapRenderPacket> packets,
}) {
  final sorted = List<MapRenderPacket>.of(packets)
    ..sort((left, right) => compareMapRenderSortKeys(
      policy: policy,
      left: left.sortKey,
      right: right.sortKey,
    ));
  validateUniqueMapRenderSortKeys(
    policy: policy,
    keys: sorted.map((packet) => packet.sortKey).toList(),
  );
  final batches = <MapRenderBatch>[];
  for (final packet in sorted) {
    final previous = batches.isEmpty ? null : batches.last;
    if (previous != null && previous.key == packet.batchKey) {
      batches[batches.length - 1] = previous.append(packet: packet);
    } else {
      batches.add(MapRenderBatch(key: packet.batchKey, packets: [packet]));
    }
  }
  return List<MapRenderBatch>.unmodifiable(batches);
}
```

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/render/map_render_batch.dart test/foundation/render/map_render_batch_test.dart
mise exec -- flutter test test/foundation/render
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/render/map_render_batch.dart packages/eqmonitor_map/test/foundation/render/map_render_batch_test.dart
git commit -m "Feat: 連続描画packetをbatch化"
git push
```

### Task 12: Scene非依存 adapter contract と fake を検証する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/support/recording_map_render_batch_adapter.dart`
- Create: `packages/eqmonitor_map/test/renderer/map_render_batch_adapter_contract_test.dart`

**Interfaces:**
- Consumes: `MapFrameSnapshot`, `MapRenderBatch`.
- Produces: `MapRenderBatchAdapter.submit({required frame, required batches})`, `MapRenderSubmission`.

- [ ] **Step 1: fake adapter contract の failing test を書く**

```dart
test('submits one immutable frame with canonical batches', () {
  final adapter = RecordingMapRenderBatchAdapter(policy: policy);
  adapter.submit(frame: frame, batches: batches);
  expect(adapter.submissions.single.frame, same(frame));
  expect(adapter.submissions.single.batches, batches);
  expect(adapter.createdRenderObjectCount, batches.length);
});
```

順序不正、policy version不一致、packet単位render object生成をfakeがrejectするcaseを追加する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/renderer/map_render_batch_adapter_contract_test.dart`

Expected: FAIL（adapter contract未定義）。

- [ ] **Step 3: production interface と test fake を実装する**

```dart
abstract interface class MapRenderBatchAdapter {
  void submit({
    required MapFrameSnapshot frame,
    required List<MapRenderBatch> batches,
  });
}
```

production側はinterfaceとimmutable submissionだけ、fakeはtest supportだけへ置く。既存spike `MapSceneRendererAdapter` を変更せず、Flutter Scene adapter実装は#1593へ残す。

- [ ] **Step 4: GREEN、import gate、commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/renderer/map_render_batch_adapter.dart test/renderer/support/recording_map_render_batch_adapter.dart test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter test test/renderer/map_render_batch_adapter_contract_test.dart
if rg -n "package:flutter_scene" lib/src/foundation lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/renderer/map_render_batch_adapter.dart packages/eqmonitor_map/test/renderer
git commit -m "Feat: Scene非依存の描画adapter契約を追加"
git push
```

### Task 13: versioned performance model / policy を定義する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_test.dart`

**Interfaces:**
- Produces: `MapPerformanceEventKind`, `MapPerformanceEvent`, `MapPerformanceSnapshot`, `MapPerformancePolicy`, `MapPerformanceDropPolicy`.

- [ ] **Step 1: policy invariant の failing test を書く**

```dart
test('requires every observation bound explicitly', () {
  final policy = MapPerformancePolicy(
    version: 1,
    sampleEveryNFrames: 2,
    snapshotInterval: const Duration(seconds: 1),
    eventMinInterval: const Duration(milliseconds: 50),
    eventBufferCapacity: 32,
    dropPolicy: MapPerformanceDropPolicy.dropOldest,
  );
  expect(policy.eventBufferCapacity, 32);
});
```

非正version/sample/capacity/interval、負event duration/countをrejectする。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/performance/map_performance_test.dart`

Expected: FAIL（performance型が未定義）。

- [ ] **Step 3: bounded observation型を実装する**

event kindは設計に列挙済みの `frameReconciliation`, `tileCover`, `labelPlacement`, `renderSubmission`, `tileRequest`, `decode`, `meshBuild`, `gpuUpload`, `instrumentationOverhead` とする。eventはversion、monotonic時刻、duration/count、nullable fixture IDを保持し、snapshotはwindow、accepted/sampledOut/rateLimited/dropped/buffered countを保持する。HUD、Flutter `FrameTiming` wiring、Controller Streamは追加しない。

```dart
enum MapPerformanceDropPolicy { dropOldest, dropNewest }

final class MapPerformancePolicy {
  factory MapPerformancePolicy({
    required int version,
    required int sampleEveryNFrames,
    required Duration snapshotInterval,
    required Duration eventMinInterval,
    required int eventBufferCapacity,
    required MapPerformanceDropPolicy dropPolicy,
  }) => validateMapPerformancePolicy(
    version: version,
    sampleEveryNFrames: sampleEveryNFrames,
    snapshotInterval: snapshotInterval,
    eventMinInterval: eventMinInterval,
    eventBufferCapacity: eventBufferCapacity,
    dropPolicy: dropPolicy,
  );
}
```

`MapPerformanceEvent` と `MapPerformanceSnapshot` も `version` をrequiredにし、すべてのlist/map入力をdefensive unmodifiable copyにする。

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance.dart test/foundation/performance/map_performance_test.dart
mise exec -- flutter test test/foundation/performance/map_performance_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance packages/eqmonitor_map/test/foundation/performance
git commit -m "Feat: version付き性能観測modelを追加"
git push
```

### Task 14: deterministic sampling / rate limit / bounded buffer を実装する

**Files:**
- Create: `packages/eqmonitor_map/lib/src/foundation/performance/map_performance_collector.dart`
- Create: `packages/eqmonitor_map/test/foundation/performance/map_performance_collector_test.dart`

**Interfaces:**
- Consumes: Task 13 policy/events.
- Produces: `MapPerformanceCollector.record({required int frameSequence, required MapPerformanceEvent event})`, `takeSnapshot({required Duration monotonicNow})`, `drainEvents()`.

- [ ] **Step 1: bounded / deterministic behavior の failing test を書く**

```dart
test('samples deterministically, rate limits by finite event kind, and stays bounded', () {
  final collector = MapPerformanceCollector(policy: policy, windowStartedAt: Duration.zero);
  for (var frame = 0; frame < 20; frame++) {
    collector.record(frameSequence: frame, event: eventAt(frame));
  }
  expect(collector.bufferedEventCount, lessThanOrEqualTo(policy.eventBufferCapacity));
  final snapshot = collector.takeSnapshot(monotonicNow: const Duration(seconds: 2));
  expect(snapshot?.sampledOutCount, greaterThan(0));
  expect(snapshot?.rateLimitedCount, greaterThan(0));
});
```

dropOldest/dropNewest双方、snapshot interval前はnull、drain後0、monotonic逆行rejectを検証する。

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/performance/map_performance_collector_test.dart`

Expected: FAIL（collector未定義）。

- [ ] **Step 3: 有界collectorを実装する**

`ListQueue<MapPerformanceEvent>` をcapacity以下に維持し、samplingは `frameSequence % sampleEveryNFrames == 0`、rate limitは有限enum kindごとの最後のaccepted monotonicだけで判定する。snapshotはpolicy interval到達時だけ immutable counter snapshotを返してwindow countersをresetする。StreamControllerやtimerを所有しない。

```dart
bool record({
  required int frameSequence,
  required MapPerformanceEvent event,
}) {
  if (frameSequence % policy.sampleEveryNFrames != 0) {
    sampledOutCount++;
    return false;
  }
  final previous = lastAcceptedByKind[event.kind];
  if (previous != null && event.monotonicAt - previous < policy.eventMinInterval) {
    rateLimitedCount++;
    return false;
  }
  lastAcceptedByKind[event.kind] = event.monotonicAt;
  if (events.length == policy.eventBufferCapacity) {
    droppedCount++;
    if (policy.dropPolicy == MapPerformanceDropPolicy.dropNewest) return false;
    events.removeFirst();
  }
  events.addLast(event);
  acceptedCount++;
  return true;
}
```

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/src/foundation/performance/map_performance_collector.dart test/foundation/performance/map_performance_collector_test.dart
mise exec -- flutter test test/foundation/performance
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/src/foundation/performance packages/eqmonitor_map/test/foundation/performance
git commit -m "Feat: 性能eventを有界に集約"
git push
```

### Task 15: public API compile gate と参照知見を追加する

**Files:**
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `packages/eqmonitor_map/README.md`
- Create: `packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart`
- Create: `docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md`

**Interfaces:**
- Produces: `package:eqmonitor_map/eqmonitor_map.dart` だけから全foundation interfaceを利用可能にする。

- [ ] **Step 1: public importだけの failing compile testを書く**

```dart
import 'package:eqmonitor_map/eqmonitor_map.dart';

test('exports the scene, frame, revision, render, and performance contracts', () {
  final key = MapNodeKey('public-node');
  final phase = MapRenderPhasePolicy(
    version: 1,
    orderedPhases: [MapRenderPhaseId('base'), MapRenderPhaseId.labelForeground],
  );
  expect(key.value, 'public-node');
  expect(phase.rankOf(phase: MapRenderPhaseId.labelForeground), 1);
  expect(MapRevisionCommitStore<List<int>>(), isNotNull);
});
```

- [ ] **Step 2: RED を確認する**

Run: `cd packages/eqmonitor_map && mise exec -- flutter test test/foundation/foundation_public_api_test.dart`

Expected: FAIL（src型がpackage entrypointから未export）。

- [ ] **Step 3: export と文書を実装する**

`eqmonitor_map.dart`へfoundation/frame/revision/render/performanceと `map_render_batch_adapter.dart` のexportを追加する。READMEはfoundation完了範囲と後続境界を更新する。knowledgeには KEVi pin、dashmap pin、採用/不採用、caller-supplied phase policy、single clock capture、generic revision store、fake adapter verification commandを具体的に記録する。未完了項目を既存TODOから消す場合は、このbranchで実装した範囲だけに限定する。

```dart
export 'src/foundation/map_element.dart';
export 'src/foundation/map_node.dart';
export 'src/foundation/map_scene.dart';
export 'src/foundation/frame/map_clock.dart';
export 'src/foundation/frame/map_frame_snapshot.dart';
export 'src/foundation/performance/map_performance.dart';
export 'src/foundation/performance/map_performance_collector.dart';
export 'src/foundation/render/map_packed_mesh.dart';
export 'src/foundation/render/map_render_batch.dart';
export 'src/foundation/render/map_render_phase.dart';
export 'src/foundation/render/map_render_sort_key.dart';
export 'src/foundation/revision/map_revision.dart';
export 'src/foundation/revision/map_revision_commit_store.dart';
export 'src/renderer/map_render_batch_adapter.dart';
```

- [ ] **Step 4: GREEN と commit**

```bash
cd packages/eqmonitor_map
mise exec -- dart format lib/eqmonitor_map.dart test/foundation/foundation_public_api_test.dart
mise exec -- flutter test test/foundation/foundation_public_api_test.dart
cd ../..
git diff --check
git add packages/eqmonitor_map/lib/eqmonitor_map.dart packages/eqmonitor_map/README.md packages/eqmonitor_map/test/foundation/foundation_public_api_test.dart docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git commit -m "Feat: 地図foundation公開APIを確定"
git push
```

### Task 16: package全体と既存BaseMapの回帰を検証する

**Files:**
- Modify only if evidence requires: files introduced by Tasks 1–15

**Interfaces:**
- Verifies: public compile、Scene import isolation、BaseMap、全package test/analyze。device/simulator/golden/E2Eは実行しない。

- [ ] **Step 1: generated/format差分を確定する**

```bash
cd packages/eqmonitor_map
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format lib test
cd ../..
git diff --check
```

- [ ] **Step 2: public / foundation / BaseMap regression を実行する**

```bash
cd packages/eqmonitor_map
mise exec -- flutter test --no-pub test/foundation test/renderer/map_render_batch_adapter_contract_test.dart
mise exec -- flutter test --no-pub test/widget/base_map_view_test.dart test/tile/base_map_render_plan_builder_test.dart test/tile/base_map_tile_decoder_test.dart test/geo/tile_matrix_test.dart
```

Expected: 全PASS。既存BaseMapのextent/fallback/camera経路を変更しない。

- [ ] **Step 3: Flutter Scene import isolationを検証する**

```bash
cd packages/eqmonitor_map
if rg -n "package:flutter_scene" lib/src/foundation lib/src/renderer/map_render_batch_adapter.dart; then exit 1; fi
```

Expected: matchなし、exit 0。

- [ ] **Step 4: full package analyze/testを実行する**

```bash
cd packages/eqmonitor_map
mise exec -- flutter analyze --no-pub
mise exec -- flutter test --no-pub
cd ../..
git status --short
git --no-pager diff --stat origin/fix/eqmonitor-map-base-layer-residuals...HEAD
```

Expected: analyze clean、全test PASS。app全体analyzeの既存2,852 warningをこのbranchの合否へ混ぜず、appファイルを変更していないことをdiffで確認する。

- [ ] **Step 5: verificationで必要になった変更だけcommitする**

```bash
git diff --check
git add packages/eqmonitor_map docs/knowledge/20260809_eqmonitor_map_foundation_contracts.md
git diff --cached --quiet || git commit -m "Test: 地図foundationの回帰検証を確定"
git push
git status --short --branch
```

Expected: worktree clean、local HEADと`origin/feat/eqmonitor-map-foundation`一致。
