# Flutter Scene Persistent Packed Instances Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use
> `superpowers:subagent-driven-development` task-by-task. Every implementation
> task is one RED → GREEN → regression → review → commit → push cycle. Do not
> start the next task until a different agent approves the current task.
> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Issue #1602向けに、static packed instance dataを一度だけGPUへuploadし、
GPU submission完了まで安全にretireできる汎用Geometryを`YumNumm/flutter_scene`
forkへ追加する。EQMonitorはcurated public APIだけを使い、forkのimmutable commit SHAへ固定する。

**Architecture:** process-global registryが1つのFlutter GPU context、submission tracker、
generation/stateを所有し、複数lifecycle ownerは同じ状態を観測する。plan、storage、registry lease、
plain binding delegateを分離し、public factoryは1つの型付きtransaction関数を通る。immutableな
vertex/instance 2-stream Geometryは通常・depth・shadow・selectionの全経路を既存full bindへ集約する。

**Tech Stack:** Flutter `4dacd3fc91d96262a33e5c598e17d816f0b35641`
(3.47.0-1.0.pre-97)、Dart 3.14.0-29.0.dev、Flutter GPU/Impeller、Flutter Scene
`7f71993b7e2a0ab1d2f59726a406098709be7291`、`mise exec --`、`gh stack`。

## Global Constraints

- fork baseはexact `7f71993b7e2a0ab1d2f59726a406098709be7291`、Flutterはexact
  `4dacd3fc91d96262a33e5c598e17d816f0b35641`。floating ref禁止。
- Flutter/Dart commandは常に`mise exec --`。forkでは
  `mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 --`を使う。
- registry、Scene encode、completion callback、lifecycle、Geometryは同一Dart isolate。
  lock、cross-isolate transfer、background GPU callは追加しない。
- ownerごとのcontext/generationは作らない。任意ownerのinvalidationは同generationの全owner
  resourceをretireし、全件settleまでrecreateを拒否する。
- per-frame instance upload/full scan、`InstancedMesh` matrix pack、delay、固定frames-in-flight、
  error時のfallback Geometryは禁止。
- `DeviceBuffer` reference releaseとdriver resident-memory解放を区別し、後者を保証しない。
- fork APIはgeneric packed Geometry/lifecycleのみ。震源24-byte schema、LOD、color/radiusは#1604、
  app wiringは#1603/#1605。
- 実機、Simulator、all-E2Eは実行しない。iPhone 13相当30fps/5分memory gateは#1604。
- 各Taskはhandwritten production+test 30–100 changed lines、generated lock除外。超える前に分割する。
- commitは英語1語prefix + 日本語、taskごとに別agentのspec/code review後にpushする。
- user checkout/dirty changeを変更しない。mismatchならdelete/reset/checkout/force pushせず停止する。

---

## Current evidence and reference boundary

- EQMonitor plan branchの元baseは`8120f23446b53f4b3222d32306d4fb576cb9683e`。Round5のread-only確認時、
  local tracking `origin/develop`は`3bf298efe90597beb4dd1402ef4eccf67e440446`で元baseをancestorに含む。
  このplan-only branch自体はreview provenanceを保つためrebaseしない。実装時はGate Dが必ずfresh fetchし、
  #1601 MERGED経路だけその時点のexact `origin/develop`を`pin_base_sha`へ採用するため、この観測値をbaseに
  流用しない。
- #1602はparent #1612 layer 06。#1603 scene foundation、#1604 2M renderer、#1605
  integrationはこのplanに混ぜない。
- active descriptor/lockは`bdero/flutter_scene`
  `7f71993b7e2a0ab1d2f59726a406098709be7291`。pinned sourceにはprocess-global
  `rendererSubmissions` / `GpuSubmissionTracker`がある。
- pinned `Geometry.depthOnlyVertex == null`で、`object_filter.dart`、`shadow_encoder.dart`、
  `depth_prepass.dart`は`Geometry.bind`を呼ぶ。persistent Geometryもnullを維持しfull bindする。
- `bdero/dashmap` `a6ff92edd999e922f81d26d209d8f589faee3fd0`はMIT。public barrelと
  pure projection/Scene adapterの分離だけを参考にする。
- 指定名`ingen084/KyoshinEewViewer`ではなく確認できたMIT repositoryは
  `ingen084/KyoshinEewViewerIngen` `23c91f26c0f3bbc47320bf87b409182002e388fa`。
  immutable snapshot/revision reuseだけを参考にし、どちらからもsource copyしない。
- `YumNumm/flutter_scene`は未作成。repo/fork作成は権限外でGate Aのexternal blocker。
- #1612が参照するcanonical specはlocal/live refsにない。Issue本文と現存design docsをcontractとし、
  gapをPRへ記録する。

## Final public API

`package:flutter_scene/scene.dart`から次だけをexportする。EQMonitorは`src/`、
`package:flutter_gpu/`、internal annotation APIをimport/callしない。

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
  factory PersistentPackedInstanceGeometry({
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

Inherited public `setLocalBounds` is explicitly overridden to throw `UnsupportedError` before mutation because
this Geometry is immutable. `localBounds` and `localBoundingSphere` return fresh copies. A lifecycle owner survives
recreate; an allocation lease records its generation. After recreate, the same owner may create new resources,
while every old-generation lease/Geometry fails `requireCurrentActive()` before render-pass mutation。

## Safety invariants

1. Layout is exactly slot0 vertex / slot1 instance. Descriptor lists、ByteData、mutable `Aabb3` are copied。
2. Validate count/stride/offset/length/alignment/finite bounds/index width/value before GPU allocation。
3. Reject empty、whitespace-only、surrounding-whitespace、duplicate attribute names and overlapping ranges。
4. Per-buffer/total max is `0x7fffffff`; multiply/add/align/end use pre-operation checks。
5. Vertex+instance use one host-visible buffer; instance offset is 16-byte aligned. Optional index uses another。
6. Non-index performs vertex overwrite once、instance overwrite once、then exact
   `flush(offsetInBytes: 0, lengthInBytes: nonIndexBytes)` once. Index performs overwrite once、then exact
   `flush(offsetInBytes: 0, lengthInBytes: indexBytes)` once。
7. Any allocation/write/flush failure stops later events, releases every created wrapper once, publishes no
   slice/lease/Geometry, and rethrows the original error。
8. Views register only after every required write and flush succeeds. Source bytes are never retained。
9. Bind order is lease current-state check → registry markUsed → slot0 → slot1 → optional index → FrameInfo。
10. FrameInfo is exactly 36 float32 values: camera `[0..15]`, model `[16..31]`, camera position `[32..34]`,
    zero padding `[35]`; bind against `shaderOverride ?? vertexShader`。
11. `depthOnlyVertex == null`; normal/depth/shadow/selection all execute the same full bind。
12. `bindsModelTransformInstance == false`; external `draw(instanceCount != 1)` fails before pass mutation。
13. Open-frame marks and last submission are separate. bind→retire→submit waits completion; no-submit settles
    only after `endFrame` determines no newer submission stamp exists。
14. Generation starts at1 globally. invalidating→all settle→invalidated→recreate is the only increment path。
15. Release failure makes context terminal failed. Remaining releases continue; bind/register/recreate reject。
16. Snapshot reports logical references, split global/owner and active/retiring/failed total/instance bytes。

## Final state contracts

Allocation internal states are `active`, `pendingOpenFrame`, `pendingSubmission`, `releasing`, `retired`,
`failed`; public state maps both pending states plus releasing to `retirementPending` and failed to
`retirementFailed`。

| current | event | result |
|---|---|---|
| active, never marked | retire | releasing immediately; cached Future |
| active, open mark | retire | pendingOpenFrame; retain |
| pendingOpenFrame | beforeSubmit(id) | pendingSubmission; last=id |
| pendingOpenFrame | endFrame without submit | releasing if its nullable prior lastSubmission is complete, otherwise pendingSubmission |
| active | beforeSubmit(id) after mark | active; last=max(previous,id) |
| active with incomplete `lastSubmission` | retire | pendingSubmission; cached Future; callback/buffer retained |
| pendingSubmission | completion below last | retain |
| pendingSubmission | completion at/above last | releasing exactly once |
| releasing | reentrant/repeated retire | identical Future |
| releasing | release success | retired; accounting removed; Future success |
| releasing | release throw | retirementFailed; failed bytes retained; global failed |

| owner | context | operation | result |
|---|---|---|---|
| active | active | invalidate | global invalidating; all owners retire; shared FI |
| active | invalidating/invalidated/failed | invalidate | no mutation; identical FI |
| disposed | any | invalidate | no mutation; identical owner FE |
| active | invalidated | recreate | no failed records; generation +1; active |
| active | active/invalidating/failed | recreate | synchronous StateError |
| disposed | any | recreate | synchronous StateError |
| active | any | dispose | owner disposed; owner records retire; owner FD |
| disposed | any | dispose | no mutation; identical FD |
| new owner | active | constructor | attach |
| new owner | invalidated | constructor | recovery owner; register rejects until recreate |
| new owner | invalidating/failed | constructor | synchronous StateError; no attach |

The final owner may dispose while invalidating. Registry and FI remain with zero owners, finish invalidated, and a
later recovery owner may attach and recreate. Settle order is resource Future → owner FD → global FI. First release
error is context cause; later errors remain in test-only ordered `failureLog`。
For `mark→submit→retire`, invalidation invoked by any two active owners returns the exact same FI object. It cannot
settle, succeed or fail until the stamped resource completes and every registered release callback in the batch has
been attempted; completion failure is cached and never retried by later completion notifications。

## Exact internal interfaces and file ownership

None of these are exported publicly. Test fakes implement these Dart interfaces or pass typed functions; they do
not extend/subclass `gpu.DeviceBuffer`, `gpu.BufferView`, or `gpu.RenderPass`。

```dart
typedef GpuSubmissionCompletionListener = void Function(int completedThrough);

void addCompletionListener(GpuSubmissionCompletionListener listener) {
  _completionListeners.add(listener);
}

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
    required gpu.Shader Function() defaultShader,
    required gpu.Shader? shaderOverride,
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

T selectPersistentPackedShader<T>({
  required T Function() defaultShader,
  required T? shaderOverride,
});

typedef PersistentPackedCanCreate = void Function();
typedef PersistentPackedPlanBuild = PersistentPackedInstancePlan Function();
typedef PersistentPackedStorageUpload = PersistentPackedInstanceStorage Function({
  required PersistentPackedGpuBackend backend,
  required PersistentPackedInstancePlan plan,
});
typedef PersistentPackedLeaseRegister = PersistentGpuResourceLease Function({
  required int totalBytes,
  required int instanceBytes,
  required void Function() release,
});
typedef PersistentPackedConstruct<T> = T Function({
  required PersistentPackedInstancePlan plan,
  required PersistentPackedInstanceStorage storage,
  required PersistentGpuResourceLease lease,
});

T executePersistentPackedInstanceTransaction<T>({
  required PersistentPackedCanCreate checkCanCreate,
  required PersistentPackedPlanBuild buildPlan,
  required PersistentPackedGpuBackend backend,
  required PersistentPackedStorageUpload upload,
  required PersistentPackedLeaseRegister register,
  required PersistentPackedConstruct<T> construct,
});
```

| file | sole responsibility |
|---|---|
| `lib/src/render/frame_transients.dart` | submission before/after listeners and global tracker |
| `lib/src/render/persistent_gpu_resource_models.dart` | exact 3 enums and immutable snapshot values |
| `lib/src/render/persistent_gpu_execution_affinity.dart` | same-isolate assertion |
| `lib/src/render/persistent_gpu_resource_registry.dart` | owners, generations, leases, frames, retirement |
| `lib/src/render/persistent_gpu_resource_lifecycle.dart` | public owner handle only |
| `lib/src/render/persistent_gpu_scene_frame.dart` | begin/encode/end try/finally seam |
| `lib/src/geometry/persistent_packed_instance_plan.dart` | pure validation and immutable upload plan |
| `lib/src/geometry/persistent_packed_gpu_backend.dart` | GPU-independent interfaces only |
| `lib/src/geometry/persistent_packed_gpu_device.dart` | final DeviceBuffer wrappers/backend |
| `lib/src/geometry/persistent_packed_instance_storage.dart` | upload/flush/view/release transaction |
| `lib/src/geometry/persistent_packed_render_pass.dart` | adapter interface only |
| `lib/src/geometry/persistent_packed_render_pass_gpu.dart` | final GPU adapter and FrameInfo bind |
| `lib/src/geometry/persistent_packed_instance_binding.dart` | plain lease-aware bind/draw delegate |
| `lib/src/geometry/persistent_packed_instance_transaction.dart` | typed pure construction orchestration |
| `lib/src/geometry/persistent_packed_instance_geometry.dart` | concrete Geometry and public factory |

<!-- affinity-entrypoint-matrix-start -->
Every registry entry/callback below calls `affinity.check()` as its first executable statement, before lookup,
state read used for a decision, mutation, Future creation, or user callback. Each listed task changes the injected
token, invokes the entry, restores the original token, and proves state/callback counts are unchanged:

| entry/callback | task | rejected-before-mutation evidence |
|---|---:|---|
| `attachOwner()` | 4C | owner id/count unchanged |
| `register(...)` | 4C | allocation/callback count unchanged |
| lease `requireCurrentActive()` | 4B | record state and release count unchanged |
| lease/registry `retire()` | 4D | record state, cached Future and release count unchanged |
| `snapshotFor(...)` | 5 | throws before reading counters; restored-token snapshot unchanged |
| `disposeOwner(ownerId)` | 6 | owner state/FD/release count unchanged |
| `invalidateContext(ownerId)` | 7 | context/FI/release count unchanged |
| `recreateContext(ownerId)` | 8 | generation/context unchanged |
| `beginFrame()` | 12 | frame-open/mark/record state unchanged |
| lease/registry `markUsed(lease)` | 12 | frame-open/mark/record state unchanged |
| `endFrame()` | 12 | frame-open/mark/record state unchanged |
| tracker before-submit listener | 13 | open marks and submission stamps unchanged |
| tracker completion listener | 14 | pending state/release count unchanged |
| `releaseRecord(...)` before registered callback | 4D/14/15A | callback/log/context/record unchanged; not failed |

Lifecycle methods delegate to these checked entries; they do not duplicate an independently drifting affinity
policy. Affinity failure is an execution-contract error, never a GPU release failure: it appends no `failureLog`,
does not change resource/context state, and leaves the same operation retryable after restoring the token。

<!-- affinity-entrypoint-matrix-end -->

## Repository and stack

```text
YumNumm/flutter_scene
eqmonitor/flutter-4dacd3fc (exact 7f71993b7e2a0ab1d2f59726a406098709be7291)
└─ feat/persistent-gpu-lifecycle
   └─ feat/persistent-packed-instance-geometry

YumNumm/EQMonitor
#1601 OPEN: feat/seismicity-pmtiles-decoder
└─ feat/seismicity-flutter-scene-fork-pin
or #1601 MERGED: develop
└─ feat/seismicity-flutter-scene-fork-pin (standalone PR)
```

Repositories cannot share one stack. Fork bottom/top are a two-PR stack. EQ pin is a separate valid stack link or
standalone PR. No implementation agent may create `YumNumm/flutter_scene`; Gate A requires its authorized fork。

## Fail-closed execution gates

Every shell block begins `set -euo pipefail`. An expected absence is accepted only through an explicit captured
exit code. Empty/multiple machine output, unset reviewed SHA, command failure, or mismatch exits nonzero。

### Gate A: real fork and write authority

```bash
set -euo pipefail
fork_json=$(gh repo view YumNumm/flutter_scene \
  --json nameWithOwner,parent,defaultBranchRef,viewerPermission)
test -n "$fork_json"
fork_authority=$(jq -er '
  select(.nameWithOwner == "YumNumm/flutter_scene") |
  select(.parent.nameWithOwner == "bdero/flutter_scene") |
  select((.defaultBranchRef.name | type) == "string" and
         (.defaultBranchRef.name | length) > 0) |
  select(.viewerPermission == "ADMIN" or .viewerPermission == "MAINTAIN" or
         .viewerPermission == "WRITE") |
  [.nameWithOwner,.parent.nameWithOwner,.defaultBranchRef.name,.viewerPermission] |
  @tsv
' <<<"$fork_json")
test -n "$fork_authority"
test "$(wc -l <<<"$fork_authority" | tr -d ' ')" -eq 1
```

If the repository is absent, `gh repo view` fails and `set -e` exits. If any authority predicate is false,
`jq -e` exits nonzero. The agent must not run `gh repo fork` or `gh repo create`。

### Gate B: exact fork clone, compatibility ref, bottom lease and worktree

```bash
set -euo pipefail
fork_clone=/Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene
fork_worktree=/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
base_sha=7f71993b7e2a0ab1d2f59726a406098709be7291
compat_ref=refs/heads/eqmonitor/flutter-4dacd3fc
bottom_ref=refs/heads/feat/persistent-gpu-lifecycle

if test -e "$fork_clone"; then
  test "$(git -C "$fork_clone" rev-parse --is-inside-work-tree)" = true
  test "$(git -C "$fork_clone" remote get-url origin)" = \
    git@github.com:YumNumm/flutter_scene.git
else
  git clone --origin origin git@github.com:YumNumm/flutter_scene.git "$fork_clone"
fi

if upstream_url=$(git -C "$fork_clone" remote get-url upstream 2>/dev/null); then
  test "$upstream_url" = https://github.com/bdero/flutter_scene.git
else
  upstream_rc=$?
  test "$upstream_rc" -eq 2
  git -C "$fork_clone" remote add upstream https://github.com/bdero/flutter_scene.git
fi
git -C "$fork_clone" fetch upstream master
git -C "$fork_clone" cat-file -e "$base_sha^{commit}"

if git -C "$fork_clone" check-ignore -q .worktrees; then
  exit 1
else
  ignore_rc=$?
  test "$ignore_rc" -eq 1
fi

if compat_line=$(git -C "$fork_clone" ls-remote --exit-code origin "$compat_ref"); then
  test "$(wc -l <<<"$compat_line" | tr -d ' ')" -eq 1
  printf '%s\n' "$compat_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/eqmonitor/flutter-4dacd3fc$'
  test "${compat_line%%[[:space:]]*}" = "$base_sha"
else
  compat_rc=$?
  test "$compat_rc" -eq 2
  git -C "$fork_clone" push origin "$base_sha:$compat_ref"
fi
git -C "$fork_clone" fetch origin \
  "$compat_ref:refs/remotes/origin/eqmonitor/flutter-4dacd3fc"
test "$(git -C "$fork_clone" rev-parse origin/eqmonitor/flutter-4dacd3fc)" = "$base_sha"
git -C "$fork_clone" cat-file -e "$base_sha^{commit}"

if bottom_line=$(git -C "$fork_clone" ls-remote --exit-code origin "$bottom_ref"); then
  test "${reviewed_bottom_resume_sha:?supervisor reviewed bottom SHA required}" != ""
  printf '%s\n' "$reviewed_bottom_resume_sha" | rg -q '^[0-9a-f]{40}$'
  test "$(wc -l <<<"$bottom_line" | tr -d ' ')" -eq 1
  printf '%s\n' "$bottom_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/feat/persistent-gpu-lifecycle$'
  remote_bottom_head=${bottom_line%%[[:space:]]*}
  test "$remote_bottom_head" = "$reviewed_bottom_resume_sha"
  git -C "$fork_clone" fetch origin \
    "$bottom_ref:refs/remotes/origin/feat/persistent-gpu-lifecycle"
  git -C "$fork_clone" cat-file -e "$remote_bottom_head^{commit}"
else
  bottom_rc=$?
  test "$bottom_rc" -eq 2
  remote_bottom_head=$base_sha
fi

mkdir -p /Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees
if test -e "$fork_worktree"; then
  git -C "$fork_clone" worktree list --porcelain | rg -Fx \
    "worktree $fork_worktree"
elif git -C "$fork_clone" show-ref --verify --quiet \
  refs/heads/feat/persistent-gpu-lifecycle; then
  test "$(git -C "$fork_clone" rev-parse feat/persistent-gpu-lifecycle)" = \
    "$remote_bottom_head"
  git -C "$fork_clone" worktree add "$fork_worktree" feat/persistent-gpu-lifecycle
else
  local_bottom_rc=$?
  test "$local_bottom_rc" -eq 1
  git -C "$fork_clone" worktree add -b feat/persistent-gpu-lifecycle \
    "$fork_worktree" "$remote_bottom_head"
fi
test "$(git -C "$fork_worktree" remote get-url origin)" = \
  git@github.com:YumNumm/flutter_scene.git
test "$(git -C "$fork_worktree" rev-parse --abbrev-ref HEAD)" = \
  feat/persistent-gpu-lifecycle
test "$(git -C "$fork_worktree" rev-parse HEAD)" = "$remote_bottom_head"
git -C "$fork_worktree" merge-base --is-ancestor "$base_sha" HEAD
test -z "$(git -C "$fork_worktree" status --porcelain=v1)"
git -C "$fork_clone" config rerere.enabled true
git -C "$fork_clone" config remote.pushDefault origin

cd "$fork_worktree"
if stack_json=$(gh stack view --json 2>/dev/null); then
  test -n "$stack_json"
  stack_branch_count=$(jq -er '.branches | length' <<<"$stack_json")
  case "$stack_branch_count" in
    1) reviewed_top_resume_sha=$remote_bottom_head ;;
    2)
      test "${reviewed_top_resume_sha:?supervisor reviewed top SHA required}" != ""
      printf '%s\n' "$reviewed_top_resume_sha" | rg -q '^[0-9a-f]{40}$'
      ;;
    *) exit 1 ;;
  esac
  jq -e --arg base "$base_sha" --arg bottom "$remote_bottom_head" \
    --arg top "$reviewed_top_resume_sha" '
    def fullsha: type == "string" and test("^[0-9a-f]{40}$");
    .trunk == "eqmonitor/flutter-4dacd3fc" and
    .currentBranch == "feat/persistent-gpu-lifecycle" and
    (.branches[0].base | fullsha) and
    (.branches[0].head | fullsha) and
    .branches[0].base == $base and
    .branches[0].head == $bottom and
    (([.branches[].name] == ["feat/persistent-gpu-lifecycle"] and
      $top == $bottom) or
     ([.branches[].name] == ["feat/persistent-gpu-lifecycle",
                            "feat/persistent-packed-instance-geometry"] and
      (.branches[1].base | fullsha) and
      (.branches[1].head | fullsha) and
      .branches[1].base == $bottom and
      .branches[1].head == $top))
  ' <<<"$stack_json" >/dev/null
else
  stack_rc=$?
  test "$stack_rc" -eq 2
  gh stack init --base eqmonitor/flutter-4dacd3fc feat/persistent-gpu-lifecycle
fi
```

### Gate C: exact toolchain and baseline

```bash
set -euo pipefail
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
version_json=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter --version --machine)
test -n "$version_json"
framework_revision=$(jq -er \
  '.frameworkRevision | select(type == "string" and length == 40)' \
  <<<"$version_json")
test "$framework_revision" = 4dacd3fc91d96262a33e5c598e17d816f0b35641
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter pub get
cd packages/flutter_scene
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter test --enable-impeller test/render/frame_transients_test.dart
```

Baseline failure is evidence, not pass. Device/Simulator/E2E is not part of this gate。

## Per-task execution contract

Every task below contains a compilable RED test snippet, a type-checkable GREEN production snippet and an exact
handwritten line budget. Add only the RED test first. Every fork RED is run through this exact harness in the same
strict shell; a normal targeted test failure is exit `1`. Exit `0`, an unrelated/toolchain exit such as `99`, a
missing test title, or a missing task-specific diagnostic all make the gate fail. Do not commit the intentional RED。

Every compile-oriented source-contract RED imports `dart:io` and `package:flutter_test/flutter_test.dart` and uses
this helper. The `marker` is the exact GREEN production signature/statement named in that task. Behavioral
assertions stay in the same named test; the source assertion gives the fail-closed harness a deterministic
task-specific diagnostic even when the pre-task API does not compile yet。

```dart
void expectRedSourceContract({
  required String path,
  required String marker,
  required String diagnostic,
}) {
  final file = File(path);
  expect(file.existsSync(), isTrue, reason: diagnostic);
  expect(file.readAsStringSync(), contains(marker), reason: diagnostic);
}
```

```bash
set -euo pipefail
run_fork_red() (
  set -euo pipefail
  test "$#" -eq 3
  red_file=$1
  red_title=$2
  red_diagnostic=$3
  if red_output=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    flutter test --enable-impeller "$red_file" --plain-name "$red_title" 2>&1); then
    printf '%s\n' "$red_output" >&2
    exit 1
  else
    red_rc=$?
  fi
  if test "$red_rc" -ne 1; then return 1; fi
  if test -z "$red_output"; then return 1; fi
  if ! printf '%s\n' "$red_output" | rg -F -- "$red_title" >/dev/null; then
    return 1
  fi
  if ! printf '%s\n' "$red_output" | rg -F -- "$red_diagnostic" >/dev/null; then
    return 1
  fi
)

probe_title='probe target title'
probe_diagnostic='RED:PROBE:target diagnostic'
mise() {
  printf '%s\n%s\n' "$probe_title" "$probe_diagnostic"
  return 99
}
if run_fork_red ignored.dart "$probe_title" "$probe_diagnostic"; then
  exit 1
else
  probe_rc=$?
  test "$probe_rc" -ne 0
fi
mise() {
  printf '%s\n' "$probe_title"
  return 1
}
if run_fork_red ignored.dart "$probe_title" "$probe_diagnostic"; then
  exit 1
else
  probe_rc=$?
  test "$probe_rc" -ne 0
fi
unset -f mise
```

The explicit branches are required because zsh suppresses `errexit` inside a function invoked as an `if`
condition; bare `test`/`rg` commands could otherwise continue until a later successful command. The first probe
proves an rc99 toolchain crash is rejected even when it prints both expected strings. The second proves an
unrelated rc1 is rejected when the diagnostic is absent. The implementation worker must execute both before Task1
and record their nonzero statuses。

After GREEN, run every named focused and regression file in that task, then analyze and diff check. Before commit
run `git --no-pager diff --numstat HEAD --` with the task's exact files and reconcile the result with
`**Handwritten budget:**`; generated locks and formatter-only indentation are excluded, but every handwritten
production/test/doc line counts. A different agent performs spec review and code review; only zero findings permits
the exact named commit and `git push`。

The repeated GREEN blocks are the expanded form of this fail-closed harness. If an implementation agent uses the
harness interactively, define it in that same shell; a failed test, analyze, or diff check is the function's
nonzero status and must stop commit/push:

```bash
set -euo pipefail
run_fork_green() (
  set -euo pipefail
  test "$#" -ge 1
  mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    flutter test --enable-impeller "$@"
  mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
    dart analyze .
  git --no-pager diff --check
)
```

## Bottom PR: global lifecycle and retirement

### Task 1: contiguous completion listener (depends Gate C; 35–65 lines)

**Files:** Modify `lib/src/render/frame_transients.dart`; Create
`test/render/gpu_submission_tracker_test.dart`。

**Interfaces:** Consumes `GpuSubmissionTracker.record/complete`。Produces
`typedef GpuSubmissionCompletionListener = void Function(int completedThrough)` and
`void addCompletionListener(GpuSubmissionCompletionListener listener)`。

**Implementation shape:** retain `previous = completedThrough`; remove the id; if removal succeeded and the new
watermark exceeds previous, iterate `List.of(_completionListeners)` in registration order。

**RED test snippet:**

```dart
test("completion listeners observe the contiguous watermark in order", () {
  expectRedSourceContract(
    path: "lib/src/render/frame_transients.dart",
    marker: "typedef GpuSubmissionCompletionListener = void Function(int completedThrough);",
    diagnostic: "RED:T01:completion listener missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
typedef GpuSubmissionCompletionListener = void Function(int completedThrough);

final List<GpuSubmissionCompletionListener> _completionListeners = [];

void addCompletionListener(GpuSubmissionCompletionListener listener) {
  _completionListeners.add(listener);
}

void complete(int id) {
  final previous = completedThrough;
  if (!_pending.remove(id)) return;
  final current = completedThrough;
  if (current <= previous) return;
  for (final listener in List.of(_completionListeners)) {
    listener(current);
  }
}
```

**Handwritten budget:** 35–65 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** add test `completion listeners observe the contiguous watermark in order` using:
  ```dart
  final a = tracker.record(), b = tracker.record();
  tracker.complete(b);
  expect(seen, isEmpty);
  tracker.complete(a);
  expect(seen, ['first:2', 'second:2']);
  tracker..complete(a)..complete(999);
  expect(seen, ['first:2', 'second:2']);
  ```
  `run_fork_red test/render/gpu_submission_tracker_test.dart 'completion listeners observe the contiguous watermark in order' 'RED:T01:completion listener missing'`。
- [ ] **GREEN:** notify a registration-order listener snapshot only when `_pending.remove(id)` is true and
  `completedThrough` advances. Run regressions:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/gpu_submission_tracker_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU submission完了通知を追加`。

### Task 2: public states and immutable usage (depends Task 1; 45–85 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_models.dart`; Create
`test/render/persistent_gpu_resource_models_test.dart`。

**Interfaces:** Produces exactly 3 enums from Final public API and exact const constructor with required
`activeResourceCount`, `retiringResourceCount`, `failedResourceCount`, `activeTotalBytes`, `retiringTotalBytes`,
`failedTotalBytes`, `activeInstanceBytes`, `retiringInstanceBytes`, `failedInstanceBytes`。No equality/codegen/factory。

**Implementation shape:** one `@immutable final class` with nine final int fields and the exact const named
constructor; enums contain only the values under Final public API。

**RED test snippet:**

```dart
test("public usage preserves nine logical fields and three enums", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_models.dart",
    marker: "final class PersistentGpuMemoryUsage",
    diagnostic: "RED:T02:public usage model missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
@immutable
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
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** construct usage with 1..9 and reference all three enum value sets. Run:
  `run_fork_red test/render/persistent_gpu_resource_models_test.dart 'public usage preserves nine logical fields and three enums' 'RED:T02:public usage model missing'`。
- [ ] **GREEN:** implement one `@immutable final class` plus exactly 3 enums. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU resource状態値を追加`。

### Task 3: exact snapshot and isolate affinity (depends Task 2; 50–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_models.dart`; Create
`lib/src/render/persistent_gpu_execution_affinity.dart`; Modify
`test/render/persistent_gpu_resource_models_test.dart`。

**Interfaces:** Produces exact Final public API snapshot constructor with required `contextState`,
`lifecycleState`, `contextGeneration`, `latestSubmission`, `completedThrough`, `global`, `owner`, and
`PersistentGpuExecutionAffinity({SendPort Function()? currentIsolateToken}); void check()`。

**Implementation shape:** snapshot is one `@immutable final class`; affinity stores the initially captured
`SendPort` and throws `StateError` when `currentIsolateToken() != capturedToken`, using `SendPort` equality rather
than assuming repeated `Isolate.current.controlPort` getter results are object-identical。

**RED test snippet:**

```dart
test("snapshot is exact and mutations stay on one isolate", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_models.dart",
    marker: "final class PersistentGpuMemorySnapshot",
    diagnostic: "RED:T03:snapshot affinity contract missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentGpuExecutionAffinity {
  PersistentGpuExecutionAffinity({SendPort Function()? currentIsolateToken}) {
    currentToken = currentIsolateToken ?? (() => Isolate.current.controlPort);
    capturedToken = currentToken();
  }

  late final SendPort Function() currentToken;
  late final SendPort capturedToken;

  void check() {
    if (currentToken() != capturedToken) {
      throw StateError('persistent GPU access crossed isolate affinity');
    }
  }
}
```

**Handwritten budget:** 50–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** assert every snapshot field and:
  ```dart
  final first = ReceivePort(), second = ReceivePort();
  var token = first.sendPort;
  final affinity = PersistentGpuExecutionAffinity(currentIsolateToken: () => token);
  affinity.check();
  token = second.sendPort;
  expect(affinity.check, throwsStateError);
  first.close();
  second.close();
  ```
  `run_fork_red test/render/persistent_gpu_resource_models_test.dart 'snapshot is exact and mutations stay on one isolate' 'RED:T03:snapshot affinity contract missing'`。
- [ ] **GREEN:** default captures `Isolate.current.controlPort`; compare typed `SendPort` equality. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU snapshotとisolate制約を追加`。

### Task 4A: registry state records (depends Task 3; 45–85 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_registry.dart`; Create
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces data-only `PersistentGpuOwnerRecord` and `PersistentGpuAllocationRecord`, internal enum
`PersistentGpuAllocationState`, and the registry constructor/fields. These classes have no methods; every mutation
entry remains on the registry so affinity ordering has one auditable location。

**RED test snippet:**

```dart
test('registry records are data only and generation starts at one', () {
  expectRedSourceContract(
    path: 'lib/src/render/persistent_gpu_resource_registry.dart',
    marker: 'final class PersistentGpuAllocationRecord',
    diagnostic: 'RED:T04A:registry records missing',
  );
});
```

**GREEN implementation snippet:**

```dart
enum PersistentGpuAllocationState {
  active, pendingOpenFrame, pendingSubmission, releasing, retired, failed,
}

final class PersistentGpuOwnerRecord {
  PersistentGpuOwnerRecord({required this.id});
  final int id;
  PersistentGpuResourceLifecycleState state =
      PersistentGpuResourceLifecycleState.active;
  Completer<void>? disposal;
}

final class PersistentGpuAllocationRecord {
  PersistentGpuAllocationRecord({required this.id, required this.ownerId,
      required this.generation, required this.totalBytes,
      required this.instanceBytes, required this.release});
  final int id;
  final int ownerId;
  final int generation;
  final int totalBytes;
  final int instanceBytes;
  final void Function() release;
  PersistentGpuAllocationState state = PersistentGpuAllocationState.active;
  int? lastSubmission;
  Completer<void>? retirement;
}

final class PersistentGpuResourceRegistry {
  PersistentGpuResourceRegistry({required this.submissions,
      required this.affinity});
  final GpuSubmissionTracker submissions;
  final PersistentGpuExecutionAffinity affinity;
  final Map<int, PersistentGpuOwnerRecord> owners = {};
  final Map<int, PersistentGpuAllocationRecord> records = {};
  int nextOwnerId = 1;
  int nextRecordId = 1;
  int contextGeneration = 1;
  PersistentGpuContextState contextState = PersistentGpuContextState.active;
}
```

**Handwritten budget:** production 40–55 + test 18–30 = 58–85 lines。

- [ ] **RED:** records expose exactly the fields above, generation starts1, and there is no method declaration on
  either record class. Run `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'registry records are data only and generation starts at one' 'RED:T04A:registry records missing'`。
- [ ] **GREEN:** add only records, enum and registry state; no owner/allocation operation yet. Run focused model and
  tracker regressions plus analyze/diff-check。
- [ ] **Commit:** `Feature: GPU registry状態を追加`。

### Task 4B: typed lease and current-state gate (depends Task 4A; 45–85 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces final `PersistentGpuResourceLease` with `recordId`, `generation`, `state`, and
`requireCurrentActive`; registry produces the two same-named public internal entrypoints used by the lease。

**RED test snippet:**

```dart
test('lease current-state check is affinity first', () {
  expectRedSourceContract(path: 'lib/src/render/persistent_gpu_resource_registry.dart',
      marker: 'void requireCurrentActive(PersistentGpuResourceLease lease)',
      diagnostic: 'RED:T04B:lease state gate missing');
});
```

**GREEN implementation snippet:**

```dart
final class PersistentGpuResourceLease {
  PersistentGpuResourceLease({required this.registry, required this.recordId,
      required this.generation});
  final PersistentGpuResourceRegistry registry;
  final int recordId;
  final int generation;
  PersistentGpuResourceState get state => registry.resourceStateFor(this);
  void requireCurrentActive() => registry.requireCurrentActive(this);
}

PersistentGpuResourceState resourceStateFor(PersistentGpuResourceLease lease) {
  affinity.check();
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation) {
    throw StateError('foreign persistent GPU lease');
  }
  return switch (record.state) {
    PersistentGpuAllocationState.active => PersistentGpuResourceState.active,
    PersistentGpuAllocationState.pendingOpenFrame ||
    PersistentGpuAllocationState.pendingSubmission ||
    PersistentGpuAllocationState.releasing =>
      PersistentGpuResourceState.retirementPending,
    PersistentGpuAllocationState.retired => PersistentGpuResourceState.retired,
    PersistentGpuAllocationState.failed =>
      PersistentGpuResourceState.retirementFailed,
  };
}

void requireCurrentActive(PersistentGpuResourceLease lease) {
  affinity.check();
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation ||
      record.state != PersistentGpuAllocationState.active ||
      contextState != PersistentGpuContextState.active ||
      record.generation != contextGeneration ||
      owners[record.ownerId]?.state != PersistentGpuResourceLifecycleState.active) {
    throw StateError('persistent GPU lease is not current and active');
  }
}
```

**Handwritten budget:** production 35–50 + test 20–35 = 55–85 lines。

- [ ] **RED:** foreign/terminal/old-generation/disposed-owner checks throw before state read exposed to caller;
  affinity mismatch leaves every map/record unchanged. Run `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'lease current-state check is affinity first' 'RED:T04B:lease state gate missing'`。
- [ ] **GREEN:** add the complete typed lease/state matrix only. Run registry/model tests and analyze/diff-check。
- [ ] **Commit:** `Feature: GPU lease状態検証を追加`。

### Task 4C: affinity-checked owner and allocation registration (depends Task 4B; 50–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `int attachOwner()` and
`PersistentGpuResourceLease register({required int ownerId, required int totalBytes, required int instanceBytes, required void Function() release})`。

**RED test snippet:**

```dart
test('owner registration validates inline after affinity', () {
  expectRedSourceContract(path: 'lib/src/render/persistent_gpu_resource_registry.dart',
      marker: 'PersistentGpuResourceLease register({',
      diagnostic: 'RED:T04C:owner registration missing');
});
```

**GREEN implementation snippet:**

```dart
int attachOwner() {
  affinity.check();
  if (contextState == PersistentGpuContextState.invalidating ||
      contextState == PersistentGpuContextState.failed) {
    throw StateError('context rejects new owners');
  }
  final id = nextOwnerId++;
  owners[id] = PersistentGpuOwnerRecord(id: id);
  return id;
}

PersistentGpuResourceLease register({required int ownerId,
    required int totalBytes, required int instanceBytes,
    required void Function() release}) {
  affinity.check();
  final owner = owners[ownerId];
  if (owner == null || owner.state != PersistentGpuResourceLifecycleState.active) {
    throw StateError('owner is not active');
  }
  if (contextState != PersistentGpuContextState.active) {
    throw StateError('context is not active');
  }
  if (totalBytes <= 0 || instanceBytes <= 0 || instanceBytes > totalBytes) {
    throw ArgumentError('invalid persistent GPU allocation bytes');
  }
  final id = nextRecordId++;
  records[id] = PersistentGpuAllocationRecord(id: id, ownerId: ownerId,
      generation: contextGeneration, totalBytes: totalBytes,
      instanceBytes: instanceBytes, release: release);
  return PersistentGpuResourceLease(registry: this, recordId: id,
      generation: contextGeneration);
}
```

**Handwritten budget:** production 35–50 + test 25–40 = 60–90 lines。

- [ ] **RED:** IDs monotonic; every invalid owner/context/byte row and affinity mismatch leaves IDs/maps/callbacks
  unchanged. Run `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'owner registration validates inline after affinity' 'RED:T04C:owner registration missing'`。
- [ ] **GREEN:** inline the small validations; add no private helper/class method. Run registry/model/tracker tests。
- [ ] **Commit:** `Feature: GPU allocation登録を追加`。

### Task 4D: immediate idempotent retirement (depends Task 4C; 50–90 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Lease gains `Future<void> retire()`; registry gains `retire` and `releaseRecord`, both internal
public methods so tests can audit transition order directly。

**RED test snippet:**

```dart
test('unused allocation retirement is immediate and idempotent', () {
  expectRedSourceContract(path: 'lib/src/render/persistent_gpu_resource_registry.dart',
      marker: 'Future<void> retire(PersistentGpuResourceLease lease)',
      diagnostic: 'RED:T04D:immediate retirement missing');
});
```

**GREEN implementation snippet:**

```dart
Future<void> retire(PersistentGpuResourceLease lease) {
  affinity.check();
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation) {
    throw StateError('foreign persistent GPU lease');
  }
  if (record.retirement case final existing) return existing.future;
  return releaseRecord(record);
}

Future<void> releaseRecord(PersistentGpuAllocationRecord record) {
  affinity.check();
  final existing = record.retirement;
  if (record.state == PersistentGpuAllocationState.releasing ||
      record.state == PersistentGpuAllocationState.retired ||
      record.state == PersistentGpuAllocationState.failed) {
    if (existing == null) throw StateError('terminal record has no retirement');
    return existing.future;
  }
  final completer = existing ?? Completer<void>();
  record.retirement ??= completer;
  record.state = PersistentGpuAllocationState.releasing;
  record.release();
  record.state = PersistentGpuAllocationState.retired;
  records.remove(record.id);
  completer.complete();
  return completer.future;
}
```

Lease `retire()` is the one-line `registry.retire(this)` delegate. `retire` performs lookup only after its affinity
check and delegates the first state mutation to `releaseRecord`; that method checks affinity before publishing the
cached completer. If either entry check throws, completer/state/callback/map all remain unchanged。

**Handwritten budget:** production 30–45 + test 25–40 = 55–85 lines。

- [ ] **RED:** unused lease releases once; repeated/reentrant calls return one Future. Configure affinity failure
  independently at either public entry and assert retirement remains null, state active, callback0, map unchanged.
  After restoring affinity, retry succeeds exactly once. Run
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'unused allocation retirement is immediate and idempotent' 'RED:T04D:immediate retirement missing'`。
- [ ] **GREEN:** implement only never-submitted immediate release. Task12/14 extend routing without weakening the
  pre-mutation affinity gate. Run registry/model/tracker tests and analyze/diff-check。
- [ ] **Commit:** `Feature: GPU allocationを即時retire`。

### Task 5: active logical-memory snapshot (depends Task 4D; 45–90 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces
`PersistentGpuMemorySnapshot snapshotFor({required int ownerId, required PersistentGpuResourceLifecycleState lifecycleState})`。

**Implementation shape:** initialize two nine-counter accumulators, fold each record once into global and into
owner when IDs match, then construct immutable usages/snapshot from tracker counters. `affinity.check()` is the
first executable statement, before owner lookup or counter reads。

**RED test snippet:**

```dart
test("snapshot separates global and owner active logical bytes", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "PersistentGpuMemorySnapshot snapshotFor({",
    diagnostic: "RED:T05:snapshot affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
PersistentGpuMemorySnapshot snapshotFor({
  required int ownerId,
  required PersistentGpuResourceLifecycleState lifecycleState,
}) {
  affinity.check();
  if (!owners.containsKey(ownerId)) throw StateError('unknown owner');
  final global = accumulatePersistentGpuUsage(records.values);
  final owner = accumulatePersistentGpuUsage(
    records.values.where((record) => record.ownerId == ownerId),
  );
  return PersistentGpuMemorySnapshot(
    contextState: contextState,
    lifecycleState: lifecycleState,
    contextGeneration: contextGeneration,
    latestSubmission: submissions.latestSubmission,
    completedThrough: submissions.completedThrough,
    global: global,
    owner: owner,
  );
}

PersistentGpuMemoryUsage accumulatePersistentGpuUsage(
    Iterable<PersistentGpuAllocationRecord> source) {
  var activeCount = 0, retiringCount = 0, failedCount = 0;
  var activeTotal = 0, retiringTotal = 0, failedTotal = 0;
  var activeInstance = 0, retiringInstance = 0, failedInstance = 0;
  for (final record in source) {
    switch (record.state) {
      case PersistentGpuAllocationState.active:
        activeCount++; activeTotal += record.totalBytes;
        activeInstance += record.instanceBytes;
        break;
      case PersistentGpuAllocationState.pendingOpenFrame ||
            PersistentGpuAllocationState.pendingSubmission ||
            PersistentGpuAllocationState.releasing:
        retiringCount++; retiringTotal += record.totalBytes;
        retiringInstance += record.instanceBytes;
        break;
      case PersistentGpuAllocationState.failed:
        failedCount++; failedTotal += record.totalBytes;
        failedInstance += record.instanceBytes;
        break;
      case PersistentGpuAllocationState.retired:
        break;
    }
  }
  return PersistentGpuMemoryUsage(activeResourceCount: activeCount,
      retiringResourceCount: retiringCount, failedResourceCount: failedCount,
      activeTotalBytes: activeTotal, retiringTotalBytes: retiringTotal,
      failedTotalBytes: failedTotal, activeInstanceBytes: activeInstance,
      retiringInstanceBytes: retiringInstance,
      failedInstanceBytes: failedInstance);
}
```

**Handwritten budget:** 45–90 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** register `(64,24)` and `(96,48)` under two owners; assert global `2/160/72`, owner
  `1/64/24`, generation1, exact tracker counters, unknown owner failure. Swap the affinity token, assert the exact
  diagnostic and no getter/record read, restore it, and prove the snapshot is unchanged. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'snapshot separates global and owner active logical bytes' 'RED:T05:snapshot affinity gate missing'`。
- [ ] **GREEN:** one fold builds global/owner active/retiring/failed buckets; do not report driver bytes. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU memory集計を追加`。

### Task 6: owner disposal on immediate leases (depends Task 5; 50–90 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `Future<void> disposeOwner(int ownerId)` and owner state/cached FD storage。

**Implementation shape:** set owner disposed and publish one owner FD completer/Future before calling any retire
path; then snapshot its records, call each cached retire path, and complete FD from their non-eager `Future.wait`.
Repeated and release-callback-reentrant calls return FD by identity. `affinity.check()` is first, before the
owner lookup, cached-FD read, state mutation, or callback path。

**RED test snippet:**

```dart
test("owner disposal shares resource futures and leaves other owners active", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "Future<void> disposeOwner(int ownerId)",
    diagnostic: "RED:T06:dispose affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
Future<void> disposeOwner(int ownerId) {
  affinity.check();
  final owner = owners[ownerId];
  if (owner == null) throw StateError('unknown owner');
  if (owner.disposal case final existing) return existing.future;
  final completer = Completer<void>();
  owner.disposal = completer;
  owner.state = PersistentGpuResourceLifecycleState.disposed;
  final retirements = records.values
      .where((record) => record.ownerId == ownerId)
      .map((record) => retire(PersistentGpuResourceLease(registry: this,
          recordId: record.id, generation: record.generation)))
      .toList(growable: false);
  Future.wait(retirements, eagerError: false).then(
    (_) => completer.complete(),
    onError: (Object error, StackTrace stackTrace) =>
        completer.completeError(error, stackTrace),
  );
  return completer.future;
}
```

**Handwritten budget:** 50–90 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** dispose A retires only A while B remains active; disposed A snapshot remains readable; repeated and
  first-release-callback-reentrant dispose are identical; resource Future completes before FD; unknown owner fails.
  An affinity mismatch returns no Future, invokes no release, and leaves owner/record state byte-for-byte unchanged.
  Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'owner disposal shares resource futures and leaves other owners active' 'RED:T06:dispose affinity gate missing'`。
- [ ] **GREEN:** publish owner state+FD before retiring a record snapshot; FD waits only that owner's records and
  propagates first error after every callback was attempted. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU resource owner破棄を追加`。

### Task 7: global invalidation on immediate leases (depends Task 6; 55–100 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `Future<void> invalidateContext(int ownerId)` and generation-cached FI。

**Implementation shape:** set global invalidating, create and publish one generation FI completer/Future, then
snapshot and retire every current-generation record. This publication must precede the first synchronous release
callback so reentrant invalidation sees the same FI. Complete it only after all record Futures and any owner FD
notifications settle, then set invalidated immediately before successful FI completion. `affinity.check()` is
the first executable statement before owner lookup, FI lookup, state mutation, or callbacks。

**RED test snippet:**

```dart
test("one owner invalidates all immediate resources in the generation", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "Future<void> invalidateContext(int ownerId)",
    diagnostic: "RED:T07:invalidate affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
Future<void> invalidateContext(int ownerId) {
  affinity.check();
  final owner = owners[ownerId];
  if (owner == null || owner.state != PersistentGpuResourceLifecycleState.active) {
    throw StateError('owner is not active');
  }
  if (invalidation case final existing) return existing.future;
  if (contextState != PersistentGpuContextState.active) {
    throw StateError('context cannot begin invalidation');
  }
  final completer = Completer<void>();
  invalidation = completer;
  contextState = PersistentGpuContextState.invalidating;
  final retirements = records.values
      .where((record) => record.generation == contextGeneration)
      .map((record) => retire(PersistentGpuResourceLease(registry: this,
          recordId: record.id, generation: record.generation)))
      .toList(growable: false);
  Future.wait(retirements, eagerError: false).then((_) {
    contextState = PersistentGpuContextState.invalidated;
    completer.complete();
  }, onError: (Object error, StackTrace stackTrace) {
    completer.completeError(error, stackTrace);
  });
  return completer.future;
}

Completer<void>? invalidation;
```

**Handwritten budget:** 55–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** A invalidates A/B records; state and cached FI exist before the first callback; that callback's
  reentrant invalidation and B's call return the identical FI; register rejects; resource→FD→FI order is exact.
  Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'one owner invalidates all immediate resources in the generation' 'RED:T07:invalidate affinity gate missing'`。
- [ ] **GREEN:** validate active owner, publish context+FI before retiring a snapshot, finalize invalidated after
  all record/owner Futures settle. No open-frame references exist yet. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/gpu_submission_tracker_test.dart test/render/persistent_gpu_resource_models_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: global GPU invalidationを追加`。

### Task 8: recreate and zero-owner recovery (depends Task 7; 55–100 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `void recreateContext(int ownerId)`; `attachOwner()` accepts active/invalidated only;
lease `requireCurrentActive()` checks record active, owner active, context active, and record generation==global。

**Implementation shape:** recovery attach creates only an owner entry; recreate verifies invalidated/no failures,
increments generation once, clears prior FI and sets active; old records retain their original generation.
`recreateContext` calls `affinity.check()` first, before owner/context reads or generation mutation。

**RED test snippet:**

```dart
test("zero-owner invalidation recovers while old generation leases reject", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "void recreateContext(int ownerId)",
    diagnostic: "RED:T08:recreate affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void recreateContext(int ownerId) {
  affinity.check();
  final owner = owners[ownerId];
  if (owner == null || owner.state != PersistentGpuResourceLifecycleState.active) {
    throw StateError('owner is not active');
  }
  if (contextState != PersistentGpuContextState.invalidated) {
    throw StateError('context is not recreatable');
  }
  contextGeneration++;
  invalidation = null;
  contextState = PersistentGpuContextState.active;
}
```

**Handwritten budget:** 55–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** last owner dispose during invalidating leaves FI alive; owner count0 reaches invalidated; recovery
  owner attaches, cannot register, recreates generation1→2, then registers. Old generation lease rejects via the
  same surviving owner after recreate. Invalidating/failed attach and invalid recreate rows fail. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'zero-owner invalidation recovers while old generation leases reject' 'RED:T08:recreate affinity gate missing'`。
- [ ] **GREEN:** registry lifetime is process-global; increment only invalidated→active; never mutate old record
  generation. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU generation再作成を追加`。

### Task 9: public lifecycle handle core (depends Task 8; 55–95 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_lifecycle.dart`; Create
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Produces public constructor attached to `persistentGpuResourceRegistry`, internal
`PersistentGpuResourceLifecycle.forRegistry(PersistentGpuResourceRegistry registry)`, getters/snapshot, and
internal exact delegates `void checkCanCreate()` and
`PersistentGpuResourceLease registerAllocation({required int totalBytes, required int instanceBytes, required void Function() release})`。

**Implementation shape:** both constructors call `attachOwner`; every getter/delegate forwards with stored ownerId;
the public constructor alone selects the global registry。

**RED test snippet:**

```dart
test("lifecycle handles share one registry and distinct owners", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_lifecycle.dart",
    marker: "final class PersistentGpuResourceLifecycle",
    diagnostic: "RED:T09:lifecycle handle missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentGpuResourceLifecycle {
  PersistentGpuResourceLifecycle()
      : this.forRegistry(persistentGpuResourceRegistry);

  PersistentGpuResourceLifecycle.forRegistry(this._registry)
      : _ownerId = _registry.attachOwner();

  final PersistentGpuResourceRegistry _registry;
  final int _ownerId;
}
```

**Handwritten budget:** 55–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** two injected handles share context/generation/global snapshot but distinct owner usage; public
  constructor uses the global identity. Run:
  `run_fork_red test/render/persistent_gpu_resource_lifecycle_test.dart 'lifecycle handles share one registry and distinct owners' 'RED:T09:lifecycle handle missing'`。
- [ ] **GREEN:** handle stores registry/ownerId/cached FE only. No operation method is added here. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: persistent GPU lifecycleを追加`。

### Task 10: lifecycle active-owner operation matrix (depends Task 9; 50–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_lifecycle.dart`; Modify
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Produces direct non-`async` `invalidateContext()`、synchronous `recreateContext()`、direct
non-`async` `dispose()` matching active-owner rows in Final state contracts。

**Implementation shape:** methods first check local owner state then directly return/call the registry method;
they add no `async`, completer or state copy。

**RED test snippet:**

```dart
test("active lifecycle operations match every context row", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_lifecycle.dart",
    marker: "Future<void> invalidateContext()",
    diagnostic: "RED:T10:active operation matrix missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
Future<void> invalidateContext() => _registry.invalidateContext(_ownerId);

void recreateContext() => _registry.recreateContext(_ownerId);

Future<void> dispose() => _registry.disposeOwner(_ownerId);
```

**Handwritten budget:** 50–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** parameterize active owner × active/invalidating/invalidated: shared FI, recreate only from
  invalidated, owner-specific FD, and next-generation FI non-identical. Run:
  `run_fork_red test/render/persistent_gpu_resource_lifecycle_test.dart 'active lifecycle operations match every context row' 'RED:T10:active operation matrix missing'`。
- [ ] **GREEN:** return registry Futures directly; no second completer. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: lifecycle active操作表を固定`。

### Task 11: lifecycle disposed and reentry matrix (depends Task 10; 50–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_lifecycle.dart`; Modify
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Completes disposed-owner rows with cached FE; snapshot/getters remain read-only after dispose。

**Implementation shape:** dispose stores FD once; disposed invalidate returns one pre-created failed FE;
recreate throws synchronously; snapshot/getters remain registry reads。

**RED test snippet:**

```dart
test("disposed lifecycle and release reentry preserve Future identities", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_lifecycle.dart",
    marker: "_disposedInvalidateFuture",
    diagnostic: "RED:T11:disposed reentry matrix missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
late final Future<void> _disposedInvalidateFuture = Future<void>.error(
  StateError('persistent GPU lifecycle is disposed'),
);

Future<void> invalidateContext() => state ==
        PersistentGpuResourceLifecycleState.disposed
    ? _disposedInvalidateFuture
    : _registry.invalidateContext(_ownerId);
```

**Handwritten budget:** 50–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** for active/invalidating/invalidated contexts, disposed invalidate returns identical FE, disposed
  dispose identical FD, disposed recreate throws synchronously, dispose during invalidation waits own records, and
  release callback reenters
  dispose/invalidate/snapshot without duplicate release. Run:
  `run_fork_red test/render/persistent_gpu_resource_lifecycle_test.dart 'disposed lifecycle and release reentry preserve Future identities' 'RED:T11:disposed reentry matrix missing'`。
- [ ] **GREEN:** disposed check precedes global mutation; only FE lives on handle. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: lifecycle disposed操作表を固定`。

### Task 12: open-frame mark and no-submit retirement (depends Task 11; 55–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`; Modify
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Registry produces `void beginFrame()`、
`void markUsed(PersistentGpuResourceLease lease)`、`void endFrame()` and open identity set; lease produces
`void markUsed()` as its registry-bound direct delegate for Task38。

**Implementation shape:** lease `markUsed()` is the one-line `registry.markUsed(this)` delegate. Registry checks
affinity/frame/lease identity/current generation before inserting the record into `openFrameMarks`. `beginFrame`,
`markUsed`, `retire`, and `endFrame` each call `affinity.check()` before any field/map read, Future creation,
mutation, or callback. No lease reaches through registry internals。

**RED test snippet:**

```dart
test("open frame without submission retires only at end", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "void beginFrame()",
    diagnostic: "RED:T12:frame affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
bool frameOpen = false;
final Set<PersistentGpuAllocationRecord> openFrameMarks = {};

void beginFrame() {
  affinity.check();
  if (frameOpen) throw StateError('frame already open');
  frameOpen = true;
}

void markUsed(PersistentGpuResourceLease lease) {
  affinity.check();
  if (!frameOpen) throw StateError('frame is closed');
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation ||
      record.generation != contextGeneration ||
      record.state != PersistentGpuAllocationState.active ||
      contextState != PersistentGpuContextState.active ||
      owners[record.ownerId]?.state !=
          PersistentGpuResourceLifecycleState.active) {
    throw StateError('persistent GPU lease is not current and active');
  }
  openFrameMarks.add(record);
}

Future<void> retire(PersistentGpuResourceLease lease) {
  affinity.check();
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation) {
    throw StateError('foreign persistent GPU lease');
  }
  if (record.retirement case final existing) return existing.future;
  if (frameOpen && openFrameMarks.contains(record)) {
    final completer = Completer<void>();
    record.retirement = completer;
    record.state = PersistentGpuAllocationState.pendingOpenFrame;
    return completer.future;
  }
  return releaseRecord(record);
}

void endFrame() {
  affinity.check();
  if (!frameOpen) throw StateError('frame is closed');
  final marked = Set<PersistentGpuAllocationRecord>.of(openFrameMarks);
  frameOpen = false;
  openFrameMarks.clear();
  for (final record in marked) {
    if (record.state != PersistentGpuAllocationState.pendingOpenFrame) {
      continue;
    }
    final last = record.lastSubmission;
    if (last != null && submissions.completedThrough < last) {
      record.state = PersistentGpuAllocationState.pendingSubmission;
    } else {
      releaseRecord(record);
    }
  }
}
```

**Handwritten budget:** 55–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** never-submitted `begin→mark→retire→end` releases once; a resource with incomplete prior
  `lastSubmission=1` stays pending through a later no-submit frame until completion1; double mark stays one mark;
  nested begin, closed end/mark, foreign/terminal/old-generation lease throw before mutation. For each of
  begin/lease-mark/registry-mark/end, swap the token, assert its diagnostic and unchanged frame/record snapshots,
  restore the token, then prove the valid call succeeds. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'open frame without submission retires only at end' 'RED:T12:frame affinity gate missing'`。
- [ ] **GREEN:** mark records by identity; immediate `retire()` path from Task4D becomes pending-open when marked;
  end clears marks and releases only when `lastSubmission == null || completedThrough >= lastSubmission`; otherwise
  it preserves that exact prior stamp as pending-submission. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU resource frame記録を追加`。

### Task 13: before-submit stamping after invalidation exists (depends Task 12; 45–85 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Registry constructor registers exactly one tracker before-submit listener; record stores nullable
`lastSubmission`; internal directly testable entrypoint is `void handleBeforeSubmit(int submissionId)`。

**Implementation shape:** listener snapshots `openFrameMarks`, clears it, and assigns each live record
`lastSubmission = max(lastSubmission ?? id, id)` without settling any Future. Its callback entrypoint calls
`affinity.check()` first, before reading the mark set or submission id and before clearing/stamping anything。

**RED test snippet:**

```dart
test("retire during open frame stamps the next submission after invalidation", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "void handleBeforeSubmit(int submissionId)",
    diagnostic: "RED:T13:before-submit affinity gate missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void handleBeforeSubmit(int submissionId) {
  affinity.check();
  final marked = Set<PersistentGpuAllocationRecord>.of(openFrameMarks);
  openFrameMarks.clear();
  for (final record in marked) {
    record.lastSubmission = max(record.lastSubmission ?? submissionId,
        submissionId);
    if (record.state == PersistentGpuAllocationState.pendingOpenFrame) {
      record.state = PersistentGpuAllocationState.pendingSubmission;
    }
  }
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** `begin→mark→retire→record` becomes pendingSubmission with last1; an active record marked again
  between two submits produces last2; Task7
  invalidation rejects new marks but the pre-existing mark still receives its stamp. A callback-affinity mismatch
  leaves every mark and stamp unchanged; after restoring the token, the same callback stamps normally. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'retire during open frame stamps the next submission after invalidation' 'RED:T13:before-submit affinity gate missing'`。
- [ ] **GREEN:** listener snapshots+clears marks and writes max(previous,id) for active/pending-open records; it
  never completes retirement. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU submission stampを追加`。

### Task 14: completion-gated retirement (depends Task 13; 55–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Registry constructor registers one completion listener; existing lease cached Future/state now
waits `completedThrough >= lastSubmission`; internal directly testable entrypoint is
`void handleCompletion(int completedThrough)`。

**Implementation shape:** `retire` is extended so an active record with an incomplete `lastSubmission` becomes
`pendingSubmission` and retains its buffer/callback. Completion snapshots eligible pending records and invokes
Task4D `releaseRecord` only at/above the watermark. Both callback and release entry call `affinity.check()` before
reads or mutation; an affinity error propagates without becoming a GPU release failure。

**RED test snippet:**

```dart
test("completion watermark releases every stamped retirement exactly once", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "void handleCompletion(int completedThrough)",
    diagnostic: "RED:T14:completion affinity gate missing",
  );
});
```

**GREEN implementation snippet:**

```dart
Future<void> retire(PersistentGpuResourceLease lease) {
  affinity.check();
  final record = records[lease.recordId];
  if (record == null || record.generation != lease.generation) {
    throw StateError('foreign persistent GPU lease');
  }
  if (record.retirement case final existing) return existing.future;
  final last = record.lastSubmission;
  if (last != null && submissions.completedThrough < last) {
    final completer = Completer<void>();
    record.retirement = completer;
    record.state = PersistentGpuAllocationState.pendingSubmission;
    return completer.future;
  }
  return releaseRecord(record);
}

void handleCompletion(int completedThrough) {
  affinity.check();
  final eligible = <PersistentGpuAllocationRecord>[];
  for (final record in records.values) {
    final last = record.lastSubmission;
    if (record.state == PersistentGpuAllocationState.pendingSubmission &&
        last != null && last <= completedThrough) {
      eligible.add(record);
    }
  }
  for (final record in eligible) {
    releaseRecord(record);
  }
}
```

**Handwritten budget:** 55–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** cover the missing active-submitted path exactly: `begin→mark→record(submit)→end→retire` yields
  pendingSubmission, callback0, buffer retained and incomplete cached Future until completion; then release1 and
  Future success. Also cover submit→complete→retire, mark→retire→submit→complete, ids2→1, and two owners calling
  invalidate during the pending period return the identical FI which completes only after resource Futures and
  owner FDs. Affinity mismatch invokes no release and changes no record/accounting/Future. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'completion watermark releases every stamped retirement exactly once' 'RED:T14:completion affinity gate missing'`。
- [ ] **GREEN:** route active+incomplete-last directly to pendingSubmission and never call `release` early;
  eligible completion snapshot only, then Task4D performs the checked releasing transition. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/frame_transients_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU completion後にresourceを解放`。

### Task 15A: release failure and ordered continuation (depends Task 14; 55–100 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces terminal failed accounting, first context cause,
`@visibleForTesting List<AsyncError> get failureLog`, and cached terminal failure Future returned by later
active-owner `invalidateContext`; recreate/register/bind reject failed state; disposed-owner FE/FD rules remain
owner-specific。

**Implementation shape:** `releaseRecord` checks affinity before any state change. Only an exception thrown by the
registered release callback after the checked transition becomes `failed`; affinity errors propagate with record,
context, Future and log unchanged. Callback failures append every error, and a precomputed completion batch
continues in registration order without retrying failed records. Only after the whole batch has run does it store
the first context cause and mark the context failed. An in-flight invalidation still completes through its Task7
coordinator after resource Futures and owner FDs; `releaseRecordsInOrder` never completes FI itself。

**RED test snippet:**

```dart
test("release failures are ordered terminal and do not stop later release", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_resource_registry.dart",
    marker: "List<AsyncError>.unmodifiable(releaseFailures)",
    diagnostic: "RED:T15A:ordered release failure missing",
  );
});
```

**GREEN implementation snippet:**

```dart
final List<AsyncError> releaseFailures = [];
AsyncError? terminalContextCause;
Completer<void>? terminalFailureInvalidation;

@visibleForTesting
List<AsyncError> get failureLog =>
    List<AsyncError>.unmodifiable(releaseFailures);

Future<void> releaseRecord(PersistentGpuAllocationRecord record) {
  affinity.check();
  final existing = record.retirement;
  if (record.state == PersistentGpuAllocationState.retired ||
      record.state == PersistentGpuAllocationState.failed ||
      record.state == PersistentGpuAllocationState.releasing) {
    if (existing == null) throw StateError('terminal record has no retirement');
    return existing.future;
  }
  final completer = existing ?? Completer<void>();
  record.retirement ??= completer;
  record.state = PersistentGpuAllocationState.releasing;
  try {
    record.release();
    record.state = PersistentGpuAllocationState.retired;
    records.remove(record.id);
    completer.complete();
  } catch (error, stackTrace) {
    final failure = AsyncError(error, stackTrace);
    record.state = PersistentGpuAllocationState.failed;
    releaseFailures.add(failure);
    completer.completeError(error, stackTrace);
  }
  return completer.future;
}

void releaseRecordsInOrder(List<PersistentGpuAllocationRecord> batch) {
  affinity.check();
  final failureStart = releaseFailures.length;
  for (final record in batch) {
    releaseRecord(record);
  }
  if (releaseFailures.length == failureStart) return;
  final first = releaseFailures[failureStart];
  terminalContextCause ??= first;
  contextState = PersistentGpuContextState.failed;
}
```

Task 15A replaces Task 14's per-record completion loop with
`releaseRecordsInOrder(eligible)`; the eligible list remains the precomputed registration-order snapshot. The
immediate branch of `retire` similarly calls `releaseRecordsInOrder([record])`, then returns the now-published
`record.retirement.future` after a null invariant check. Owner disposal and context invalidation precompute their
record lists before calling the same ordered entry, so all siblings are attempted even if an earlier callback
throws。

```dart
releaseRecordsInOrder([record]);
final retirement = record.retirement;
if (retirement == null) {
  throw StateError('release did not publish retirement');
}
return retirement.future;
```

**Handwritten budget:** production 55–70 + test 30–40 = 85–100 lines。

- [ ] **RED:** A callback reenters its retire/snapshot then throws first; B throws second. Complete the shared
  submission; assert callbacks once, both resources/context failed, failed bytes retained, later records still
  attempted in registration order, `failureLog` is `[first,second]`, and each resource Future fails with its own
  callback error. Repeated completion/retire never retries. Separately force affinity failure before
  `releaseRecord`; assert active/pending state, Future identity, log, context and callback count are unchanged;
  retry after restoring affinity succeeds. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'release failures are ordered terminal and do not stop later release' 'RED:T15A:ordered release failure missing'`。
- [ ] **GREEN:** publish state before callback, preserve each resource error, store the first context cause only
  after the whole ordered snapshot, and never complete FI here. Run focused registry/lifecycle/tracker tests plus
  analyze/diff-check。
- [ ] **Commit:** `Fix: GPU release失敗をterminal化`。

### Task 15B: failure FI waits for owner disposal (depends Task 15A; 55–100 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`; Modify
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Replaces Task7 `invalidateContext` with the complete failed/in-flight coordinator; a later
active-owner call on a previously failed context returns one cached terminal Future, while an already in-flight
invalidation retains its exact FI identity。

**Implementation shape:** The local continuation registers
owner FD waits only after every resource Future settles, and it never reads or mutates registry state before its
own affinity check:

**RED test snippet:**

```dart
test('failed invalidation waits resource then owner before identical FI', () {
  expectRedSourceContract(
    path: 'lib/src/render/persistent_gpu_resource_registry.dart',
    marker: 'void finishAfterOwnerDisposals(AsyncError? fallback)',
    diagnostic: 'RED:T15B:failure FI ordering missing',
  );
});
```

**GREEN implementation snippet:**

```dart
Future<void> invalidateContext(int ownerId) {
  affinity.check();
  final owner = owners[ownerId];
  if (owner == null ||
      owner.state != PersistentGpuResourceLifecycleState.active) {
    throw StateError('owner is not active');
  }
  if (invalidation case final existing) return existing.future;
  if (contextState == PersistentGpuContextState.failed) {
    if (terminalFailureInvalidation case final existing) {
      return existing.future;
    }
    final cause = terminalContextCause;
    if (cause == null) throw StateError('failed context has no cause');
    final completer = Completer<void>();
    terminalFailureInvalidation = completer;
    completer.completeError(cause.error, cause.stackTrace);
    return completer.future;
  }
  if (contextState != PersistentGpuContextState.active) {
    throw StateError('context cannot begin invalidation');
  }
  final completer = Completer<void>();
  invalidation = completer;
  contextState = PersistentGpuContextState.invalidating;
  final batch = records.values
      .where((record) => record.generation == contextGeneration)
      .toList(growable: false);
  final retirements = batch.map((record) => retire(
    PersistentGpuResourceLease(registry: this, recordId: record.id,
        generation: record.generation),
  )).toList(growable: false);

  void finishAfterOwnerDisposals(AsyncError? fallback) {
    affinity.check();
    final disposals = owners.values
        .map((owner) => owner.disposal?.future)
        .whereType<Future<void>>()
        .toList(growable: false);
    Future.wait(disposals, eagerError: false).then<void>((_) {
      affinity.check();
      final failure = terminalContextCause ?? fallback;
      if (failure != null) {
        contextState = PersistentGpuContextState.failed;
        completer.completeError(failure.error, failure.stackTrace);
      } else {
        contextState = PersistentGpuContextState.invalidated;
        completer.complete();
      }
    }, onError: (Object error, StackTrace stackTrace) {
      affinity.check();
      final failure = terminalContextCause ??
          fallback ?? AsyncError(error, stackTrace);
      contextState = PersistentGpuContextState.failed;
      completer.completeError(failure.error, failure.stackTrace);
    });
  }

  Future.wait(retirements, eagerError: false).then<void>(
    (_) => finishAfterOwnerDisposals(null),
    onError: (Object error, StackTrace stackTrace) =>
        finishAfterOwnerDisposals(AsyncError(error, stackTrace)),
  );
  return completer.future;
}
```

**Handwritten budget:** production 65–78 + tests 25–35 = 90–100 lines。

- [ ] **RED:** During in-flight invalidation, A callback reentrantly disposes its owner and throws; B throws after
  it. Assert the exact order callback A→callback B→resource Futures→owner FD→global FI, identical FI from two
  owners and reentrant/later calls, and FI failure with the first context cause only after all callbacks. For a
  release failure before invalidation, the first later active-owner invalidation creates one terminal Future and
  every repeat returns that exact object. Disposed owner still returns its owner-specific FE/FD. Run:
  `run_fork_red test/render/persistent_gpu_resource_registry_test.dart 'failed invalidation waits resource then owner before identical FI' 'RED:T15B:failure FI ordering missing'`。
- [ ] **GREEN:** let record Futures preserve per-callback errors; wait all record Futures non-eagerly, then all
  published owner FDs, then settle the single FI from `terminalContextCause`. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Fix: GPU invalidation失敗順序を固定`。

### Task 16: encode-scope try/finally seam (depends Task 15B; 35–70 lines)

**Files:** Create `lib/src/render/persistent_gpu_scene_frame.dart`; Create
`test/render/persistent_gpu_scene_frame_test.dart`。

**Interfaces:** Produces
`@visibleForTesting void runPersistentGpuEncodeScope({required void Function() beginFrame, required void Function() encode, required void Function() endFrame})`。

**Implementation shape:** call begin outside try; use exactly this null-safe primary-preservation shape (with the
real callbacks) so end always runs and never replaces an encode failure:

```dart
beginFrame();
AsyncError? primary;
try {
  encode();
} catch (error, stackTrace) {
  primary = AsyncError(error, stackTrace);
} finally {
  try {
    endFrame();
  } catch (error, stackTrace) {
    primary ??= AsyncError(error, stackTrace);
  }
}
if (primary case final failure) {
  Error.throwWithStackTrace(failure.error, failure.stackTrace);
}
```

**RED test snippet:**

```dart
test("encode scope closes and preserves the original failure", () {
  expectRedSourceContract(
    path: "lib/src/render/persistent_gpu_scene_frame.dart",
    marker: "void runPersistentGpuEncodeScope({",
    diagnostic: "RED:T16:encode failure preservation missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
@visibleForTesting
void runPersistentGpuEncodeScope({
  required void Function() beginFrame,
  required void Function() encode,
  required void Function() endFrame,
}) {
  beginFrame();
  AsyncError? primary;
  try {
    encode();
  } catch (error, stackTrace) {
    primary = AsyncError(error, stackTrace);
  } finally {
    try {
      endFrame();
    } catch (error, stackTrace) {
      primary ??= AsyncError(error, stackTrace);
    }
  }
  if (primary case final failure) {
    Error.throwWithStackTrace(failure.error, failure.stackTrace);
  }
}
```

**Handwritten budget:** 35–70 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** normal events are begin/encode/end; encode failure still ends and rethrows identical error/stack;
  begin failure runs neither later callback; encode+end failure preserves encode primary. Run:
  `run_fork_red test/render/persistent_gpu_scene_frame_test.dart 'encode scope closes and preserves the original failure' 'RED:T16:encode failure preservation missing'`。
- [ ] **GREEN:** one begin, one `try/finally`, capture one `AsyncError` only to preserve primary via
  `Error.throwWithStackTrace`; no generic framework. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_frame_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU encode scopeを追加`。

### Task 17: Scene owns one encode scope (depends Task 16; 40–80 lines)

**Files:** Modify `lib/src/scene.dart`; Create
`test/render/persistent_gpu_scene_integration_test.dart`。

**Interfaces:** Existing `renderViews(List<RenderView> views, ui.Canvas canvas, {ui.Rect? region, double? pixelRatio})`
remains the sole implementation entrypoint. It invokes the top-level Task16 seam directly; no private
`_renderViewsImpl`, private method, subclass, or second render entrypoint is introduced。

**Implementation shape:** replace only the opening and closing braces around the existing body so the method has
one expression-level `runPersistentGpuEncodeScope` call. Its `encode` closure retains
the old body verbatim; formatter-only indentation is excluded from the handwritten budget. Global begin/end are
tear-offs. This makes the top-level seam directly testable while preserving the public method as the only Scene
entrypoint。

**RED test snippet:**

```dart
test('Scene renderViews owns exactly one persistent encode scope', () {
  final source = File('lib/src/scene.dart').readAsStringSync();
  expect(
    source,
    allOf(
      contains('runPersistentGpuEncodeScope('),
      contains('encode: () {'),
      isNot(contains('_renderViewsImpl')),
    ),
    reason: 'RED:T17:Scene encode scope missing',
  );
});
```

**GREEN implementation snippet:**

```diff
-  }) {
+  }) => runPersistentGpuEncodeScope(
+    beginFrame: persistentGpuResourceRegistry.beginFrame,
+    encode: () {
@@ unchanged renderViews body @@
-  }
+    },
+    endFrame: persistentGpuResourceRegistry.endFrame,
+  );
```

This exact structural diff wraps the unchanged, already type-checked method statements inline and introduces no
callable besides Task16's top-level seam. The `@@` line is diff notation, not source. The final source-contract
assertion rejects `renderViewsBody` and `_renderViewsImpl` and requires the old first and last statements inside
`encode`。

**Handwritten budget:** production 8–15 + test 32–50 = 40–65 lines; formatter-only indentation is excluded。

- [ ] **RED:** source/test seam asserts wrapper contains one `runPersistentGpuEncodeScope`, begin/end use global
  registry, encode owns the old body inline once, no private/body helper identifier exists, and empty/throw routes
  keep ordering. Run `run_fork_red test/render/persistent_gpu_scene_integration_test.dart 'Scene renderViews owns exactly one persistent encode scope' 'RED:T17:Scene encode scope missing'`。
- [ ] **GREEN:** keep the old body inline inside the top-level seam closure and use exact global begin/end tear-offs.
  Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_integration_test.dart test/render/persistent_gpu_scene_frame_test.dart test/scene_view_test.dart test/render_scale_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: SceneへGPU lifecycleを接続`。

### Task 18: curated lifecycle public export (depends Task 17; 35–70 lines)

**Files:** Modify `lib/src/scene.dart`; Modify `lib/scene.dart`; Create
`test/render/persistent_gpu_lifecycle_public_api_test.dart`。

**Interfaces:** Public export includes lifecycle, exactly 3 enums, usage/snapshot; excludes registry, lease,
affinity, global registry and encode seam。

**Implementation shape:** `lib/src/scene.dart` imports internal files for Scene use; `lib/scene.dart` adds one
curated export from the lifecycle file for the handle and a separate curated export from the models file for five
model symbols. Dart exports are not transitive: the lifecycle file does not implicitly re-export its imports。

**RED test snippet:**

```dart
test("public lifecycle barrel hides registry internals", () {
  expectRedSourceContract(
    path: "lib/scene.dart",
    marker: "show PersistentGpuResourceLifecycle;",
    diagnostic: "RED:T18:curated lifecycle export missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
export 'src/render/persistent_gpu_resource_lifecycle.dart'
    show PersistentGpuResourceLifecycle;
export 'src/render/persistent_gpu_resource_models.dart'
    show
        PersistentGpuContextState,
        PersistentGpuMemorySnapshot,
        PersistentGpuMemoryUsage,
        PersistentGpuResourceLifecycleState,
        PersistentGpuResourceState;
```

**Handwritten budget:** 35–70 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** public-only import constructs lifecycle and reads active/generation1/zero snapshot; source requires
  both exact source paths and show-lists, then rejects each internal symbol. Run:
  `run_fork_red test/render/persistent_gpu_lifecycle_public_api_test.dart 'public lifecycle barrel hides registry internals' 'RED:T18:curated lifecycle export missing'`。
- [ ] **GREEN:** add curated `show` exports only. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_lifecycle_public_api_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_scene_integration_test.dart test/scene_view_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: persistent GPU lifecycleを公開`。

### Task 19: lifecycle README contract (depends Task 18; 30–70 lines)

**Files:** Modify `README.md`; Modify
`test/render/persistent_gpu_lifecycle_public_api_test.dart`。

**Interfaces:** Produces exact documented sequence `stop rendering → detach → invalidate → await → recreate`
and logical/reference vs resident-memory boundary。

**Implementation shape:** one README section contains exact sequence and explicit bullets for multi-owner,
terminal failure, logical/resident and missing automatic/device evidence boundaries。

**RED test snippet:**

```dart
test("README states terminal lifecycle ordering", () {
  expectRedSourceContract(
    path: "README.md",
    marker: "Persistent GPU resource lifecycle",
    diagnostic: "RED:T19:lifecycle README contract missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```markdown
## Persistent GPU resource lifecycle

stop rendering → detach → invalidate → await → recreate
```

**Handwritten budget:** 30–70 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** source expectation requires sequence plus multi-owner invalidation, terminal failure, no automatic
  context-loss signal, no device evidence. Run:
  `run_fork_red test/render/persistent_gpu_lifecycle_public_api_test.dart 'README states terminal lifecycle ordering' 'RED:T19:lifecycle README contract missing'`。
- [ ] **GREEN:** add only consumer contract. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_lifecycle_public_api_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_scene_integration_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Docs: persistent GPU lifecycle契約を追加`。

### Bottom delivery gate (no commit)

```bash
set -euo pipefail
version_json=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter --version --machine)
test -n "$version_json"
framework_revision=$(jq -er \
  '.frameworkRevision | select(type == "string" and length == 40)' \
  <<<"$version_json")
test "$framework_revision" = 4dacd3fc91d96262a33e5c598e17d816f0b35641
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart format --output=none --set-exit-if-changed lib test
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller
test -z "$(git status --porcelain=v1)"
bottom_head=$(git rev-parse HEAD)
bottom_line=$(git ls-remote --exit-code origin refs/heads/feat/persistent-gpu-lifecycle)
test "$(wc -l <<<"$bottom_line" | tr -d ' ')" -eq 1
test "${bottom_line%%[[:space:]]*}" = "$bottom_head"
git fetch origin refs/heads/feat/persistent-gpu-lifecycle:refs/remotes/origin/feat/persistent-gpu-lifecycle
git cat-file -e "$bottom_head^{commit}"
```

Record exact pass/fail/skip; GPU skip is not pass. Fresh spec/code reviewers must report zero findings. Push
bottom only with `gh stack push --remote origin`; do not submit a one-PR stack. From reviewed clean bottom run
`gh stack add feat/persistent-packed-instance-geometry`. An existing top requires supervisor-provided exact
`reviewed_top_resume_sha`, advertised ref equality, fetch/cat-file, clean local=remote, bottom ancestry, then
`gh stack checkout feat/persistent-packed-instance-geometry`; any mismatch stops without reset/delete/force。

```bash
set -euo pipefail
fork_clone=/Users/ryotaro.onoue/dev/github.com/YumNumm/flutter_scene
fork_worktree=/Users/ryotaro.onoue/dev/github.com/YumNumm/.worktrees/flutter-scene-persistent-gpu-lifecycle
top_ref=refs/heads/feat/persistent-packed-instance-geometry
cd "$fork_worktree"
test "$(git rev-parse --abbrev-ref HEAD)" = feat/persistent-gpu-lifecycle
test -z "$(git status --porcelain=v1)"
bottom_head=$(git rev-parse HEAD)
top_remote_exists=0
if top_line=$(git ls-remote --exit-code origin "$top_ref"); then
  top_remote_exists=1
  test "${reviewed_top_resume_sha:?supervisor reviewed top SHA required}" != ""
  printf '%s\n' "$reviewed_top_resume_sha" | rg -q '^[0-9a-f]{40}$'
  test "$(wc -l <<<"$top_line" | tr -d ' ')" -eq 1
  remote_top_head=${top_line%%[[:space:]]*}
  test "$remote_top_head" = "$reviewed_top_resume_sha"
  git fetch origin \
    "$top_ref:refs/remotes/origin/feat/persistent-packed-instance-geometry"
  git cat-file -e "$remote_top_head^{commit}"
else
  top_remote_rc=$?
  test "$top_remote_rc" -eq 2
fi
if git -C "$fork_clone" show-ref --verify --quiet "$top_ref"; then
  if test "$top_remote_exists" -eq 1; then
    test "$(git -C "$fork_clone" rev-parse feat/persistent-packed-instance-geometry)" = \
      "$remote_top_head"
  else
    test "${reviewed_top_resume_sha:?supervisor reviewed local top SHA required}" != ""
    printf '%s\n' "$reviewed_top_resume_sha" | rg -q '^[0-9a-f]{40}$'
    git -C "$fork_clone" cat-file -e "$reviewed_top_resume_sha^{commit}"
    test "$(git -C "$fork_clone" rev-parse feat/persistent-packed-instance-geometry)" = \
      "$reviewed_top_resume_sha"
  fi
  gh stack checkout feat/persistent-packed-instance-geometry
else
  local_top_rc=$?
  test "$local_top_rc" -eq 1
  if test "$top_remote_exists" -eq 1; then
    git -C "$fork_clone" branch feat/persistent-packed-instance-geometry \
      "$remote_top_head"
    gh stack checkout feat/persistent-packed-instance-geometry
  else
    gh stack add feat/persistent-packed-instance-geometry
  fi
fi
test "$(git rev-parse --abbrev-ref HEAD)" = feat/persistent-packed-instance-geometry
git merge-base --is-ancestor "$bottom_head" HEAD
test -z "$(git status --porcelain=v1)"
if test "$top_remote_exists" -eq 1; then
  test "$(git rev-parse HEAD)" = "$remote_top_head"
fi
```

## Top PR: persistent packed Geometry

### Task 20: checked allocation arithmetic (depends bottom approval; 45–80 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_plan.dart`; Create
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces `const int kMaxPersistentPackedAllocationBytes = 0x7fffffff` and static named-argument
`PersistentPackedCheckedMath.multiply/add/align16/endOffset` returning `int`。

**Implementation shape:** each method validates nonnegative operands and checks using division/difference before
performing its single multiply/add; align16 calls checked add with 15 before masking。

**RED test snippet:**

```dart
test("checked arithmetic rejects before overflow", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedCheckedMath",
    diagnostic: "RED:T20:checked arithmetic missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedCheckedMath {
  static int multiply({required int left, required int right}) {
    if (left < 0 || right < 0 ||
        (right != 0 && left > kMaxPersistentPackedAllocationBytes ~/ right)) {
      throw ArgumentError('multiply($left,$right)');
    }
    return left * right;
  }

  static int add({required int left, required int right}) {
    if (left < 0 || right < 0 ||
        left > kMaxPersistentPackedAllocationBytes - right) {
      throw ArgumentError('add($left,$right)');
    }
    return left + right;
  }
}
```

**Handwritten budget:** 45–80 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** exact happy `0*max=0`, `max+0=max`, `align16(1)=16`; negative, `max*2`, `max+1`,
  `align16(max)`, `endOffset(max,1)` errors include operation/operands. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'checked arithmetic rejects before overflow' 'RED:T20:checked arithmetic missing'`。
- [ ] **GREEN:** multiply uses zero case then `left > max ~/ right`; add/end use `left > max-right`; align uses
  checked add before mask. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed allocation計算を検証`。

### Task 21: deep layout snapshot (depends Task 20; 45–85 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces
`PersistentPackedLayoutSnapshot.create(VertexLayoutDescriptor source)` and final copied `layout`,
`vertexStrideInBytes`, `instanceStrideInBytes`。

**Implementation shape:** map every source buffer and attribute to a new const-compatible descriptor and wrap
both nested and outer lists with `List.unmodifiable` before storing/validating。

**RED test snippet:**

```dart
test("layout is deeply snapshotted before caller mutation", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedLayoutSnapshot",
    diagnostic: "RED:T21:deep layout snapshot missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedLayoutSnapshot {
  PersistentPackedLayoutSnapshot.create(VertexLayoutDescriptor source)
      : layout = VertexLayoutDescriptor(
          buffers: List.unmodifiable(
            source.buffers.map(
              (buffer) => VertexBufferDescriptor(
                strideInBytes: buffer.strideInBytes,
                stepMode: buffer.stepMode,
                attributes: List.unmodifiable(
                  buffer.attributes.map(
                    (attribute) => VertexAttributeDescriptor(
                      name: attribute.name,
                      format: attribute.format,
                      offsetInBytes: attribute.offsetInBytes,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  final VertexLayoutDescriptor layout;
  int get vertexStrideInBytes => layout.buffers[0].strideInBytes;
  int get instanceStrideInBytes => layout.buffers[1].strideInBytes;
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** mutate/clear caller buffer and attribute lists after create; returned nested lists reject mutation
  and remain value equal. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'layout is deeply snapshotted before caller mutation' 'RED:T21:deep layout snapshot missing'`。
- [ ] **GREEN:** reconstruct every descriptor/attribute with `List.unmodifiable` before validation. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/vertex_layout_test.dart test/interleaved_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed layoutを複製`。

### Task 22: exact slot/name/stride policy (depends Task 21; 45–85 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Extends `PersistentPackedLayoutSnapshot.create` with exactly two slots: slot0
`gpu.VertexStepMode.vertex`, slot1 `.instance`。

**Implementation shape:** validate outer slot count/modes/strides, then each attribute name/list using one
cross-slot name set; call existing `toGpuLayout()` only after these policies pass。

**RED test snippet:**

```dart
test("layout rejects slots names and strides", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "gpu.VertexStepMode.instance",
    diagnostic: "RED:T22:slot name stride validation missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void validatePersistentPackedSlots(VertexLayoutDescriptor layout) {
  if (layout.buffers.length != 2 ||
      layout.buffers[0].stepMode != gpu.VertexStepMode.vertex ||
      layout.buffers[1].stepMode != gpu.VertexStepMode.instance) {
    throw ArgumentError('packed layout requires vertex slot0 and instance slot1');
  }
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** reject slot count0/1/3, wrong step modes, empty attributes, empty/whitespace/surrounding-whitespace
  name, duplicate names across slots, stride<=0. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'layout rejects slots names and strides' 'RED:T22:slot name stride validation missing'`。
- [ ] **GREEN:** require `name.isNotEmpty && name.trim() == name` without rename; one name set across slots;
  then invoke existing `toGpuLayout()`. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/vertex_layout_test.dart test/shader_material_vertex_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed layout構造を検証`。

### Task 23: aligned non-overlapping attribute ranges (depends Task 22; 55–95 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Uses Task20 `endOffset`; adds no public type。

**Implementation shape:** build local `(start, end, name)` records using checked end, validate alignment/stride,
sort by start and reject only `next.start < current.end`。

**RED test snippet:**

```dart
test("layout rejects misaligned overlapping checked ranges", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "next.start < current.end",
    diagnostic: "RED:T23:aligned range validation missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
bool persistentPackedRangesOverlap({
  required ({int start, int end}) current,
  required ({int start, int end}) next,
}) => next.start < current.end;
```

**Handwritten budget:** 55–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** reject negative offset, checked end overflow/max breach, end>stride, offset misaligned to
  `gcd(bytesPerElement,4)`, stride misaligned to slot maximum, overlap `[0,12)`/`[8,12)`; accept adjacent
  `[0,8)`/`[8,12)`; overlap is accepted before GREEN. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'layout rejects misaligned overlapping checked ranges' 'RED:T23:aligned range validation missing'`。
- [ ] **GREEN:** checked ends only; sort local `(start,end,name)` and compare adjacent ranges. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/vertex_layout_test.dart test/geometry_builder_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed attribute範囲を検証`。

### Task 24: defensive finite bounds snapshot (depends Task 23; 45–85 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces `PersistentPackedBoundsSnapshot.create(vm.Aabb3 source)`; getters
`vm.Aabb3 get localBounds` and `vm.Sphere get localBoundingSphere` return fresh copies。

**Implementation shape:** copy six doubles, validate them and derived center/radius are finite, retain only those
scalars, and construct new Aabb3/Sphere on every getter call。

**RED test snippet:**

```dart
test("bounds validate derived values and return defensive copies", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedBoundsSnapshot",
    diagnostic: "RED:T24:defensive bounds missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedBoundsSnapshot {
  PersistentPackedBoundsSnapshot.create(vm.Aabb3 source)
      : _min = vm.Vector3.copy(source.min),
        _max = vm.Vector3.copy(source.max);
  final vm.Vector3 _min;
  final vm.Vector3 _max;
  vm.Aabb3 get localBounds =>
      vm.Aabb3.minMax(vm.Vector3.copy(_min), vm.Vector3.copy(_max));
  vm.Sphere get localBoundingSphere {
    final center = (_min + _max)..scale(0.5);
    return vm.Sphere.centerRadius(center, (_max - _min).length * 0.5);
  }
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** reject NaN/infinity/min>max and finite endpoints yielding non-finite center/radius; mutate source,
  returned Aabb3 and returned Sphere then observe canonical later copies. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'bounds validate derived values and return defensive copies' 'RED:T24:defensive bounds missing'`。
- [ ] **GREEN:** retain six finite scalars and finite derived center/radius only; construct fresh objects per getter.
  Run: `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/bounds_test.dart test/cull_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed boundsを防御的に固定`。

### Task 25: optional index byte shape (depends Task 24; 35–75 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces
`PersistentPackedIndexPlan.create({required ByteData? data, required gpu.IndexType type, required int vertexCount})`
with final `hasIndices/indexType/indexCount/indexBytes`; retains no data. The exact requested `gpu.IndexType` is
stored even for the null/no-index case so every downstream draw getter is total and typed。

**Implementation shape:** null returns no-index scalars; nonnull chooses width via exhaustive enum switch,
requires positive divisible length and positive vertex count, and stores count/byte scalars only。

**RED test snippet:**

```dart
test("index byte shape matches exact enum width", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedIndexPlan",
    diagnostic: "RED:T25:index byte shape missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedIndexPlan {
  const PersistentPackedIndexPlan({
    required this.hasIndices,
    required this.indexType,
    required this.indexCount,
    required this.indexBytes,
  });
  final bool hasIndices;
  final gpu.IndexType indexType;
  final int indexCount;
  final int indexBytes;

  factory PersistentPackedIndexPlan.create({required ByteData? data,
      required gpu.IndexType type, required int vertexCount}) {
    if (data == null) return PersistentPackedIndexPlan(hasIndices: false,
        indexType: type, indexCount: 0, indexBytes: 0);
    final width = switch (type) {
      gpu.IndexType.int16 => 2,
      gpu.IndexType.int32 => 4,
    };
    if (vertexCount <= 0 || data.lengthInBytes == 0 ||
        data.lengthInBytes % width != 0) {
      throw ArgumentError('invalid $type index byte shape');
    }
    return PersistentPackedIndexPlan(hasIndices: true, indexType: type,
        indexCount: data.lengthInBytes ~/ width,
        indexBytes: data.lengthInBytes);
  }
}
```

**Handwritten budget:** 35–75 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** null accepted; non-null empty, int16 odd, int32 non-multiple4, vertexCount<=0 rejected; supported
  widths produce exact counts and preserve exact `IndexType` for indexed and null cases. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'index byte shape matches exact enum width' 'RED:T25:index byte shape missing'`。
- [ ] **GREEN:** exhaustive index-type switch and exact divisibility; no fallback enum. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/geometry_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed index形状を検証`。

### Task 26: index value scan before upload (depends Task 25; 40–80 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Extends Task25; every little-endian index satisfies `value < vertexCount`。

**Implementation shape:** loop from element0 to indexCount-1, derive byte offset from width, read the matching
little-endian unsigned value, and throw with element/value/count on first invalid value。

**RED test snippet:**

```dart
test("every index is smaller than vertexCount", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "getUint32(byteOffset, Endian.little)",
    diagnostic: "RED:T26:index value scan missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
int readPersistentPackedIndex({
  required ByteData data,
  required gpu.IndexType type,
  required int byteOffset,
}) => switch (type) {
  gpu.IndexType.int16 => data.getUint16(byteOffset, Endian.little),
  gpu.IndexType.int32 => data.getUint32(byteOffset, Endian.little),
};
```

**Handwritten budget:** 40–80 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** before adding the scan, int16/int32 accept `[0,vertexCount-1]` and erroneously accept equal/larger;
  test expects `ArgumentError` including element/value/count. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'every index is smaller than vertexCount' 'RED:T26:index value scan missing'`。
- [ ] **GREEN:** use `getUint16/getUint32(byteOffset, Endian.little)` and retain no input. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/geometry_test.dart test/mesh_data_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed index値を検証`。

### Task 27: checked allocation sizes (depends Task 26; 45–85 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces internal final sizing value with `vertexBytes`, `instanceBytes`, `instanceOffset`,
`nonIndexBytes`, `indexBytes`, `totalBytes`。

**Implementation shape:** call Task20 multiply for vertex/instance, align16 for instance offset, add for
non-index/total; compare source lengths only after all checked scalar sizes exist。

**RED test snippet:**

```dart
test("allocation sizes use checked multiply align and add", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedAllocationSizes",
    diagnostic: "RED:T27:checked allocation size missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedAllocationSizes {
  const PersistentPackedAllocationSizes({
    required this.vertexBytes,
    required this.instanceBytes,
    required this.instanceOffset,
    required this.nonIndexBytes,
    required this.indexBytes,
    required this.totalBytes,
  });
  final int vertexBytes;
  final int instanceBytes;
  final int instanceOffset;
  final int nonIndexBytes;
  final int indexBytes;
  final int totalBytes;
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** assert vertex multiply, align16, padding, instance multiply, non-index/index adds; reject nonpositive
  counts and per-buffer/total max before source-length compare. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'allocation sizes use checked multiply align and add' 'RED:T27:checked allocation size missing'`。
- [ ] **GREEN:** every compound operation calls Task20 methods; no raw multiply/add. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/geometry_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed byte長を計算`。

### Task 28: immutable composite upload plan (depends Task 27; 50–95 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces exact
`PersistentPackedInstancePlan.create({required ByteData vertexData, required int vertexCount, required ByteData? indexData, required gpu.IndexType indexType, required ByteData instanceData, required int instanceCount, required VertexLayoutDescriptor vertexLayout, required vm.Aabb3 localBounds})`;
exposes immutable subplans/scalars, retains no ByteData。

**Implementation shape:** create layout/bounds snapshots, index and sizing in that order; validate exact lengths;
return a final object containing only those immutable values and scalars. It exposes every field consumed by
Tasks29–44 through the exact typed getters below; no consumer reaches through a nullable or undocumented subplan。

**RED test snippet:**

```dart
test("composite plan retains no caller-owned source", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "final class PersistentPackedInstancePlan",
    diagnostic: "RED:T28:immutable plan missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class PersistentPackedInstancePlan {
  const PersistentPackedInstancePlan.internal({
    required this.layout,
    required this.bounds,
    required this.index,
    required this.sizes,
    required this.vertexCount,
    required this.instanceCount,
  });
  final PersistentPackedLayoutSnapshot layout;
  final PersistentPackedBoundsSnapshot bounds;
  final PersistentPackedIndexPlan index;
  final PersistentPackedAllocationSizes sizes;
  final int vertexCount;
  final int instanceCount;
  int get vertexBytes => sizes.vertexBytes;
  int get instanceBytes => sizes.instanceBytes;
  int get instanceOffset => sizes.instanceOffset;
  int get nonIndexBytes => sizes.nonIndexBytes;
  int get indexBytes => sizes.indexBytes;
  int get totalBytes => sizes.totalBytes;
  gpu.IndexType get indexType => index.indexType;
  int get indexCount => index.indexCount;
  VertexLayoutDescriptor get vertexLayout => layout.layout;
  int get vertexStrideInBytes => layout.vertexStrideInBytes;
  int get instanceStrideInBytes => layout.instanceStrideInBytes;
  vm.Aabb3 get localBounds => bounds.localBounds;
  vm.Sphere get localBoundingSphere => bounds.localBoundingSphere;
}
```

**Handwritten budget:** 50–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** valid indexed/non-indexed plans, exact length mismatches, post-create mutation of all source objects,
  and a consumer-closure test that type-checks every getter used in Tasks29–44. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'composite plan retains no caller-owned source' 'RED:T28:immutable plan missing'`。
- [ ] **GREEN:** snapshot layout/bounds first; validate index/sizing; compare exact lengths; retain scalars/subplans.
  Run: `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/bounds_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed upload planを合成`。

### Task 29: pure write sequence (depends Task 28; 45–85 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces
`void executePersistentPackedWrites({required PersistentPackedInstancePlan plan, required ByteData vertexData, required ByteData instanceData, required ByteData? indexData, required bool Function({required ByteData source, required int destinationOffsetInBytes}) overwriteNonIndex, required bool Function({required ByteData source, required int destinationOffsetInBytes}) overwriteIndex})`。

**Implementation shape:** three ordered callback-result checks that throw `StateError` on false using exact destination
offsets; omit the third entirely when plan has no index; never catch callbacks。

**RED test snippet:**

```dart
test("upload executor writes each source exactly once", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_plan.dart",
    marker: "void executePersistentPackedWrites({",
    diagnostic: "RED:T29:exact write sequence missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void executePersistentPackedWrites({
  required PersistentPackedInstancePlan plan,
  required ByteData vertexData,
  required ByteData instanceData,
  required ByteData? indexData,
  required bool Function({
    required ByteData source,
    required int destinationOffsetInBytes,
  }) overwriteNonIndex,
  required bool Function({
    required ByteData source,
    required int destinationOffsetInBytes,
  }) overwriteIndex,
}) {
  if (!overwriteNonIndex(source: vertexData, destinationOffsetInBytes: 0)) {
    throw StateError('vertex overwrite failed at 0');
  }
  if (!overwriteNonIndex(source: instanceData,
      destinationOffsetInBytes: plan.instanceOffset)) {
    throw StateError('instance overwrite failed at ${plan.instanceOffset}');
  }
  if (indexData case final data) {
    if (!overwriteIndex(source: data, destinationOffsetInBytes: 0)) {
      throw StateError('index overwrite failed at 0');
    }
  }
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** events vertex `(0,len)` once, instance `(instanceOffset,len)` once, optional index `(0,len)` once;
  false at each write stops later events and error includes operation/offset/length. Run:
  `run_fork_red test/persistent_packed_instance_plan_test.dart 'upload executor writes each source exactly once' 'RED:T29:exact write sequence missing'`。
- [ ] **GREEN:** synchronous three-condition sequence; no allocation/flush/catch/source retention. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/geometry_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed write順序を固定`。

### Task 30: GPU-independent interfaces and recording fakes (depends Task 29; 45–85 lines)

**Files:** Create `lib/src/geometry/persistent_packed_gpu_backend.dart`; Create
`test/support/persistent_packed_gpu_fakes.dart`; Create `test/persistent_packed_gpu_backend_test.dart`。

**Interfaces:** Produces the exact `PersistentPackedGpuSlice/Buffer/Backend` interfaces in this plan. Test-only
`RecordingPersistentPackedGpuBackend` implements them and records typed allocate/overwrite/flush/slice/release。

**Implementation shape:** the fake owns `List<String> events`, configurable `bool overwriteResult` and
`Exception? flushError`; each interface call appends one fully formatted event before returning/throwing。

**RED test snippet:**

```dart
test("recording backend implements typed calls without GPU subclassing", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_gpu_backend.dart",
    marker: "abstract interface class PersistentPackedGpuBackend",
    diagnostic: "RED:T30:typed backend fake missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
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
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** compile fake and assert a scripted buffer's typed event list; source assertion forbids
  `extends gpu.DeviceBuffer` / `extends gpu.BufferView`. Run:
  `run_fork_red test/persistent_packed_gpu_backend_test.dart 'recording backend implements typed calls without GPU subclassing' 'RED:T30:typed backend fake missing'`。
- [ ] **GREEN:** interfaces contain no GPU concrete type; one minimal configurable fake in test/support. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_plan_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Test: packed GPU境界とfakeを追加`。

### Task 31: final DeviceBuffer backend wrappers (depends Task 30; 55–100 lines)

**Files:** Create `lib/src/geometry/persistent_packed_gpu_device.dart`; Modify
`test/persistent_packed_gpu_backend_test.dart`。

**Interfaces:** Produces final internal `DevicePersistentPackedGpuBackend`,
`DevicePersistentPackedGpuBuffer`, `DevicePersistentPackedGpuSlice`; slice wraps exact `gpu.BufferView` and
exposes internal `gpu.BufferView get view` for Task36 only。

**Implementation shape:** `allocate` calls exactly
`gpu.gpuContext.createDeviceBuffer(gpu.StorageMode.hostVisible, lengthInBytes)` once; buffer methods read
`final device = _device ?? (throw StateError('released'))`; `slice` returns
`DevicePersistentPackedGpuSlice(gpu.BufferView(device, offsetInBytes: offsetInBytes, lengthInBytes: lengthInBytes))`; `release`
sets `_device = null` only。

**RED test snippet:**

```dart
test("device backend wraps one nullable buffer without subclassing", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_gpu_device.dart",
    marker: "final class DevicePersistentPackedGpuBackend",
    diagnostic: "RED:T31:device buffer wrapper missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
final class DevicePersistentPackedGpuBackend
    implements PersistentPackedGpuBackend {
  @override
  PersistentPackedGpuBuffer allocate({required int lengthInBytes}) =>
      DevicePersistentPackedGpuBuffer(
        gpu.gpuContext.createDeviceBuffer(
          gpu.StorageMode.hostVisible,
          lengthInBytes,
        ),
      );
}
```

**Handwritten budget:** 55–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** source contract requires that exact one host-visible `gpuContext.createDeviceBuffer` call,
  exact overwrite/flush/slice delegation,
  null-on-release, post-release StateError, and no public export. Run:
  `run_fork_red test/persistent_packed_gpu_backend_test.dart 'device backend wraps one nullable buffer without subclassing' 'RED:T31:device buffer wrapper missing'`。
- [ ] **GREEN:** wrappers implement Task30 interfaces by composition only. `release()` clears the sole device
  reference idempotently; no nonexistent `DeviceBuffer.dispose`. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_plan_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed DeviceBuffer境界を追加`。

### Task 32: non-index write/flush transaction (depends Task 31; 55–95 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_storage.dart`; Create
`test/persistent_packed_instance_storage_test.dart`。

**Interfaces:** Produces internal
`PersistentPackedGpuBuffer uploadPersistentPackedNonIndex({required PersistentPackedGpuBackend backend, required PersistentPackedInstancePlan plan, required ByteData vertexData, required ByteData instanceData})`。

**Implementation shape:** allocate one non-index wrapper, call Task29 with its overwrite closure, flush exact full
range, return it; catch any failure, release once, rethrow original。

**RED test snippet:**

```dart
test("non-index upload flushes once before returning buffer", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_storage.dart",
    marker: "PersistentPackedGpuBuffer uploadPersistentPackedNonIndex({",
    diagnostic: "RED:T32:non-index upload transaction missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
PersistentPackedGpuBuffer uploadPersistentPackedNonIndex({
  required PersistentPackedGpuBackend backend,
  required PersistentPackedInstancePlan plan,
  required ByteData vertexData,
  required ByteData instanceData,
}) {
  final buffer = backend.allocate(lengthInBytes: plan.nonIndexBytes);
  try {
    executePersistentPackedWrites(
      plan: plan,
      vertexData: vertexData,
      instanceData: instanceData,
      indexData: null,
      overwriteNonIndex: buffer.overwrite,
      overwriteIndex: ({required source, required destinationOffsetInBytes}) =>
          throw StateError('non-index plan invoked index overwrite'),
    );
    buffer.flush(offsetInBytes: 0, lengthInBytes: plan.nonIndexBytes);
    return buffer;
  } catch (_) {
    buffer.release();
    rethrow;
  }
}
```

**Handwritten budget:** 55–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** exact events allocate, vertex overwrite, instance overwrite, flush `(0,nonIndexBytes)`; each
  overwrite false and flush throw releases once, stops later event, returns nothing. Run:
  `run_fork_red test/persistent_packed_instance_storage_test.dart 'non-index upload flushes once before returning buffer' 'RED:T32:non-index upload transaction missing'`。
- [ ] **GREEN:** call Task29 executor; index callback is unreachable; catch releases and rethrows original; return
  buffer only after flush. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_plan_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed non-index bufferをupload`。

### Task 33: indexed all-or-nothing storage upload (depends Task 32; 60–100 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_storage.dart`; Modify
`test/persistent_packed_instance_storage_test.dart`。

**Interfaces:** Produces static
`PersistentPackedInstanceStorage.uploadWithBackend({required PersistentPackedGpuBackend backend, required PersistentPackedInstancePlan plan, required ByteData vertexData, required ByteData instanceData, required ByteData? indexData})`。

**Implementation shape:** keep nullable local wrappers; finish non-index then optional index write/flush; create
all slices only afterward; catch releases index then non-index and rethrows。

**RED test snippet:**

```dart
test("indexed upload publishes slices only after both flushes", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_storage.dart",
    marker: "static PersistentPackedInstanceStorage uploadWithBackend({",
    diagnostic: "RED:T33:indexed upload transaction missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
static PersistentPackedInstanceStorage uploadWithBackend({
  required PersistentPackedGpuBackend backend,
  required PersistentPackedInstancePlan plan,
  required ByteData vertexData,
  required ByteData instanceData,
  required ByteData? indexData,
}) {
  final nonIndex = uploadPersistentPackedNonIndex(backend: backend,
      plan: plan, vertexData: vertexData, instanceData: instanceData);
  PersistentPackedGpuBuffer? index;
  try {
    if (indexData case final data) {
      index = backend.allocate(lengthInBytes: plan.indexBytes);
      if (!index.overwrite(data, destinationOffsetInBytes: 0)) {
        throw StateError('index overwrite failed at 0');
      }
      index.flush(offsetInBytes: 0, lengthInBytes: plan.indexBytes);
    }
    return PersistentPackedInstanceStorage.internal(
      nonIndexBuffer: nonIndex,
      indexBuffer: index,
      vertexSlice: nonIndex.slice(offsetInBytes: 0,
          lengthInBytes: plan.vertexBytes),
      instanceSlice: nonIndex.slice(offsetInBytes: plan.instanceOffset,
          lengthInBytes: plan.instanceBytes),
      indexSlice: index?.slice(offsetInBytes: 0,
          lengthInBytes: plan.indexBytes),
    );
  } catch (_) {
    index?.release();
    nonIndex.release();
    rethrow;
  }
}
```

**Handwritten budget:** 60–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** indexed exact events are allocate non-index, two non-index writes, non-index flush, allocate index,
  index write, index flush, then exactly 3 slices. Allocation/write/each flush failures release every created buffer in
  reverse order, make no slice, run no later event. Run:
  `run_fork_red test/persistent_packed_instance_storage_test.dart 'indexed upload publishes slices only after both flushes' 'RED:T33:indexed upload transaction missing'`。
- [ ] **GREEN:** hold wrappers in locals through both flushes; slice only afterward; catch index then non-index
  release and rethrow original. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_plan_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed index bufferをtransaction化`。

### Task 34: storage views, source independence and release (depends Task 33; 45–90 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_storage.dart`; Modify
`test/persistent_packed_instance_storage_test.dart`。

**Interfaces:** Produces nullable getters `vertexSlice/instanceSlice/indexSlice`, logical-byte getters, and
synchronous idempotent `void release()`。

**Implementation shape:** fields contain only slices/wrappers/scalars; release stores wrapper locals, nulls all
slice/wrapper fields, then calls index and non-index release once when nonnull。

**RED test snippet:**

```dart
test("storage releases views and retains no source bytes", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_storage.dart",
    marker: "void release()",
    diagnostic: "RED:T34:storage release contract missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void release() {
  final indexBuffer = _indexBuffer;
  final nonIndexBuffer = _nonIndexBuffer;
  _vertexSlice = null;
  _instanceSlice = null;
  _indexSlice = null;
  _indexBuffer = null;
  _nonIndexBuffer = null;
  indexBuffer?.release();
  nonIndexBuffer?.release();
}
```

**Handwritten budget:** 45–90 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** exact slice offsets/lengths; mutate source after upload while fake's copied upload remains fixed;
  release clears slices then index/non-index wrappers once; repeat no-op. Run:
  `run_fork_red test/persistent_packed_instance_storage_test.dart 'storage releases views and retains no source bytes' 'RED:T34:storage release contract missing'`。
- [ ] **GREEN:** store only plan scalars/slices/wrappers; release nulls views before wrappers. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_plan_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed GPU storageを解放可能化`。

### Task 35: render-pass interface and recording fake (depends Task 34; 40–80 lines)

**Files:** Create `lib/src/geometry/persistent_packed_render_pass.dart`; Modify
`test/support/persistent_packed_gpu_fakes.dart`; Create
`test/persistent_packed_render_pass_test.dart`。

**Interfaces:** Produces exact `PersistentPackedRenderPassAdapter` interface from this plan and test-only
`RecordingPersistentPackedRenderPassAdapter`; neither references/subclasses concrete `gpu.RenderPass` in fake。

**Implementation shape:** fake methods append records containing only interface arguments; `bindFrameInfo`
records the default resolver identity, whether an override was supplied, and copied matrices/vector without
invoking the resolver or creating a GPU pass/buffer/view。

**RED test snippet:**

```dart
test("recording render pass implements typed events without GPU subclassing", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_render_pass.dart",
    marker: "abstract interface class PersistentPackedRenderPassAdapter",
    diagnostic: "RED:T35:typed render-pass fake missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
abstract interface class PersistentPackedRenderPassAdapter {
  void bindVertex({required PersistentPackedGpuSlice slice,
      required int slot, required int vertexCount});
  void bindIndex({required PersistentPackedGpuSlice slice,
      required gpu.IndexType indexType, required int indexCount});
  void bindFrameInfo({required gpu.Shader Function() defaultShader,
      required gpu.Shader? shaderOverride,
      required TransientWriter transients,
      required vm.Matrix4 modelTransform,
      required vm.Matrix4 cameraTransform,
      required vm.Vector3 cameraPosition});
  void draw({required int vertexCount, required int indexCount,
      required int instanceCount});
}
```

**Handwritten budget:** 40–80 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** fake records typed vertex/index/frame/draw arguments; source rejects `extends gpu.RenderPass`.
  `run_fork_red test/persistent_packed_render_pass_test.dart 'recording render pass implements typed events without GPU subclassing' 'RED:T35:typed render-pass fake missing'`。
- [ ] **GREEN:** interface only in production file; extend the single existing test-support fake file. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_storage_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Test: packed RenderPass境界とfakeを追加`。

### Task 36: production GPU bind/draw functions (depends Task 35; 50–95 lines)

**Files:** Create `lib/src/geometry/persistent_packed_render_pass_gpu.dart`; Modify
`test/persistent_packed_render_pass_test.dart`。

**Interfaces:** Produces internal top-level
`gpu.BufferView requireDevicePersistentPackedGpuView(PersistentPackedGpuSlice slice)`、
`void bindPersistentPackedGpuVertex({required gpu.RenderPass pass, required PersistentPackedGpuSlice slice, required int slot, required int vertexCount})`、
`void bindPersistentPackedGpuIndex({required gpu.RenderPass pass, required PersistentPackedGpuSlice slice, required gpu.IndexType indexType, required int indexCount})`、
`void drawPersistentPackedGpu({required gpu.RenderPass pass, required int vertexCount, required int indexCount, required int instanceCount})`。

**Implementation shape:** the view function pattern-checks `DevicePersistentPackedGpuSlice` and throws
`StateError` otherwise; the three functions call existing compat helpers and are never exported。

**RED test snippet:**

```dart
test("GPU adapter unwraps only device slices for bind and draw", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_render_pass_gpu.dart",
    marker: "void drawPersistentPackedGpu({",
    diagnostic: "RED:T36:GPU bind draw adapter missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
void drawPersistentPackedGpu({
  required gpu.RenderPass pass,
  required int vertexCount,
  required int indexCount,
  required int instanceCount,
}) {
  if (indexCount > 0) {
    drawIndexedCompat(pass, indexCount, instanceCount: instanceCount);
  } else {
    drawCompat(pass, vertexCount, instanceCount: instanceCount);
  }
}
```

**Handwritten budget:** 50–95 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** source contract requires `bindVertexBufferCompat`, `bindIndexBufferCompat`,
  `drawCompat/drawIndexedCompat`; a foreign slice fails before pass call; indexed/non-index draw arguments exact.
  `run_fork_red test/persistent_packed_render_pass_test.dart 'GPU adapter unwraps only device slices for bind and draw' 'RED:T36:GPU bind draw adapter missing'`。
- [ ] **GREEN:** implement only the four complete top-level functions. Task37 delegates its complete adapter to
  them; no incomplete interface implementation or temporary throw exists. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart test/persistent_packed_gpu_backend_test.dart test/persistent_packed_instance_storage_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed RenderPass bind境界を追加`。

### Task 37: exact 36-float production FrameInfo adapter (depends Task 36; 45–90 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_render_pass_gpu.dart`; Modify
`test/persistent_packed_render_pass_test.dart`。

**Interfaces:** Produces concrete final `GpuPersistentPackedRenderPassAdapter(gpu.RenderPass pass)` by delegating
to Task36 functions and implementing all Task35 methods; `bindFrameInfo` selects its shader lazily. Also produces
the exact generic `selectPersistentPackedShader<T>` in this plan and
`@visibleForTesting Float32List packPersistentPackedFrameInfo({required vm.Matrix4 cameraTransform, required vm.Matrix4 modelTransform, required vm.Vector3 cameraPosition})`, both used by production。

**Implementation shape:** select `shaderOverride ?? defaultShader()` through the generic helper. Then use
`final floats = Float32List(36)..setRange(0, 16, cameraTransform.storage)..setRange(16, 32, modelTransform.storage);`
assign indices32–35, emplace `floats.buffer.asByteData()`, and
`pass.bindUniform(shader.getUniformSlot('FrameInfo'), view)`。

**RED test snippet:**

```dart
test("GPU adapter packs exact 36-float FrameInfo", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_render_pass_gpu.dart",
    marker: "Float32List packPersistentPackedFrameInfo({",
    diagnostic: "RED:T37:FrameInfo pack missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
Float32List packPersistentPackedFrameInfo({
  required vm.Matrix4 cameraTransform,
  required vm.Matrix4 modelTransform,
  required vm.Vector3 cameraPosition,
}) => Float32List(36)
  ..setRange(0, 16, cameraTransform.storage)
  ..setRange(16, 32, modelTransform.storage)
  ..[32] = cameraPosition.x
  ..[33] = cameraPosition.y
  ..[34] = cameraPosition.z
  ..[35] = 0;
```

**Handwritten budget:** 45–90 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** generic selector returns override without invoking default and otherwise invokes default exactly
  once; pure packed output is exactly 36 float32: camera0..15, model16..31, camera position32..34, zero35; source
  contract requires production to emplace these 144 bytes and bind selected shader's `FrameInfo` slot. Run:
  `run_fork_red test/persistent_packed_render_pass_test.dart 'GPU adapter packs exact 36-float FrameInfo' 'RED:T37:FrameInfo pack missing'`。
- [ ] **GREEN:** allocate one `Float32List(36)`, `setRange` matrices, assign position/pad, emplace and bind exact
  slot. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart test/geometry_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed FrameInfoを36 floatでbind`。

### Task 38A: lifecycle-aware bind delegate (depends Task 37; 50–90 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_binding.dart`; Create
`test/persistent_packed_instance_binding_test.dart`。

**Interfaces:** Produces non-Geometry final
`PersistentPackedInstanceBinding({required plan, required storage, required lease, required gpu.Shader Function() defaultShader})` with
`void bind({required adapter, required transients, required modelTransform, required cameraTransform, required cameraPosition, gpu.Shader? shaderOverride})`。

**Implementation shape:** bind calls `lease.requireCurrentActive(); lease.markUsed();`, then adapter slot0/slot1,
optional index and FrameInfo in that order. It passes the default resolver and nullable override through without
resolving either; only Task37's production adapter resolves。

**RED test snippet:**

```dart
test('binding validates lifecycle before full persistent bind', () {
  expect(
    File('lib/src/geometry/persistent_packed_instance_binding.dart')
        .existsSync(),
    isTrue,
    reason: 'RED:T38A:lifecycle bind delegate missing',
  );
});
```

**GREEN implementation snippet:**

```dart
void bind({
  required PersistentPackedRenderPassAdapter adapter,
  required TransientWriter transients,
  required vm.Matrix4 modelTransform,
  required vm.Matrix4 cameraTransform,
  required vm.Vector3 cameraPosition,
  gpu.Shader? shaderOverride,
}) {
  lease.requireCurrentActive();
  lease.markUsed();
  final vertexSlice = storage.vertexSlice ?? (throw StateError('released'));
  final instanceSlice = storage.instanceSlice ?? (throw StateError('released'));
  adapter.bindVertex(slice: vertexSlice, slot: 0,
      vertexCount: plan.vertexCount);
  adapter.bindVertex(slice: instanceSlice, slot: 1,
      vertexCount: plan.instanceCount);
  if (storage.indexSlice case final indexSlice) {
    adapter.bindIndex(slice: indexSlice, indexType: plan.indexType,
        indexCount: plan.indexCount);
  }
  adapter.bindFrameInfo(defaultShader: defaultShader,
      shaderOverride: shaderOverride, transients: transients,
      modelTransform: modelTransform, cameraTransform: cameraTransform,
      cameraPosition: cameraPosition);
}
```

**Handwritten budget:** production 38–55 + test 25–35 = 63–90 lines。

- [ ] **RED:** bind exact events requireCurrentActive→markUsed→slot0→slot1→index?→frame; fake records exact
  default resolver identity/override-presence without invoking either;
  terminal/old-generation/disposed/non-active/closed-frame all have adapter events0. Run
  `run_fork_red test/persistent_packed_instance_binding_test.dart 'binding validates lifecycle before full persistent bind' 'RED:T38A:lifecycle bind delegate missing'`。
- [ ] **GREEN:** one final plain delegate with bind only; no superclass calls, source scan, overwrite or instance
  transients. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/persistent_packed_instance_storage_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed bind delegateを追加`。

### Task 38B: validated persistent draw delegate (depends Task 38A; 35–75 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_binding.dart`; Modify
`test/persistent_packed_instance_binding_test.dart`。

**Interfaces:** Adds
`void draw({required PersistentPackedRenderPassAdapter adapter, int externalInstanceCount = 1})`。

**Implementation shape:** draw calls `lease.requireCurrentActive()` before reading counts or touching adapter,
rejects every external count except one, then passes stored vertex/index/instance counts exactly once。

**RED test snippet:**

```dart
test('draw rejects external instancing before adapter events', () {
  final source = File(
    'lib/src/geometry/persistent_packed_instance_binding.dart',
  ).readAsStringSync();
  expect(source, contains('externalInstanceCount != 1'),
      reason: 'RED:T38B:external draw guard missing');
});
```

**GREEN implementation snippet:**

```dart
void draw({
  required PersistentPackedRenderPassAdapter adapter,
  int externalInstanceCount = 1,
}) {
  lease.requireCurrentActive();
  if (externalInstanceCount != 1) {
    throw ArgumentError.value(externalInstanceCount, 'externalInstanceCount');
  }
  adapter.draw(vertexCount: plan.vertexCount, indexCount: plan.indexCount,
      instanceCount: plan.instanceCount);
}
```

**Handwritten budget:** production 12–20 + test 24–38 = 36–58 lines。

- [ ] **RED:** draw exact counts; external count!=1 and retire between bind/draw fail before adapter event. Run
  `run_fork_red test/persistent_packed_instance_binding_test.dart 'draw rejects external instancing before adapter events' 'RED:T38B:external draw guard missing'`。
- [ ] **GREEN:** add only the guarded draw method and its matrix. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed draw delegateを追加`。

### Task 39: typed construction transaction happy path (depends Task 38B; 45–85 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_transaction.dart`; Create
`test/persistent_packed_instance_transaction_test.dart`。

**Interfaces:** Produces exact typed aliases and generic `executePersistentPackedInstanceTransaction<T>` shown
in Exact internal interfaces. No dynamic/object parameter, subclass, service locator, or optional callback。

**Implementation shape:** the function calls `checkCanCreate()` first, assigns `final plan = buildPlan()`, then
`final storage = upload(backend: backend, plan: plan)`, registers exact plan bytes with
`release: storage.release`, and invokes `construct(plan: plan, storage: storage, lease: lease)`。

**RED test snippet:**

```dart
test("typed transaction constructs only after check upload and register", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_transaction.dart",
    marker: "T executePersistentPackedInstanceTransaction<T>({",
    diagnostic: "RED:T39:transaction order missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
T executePersistentPackedInstanceTransaction<T>({
  required PersistentPackedCanCreate checkCanCreate,
  required PersistentPackedPlanBuild buildPlan,
  required PersistentPackedGpuBackend backend,
  required PersistentPackedStorageUpload upload,
  required PersistentPackedLeaseRegister register,
  required PersistentPackedConstruct<T> construct,
}) {
  checkCanCreate();
  final plan = buildPlan();
  final storage = upload(backend: backend, plan: plan);
  final lease = register(totalBytes: plan.totalBytes,
      instanceBytes: plan.instanceBytes, release: storage.release);
  return construct(plan: plan, storage: storage, lease: lease);
}
```

**Handwritten budget:** 45–85 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** typed recording closures observe exact order check→plan→upload(backend identity)→register exact
  bytes/release callback→construct exact parts and return sentinel. Run:
  `run_fork_red test/persistent_packed_instance_transaction_test.dart 'typed transaction constructs only after check upload and register' 'RED:T39:transaction order missing'`。
- [ ] **GREEN:** straight-line typed calls only; retain `storage` local for failure cleanup added Task40. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_transaction_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_instance_storage_test.dart test/persistent_packed_instance_plan_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed構築transactionを追加`。

### Task 40: typed construction failure matrix (depends Task 39; 60–100 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_transaction.dart`; Modify
`test/persistent_packed_instance_transaction_test.dart`。

**Interfaces:** Completes failure semantics: lifecycle rejection before plan/backend; upload owns its allocation
cleanup; register failure calls storage.release once; construct failure calls `lease.retire().ignore()` then
rethrows original synchronously。

**Implementation shape:** wrap only `register(totalBytes: plan.totalBytes, instanceBytes: plan.instanceBytes, release: storage.release)`
in `try/on` that calls `storage.release()` and rethrows; wrap only
`construct(plan: plan, storage: storage, lease: lease)` in a second `try/on` that calls
`lease.retire().ignore()` and rethrows. The initial
check/build/upload sequence remains outside both catch regions。

**RED test snippet:**

```dart
test("typed transaction failure matrix stops and cleans exact owner", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_transaction.dart",
    marker: "lease.retire().ignore()",
    diagnostic: "RED:T40:transaction cleanup missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
T executePersistentPackedInstanceTransaction<T>({
  required PersistentPackedCanCreate checkCanCreate,
  required PersistentPackedPlanBuild buildPlan,
  required PersistentPackedGpuBackend backend,
  required PersistentPackedStorageUpload upload,
  required PersistentPackedLeaseRegister register,
  required PersistentPackedConstruct<T> construct,
}) {
  checkCanCreate();
  final plan = buildPlan();
  final storage = upload(backend: backend, plan: plan);
  late final PersistentGpuResourceLease lease;
  try {
    lease = register(totalBytes: plan.totalBytes,
        instanceBytes: plan.instanceBytes, release: storage.release);
  } catch (_) {
    storage.release();
    rethrow;
  }
  try {
    return construct(plan: plan, storage: storage, lease: lease);
  } catch (_) {
    lease.retire().ignore();
    rethrow;
  }
}
```

**Handwritten budget:** 60–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** table check/build/upload/register/construct throws distinct sentinel; assert exact stopped event
  prefix, allocation0 on check reject, release0 for pre-storage, storage release1 on register, lease retirement1 on
  construct, returned object0 for every failure. Run:
  `run_fork_red test/persistent_packed_instance_transaction_test.dart 'typed transaction failure matrix stops and cleans exact owner' 'RED:T40:transaction cleanup missing'`。
- [ ] **GREEN:** two narrow try/catch regions: catch register releases storage/rethrows; catch construct starts lease
  retirement/rethrows. Never catch check/build/upload. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_transaction_test.dart test/persistent_packed_instance_storage_test.dart test/persistent_packed_instance_binding_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Fix: packed構築失敗cleanupを固定`。

### Task 41A: immutable validated Geometry parts (depends Task 40; 40–80 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_geometry.dart`; Create
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces internal immutable
`PersistentPackedInstanceGeometryParts({required plan, required storage, required lease, required defaultShader, required doubleSided})`
and getters for those exact typed values. This task does not instantiate or subclass `Geometry`。

**Implementation shape:** the constructor assigns final fields and creates exactly one Task38A/38B binding delegate;
it retains only copied plan metadata, GPU storage, lifecycle lease and the typed lazy shader resolver. No factory,
GPU call, shader resolution, or abstract `Geometry` member appears yet。

**RED test snippet:**

```dart
test('validated parts retain one typed binding without Geometry', () {
  expect(
    File('lib/src/geometry/persistent_packed_instance_geometry.dart')
        .existsSync(),
    isTrue,
    reason: 'RED:T41A:immutable Geometry parts missing',
  );
});
```

**GREEN implementation snippet:**

```dart
@immutable
final class PersistentPackedInstanceGeometryParts {
  PersistentPackedInstanceGeometryParts({
    required this.plan,
    required this.storage,
    required this.lease,
    required this.defaultShader,
    required this.doubleSided,
  }) : binding = PersistentPackedInstanceBinding(
         plan: plan, storage: storage, lease: lease,
         defaultShader: defaultShader,
       );
  final PersistentPackedInstancePlan plan;
  final PersistentPackedInstanceStorage storage;
  final PersistentGpuResourceLease lease;
  final gpu.Shader Function() defaultShader;
  final bool doubleSided;
  final PersistentPackedInstanceBinding binding;
}
```

**Handwritten budget:** production 24–38 + test 24–36 = 48–74 lines。

- [ ] **RED:** construct parts with recording storage/lease and a throwing shader resolver; assert exact typed
  identities, one binding identity and shader invocation count0. Source rejects `extends Geometry`. Run
  `run_fork_red test/persistent_packed_instance_geometry_test.dart 'validated parts retain one typed binding without Geometry' 'RED:T41A:immutable Geometry parts missing'`。
- [ ] **GREEN:** add the immutable parts holder only. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry partsを追加`。

### Task 41B: complete concrete immutable Geometry (depends Task 41A; 55–95 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces concrete class with `@internal` nonthrowing public named constructor
`fromValidatedParts`. The very first instantiable revision implements abstract `bind` plus `draw`, `vertexShader`,
bounds, `setLocalBounds`, and every layout/count/state/retire getter; no temporarily abstract or throwing
construction state or extra test factory is committed. Tests call the named constructor directly and inspect the
typed `parts.binding` field。

**Implementation shape:** `fromValidatedParts` consumes a Task41A parts holder. Public `vertexShader` resolves
its lazy
resolver; the internal accessor returns its same binding. `setLocalBounds(vm.Aabb3? aabb, vm.Sphere? sphere)`
always throws `UnsupportedError`; both bounds getters return Task24 fresh copies; bind/draw use the Task37
production adapter around the supplied pass。

**RED test snippet:**

```dart
test('concrete Geometry is complete at first instantiation', () {
  final source = File(
    'lib/src/geometry/persistent_packed_instance_geometry.dart',
  ).readAsStringSync();
  expect(source, contains('extends Geometry'),
      reason: 'RED:T41B:complete concrete Geometry missing');
});
```

**GREEN implementation snippet:**

```dart
final class PersistentPackedInstanceGeometry extends Geometry {
  @internal
  PersistentPackedInstanceGeometry.fromValidatedParts({
    required PersistentPackedInstancePlan plan,
    required PersistentPackedInstanceStorage storage,
    required PersistentGpuResourceLease lease,
    required gpu.Shader Function() defaultShader,
    required bool doubleSided,
  }) : parts = PersistentPackedInstanceGeometryParts(plan: plan,
         storage: storage, lease: lease, defaultShader: defaultShader,
         doubleSided: doubleSided);

  final PersistentPackedInstanceGeometryParts parts;
  @override gpu.Shader get vertexShader => parts.defaultShader();
  @override vm.Aabb3 get localBounds => parts.plan.localBounds;
  @override vm.Sphere get localBoundingSphere =>
      parts.plan.localBoundingSphere;
  @override VertexLayoutDescriptor get instancedVertexLayout =>
      parts.plan.vertexLayout;
  @override int get vertexStreamCount => 2;
  @override bool get bindsModelTransformInstance => false;
  @override bool get isDoubleSided => parts.doubleSided;
  @override
  ({gpu.Shader shader, VertexLayoutDescriptor layout})?
      get depthOnlyVertex => null;
  int get instanceCount => parts.plan.instanceCount;
  int get instanceStrideInBytes => parts.plan.instanceStrideInBytes;
  int get contextGeneration => parts.lease.generation;
  PersistentGpuResourceState get resourceState => parts.lease.state;
  Future<void> retire() => parts.lease.retire();

@override
void bind(gpu.RenderPass pass, TransientWriter transientsBuffer,
    vm.Matrix4 modelTransform, vm.Matrix4 cameraTransform,
    vm.Vector3 cameraPosition, {gpu.Shader? shaderOverride}) {
  parts.binding.bind(adapter: GpuPersistentPackedRenderPassAdapter(pass),
      transients: transientsBuffer, modelTransform: modelTransform,
      cameraTransform: cameraTransform, cameraPosition: cameraPosition,
      shaderOverride: shaderOverride);
}

@override
void draw(gpu.RenderPass pass, {int instanceCount = 1}) {
  parts.binding.draw(adapter: GpuPersistentPackedRenderPassAdapter(pass),
      externalInstanceCount: instanceCount);
}

@override
void setLocalBounds(vm.Aabb3? aabb, vm.Sphere? sphere) =>
    throw UnsupportedError('PersistentPackedInstanceGeometry is immutable');
}

```

**Handwritten budget:** production 48–65 + test 30–40 = 78–95 lines。

- [ ] **RED:** internal parts helper creates the concrete class without resolving its throwing test shader; its
  exact binding delegate bind/draws through a recording adapter; both `setLocalBounds` forms throw and mutated
  returned bounds never alter later copies. Run
  `run_fork_red test/persistent_packed_instance_geometry_test.dart 'concrete Geometry is complete at first instantiation' 'RED:T41B:complete concrete Geometry missing'`。
- [ ] **GREEN:** override every abstract/public contract at the first instantiation; the immutable bounds override
  is the only intentional throw. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry coreを追加`。

### Task 42: shared public factory transaction (depends Task 41B; 55–100 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces Final public API factory and internal exact
`createPersistentPackedInstanceGeometry({required PersistentGpuResourceLifecycle lifecycle, required PersistentPackedGpuBackend backend, required ByteData vertexData, required int vertexCount, required ByteData? indexData, required gpu.IndexType indexType, required ByteData instanceData, required int instanceCount, required VertexLayoutDescriptor vertexLayout, required gpu.Shader vertexShader, required vm.Aabb3 localBounds, required bool doubleSided})`。
Both call Task39 transaction and Task41B `fromValidatedParts`。

**Implementation shape:** public factory delegates with `DevicePersistentPackedGpuBackend()` and the supplied
shader unchanged. The internal helper is the only place that supplies lifecycle check/register, source-capturing
plan/upload, and `fromValidatedParts(defaultShader: () => vertexShader)` construct closures to Task39. There is no second
manual plan→upload→register path。

```dart
return executePersistentPackedInstanceTransaction(
  checkCanCreate: lifecycle.checkCanCreate,
  buildPlan: () => PersistentPackedInstancePlan.create(
    vertexData: vertexData,
    vertexCount: vertexCount,
    indexData: indexData,
    indexType: indexType,
    instanceData: instanceData,
    instanceCount: instanceCount,
    vertexLayout: vertexLayout,
    localBounds: localBounds,
  ),
  backend: backend,
  upload: ({required backend, required plan}) =>
      PersistentPackedInstanceStorage.uploadWithBackend(
        backend: backend,
        plan: plan,
        vertexData: vertexData,
        instanceData: instanceData,
        indexData: indexData,
      ),
  register: lifecycle.registerAllocation,
  construct: ({required plan, required storage, required lease}) =>
      PersistentPackedInstanceGeometry.fromValidatedParts(
        plan: plan,
        storage: storage,
        lease: lease,
        defaultShader: () => vertexShader,
        doubleSided: doubleSided,
      ),
);
```

**RED test snippet:**

```dart
test("public Geometry factory shares typed lifecycle transaction", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_geometry.dart",
    marker: "PersistentPackedInstanceGeometry createPersistentPackedInstanceGeometry({",
    diagnostic: "RED:T42:shared factory transaction missing",
  );
});
```

**GREEN implementation snippet:**

```dart
PersistentPackedInstanceGeometry createPersistentPackedInstanceGeometry({
  required PersistentGpuResourceLifecycle lifecycle,
  required PersistentPackedGpuBackend backend,
  required ByteData vertexData,
  required int vertexCount,
  required ByteData? indexData,
  required gpu.IndexType indexType,
  required ByteData instanceData,
  required int instanceCount,
  required VertexLayoutDescriptor vertexLayout,
  required gpu.Shader vertexShader,
  required vm.Aabb3 localBounds,
  required bool doubleSided,
}) => executePersistentPackedInstanceTransaction(
  checkCanCreate: lifecycle.checkCanCreate,
  buildPlan: () => PersistentPackedInstancePlan.create(
    vertexData: vertexData, vertexCount: vertexCount, indexData: indexData,
    indexType: indexType, instanceData: instanceData,
    instanceCount: instanceCount, vertexLayout: vertexLayout,
    localBounds: localBounds,
  ),
  backend: backend,
  upload: ({required backend, required plan}) =>
      PersistentPackedInstanceStorage.uploadWithBackend(
        backend: backend, plan: plan, vertexData: vertexData,
        instanceData: instanceData, indexData: indexData,
  ),
  register: lifecycle.registerAllocation,
  construct: ({required plan, required storage, required lease}) =>
      PersistentPackedInstanceGeometry.fromValidatedParts(
        plan: plan, storage: storage, lease: lease,
        defaultShader: () => vertexShader, doubleSided: doubleSided,
      ),
);
```

This is the sole transaction body; no second helper/body is permitted。

**Handwritten budget:** 55–100 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** source proves the public factory has exactly one call to the backend-injected helper and that helper
  has exactly one call to Task39's transaction; lifecycle rejection event precedes plan/allocation; valid fake
  backend order is check→plan→upload→register→construct; register failure cleanup comes from Task40.
  `run_fork_red test/persistent_packed_instance_geometry_test.dart 'public Geometry factory shares typed lifecycle transaction' 'RED:T42:shared factory transaction missing'`。
- [ ] **GREEN:** public and test paths differ only by backend argument. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/persistent_packed_instance_transaction_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_instance_storage_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometryをtransaction構築`。

### Task 43: full normal/depth/shadow/selection routes (depends Task 42; 45–90 lines)

**Files:** Modify `test/persistent_packed_instance_geometry_test.dart`; Modify
`test/render/persistent_gpu_scene_integration_test.dart`。

**Interfaces:** Audits Task41B's exact
`depthOnlyVertex == null`, `vertexStreamCount == 2`, `bindsModelTransformInstance == false`, copied layout and
double-sided values against every existing render route; adds no production API。

**Implementation shape:** recording-adapter tests drive the already-complete Task41B binding through normal,
depth, shadow and selection route predicates; source assertions pin each existing encoder's null branch。

**RED test snippet:**

```dart
test("depth shadow and selection use packed full bind", () {
  expectRedSourceContract(
    path: "lib/src/geometry/persistent_packed_instance_geometry.dart",
    marker: "VertexLayoutDescriptor layout})? get depthOnlyVertex => null;",
    diagnostic: "RED:T43:full route binding missing",
  );
});
```

**GREEN implementation snippet:** the route test uses the same typed expectation for each named route:

```dart
for (final path in [
  'lib/src/render/object_filter.dart',
  'lib/src/render/shadow_encoder.dart',
  'lib/src/render/depth_prepass.dart',
]) {
  test('$path uses bind for null depthOnlyVertex', () {
    final source = File(path).readAsStringSync();
    expect(source, contains('depthOnlyVertex'));
    expect(source, contains('.bind('));
    expect(source, isNot(contains('depthOnlyVertex == null) {\n'
        '      geometry.bindPositionStream')));
  });
}
```

**Handwritten budget:** 45–90 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** assert source contracts in `object_filter.dart`, `shadow_encoder.dart`, and `depth_prepass.dart`
  select `geometry.bind` when `depthOnlyVertex` is null and never select `bindPositionStream`; run the concrete
  Geometry's exact internal binding delegate through four named normal/depth/shadow/selection cases and require
  both slots plus FrameInfo each time. Run:
  `run_fork_red test/persistent_packed_instance_geometry_test.dart 'depth shadow and selection use packed full bind' 'RED:T43:full route binding missing'`。
- [ ] **GREEN:** add only route/source contract tests; never call position stream or superclass setters. Run
  geometry + scene integration + `shadow_cache_test.dart` + `spot_shadow_test.dart` +
  `scene_semantics_test.dart`. Run: `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/render/persistent_gpu_scene_integration_test.dart test/shadow_cache_test.dart test/spot_shadow_test.dart test/scene_semantics_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry全描画経路を固定`。

### Task 44: exact material vertex variant (depends Task 43; 40–80 lines)

**Files:** Modify `lib/src/material/shader_stage.dart`; Modify
`lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/shader_material_vertex_test.dart`。

**Interfaces:** Produces `MeshVariant.persistentPackedInstances('persistent_packed_instances')`, exact `fromName`
case, Geometry `materialVertexVariant` same wire name。

**Implementation shape:** append one enum case, add one exact string switch arm before default, and return the
same wire string from Geometry; change no generated fmat code。

**RED test snippet:**

```dart
test("ShaderMaterial keeps persistent packed instance variant exact", () {
  expectRedSourceContract(
    path: "lib/src/material/shader_stage.dart",
    marker: "persistentPackedInstances('persistent_packed_instances')",
    diagnostic: "RED:T44:material variant missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
persistentPackedInstances('persistent_packed_instances'),
```

```dart
@override
String get materialVertexVariant => 'persistent_packed_instances';
```

**Handwritten budget:** 40–80 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** exact enum name/fromName round-trip and Geometry wire name; `setVertexShader(null, variant: ...)`
  accepts the new typed enum without a GPU shader; existing unskinned/skinned/depth and unknown→unskinned remain
  unchanged. Source assertion requires `materialVertexShader` to index `_vertexShaders[kind]`. Run:
  `run_fork_red test/shader_material_vertex_test.dart 'ShaderMaterial keeps persistent packed instance variant exact' 'RED:T44:material variant missing'`。
- [ ] **GREEN:** one enum value and one switch case; no generator/default collapse. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/shader_material_vertex_test.dart test/shader_material_test.dart test/persistent_packed_instance_geometry_test.dart test/render/persistent_gpu_scene_integration_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry shader variantを追加`。

### Task 45: curated Geometry public export (depends Task 44; 35–75 lines)

**Files:** Modify `lib/scene.dart`; Create
`test/persistent_packed_instance_public_api_test.dart`。

**Interfaces:** Exports only `PersistentPackedInstanceGeometry`; plan/storage/backend/slices/adapters/binding/
lease/transaction/test helpers remain internal。

**Implementation shape:** add one `show PersistentPackedInstanceGeometry` export entry; public API test scans
the barrel to reject every internal name listed in Interfaces。

**RED test snippet:**

```dart
test("public Geometry barrel hides every transaction seam", () {
  expectRedSourceContract(
    path: "lib/scene.dart",
    marker: "show PersistentPackedInstanceGeometry",
    diagnostic: "RED:T45:curated Geometry export missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```dart
export 'src/geometry/persistent_packed_instance_geometry.dart'
    show PersistentPackedInstanceGeometry;
```

**Handwritten budget:** 35–75 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** public-only imports take factory tear-off and reference lifecycle/layout/state/retire; source rejects
  every internal symbol/export. Run:
  `run_fork_red test/persistent_packed_instance_public_api_test.dart 'public Geometry barrel hides every transaction seam' 'RED:T45:curated Geometry export missing'`。
- [ ] **GREEN:** one curated show entry. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_public_api_test.dart test/render/persistent_gpu_lifecycle_public_api_test.dart test/persistent_packed_instance_geometry_test.dart test/shader_material_vertex_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry APIを公開`。

### Task 46: packed Geometry README contract (depends Task 45; 30–75 lines)

**Files:** Modify `README.md`; Modify
`test/persistent_packed_instance_public_api_test.dart`。

**Interfaces:** Documents CPU pack→one construction→per-frame bind→revision new attach/old detach+retire→
stop/detach/invalidate/await/recreate; exact 36-float shader/layout contract, the one-render-item ownership rule,
and deferrals。

**Implementation shape:** one focused README section with the exact flow, FrameInfo offsets, two-slot contract,
logical-memory wording and explicit issue/device deferrals. State that the Geometry already owns its packed
`instanceCount`: do not wrap it in `InstancedMesh` or share the identical Geometry across engine-batched Nodes;
an external `draw(instanceCount != 1)` fails before pass mutation。

**RED test snippet:**

```dart
test("README states one upload and 36-float shader contract", () {
  expectRedSourceContract(
    path: "README.md",
    marker: "external instancing",
    diagnostic: "RED:T46:Geometry README contract missing",
  );
});
```

**GREEN implementation snippet:** the exact production signature/statement is:

```markdown
The Geometry owns its packed instance count. External instancing is rejected:
do not wrap it in `InstancedMesh` or share one Geometry across batched Nodes.
```

**Handwritten budget:** 30–75 total lines exactly as scoped in this task heading; test, production,
and documentation lines are counted, while generated files and formatter-only indentation are excluded。

- [ ] **RED:** source assertions require workflow, logical memory, no fallback/per-frame upload, the explicit
  external-instancing prohibition, #1603/#1604/#1605 and no physical evidence. Run:
  `run_fork_red test/persistent_packed_instance_public_api_test.dart 'README states one upload and 36-float shader contract' 'RED:T46:Geometry README contract missing'`。
- [ ] **GREEN:** add only consumer/provenance/deferred boundary. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_public_api_test.dart test/render/persistent_gpu_lifecycle_public_api_test.dart test/persistent_packed_instance_geometry_test.dart test/render/persistent_gpu_scene_integration_test.dart test/shader_material_vertex_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Docs: packed Geometry契約を追加`。

### Top delivery, two-PR stack and immutable handoff (no commit)

```bash
set -euo pipefail
base_sha=7f71993b7e2a0ab1d2f59726a406098709be7291
printf '%s\n' "$base_sha" | rg -q '^[0-9a-f]{40}$'
test "${reviewed_bottom_sha:?reviewed bottom SHA required}" != ""
printf '%s\n' "$reviewed_bottom_sha" | rg -q '^[0-9a-f]{40}$'
bottom_line=$(git ls-remote --exit-code origin refs/heads/feat/persistent-gpu-lifecycle)
test "$(wc -l <<<"$bottom_line" | tr -d ' ')" -eq 1
bottom_head=${bottom_line%%[[:space:]]*}
test "$bottom_head" = "$reviewed_bottom_sha"
git fetch origin \
  refs/heads/feat/persistent-gpu-lifecycle:refs/remotes/origin/feat/persistent-gpu-lifecycle
git cat-file -e "$bottom_head^{commit}"
git merge-base --is-ancestor "$bottom_head" HEAD
new_files=$(git diff --name-only "$bottom_head...HEAD" -- lib)
test -n "$new_files"
if printf '%s\n' "$new_files" | rg -q '[[:space:]]'; then
  exit 1
else
  path_rc=$?
  test "$path_rc" -eq 1
fi
if forbidden=$(git grep -n -E \
  'instanceTransients\.emplace|List<Matrix4>|Future\.delayed|Timer\(|setVertices\(|setVertexStreams\(|setIndices\(' \
  HEAD -- $new_files 2>&1); then
  printf '%s\n' "$forbidden" >&2
  exit 1
else
  forbidden_rc=$?
  test "$forbidden_rc" -eq 1
fi
version_json=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- \
  flutter --version --machine)
test -n "$version_json"
framework_revision=$(jq -er \
  '.frameworkRevision | select(type == "string" and length == 40)' \
  <<<"$version_json")
test "$framework_revision" = 4dacd3fc91d96262a33e5c598e17d816f0b35641
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart format --output=none --set-exit-if-changed lib test
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .
mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller
test -z "$(git status --porcelain=v1)"
gh stack submit --auto --open --remote origin
top_head=$(git rev-parse HEAD)
printf '%s\n' "$top_head" | rg -q '^[0-9a-f]{40}$'
stack_json=$(gh stack view --json)
test -n "$stack_json"
jq -e --arg base "$base_sha" --arg bottom "$reviewed_bottom_sha" \
  --arg top "$top_head" '
  def fullsha: type == "string" and test("^[0-9a-f]{40}$");
  .trunk == "eqmonitor/flutter-4dacd3fc" and
  [.branches[].name] == ["feat/persistent-gpu-lifecycle",
                         "feat/persistent-packed-instance-geometry"] and
  (.branches[0].base | fullsha) and
  (.branches[0].head | fullsha) and
  (.branches[1].base | fullsha) and
  (.branches[1].head | fullsha) and
  .branches[0].base == $base and
  .branches[0].head == $bottom and
  .branches[1].base == $bottom and
  .branches[1].head == $top and
  (.branches[0].pr.state == "OPEN") and
  (.branches[1].pr.state == "OPEN")
' <<<"$stack_json" >/dev/null

null_stack='{"trunk":"eqmonitor/flutter-4dacd3fc","branches":[{"name":"feat/persistent-gpu-lifecycle","base":null,"head":null,"pr":{"state":"OPEN"}},{"name":"feat/persistent-packed-instance-geometry","base":null,"head":null,"pr":{"state":"OPEN"}}]}'
if jq -e --arg base "$base_sha" --arg bottom "$reviewed_bottom_sha" \
  --arg top "$top_head" '
    def fullsha: type == "string" and test("^[0-9a-f]{40}$");
    (.branches[0].base | fullsha) and
    (.branches[0].head | fullsha) and
    (.branches[1].base | fullsha) and
    (.branches[1].head | fullsha) and
    .branches[0].base == $base and
    .branches[0].head == $bottom and
    .branches[1].base == $bottom and
    .branches[1].head == $top
  ' <<<"$null_stack" >/dev/null; then
  exit 1
else
  null_stack_rc=$?
  test "$null_stack_rc" -eq 1
fi
```

Fresh spec/code review must approve Tasks20–46 and full bottom compatibility. Edit both PR bodies with exact
base/head, #1602/#1612, MIT/no-copy provenance, logical≠resident, missing automatic context-loss signal,
#1603–#1605 and #1604 physical gate deferrals, upstream forward-port and missing canonical spec; re-query nonempty
bodies/base/head/state. Only after both PRs remain OPEN, run exact handoff:

```bash
set -euo pipefail
top_ref=refs/heads/feat/persistent-packed-instance-geometry
top_line=$(git ls-remote --exit-code origin "$top_ref")
test -n "$top_line"
test "$(wc -l <<<"$top_line" | tr -d ' ')" -eq 1
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
test -n "$fork_top_sha"
printf '%s\n' "$fork_top_sha"
```

Any later fork fix invalidates `fork_top_sha` and requires both delivery gates/reviews again。

## Gate D: #1601 immutable approval and EQ worktree

Supervisor supplies exact `reviewed_decoder_sha` from whole-branch #1601 spec/code review. It covers nonempty tile
enumeration, column chunks, `TransferableTypedData`, typed manifest-count failure, missing-depth validity bit and all
#1601 children—not a single commit review。

```bash
set -euo pipefail
cd /Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
test "${reviewed_decoder_sha:?supervisor reviewed decoder SHA required}" != ""
printf '%s\n' "$reviewed_decoder_sha" | rg -q '^[0-9a-f]{40}$'
decoder_json=$(gh pr view 1620 --repo YumNumm/EQMonitor \
  --json state,isDraft,reviewDecision,mergeStateStatus,headRefName,headRefOid,baseRefName,statusCheckRollup,mergeCommit,url)
test -n "$decoder_json"
test "$(jq -er '.headRefOid' <<<"$decoder_json")" = "$reviewed_decoder_sha"
decoder_state=$(jq -er '.state' <<<"$decoder_json")
if test "$decoder_state" = OPEN; then
  git fetch origin \
    '+refs/heads/feat/seismicity-pmtiles-decoder:refs/remotes/origin/feat/seismicity-pmtiles-decoder'
  test "$(git rev-parse origin/feat/seismicity-pmtiles-decoder)" = \
    "$reviewed_decoder_sha"
  git cat-file -e "$reviewed_decoder_sha^{commit}"
  jq -e '
    .isDraft == false and .reviewDecision == "APPROVED" and
    .mergeStateStatus == "CLEAN" and
    .headRefName == "feat/seismicity-pmtiles-decoder" and
    .baseRefName == "feat/seismicity-pmtiles-network-reader" and
    ([.statusCheckRollup[] |
      select(.status != "COMPLETED" or
             (.conclusion != "SUCCESS" and .conclusion != "NEUTRAL" and
              .conclusion != "SKIPPED"))] | length == 0)
  ' <<<"$decoder_json" >/dev/null
  pin_base_sha=$reviewed_decoder_sha
elif test "$decoder_state" = MERGED; then
  git fetch origin '+refs/pull/1620/head:refs/remotes/origin/pull/1620/head'
  test "$(git rev-parse refs/remotes/origin/pull/1620/head)" = \
    "$reviewed_decoder_sha"
  git cat-file -e "$reviewed_decoder_sha^{commit}"
  merge_sha=$(jq -er '.mergeCommit.oid | select(type == "string" and length == 40)' \
    <<<"$decoder_json")
  git fetch origin develop
  git cat-file -e "$merge_sha^{commit}"
  git merge-base --is-ancestor "$merge_sha" origin/develop
  jq -e '
    .headRefName == "feat/seismicity-pmtiles-decoder" and
    .baseRefName == "feat/seismicity-pmtiles-network-reader" and
    .reviewDecision == "APPROVED" and
    ([.statusCheckRollup[] |
      select(.status != "COMPLETED" or
             (.conclusion != "SUCCESS" and .conclusion != "NEUTRAL" and
              .conclusion != "SKIPPED"))] | length == 0)
  ' <<<"$decoder_json" >/dev/null
  pin_base_sha=$(git rev-parse origin/develop)
else
  exit 1
fi
issue_json=$(gh issue view 1601 --repo YumNumm/EQMonitor --json state,body,url)
test -n "$issue_json"
jq -e '(.body | type == "string" and length > 0) and
       (.url | type == "string" and length > 0)' <<<"$issue_json" >/dev/null
```

OPEN requires final non-draft exact head/base, APPROVED, CLEAN and every completed allowed check. MERGED requires
the immutable pull-head SHA plus merge commit in fresh origin/develop and the same review/check evidence. Unknown,
pending, failure, cancellation, empty output or mismatch exits nonzero。

Detached verification preserves failure evidence and returns the failing command status:

```bash
set -euo pipefail
test "${reviewed_decoder_sha:?reviewed decoder SHA required}" != ""
printf '%s\n' "$reviewed_decoder_sha" | rg -q '^[0-9a-f]{40}$'
decoder_verify_parent=$(mktemp -d /tmp/eqmonitor-decoder-verify.XXXXXX)
decoder_verify=$decoder_verify_parent/worktree
git worktree add --detach "$decoder_verify" "$reviewed_decoder_sha"
if (
  set -euo pipefail
  cd "$decoder_verify"
  mise exec -- flutter test packages/seismicity_pmtiles
  mise exec -- flutter test packages/pmtiles_v3
  mise exec -- dart analyze packages/seismicity_pmtiles
  mise exec -- dart analyze packages/pmtiles_v3
); then
  git worktree remove "$decoder_verify"
  rmdir "$decoder_verify_parent"
else
  verify_rc=$?
  printf 'decoder verification failed; evidence worktree: %s\n' "$decoder_verify" >&2
  exit "$verify_rc"
fi
```

Create/resume pin worktree with an exact lease:

```bash
set -euo pipefail
test "${pin_base_sha:?Gate D pin base SHA required}" != ""
printf '%s\n' "$pin_base_sha" | rg -q '^[0-9a-f]{40}$'
eq_root=/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor
pin_worktree=$eq_root/.worktrees/seismicity-flutter-scene-fork-pin
pin_ref=refs/heads/feat/seismicity-flutter-scene-fork-pin
test "$(git -C "$eq_root" remote get-url origin)" = git@github.com:YumNumm/EQMonitor.git
git -C "$eq_root" check-ignore -q .worktrees/seismicity-flutter-scene-fork-pin
pin_remote_exists=0
if pin_line=$(git -C "$eq_root" ls-remote --exit-code origin "$pin_ref"); then
  pin_remote_exists=1
  test "${reviewed_pin_resume_sha:?supervisor reviewed pin SHA required}" != ""
  printf '%s\n' "$reviewed_pin_resume_sha" | rg -q '^[0-9a-f]{40}$'
  test "$(wc -l <<<"$pin_line" | tr -d ' ')" -eq 1
  printf '%s\n' "$pin_line" | rg -q \
    '^[0-9a-f]{40}[[:space:]]+refs/heads/feat/seismicity-flutter-scene-fork-pin$'
  remote_pin_head=${pin_line%%[[:space:]]*}
  test "$remote_pin_head" = "$reviewed_pin_resume_sha"
  git -C "$eq_root" fetch origin \
    "$pin_ref:refs/remotes/origin/feat/seismicity-flutter-scene-fork-pin"
  git -C "$eq_root" cat-file -e "$remote_pin_head^{commit}"
else
  pin_remote_rc=$?
  test "$pin_remote_rc" -eq 2
  remote_pin_head=$pin_base_sha
fi
if test "$pin_remote_exists" -eq 0 && \
  git -C "$eq_root" show-ref --verify --quiet "$pin_ref"; then
  test "${reviewed_pin_resume_sha:?supervisor reviewed local pin SHA required}" != ""
  printf '%s\n' "$reviewed_pin_resume_sha" | rg -q '^[0-9a-f]{40}$'
  git -C "$eq_root" cat-file -e "$reviewed_pin_resume_sha^{commit}"
  test "$(git -C "$eq_root" rev-parse feat/seismicity-flutter-scene-fork-pin)" = \
    "$reviewed_pin_resume_sha"
  remote_pin_head=$reviewed_pin_resume_sha
fi
if test -e "$pin_worktree"; then
  git -C "$eq_root" worktree list --porcelain | rg -Fx "worktree $pin_worktree"
elif git -C "$eq_root" show-ref --verify --quiet "$pin_ref"; then
  test "$(git -C "$eq_root" rev-parse feat/seismicity-flutter-scene-fork-pin)" = \
    "$remote_pin_head"
  git -C "$eq_root" worktree add "$pin_worktree" feat/seismicity-flutter-scene-fork-pin
else
  local_pin_rc=$?
  test "$local_pin_rc" -eq 1
  git -C "$eq_root" worktree add -b feat/seismicity-flutter-scene-fork-pin \
    "$pin_worktree" "$remote_pin_head"
fi
test "$(git -C "$pin_worktree" rev-parse --abbrev-ref HEAD)" = \
  feat/seismicity-flutter-scene-fork-pin
test "$(git -C "$pin_worktree" rev-parse HEAD)" = "$remote_pin_head"
git -C "$pin_worktree" merge-base --is-ancestor "$pin_base_sha" HEAD
test -z "$(git -C "$pin_worktree" status --porcelain=v1)"
git -C "$eq_root" config remote.pushDefault origin
```

## EQMonitor immutable pin tasks

All commands run from `$pin_worktree`. Dart/Flutter uses `mise exec --`。

### Task 47: public API RED and atomic fork pin (depends Gate D and top handoff; 45–90 lines)

**Files:** Create
`packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart`; Modify
`packages/eqmonitor_map/pubspec.yaml`; Modify `packages/eqmonitor_map/example/pubspec.yaml`; Regenerate
`pubspec.lock` only through Flutter。

**Interfaces:** All three descriptors and both lock entries use exact URL
`https://github.com/YumNumm/flutter_scene.git`, requested/resolved `fork_top_sha`, existing paths
`packages/flutter_scene` or `packages/scene`; consumer uses public imports only。

**Implementation shape:** add the source-only consumer RED first. Export `fork_top_sha` before every `yq`
`strenv` use. Capture and validate all six pre-change URL/ref scalars, update exactly those six scalars, then
capture and validate all six post-change scalars before one root `flutter pub get` regenerates both git lock
descriptions. Assert the three existing `path` scalars unchanged separately。

**RED test snippet:**

```dart
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';

test('consumer sees the persistent packed public API', () async {
  final uri = await Isolate.resolvePackageUri(
    Uri.parse('package:flutter_scene/scene.dart'),
  );
  if (uri == null) {
    throw StateError('RED:T47:fork public API missing');
  }
  final source = await File.fromUri(uri).readAsString();
  const symbols = <String>[
    'PersistentGpuResourceLifecycle',
    'PersistentGpuContextState',
    'PersistentGpuResourceLifecycleState',
    'PersistentGpuResourceState',
    'PersistentGpuMemoryUsage',
    'PersistentGpuMemorySnapshot',
    'PersistentPackedInstanceGeometry',
  ];
  expect(symbols.every(source.contains), isTrue,
      reason: 'RED:T47:fork public API missing');
});
```

After the pin turns GREEN, replace that source probe with this compile-time public-consumer test. It imports only
the curated barrel and references all seven public types:

```dart
import 'package:flutter_scene/scene.dart';
import 'package:flutter_test/flutter_test.dart';

Type publicFlutterSceneType<T>() => T;

test('consumer compiles against the persistent packed public API', () {
  expect(<Type>[
    publicFlutterSceneType<PersistentGpuResourceLifecycle>(),
    publicFlutterSceneType<PersistentGpuContextState>(),
    publicFlutterSceneType<PersistentGpuResourceLifecycleState>(),
    publicFlutterSceneType<PersistentGpuResourceState>(),
    publicFlutterSceneType<PersistentGpuMemoryUsage>(),
    publicFlutterSceneType<PersistentGpuMemorySnapshot>(),
    publicFlutterSceneType<PersistentPackedInstanceGeometry>(),
  ], everyElement(isA<Type>()));
});
```

**GREEN implementation snippet:** update and validate all six scalars, then regenerate locks:

```bash
set -euo pipefail
export fork_top_sha
export fork_url=https://github.com/YumNumm/flutter_scene.git
upstream_url=https://github.com/bdero/flutter_scene.git
upstream_ref=7f71993b7e2a0ab1d2f59726a406098709be7291
test -n "${fork_top_sha:?validated fork top SHA required}"
printf '%s\n' "$fork_top_sha" | rg -q '^[0-9a-f]{40}$'

descriptor_specs=(
  'packages/eqmonitor_map/pubspec.yaml|.dependencies.flutter_scene.git'
  'packages/eqmonitor_map/pubspec.yaml|.dependency_overrides.scene.git'
  'packages/eqmonitor_map/example/pubspec.yaml|.dependencies.flutter_scene.git'
)
read_descriptor_scalars() {
  for spec in "${descriptor_specs[@]}"; do
    IFS='|' read -r file query <<<"$spec"
    mise exec -- yq -er "$query.url | select(type == \"string\")" "$file"
    mise exec -- yq -er "$query.ref | select(type == \"string\")" "$file"
  done
}

before=$(read_descriptor_scalars)
test "$(wc -l <<<"$before" | tr -d ' ')" -eq 6
test "$(rg -Fxc "$upstream_url" <<<"$before")" -eq 3
test "$(rg -Fxc "$upstream_ref" <<<"$before")" -eq 3
test "$(mise exec -- yq -er '.dependencies.flutter_scene.git.path' \
  packages/eqmonitor_map/pubspec.yaml)" = packages/flutter_scene
test "$(mise exec -- yq -er '.dependency_overrides.scene.git.path' \
  packages/eqmonitor_map/pubspec.yaml)" = packages/scene
test "$(mise exec -- yq -er '.dependencies.flutter_scene.git.path' \
  packages/eqmonitor_map/example/pubspec.yaml)" = packages/flutter_scene

mise exec -- yq -i \
  '.dependencies.flutter_scene.git.url = strenv(fork_url) |
   .dependencies.flutter_scene.git.ref = strenv(fork_top_sha) |
   .dependency_overrides.scene.git.url = strenv(fork_url) |
   .dependency_overrides.scene.git.ref = strenv(fork_top_sha)' \
  packages/eqmonitor_map/pubspec.yaml
mise exec -- yq -i \
  '.dependencies.flutter_scene.git.url = strenv(fork_url) |
   .dependencies.flutter_scene.git.ref = strenv(fork_top_sha)' \
  packages/eqmonitor_map/example/pubspec.yaml

after=$(read_descriptor_scalars)
test "$(wc -l <<<"$after" | tr -d ' ')" -eq 6
test "$(rg -Fxc "$fork_url" <<<"$after")" -eq 3
test "$(rg -Fxc "$fork_top_sha" <<<"$after")" -eq 3
test "$(mise exec -- yq -er '.dependencies.flutter_scene.git.path' \
  packages/eqmonitor_map/pubspec.yaml)" = packages/flutter_scene
test "$(mise exec -- yq -er '.dependency_overrides.scene.git.path' \
  packages/eqmonitor_map/pubspec.yaml)" = packages/scene
test "$(mise exec -- yq -er '.dependencies.flutter_scene.git.path' \
  packages/eqmonitor_map/example/pubspec.yaml)" = packages/flutter_scene
mise exec -- flutter pub get
```

**Handwritten budget:** descriptor 6–12 + test 30–48 + regenerated-lock review 9–30 = 45–90 lines。

- [ ] **RED:** before pin change, the source-only test fails with the exact dedicated diagnostic. An unrelated
  `rc=1` that merely prints the type name is rejected. Run fail-closed:
  `set -euo pipefail; diagnostic='RED:T47:fork public API missing'; if out=$(mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart 2>&1); then exit 1; else rc=$?; fi; test "$rc" -eq 1; rg -F "$diagnostic" <<<"$out"; if rg -F "$diagnostic" <<<'PersistentPackedInstanceGeometry unrelated rc1'; then exit 1; else rejected_rc=$?; fi; test "$rejected_rc" -eq 1`。
- [ ] **GREEN:** rerun top advertised-ref handoff; export the validated SHA; assert exact pre/post counts for all
  six URL/ref scalars and the exact three paths; then run `mise exec -- flutter pub get`, never editing lock
  manually. Run:
  `set -euo pipefail; mise exec -- flutter pub get; mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart; mise exec -- dart analyze packages/eqmonitor_map; mise exec -- dart analyze packages/eqmonitor_map/example; git --no-pager diff --check`。
- [ ] **Commit:** `Package: Flutter Scene fork SHAへ固定`。

### Task 48: verifier arguments and three descriptors (depends Task 47; 50–95 lines)

**Files:** Create `tool/verify_flutter_scene_pin.sh`; Create
`scripts/ci/test_verify_flutter_scene_pin.sh`。

**Interfaces:** Produces executable
`tool/verify_flutter_scene_pin.sh EXPECTED_URL EXPECTED_FULL_SHA [REPO_ROOT]`; validates exact URL/ref/path for
map flutter_scene, map scene override, example flutter_scene using `mise exec -- yq -er`。

**Implementation shape:** `assert_scalar() (` starts its subshell with `set -euo pipefail`, validates four
arguments, then captures
`actual=$(mise exec -- yq -er "$query | select(type == \"string\")" "$file")`, requires exact equality, and
prints the provided label to stderr before `exit 1` on mismatch. Every test-script fixture helper uses the same
strict subshell-function shape。
Each named RED group converts only its expected missing assertion to exit `1` and prints its exact `RED:T48`/
`T49`/`T50` diagnostic plus group name; command-not-found, parser/toolchain or any other status is propagated and
therefore rejected by the outer exact-rc gate。

**RED test snippet:**

```bash
if output=$(bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor 2>&1); then
  exit 1
else
  rc=$?
fi
test "$rc" -eq 1
rg -F 'RED:T48:descriptor verifier missing' <<<"$output"
```

**GREEN implementation snippet:**

```bash
assert_scalar() (
  set -euo pipefail
  test "$#" -eq 4
  actual=$(mise exec -- yq -er "$2 | select(type == \"string\")" "$1")
  test "$actual" = "$3" || { printf '%s\n' "$4" >&2; exit 1; }
)
```

**Handwritten budget:** verifier 28–45 + fixture test 22–50 = 50–95 lines。

- [ ] **RED:** fixture happy/wrong descriptor URL calls missing verifier. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor 2>&1); then exit 1; else rc=$?; fi; test "$rc" -eq 1; test -n "$out"; rg -F 'descriptor' <<<"$out"; rg -F 'RED:T48:descriptor verifier missing' <<<"$out"`。
- [ ] **GREEN:** script starts `set -euo pipefail`; validates arg count, nonempty URL, `^[0-9a-f]{40}$`, root/files,
  then exact three scalar triples and labels error `file:package:field`; `chmod +x` verifier. Shell test exposes
  `descriptor` group. Run:
  `set -euo pipefail; bash -n tool/verify_flutter_scene_pin.sh scripts/ci/test_verify_flutter_scene_pin.sh; bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor; tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"; mise exec -- dart analyze packages/eqmonitor_map; git --no-pager diff --check`。
- [ ] **Commit:** `Test: Flutter Scene descriptor pin検証を追加`。

### Task 49: exact two-lock verifier (depends Task 48; 45–85 lines)

**Files:** Modify `tool/verify_flutter_scene_pin.sh`; Modify
`scripts/ci/test_verify_flutter_scene_pin.sh`。

**Interfaces:** Adds exact `.packages.flutter_scene.description` and `.packages.scene.description`
URL/ref/`resolved-ref`/path validation; preserves Task48 CLI and descriptor checks。

**Implementation shape:** invoke Task48 `assert_scalar` eight times: four fields for `flutter_scene`, four for
`scene`; expected paths are `packages/flutter_scene` and `packages/scene` respectively。

**RED test snippet:**

```bash
if output=$(bash scripts/ci/test_verify_flutter_scene_pin.sh lock 2>&1); then
  exit 1
else
  rc=$?
fi
test "$rc" -eq 1
rg -F 'RED:T49:resolved-ref verifier missing' <<<"$output"
```

**GREEN implementation snippet:**

```bash
assert_scalar "$repo_root/pubspec.lock" \
  '.packages.flutter_scene.description."resolved-ref"' \
  "$expected_sha" 'pubspec.lock:flutter_scene:resolved-ref'
assert_scalar "$repo_root/pubspec.lock" \
  '.packages.scene.description."resolved-ref"' \
  "$expected_sha" 'pubspec.lock:scene:resolved-ref'
```

**Handwritten budget:** verifier 16–28 + lock fixtures 29–57 = 45–85 lines。

- [ ] **RED:** fixture wrong requested ref and wrong resolved-ref currently pass Task48 verifier; lock group expects
  failure labels. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh lock 2>&1); then exit 1; else rc=$?; fi; test "$rc" -eq 1; test -n "$out"; rg -F 'lock' <<<"$out"; rg -F 'RED:T49:resolved-ref verifier missing' <<<"$out"`。
- [ ] **GREEN:** query each lock scalar with `yq -er`, compare exact expected, include package+field label. Run:
  `set -euo pipefail; bash -n tool/verify_flutter_scene_pin.sh scripts/ci/test_verify_flutter_scene_pin.sh; bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor; bash scripts/ci/test_verify_flutter_scene_pin.sh lock; tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"; mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart; mise exec -- dart analyze packages/eqmonitor_map; git --no-pager diff --check`。
- [ ] **Commit:** `Test: Flutter Scene lock pin検証を追加`。

### Task 50: fail-closed corruption matrix (depends Task 49; 55–100 lines)

**Files:** Modify `scripts/ci/test_verify_flutter_scene_pin.sh`。

**Interfaces:** Test helper
`expect_pin_failure EXPECTED_LABEL EXPECTED_URL EXPECTED_SHA FIXTURE_ROOT` runs verifier, requires nonzero and exact
label. Fixture temp is
`mktemp -d "${TMPDIR:-/tmp}/eqmonitor-flutter-scene-pin.XXXXXX"`; trap removes only a validated nonempty path
matching that exact prefix。

**Implementation shape:** `expect_pin_failure() (` starts with `set -euo pipefail`, validates four arguments,
then uses `if output=$(tool/verify_flutter_scene_pin.sh "$expected_url" "$expected_sha" "$fixture_root" 2>&1);
then exit 1; else rc=$?; fi`, requires `rc != 0`, then `rg -F "$expected_label" <<<"$output"`; each matrix row
copies a clean fixture, mutates one scalar with `mise exec -- yq -i`, and calls the helper。
The strict-subshell `cleanup() (` requires `fixture_root` nonempty and a case match of
`"${TMPDIR:-/tmp}"/eqmonitor-flutter-scene-pin.*` before `rm -rf -- "$fixture_root"`; any other target exits nonzero。

**RED test snippet:**

```bash
if output=$(bash scripts/ci/test_verify_flutter_scene_pin.sh corruption 2>&1); then
  exit 1
else
  rc=$?
fi
test "$rc" -eq 1
rg -F 'RED:T50:corruption matrix missing' <<<"$output"
```

**GREEN implementation snippet:**

```bash
expect_pin_failure() (
  set -euo pipefail
  test "$#" -eq 4
  if output=$(tool/verify_flutter_scene_pin.sh "$2" "$3" "$4" 2>&1); then
    exit 1
  else
    rc=$?
  fi
  test "$rc" -ne 0
  rg -F "$1" <<<"$output"
)
```

**Handwritten budget:** strict helpers 22–35 + corruption rows 33–65 = 55–100 lines。

- [ ] **RED:** matrix covers each descriptor URL/ref/path, each lock URL/ref/resolved-ref/path, short SHA,
  missing field, nonscalar field. Before helper/matrix each corrupt case is unasserted. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh corruption 2>&1); then exit 1; else rc=$?; fi; test "$rc" -eq 1; test -n "$out"; rg -F 'corruption' <<<"$out"; rg -F 'RED:T50:corruption matrix missing' <<<"$out"`。
- [ ] **GREEN:** implement one table-driven loop; every function is a strict subshell, captures verifier status
  via `if`, and fails if status0 or label absent. Run:
  `set -euo pipefail; bash -n tool/verify_flutter_scene_pin.sh scripts/ci/test_verify_flutter_scene_pin.sh; bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor; bash scripts/ci/test_verify_flutter_scene_pin.sh lock; bash scripts/ci/test_verify_flutter_scene_pin.sh corruption; tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"; mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart; mise exec -- dart analyze packages/eqmonitor_map; git --no-pager diff --check`。
- [ ] **Commit:** `Test: Flutter Scene pin破損matrixを追加`。

### Task 51: package consumer provenance (depends Task 50; 30–75 lines)

**Files:** Modify `packages/eqmonitor_map/README.md`; Modify
`packages/eqmonitor_map/example/README.md`。

**Interfaces:** Documents both fork PR URLs, top/base/Flutter full SHAs, 36-float FrameInfo, multi-owner lifecycle,
logical≠resident, no copied reference code, #1603/#1604/#1605 and physical-gate deferral。

**Implementation shape:** update only current instruction sections in both READMEs with identical immutable pin
and provenance paragraph; retain historical pin evidence as explicitly historical。

**RED test snippet:**

```bash
for file in packages/eqmonitor_map/README.md \
  packages/eqmonitor_map/example/README.md; do
  if rg -Fq "$fork_top_sha" "$file"; then exit 1; fi
done
```

**GREEN implementation snippet:**

```markdown
Fork: `https://github.com/YumNumm/flutter_scene.git`
Revision: `<validated fork_top_sha: 40 lowercase hex>`
Accounting: logical bytes, not driver-resident bytes
Provenance: MIT reference only; no source copied
Deferred: #1603, #1604, #1605
```

Both current sections contain these same validated values; angle-bracket notation is replaced with the captured
immutable SHA, not copied literally。

**Handwritten budget:** map README 15–35 + example README 15–40 = 30–75 lines。

- [ ] **RED:** exact fork URL/SHA phrases absent in both current instruction sections. Run fail-closed:
  `set -euo pipefail; if rg -Fq "$fork_top_sha" packages/eqmonitor_map/README.md && rg -Fq "$fork_top_sha" packages/eqmonitor_map/example/README.md; then exit 1; else rc=$?; fi; test "$rc" -eq 1`。
- [ ] **GREEN:** update current instructions, retaining historical evidence labels. Run:
  `set -euo pipefail; rg -Fq https://github.com/YumNumm/flutter_scene.git packages/eqmonitor_map/README.md; rg -Fq https://github.com/YumNumm/flutter_scene.git packages/eqmonitor_map/example/README.md; rg -Fq "$fork_top_sha" packages/eqmonitor_map/README.md; rg -Fq "$fork_top_sha" packages/eqmonitor_map/example/README.md; tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"; bash scripts/ci/test_verify_flutter_scene_pin.sh corruption; mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart; mise exec -- dart analyze packages/eqmonitor_map; git --no-pager diff --check`。
- [ ] **Commit:** `Docs: Flutter Scene provenanceを同期`。

### Task 52: current toolchain and lifecycle knowledge (depends Task 51; 45–95 lines)

**Files:** Modify `docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md`; Modify
`docs/knowledge/20260802_flutter_scene_scene_source_pin.md`; Modify
`docs/knowledge/20260802_flutter_scene_large_static_instances.md`。

**Interfaces:** Current instructions document requested+resolved both lock entries, exact fork/SHA, global
invalidation/completion retirement, logical≠resident, FrameInfo, #1604 device defer and MIT/no-copy provenance。

**Implementation shape:** replace current operational pin/lifecycle paragraphs in the three exact files; leave
dated evidence unchanged and label it historical where ambiguity exists。

**RED test snippet:**

```bash
for file in docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md \
  docs/knowledge/20260802_flutter_scene_scene_source_pin.md \
  docs/knowledge/20260802_flutter_scene_large_static_instances.md; do
  if rg -Fq "$fork_top_sha" "$file"; then exit 1; fi
done
```

**GREEN implementation snippet:**

```markdown
- requested ref and resolved-ref: `<validated fork_top_sha: 40 lowercase hex>`
- retirement: contiguous GPU submission completion
- memory metric: logical bytes, not driver-resident bytes
- FrameInfo: 36 float32 values
- device validation: deferred to #1604
- provenance: MIT reference only; no source copied
```

Every current section uses the captured immutable SHA in place of angle-bracket notation and retains historical
evidence unchanged。

**Handwritten budget:** three current sections total 45–95 lines; historical evidence is not rewritten。

- [ ] **RED:** each current-instruction section lacks exact `fork_top_sha`; historical blocks are not rewritten.
  Run fail-closed:
  `set -euo pipefail; if rg -Fq "$fork_top_sha" docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md && rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_scene_source_pin.md && rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_large_static_instances.md; then exit 1; else rc=$?; fi; test "$rc" -eq 1`。
- [ ] **GREEN:** update only current instructions. Run:
  `set -euo pipefail; rg -Fq "$fork_top_sha" docs/knowledge/20260802_eqmonitor_map_flutter_scene_toolchain.md; rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_scene_source_pin.md; rg -Fq "$fork_top_sha" docs/knowledge/20260802_flutter_scene_large_static_instances.md; tool/verify_flutter_scene_pin.sh https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"; bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor; bash scripts/ci/test_verify_flutter_scene_pin.sh lock; bash scripts/ci/test_verify_flutter_scene_pin.sh corruption; mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart; mise exec -- dart analyze packages/eqmonitor_map; git --no-pager diff --check`。
- [ ] **Commit:** `Docs: Flutter Scene lifecycle知見を同期`。

## EQ delivery and PR route (no commit)

Re-run Gate D live. If decoder SHA changed, invalidate approval, create a recoverable backup ref, rebase from the
old exact base to new exact base, rerun Tasks47–52 gates, and only update remote after validating
`validated_old_remote_sha` against `^[0-9a-f]{40}$` with exact
`--force-with-lease=refs/heads/feat/seismicity-flutter-scene-fork-pin:$validated_old_remote_sha`; bare force is
forbidden。

```bash
set -euo pipefail
test "${pin_worktree:?pin worktree required}" != ""
test "${fork_top_sha:?fork top SHA required}" != ""
test "${reviewed_decoder_sha:?reviewed decoder SHA required}" != ""
test "${decoder_state:?Gate D decoder state required}" != ""
printf '%s\n' "$fork_top_sha" | rg -q '^[0-9a-f]{40}$'
printf '%s\n' "$reviewed_decoder_sha" | rg -q '^[0-9a-f]{40}$'
cd "$pin_worktree"
test -z "$(git status --porcelain=v1)"
tool/verify_flutter_scene_pin.sh \
  https://github.com/YumNumm/flutter_scene.git "$fork_top_sha" "$pin_worktree"
bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor
bash scripts/ci/test_verify_flutter_scene_pin.sh lock
bash scripts/ci/test_verify_flutter_scene_pin.sh corruption
mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart
mise exec -- dart analyze packages/eqmonitor_map
mise exec -- dart analyze packages/eqmonitor_map/example
git --no-pager diff --check

if test "$decoder_state" = OPEN; then
  gh stack link --base feat/seismicity-pmtiles-network-reader --open --remote origin \
    feat/seismicity-pmtiles-decoder feat/seismicity-flutter-scene-fork-pin
  decoder_pr=$(gh pr view 1620 --repo YumNumm/EQMonitor \
    --json state,headRefName,headRefOid,baseRefName,url)
  pin_pr=$(gh pr view feat/seismicity-flutter-scene-fork-pin --repo YumNumm/EQMonitor \
    --json state,headRefName,headRefOid,baseRefName,url)
  test -n "$decoder_pr"
  test -n "$pin_pr"
  jq -e --arg decoder "$reviewed_decoder_sha" '
    .state == "OPEN" and
    .headRefName == "feat/seismicity-pmtiles-decoder" and
    .headRefOid == $decoder and
    .baseRefName == "feat/seismicity-pmtiles-network-reader"
  ' <<<"$decoder_pr" >/dev/null
  jq -e '
    .state == "OPEN" and
    .headRefName == "feat/seismicity-flutter-scene-fork-pin" and
    .baseRefName == "feat/seismicity-pmtiles-decoder"
  ' <<<"$pin_pr" >/dev/null
elif test "$decoder_state" = MERGED; then
  git push origin HEAD:refs/heads/feat/seismicity-flutter-scene-fork-pin
  pin_pr_body="Pins YumNumm/flutter_scene at ${fork_top_sha}. Depends on reviewed decoder ${reviewed_decoder_sha}. Tracks #1602 and #1612. Remaining work: #1603 wiring; #1604 24-byte schema, LOD, 2M and device 30fps/5min gate; #1605 UX and device smoke. No reference source copied; upstream forward-port and missing canonical spec remain explicit."
  pin_pr_url=$(gh pr create --repo YumNumm/EQMonitor --base develop \
    --head feat/seismicity-flutter-scene-fork-pin \
    --title 'Package: Flutter Scene fork SHAへ固定' --body "$pin_pr_body")
  test -n "$pin_pr_url"
  pin_pr=$(gh pr view "$pin_pr_url" --repo YumNumm/EQMonitor \
    --json state,headRefName,headRefOid,baseRefName,url)
  jq -e '
    .state == "OPEN" and
    .headRefName == "feat/seismicity-flutter-scene-fork-pin" and
    .baseRefName == "develop"
  ' <<<"$pin_pr" >/dev/null
else
  exit 1
fi

pin_head=$(git rev-parse HEAD)
pin_line=$(git ls-remote --exit-code origin \
  refs/heads/feat/seismicity-flutter-scene-fork-pin)
test -n "$pin_line"
test "$(wc -l <<<"$pin_line" | tr -d ' ')" -eq 1
test "${pin_line%%[[:space:]]*}" = "$pin_head"
git fetch origin \
  refs/heads/feat/seismicity-flutter-scene-fork-pin:refs/remotes/origin/feat/seismicity-flutter-scene-fork-pin
git cat-file -e "$pin_head^{commit}"
test "$(git rev-parse origin/feat/seismicity-flutter-scene-fork-pin)" = "$pin_head"
```

PR body must contain fork bottom/top URLs, advertised top SHA, decoder final SHA, #1602/#1612, no-copy/license,
and remaining #1603/#1604/#1605/device/resident/upstream/spec boundaries. Re-query exact body/base/head/state/checks。
No merge, #1603 implementation, device/Simulator/E2E is authorized by this plan。

## Mechanical plan audit

Run from the EQMonitor plan worktree before requesting plan review. This reports cardinalities rather than
inferring them visually: 58 split tasks all have snippets/budgets; the bottom has 52 unique RED mappings; the
affinity matrix has 14 independently rejected entry/callback rows; Task28 closes every downstream plan field;
Task18 preserves symbol provenance; no private-method/legacy undefined-helper call remains; Task47 assigns all six
descriptor scalars after exporting the SHA; and a null-equals-null stack cannot pass the SHA predicate。

```bash
set -euo pipefail
plan=docs/superpowers/plans/2026-08-12-flutter-scene-persistent-packed-instances.md
task_count=$(rg -c '^### Task [0-9]+[A-D]?:' "$plan")
red_snippet_count=$(rg -c '^\*\*RED test snippet:\*\*$' "$plan")
green_snippet_count=$(rg -c '^\*\*GREEN implementation snippet:\*\*' "$plan")
budget_count=$(rg -c '^\*\*Handwritten budget:\*\*' "$plan")
test "$task_count" -eq 58
test "$red_snippet_count" -eq "$task_count"
test "$green_snippet_count" -eq "$task_count"
test "$budget_count" -eq "$task_count"

bottom_plan=$(sed '/^### Task 47:/q' "$plan")
bottom_red_count=$(rg -c 'run_fork_red test/' <<<"$bottom_plan")
bottom_red_mapping_count=$(rg -o \
  "run_fork_red [^\x60]+ 'RED:T[0-9]+[A-D]?:[^']+'" <<<"$bottom_plan" | \
  sed -E "s/.*'(RED:T[0-9]+[A-D]?):[^']+'.*/\1/" | sort -u | wc -l | tr -d ' ')
test "$bottom_red_count" -eq 52
test "$bottom_red_mapping_count" -eq "$bottom_red_count"
if rg -q 'set -euo pipefail; (title=|if out=).*flutter@4dac' <<<"$bottom_plan"; then
  exit 1
else
  weak_red_rc=$?
  test "$weak_red_rc" -eq 1
fi

affinity_matrix=$(sed -n \
  '/affinity-entrypoint-matrix-start/,/affinity-entrypoint-matrix-end/p' "$plan")
affinity_entrypoint_count=$(rg -c '^\| (`|lease|tracker|immediately)' \
  <<<"$affinity_matrix")
test "$affinity_entrypoint_count" -eq 14

task28=$(sed -n '/^### Task 28:/,/^### Task 29:/p' "$plan")
required_plan_api=(
  vertexBytes instanceBytes instanceOffset nonIndexBytes indexBytes totalBytes
  indexType indexCount vertexLayout vertexStrideInBytes instanceStrideInBytes
  localBounds localBoundingSphere vertexCount instanceCount
)
for field in "${required_plan_api[@]}"; do
  rg -q "(get $field\\b|final [^;]+ $field;)" <<<"$task28"
done
consumer_plan_fields=$(sed -n '/^### Task 29:/,/^### Task 45:/p' "$plan" | \
  rg -o 'plan\.[A-Za-z][A-Za-z0-9_]*' | sed 's/plan\.//' | \
  rg -v '^dart$' | sort -u)
while IFS= read -r field; do
  printf '%s\n' "${required_plan_api[@]}" | rg -Fxq "$field"
done <<<"$consumer_plan_fields"

task18=$(sed -n '/^### Task 18:/,/^### Task 19:/p' "$plan")
lifecycle_export=$(sed -n "/export 'src\\/render\\/persistent_gpu_resource_lifecycle.dart'/,/;/p" \
  <<<"$task18")
models_export=$(sed -n "/export 'src\\/render\\/persistent_gpu_resource_models.dart'/,/;/p" \
  <<<"$task18")
rg -q 'show PersistentGpuResourceLifecycle;' <<<"$lifecycle_export"
if rg -q 'PersistentGpu(ContextState|MemorySnapshot|MemoryUsage|ResourceLifecycleState|ResourceState)' \
  <<<"$lifecycle_export"; then exit 1; else provenance_rc=$?; fi
test "$provenance_rc" -eq 1
for symbol in PersistentGpuContextState PersistentGpuMemorySnapshot \
  PersistentGpuMemoryUsage PersistentGpuResourceLifecycleState \
  PersistentGpuResourceState; do
  rg -q "\\b$symbol\\b" <<<"$models_export"
done
if rg -q '\bPersistentGpuResourceLifecycle\b' <<<"$models_export"; then
  exit 1
else
  lifecycle_leak_rc=$?
fi
test "$lifecycle_leak_rc" -eq 1

if rg -q '(\b_[A-Za-z][A-Za-z0-9_]*\s*\(|\b(get|set)\s+_[A-Za-z])' "$plan"; then
  exit 1
else
  private_method_rc=$?
fi
test "$private_method_rc" -eq 1
for legacy_helper in requireOwner buildPersistent requireCurrentActiveRecord \
  settleNoSubmissionMarks _fromParts; do
  if rg -Fq "$legacy_helper(" "$plan"; then exit 1; else helper_rc=$?; fi
  test "$helper_rc" -eq 1
done

task47=$(sed -n '/^### Task 47:/,/^### Task 48:/p' "$plan")
descriptor_spec_count=$(rg -c \
  "^  'packages/eqmonitor_map(/example)?/pubspec.yaml\\|\\.(dependencies.flutter_scene|dependency_overrides.scene).git'$" \
  <<<"$task47")
url_assignment_count=$(rg -c 'git.url = strenv\(fork_url\)' <<<"$task47")
ref_assignment_count=$(rg -c 'git.ref = strenv\(fork_top_sha\)' <<<"$task47")
test "$descriptor_spec_count" -eq 3
test "$url_assignment_count" -eq 3
test "$ref_assignment_count" -eq 3
export_line=$(rg -n -m1 '^export fork_top_sha$' <<<"$task47" | cut -d: -f1)
strenv_line=$(rg -n -m1 'strenv\(fork_top_sha\)' <<<"$task47" | cut -d: -f1)
test "$export_line" -lt "$strenv_line"

null_stack='{"branches":[{"base":null,"head":null},{"base":null,"head":null}]}'
if jq -e '
  def fullsha: type == "string" and test("^[0-9a-f]{40}$");
  (.branches[0].base | fullsha) and
  (.branches[0].head | fullsha) and
  (.branches[1].base | fullsha) and
  (.branches[1].head | fullsha)
' <<<"$null_stack" >/dev/null; then
  exit 1
else
  stack_null_negative_exit=$?
  test "$stack_null_negative_exit" -eq 1
fi

printf 'task_snippets=%s red_mappings=%s affinity_entrypoints=%s plan_fields=%s descriptor_scalars=%s private_methods=%s stack_null_exit=%s\n' \
  "$task_count" "$bottom_red_mapping_count" "$affinity_entrypoint_count" \
  "${#required_plan_api[@]}" "$((url_assignment_count + ref_assignment_count))" \
  0 "$stack_null_negative_exit"
```

## Completion checklist

- [ ] Gate A proves the real authorized fork; agents never create it。
- [ ] Every shell gate is `set -euo pipefail`; expected absence/failure captures and validates nonzero status。
- [ ] Gate C mechanically proves exact `frameworkRevision`。
- [ ] Bottom API dependency order compiles: immediate retire/invalidation precede frame/invalidation tests。
- [ ] Global owner/context/resource matrices, Future identities, zero-owner recovery and old-generation rejection pass。
- [ ] Top types compile before use; concrete Geometry first appears with every abstract member implemented。
- [ ] Public factory and tests share the typed check→plan→upload→register→construct transaction。
- [ ] Lifecycle reject precedes allocation; register/construct failures clean exact storage/lease owner once。
- [ ] Fakes implement narrow interfaces and never subclass private/base GPU classes。
- [ ] Immutable Geometry throws from inherited `setLocalBounds` and returns defensive bounds copies。
- [ ] Exact overwrite/flush/failure/no-publish ordering and source independence pass。
- [ ] Two slots and exact 36-float FrameInfo bind in normal/depth/shadow/selection via `depthOnlyVertex == null`。
- [ ] Layout names/overlap/alignment/checked arithmetic/index values/finite derived bounds pass。
- [ ] Fork bottom/top form a verified two-PR stack; only advertised/fetched/cat-file top SHA is handed off。
- [ ] #1601 approval and detached verification bind to exact immutable SHA and fail nonzero on failure。
- [ ] EQ descriptors/locks/docs use one full SHA; verifier and corruption matrix are fail-closed。
- [ ] EQ route is two-branch link when decoder OPEN or standalone PR when MERGED。
- [ ] All PRs preserve provenance/license/deferred-device/resident boundaries; none are merged by this plan。
