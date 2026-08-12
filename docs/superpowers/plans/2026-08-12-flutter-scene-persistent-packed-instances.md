# Flutter Scene Persistent Packed Instances Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> `superpowers:subagent-driven-development` to implement this plan task-by-task.
> Steps use checkbox (`- [ ]`) syntax for tracking. Use `gh-stack` only with
> non-interactive flags and stop after every PR in this plan has been created.

**Goal:** Issue #1602 向けに、static packed instance data を一度だけ GPU へ
upload し、GPU submission 完了まで安全に retire できる汎用 Geometry を
`YumNumm/flutter_scene` fork へ追加する。EQMonitor は公開 API だけを使い、fork の
immutable commit SHA へ依存を固定する。

**Architecture:** process-global な Flutter GPU context、submission tracker、renderer と
1対1の registry が context generation/state を所有し、複数 lifecycle owner は同じ global
state を観測する。その registry 上に immutable な 2-stream Geometry を積み、base vertex と
instance record は persistent device buffer へ初回だけ書く。描画時は bind と小さな
`FrameInfo` uniform 更新だけを行い、data change は Scene 差し替えと旧 resource retire で表す。

**Tech Stack:** Flutter `4dacd3fc91d96262a33e5c598e17d816f0b35641`
(3.47.0-1.0.pre-97)、Dart 3.14.0-29.0.dev、Flutter GPU/Impeller、
Flutter Scene `7f71993b7e2a0ab1d2f59726a406098709be7291`、Dart/Flutter test、
`mise exec --`、`gh stack`。

## Global Constraints

- fork implementation base は exact
  `7f71993b7e2a0ab1d2f59726a406098709be7291`、Flutter は exact
  `4dacd3fc91d96262a33e5c598e17d816f0b35641`。floating branch/tag を dependency に使わない。
- Flutter/Dart command は常に `mise exec --`、fork checkout では exact Flutter tool argument
  を付けた `mise exec flutter@4dacd3fc... --` で実行する。
- GPU context generation/state は owner 単位に分裂させない。1 owner の invalidation が同 generation
  の全 owner resource を fail-closed にし、global retirement 完了まで recreate を拒否する。
- registry、Scene render、GPU completion callback、lifecycle、Geometry は同じ Dart isolate から
  操作する。cross-isolate transfer、lock、background-isolate GPU call を設計に入れない。
- per-frame instance upload/full scan、`InstancedMesh` matrix pack、固定 delay、固定 frames-in-flight、
  error 時の標準 Geometry fallback は禁止する。
- `DeviceBuffer` reference release と driver resident-memory 解放を区別し、後者を保証しない。
- fork API は generic packed Geometry と lifecycle に限定する。震源固有の24-byte schema、shader LOD、
  color/radius は #1604 の consumer に残す。
- 実機、Simulator、all-E2E は今回実行しない。#1604 の物理 iPhone 13 相当 30fps/5分 memory gate は
  defer と明記し、non-device test を代替証拠にしない。
- 各 implementation Task は30–100 handwritten production+test linesを目安に、RED→GREEN→1 commit→
  push で閉じる。生成 lockfile 行はこの handwritten budget から除く。
- user の既存 checkout/dirty changes を変更しない。worktree target/branch/remote が曖昧なら停止する。

---

## 1. 現在地と監査結果（2026-08-12）

- 計画 branch は最新 `origin/develop` の
  `8120f23446b53f4b3222d32306d4fb576cb9683e` から作る。
- Issue #1602 は parent #1612 の layer 06。後続 #1603 は scene foundation、#1604 は
  200万件 static renderer、#1605 は app integration であり、この変更へ混ぜない。
- `packages/eqmonitor_map/pubspec.yaml` の `flutter_scene` と override `scene`、root
  `pubspec.lock` の両 package は現在すべて `bdero/flutter_scene` の `7f71993...`。
- 同じ SHA は `packages/eqmonitor_map/example/pubspec.yaml`、package/example README、
  toolchain/source-pin knowledge にも存在する。fork pin PR で現役の正本を同時更新する。
- `bdero/flutter_scene` の現行 master は
  `ed04205c10991739338fde19563bcf2698057755`。`BillboardGeometry.bind` は現在も毎 draw
  `instanceTransients.emplace(liveBytes)` し、`InstancedMesh` は `List<Matrix4>` を
  per-frame pack するため、#1602 の経路には使えない。
- 現行 master の `2d4decc72e8ee965dbc0995ea678aae9f0405203` には
  `ResourceGroup.release` と engine cache の memory report があるが、任意 Geometry の
  buffer retirement、context generation、即時 GPU 解放は提供しない。
- pin 済み `7f71993...` にも `GpuSubmissionTracker` と全 renderer command buffer の
  `rendererSubmissions.submit(...)` 経路は存在する。新規 fence を並立させず、これを
  completion-aware retirement の正本にする。
- Flutter GPU の `DeviceBuffer` に明示 `dispose` はない。retire の保証は「完了前に
  Dart reference を落とさない」「完了後に reference を落とす」までであり、driver が
  実メモリを即時返すとは記述しない。
- `YumNumm/flutter_scene` は現時点で GitHub 上に存在しない。namespace への repo/fork
  作成権限は確認できないため、作成は実装開始前の明示 prerequisite とする。
- #1612 が参照する
  `docs/superpowers/specs/2026-08-07-eqmonitor-map-seismicity-github-issues.md` は
  local/remote refs のどちらにも存在しない。Issue 本文と現存 design/delivery docs を
  current contract とし、この provenance gap は各 PR の Remaining tasks に残す。

## 2. 参考実装から採用する境界

- `bdero/dashmap` `a6ff92edd999e922f81d26d209d8f589faee3fd0` は MIT。
  `package:flutter_scene/scene.dart` / `gpu.dart` の curated public import、pure projection と
  Scene adapter の分離を参考にする。一方、tile unload の GPU dispose は TODO のため、
  その lifecycle を完成例として流用しない。
- ユーザー指定の `ingen084/KyoshinEewViewer` は存在せず、検索で確認できた対象は MIT の
  `ingen084/KyoshinEewViewerIngen`
  `23c91f26c0f3bbc47320bf87b409182002e388fa`。点集合を immutable snapshot として一括
  差し替え、projection cache を data revision 単位で再利用する考え方だけを参考にする。
- いずれの repository からもソースを copy しない。copy が必要になった場合は、その場で
  MIT notice の要否を再確認し、無記録で取り込まない。

### 採用案と棄却案

1. **採用: exact pin の compatibility branch に generic API を積む。** EQMonitor で既に compile/
   smoke 実績がある Flutter `4dacd3fc...` + Scene `7f71993...` を保ち、必要な API だけを小さく
   review できる。後続 stack が参照する SHA も一意になる。
2. **棄却: bdero current master へ直接実装する。** upstream の cache memory API は利用できるが、
   EQMonitor pin 以降の多数の変更と current Flutter master 要件を同時に取り込むため、#1602 の
   static instance 差分と互換性リスクを分離できない。forward-port は fork完成後の別PRにする。
3. **棄却: EQMonitor adapter で Flutter Scene internal GPU API を呼ぶ。** 最短でも fork upgrade ごとに
   private symbol へ追従し、Issue の public API 条件を破る。`flutter_gpu` buffer を app が直接所有
   する案も同じ理由で採らない。
4. **棄却: per-frame billboard/InstancedMesh、chunking、固定 frames-in-flight。** 200万件の再pack/
   upload または CPU matrix memory を残し、GPU completion を時間・frame数で推測するため、性能と
   lifecycle の必須条件を満たさない。

この選択により fork の API は「汎用2-stream packed Geometry + lifecycle」に限定し、震源の座標、
色、LOD、24-byte record schema は #1604 の EQMonitor consumer 側に残す。

## 3. 固定する公開 API と不変条件

`package:flutter_scene/scene.dart` から次だけを export する。EQMonitor は
`package:flutter_scene/src/...`、`package:flutter_gpu/...`、internal annotation 付き API を
import/call しない。

```dart
enum PersistentGpuContextState { active, invalidating, invalidated, failed }
enum PersistentGpuResourceLifecycleState { active, disposed }
enum PersistentGpuResourceState {
  active,
  retirementPending,
  retired,
  retirementFailed,
}

final class PersistentGpuMemoryUsage {
  const PersistentGpuMemoryUsage({
    required this.activeResourceCount,
    required this.retiringResourceCount,
    required this.failedResourceCount,
    required this.activeTotalBytes,
    required this.retiringTotalBytes,
    required this.failedTotalBytes,
    required this.activeInstanceBytes,
    required this.retiringInstanceBytes,
    required this.failedInstanceBytes,
  });
  final int activeResourceCount;
  final int retiringResourceCount;
  final int failedResourceCount;
  final int activeTotalBytes;
  final int retiringTotalBytes;
  final int failedTotalBytes;
  final int activeInstanceBytes;
  final int retiringInstanceBytes;
  final int failedInstanceBytes;
}

final class PersistentGpuMemorySnapshot {
  final PersistentGpuContextState contextState;
  final PersistentGpuResourceLifecycleState lifecycleState;
  final int contextGeneration;
  final int latestSubmission;
  final int completedThrough;
  final PersistentGpuMemoryUsage global;
  final PersistentGpuMemoryUsage owner;
}

final class PersistentGpuResourceLifecycle {
  PersistentGpuResourceLifecycle();
  int get contextGeneration;
  PersistentGpuContextState get contextState;
  PersistentGpuResourceLifecycleState get state;
  PersistentGpuMemorySnapshot takeMemorySnapshot();
  Future<void> invalidateContext();
  void recreateContext();
  Future<void> dispose();
}

final class PersistentPackedInstanceGeometry extends Geometry {
  PersistentPackedInstanceGeometry({
    required PersistentGpuResourceLifecycle lifecycle,
    required ByteData vertexData,
    required int vertexCount,
    ByteData? indexData,
    gpu.IndexType indexType = gpu.IndexType.int16,
    required ByteData instanceData,
    required int instanceCount,
    required VertexLayoutDescriptor vertexLayout,
    required gpu.Shader vertexShader,
    required vm.Aabb3 localBounds,
    required bool doubleSided,
  });

  int get instanceCount;
  int get instanceStrideInBytes;
  int get contextGeneration;
  PersistentGpuResourceState get resourceState;
  Future<void> retire();
}
```

`PersistentGpuResourceLifecycle` は owner handle であり context owner ではない。public constructor
は process-global registry へ新 owner を attach する。test-only `@internal` constructor だけが
injected registry を受け取る。すべての owner の `contextState` / `contextGeneration` / `global`
snapshot は常に同じ値で、`owner` usage だけが handle ごとに異なる。

API review 中に引数名を変える場合も、次の semantics は変えない。

1. layout は slot 0 vertex、slot 1 instance の exactly 2 buffers。buffer/attribute List と
   mutable `Aabb3` は constructor 冒頭で deep snapshot し、caller の後続 mutation を反映しない。
2. count、stride、attribute offset、byte length、alignment、finite bounds、index width/value を
   upload 前に検証する。empty/negative/overflow は `ArgumentError`、fallback は行わない。
3. allocation policy は1 buffer/total logical allocation とも最大 `0x7fffffff` bytes。multiply、
   16-byte align、add は除算による checked arithmetic を先に行い、overflow 後の値を使わない。
4. base vertex と instance は同じ non-index host-visible buffer、instance offset は16-byte aligned。
   index は WebGL duplicate を避けるため別 buffer。source bytes は各1回 overwrite/1回 flush 後に
   保持せず、superclass private buffer field にも格納しない。
5. bind は persistent views と小さい `FrameInfo` だけ。instance transient、camera change upload、
   per-frame full scan を禁止する。data change は new geometry attach → old detach → old retire。
6. Geometry は `bindsModelTransformInstance == false`、独自 material variant を使う。nested
   `InstancedMesh` から `draw(instanceCount != 1)` された場合は `StateError` で fail closed。
7. resource record は open-frame use と last submitted id を別々に持つ。bind後retireは次 submit の
   stamp、または endFrame no-submit の確定まで reference を保持する。
8. generation は process-global で1から開始。任意 owner の invalidation は global state を即時
   `invalidating` にして全 owner の current-generation resource を retire し、全件 settle 後だけ
   `invalidated`。recreate はその後に1回だけ generationを増やす。
9. release callback failure は global `failed`。残る retirement は継続するが bind/register/recreate
   は拒否し、process/Scene 再構築以外で回復したと推測しない。
10. snapshot bytes は registry が保持する logical references。global/owner と active/retiring/failed、
    total/instance を分け、driver resident bytes や即時 reclaim と表現しない。

## 4. Required state machines

### Allocation record and open-frame table

Internal record states are `active`, `retirementPendingOpenFrame`,
`retirementPendingSubmission`, `releasing`, `retired`, `retirementFailed`。public state は2つの pending
を `retirementPending` に collapse する。

| current | event / guard | next | required effect |
|---|---|---|---|
| active | `markUsed`, frame open/current generation | active + open mark | future bind以外の state は変えない |
| active | `retire`, open markあり | pendingOpenFrame | 同一 cached retire Future、reference保持 |
| pendingOpenFrame | before-submit(id) | pendingSubmission | markを消し `lastSubmission=id`、reference保持 |
| pendingOpenFrame | endFrame、submitなし | releasing または pendingSubmission | markを消し、過去in-flightがなければrelease |
| active | before-submit後 | active + submitted id | `lastSubmission=max(old,id)` |
| active | completion後に初めてretire | releasing | watermark済みなので即release開始 |
| pendingSubmission | completion < lastSubmission | pendingSubmission | releaseしない |
| pendingSubmission | completion >= lastSubmission | releasing | callbackをちょうど1回呼ぶ |
| releasing | reentrant/repeated retire | releasing | identical Future、callback再実行なし |
| releasing | callback success | retired | accountingから除外後にFuture success |
| releasing | callback throws | retirementFailed | bytesをfailed accountingへ、global failed、Future error |
| retired/failed | repeated retire | same | original identical Futureを返す |

`beginFrame` は frame closed のときだけ成功し、nested begin は `StateError`。`endFrame` は open の
ときだけ成功し `finally` から必ず1回呼ぶ。before-submit は pendingOpenFrame も stamp するため、
bind → retire → submit の command buffer が completion 前に解放されない。global invalidation が
open frame 中に起きた場合も全 mark は pendingOpenFrame となり、後続 `markUsed` は拒否するが、
既に encode 済み command の before-submit/endFrame 処理は継続する。

completion listener は tracker pending set を更新し watermark を計算した後、listener snapshot を
registration順に呼ぶ。unknown/duplicate id は通知しない。registry は release callback の前に
`releasing` を設定し、callback success/failure と accounting 更新後に resource Future、owner
dispose Future、global invalidate Future の順で settle する。

### Public owner operation × global state table

owner `dispose()` は global context disposal ではない。global state は process-wide、owner state は
`active`/`disposed` のみ。`FI` は generationごとの cached invalidate Future、`FD` は ownerごとの
cached dispose Future、`FE` は disposed owner の cached invalid-operation error Future とする。

| owner | global | operation | result / next state |
|---|---|---|---|
| active | active | `invalidateContext()` | global→invalidating、全owner resource retire、`FI` |
| active | invalidating | `invalidateContext()` | mutationなし、identical `FI` |
| active | invalidated | `invalidateContext()` | mutationなし、完了済み identical `FI` |
| active | failed | `invalidateContext()` | mutationなし、error完了済み identical `FI` |
| disposed | any | `invalidateContext()` | global mutationなし、repeated callでidentical `FE` |
| active | invalidated | `recreateContext()` | failed record 0 を再確認、generation +1、global→active |
| active | active | `recreateContext()` | synchronous `StateError`、generation不変 |
| active | invalidating | `recreateContext()` | synchronous `StateError`、retirement継続 |
| active | failed | `recreateContext()` | synchronous `StateError`、process再構築を要求 |
| disposed | any | `recreateContext()` | synchronous `StateError` |
| active | active | `dispose()` | owner→disposed、owner resourceのみretire、`FD` |
| active | invalidating | `dispose()` | owner→disposed、global retireと共有、owner分settleで`FD` |
| active | invalidated | `dispose()` | owner→disposed、完了済み `FD` |
| active | failed | `dispose()` | owner→disposed、残存owner record settle/error後 `FD` |
| disposed | any | `dispose()` | mutationなし、identical `FD` |
| either | any | `takeMemorySnapshot()` | read-only、disposed ownerもfinal owner/global usageを取得可 |
| new owner | active | public constructor | ownerをattachしactive handleを返す |
| new owner | invalidating/invalidated/failed | public constructor | synchronous `StateError`、ownerを作らない |
| either | any | state/generation getters | read-only、owner stateとshared global valuesを返す |

`FI` は同じ generation ではどの owner から取得しても `identical`。recreate 後の次 invalidation は
新しい `FI`。`FD` は owner 固有で `FI` とは別 object。dispose during invalidation は global
invalidation をcancelせず、`FD` が先に完了しても `FI` は他 owner を待つ。1 owner の callback
failure は global→failed とし、`FI`/該当 `FD` は全 records settle 後に同じ最初の errorで完了する。
Future-returning public/internal methodsは `async` にせず cached Futureを直接returnする。これにより
完了値だけでなく `identical` identityも契約に含める。

release callback から `retire()`、`dispose()`、`invalidateContext()`、snapshot を reentrant に
呼べるが、stateを callback 前に進めてあるため二重releaseしない。callback/reentrant operation が
別 error を投げた場合は最初の release error を context failure cause とし、後続 error は
`Object.hash` 等で潰さず test log 用 list に順序保持する。production release callback は nullable
buffer views を clear する同期 no-throw closure に限定する。

## 5. File responsibility map

### YumNumm/flutter_scene bottom PR

- `lib/src/render/frame_transients.dart`: submission id、before-submit、completion watermark 通知。
- `lib/src/render/persistent_gpu_resource_models.dart`: public enums、usage/snapshot immutable values。
- `lib/src/render/persistent_gpu_execution_affinity.dart`: same-isolate check と mutation reentrancy guard。
- `lib/src/render/persistent_gpu_resource_registry.dart`: global generation/state、owner/record accounting、
  frame marks、submission stamps、retirement/failure completion。
- `lib/src/render/persistent_gpu_resource_lifecycle.dart`: public owner handle と operation state machine。
- `lib/src/scene.dart`: registry `beginFrame`/`endFrame` を render frame の `try/finally` に接続。
- `lib/scene.dart`: curated public lifecycle exports。
- `test/render/gpu_submission_tracker_test.dart`: tracker ordering/listener tests。
- `test/render/persistent_gpu_resource_registry_test.dart`: record/frame/submission/failure state tests。
- `test/render/persistent_gpu_resource_lifecycle_test.dart`: multi-owner operation transition tests。

### YumNumm/flutter_scene top PR

- `lib/src/geometry/persistent_packed_instance_plan.dart`: defensive copy、checked arithmetic、layout/bounds/
  index validation、immutable upload plan。
- `lib/src/geometry/persistent_packed_instance_storage.dart`: one-shot device allocation/write/flush と
  nullable views release。
- `lib/src/geometry/persistent_packed_instance_geometry.dart`: public Geometry、lifecycle lease、bind/draw。
- `lib/src/material/shader_stage.dart`: exact persistent packed material variant。
- `lib/src/material/shader_material.dart`: variant lookup without unskinned collapse。
- `lib/scene.dart` / `README.md`: curated Geometry export と consumer contract。
- `test/persistent_packed_instance_plan_test.dart`: all input/mutation/overflow/index validation。
- `test/persistent_packed_instance_storage_test.dart`: write count/failure/release、GPU-gated upload。
- `test/persistent_packed_instance_geometry_test.dart`: state/bind/draw/material behavior。
- `test/persistent_packed_instance_public_api_test.dart`: public-import-only compile contract。

### YumNumm/EQMonitor pin PR

- `packages/eqmonitor_map/pubspec.yaml`, `packages/eqmonitor_map/example/pubspec.yaml`, `pubspec.lock`:
  one fork URL/full SHA across flutter_scene and scene。
- `tool/verify_flutter_scene_pin.sh`, `scripts/ci/test_verify_flutter_scene_pin.sh`: machine-readable 3 descriptor
  + 2 lock entry assertion。
- `packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart`: resolved fork API check。
- package/example README と既存3 knowledge docs: live SHA/provenance/lifecycle boundaries。

大きな registry/validation/Geometry file を1 task で完成させない。後述 task はこの責務境界を保ち、
隣接 task が使う signature を各 `Interfaces` block で固定する。

## 6. Repository と PR stack

repository を跨ぐ branch は GitHub 上の1本の stack にできない。次の2 stack と immutable
SHA hand-off を使う。

```text
YumNumm/flutter_scene
eqmonitor/flutter-4dacd3fc (7f71993..., compatibility trunk; PRなし)
└─ feat/persistent-gpu-lifecycle
   └─ feat/persistent-packed-instance-geometry
                                      ┐
                                      └─ top commit SHAを固定
YumNumm/EQMonitor
... → PR #1620 feat/seismicity-pmtiles-decoder
      └─ feat/seismicity-flutter-scene-fork-pin
```

fork の current master へ直接実装しない。master は upstream current のまま保持し、EQMonitor の
既存 toolchain と既存 pin を再現する compatibility trunk を `7f71993...` に作る。上流 master
への forward-port は #1602 の completion 条件にせず、別 follow-up として記録する。

## 7. Execution prerequisites（commitを作らないgate）

### Gate A: fork authority — unresolvedなら必ず停止

この plan は repository/namespace 作成権限を含まない。owner/admin が GitHub UI 等で
`YumNumm/flutter_scene` を `bdero/flutter_scene` の fork として作成した後だけ続行する。
agent は `gh repo fork` / `gh repo create` を実行しない。

```bash
gh repo view YumNumm/flutter_scene \
  --json nameWithOwner,parent,defaultBranchRef,viewerPermission \
  --jq 'select(.parent.nameWithOwner == "bdero/flutter_scene") |
        select(.viewerPermission == "ADMIN" or .viewerPermission == "MAINTAIN" or
               .viewerPermission == "WRITE")'
```

0件/errorなら authority blocker を報告して停止する。代替 repo や user fork を推測しない。

### Gate B: non-destructive clone/remotes/worktree

clone target が存在しない場合だけ cloneし、既存ならexact originをassertする。

```bash
fork_clone=/Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene
if [ -e "$fork_clone" ]; then
  test "$(git -C "$fork_clone" rev-parse --is-inside-work-tree)" = true
  test "$(git -C "$fork_clone" remote get-url origin)" = \
    git@github.com:YumNumm/flutter_scene.git
else
  git clone --origin origin git@github.com:YumNumm/flutter_scene.git "$fork_clone"
fi
```

dirtyでも user change を触らず、worktree追加だけに留める。non-git/wrong originなら停止する。
`upstream` が未登録の場合だけ追加し、登録済みなら exact URL をassertする。

```bash
if upstream_url=$(git -C "$fork_clone" remote get-url upstream 2>/dev/null); then
  test "$upstream_url" = https://github.com/bdero/flutter_scene.git
else
  git -C "$fork_clone" remote add upstream https://github.com/bdero/flutter_scene.git
fi
git -C "$fork_clone" fetch upstream master
git -C "$fork_clone" \
  cat-file -e 7f71993b7e2a0ab1d2f59726a406098709be7291^{commit}
```

fork は `.worktrees` をignoreしないため nested worktreeを作らない（次はexit 1が期待値）。

```bash
git -C /Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene \
  check-ignore -q .worktrees
```

compatibility remote branch が既存なら exact SHA をassertし、異なれば停止する。未作成の場合だけ
new refをpushする。force pushは禁止。

```bash
if remote_line=$(git -C "$fork_clone" ls-remote --exit-code origin \
  refs/heads/eqmonitor/flutter-4dacd3fc); then
  test "${remote_line%%[[:space:]]*}" = \
    7f71993b7e2a0ab1d2f59726a406098709be7291
else
  remote_status=$?
  test "$remote_status" -eq 2
  git -C "$fork_clone" push origin \
    7f71993b7e2a0ab1d2f59726a406098709be7291:refs/heads/eqmonitor/flutter-4dacd3fc
fi
git -C "$fork_clone" fetch origin \
  '+refs/heads/*:refs/remotes/origin/*'
test "$(git -C "$fork_clone" rev-parse origin/eqmonitor/flutter-4dacd3fc)" = \
  7f71993b7e2a0ab1d2f59726a406098709be7291
```

上のpushは remote ref不存在のexit 2 routeだけ。その他のerrorは `test` で停止する。local
compatibility branchも未作成の場合だけremote tracking branchとして作り、既存ならexact SHAをassertする。

```bash
if git -C "$fork_clone" show-ref --verify --quiet \
  refs/heads/eqmonitor/flutter-4dacd3fc; then
  test "$(git -C "$fork_clone" rev-parse eqmonitor/flutter-4dacd3fc)" = \
    7f71993b7e2a0ab1d2f59726a406098709be7291
else
  git -C "$fork_clone" branch --track eqmonitor/flutter-4dacd3fc \
    origin/eqmonitor/flutter-4dacd3fc
fi
```

worktree は fork clone の外に固定する。target が存在しない場合、branch も未作成なら `-b` route、
branch だけ存在する resume なら branch をそのまま attach する。target が存在する場合は追加・削除
せず、registered path、branch、origin、clean state をassertする。mismatch/dirtyなら停止し、
`worktree remove`、`branch -D`、reset、checkout、force pushは行わない。

```bash
mkdir -p /Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees
fork_worktree=/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
if [ -e "$fork_worktree" ]; then
  git -C "$fork_clone" worktree list --porcelain | \
    rg -F "worktree $fork_worktree"
elif git -C "$fork_clone" show-ref --verify --quiet \
  refs/heads/feat/persistent-gpu-lifecycle; then
  git -C "$fork_clone" worktree add "$fork_worktree" \
    feat/persistent-gpu-lifecycle
else
  git -C "$fork_clone" worktree add -b feat/persistent-gpu-lifecycle \
    "$fork_worktree" eqmonitor/flutter-4dacd3fc
fi
test "$(git -C "$fork_worktree" remote get-url origin)" = \
  git@github.com:YumNumm/flutter_scene.git
test "$(git -C "$fork_worktree" rev-parse --abbrev-ref HEAD)" = \
  feat/persistent-gpu-lifecycle
git -C "$fork_worktree" \
  merge-base --is-ancestor 7f71993b7e2a0ab1d2f59726a406098709be7291 HEAD
test -z "$(git -C "$fork_worktree" status --porcelain=v1)"
git -C "$fork_clone" config rerere.enabled true
git -C "$fork_clone" config remote.pushDefault origin
cd "$fork_worktree"
gh stack init --base eqmonitor/flutter-4dacd3fc feat/persistent-gpu-lifecycle
```

`gh stack init` は branch が stack metadata 未登録の場合だけ実行する。既存登録時は
`gh stack view --json` で base が `eqmonitor/flutter-4dacd3fc` と一致することをassertし、metadataを
上書きしない。bottom の Task 1 から開始し、top worktree/branchは bottom PR 作成後の delivery
gate で同じ non-destructive 分岐を使って追加する。

### Gate C: pinned toolchain と baseline

fork 自体は Flutter を pin していないため、全 Flutter/Dart command は EQMonitor と同じ exact
tool version を指定する。

```bash
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter --version --machine
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter pub get
cd packages/flutter_scene
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter test --enable-impeller test/render/frame_transients_test.dart
```

version JSON の framework SHA が `4dacd3fc91d96262a33e5c598e17d816f0b35641` でなければ中断する。
baseline failure は既存失敗と今回差分を分離して PR body に記録し、成功扱いにしない。実機、
Simulator、smoke-render E2E は今回のユーザー指定により実行しない。fork実装Taskの shell snippet
は上記 worktree の `packages/flutter_scene` から開始する。

## 8. Implementation tasks

各 Task は fresh subagent 1名へその Task だけを渡し、完了後に別 subagent が spec compliance、
さらに別 subagent が code quality を reviewする。指摘修正と再reviewまで同じ Task 内で閉じる。
実装経路は `superpowers:subagent-driven-development` だけを使い、`executing-plans` と併用しない。
fork Task はすべて
`/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle/packages/flutter_scene`
で実行し、各 commit の handwritten production+test 差分を `git --no-pager diff --stat HEAD^` で
30–100行と確認する。範囲を超えたら責務を混ぜず次 Task へ分ける。

### Task 1: completion watermark listener（fork bottom、依存なし）

**Files:** Modify `lib/src/render/frame_transients.dart`; Create
`test/render/gpu_submission_tracker_test.dart`。

**Interfaces:** Produces
`void GpuSubmissionTracker.addCompletionListener(void Function(int completedThrough) listener)`。
listener は registration 順の snapshot で呼び、record/before-submit listener の既存 signature は維持する。

- [ ] **Step 1 — RED:** 次の body を追加する。`record()` は `a=1,b=2`、`complete(b)` は通知せず、
  `complete(a)` は `['first:2','second:2']`、duplicate/unknown は追加通知なしを期待する。

  ```dart
  test('completion listeners observe the contiguous watermark in order', () {
    final tracker = GpuSubmissionTracker();
    final seen = <String>[];
    tracker.addCompletionListener((value) => seen.add('first:$value'));
    tracker.addCompletionListener((value) => seen.add('second:$value'));
    final a = tracker.record();
    final b = tracker.record();
    tracker.complete(b);
    expect(seen, isEmpty);
    tracker.complete(a);
    expect(seen, ['first:2', 'second:2']);
    tracker..complete(a)..complete(999);
    expect(seen, ['first:2', 'second:2']);
  });
  ```

- [ ] **Step 2 — verify RED:** `mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/gpu_submission_tracker_test.dart`。
  expected RED は `addCompletionListener` が未定義。
- [ ] **Step 3 — GREEN:** `_completionListeners` を追加し、`complete` が pending id を実際に削除し、
  かつ contiguous watermark が前値より進んだ時だけ更新後値を snapshot iteration で通知する。
- [ ] **Step 4 — verify:** 上記 focused test と既存 `test/render/frame_transients_test.dart` を通し、
  `git --no-pager diff --check` を通す。
- [ ] **Step 5 — publish:** `git add lib/src/render/frame_transients.dart test/render/gpu_submission_tracker_test.dart && git commit -m 'Feature: GPU submission完了通知を追加' && git push`。

### Task 2: public value models と same-isolate guard（fork bottom、depends Task 1）

**Files:** Create `lib/src/render/persistent_gpu_resource_models.dart`,
`lib/src/render/persistent_gpu_execution_affinity.dart`,
`test/render/persistent_gpu_resource_models_test.dart`。

**Interfaces:** Produces section 3 の3 enum/2 immutable value class、および internal
`PersistentGpuExecutionAffinity({Object Function()? currentIsolateToken})`、`void check()`。
production default は `Isolate.current.controlPort` をtokenとしてcaptureし `==` 比較、testは可変fake
tokenを注入する。hash collisionをsame-isolate証拠に使わない。

- [ ] **Step 1 — RED:** immutable usage/snapshot の全 field を exact 値で比較する test と次の guard test
  を追加する。

  ```dart
  test('rejects a registry mutation from a different isolate identity', () {
    var isolateToken = Object();
    final affinity = PersistentGpuExecutionAffinity(
      currentIsolateToken: () => isolateToken,
    );
    affinity.check();
    isolateToken = Object();
    expect(affinity.check, throwsStateError);
  });
  ```

- [ ] **Step 2 — verify RED:** pinned `flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart`。
  expected RED は両 type file/import が存在しない。
- [ ] **Step 3 — GREEN:** public values は全 field `final`/`const`、guard は生成 isolate id と現在値を
  error に含める。lock、SendPort、cross-isolate transfer は追加しない。
- [ ] **Step 4 — verify:** focused test、`mise exec ... -- dart analyze lib/src/render test/render`、
  `git --no-pager diff --check`。
- [ ] **Step 5 — publish:** 3 files を addし
  `git commit -m 'Feature: GPU resource状態値を追加' && git push`。

### Task 3: resource registration と owner accounting（fork bottom、depends Task 2）

**Files:** Create `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces internal
`int attachOwner()`、`PersistentGpuResourceLease register({required int ownerId, required int totalBytes, required int instanceBytes, required void Function() release})`、
`PersistentGpuMemorySnapshot snapshotFor({required int ownerId, required PersistentGpuResourceLifecycleState lifecycleState})`。
lease exposes `generation/state/Future<void> retire()`; constructor consumes tracker と affinity。

- [ ] **Step 1 — RED:** owner A に `(totalBytes: 64, instanceBytes: 24)`、owner B に `(96, 48)` を
  registerし、global active count/bytes=`2/160/72`、owner A=`1/64/24`、generation=1、
  latest/completed tracker values を exact 比較する。unknown/disposed owner は `StateError`、負 byte は
  `ArgumentError`、異 isolate は `StateError` を期待する。
- [ ] **Step 2 — verify RED:** pinned focused registry test。expected RED は registry/lease 未定義。
- [ ] **Step 3 — GREEN:** record に ownerId、generation、logical bytes、release closure、cached
  Completer/Future を持たせる。`totalBytes >= instanceBytes >= 0`、同 generation active 時だけ登録し、
  snapshot は global と owner を active/retiring/failed で集計する。
- [ ] **Step 4 — verify:** focused test、models test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files を addし
  `git commit -m 'Feature: GPU resource登録と集計を追加' && git push`。

### Task 4: explicit begin/mark/endFrame（fork bottom、depends Task 3）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `void beginFrame()`、`void markUsed(PersistentGpuResourceLease lease)`、
`void endFrame()`。record 内部に open-frame mark を持ち、public state は増やさない。

- [ ] **Step 1 — RED:** `beginFrame → markUsed → retire` で release=0/pending、`endFrame` submissionなしで
  release=1/retiredを期待する。nested begin、closed end、closed-frame mark、retire後mark、別 registry
  lease、別 isolate mutation はすべて `StateError`。同 lease の2回 mark は1 markとして扱う。
- [ ] **Step 2 — verify RED:** registry focused test の `open frame without submission` を実行し、
  expected RED は begin/mark/end API未定義。
- [ ] **Step 3 — GREEN:** registry は `_frameOpen` と identity Set を所有する。retire が open mark を
  見たら `retirementPendingOpenFrame`、endFrame は mark を全消去し past in-flight がなければ release。
  `try/finally` integration はまだ行わない。
- [ ] **Step 4 — verify:** registry全test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files を addし
  `git commit -m 'Feature: GPU resource frame記録を追加' && git push`。

### Task 5: before-submit stamping（fork bottom、depends Task 4）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** registry constructor は Task 1 の before-submit listener を1回だけ登録する。
record は `int? lastSubmission` を持ち、`markUsed` setを submission idへ atomically stampする。

- [ ] **Step 1 — RED:** `beginFrame → markUsed → retire → tracker.record()` 後に state pending、
  `lastSubmission=1`、release=0を期待する。active resource も `markUsed → record` で stampされる。
  1 frame内2 submissionでは最終 id=2、invalidation が open frame 中でも既に mark済み record は
  stampされ、後続markだけ拒否されることを testする。
- [ ] **Step 2 — verify RED:** plain-name `retire during open frame stamps next submission`。
  expected RED は record が submission待ちへ遷移せず早期releaseする assertion failure。
- [ ] **Step 3 — GREEN:** before-submit は listener呼出時の mark snapshotを clearし、active/pending-open
  両方へ `max(previous,id)` を記録する。frame は openのまま、release/Future settle は行わない。
- [ ] **Step 4 — verify:** registry全test + tracker test + diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: GPU submission stampを追加' && git push`。

### Task 6: completion-gated retirement（fork bottom、depends Task 5）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Task 1 completion listener を1回登録。`retire()` は record固有 cached Futureを返し、
`lastSubmission <= completedThrough` の時だけ synchronous release callbackを1回呼ぶ。

- [ ] **Step 1 — RED:** 次の3順序を別testにする。(a) submit→complete→retire は即 release、
  (b) bind→retire→submit→complete は completionまで保持、(c) submit1/submit2 を2→1順にcompleteし、
  watermark=0では保持、2へ進んだ時だけrelease。各順序で `identical(lease.retire(), lease.retire())`
  と callback count=1 を期待する。
- [ ] **Step 2 — verify RED:** plain-name `completion before retirement releases immediately`。
  expected RED は completion listener未接続またはFuture未完了。
- [ ] **Step 3 — GREEN:** release前に内部stateを `releasing`、accountingを retiringへ移す。
  completion callback中の collection mutationを避けるため eligible record snapshotを作り順にreleaseする。
- [ ] **Step 4 — verify:** registry/tracker tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: GPU completion後にresourceを解放' && git push`。

### Task 7: release failure/reentrancy ordering（fork bottom、depends Task 6）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** registry retains ordered `List<Object> failureLog` for tests; first release error is global cause。
No public recovery API。production callback is later constrained to no-throw view clearing。

- [ ] **Step 1 — RED:** injected callbackから同 lease `retire()` と snapshotを reentrant に呼び、
  callback一回/Future同一を期待する。別testでは callbackが `firstError`、test-only release observerが
  `secondError` をthrowし、resource=`retirementFailed`、failed bytes保持、global=`failed`、
  failureLog exact `[firstError, secondError]` を期待する。public dispose/invalidate reentrancyはTask 10で足す。
- [ ] **Step 2 — verify RED:** plain-name `release failure is terminal and preserves error order`。
  expected RED は failure accounting/stateが未実装。
- [ ] **Step 3 — GREEN:** callback前に state/accountingを進め、try/catch後にresource Futureをsettleする。
  first errorだけを context causeにし、残りは insertion orderで保存。残る records のretirementは継続する。
- [ ] **Step 4 — verify:** registry全test、同一Future/one-callback assertions、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Fix: GPU release失敗をterminal化' && git push`。

### Task 8: global owners と snapshot projection（fork bottom、depends Task 7）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `Future<void> disposeOwner(int ownerId)`, generation-global invalidate state storage、
owner terminal state storage。`snapshotFor` は disposed ownerにもread-onlyで許可する。

- [ ] **Step 1 — RED:** owners A/Bへ各1 recordを登録し、A disposeでAだけretiring、B active、globalは
  activeを期待する。disposed A snapshotは final owner usageとglobal B usageを返す。Aの再disposeは
  identical owner Future、unknown owner operationは `StateError`。全snapshot fieldをexact比較する。
- [ ] **Step 2 — verify RED:** plain-name `owner disposal does not dispose global context`。
  expected RED は disposeOwner未定義。
- [ ] **Step 3 — GREEN:** owner state/Futureをregistryで管理し、disposeはそのowner current-generation
  recordsだけretire。owner Futureはowner records settle後に resource Futureより後でsettleする。
- [ ] **Step 4 — verify:** registry/models tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: GPU resource owner集計を追加' && git push`。

### Task 9: process-global invalidation/recreate（fork bottom、depends Task 8）

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `Future<void> invalidateContext(int ownerId)`、
`void recreateContext(int ownerId)`。generationごとに cached `FI` を1つ持ち、どのactive ownerにも
identical objectを返す。Also produces process-global internal
`final persistentGpuResourceRegistry = PersistentGpuResourceRegistry(submissions: rendererSubmissions)`。

- [ ] **Step 1 — RED:** owners A/Bに current-generation recordを作りAからinvalidateする。即座にglobal
  invalidating、A/B recordはpending、B bind/register拒否、A/B invalidate Futureはidenticalを期待する。
  open frameでA record mark後、Bからinvalidate→before-submit→completionの順でも早期releaseしない。
  全record settle後だけ invalidated、resource→owner dispose→global FI のcompletion順を記録する。
- [ ] **Step 2 — verify RED:** plain-name `one owner invalidates every owner in the generation`。
  expected RED はglobal invalidation API未定義。
- [ ] **Step 3 — GREEN:** invalidation開始時にglobal stateを先に変え、同 generation全recordをretire。
  recreateは invalidated/failed-record=0 の時だけ generation+1/active、新しいFIをlazy作成する。
  active/invalidating/failed/repeated recreateは synchronous `StateError`。
- [ ] **Step 4 — verify:** registry全test、state-machine table全rowをtest名で対応、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: global GPU generationを追加' && git push`。

### Task 10: public lifecycle owner operation table（fork bottom、depends Task 9）

**Files:** Create `lib/src/render/persistent_gpu_resource_lifecycle.dart`,
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Produces section 3 の `PersistentGpuResourceLifecycle`。public factoryは process-global
`persistentGpuResourceRegistry`へattachし、`@internal ...forRegistry(PersistentGpuResourceRegistry)`を
test/Geometry用に持つ。internal `registerAllocation(...)` と `markUsed(lease)` だけをGeometryへ渡す。

- [ ] **Step 1 — RED:** section 4 operation×state tableを parameterized test化する。特に dispose during
  invalidation では `FD` と `FI` は別object、FDはA settleで完了してもFIはBを待つ。disposed後の
  invalidateは repeated exact `FE`、recreate後の次invalidateだけnew FI、failed時の全operation、
  snapshot allowed、全 getter shared generation/stateをexact期待する。release callbackから同owner
  dispose/global invalidate/snapshotを呼ぶ reentrant testでも二重releaseせず、resource→FD→FI順を期待する。
- [ ] **Step 2 — verify RED:** focused lifecycle test。expected RED は lifecycle type/import不存在。
- [ ] **Step 3 — GREEN:** handleはownerIdとdisposed-invalid-operation用cached FEだけを持ち、FD/FIは
  registryのcached objectをそのままreturnする。global state/Futureを複製しない。every public/internal
  operation first calls affinity。disposed checksはglobal mutationより先に行う。
- [ ] **Step 4 — verify:** lifecycle/registry/tracker全test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: persistent GPU lifecycleを公開' && git push`。

### Task 11: Scene frame boundary integration（fork bottom、depends Task 10）

**Files:** Modify `lib/src/scene.dart`; Create `test/render/persistent_gpu_scene_frame_test.dart`。

**Interfaces:** Scene consumes the process-global registry only。render frame entryで
`beginFrame()`、全 encode/submit bodyを `try`、必ず1回 `finally { endFrame(); }` とする。

- [ ] **Step 1 — RED:** test seamで registry event log と encode closureをinjectし、normal=
  `begin,encode,end`、encode throw=`begin,encode,end` + original error、submissionなしでもend、
  nested renderはbeginの `StateError` を期待する。既存 renderer submission順は変えない。
- [ ] **Step 2 — verify RED:** pinned test plain-name `scene closes resource frame after encode failure`。
  expected RED は frame hooks 未接続。
- [ ] **Step 3 — GREEN:** existing transients beginと同じ frame setup位置に registry beginを置く。
  `finally` はend errorでoriginal encode errorを隠さないよう、closed-state invariantをtest seamで守る。
- [ ] **Step 4 — verify:** new scene test、全 render tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: SceneへGPU lifecycle frameを接続' && git push`。

### Task 12: lifecycle curated export/docs（fork bottom、depends Task 11）

**Files:** Modify `lib/src/scene.dart`, `lib/scene.dart`, `README.md`; Create
`test/render/persistent_gpu_lifecycle_public_api_test.dart`。

**Interfaces:** Public show-listは section 3 の lifecycle、4 enum、usage/snapshotだけ。
registry、lease、affinity、test constructorはexportしない。

- [ ] **Step 1 — RED:** test imports only `package:flutter_scene/scene.dart` and instantiates lifecycle、reads
  initial active/generation 1/snapshot zero。compile-fail grepとして public barrelに
  `PersistentGpuResourceRegistry|PersistentGpuResourceLease` が無いことも source assertionする。
- [ ] **Step 2 — verify RED:** public API test。expected RED は symbols未export。
- [ ] **Step 3 — GREEN:** curated exportsを追加。READMEへ stop rendering→detach→invalidate→await→
  recreate、multi-owner global invalidation、failed terminal、logical bytes≠driver resident bytesを記載する。
- [ ] **Step 4 — verify:** public/lifecycle/registry tests、full `dart analyze .`、diff-check。
- [ ] **Step 5 — publish:** 4 files、`git commit -m 'Docs: persistent GPU lifecycle契約を公開' && git push`。

### Delivery Gate BOTTOM（commitなし）

- [ ] exact Flutter version、`dart format --output=none --set-exit-if-changed lib test`、`dart analyze .`、
  `flutter test --enable-impeller` を pinned miseで実行し pass/fail/skip件数を保存する。GPU skipをpassへ
  読み替えず、device/Simulator/E2E/#1604 profileは実施しない。
- [ ] fresh review subagentが section 3/4 と Task 1–12 diffを照合し、未解決 finding が0になるまで
  修正Taskを追加する。clean、local HEAD=remote HEADをassertする。
- [ ] `gh stack submit --auto --open --remote origin` で bottom PRを作成する。body Remaining tasksに
  top Geometry、EQ pin、automatic context-loss signalなし、driver reclaim未観測、#1603–#1605、
  #1604 physical 30fps/5min defer、欠落canonical specを列挙する。
- [ ] top branchが未作成なら clean bottom worktreeで
  `gh stack add feat/persistent-packed-instance-geometry`。既存なら `gh stack view --json` でowner/baseを
  assertして `gh stack checkout feat/persistent-packed-instance-geometry`。bottom ancestry不一致、dirty、
  linked elsewhereなら停止し、branch delete/reset/force pushしない。

### Task 13: checked allocation arithmetic（fork top、depends Task 12）

**Files:** Create `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal `const kMaxPersistentPackedAllocationBytes = 0x7fffffff` and
`PersistentPackedCheckedMath.multiply({required int left, required int right, required String name})`、
`add(...)`、`align16({required int value, required String name})`。

- [ ] **Step 1 — RED:** table test exact cases: `0*max=0`、`max+0=max`、`align16(1)=16`、
  negative operand、`max*2`、`max+1`、`align16(max)` は `ArgumentError` before wrapped value。
  error messageは operation name と operandsを含む。
- [ ] **Step 2 — verify RED:** plan focused test。expected RED は math class/constant不存在。
- [ ] **Step 3 — GREEN:** multiplyは `left > max ~/ right`、addは `left > max-right`、alignは
  checked add before bit-mask。すべての input/resultを0..max内に制限し、BigInt/floating pointを使わない。
- [ ] **Step 4 — verify:** focused test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed allocation計算を検証' && git push`。

### Task 14: defensive layout snapshot/validation（fork top、depends Task 13）

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal
`PersistentPackedLayoutSnapshot.create(VertexLayoutDescriptor source)` with `layout`,
`vertexStrideInBytes`, `instanceStrideInBytes`。全 buffer/attribute listを `List.unmodifiable` cloneする。

- [ ] **Step 1 — RED:** happy path 2 slotと、buffers 0/1/3、slot0 non-vertex、slot1 non-instance、
  empty attributes、stride <=0、offset <0、duplicate name、end > stride を rejectする。offset alignmentは
  `gcd(format.bytesPerElement, 4)`、strideはslot最大alignmentの倍数を要求する。constructor後に元の
  buffers list/attributes listをclear/addしても snapshot equality/strideが不変を期待する。
- [ ] **Step 2 — verify RED:** plain-name `layout is deeply snapshotted before caller mutation`。
  expected RED は snapshot class未定義。
- [ ] **Step 3 — GREEN:** descriptor/attributeをfieldごとに再生成し unmodifiable化してから検証する。
  `layout.toGpuLayout()` を呼び既存 duplicate/end checkを再利用し、追加policyだけを先に検査する。
- [ ] **Step 4 — verify:** plan全test、既存 `test/vertex_layout_test.dart`、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed layoutを防御的に固定' && git push`。

### Task 15: defensive bounds snapshot/validation（fork top、depends Task 14）

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal `PersistentPackedBoundsSnapshot.create(vm.Aabb3 source)` with copied
`vm.Aabb3 aabb` and derived copied `vm.Sphere sphere`。

- [ ] **Step 1 — RED:** finite min/max happy path、NaN、±infinity、各axis min>maxをtable testする。
  `source.min.setValues(...)` / `source.max.setValues(...)` をcreation後に呼んでも snapshot aabb/sphere
  center/radiusが変わらず、returned getterをmutateしても次getterが変わらないことを期待する。
- [ ] **Step 2 — verify RED:** plain-name `bounds are deeply snapshotted`。expected RED は class不存在。
- [ ] **Step 3 — GREEN:** min/maxを `Vector3.copy` し finite/min<=maxを確認、internal canonical valuesを
  retainし、getterは `Aabb3.copy` / `Sphere.copy` を返す。caller objectをGeometry/superclassへ渡さない。
- [ ] **Step 4 — verify:** focused plan tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed boundsを防御的に固定' && git push`。

### Task 16: exact index validation（fork top、depends Task 15）

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal
`PersistentPackedIndexPlan.create({required ByteData? data, required gpu.IndexType type, required int vertexCount})`
with `indexCount/indexBytes/hasIndices`。non-null bytes are validation input only and are not retained。

- [ ] **Step 1 — RED:** null index accepts、non-null empty rejects、int16 odd/int32 non-multiple-of-4 rejects、
  vertexCount<=0 rejects。little-endian values `[0, vertexCount-1]` accept、value==vertexCountとlarger reject。
  both widthsをtestし、source ByteDataをvalidation後にmutateしても derived count/bytes不変を期待する。
- [ ] **Step 2 — verify RED:** plain-name `every index is smaller than vertexCount`。expected RED は
  out-of-range inputが受理される/validator不存在。
- [ ] **Step 3 — GREEN:** `getUint16/getUint32(offset, Endian.little)` で全値をscanし、width/countは
  checked math policy内で算出。unsupported enumなら `ArgumentError`、fallback index typeなし。
- [ ] **Step 4 — verify:** plan全test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed index値を検証' && git push`。

### Task 17: immutable composite upload plan/executor（fork top、depends Task 16）

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal `PersistentPackedInstancePlan.create(...)` with the public constructor's
data/count/layout/bounds/index inputs, computed `vertexBytes/instanceBytes/instanceOffset/nonIndexBytes/
indexBytes/totalBytes/indexCount` and frozen layout/bounds。Also produces
`executePersistentPackedUpload({required plan, required vertexData, required instanceData, required indexData, required bool Function(ByteData,int) overwriteNonIndex, required bool Function(ByteData,int) overwriteIndex})`。

- [ ] **Step 1 — RED:** exact byte-length happy path and too-short/too-long/zero/negative countsをtest。
  `vertexBytes=count*stride`、`instanceOffset=align16(vertexBytes)`、padding、each buffer/total maxをassert。
  fake writersのcallsは base `(data,0)` once、instance `(data,instanceOffset)` once、index null=0/non-null
  `(data,0)` once。false returnは該当 call名を含む `StateError` で後続callなし。
- [ ] **Step 2 — verify RED:** plain-name `upload executor writes each source exactly once`。
  expected RED は composite plan/executor不存在。
- [ ] **Step 3 — GREEN:** constructor冒頭でlayout/bounds snapshotsを作り、checked math後にexact lengthを
  検証、index planをcomposeする。executorはallocationせず同期overwrite resultだけ検査しsourceを保持しない。
- [ ] **Step 4 — verify:** plan全test、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed upload planを合成' && git push`。

### Task 18: one-shot GPU storage（fork top、depends Task 17）

**Files:** Create `lib/src/geometry/persistent_packed_instance_storage.dart`,
`test/persistent_packed_instance_storage_test.dart`。

**Interfaces:** Produces internal
`PersistentPackedInstanceStorage.upload({required PersistentPackedInstancePlan plan, required ByteData vertexData, required ByteData instanceData, required ByteData? indexData})`、nullable
`vertexView/instanceView/indexView` getters、synchronous idempotent `void release()`。

- [ ] **Step 1 — RED:** injected test backendで non-index allocation once、index 0/1、overwrite offsets/counts
  exact、viewsのlength exactをassert。base/instance/index各 failureでは throw、作成済み refs cleared、
  later overwriteなし。GPU available時だけ real `DeviceBuffer` pathを1 small fixtureで実行し、unavailableは
  reason付きskip。source bytes mutation after uploadで recorded uploaded copy不変をexpectする。
- [ ] **Step 2 — verify RED:** storage focused test。expected RED は storage/backend seam不存在。
- [ ] **Step 3 — GREEN:** host-visible non-index bufferとoptional index bufferをplan完了後だけ作る。
  `DeviceBuffer.overwrite`（upload/flush）をexecutor callbacksへ渡し、成功後だけviewsをpublish。
  `release` は3 viewsと2 device refsをnullにする no-throw closure。superclassへ渡さない。
- [ ] **Step 4 — verify:** pure tests + GPU conditional test、plan tests、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed GPU storageを追加' && git push`。

### Task 19: Geometry lifecycle lease/state（fork top、depends Task 18）

**Files:** Create `lib/src/geometry/persistent_packed_instance_geometry.dart`,
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces section 3 public constructor/getters/`retire()`。Consumes lifecycle internal
`registerAllocation` only after storage upload succeeds。Geometry directly owns plan/storage/lease and never calls
`setVertices`/`setVertexStreams`/`setIndices`。

- [ ] **Step 1 — RED:** fake registry/lifecycleで constructor success registers exact total/instance bytes and
  generation、upload failure registers zero、retire Future identity/state transitionsをassert。input layout lists、
  Aabb3、vertex/instance/index ByteDataをconstructor後にmutateしても counts/layout/bounds/uploaded bytes不変。
  old generation、invalidating、disposed lifecycle constructionは fail-closed。
- [ ] **Step 2 — verify RED:** geometry focused test。expected RED は public Geometry不存在。
- [ ] **Step 3 — GREEN:** synchronous plan→storage→register順に構築し、release callbackはstorage.releaseのみ。
  `setLocalBounds(plan.bounds, plan.sphere)` はcopy gettersを渡す。constructor途中errorはstorage.releaseして
  rethrowし、fallback Geometryを作らない。
- [ ] **Step 4 — verify:** geometry/plan/storage tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed Geometry lifecycleを追加' && git push`。

### Task 20: persistent bind/draw（fork top、depends Task 19）

**Files:** Modify `lib/src/geometry/persistent_packed_instance_geometry.dart`,
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Overrides `vertexStreamCount=2`, `instancedVertexLayout`,
`bindsModelTransformInstance=false`, `isDoubleSided`, `depthOnlyVertex` (same shader/layout), existing
`bind(...)` and `draw(RenderPass,{int instanceCount=1})` signatures。

- [ ] **Step 1 — RED:** fake pass event log exact order: lifecycle current check→markUsed→slot0 vertex→slot1
  instance→optional index→FrameInfo uniform。indexed/non-index draw use immutable count and instance count from
  plan。retirementPending/retired/failed/old generationは bind/drawを拒否。external `instanceCount != 1` は
  `StateError`、state reject時はpass events 0。depth/shadow pathもslot 0/1同layoutをexpectする。
- [ ] **Step 2 — verify RED:** plain-name `bind marks use before persistent buffer bindings`。
  expected RED は bind/draw override未実装。
- [ ] **Step 3 — GREEN:** existing compat bind/draw helpersとFrameInfo packだけを使う。instance transient、
  source scan、overwriteをbind/drawから呼ばない。markUsed後のfailureもopen-frame retirementで安全に閉じる。
- [ ] **Step 4 — verify:** geometry tests、`rg -n 'instanceTransients|overwrite\('` audit、diff-check。
- [ ] **Step 5 — publish:** 2 files、`git commit -m 'Feature: packed Geometryを永続bind' && git push`。

### Task 21: exact material variant（fork top、depends Task 20）

**Files:** Modify `lib/src/material/shader_stage.dart`, `lib/src/material/shader_material.dart`,
`lib/src/geometry/persistent_packed_instance_geometry.dart`, `test/shader_material_vertex_test.dart`。

**Interfaces:** Adds `MeshVariant.persistentPackedInstances('persistent_packed_instances')` and exact
`MeshVariant.fromName` mapping。Geometry `materialVertexVariant` returns that exact name。

- [ ] **Step 1 — RED:** assign shader via `setVertexShader(... variant: persistentPackedInstances)` and expect
  `materialVertexShader('persistent_packed_instances')` same shader; unskinned/skinned/depth and unknown keep existing
  behavior。Geometry variant exact stringをassertし、missing custom variant warning names it rather than unskinned。
- [ ] **Step 2 — verify RED:** shader material focused tests。expected RED は enum member未定義。
- [ ] **Step 3 — GREEN:** enum/switchへ1 explicit caseを追加し、ShaderMaterial lookupはexact enum keyを使う。
  implicit fallback、standard shader、position-only shortcutへcollapseさせない。
- [ ] **Step 4 — verify:** shader/geometry tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 4 files、`git commit -m 'Feature: packed Geometry shader variantを追加' && git push`。

### Task 22: Geometry curated export/docs（fork top、depends Task 21）

**Files:** Modify `lib/scene.dart`, `README.md`; Create
`test/persistent_packed_instance_public_api_test.dart`。

**Interfaces:** Public barrel adds only `PersistentPackedInstanceGeometry`; layout/lifecycle types remain existing
curated exports。plan/storage/registry/lease/backends are internal。

- [ ] **Step 1 — RED:** test imports only `dart:typed_data`, `vector_math`,
  `package:flutter_scene/scene.dart`, `package:flutter_scene/gpu.dart` and assigns
  `final constructor = PersistentPackedInstanceGeometry.new`、references lifecycle/snapshot/layout/retire types。
  source assertion rejects any `package:flutter_scene/src/` import and internal type export。
- [ ] **Step 2 — verify RED:** public API focused test。expected RED は Geometry symbol未export。
- [ ] **Step 3 — GREEN:** curated exportを追加。README exampleは CPU pack→one construction→per-frame bind→
  revision時new attach/old detach/old retire→stop/detach/invalidate/await/recreate。custom shaderのFrameInfo、
  required attributes/varyings、logical memory、no fallback/no per-frame uploadを記載する。
- [ ] **Step 4 — verify:** public/geometry/material tests、analyze、diff-check。
- [ ] **Step 5 — publish:** 3 files、`git commit -m 'Docs: packed Geometry公開契約を追加' && git push`。

### Delivery Gate TOP（commitなし）

- [ ] forbidden auditで `instanceTransients.emplace|List<Matrix4>|Future.delayed|Timer\(|setVertices\(|
  setIndices\(` が新 filesに0件、constructor/storage以外の `overwrite` が0件、releaseだけが nullable
  buffer refsをclearすることを確認する。
- [ ] pinned format/analyze/full `flutter test --enable-impeller` を実行しpass/fail/skipとexact Flutter SHAを
  保存する。fresh spec/code review subagentsのfindingsを0にし、clean/local=remoteをassertする。
- [ ] `gh stack submit --auto --open --remote origin`、`gh stack view --json` で bottom/baseとtop/base、OPEN
  をassert。top PR bodyにEQ pin、#1603/#1604/#1605、physical 30fps/5min defer、driver reclaim未観測、
  current upstream `ed04205c10991739338fde19563bcf2698057755` forward-portをRemaining tasksとして書く。
- [ ] `git rev-parse HEAD` のfull 40-char top SHAを immutable hand-offとして記録する。PR作成後に review
  fix commitが入った場合は古いSHAを破棄し、全gate再実行後の新しいHEADだけをEQ pinへ渡す。

### Gate D: #1601 whole-branch approval と EQMonitor worktree（commitなし）

EQMonitor pinは「Task 22完了」だけでは開始しない。Issue #1601 とそのimplementation PR全体が、同じ
immutable head SHAで final review/verification済みであることを先に証明する。2026-08-12時点の#1620は
head `cfdc8516cc21991d41ff6ff20954271f37026d01`、base
`feat/seismicity-pmtiles-network-reader`、`BEHIND`、approvalなし、analyze/integration/Android/status check
failureのため、現状のままならこのgateで停止する。

- [ ] live queryを再実行し、#1601 requirements（non-empty tile enumeration、column chunk、isolate
  `TransferableTypedData`、manifest count typed failure、missing depth validity bit）が同一 `headRefOid`
  のwhole-branch reviewで承認済みであることをreview evidenceへ記録する。

  ```bash
  gh issue view 1601 --repo YumNumm/EQMonitor --json state,body,url
  gh pr view 1620 --repo YumNumm/EQMonitor \
    --json state,isDraft,reviewDecision,mergeStateStatus,headRefName,headRefOid,baseRefName,statusCheckRollup,url
  ```

  OPEN routeの必須条件はnon-draft、head exact decoder、base exact network-reader、reviewDecision
  `APPROVED`、mergeStateがclean、全required checkがCOMPLETEDかつ `SUCCESS|NEUTRAL|SKIPPED`。
  MERGED routeはmerge commitを取得し最新`origin/develop`に含まれること、final head SHAへの同じreview/check
  証拠を要求する。failure/cancel/pending/BEHIND、Issue audit欠落、reviewが古いSHAなら停止する。
  個別commitだけのapprovalをwhole-branch approvalとみなさない。
- [ ] `decoder_final_sha` にlive full `headRefOid`を入れ `^[0-9a-f]{40}$` をassert、fetch/cat-file後、
  exact SHA detached worktreeで `mise exec -- flutter test packages/seismicity_pmtiles
  packages/pmtiles_v3` と `mise exec -- dart analyze packages/seismicity_pmtiles packages/pmtiles_v3` を実行する。
  fresh verification failureなら停止し、#1620を直す権限へ拡張しない。
- [ ] OPEN routeの `pin_base_sha=decoder_final_sha`、MERGED routeの `pin_base_sha=origin/develop` full SHAを
  記録する。active checkoutを使わず
  `/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.worktrees/seismicity-flutter-scene-fork-pin`
  を使用する。target/branch不存在なら
  `git worktree add -b feat/seismicity-flutter-scene-fork-pin /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.worktrees/seismicity-flutter-scene-fork-pin "$pin_base_sha"`。
  branchのみ既存ならattach、target既存ならregistered path/origin/branch/clean/
  `merge-base --is-ancestor "$pin_base_sha" HEAD` をassertする。mismatch/dirtyは停止し、delete/reset/
  checkout/force pushしない。

### Task 23: fork URL/SHA と lockをatomic更新（EQ top、depends Gate D + Task 22）

**Files:** Modify `packages/eqmonitor_map/pubspec.yaml`,
`packages/eqmonitor_map/example/pubspec.yaml`, `pubspec.lock`。

**Interfaces:** All 3 active descriptors use exact URL
`https://github.com/YumNumm/flutter_scene.git` and the Delivery Gate TOP full SHA; root lock entries
`flutter_scene`/`scene` each have same exact `description.url/ref/resolved-ref` and existing package path。

- [ ] **Step 1 — RED:** before edit, machine query asserts old bdero URL/ref then deliberately expects new exact
  URL/SHA, yielding nonzero。`fork_top_sha` must pass 40-char regex and `git ls-remote` exact commit reachability。
- [ ] **Step 2 — GREEN:** edit only 3 descriptor URL/ref values, then `mise exec -- flutter pub get`; lockfile is
  resolver-generated, never hand-edited。example is workspace member so no new lockfileを作らない。
- [ ] **Step 3 — verify:** `mise exec -- flutter pub get --enforce-lockfile`、YAML machine queryで3 descriptor +
  2 lock entry exact URL/requested/resolved full SHA、`rg`でactive old URL/SHA 0件、diff-check。
- [ ] **Step 4 — publish:** 3 files、`git commit -m 'Package: Flutter Scene fork SHAへ固定' &&
  git push -u origin feat/seismicity-flutter-scene-fork-pin`。

### Task 24: machine-readable exact pin verifier（EQ top、depends Task 23）

**Files:** Create `tool/verify_flutter_scene_pin.sh`,
`scripts/ci/test_verify_flutter_scene_pin.sh`。

**Interfaces:** `tool/verify_flutter_scene_pin.sh EXPECTED_URL EXPECTED_FULL_SHA [REPO_ROOT]`。
It validates `.dependencies.flutter_scene.git.{url,ref,path}` and
`.dependency_overrides.scene.git.{url,ref,path}` in package pubspec, example
`.dependencies.flutter_scene.git.{url,ref,path}`, and lock
`.packages.flutter_scene.description.{url,ref,"resolved-ref",path}` / corresponding `.packages.scene` fields,
using `mise exec -- yq`; exit 0 only when all 5 entries match exact values。Expected paths are respectively
`packages/flutter_scene`, `packages/scene`, `packages/flutter_scene`, and the same two lock paths。

- [ ] **Step 1 — RED:** test uses `mktemp -d`, trap removes only that validated temp path, copies minimal fixtures,
  and checks happy path plus wrong descriptor URL、requested refだけwrong、resolved-refだけwrong、scene package
  only wrong、short SHA。Each mutation expects nonzero and error naming exact file/package/field。
- [ ] **Step 2 — verify RED:** `mise exec -- bash scripts/ci/test_verify_flutter_scene_pin.sh`。
  expected RED は verifier不存在。
- [ ] **Step 3 — GREEN:** args count/URL/full-SHA regex/root filesを先にvalidateし、yqでscalarを読む。
  string grepだけ、floating ref許可、ref==resolved only checkは禁止。3 descriptor and 2 lock entriesを個別assert。
- [ ] **Step 4 — verify:** shell testと real root verifier、`bash -n`、`git diff --check`。
- [ ] **Step 5 — publish:** 2 executable files、`git commit -m 'Test: Flutter Scene pin検証を追加' && git push`。

### Task 25: EQMonitor public API contract（EQ top、depends Task 24）

**Files:** Create
`packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart`。

**Interfaces:** Consumer imports only `package:flutter_scene/scene.dart` and `gpu.dart`; no flutter_scene `src/`
or flutter_gpu import。It references lifecycle/snapshot/layout/Geometry constructor and retire Future types without GPU。

- [ ] **Step 1 — RED:** add compile test and initial lifecycle snapshot expectations active/generation=1/zero bytes。
  Before Task 23 resolution this would fail on missing symbols; on pinned fork it must compile。Source assertion rejects
  private imports and verifies public constructor tear-off type。
- [ ] **Step 2 — verify:** `mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart`。
  Any missing export is RED and fixed in fork top followed by new immutable SHA/re-pin, not via private EQ import。
- [ ] **Step 3 — GREEN:** test-only adjustment to public signatures; no adapter/product rendering implementation。
- [ ] **Step 4 — verify:** focused test + `mise exec -- dart analyze packages/eqmonitor_map` + diff-check。
- [ ] **Step 5 — publish:** file、`git commit -m 'Test: Flutter Scene公開API境界を固定' && git push`。

### Task 26: package consumer docs（EQ top、depends Task 25）

**Files:** Modify `packages/eqmonitor_map/README.md`, `packages/eqmonitor_map/example/README.md`。

**Interfaces:** Current package docs record both fork PR URLs、top full SHA、upstream base `7f71993...`、
Flutter full SHA、global multi-owner lifecycle ordering、logical vs resident bytes。Historical plan/draft evidenceは
rewriteしない。

- [ ] **Step 1 — RED:** `rg` inventoryでactive README/knowledgeのold bdero current pinを列挙し、expected
  fork URL/top SHA queryをfailureとして保存する。
- [ ] **Step 2 — GREEN:** package/example READMEだけ同期し、#1603/#1604/#1605 boundaries、automatic context-loss
  なし、#1604 physical 30fps/5min未実施、reference sources are patterns only/no copied codeを明記する。
- [ ] **Step 3 — verify:** verifier、public test、package READMEのold active pin 0件、diff-check。
- [ ] **Step 4 — publish:** two files、`git commit -m 'Docs: Flutter Scene package provenanceを同期' && git push`。

### Task 27: toolchain/lifecycle knowledge docs（EQ top、depends Task 26）

**Files:** Modify `docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md`,
`docs/knowledge/20260802_flutter_scene_scene_source_pin.md`,
`docs/knowledge/20260802_flutter_scene_large_static_instances.md`。

**Interfaces:** Current knowledge records exact fork/top/toolchain SHA and operational lifecycle; source-pin doc
asserts both lock entries' requested/resolved SHA。Historical entries remain intact and clearly labelled historical。

- [ ] **Step 1 — RED:** `rg` exact old current pin lines in the 3 files and run expected fork URL/top SHA assertion
  to nonzero; capture which lines are current instructions versus historical evidence。
- [ ] **Step 2 — GREEN:** update current instructions only with global multi-owner invalidation、completion-gated
  retirement、logical bytes≠resident bytes、#1604 device/performance defer、reference provenance/no copied code。
- [ ] **Step 3 — verify:** Task 24 verifier、Task 25 public test、package analyze、current instruction old pin 0件、
  `git diff --check`。
- [ ] **Step 4 — publish:** three files、
  `git commit -m 'Docs: Flutter Scene lifecycle知見を同期' && git push`。

### Delivery Gate EQ / upstack refresh / PR stop（commitなし）

- [ ] PR作成直前に Gate D query/audit/check/local testsを再実行する。`decoder_current_sha` が記録済み
  `decoder_final_sha` と同じならそのbaseを維持する。異なる場合は新SHAでGate Dを最初から通し、
  passした時だけ次のnon-destructive upstack rebaseを行う。
- [ ] rebase前に `pin_pre_rebase_head=$(git rev-parse HEAD)` とremote pin headをfull SHAでvalidateし、
  `git branch "backup/seismicity-flutter-scene-fork-pin-$pin_pre_rebase_head" HEAD` でrecoverable backupを
  作る。OPEN routeは
  `git rebase --onto "$decoder_current_sha" "$decoder_final_sha" feat/seismicity-flutter-scene-fork-pin`。
  #1620がMERGEDへ変わったrouteはmerge commitが最新origin/developに含まれることをassertし、
  `git rebase --onto origin/develop "$decoder_final_sha" feat/seismicity-flutter-scene-fork-pin`。
  conflictがpin/docs外へ及ぶ、approval/checkを再証明できない場合はbackupを残して停止する。
- [ ] rebase後はTask 24 verifier、Task 25 focused test、package analyze、`flutter pub get --enforce-lockfile`、
  diff-checkを再実行する。remote branch更新が必要な場合だけ、validated remote old SHAを用いて
  `git push --force-with-lease=refs/heads/feat/seismicity-flutter-scene-fork-pin:$remote_pin_head origin
  HEAD:refs/heads/feat/seismicity-flutter-scene-fork-pin`。bare `--force`は禁止する。
- [ ] OPEN decoder routeは
  `gh stack link --base feat/seismicity-pmtiles-network-reader feat/seismicity-pmtiles-decoder
  feat/seismicity-flutter-scene-fork-pin --remote origin`。MERGED routeは
  `gh stack link --base develop feat/seismicity-flutter-scene-fork-pin --remote origin`。
  いずれも非対話で実行し、既存stack metadataが違えば修復を推測せず停止する。
- [ ] EQ pin PRをOPENでsubmitし、baseがOPEN routeでは decoder branch、MERGED routeではdevelop、headが
  pin branch、bodyが fork bottom/top PR URLs、top full SHA、decoder final SHAを含むことを
  `gh pr view --json` でassertする。Remaining tasksに #1603 lifecycle wiring、#1604 24-byte/LOD/2M upload、
  #1604 physical iPhone 13相当30fps/5min memory、#1605 integration/loading/error/retry/device smoke、
  upstream forward-port、欠落canonical specを列挙する。
- [ ] fork bottom/topとEQ pinの全PRについてURL/base/head/full SHA/checks/skips/blockersを収集し、各worktree
  `status --porcelain=v1` empty、local=remoteをassertする。この3 PRを一旦すべて作成した時点で必ず停止し、
  merge、review対応、#1603、実機/Simulator/E2Eへ進まない。

## 9. Completion checklist

- [ ] fork が正しい parent/権限で作成され、compatibility trunk は exact `7f71993...`。
- [ ] fork bottom PR は completion watermark、retirement、generation、memory snapshot を公開。
- [ ] fork top PR は instance bytes を初回1回だけ upload し、per-frame bind だけを行う。
- [ ] retire/context generation が fail-closed で、CPU frame/delay を GPU completion とみなさない。
- [ ] fork package focused/full test と analyze が non-device 環境で完了し、skip は明示済み。
- [ ] EQMonitor の dependency/lock/current README は YumNumm fork の同一 full SHA。
- [ ] pin verifier は lockのflutter_scene/scene双方でURL/requested ref/resolved full SHA/pathをexact assert。
- [ ] EQMonitor は curated public import だけを compile test で使用。
- [ ] #1601 whole branch は同一final SHAでapproval/check/focused verification済み、更新時はrebase再検証済み。
- [ ] 3 PR の Remaining tasks が performance/device gate と後続 Issues を隠していない。
- [ ] 全 PR 作成後に作業を停止し、merge や後続 layer へ進んでいない。
