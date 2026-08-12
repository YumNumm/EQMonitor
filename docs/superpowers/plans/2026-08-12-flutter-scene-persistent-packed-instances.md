# Flutter Scene Persistent Packed Instances Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: use
> `superpowers:subagent-driven-development` task-by-task. Every implementation
> task is one RED → GREEN → review → commit → push cycle. Do not start the
> next task until a different agent approves the current task.

**Goal:** Issue #1602 向けに、static packed instance data を一度だけ GPU へ
upload し、GPU submission 完了まで安全に retire できる汎用 Geometry を
`YumNumm/flutter_scene` fork へ追加する。EQMonitor は公開 API だけを使い、
fork の immutable commit SHA へ固定する。

**Architecture:** process-global registry が1つの Flutter GPU context、submission
tracker、generation/state を所有し、複数 lifecycle owner は同じ状態を観測する。
immutable な vertex/instance 2-stream Geometry は初回だけ persistent buffer へ書き、
通常・depth・shadow・selection の全経路を既存 full `bind` へ集約する。data change は
new attach → old detach → old retire で表す。

**Tech Stack:** Flutter `4dacd3fc91d96262a33e5c598e17d816f0b35641`
(3.47.0-1.0.pre-97)、Dart 3.14.0-29.0.dev、Flutter GPU/Impeller、Flutter
Scene `7f71993b7e2a0ab1d2f59726a406098709be7291`、`mise exec --`、`gh stack`。

## Global Constraints

- fork base は exact `7f71993b7e2a0ab1d2f59726a406098709be7291`、Flutter は
  exact `4dacd3fc91d96262a33e5c598e17d816f0b35641`。floating ref 禁止。
- Flutter/Dart は常に `mise exec --`。fork では
  `mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 --` を付ける。
- registry、Scene encode、completion callback、lifecycle、Geometry は同一 Dart isolate。
  lock、cross-isolate transfer、background GPU call は追加しない。
- owner ごとの context/generation は作らない。任意 owner の invalidation は同 generation
  の全 owner resource を retire し、全件 settle まで recreate を拒否する。
- per-frame instance upload/full scan、`InstancedMesh` matrix pack、delay、固定 frames-in-flight、
  error 時の fallback Geometry は禁止。
- `DeviceBuffer` reference release と driver resident-memory 解放を区別し、後者を保証しない。
- fork API は generic packed Geometry/lifecycle のみ。震源24-byte schema、LOD、color/radius は
  #1604、app wiring は #1603/#1605。
- 実機、Simulator、all-E2E は実行しない。iPhone 13相当 30fps/5分 memory gate は #1604。
- 各 Task は handwritten production+test 30–100 changed lines（generated lock除外）。超える前に
  taskを分ける。commit は英語1語prefix + 日本語、commit後push。
- user checkout/dirty changeを変更しない。mismatchなら削除/reset/checkout/force pushせず停止。

## Current evidence and reference boundary (2026-08-12)

- EQMonitor plan branch base は当時の latest `origin/develop`
  `8120f23446b53f4b3222d32306d4fb576cb9683e`。
- #1602 は parent #1612 layer 06。#1603 scene foundation、#1604 2M renderer、
  #1605 integration はこの plan に混ぜない。
- active descriptors/lock は `bdero/flutter_scene`
  `7f71993b7e2a0ab1d2f59726a406098709be7291`。current upstream master
  `ed04205c10991739338fde19563bcf2698057755` も transient billboard で、任意
  `DeviceBuffer.dispose` はない。
- pinned source には process-global `rendererSubmissions` / `GpuSubmissionTracker` があり、
  全 renderer command buffer は `GpuSubmissionTracker.submit(gpu.CommandBuffer)` を通る。別 fence は作らない。
- pinned `Geometry.depthOnlyVertex == null` の既存 depth/shadow/selection encoder は
  `Geometry.bind(gpu.RenderPass, TransientWriter, Matrix4, Matrix4, Vector3)` を呼ぶ。
  persistent Geometry も null を維持し、両 stream を full bindする。
  non-null + `bindPositionStream` は superclass private stream を必要とするため採用しない。
- `bdero/dashmap` `a6ff92edd999e922f81d26d209d8f589faee3fd0` は MIT。
  public barrel と pure projection/Scene adapter の分離だけを参考にする。
- 指定名 `ingen084/KyoshinEewViewer` ではなく確認できた MIT repository は
  `ingen084/KyoshinEewViewerIngen`
  `23c91f26c0f3bbc47320bf87b409182002e388fa`。immutable snapshot/revision reuse
  の考えだけを参考にする。どちらからも source copy しない。
- `YumNumm/flutter_scene` は未作成。repo/fork作成はこの計画の権限外であり Gate A の blocker。
- #1612 が参照する `docs/superpowers/specs/2026-08-07-eqmonitor-map-seismicity-github-issues.md`
  は local/live refs にない。Issue本文と現存design docsをcontractとし、gapをPRへ残す。

## Public API

`package:flutter_scene/scene.dart` から次だけを export する。EQMonitor は `src/`、
`package:flutter_gpu/`、internal annotation API を import/call しない。

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
  const PersistentGpuMemorySnapshot({
    required this.contextState,
    required this.lifecycleState,
    required this.contextGeneration,
    required this.latestSubmission,
    required this.completedThrough,
    required this.global,
    required this.owner,
  });
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

public lifecycle constructor は process-global registry へ owner をattachする。test-only
`@internal PersistentGpuResourceLifecycle.forRegistry(PersistentGpuResourceRegistry registry)` だけ
injected registry を使う。public/internal Future methods は
`async` にせず cached Future を直接返し、`identical` を契約に含める。

## Safety invariants

1. layout は slot0 vertex / slot1 instance exactly 2 buffers。buffer/attribute list、ByteData、
   mutable `Aabb3` は caller mutation から防御する。
2. count/stride/offset/length/alignment/finite bounds/index width/valueをupload前に検証。
   empty name、duplicate name、attribute overlap、negative、overflow は `ArgumentError`。
3. per-buffer/total maxは `0x7fffffff`。multiply/add/align/end-offsetは除算/差分で
   overflow前に検査し、overflow後の値を作らない。
4. vertex+instance は1 non-index host-visible buffer、instance offsetは16-byte alignment。
   optional indexは別buffer。
5. non-indexはvertex/instance各1回overwrite成功後、exact
   `flush(offsetInBytes: 0, lengthInBytes: nonIndexBytes)` 1回。indexはoverwrite成功後、exact
   `flush(offsetInBytes: 0, lengthInBytes: indexBytes)` 1回。失敗後は後続write/flushなし。
6. 両bufferのwrite/flush成功後だけviewsをpublish/registerする。失敗はrefsをclearしてrethrow。
7. source bytesはupload後保持せず、superclass `setVertices/setVertexStreams/setIndices` を使わない。
8. bindはcurrent-state check→`markUsed`→slot0→slot1→optional index→small `FrameInfo`。
   per-frame instance upload/full scanなし。
9. `FrameInfo` は std140 36 floats exactly: camera transform `[0..15]`、model transform
   `[16..31]`、camera position `[32..34]`、padding `[35]`。`shaderOverride ?? vertexShader` の
   `FrameInfo` slotへbindする。consumer shaderはこのblockとlayout/varying contractを宣言する。
10. `depthOnlyVertex == null`。既存 depth/shadow/selection はfull normal `bind`を再利用する。
11. `bindsModelTransformInstance == false`。external `draw(instanceCount != 1)` はfail closed。
12. open-frame markとlast submissionは別管理。bind→retire→submitはcompletionまで保持、
    no-submitは`endFrame`で確定する。
13. generationはprocess-globalで1開始。invalidating→全settle→invalidated→recreateだけが+1。
14. release failureはglobal failed。残りretirementは続けるがbind/register/recreateを拒否。
15. snapshotはlogical references。global/owner、active/retiring/failed、total/instanceを分ける。

## State machines

### Allocation record

Internal states: `active`, `retirementPendingOpenFrame`,
`retirementPendingSubmission`, `releasing`, `retired`, `retirementFailed`。
public は両pendingを `retirementPending` にcollapseする。

| current | event / guard | next/effect |
|---|---|---|
| active | markUsed、frame open/current | active + open mark |
| active | retire、open mark | pendingOpenFrame、cached Future、retain |
| pendingOpenFrame | beforeSubmit(id) | pendingSubmission、mark clear、last=id |
| pendingOpenFrame | endFrame no-submit | releasing、またはpast in-flight待ち |
| active | beforeSubmit(id) after mark | active、last=max(old,id) |
| active | retire after watermark | releasing immediately |
| pendingSubmission | watermark < last | retain |
| pendingSubmission | watermark >= last | releasing、callback once |
| releasing | repeated/reentrant retire | same state、identical Future |
| releasing | callback success | retired、accounting remove、Future success |
| releasing | callback throws | retirementFailed、failed bytes、global failed |
| retired/failed | repeated retire | same、original Future |

`beginFrame` nested、closed `endFrame`、closed `markUsed` は `StateError`。invalidationが
open frame中でも既存marksはbeforeSubmit/endFrame処理を継続し、新規markだけ拒否する。
completion trackerはpending set更新→watermark計算→listener snapshotをregistration順に呼ぶ。
unknown/duplicate completionは通知しない。settle順は resource Future → owner FD → global FI。

### Owner/context operations

`FI` はgenerationごとのcached invalidate Future、`FD` はownerごとのdispose Future、
`FE` はdisposed owner invalid-operation Future。

| owner | context | operation | result |
|---|---|---|---|
| active | active | invalidate | global→invalidating、全owner retire、FI |
| active | invalidating/invalidated/failed | invalidate | mutationなし、identical FI |
| disposed | any | invalidate | mutationなし、identical FE |
| active | invalidated | recreate | failed record 0確認、generation+1、active |
| active | active/invalidating/failed | recreate | synchronous StateError |
| disposed | any | recreate | synchronous StateError |
| active | any | dispose | owner→disposed、owner records retire、FD |
| disposed | any | dispose | mutationなし、identical FD |
| either | any | snapshot/getters | read-only |
| new owner | active | constructor | attach active handle |
| new owner | invalidated | constructor | recovery owner attach、resource作成拒否、recreateのみ |
| new owner | invalidating/failed | constructor | synchronous StateError、attachなし |

最後のownerがinvalidating中にdisposeされてもregistry/FIは残り、owner 0でinvalidatedへ進む。
後からattachしたrecovery ownerだけがrecreateできる。dispose during invalidationはFIをcancelせず、
FDが先に完了してもFIは他ownerを待つ。最初のrelease errorをcontext causeにし、後続errorは
test-only ordered logへ保存する。

### Resource operation matrix

| operation | owner/context/resource | result |
|---|---|---|
| construct/register | active/active/new | upload成功後だけregister |
| construct/register | disposed or non-active context | StateError、register 0 |
| bind/markUsed | active/active/current active + frame open | mark後にpass mutation |
| bind/markUsed | 他の全組合せ | StateError、pass event 0 |
| draw(1) | engine bind→draw契約内のcurrent active | state再検証後stored countsでdraw |
| draw(!=1) | any | StateError、draw event 0 |
| retire first | any owner/context、live record | state table、cached Future |
| retire repeated | pending/releasing/terminal | identical Future、mutationなし |
| owner dispose | active owner | owner recordsのretire Futureを共有 |
| invalidation | active owner/active context | context stateを先に変え全records retire |
| completion | pending、watermark >= last | release exactly once |
| release failure | releasing | resource/context failed、残り継続 |

## Exact internal seams (never public-exported)

mock frameworkや汎用factoryは追加せず、native GPU objectをtestから除く最小境界だけを置く。

```dart
typedef GpuSubmissionCompletionListener = void Function(int completedThrough);

final class PersistentGpuResourceRegistry {
  PersistentGpuResourceRegistry({
    required GpuSubmissionTracker submissions,
    required PersistentGpuExecutionAffinity affinity,
  });
}

final PersistentGpuResourceRegistry persistentGpuResourceRegistry =
    PersistentGpuResourceRegistry(
      submissions: rendererSubmissions,
      affinity: PersistentGpuExecutionAffinity(),
    );

@visibleForTesting
void runPersistentGpuEncodeScope({
  required void Function() beginFrame,
  required void Function() encode,
  required void Function() endFrame,
});

abstract interface class PersistentPackedGpuSlice {
  int get lengthInBytes;
}

abstract interface class PersistentPackedGpuBuffer {
  bool overwrite(ByteData source, {required int destinationOffsetInBytes});
  void flush({required int offsetInBytes, required int lengthInBytes});
  PersistentPackedGpuSlice slice({
    required int offsetInBytes,
    required int lengthInBytes,
  });
  void release();
}

abstract interface class PersistentPackedGpuBackend {
  PersistentPackedGpuBuffer allocate({required int lengthInBytes});
}

abstract interface class PersistentPackedRenderPassAdapter {
  void bindVertex({
    required PersistentPackedGpuSlice slice,
    required int slot,
    required int vertexCount,
  });
  void bindIndex({
    required PersistentPackedGpuSlice slice,
    required gpu.IndexType indexType,
    required int indexCount,
  });
  void bindFrameInfo({
    required gpu.Shader shader,
    required TransientWriter transients,
    required vm.Matrix4 modelTransform,
    required vm.Matrix4 cameraTransform,
    required vm.Vector3 cameraPosition,
  });
  void draw({
    required int vertexCount,
    required int indexCount,
    required int instanceCount,
  });
}
```

production backend/adapterだけが `gpu.DeviceBuffer`/`gpu.RenderPass` を保持する。Geometry public
constructorはplan→storage→lease→private `_fromParts`へ委譲する。fork testだけがsrc importの
`createPersistentPackedInstanceGeometryForTesting({required plan, required storage, required lease, required shader, required doubleSided})`、
`bindPersistentPackedInstanceGeometryForTesting({required geometry, required adapter, required transients, required modelTransform, required cameraTransform, required cameraPosition, gpu.Shader? shaderOverride})`、
`drawPersistentPackedInstanceGeometryForTesting({required geometry, required adapter, int instanceCount = 1})`
を使う。public `bind` は Public API のexact signatureで production adapter をその場で作り、同じprivate bindへ
委譲する。public `draw` もpassごとにproduction adapterを作り、同じprivate drawへ委譲する。
helpers/backend/adapter/private constructorはpublic barrelからexportしない。

| seam | exact owner file | direct consumer |
|---|---|---|
| `GpuSubmissionCompletionListener` / `addCompletionListener` | `lib/src/render/frame_transients.dart` | registry constructor |
| `PersistentGpuResourceRegistry` / `persistentGpuResourceRegistry` | `lib/src/render/persistent_gpu_resource_registry.dart` | lifecycle and Scene wrapper |
| `runPersistentGpuEncodeScope` | `lib/src/render/persistent_gpu_scene_frame.dart` | `lib/src/scene.dart` |
| backend/buffer/slice interfaces and device wrappers | `lib/src/geometry/persistent_packed_gpu_backend.dart` | storage transaction |
| adapter interface and GPU adapter | `lib/src/geometry/persistent_packed_render_pass.dart` | Geometry bind/draw |
| private `_fromParts` and three test helpers | `lib/src/geometry/persistent_packed_instance_geometry.dart` | public constructor and src-only tests |

## Repository / stack

repositoryを跨ぐ1 stackは作れない。forkは2 PR stack、EQMonitor pinは#1601の上またはdevelopへの
standalone PRで、fork top full SHAをhandoffする。

```text
YumNumm/flutter_scene
eqmonitor/flutter-4dacd3fc (exact 7f71993b7e2a0ab1d2f59726a406098709be7291, PRなし)
└─ feat/persistent-gpu-lifecycle
   └─ feat/persistent-packed-instance-geometry

YumNumm/EQMonitor
#1601 decoder OPEN ─└─ feat/seismicity-flutter-scene-fork-pin
or #1601 MERGED     develop ─└─ same pin branch (standalone PR)
```

current upstream masterへ直接実装せず、exact compatibility trunkを作る。forward-portは別follow-up。

## Execution gates (no commit)

### Gate A: fork authority

このplanはrepo/fork作成権限を含まない。owner/adminが `YumNumm/flutter_scene` を
`bdero/flutter_scene` のforkとして作成した後だけ続行する。agentは`gh repo fork/create`しない。

```bash
fork_authority=$(gh repo view YumNumm/flutter_scene \
  --json nameWithOwner,parent,defaultBranchRef,viewerPermission \
  --jq 'select(.nameWithOwner == "YumNumm/flutter_scene") |
        select(.parent.nameWithOwner == "bdero/flutter_scene") |
        select(.defaultBranchRef.name != null and .defaultBranchRef.name != "") |
        select(.viewerPermission == "ADMIN" or .viewerPermission == "MAINTAIN" or
               .viewerPermission == "WRITE") |
        [.nameWithOwner,.parent.nameWithOwner,.defaultBranchRef.name,.viewerPermission] | @tsv')
test -n "$fork_authority"
test "$(printf '%s\n' "$fork_authority" | wc -l | tr -d ' ')" -eq 1
```

空/複数/errorなら停止。`jq select`のexit 0だけを成功扱いせず、代替repoを推測しない。

### Gate B: clone, exact refs, reviewed resume

clone pathは `/Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene`。不存在時だけclone、
存在時はgit worktreeかつorigin exact `git@github.com:YumNumm/flutter_scene.git` をassert。
upstreamは exact `https://github.com/bdero/flutter_scene.git`、base commitをfetch/cat-fileする。
`.worktrees`はignoreされないのでworktreeはclone外
`/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle`。

```bash
fork_clone=/Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene
if [ -e "$fork_clone" ]; then
  test "$(git -C "$fork_clone" rev-parse --is-inside-work-tree)" = true
  test "$(git -C "$fork_clone" remote get-url origin)" = \
    git@github.com:YumNumm/flutter_scene.git
else
  git clone --origin origin git@github.com:YumNumm/flutter_scene.git "$fork_clone"
fi
if upstream_url=$(git -C "$fork_clone" remote get-url upstream 2>/dev/null); then
  test "$upstream_url" = https://github.com/bdero/flutter_scene.git
else
  git -C "$fork_clone" remote add upstream https://github.com/bdero/flutter_scene.git
fi
git -C "$fork_clone" fetch upstream master
git -C "$fork_clone" cat-file -e \
  7f71993b7e2a0ab1d2f59726a406098709be7291^{commit}
if git -C "$fork_clone" check-ignore -q .worktrees; then
  exit 1
else
  test "$?" -eq 1
fi
```

compat remote ref `eqmonitor/flutter-4dacd3fc` は不存在時だけ exact baseをnon-force push。
既存ならadvertised SHA exact baseを要求する。feature ref既存時はsupervisorが直前reviewで承認した
full `reviewed_bottom_resume_sha` と一致するときだけresumeする。

```bash
compat_ref=refs/heads/eqmonitor/flutter-4dacd3fc
if compat_line=$(git -C "$fork_clone" ls-remote --exit-code origin "$compat_ref"); then
  test "$(printf '%s\n' "$compat_line" | wc -l | tr -d ' ')" -eq 1
  printf '%s\n' "$compat_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/eqmonitor/flutter-4dacd3fc$'
  test "${compat_line%%[[:space:]]*}" = \
    7f71993b7e2a0ab1d2f59726a406098709be7291
else
  test "$?" -eq 2
  git -C "$fork_clone" push origin \
    7f71993b7e2a0ab1d2f59726a406098709be7291:"$compat_ref"
fi
git -C "$fork_clone" fetch origin \
  "$compat_ref:refs/remotes/origin/eqmonitor/flutter-4dacd3fc"
test "$(git -C "$fork_clone" rev-parse origin/eqmonitor/flutter-4dacd3fc)" = \
  7f71993b7e2a0ab1d2f59726a406098709be7291

bottom_ref=refs/heads/feat/persistent-gpu-lifecycle
if remote_line=$(git -C "$fork_clone" ls-remote --exit-code origin "$bottom_ref"); then
  test "$(printf '%s\n' "$remote_line" | wc -l | tr -d ' ')" -eq 1
  printf '%s\n' "$remote_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/feat/persistent-gpu-lifecycle$'
  remote_bottom_head=${remote_line%%[[:space:]]*}
  printf '%s\n' "$reviewed_bottom_resume_sha" | rg -q '^[0-9a-f]{40}$'
  test "$remote_bottom_head" = "$reviewed_bottom_resume_sha"
  git -C "$fork_clone" fetch origin \
    "$bottom_ref:refs/remotes/origin/feat/persistent-gpu-lifecycle"
  git -C "$fork_clone" cat-file -e "$remote_bottom_head^{commit}"
else
  test "$?" -eq 2
  remote_bottom_head=7f71993b7e2a0ab1d2f59726a406098709be7291
fi
```

target/branch不存在ならexact `$remote_bottom_head`から作る。既存target/branchはregistered path、
origin、branch、clean、base ancestry、local=remote advertised headをassert。mismatch時は停止。
`rerere.enabled=true`、`remote.pushDefault=origin`後、metadata不存在時だけ
`gh stack init --base eqmonitor/flutter-4dacd3fc feat/persistent-gpu-lifecycle`。
既存metadataは `gh stack view --json` のnon-empty JSONでtrunk/branchをassertする。

```bash
fork_worktree=/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
mkdir -p /Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees
if [ -e "$fork_worktree" ]; then
  git -C "$fork_clone" worktree list --porcelain | \
    rg -Fx "worktree $fork_worktree"
elif git -C "$fork_clone" show-ref --verify --quiet \
  refs/heads/feat/persistent-gpu-lifecycle; then
  test "$(git -C "$fork_clone" rev-parse feat/persistent-gpu-lifecycle)" = \
    "$remote_bottom_head"
  git -C "$fork_clone" worktree add "$fork_worktree" \
    feat/persistent-gpu-lifecycle
else
  git -C "$fork_clone" worktree add -b feat/persistent-gpu-lifecycle \
    "$fork_worktree" "$remote_bottom_head"
fi
test "$(git -C "$fork_worktree" remote get-url origin)" = \
  git@github.com:YumNumm/flutter_scene.git
test "$(git -C "$fork_worktree" rev-parse --abbrev-ref HEAD)" = \
  feat/persistent-gpu-lifecycle
test "$(git -C "$fork_worktree" rev-parse HEAD)" = "$remote_bottom_head"
git -C "$fork_worktree" merge-base --is-ancestor \
  7f71993b7e2a0ab1d2f59726a406098709be7291 HEAD
test -z "$(git -C "$fork_worktree" status --porcelain=v1)"
git -C "$fork_clone" config rerere.enabled true
git -C "$fork_clone" config remote.pushDefault origin
cd "$fork_worktree"
if stack_json=$(gh stack view --json 2>/dev/null); then
  test -n "$stack_json"
  printf '%s\n' "$stack_json" | jq -e \
    '.trunk == "eqmonitor/flutter-4dacd3fc" and
     .currentBranch == "feat/persistent-gpu-lifecycle" and
     (([.branches[].name] == ["feat/persistent-gpu-lifecycle"]) or
      ([.branches[].name] == ["feat/persistent-gpu-lifecycle",
                             "feat/persistent-packed-instance-geometry"]))' >/dev/null
else
  test "$?" -eq 2
  gh stack init --base eqmonitor/flutter-4dacd3fc \
    feat/persistent-gpu-lifecycle
fi
```

### Gate C: toolchain/baseline

```bash
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter --version --machine
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter pub get
cd packages/flutter_scene
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter test --enable-impeller test/render/frame_transients_test.dart
```

version JSON framework SHA不一致なら停止。baseline failureは今回差分と分離しpass扱いしない。

## Task execution protocol

各Taskは記載file以外を変更せず、目標30–100 handwritten changed lines。RED commandは対象test名を
plain-name filterで実行し記載failureを確認、GREENは最小実装、focused + regression +
`mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .` +
`git --no-pager diff --check`。別agentのspec/code reviewで0 findings後、
記載commit messageでcommitし `git push`。Task間のgenerated formatting driftは戻し、dirtyを残さない。
Commit前に `git --no-pager diff --numstat HEAD --` の後へそのTaskの `Files` exact pathsを並べて
結果を保存し、generated lockを除く
handwritten追加+削除が見積範囲かつ30–100であることをassertする。外れたらcommitせず、隣の責務を
混ぜずTaskを再分割してfresh reviewする。

Fork task はtableのexact `red_file` とliteral titleを変数へ代入し、次の4 commandを
そのまま実行する。REDはmissing symbol/behaviorでfail、GREENは同じfile全体がpass、analyzeと
diff checkもpassを要求する。`Verify/publish` の末尾はそのTaskだけのcommit boundaryである。
Task N はそのrowの `red_file` を第1引数、literal titleを第2引数として
`run_fork_red` を呼び、実装後は同じ `red_file` を唯一の引数として `run_fork_green` を呼ぶ。

```bash
run_fork_red() {
  test "$#" -eq 2
  mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    flutter test --enable-impeller "$1" --plain-name "$2"
}
run_fork_green() {
  test "$#" -eq 1
  mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    flutter test --enable-impeller "$1"
  mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    dart analyze .
  git --no-pager diff --check
}
```

| Task | exact `red_file` | literal RED title / expected initial failure |
|---|---|---|
| 1 | `test/render/gpu_submission_tracker_test.dart` | `completion listeners observe the contiguous watermark in order` / method missing |
| 2 | `test/render/persistent_gpu_resource_models_test.dart` | `public usage value preserves every logical field` / type missing |
| 3 | `test/render/persistent_gpu_resource_models_test.dart` | `snapshot is immutable and mutations stay on one isolate` / types missing |
| 4 | `test/render/persistent_gpu_resource_registry_test.dart` | `allocation registration validates owner and bytes first` / registry missing |
| 5 | `test/render/persistent_gpu_resource_registry_test.dart` | `snapshot separates global and owner active bytes` / snapshot method missing |
| 6 | `test/render/persistent_gpu_resource_registry_test.dart` | `open frame without submission retires only at end` / frame API missing |
| 7 | `test/render/persistent_gpu_resource_registry_test.dart` | `retire during open frame stamps the next submission` / no stamp |
| 8 | `test/render/persistent_gpu_resource_registry_test.dart` | `completion before retirement releases immediately` / listener not wired |
| 9 | `test/render/persistent_gpu_resource_registry_test.dart` | `release failure is terminal and preserves error order` / failed state absent |
| 10 | `test/render/persistent_gpu_resource_registry_test.dart` | `owner disposal leaves other owners active` / disposeOwner missing |
| 11 | `test/render/persistent_gpu_resource_registry_test.dart` | `one owner invalidates every owner in the generation` / invalidate missing |
| 12 | `test/render/persistent_gpu_resource_registry_test.dart` | `last disposed owner can be followed by invalidated recovery owner` / attach rejected |
| 13 | `test/render/persistent_gpu_resource_lifecycle_test.dart` | `lifecycle handles share global state and isolate owner usage` / lifecycle missing |
| 14 | `test/render/persistent_gpu_resource_lifecycle_test.dart` | `lifecycle operation matrix preserves cached Future identity` / operations missing |
| 15 | `test/render/persistent_gpu_scene_frame_test.dart` | `encode scope closes after the original encode failure` / seam missing |
| 16 | `test/render/persistent_gpu_scene_integration_test.dart` | `Scene renderViews owns exactly one persistent encode scope` / wrapper absent |
| 17 | `test/render/persistent_gpu_lifecycle_public_api_test.dart` | `public lifecycle barrel hides registry internals` / export absent |
| 18 | `test/render/persistent_gpu_lifecycle_public_api_test.dart` | `README states the terminal lifecycle ordering` / phrases absent |
| 19 | `test/persistent_packed_instance_plan_test.dart` | `checked arithmetic rejects before overflow` / math missing |
| 20 | `test/persistent_packed_instance_plan_test.dart` | `layout is deeply snapshotted before caller mutation` / snapshot missing |
| 21 | `test/persistent_packed_instance_plan_test.dart` | `layout rejects invalid slots names and strides` / policy missing |
| 22 | `test/persistent_packed_instance_plan_test.dart` | `layout rejects overlapping checked attribute ranges` / overlap accepted |
| 23 | `test/persistent_packed_instance_plan_test.dart` | `bounds getters cannot mutate the stored snapshot` / bounds missing |
| 24 | `test/persistent_packed_instance_plan_test.dart` | `index byte shape matches its exact width` / plan missing |
| 25 | `test/persistent_packed_instance_plan_test.dart` | `every index is smaller than vertexCount` / out-of-range accepted |
| 26 | `test/persistent_packed_instance_plan_test.dart` | `allocation sizes use checked multiply align and add` / sizing missing |
| 27 | `test/persistent_packed_instance_plan_test.dart` | `composite plan retains no caller-owned source` / composite missing |
| 28 | `test/persistent_packed_instance_plan_test.dart` | `upload executor writes each source exactly once` / executor missing |
| 29 | `test/persistent_packed_gpu_backend_test.dart` | `GPU backend preserves typed offsets ranges and release` / seam missing |
| 30 | `test/persistent_packed_instance_storage_test.dart` | `non-index upload flushes once before returning the buffer` / transaction missing |
| 31 | `test/persistent_packed_instance_storage_test.dart` | `indexed upload publishes slices only after both flushes` / storage missing |
| 32 | `test/persistent_packed_instance_storage_test.dart` | `storage release clears every slice exactly once` / release missing |
| 33 | `test/persistent_packed_instance_geometry_test.dart` | `Geometry bounds getters return defensive copies` / Geometry missing |
| 34 | `test/persistent_packed_instance_geometry_test.dart` | `Geometry registers only after successful upload` / constructor missing |
| 35 | `test/persistent_packed_instance_geometry_test.dart` | `Geometry retirement is the lease Future` / delegation missing |
| 36 | `test/persistent_packed_render_pass_test.dart` | `RenderPass adapter packs the exact 36-float FrameInfo` / adapter missing |
| 37 | `test/persistent_packed_instance_geometry_test.dart` | `bind marks use before two persistent buffer slots` / bind missing |
| 38 | `test/persistent_packed_instance_geometry_test.dart` | `depth shadow and selection choose full bind for packed Geometry` / draw route missing |
| 39 | `test/shader_material_vertex_test.dart` | `ShaderMaterial keeps the packed instance variant exact` / enum missing |
| 40 | `test/persistent_packed_instance_public_api_test.dart` | `public Geometry barrel hides storage and adapter seams` / export absent |
| 41 | `test/persistent_packed_instance_public_api_test.dart` | `README states one upload and the 36-float shader contract` / phrases absent |

Tasks 42–46 use their listed package/shell/doc command because Task42 intentionally changes dependency
resolution and Tasks43–46 are not fork Dart unit tests。

## Bottom PR tasks: lifecycle and retirement

### Task 1: completion watermark listener (depends Gate C; 35–65 lines)

**Files:** Modify `lib/src/render/frame_transients.dart`; Create
`test/render/gpu_submission_tracker_test.dart`。

**Produces:** `addCompletionListener(GpuSubmissionCompletionListener listener)`。

- [ ] **RED:** add the exact ordering case below; focused test expects missing method.

  ```dart
  final a = tracker.record(), b = tracker.record();
  tracker.complete(b);
  expect(seen, isEmpty);
  tracker.complete(a);
  expect(seen, ['first:2', 'second:2']);
  tracker..complete(a)..complete(999);
  expect(seen, ['first:2', 'second:2']);
  ```

- [ ] **GREEN:** notify a registration-order snapshot only when `_pending.remove(id)` is true and the
  contiguous watermark advances. Preserve record/before-submit signatures.
- [ ] **Verify/publish:** tracker + frame transients tests; `Feature: GPU submission完了通知を追加`。

### Task 2: public enums and usage value (depends Task 1; 45–85 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_models.dart`,
`test/render/persistent_gpu_resource_models_test.dart`。

**Produces:** exactly 3 enums (`PersistentGpuContextState`,
`PersistentGpuResourceLifecycleState`, `PersistentGpuResourceState`) and
`PersistentGpuMemoryUsage` from Public API。

- [ ] **RED:** construct usage with values 1..9 and assert every final field; reference all 3 enum types.
- [ ] **GREEN:** one `@immutable final class`, const named constructor, no equality/factory/codegen.
- [ ] **Verify/publish:** focused test; `Feature: GPU resource状態値を追加`。

### Task 3: snapshot value and isolate affinity (depends Task 2; 50–95 lines)

**Files:** Modify models; Create `lib/src/render/persistent_gpu_execution_affinity.dart`; Modify models test。

**Produces:** exact const `PersistentGpuMemorySnapshot` constructor from Public API and
`PersistentGpuExecutionAffinity({Object Function()? currentIsolateToken})`, `void check()`。

- [ ] **RED:** assert every snapshot field and this identity failure:

  ```dart
  var token = Object();
  final affinity = PersistentGpuExecutionAffinity(currentIsolateToken: () => token);
  affinity.check();
  token = Object();
  expect(affinity.check, throwsStateError);
  ```

- [ ] **GREEN:** default captures `Isolate.current.controlPort`; compare token, not hash.
- [ ] **Verify/publish:** models test; `Feature: GPU snapshotとisolate制約を追加`。

### Task 4: owner attach and allocation record (depends Task 3; 55–95 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_registry.dart`,
`test/render/persistent_gpu_resource_registry_test.dart`。

**Produces:** exact registry constructor seam, `int attachOwner()`, and
`PersistentGpuResourceLease register({required int ownerId, required int totalBytes, required int instanceBytes, required void Function() release})`。

- [ ] **RED:** owner 1/2 are monotonic; unknown owner, `total < instance`, negative bytes, and
  affinity mismatch throw before record/release mutation.
- [ ] **GREEN:** record only ownerId/generation/bytes/release/cached completer; require
  `totalBytes >= instanceBytes >= 0` and active current generation.
- [ ] **Verify/publish:** registry test; `Feature: GPU allocation recordを追加`。

### Task 5: active memory snapshot accounting (depends Task 4; 45–90 lines)

**Files:** Modify registry and registry test。

**Produces:**
`snapshotFor({required int ownerId, required PersistentGpuResourceLifecycleState lifecycleState})`。

- [ ] **RED:** register A `(64,24)` and B `(96,48)`; assert global count/total/instance
  `2/160/72`, owner A `1/64/24`, generation 1, tracker latest/completed exact; unknown owner fails.
- [ ] **GREEN:** fold records once into global and selected-owner active/retiring/failed buckets;
  return immutable snapshot, never driver bytes.
- [ ] **Verify/publish:** registry + models; `Feature: GPU memory集計を追加`。

### Task 6: explicit begin/mark/end frame (depends Task 5; 55–95 lines)

**Files:** Modify registry and registry test。

**Produces:** `beginFrame()`, `markUsed(PersistentGpuResourceLease lease)`, `endFrame()`。

- [ ] **RED:** `begin→mark→retire→end(no submit)` releases once; double mark is one mark.
  Nested begin、closed end/mark、foreign lease、retired lease all throw before mutation.
- [ ] **GREEN:** own `_frameOpen` and identity set; open retire becomes pending-open;
  no-submit end clears marks and releases only with no older in-flight id.
- [ ] **Verify/publish:** registry test; `Feature: GPU resource frame記録を追加`。

### Task 7: before-submit stamping (depends Task 6; 40–80 lines)

**Files:** Modify registry and registry test。

**Produces:** constructor registers exactly one tracker before-submit listener; record stores nullable
`lastSubmission`。

- [ ] **RED:** `begin→mark→retire→record` stays pending with last=1/release=0; two submits use
  last=2; simulated invalidation rejects new mark but stamps the existing mark.
- [ ] **GREEN:** listener snapshots+clears marks, applies `max(previous,id)` to active and pending-open
  records, and never settles a Future.
- [ ] **Verify/publish:** registry + tracker; `Feature: GPU submission stampを追加`。

### Task 8: completion-gated successful retirement (depends Task 7; 55–95 lines)

**Files:** Modify registry and registry test。

**Produces:** lease `generation/state/Future<void> retire()` with one cached Future; one completion listener。

- [ ] **RED:** cover `(submit→complete→retire)`, `(mark→retire→submit→complete)`, and ids 2→1;
  each asserts `identical(retire(), retire())`, no early release, callback count 1.
- [ ] **GREEN:** set `releasing` before callback; release an eligible snapshot only when
  `lastSubmission == null || lastSubmission <= completedThrough`; success removes accounting then completes.
- [ ] **Verify/publish:** registry + tracker; `Feature: GPU completion後にresourceを解放`。

### Task 9: release failure and reentrant retire (depends Task 8; 55–95 lines)

**Files:** Modify registry and registry test。

**Produces:** terminal failed accounting and test-only ordered `failureLog`。

- [ ] **RED:** record A release callback calls its own `retire()` and snapshot, then throws `firstError`;
  record B release callback throws `secondError`. Complete the shared submission and assert each callback once,
  identical A Future, both resources/context failed, both failed-byte entries retained, ordered log
  `[firstError, secondError]`.
- [ ] **GREEN:** state/accounting move before callback; first release error is context cause; later
  errors append in order; other records keep retiring.
- [ ] **Verify/publish:** registry test; `Fix: GPU release失敗をterminal化`。

### Task 10: owner disposal (depends Task 9; 50–90 lines)

**Files:** Modify registry and registry test。

**Produces:** `Future<void> disposeOwner(int ownerId)` and owner terminal/cached FD storage。

- [ ] **RED:** dispose A retires only A while B remains active; disposed A snapshot is readable;
  repeated dispose is identical; resource Future settles before FD; unknown owner fails.
- [ ] **GREEN:** owner state changes before retiring a record snapshot; FD waits only that owner's
  current-generation records and propagates its first error.
- [ ] **Verify/publish:** registry test; `Feature: GPU resource owner破棄を追加`。

### Task 11: global invalidation (depends Task 10; 55–100 lines)

**Files:** Modify registry and registry test。

**Produces:** `Future<void> invalidateContext(int ownerId)` and generation-cached FI。

- [ ] **RED:** A invalidates resources owned by A/B; global becomes invalidating immediately;
  register/mark reject; A/B receive identical FI; open mark still stamps/waits; FI settles after
  all resources and FD in resource→FD→FI order.
- [ ] **GREEN:** validate active owner, set global state first, retire a snapshot of all current-generation
  records, cache FI once, finalize invalidated only after every record settles.
- [ ] **Verify/publish:** registry test; `Feature: global GPU invalidationを追加`。

### Task 12: recreate and last-owner recovery (depends Task 11; 55–100 lines)

**Files:** Modify registry and registry test。

**Produces:** `void recreateContext(int ownerId)`; `attachOwner()` accepts active and invalidated only。

- [ ] **RED:** last owner dispose during invalidating leaves registry/FI alive; owner count 0 reaches
  invalidated; new recovery owner attaches, cannot register, recreates once generation 1→2, then registers.
  Attach invalidating/failed and recreate active/invalidating/failed/disposed all fail.
- [ ] **GREEN:** registry lifetime is process-global; invalidated attach creates recovery handle;
  recreate verifies no failed record, increments once, clears old FI, activates.
- [ ] **Verify/publish:** registry test; `Feature: GPU generation再作成を追加`。

### Task 13: public lifecycle handle core (depends Task 12; 55–95 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_lifecycle.dart`,
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Produces:** public/global attach constructor using exact `persistentGpuResourceRegistry`,
`@internal forRegistry`, getters/snapshot, internal `registerAllocation` and `markUsed` delegation。

- [ ] **RED:** two injected handles share context/generation/global snapshot but have distinct owner
  usage; public getters match registry; disposed/internal-invalid calls fail before registry mutation.
- [ ] **GREEN:** handle stores registry/ownerId/cached FE only; process global is exactly one registry
  using `rendererSubmissions` and one affinity.
- [ ] **Verify/publish:** lifecycle + registry; `Feature: persistent GPU lifecycleを追加`。

### Task 14: lifecycle operation matrix and Future identity (depends Task 13; 60–100 lines)

**Files:** Modify lifecycle and lifecycle test。

**Produces:** `invalidateContext`, `recreateContext`, `dispose` exact owner table semantics。

- [ ] **RED:** parameterize every owner/context row. Assert FI shared across owners, next-generation FI
  differs, FD owner-specific/not FI, disposed invalidate repeats FE, dispose during invalidation waits own
  records only, release callback reentry `dispose/invalidate/snapshot` releases once.
- [ ] **GREEN:** return registry FD/FI directly without `async`; disposed check precedes global call;
  only FE lives on the handle.
- [ ] **Verify/publish:** lifecycle + registry; `Feature: lifecycle操作表を固定`。

### Task 15: encode-scope try/finally seam (depends Task 14; 35–70 lines)

**Files:** Create `lib/src/render/persistent_gpu_scene_frame.dart`,
`test/render/persistent_gpu_scene_frame_test.dart`。

**Produces:** exact `runPersistentGpuEncodeScope` seam。

- [ ] **RED:** events normal `begin,encode,end`; encode throw still ends and rethrows same error/stack;
  end-only throw propagates; begin throw runs neither encode nor end.
- [ ] **GREEN:** capture `(Object, StackTrace)?` from encode, call end exactly once, use
  `Error.throwWithStackTrace`; if encode/end both fail preserve encode as primary.
- [ ] **Verify/publish:** seam test; `Feature: GPU encode scopeを追加`。

### Task 16: Scene frame integration (depends Task 15; 35–80 lines)

**Files:** Modify `lib/src/scene.dart`; Create
`test/render/persistent_gpu_scene_integration_test.dart`。

**Produces:** public `renderViews` wrapper and renamed private `_renderViewsImpl`; no body reindent。

- [ ] **RED:** injected callbacks around encode assert normal/empty/throw ordering; source contract asserts
  `renderViews` calls `runPersistentGpuEncodeScope` and only its `encode` calls `_renderViewsImpl`.
- [ ] **GREEN:** rename existing method only; add <=20-line wrapper passing
  `persistentGpuResourceRegistry.beginFrame`,
  `() => _renderViewsImpl(views, canvas, region: region, pixelRatio: pixelRatio)`, and
  `persistentGpuResourceRegistry.endFrame`.
  `render` and warm-up keep calling public wrapper.
- [ ] **Verify/publish:** new test + render graph tests; `Feature: SceneへGPU lifecycleを接続`。

### Task 17: lifecycle curated export contract (depends Task 16; 35–70 lines)

**Files:** Modify `lib/src/scene.dart`, `lib/scene.dart`; Create
`test/render/persistent_gpu_lifecycle_public_api_test.dart`。

**Produces:** lifecycle, exactly 3 enums, usage/snapshot; no registry/lease/affinity/test seam export。

- [ ] **RED:** public-only import constructs lifecycle, reads active/generation 1/zero snapshot; source
  assertion rejects internal symbols.
- [ ] **GREEN:** add curated show-list exports only.
- [ ] **Verify/publish:** public/lifecycle tests; `Feature: persistent GPU lifecycleを公開`。

### Task 18: lifecycle README contract (depends Task 17; 30–70 lines)

**Files:** Modify `README.md`; Modify public API test。

**Produces:** lifecycle shutdown/recreate sequence and logical/resident-memory documentation contract.

- [ ] **RED:** source expectation fails for exact sequence
  `stop rendering → detach → invalidate → await → recreate` and `logical bytes`/`resident` distinction.
- [ ] **GREEN:** document multi-owner global invalidation、terminal failure、logical≠resident、no automatic
  context-loss signal and no device-performance evidence.
- [ ] **Verify/publish:** public test + doc grep; `Docs: persistent GPU lifecycle契約を追加`。

### Delivery Gate BOTTOM (no commit)

- [ ] pinned format, `dart analyze .`, full `flutter test --enable-impeller`; record pass/fail/skip and
  exact framework SHA. GPU skip is not pass; no device/Simulator/E2E/profile.
- [ ] fresh spec/code reviewers compare API, matrices, Tasks 1–18 and diff; zero findings.
- [ ] fetch each advertised feature ref, cat-file its full head; assert clean/local=remote.
- [ ] Do not submit a one-PR "stack". Push bottom with `gh stack push --remote origin` if needed; create
  both fork PRs together only after top is finished using `gh stack submit --auto --open --remote origin`.
- [ ] Start top from clean reviewed bottom with `gh stack add feat/persistent-packed-instance-geometry`.
  Existing top resume requires supervisor-provided `reviewed_top_resume_sha`, advertised ref=head equality,
  fetch/cat-file, clean local=remote, bottom ancestry, then named `gh stack checkout`. Never reset/delete/force.

## Top PR tasks: persistent packed Geometry

### Task 19: checked allocation arithmetic (depends bottom approval; 45–80 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_plan.dart`,
`test/persistent_packed_instance_plan_test.dart`。

**Produces:** `kMaxPersistentPackedAllocationBytes = 0x7fffffff` and
`PersistentPackedCheckedMath.multiply/add/align16/endOffset` named-argument methods。

- [ ] **RED:** table exact `0*max=0`, `max+0=max`, `align16(1)=16`, plus negative,
  `max*2`, `max+1`, `align16(max)`, `endOffset(max,1)` errors containing name/operands.
- [ ] **GREEN:** multiply uses `left > max ~/ right` after zero case; add/end use
  `left > max-right`; align performs checked add before mask. No BigInt/float/wrapped intermediate.
- [ ] **Verify/publish:** plan test; `Feature: packed allocation計算を検証`。

### Task 20: deep layout snapshot (depends Task 19; 45–85 lines)

**Files:** Modify plan and plan test。

**Produces:** `PersistentPackedLayoutSnapshot.create(VertexLayoutDescriptor source)` with frozen
`layout`, vertex stride, instance stride。

- [ ] **RED:** valid 2-slot layout survives caller clearing/replacing source buffer/attribute lists;
  returned layout lists reject mutation and remain value equal.
- [ ] **GREEN:** reconstruct every descriptor/attribute field into `List.unmodifiable` before any
  validation; never retain caller lists.
- [ ] **Verify/publish:** plan + existing vertex layout test; `Feature: packed layoutを複製`。

### Task 21: layout slot/name/stride policy (depends Task 20; 45–85 lines)

**Files:** Modify plan and plan test。

**Produces:** exactly-two-slot semantic validation。

- [ ] **RED:** reject buffer count 0/1/3, slot0 non-vertex, slot1 non-instance, empty attribute list,
  empty/whitespace/surrounding-whitespace attribute name, duplicate name across slots, stride <=0;
  accept one valid layout.
- [ ] **GREEN:** require `name.isNotEmpty && name.trim() == name` without renaming; use one `Set<String>`
  across both slots;
  invoke existing `layout.toGpuLayout()` after policy checks to reuse duplicate/end lowering checks.
- [ ] **Verify/publish:** plan + vertex layout; `Feature: packed layout構造を検証`。

### Task 22: attribute alignment/overlap/checked end (depends Task 21; 55–95 lines)

**Files:** Modify plan and plan test。

**Produces:** complete per-slot byte-range validation before GPU lowering。

- [ ] **RED:** reject negative offset, checked `offset + bytesPerElement` overflow/max breach,
  end > stride, offset misaligned to `gcd(bytesPerElement,4)`, stride not multiple of slot max alignment,
  exact overlap `[0,12)` with `[8,12)`; accept adjacent `[0,8)` / `[8,12)`.
- [ ] **GREEN:** compute every end with Task19 `endOffset`, sort local `(start,end,name)` ranges by start,
  compare adjacent `next.start < current.end`; never form unchecked end before validation.
- [ ] **Verify/publish:** plan test; `Feature: packed attribute範囲を検証`。

### Task 23: defensive bounds snapshot (depends Task 22; 45–85 lines)

**Files:** Modify plan and plan test。

**Produces:** `PersistentPackedBoundsSnapshot.create(vm.Aabb3)`; getters return fresh copied
`vm.Aabb3` and `vm.Sphere`。

- [ ] **RED:** finite happy case; table NaN/±infinity/axis min>max and finite endpoints whose derived
  center/radius becomes non-finite. Mutate source min/max after create
  and mutate each returned Aabb3 min/max and Sphere center/radius; later getters remain canonical.
- [ ] **GREEN:** copy six scalar bounds, validate finite/order plus finite derived center/radius, retain
  private canonical vectors/scalar,
  build a fresh circumscribed sphere and Aabb3 for every getter. Do not expose inherited mutable values.
- [ ] **Verify/publish:** plan test; `Feature: packed boundsを防御的に固定`。

### Task 24: index byte-shape plan (depends Task 23; 35–75 lines)

**Files:** Modify plan and plan test。

**Produces:** `PersistentPackedIndexPlan.create({ByteData? data, gpu.IndexType type, int vertexCount})`
with `hasIndices/indexCount/indexBytes` and no retained input。

- [ ] **RED:** null accepts; non-null empty, int16 odd, int32 non-multiple-4, vertexCount<=0 reject;
  both supported enum widths compute exact counts.
- [ ] **GREEN:** exhaustive index-type switch, Task19 checked size policy, exact divisibility, no fallback type.
- [ ] **Verify/publish:** plan test; `Feature: packed index形状を検証`。

### Task 25: index value validation (depends Task 24; 40–80 lines)

**Files:** Modify plan and plan test。

**Produces:** every little-endian index constrained to `[0, vertexCount)` before upload。

- [ ] **RED:** for int16/int32 accept `[0,vertexCount-1]`; reject equal/larger and report element index/
  value/count. Mutating source after create does not change derived fields.
- [ ] **GREEN:** scan with `indexData.getUint16(byteOffset, Endian.little)` /
  `indexData.getUint32(byteOffset, Endian.little)` and retain no bytes.
- [ ] **Verify/publish:** run RED **before** adding scan, expected out-of-range acceptance; then plan tests;
  `Feature: packed index値を検証`。

### Task 26: checked count and byte sizing (depends Task 25; 45–85 lines)

**Files:** Modify plan and plan test。

**Produces:** internal sizing record with `vertexBytes`, `instanceBytes`, `instanceOffset`,
`nonIndexBytes`, `indexBytes`, `totalBytes`。

- [ ] **RED:** exact `vertexCount*vertexStride`, `align16(vertexBytes)`, padding, instance multiply,
  non-index add, index add. Reject zero/negative counts and any per-buffer/total max breach before length compare.
- [ ] **GREEN:** use Task19 methods for every multiply/align/add; no raw compound arithmetic.
- [ ] **Verify/publish:** plan test; `Feature: packed byte長を計算`。

### Task 27: immutable composite upload plan (depends Task 26; 50–95 lines)

**Files:** Modify plan and plan test。

**Produces:** `PersistentPackedInstancePlan.create` composing layout/bounds/index/sizing and exact
source-length validation; exposes copied layout/bounds and scalar fields, retains no ByteData。

- [ ] **RED:** valid indexed/non-index plans; too-short/too-long vertex, instance, index bytes reject.
  Mutate source layout/bounds/bytes after create; plan scalars/layout/bounds remain fixed and no source getter exists.
- [ ] **GREEN:** snapshot layout/bounds first, validate counts/sizes/index, compare all exact lengths,
  return final scalar/subplan references only.
- [ ] **Verify/publish:** all plan tests; `Feature: packed upload planを合成`。

### Task 28: pure upload write executor (depends Task 27; 45–85 lines)

**Files:** Modify plan and plan test。

**Produces:**
`executePersistentPackedWrites({required plan, required vertexData, required instanceData, required indexData, required overwriteNonIndex, required overwriteIndex})`。

- [ ] **RED:** event calls are vertex `(0,len)` once, instance `(instanceOffset,len)` once, optional
  index `(0,len)` once. False at vertex stops instance/index; false at instance stops index; false index reports
  `index`; each `StateError` names operation/offset/length.
- [ ] **GREEN:** synchronous three-condition sequence only; no allocation/flush/source retention/catch.
- [ ] **Verify/publish:** plan test; `Feature: packed write順序を固定`。

### Task 29: minimal production GPU backend seam (depends Task 28; 55–100 lines)

**Files:** Create `lib/src/geometry/persistent_packed_gpu_backend.dart`,
`test/persistent_packed_gpu_backend_test.dart`。

**Produces:** exact backend/buffer/slice interfaces plus internal
`DevicePersistentPackedGpuBackend`, `DevicePersistentPackedGpuSlice` wrapping a `gpu.BufferView`。

- [ ] **RED:** fake buffer records allocate/overwrite/flush/slice/release typed calls; after release,
  production-style wrapper operations throw. Source assertion rejects public barrel export.
- [ ] **GREEN:** production allocate calls only
  `gpu.gpuContext.createDeviceBuffer(gpu.StorageMode.hostVisible,length)`; wrapper delegates exact arguments,
  creates slices, and nulls one device reference idempotently. No factory hierarchy/mock package.
- [ ] **Verify/publish:** pure seam test (no allocation on unavailable GPU); `Feature: packed GPU backend境界を追加`。

### Task 30: non-index allocation/write/flush transaction (depends Task 29; 55–95 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_storage.dart`,
`test/persistent_packed_instance_storage_test.dart`。

**Produces:** test-visible `uploadPersistentPackedNonIndex` transaction returning one unpublished
buffer only after vertex+instance overwrite and one flush succeed。

- [ ] **RED:** exact events `allocate(nonIndexBytes), overwrite(vertex,0), overwrite(instance,offset),
  flush(0,nonIndexBytes)`; assert overwrite counts 1 each and flush count 1. Vertex/instance false and flush throw
  release once, stop later events, return/publish nothing.
- [ ] **GREEN:** allocate after complete plan exists; use Task28 executor with index callback unreachable;
  catch, release, rethrow; return buffer only after flush completes.
- [ ] **Verify/publish:** storage + plan; `Feature: packed non-index bufferをupload`。

### Task 31: indexed storage transaction and pre-publish ordering (depends Task 30; 60–100 lines)

**Files:** Modify storage and storage test。

**Produces:** `PersistentPackedInstanceStorage.upload` and test-only `uploadWithBackend` supporting
optional index, but publishing no view until every required write/flush succeeds。

- [ ] **RED:** indexed exact events allocate non-index then index; two non-index overwrites; non-index flush
  `(0,nonIndexBytes)` once; index overwrite `(0,indexBytes)` once; index flush `(0,indexBytes)` once; only then
  3 slice events/published getters. Allocation/index overwrite/each flush failures release all created buffers,
  create no slice/register, and execute no later event.
- [ ] **GREEN:** hold buffers in locals through both transactions; after both flushes create vertex/instance/index
  slices and call private storage constructor. Catch releases index then non-index and rethrows original error.
- [ ] **Verify/publish:** storage + plan; `Feature: packed index bufferをtransaction化`。

### Task 32: storage views, source independence, release (depends Task 31; 45–90 lines)

**Files:** Modify storage and storage test。

**Produces:** nullable `vertexSlice/instanceSlice/indexSlice`, synchronous idempotent `release()` and
logical byte getters。

- [ ] **RED:** exact slice offsets/lengths; source ByteData mutation after upload does not alter fake's copied
  uploaded bytes; release clears 3 slices then releases index/non-index once; repeated release no-op; getters null.
  GPU-available conditional uses one tiny real upload, otherwise skips with captured reason.
- [ ] **GREEN:** storage retains only plan scalars/slices/buffer wrappers, never source ByteData; release is a
  no-throw null-and-release sequence.
- [ ] **Verify/publish:** pure + conditional storage, plan; `Feature: packed GPU storageを解放可能化`。

### Task 33: Geometry injected core and defensive bounds (depends Task 32; 55–95 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_geometry.dart`,
`test/persistent_packed_instance_geometry_test.dart`。

**Produces:** private `_fromParts`, exact test creation helper, immutable count/stride/generation getters,
and overrides of inherited `localBounds` / `localBoundingSphere` returning plan copies。

- [ ] **RED:** injected plan/storage/lease exposes exact scalars; mutate first returned Aabb3 min/max and
  Sphere center/radius, then assert later getters unchanged. Assert superclass `setVertices/setVertexStreams/
  setIndices/setLocalBounds` are never called by source/event seam.
- [ ] **GREEN:** store only plan/storage/lease/shader/doubleSided; override bounds getters using Task23;
  do not populate superclass mutable bounds or buffer fields.
- [ ] **Verify/publish:** geometry + plan/storage; `Feature: packed Geometry coreを追加`。

### Task 34: public construction transaction (depends Task 33; 55–100 lines)

**Files:** Modify Geometry and geometry test。

**Produces:** public factory constructor matching Public API and lifecycle internal
`registerAllocation({totalBytes,instanceBytes,release})` after upload success only。

- [ ] **RED:** valid constructor order is `plan,upload,register,construct`; plan/upload failure register=0;
  register failure calls storage.release once and rethrows; invalidating/disposed/old lifecycle fails before
  GPU allocation. Caller mutation after return does not affect uploaded copy/layout/bounds.
- [ ] **GREEN:** check lifecycle can-create first, build plan, synchronous storage upload, register exact bytes,
  return `_fromParts`; catch after storage creation releases then rethrows. No fallback Geometry.
- [ ] **Verify/publish:** geometry/plan/storage/lifecycle; `Feature: packed Geometryをtransaction構築`。

### Task 35: Geometry resource lifecycle state (depends Task 34; 35–75 lines)

**Files:** Modify Geometry and geometry test。

**Produces:** `resourceState`, `contextGeneration`, cached `retire()` direct delegation。

- [ ] **RED:** active→pending→retired/failed mirrors lease; `identical(geometry.retire(), geometry.retire())`;
  storage releases only from lease callback after completion, never directly from retire.
- [ ] **GREEN:** return lease values/Future directly without `async`, state cache, or second completer.
- [ ] **Verify/publish:** geometry + registry; `Feature: packed Geometry retirementを接続`。

### Task 36: RenderPass production adapter and fake seam (depends Task 35; 55–100 lines)

**Files:** Create `lib/src/geometry/persistent_packed_render_pass.dart`,
`test/persistent_packed_render_pass_test.dart`。

**Produces:** exact adapter interface, `GpuPersistentPackedRenderPassAdapter(gpu.RenderPass)`, and
test event fake; production unwraps only `DevicePersistentPackedGpuSlice`。

- [ ] **RED:** fake records typed vertex/index/frame/draw events. Production-source contract uses
`bindVertexBufferCompat`, `bindIndexBufferCompat`, `drawCompat/drawIndexedCompat`; foreign slice fails before pass.
- [ ] **GREEN:** one final adapter with direct delegation; `bindFrameInfo` packs exactly 36 floats
camera/model/cameraPosition/pad and uses supplied shader slot. No generic render abstraction.
- [ ] **Verify/publish:** adapter pure tests; `Feature: packed RenderPass境界を追加`。

### Task 37: full persistent bind (depends Task 36; 55–95 lines)

**Files:** Modify Geometry and geometry test。

**Produces:** public `bind`, test bind helper, `vertexStreamCount=2`, exact layout,
`bindsModelTransformInstance=false`, `isDoubleSided` from constructor。

- [ ] **RED:** exact events `currentCheck,markUsed,vertex(slot0),instance(slot1),index?,frameInfo`;
  `shaderOverride ?? vertexShader` chosen exactly. pending/retired/failed/old generation/disposed/non-active context/
  closed frame each throw with pass event 0. Force adapter failure after mark and assert later retire waits end/submit.
- [ ] **GREEN:** one private `_bindWithAdapter`; validate all state before first event, mark before adapter calls,
  bind stored slices only, then 36-float FrameInfo. No overwrite/source scan/transient instance data.
- [ ] **Verify/publish:** geometry + lifecycle; `Feature: packed Geometryを永続bind`。

### Task 38: draw and depth/shadow/selection route (depends Task 37; 45–90 lines)

**Files:** Modify Geometry and geometry test; Modify
`test/render/persistent_gpu_scene_integration_test.dart`。

**Produces:** stored-count draw, exact src-only draw helper, and explicit `depthOnlyVertex => null`。

- [ ] **RED:** indexed/non-index fake draws exact stored vertex/index and instance count; zero is impossible by
  plan. external `instanceCount != 1` and retire/invalidate between bind→draw throw with draw event 0.
  Assert `depthOnlyVertex == null` and source/route
  contract in `object_filter.dart`, `shadow_encoder.dart`, `depth_prepass.dart`: null selects `geometry.bind`, not
  `bindPositionStream`; test adapter then observes both slots for each named route.
- [ ] **GREEN:** revalidate current active lease before adapter mutation; one branch indexed/non-index in adapter,
  always stored instance count; override null explicitly.
  Do not override or call `bindPositionStream` and do not call superclass stream setters.
- [ ] **Verify/publish:** geometry + three existing render suites/integration seam;
  `Feature: packed Geometry draw経路を固定`。

### Task 39: exact material vertex variant (depends Task 38; 40–80 lines)

**Files:** Modify `lib/src/material/shader_stage.dart`,
`lib/src/material/shader_material.dart`, Geometry; Modify `test/shader_material_vertex_test.dart`。

**Produces:** `MeshVariant.persistentPackedInstances('persistent_packed_instances')`, exact
`fromName` mapping, Geometry `materialVertexVariant`。

- [ ] **RED:** set/retrieve this variant shader; missing warning names it; existing unskinned/skinned/depth and
  unknown→unskinned remain exact. Geometry returns exact wire name.
- [ ] **GREEN:** add one enum value/switch case only; no fmat generator or implicit unskinned collapse.
- [ ] **Verify/publish:** shader + geometry; `Feature: packed Geometry shader variantを追加`。

### Task 40: Geometry curated public export (depends Task 39; 35–75 lines)

**Files:** Modify `lib/scene.dart`; Create
`test/persistent_packed_instance_public_api_test.dart`。

**Produces:** public Geometry only; plan/storage/backend/slice/adapter/lease/helpers remain internal。

- [ ] **RED:** imports only `dart:typed_data`, `vector_math`, public `scene.dart`/`gpu.dart`; takes constructor
  tear-off and references lifecycle/layout/state/retire types. Source assertions reject `src/` imports/exports.
- [ ] **GREEN:** add one curated export/show entry.
- [ ] **Verify/publish:** public + geometry; `Feature: packed Geometry APIを公開`。

### Task 41: packed Geometry README contract (depends Task 40; 30–75 lines)

**Files:** Modify `README.md`; Modify public API test。

**Produces:** one-upload consumer flow, exact FrameInfo/layout contract, and deferred-scope documentation.

- [ ] **RED:** doc-source expectation fails for CPU pack→one construction→per-frame bind→revision new attach/
  old detach+retire→stop/detach/invalidate/await/recreate, exact 36-float FrameInfo order, required layout/varyings,
  logical memory, no fallback/per-frame upload.
- [ ] **GREEN:** add only the consumer contract and #1603/#1604/#1605/deferred device boundaries.
- [ ] **Verify/publish:** public test + forbidden grep; `Docs: packed Geometry契約を追加`。

### Delivery Gate TOP (no commit)

- [ ] forbidden audit new files: zero `instanceTransients.emplace|List<Matrix4>|Future.delayed|Timer\(|
  setVertices\(|setVertexStreams\(|setIndices\(`; overwrite only storage transaction; release only clears refs.
- [ ] pinned format/analyze/full test; exact Flutter SHA, pass/fail/skip. Fresh spec/code review zero findings.
- [ ] fetch advertised bottom/top refs, cat-file full heads, assert ancestry/clean/local=remote. Then
  `gh stack submit --auto --open --remote origin`; `gh stack view --json` must be non-empty and show exactly
  bottom(base compatibility trunk) then top(base bottom), both OPEN. A one-branch link is invalid.
- [ ] edit both PR bodies after submit with exact base/head/Issue #1602/#1612, no copied code/licenses, logical vs
  resident, automatic context-loss missing, #1603–#1605, #1604 physical 30fps/5min defer, upstream forward-port,
  missing canonical spec. Re-query bodies/base/head/state.
- [ ] Obtain advertised top ref via `git ls-remote --exit-code origin refs/heads/feat/persistent-packed-instance-geometry`;
  require non-empty one line, `remote_top_head == git rev-parse HEAD`, fetch to remote-tracking ref, and
  `git cat-file -e "$remote_top_head^{commit}"`. Record only this 40-char SHA as `fork_top_sha`; any later fix
  invalidates handoff and requires all gates again.

Exact handoff command, run from the clean top worktree after both PRs are OPEN:

```bash
top_ref=refs/heads/feat/persistent-packed-instance-geometry
top_line=$(git ls-remote --exit-code origin "$top_ref")
test "$(printf '%s\n' "$top_line" | wc -l | tr -d ' ')" -eq 1
printf '%s\n' "$top_line" | rg -q \
  '^[0-9a-f]{40}[[:space:]]+refs/heads/feat/persistent-packed-instance-geometry$'
remote_top_head=${top_line%%[[:space:]]*}
printf '%s\n' "$remote_top_head" | rg -q '^[0-9a-f]{40}$'
test "$remote_top_head" = "$(git rev-parse HEAD)"
git fetch origin \
  "$top_ref:refs/remotes/origin/feat/persistent-packed-instance-geometry"
git cat-file -e "$remote_top_head^{commit}"
test "$(git rev-parse origin/feat/persistent-packed-instance-geometry)" = \
  "$remote_top_head"
fork_top_sha=$remote_top_head
```

## Gate D: #1601 immutable approval and EQMonitor pin worktree (no commit)

Do not start EQ pin from Task 41 alone. Supervisor supplies the full 40-char
`reviewed_decoder_sha` produced by #1601 whole-branch spec+code review and final non-device verification.
It must cover non-empty tile enumeration、column chunks、`TransferableTypedData` isolate transfer、typed
manifest-count failure、missing-depth validity bit and every #1601 child task—not a single commit review。

```bash
decoder_json=$(gh pr view 1620 --repo YumNumm/EQMonitor \
  --json state,isDraft,reviewDecision,mergeStateStatus,headRefName,headRefOid,baseRefName,statusCheckRollup,mergeCommit,url)
test -n "$decoder_json"
printf '%s\n' "$reviewed_decoder_sha" | rg -q '^[0-9a-f]{40}$'
test "$(printf '%s\n' "$decoder_json" | jq -er '.headRefOid')" = "$reviewed_decoder_sha"
decoder_state=$(printf '%s\n' "$decoder_json" | jq -r '.state')
if [ "$decoder_state" = OPEN ]; then
  git fetch origin \
    "+refs/heads/feat/seismicity-pmtiles-decoder:refs/remotes/origin/feat/seismicity-pmtiles-decoder"
  test "$(git rev-parse origin/feat/seismicity-pmtiles-decoder)" = \
    "$reviewed_decoder_sha"
  git cat-file -e "$reviewed_decoder_sha^{commit}"
  printf '%s\n' "$decoder_json" | jq -e \
    '.isDraft == false and .reviewDecision == "APPROVED" and
     .mergeStateStatus == "CLEAN" and
     .headRefName == "feat/seismicity-pmtiles-decoder" and
     .baseRefName == "feat/seismicity-pmtiles-network-reader" and
     ([.statusCheckRollup[] |
       select(.status != "COMPLETED" or
              (.conclusion != "SUCCESS" and .conclusion != "NEUTRAL" and
               .conclusion != "SKIPPED"))] | length == 0)' >/dev/null
elif [ "$decoder_state" = MERGED ]; then
  git fetch origin \
    "+refs/pull/1620/head:refs/remotes/origin/pull/1620/head"
  test "$(git rev-parse refs/remotes/origin/pull/1620/head)" = \
    "$reviewed_decoder_sha"
  git cat-file -e "$reviewed_decoder_sha^{commit}"
  merge_sha=$(printf '%s\n' "$decoder_json" | jq -er '.mergeCommit.oid')
  git fetch origin develop
  git cat-file -e "$merge_sha^{commit}"
  git merge-base --is-ancestor "$merge_sha" origin/develop
  printf '%s\n' "$decoder_json" | jq -e \
    '.headRefName == "feat/seismicity-pmtiles-decoder" and
     .baseRefName == "feat/seismicity-pmtiles-network-reader" and
     .reviewDecision == "APPROVED" and
     ([.statusCheckRollup[] |
       select(.status != "COMPLETED" or
              (.conclusion != "SUCCESS" and .conclusion != "NEUTRAL" and
               .conclusion != "SKIPPED"))] | length == 0)' >/dev/null
else
  exit 1
fi
issue_json=$(gh issue view 1601 --repo YumNumm/EQMonitor --json state,body,url)
test -n "$issue_json"
printf '%s\n' "$issue_json" | jq -e \
  '(.body | type == "string" and length > 0) and (.url | length > 0)' >/dev/null
```

OPEN route requires non-draft OPEN PR, exact head/base `feat/seismicity-pmtiles-decoder` /
`feat/seismicity-pmtiles-network-reader`, clean merge state, review bound to this SHA, and every completed
check `SUCCESS|NEUTRAL|SKIPPED`; pending/failure/cancel/BEHIND stops. MERGED route requires merge commit in
fresh `origin/develop` plus the same review/check evidence for the final head. Query Issue #1601 live and bind
the requirements audit to the same SHA. Empty jq output/unknown state stops。

Create a detached verification worktree at exact decoder SHA and invoke one directory per analyze command.
If a command fails, stop and preserve that worktree as evidence; only the all-pass path removes the exact
registered worktree and its now-empty temporary parent:

```bash
decoder_verify_parent=$(mktemp -d /tmp/eqmonitor-decoder-verify.XXXXXX)
decoder_verify=$decoder_verify_parent/worktree
git worktree add --detach "$decoder_verify" "$reviewed_decoder_sha"
(
  cd "$decoder_verify"
  mise exec -- flutter test packages/seismicity_pmtiles
  mise exec -- flutter test packages/pmtiles_v3
  mise exec -- dart analyze packages/seismicity_pmtiles
  mise exec -- dart analyze packages/pmtiles_v3
)
git worktree remove "$decoder_verify"
rmdir "$decoder_verify_parent"
```

Failure stops without expanding this plan to fix #1601. OPEN `pin_base_sha=$reviewed_decoder_sha`; MERGED
`pin_base_sha=$(git rev-parse origin/develop)` after ancestry proof。

Pin worktree is
`/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.worktrees/seismicity-flutter-scene-fork-pin`, branch
`feat/seismicity-flutter-scene-fork-pin`. If both absent create from exact pin base. Existing remote branch
requires supervisor-provided full `reviewed_pin_resume_sha`, advertised ref equality, fetch/cat-file, clean
local=remote and base ancestry. Existing local-only branch must equal reviewed SHA. Dirty/mismatch stops; never
delete/reset/checkout/force. Before creation require
`git check-ignore -q .worktrees/seismicity-flutter-scene-fork-pin`; if it is not ignored, stop rather than add
workspace artifacts. For a remote branch, fetch the advertised ref into its remote-tracking ref and require
`git cat-file -e "$reviewed_pin_resume_sha^{commit}"` before attach. Configure `remote.pushDefault=origin`。

```bash
eq_root=/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
pin_worktree=$eq_root/.worktrees/seismicity-flutter-scene-fork-pin
pin_ref=refs/heads/feat/seismicity-flutter-scene-fork-pin
test "$(git -C "$eq_root" remote get-url origin)" = \
  git@github.com:YumNumm/EQMonitor.git
git -C "$eq_root" check-ignore -q \
  .worktrees/seismicity-flutter-scene-fork-pin
pin_remote_exists=0
if pin_line=$(git -C "$eq_root" ls-remote --exit-code origin "$pin_ref"); then
  pin_remote_exists=1
  test "$(printf '%s\n' "$pin_line" | wc -l | tr -d ' ')" -eq 1
  printf '%s\n' "$pin_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/feat/seismicity-flutter-scene-fork-pin$'
  remote_pin_head=${pin_line%%[[:space:]]*}
  printf '%s\n' "$reviewed_pin_resume_sha" | rg -q '^[0-9a-f]{40}$'
  test "$remote_pin_head" = "$reviewed_pin_resume_sha"
  git -C "$eq_root" fetch origin \
    "$pin_ref:refs/remotes/origin/feat/seismicity-flutter-scene-fork-pin"
  git -C "$eq_root" cat-file -e "$remote_pin_head^{commit}"
else
  test "$?" -eq 2
  remote_pin_head=$pin_base_sha
fi
if [ "$pin_remote_exists" -eq 0 ] && \
  git -C "$eq_root" show-ref --verify --quiet "$pin_ref"; then
  printf '%s\n' "$reviewed_pin_resume_sha" | rg -q '^[0-9a-f]{40}$'
  git -C "$eq_root" cat-file -e "$reviewed_pin_resume_sha^{commit}"
  test "$(git -C "$eq_root" rev-parse feat/seismicity-flutter-scene-fork-pin)" = \
    "$reviewed_pin_resume_sha"
  remote_pin_head=$reviewed_pin_resume_sha
fi
if [ -e "$pin_worktree" ]; then
  git -C "$eq_root" worktree list --porcelain | \
    rg -Fx "worktree $pin_worktree"
elif git -C "$eq_root" show-ref --verify --quiet "$pin_ref"; then
  test "$(git -C "$eq_root" rev-parse feat/seismicity-flutter-scene-fork-pin)" = \
    "$remote_pin_head"
  git -C "$eq_root" worktree add "$pin_worktree" \
    feat/seismicity-flutter-scene-fork-pin
else
  git -C "$eq_root" worktree add -b feat/seismicity-flutter-scene-fork-pin \
    "$pin_worktree" "$pin_base_sha"
fi
test "$(git -C "$pin_worktree" rev-parse --abbrev-ref HEAD)" = \
  feat/seismicity-flutter-scene-fork-pin
test "$(git -C "$pin_worktree" rev-parse HEAD)" = "$remote_pin_head"
git -C "$pin_worktree" merge-base --is-ancestor "$pin_base_sha" HEAD
test -z "$(git -C "$pin_worktree" status --porcelain=v1)"
git -C "$eq_root" config remote.pushDefault origin
```

## EQMonitor pin tasks

Tasks 42–46 run from `$pin_worktree`. Their exact RED/GREEN commands are below; the RED failure is the one
listed by the Task and GREEN requires the same command to pass. Every Task then runs
`mise exec -- dart analyze packages/eqmonitor_map` and `git --no-pager diff --check` before its named commit.

| Task | exact RED/GREEN command(s) |
|---|---|
| 42 | `mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart` |
| 43 | `bash scripts/ci/test_verify_flutter_scene_pin.sh && bash -n tool/verify_flutter_scene_pin.sh && tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"` |
| 44 | `bash scripts/ci/test_verify_flutter_scene_pin.sh && tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"` |
| 45 | `rg -Fq 'https://github.com/YumNumm/flutter_scene.git' packages/eqmonitor_map/README.md && rg -Fq 'https://github.com/YumNumm/flutter_scene.git' packages/eqmonitor_map/example/README.md && rg -Fq "$fork_top_sha" packages/eqmonitor_map/README.md && rg -Fq "$fork_top_sha" packages/eqmonitor_map/example/README.md && tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree" && mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart` |
| 46 | `rg -Fq "$fork_top_sha" docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md && rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_scene_source_pin.md && rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_large_static_instances.md && tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree" && mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart` |

### Task 42: public API RED then atomic fork SHA pin (depends Gate D + top gate; 45–90 handwritten lines)

**Files:** Create
`packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart`; Modify
`packages/eqmonitor_map/pubspec.yaml`, `packages/eqmonitor_map/example/pubspec.yaml`, generated `pubspec.lock`。

**Produces:** all 3 descriptors and lock entries `flutter_scene`/`scene` use exact URL
`https://github.com/YumNumm/flutter_scene.git`, requested/resolved `fork_top_sha`, existing package paths;
consumer compile uses public imports only。

- [ ] **RED first:** while old bdero pin is still resolved, add test taking lifecycle/Geometry constructor
  tear-offs and checking active generation1 zero snapshot; run it and require missing persistent symbol failure.
  If it passes, stop because dependency state is not the audited base.
- [ ] **Authority:** obtain top advertised ref again, require one non-empty line, exact `fork_top_sha`, fetch,
  cat-file, and full 40-char regex. Never accept a SHA reachable only in local object storage.
- [ ] **GREEN:** edit only URL/ref values in 2 YAML descriptors, run `mise exec -- flutter pub get`; never
  hand-edit lock. Test must compile/pass without `src/` or `flutter_gpu` import.
- [ ] **Verify/publish:** `flutter pub get --enforce-lockfile`, public test, package analyze, machine YAML
  query for 3 descriptors+2 locks; `Package: Flutter Scene fork SHAへ固定`。

### Task 43: descriptor pin verifier core (depends Task 42; 50–95 lines)

**Files:** Create `tool/verify_flutter_scene_pin.sh`,
`scripts/ci/test_verify_flutter_scene_pin.sh`。

**Produces:** `verify_flutter_scene_pin.sh EXPECTED_URL EXPECTED_FULL_SHA [REPO_ROOT]`; first commit validates
the 3 descriptor entries URL/ref/path with `mise exec -- yq`。

- [ ] **RED:** fixture happy case and wrong map dependency URL call missing verifier and fail.
- [ ] **GREEN:** validate arg count, non-empty URL, SHA regex, repo files first; read each scalar and report exact
  file/package/field mismatch. Expected paths are map flutter_scene package path, scene override path, and example
  flutter_scene path. No grep/floating ref shortcut. Commit the verifier with executable mode (`chmod +x`).
- [ ] **Verify/publish:** happy fixture + real root + `bash -n`; `Test: Flutter Scene pin検証を追加`。

### Task 44: lock pin verifier and corruption matrix (depends Task 43; 55–100 lines)

**Files:** Modify verifier and its shell test。

**Produces:** exact requested/resolved lock validation and fail-closed descriptor/lock corruption matrix.

- [ ] **RED:** with Task43 verifier, wrong lock requested ref and wrong `resolved-ref` still pass; require both fail.
  Add matrix for wrong descriptor URL/ref/path, each lock package URL/requested/resolved/path, short SHA,
  missing/non-scalar field; each expects nonzero and exact field label.
- [ ] **GREEN:** validate both `.packages.flutter_scene.description` and `.packages.scene.description` exact
  URL/ref/`resolved-ref`/path. Keep the 3 descriptor checks. Temp uses `mktemp -d` and validated trap path only.
- [ ] **Verify/publish:** matrix + real verifier; `Test: Flutter Scene pin破損検知を追加`。

### Task 45: package consumer provenance docs (depends Task 44; 30–75 lines)

**Files:** Modify `packages/eqmonitor_map/README.md`,
`packages/eqmonitor_map/example/README.md`。

**Produces:** current consumer pin/provenance contract for package and example users.

- [ ] **RED:** inventory current-instruction old bdero pins, then exact fork URL/top SHA assertion fails.
- [ ] **GREEN:** record both fork PR URLs/top/base/Flutter SHAs, 36-float FrameInfo, multi-owner lifecycle,
  logical≠resident, no copied reference code, #1603/#1604/#1605 boundaries and physical gate deferred.
- [ ] **Verify/publish:** Task43 verifier + public test + no old active pin; `Docs: Flutter Scene provenanceを同期`。

### Task 46: toolchain/lifecycle knowledge docs (depends Task 45; 45–95 lines)

**Files:** Modify `docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md`,
`docs/knowledge/20260802_flutter_scene_scene_source_pin.md`,
`docs/knowledge/20260802_flutter_scene_large_static_instances.md`。

**Produces:** current fork toolchain, lifecycle, lock, FrameInfo, and deferred-device-gate knowledge.

- [ ] **RED:** distinguish current instructions from historical evidence; current exact fork/SHA assertion fails.
- [ ] **GREEN:** update current instructions only: requested+resolved both lock entries, global invalidation/
  completion retirement, logical≠resident, 36-float contract, #1604 device defer, reference provenance.
- [ ] **Verify/publish:** verifier/public test/analyze/no stale current instruction; `Docs: Flutter Scene lifecycle知見を同期`。

### Delivery Gate EQ and PR route (no commit)

- [ ] Re-run Gate D live. If decoder SHA changed, discard approval and repeat Gate D. After new approval,
  create recoverable backup ref, rebase pin branch from old exact base to new exact base, then rerun Tasks42–46
  gates. Require `validated_old_remote_sha` to match `^[0-9a-f]{40}$`; remote update only with explicit
  `--force-with-lease=refs/heads/feat/seismicity-flutter-scene-fork-pin:$validated_old_remote_sha`; bare force禁止。
- [ ] OPEN decoder route uses at least two branches, never one-branch link:
  `gh stack link --base feat/seismicity-pmtiles-network-reader --open --remote origin feat/seismicity-pmtiles-decoder feat/seismicity-flutter-scene-fork-pin`。
  Assert resulting decoder→pin order/base/head with non-empty stack/API output。
- [ ] MERGED decoder route is a valid standalone PR, not `gh stack link`:
  push pin non-force, write reviewed text to `$pin_worktree/pr-body.md`, then run
  `gh pr create --repo YumNumm/EQMonitor --base develop --head feat/seismicity-flutter-scene-fork-pin --title 'Package: Flutter Scene fork SHAへ固定' --body-file "$pin_worktree/pr-body.md"`.
  Assert base/head/state via `gh pr view --json`。
- [ ] PR body contains fork bottom/top URLs, advertised top SHA, decoder final SHA, #1602/#1612, no copied code,
  and Remaining: #1603 wiring, #1604 24-byte/LOD/2M + physical 30fps/5min, #1605 UX/device smoke,
  upstream forward-port, missing canonical spec. Re-query exact body/base/head/state/checks。
- [ ] Fetch/cat-file advertised fork bottom/top and EQ pin refs; assert each remote head equals handed-off/local
  full SHA, correct ancestry, every worktree clean/local=remote. Record test/analyze pass/fail/skip/blockers.
  Plan implementer then hands back to parent; no merge, #1603 implementation, device/Simulator/E2E。

## Completion checklist

- [ ] Gate A proves the authorized real fork; compatibility trunk is exact base.
- [ ] Fork bottom exposes one global completion-aware lifecycle with full owner/resource matrices.
- [ ] Last-owner invalidation recovery and release failure are tested/fail closed.
- [ ] Fork top performs each source overwrite/flush exact once and publishes only after all success.
- [ ] Geometry binds two persistent streams and 36-float FrameInfo; all normal/depth/shadow/selection use full bind.
- [ ] Layout names/overlap/alignment/checked arithmetic, index values, mutable bounds getters are tested.
- [ ] No per-frame instance upload/full scan/fallback/fixed-delay completion exists.
- [ ] Fork focused/full tests and analyze run with exact toolchain; skips/omitted device gates explicit.
- [ ] Fork bottom/top form a verified two-PR stack and advertised top SHA is the EQ dependency SHA.
- [ ] #1601 is approved/verified at the same immutable base SHA used by pin PR.
- [ ] EQ descriptors/locks/docs use one fork URL/requested/resolved full SHA and verifier detects corruption.
- [ ] EQ consumer compile uses curated public imports only.
- [ ] EQ pin uses valid two-branch link when decoder OPEN or standalone PR when decoder MERGED.
- [ ] All 3 PRs record deferred/device/resident/provenance boundaries; none are merged by this plan.
