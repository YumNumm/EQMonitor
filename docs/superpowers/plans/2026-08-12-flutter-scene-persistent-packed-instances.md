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

- EQMonitor plan branchの元baseは`8120f23446b53f4b3222d32306d4fb576cb9683e`。
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

Allocation internal states are `active`, `retirementPendingOpenFrame`,
`retirementPendingSubmission`, `releasing`, `retired`, `retirementFailed`; public state collapses both pending。

| current | event | result |
|---|---|---|
| active, never marked | retire | releasing immediately; cached Future |
| active, open mark | retire | pendingOpenFrame; retain |
| pendingOpenFrame | beforeSubmit(id) | pendingSubmission; last=id |
| pendingOpenFrame | endFrame without submit | releasing if its nullable prior lastSubmission is complete, otherwise pendingSubmission |
| active | beforeSubmit(id) after mark | active; last=max(previous,id) |
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

## Exact internal interfaces and file ownership

None of these are exported publicly. Test fakes implement these Dart interfaces or pass typed functions; they do
not extend/subclass `gpu.DeviceBuffer`, `gpu.BufferView`, or `gpu.RenderPass`。

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
  jq -e '
    .trunk == "eqmonitor/flutter-4dacd3fc" and
    .currentBranch == "feat/persistent-gpu-lifecycle" and
    (([.branches[].name] == ["feat/persistent-gpu-lifecycle"]) or
     ([.branches[].name] == ["feat/persistent-gpu-lifecycle",
                            "feat/persistent-packed-instance-geometry"]))
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

Every RED command below is intentionally expected to return nonzero with the named missing symbol/behavior. Run
it as its own shell block; nonzero is the proof. After GREEN, run every named focused and regression file in that
task, then analyze and diff check. Before commit run `git --no-pager diff --numstat HEAD --` with the task's exact
files and require 30–100 handwritten changed lines. A different agent performs spec review and code review; only
zero findings permits the exact named commit and `git push`。Generated lock changes are excluded from line count。

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
  Run fail-closed: `set -euo pipefail; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/gpu_submission_tracker_test.dart --plain-name 'completion listeners observe the contiguous watermark in order' 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'addCompletionListener' <<<"$out"`。
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

- [ ] **RED:** construct usage with 1..9 and reference all three enum value sets. Run:
  `set -euo pipefail; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart --plain-name 'public usage preserves nine logical fields and three enums' 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'PersistentGpuMemoryUsage' <<<"$out"`。
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
  Run: `set -euo pipefail; title='snapshot is exact and mutations stay on one isolate'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** default captures `Isolate.current.controlPort`; compare typed `SendPort` equality. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU snapshotとisolate制約を追加`。

### Task 4: owner, allocation and immediate retirement (depends Task 3; 60–100 lines)

**Files:** Create `lib/src/render/persistent_gpu_resource_registry.dart`; Create
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Consumes tracker/affinity/models。Produces
`int attachOwner()`、
`PersistentGpuResourceLease register({required int ownerId, required int totalBytes, required int instanceBytes, required void Function() release})`、
and lease `int get generation; PersistentGpuResourceState get state; Future<void> retire(); void requireCurrentActive()`。

**Implementation shape:** `retire()` returns the record's existing completer Future when present; otherwise it
creates/publishes the completer and sets `releasing` before invoking the stored callback once, changes terminal
state, then completes that same Future. A callback's reentrant `retire()` therefore cannot allocate another Future。

- [ ] **RED:** owner IDs monotonic; invalid owner/bytes fail before callback; a never-marked lease releases once
  immediately and repeated/reentrant `retire()` returns an identical Future. Run:
  `set -euo pipefail; title='unused allocation retirement is immediate and idempotent'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** create owner/record identity maps, generation1 active registry, and one cached completer per record;
  set `releasing` before callback. No frame/submission state yet. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU allocation leaseを追加`。

### Task 5: active logical-memory snapshot (depends Task 4; 45–90 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces
`PersistentGpuMemorySnapshot snapshotFor({required int ownerId, required PersistentGpuResourceLifecycleState lifecycleState})`。

**Implementation shape:** initialize two nine-counter accumulators, fold each record once into global and into
owner when IDs match, then construct immutable usages/snapshot from tracker counters。

- [ ] **RED:** register `(64,24)` and `(96,48)` under two owners; assert global `2/160/72`, owner
  `1/64/24`, generation1, exact tracker counters, unknown owner failure. Run:
  `set -euo pipefail; title='snapshot separates global and owner active logical bytes'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** one fold builds global/owner active/retiring/failed buckets; do not report driver bytes. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart test/render/gpu_submission_tracker_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU memory集計を追加`。

### Task 6: owner disposal on immediate leases (depends Task 5; 50–90 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces `Future<void> disposeOwner(int ownerId)` and owner state/cached FD storage。

**Implementation shape:** set owner disposed and publish one owner FD completer/Future before calling any retire
path; then snapshot its records, call each cached retire path, and complete FD from their non-eager `Future.wait`.
Repeated and release-callback-reentrant calls return FD by identity。

- [ ] **RED:** dispose A retires only A while B remains active; disposed A snapshot remains readable; repeated and
  first-release-callback-reentrant dispose are identical; resource Future completes before FD; unknown owner fails.
  Run:
  `set -euo pipefail; title='owner disposal shares resource futures and leaves other owners active'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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
notifications settle, then set invalidated immediately before successful FI completion。

- [ ] **RED:** A invalidates A/B records; state and cached FI exist before the first callback; that callback's
  reentrant invalidation and B's call return the identical FI; register rejects; resource→FD→FI order is exact.
  Run:
  `set -euo pipefail; title='one owner invalidates all immediate resources in the generation'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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
increments generation once, clears prior FI and sets active; old records retain their original generation。

- [ ] **RED:** last owner dispose during invalidating leaves FI alive; owner count0 reaches invalidated; recovery
  owner attaches, cannot register, recreates generation1→2, then registers. Old generation lease rejects via the
  same surviving owner after recreate. Invalidating/failed attach and invalid recreate rows fail. Run:
  `set -euo pipefail; title='zero-owner invalidation recovers while old generation leases reject'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** two injected handles share context/generation/global snapshot but distinct owner usage; public
  constructor uses the global identity. Run:
  `set -euo pipefail; title='lifecycle handles share one registry and distinct owners'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** parameterize active owner × active/invalidating/invalidated: shared FI, recreate only from
  invalidated, owner-specific FD, and next-generation FI non-identical. Run:
  `set -euo pipefail; title='active lifecycle operations match every context row'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** return registry Futures directly; no second completer. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_models_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: lifecycle active操作表を固定`。

### Task 11: lifecycle disposed and reentry matrix (depends Task 10; 50–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_lifecycle.dart`; Modify
`test/render/persistent_gpu_resource_lifecycle_test.dart`。

**Interfaces:** Completes disposed-owner rows with cached FE; snapshot/getters remain read-only after dispose。

**Implementation shape:** dispose stores FD once; disposed invalidate returns one pre-created failed FE;
recreate throws synchronously; snapshot/getters remain registry reads。

- [ ] **RED:** for active/invalidating/invalidated contexts, disposed invalidate returns identical FE, disposed
  dispose identical FD, disposed recreate throws synchronously, dispose during invalidation waits own records, and
  release callback reenters
  dispose/invalidate/snapshot without duplicate release. Run:
  `set -euo pipefail; title='disposed lifecycle and release reentry preserve Future identities'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_lifecycle_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

**Implementation shape:** `PersistentGpuResourceLease.markUsed() => _registry.markUsed(this);`; registry checks
affinity/frame/lease identity/current generation before inserting the record into `_openFrameMarks`。

- [ ] **RED:** never-submitted `begin→mark→retire→end` releases once; a resource with incomplete prior
  `lastSubmission=1` stays pending through a later no-submit frame until completion1; double mark stays one mark;
  nested begin, closed end/mark, foreign/terminal/old-generation lease throw before mutation. Run:
  `set -euo pipefail; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name 'open frame without submission retires only at end' 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'beginFrame' <<<"$out"`。
- [ ] **GREEN:** mark records by identity; immediate `retire()` path from Task4 becomes pending-open when marked;
  end clears marks and releases only when `lastSubmission == null || completedThrough >= lastSubmission`; otherwise
  it preserves that exact prior stamp as pending-submission. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU resource frame記録を追加`。

### Task 13: before-submit stamping after invalidation exists (depends Task 12; 45–85 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Registry constructor registers exactly one tracker before-submit listener; record stores nullable
`lastSubmission`。

**Implementation shape:** listener snapshots `_openFrameMarks`, clears it, and assigns each live record
`lastSubmission = max(lastSubmission ?? id, id)` without settling any Future。

- [ ] **RED:** `begin→mark→retire→record` remains pending with last1; two submits produce last2; Task7
  invalidation rejects new marks but the pre-existing mark still receives its stamp. Run:
  `set -euo pipefail; title='retire during open frame stamps the next submission after invalidation'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** listener snapshots+clears marks and writes max(previous,id) for active/pending-open records; it
  never completes retirement. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU submission stampを追加`。

### Task 14: completion-gated retirement (depends Task 13; 55–95 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Registry constructor registers one completion listener; existing lease cached Future/state now
waits `completedThrough >= lastSubmission`。

**Implementation shape:** completion listener snapshots eligible pending records and invokes the existing Task4
release routine only when nullable stamp is absent or at/below watermark。

- [ ] **RED:** cover submit→complete→retire, mark→retire→submit→complete, and completion ids2→1; assert no
  early callback, release once, identical Future. Run:
  `set -euo pipefail; title='completion watermark releases every stamped retirement exactly once'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** eligible snapshot only; set releasing before callback; success removes accounting then completes.
  Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/frame_transients_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU completion後にresourceを解放`。

### Task 15: release failure and ordered continuation (depends Task 14; 55–100 lines)

**Files:** Modify `lib/src/render/persistent_gpu_resource_registry.dart`; Modify
`test/render/persistent_gpu_resource_registry_test.dart`。

**Interfaces:** Produces terminal failed accounting, context cause,
`@visibleForTesting List<AsyncError> get failureLog`, and cached terminal failure Future returned by later active-owner
`invalidateContext`; recreate/register/bind reject failed state; disposed-owner FE/FD rules remain owner-specific。

**Implementation shape:** release routine catches each callback error after marking the record failed, stores the
first as context cause/terminal Future, appends every error, and continues its precomputed release snapshot;
`failureLog` returns `List<AsyncError>.unmodifiable(_failureLog)` so tests cannot mutate registry state。

- [ ] **RED:** A callback reenters its retire/snapshot then throws first; B callback throws second. Complete the
  shared submission; assert callbacks once, both resources/context failed, failed bytes retained, later records
  still attempted, `failureLog.map((entry) => entry.error)` is `[first,second]`. Public lifecycle then covers
  active/disposed failed-context rows. Run:
  `set -euo pipefail; title='release failures are ordered terminal and do not stop later release'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** move state/accounting before callback; first error is cause, all later errors append, continue a
  release snapshot and return the cached terminal context Future for later invalidation. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_resource_registry_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Fix: GPU release失敗をterminal化`。

### Task 16: encode-scope try/finally seam (depends Task 15; 35–70 lines)

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

- [ ] **RED:** normal events are begin/encode/end; encode failure still ends and rethrows identical error/stack;
  begin failure runs neither later callback; encode+end failure preserves encode primary. Run:
  `set -euo pipefail; title='encode scope closes and preserves the original failure'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_frame_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** one begin, one `try/finally`, capture one `AsyncError` only to preserve primary via
  `Error.throwWithStackTrace`; no generic framework. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_frame_test.dart test/render/persistent_gpu_resource_registry_test.dart test/render/gpu_submission_tracker_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: GPU encode scopeを追加`。

### Task 17: Scene owns one encode scope (depends Task 16; 40–80 lines)

**Files:** Modify `lib/src/scene.dart`; Create
`test/render/persistent_gpu_scene_integration_test.dart`。

**Interfaces:** Existing `renderViews(List<RenderView> views, ui.Canvas canvas, {ui.Rect? region, double? pixelRatio})`
remains public wrapper; original body becomes exact private
`void _renderViewsImpl(List<RenderView> views, ui.Canvas canvas, {ui.Rect? region, double? pixelRatio})`。

**Implementation shape:** wrapper has one expression-level call to Task16 seam with global begin/end and a closure
calling the renamed body with all four arguments unchanged。

- [ ] **RED:** source/test seam asserts wrapper contains one `runPersistentGpuEncodeScope`, begin/end use global
  registry, encode calls `_renderViewsImpl` once, and empty/throw routes keep ordering. Run:
  `set -euo pipefail; title='Scene renderViews owns exactly one persistent encode scope'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_integration_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** rename old body without reindent; wrapper calls global begin, exact
  `_renderViewsImpl(views, canvas, region: region, pixelRatio: pixelRatio)`, global end. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_scene_integration_test.dart test/render/persistent_gpu_scene_frame_test.dart test/scene_view_test.dart test/render_scale_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: SceneへGPU lifecycleを接続`。

### Task 18: curated lifecycle public export (depends Task 17; 35–70 lines)

**Files:** Modify `lib/src/scene.dart`; Modify `lib/scene.dart`; Create
`test/render/persistent_gpu_lifecycle_public_api_test.dart`。

**Interfaces:** Public export includes lifecycle, exactly 3 enums, usage/snapshot; excludes registry, lease,
affinity, global registry and encode seam。

**Implementation shape:** `lib/src/scene.dart` imports internal files for Scene use; `lib/scene.dart` adds one
curated export with a `show` list containing only the six public lifecycle symbols。

- [ ] **RED:** public-only import constructs lifecycle and reads active/generation1/zero snapshot; source
  assertions reject each internal symbol. Run:
  `set -euo pipefail; title='public lifecycle barrel hides registry internals'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_lifecycle_public_api_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** source expectation requires sequence plus multi-owner invalidation, terminal failure, no automatic
  context-loss signal, no device evidence. Run:
  `set -euo pipefail; title='README states terminal lifecycle ordering'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/render/persistent_gpu_lifecycle_public_api_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** exact happy `0*max=0`, `max+0=max`, `align16(1)=16`; negative, `max*2`, `max+1`,
  `align16(max)`, `endOffset(max,1)` errors include operation/operands. Run:
  `set -euo pipefail; title='checked arithmetic rejects before overflow'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** mutate/clear caller buffer and attribute lists after create; returned nested lists reject mutation
  and remain value equal. Run:
  `set -euo pipefail; title='layout is deeply snapshotted before caller mutation'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** reject slot count0/1/3, wrong step modes, empty attributes, empty/whitespace/surrounding-whitespace
  name, duplicate names across slots, stride<=0. Run:
  `set -euo pipefail; title='layout rejects slots names and strides'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** reject negative offset, checked end overflow/max breach, end>stride, offset misaligned to
  `gcd(bytesPerElement,4)`, stride misaligned to slot maximum, overlap `[0,12)`/`[8,12)`; accept adjacent
  `[0,8)`/`[8,12)`; overlap is accepted before GREEN. Run:
  `set -euo pipefail; title='layout rejects misaligned overlapping checked ranges'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** reject NaN/infinity/min>max and finite endpoints yielding non-finite center/radius; mutate source,
  returned Aabb3 and returned Sphere then observe canonical later copies. Run:
  `set -euo pipefail; title='bounds validate derived values and return defensive copies'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** retain six finite scalars and finite derived center/radius only; construct fresh objects per getter.
  Run: `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/bounds_test.dart test/cull_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed boundsを防御的に固定`。

### Task 25: optional index byte shape (depends Task 24; 35–75 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Produces
`PersistentPackedIndexPlan.create({required ByteData? data, required gpu.IndexType type, required int vertexCount})`
with final `hasIndices/indexCount/indexBytes`; retains no data。

**Implementation shape:** null returns no-index scalars; nonnull chooses width via exhaustive enum switch,
requires positive divisible length and positive vertex count, and stores count/byte scalars only。

- [ ] **RED:** null accepted; non-null empty, int16 odd, int32 non-multiple4, vertexCount<=0 rejected; supported
  widths produce exact counts. Run:
  `set -euo pipefail; title='index byte shape matches exact enum width'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** exhaustive index-type switch and exact divisibility; no fallback enum. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart test/geometry_test.dart test/vertex_layout_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed index形状を検証`。

### Task 26: index value scan before upload (depends Task 25; 40–80 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_plan.dart`; Modify
`test/persistent_packed_instance_plan_test.dart`。

**Interfaces:** Extends Task25; every little-endian index satisfies `value < vertexCount`。

**Implementation shape:** loop from element0 to indexCount-1, derive byte offset from width, read the matching
little-endian unsigned value, and throw with element/value/count on first invalid value。

- [ ] **RED:** before adding the scan, int16/int32 accept `[0,vertexCount-1]` and erroneously accept equal/larger;
  test expects `ArgumentError` including element/value/count. Run:
  `set -euo pipefail; title='every index is smaller than vertexCount'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** assert vertex multiply, align16, padding, instance multiply, non-index/index adds; reject nonpositive
  counts and per-buffer/total max before source-length compare. Run:
  `set -euo pipefail; title='allocation sizes use checked multiply align and add'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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
return a final object containing only those immutable values and scalars。

- [ ] **RED:** valid indexed/non-indexed plans, exact length mismatches, and post-create mutation of all source
  objects. Run:
  `set -euo pipefail; title='composite plan retains no caller-owned source'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** events vertex `(0,len)` once, instance `(instanceOffset,len)` once, optional index `(0,len)` once;
  false at each write stops later events and error includes operation/offset/length. Run:
  `set -euo pipefail; title='upload executor writes each source exactly once'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_plan_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** compile fake and assert a scripted buffer's typed event list; source assertion forbids
  `extends gpu.DeviceBuffer` / `extends gpu.BufferView`. Run:
  `set -euo pipefail; title='recording backend implements typed calls without GPU subclassing'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_gpu_backend_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** source contract requires that exact one host-visible `gpuContext.createDeviceBuffer` call,
  exact overwrite/flush/slice delegation,
  null-on-release, post-release StateError, and no public export. Run:
  `set -euo pipefail; title='device backend wraps one nullable buffer without subclassing'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_gpu_backend_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** exact events allocate, vertex overwrite, instance overwrite, flush `(0,nonIndexBytes)`; each
  overwrite false and flush throw releases once, stops later event, returns nothing. Run:
  `set -euo pipefail; title='non-index upload flushes once before returning buffer'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** indexed exact events are allocate non-index/index, two non-index writes, non-index flush, index
  write, index flush, then exactly 3 slices. Allocation/write/each flush failures release every created buffer in
  reverse order, make no slice, run no later event. Run:
  `set -euo pipefail; title='indexed upload publishes slices only after both flushes'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** exact slice offsets/lengths; mutate source after upload while fake's copied upload remains fixed;
  release clears slices then index/non-index wrappers once; repeat no-op. Run:
  `set -euo pipefail; title='storage releases views and retains no source bytes'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_storage_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** fake records typed vertex/index/frame/draw arguments; source rejects `extends gpu.RenderPass`.
  Run: `set -euo pipefail; title='recording render pass implements typed events without GPU subclassing'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** source contract requires `bindVertexBufferCompat`, `bindIndexBufferCompat`,
  `drawCompat/drawIndexedCompat`; a foreign slice fails before pass call; indexed/non-index draw arguments exact.
  Run: `set -euo pipefail; title='GPU adapter unwraps only device slices for bind and draw'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** generic selector returns override without invoking default and otherwise invokes default exactly
  once; pure packed output is exactly 36 float32: camera0..15, model16..31, camera position32..34, zero35; source
  contract requires production to emplace these 144 bytes and bind selected shader's `FrameInfo` slot. Run:
  `set -euo pipefail; title='GPU adapter packs exact 36-float FrameInfo'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** allocate one `Float32List(36)`, `setRange` matrices, assign position/pad, emplace and bind exact
  slot. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_render_pass_test.dart test/geometry_test.dart test/render/frame_transients_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed FrameInfoを36 floatでbind`。

### Task 38: plain lifecycle-aware binding delegate (depends Task 37; 55–100 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_binding.dart`; Create
`test/persistent_packed_instance_binding_test.dart`。

**Interfaces:** Produces non-Geometry final
`PersistentPackedInstanceBinding({required plan, required storage, required lease, required gpu.Shader Function() defaultShader})` with
`void bind({required adapter, required transients, required modelTransform, required cameraTransform, required cameraPosition, gpu.Shader? shaderOverride})`
and `void draw({required adapter, int externalInstanceCount = 1})`。

**Implementation shape:** bind calls `lease.requireCurrentActive(); lease.markUsed();`, then adapter slot0/slot1,
optional index and FrameInfo in that order. It passes the default resolver and nullable override through without
resolving either; only Task37's production adapter resolves. Draw repeats `requireCurrentActive()`, requires
external count1, and passes stored vertex/index/instance counts to the adapter。

- [ ] **RED:** bind exact events requireCurrentActive→markUsed→slot0→slot1→index?→frame; fake records exact
  default resolver identity/override-presence without invoking either;
  terminal/old-generation/disposed/non-active/closed-frame all have adapter events0. Draw exact counts; external
  count!=1 and retire between bind/draw fail before event. Run:
  `set -euo pipefail; title='binding validates lifecycle before full persistent bind and draw'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_binding_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** one final plain delegate; no superclass calls, source scan, overwrite or instance transients. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/persistent_packed_instance_storage_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed bind delegateを追加`。

### Task 39: typed construction transaction happy path (depends Task 38; 45–85 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_transaction.dart`; Create
`test/persistent_packed_instance_transaction_test.dart`。

**Interfaces:** Produces exact typed aliases and generic `executePersistentPackedInstanceTransaction<T>` shown
in Exact internal interfaces. No dynamic/object parameter, subclass, service locator, or optional callback。

**Implementation shape:** the function calls `checkCanCreate()` first, assigns `final plan = buildPlan()`, then
`final storage = upload(backend: backend, plan: plan)`, registers exact plan bytes with
`release: storage.release`, and invokes `construct(plan: plan, storage: storage, lease: lease)`。

- [ ] **RED:** typed recording closures observe exact order check→plan→upload(backend identity)→register exact
  bytes/release callback→construct exact parts and return sentinel. Run:
  `set -euo pipefail; title='typed transaction constructs only after check upload and register'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_transaction_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** table check/build/upload/register/construct throws distinct sentinel; assert exact stopped event
  prefix, allocation0 on check reject, release0 for pre-storage, storage release1 on register, lease retirement1 on
  construct, returned object0 for every failure. Run:
  `set -euo pipefail; title='typed transaction failure matrix stops and cleans exact owner'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_transaction_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** two narrow try/catch regions: catch register releases storage/rethrows; catch construct starts lease
  retirement/rethrows. Never catch check/build/upload. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_transaction_test.dart test/persistent_packed_instance_storage_test.dart test/persistent_packed_instance_binding_test.dart test/render/persistent_gpu_resource_lifecycle_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Fix: packed構築失敗cleanupを固定`。

### Task 41: concrete immutable Geometry from validated parts (depends Task 40; 55–95 lines)

**Files:** Create `lib/src/geometry/persistent_packed_instance_geometry.dart`; Create
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces concrete class private nonthrowing `_fromParts` and internal
`createPersistentPackedInstanceGeometryFromPartsForTesting({required PersistentPackedInstancePlan plan, required PersistentPackedInstanceStorage storage, required PersistentGpuResourceLease lease, required gpu.Shader Function() defaultShader, required bool doubleSided})`
and `persistentPackedInstanceBindingForTesting(PersistentPackedInstanceGeometry geometry)`. At first instantiation
the concrete class implements `bind`, `draw`, `vertexShader`, bounds, `setLocalBounds`, and every
layout/count/state/retire getter。

**Implementation shape:** `_fromParts` assigns final fields, retains only the typed shader resolver, and creates
Task38 binding delegate. Public `vertexShader` resolves it; the one-line internal accessor returns that same delegate.
`setLocalBounds(vm.Aabb3? aabb, vm.Sphere? sphere)` always throws `UnsupportedError`; both bounds getters use
Task24 fresh copies; bind/draw use production Task37 adapter around the supplied pass。

- [ ] **RED:** internal parts helper creates the concrete class without resolving its throwing test shader;
  its exact binding delegate bind/draws through a recording adapter; `setLocalBounds(null,null)` and nonnull
  arguments throw; mutated returned bounds never alter later copies. Run:
  `set -euo pipefail; title='concrete Geometry from parts implements bind draw and immutable bounds'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** override every abstract member now; no temporary throw except the intentional immutable
  `setLocalBounds` override. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_render_pass_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry coreを追加`。

### Task 42: shared public factory transaction (depends Task 41; 55–100 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/persistent_packed_instance_geometry_test.dart`。

**Interfaces:** Produces Final public API factory and internal exact
`createPersistentPackedInstanceGeometry({required PersistentGpuResourceLifecycle lifecycle, required PersistentPackedGpuBackend backend, required ByteData vertexData, required int vertexCount, required ByteData? indexData, required gpu.IndexType indexType, required ByteData instanceData, required int instanceCount, required VertexLayoutDescriptor vertexLayout, required gpu.Shader vertexShader, required vm.Aabb3 localBounds, required bool doubleSided})`。
Both call Task39 transaction and Task41 `_fromParts`。

**Implementation shape:** public factory delegates with `DevicePersistentPackedGpuBackend()` and the supplied
shader unchanged. The internal helper is the only place that supplies lifecycle check/register, source-capturing
plan/upload, and `_fromParts(defaultShader: () => vertexShader)` construct closures to Task39. There is no second
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
      PersistentPackedInstanceGeometry._fromParts(
        plan: plan,
        storage: storage,
        lease: lease,
        defaultShader: () => vertexShader,
        doubleSided: doubleSided,
      ),
);
```

- [ ] **RED:** source proves the public factory has exactly one call to the backend-injected helper and that helper
  has exactly one call to Task39's transaction; lifecycle rejection event precedes plan/allocation; valid fake
  backend order is check→plan→upload→register→construct; register failure cleanup comes from Task40.
  Run: `set -euo pipefail; title='public Geometry factory shares typed lifecycle transaction'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** public and test paths differ only by backend argument. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/persistent_packed_instance_transaction_test.dart test/persistent_packed_instance_binding_test.dart test/persistent_packed_instance_storage_test.dart test/geometry_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometryをtransaction構築`。

### Task 43: full normal/depth/shadow/selection routes (depends Task 42; 45–90 lines)

**Files:** Modify `lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/persistent_packed_instance_geometry_test.dart`; Modify
`test/render/persistent_gpu_scene_integration_test.dart`。

**Interfaces:** Geometry overrides exact `depthOnlyVertex => null`, `vertexStreamCount => 2`,
`bindsModelTransformInstance => false`, `instancedVertexLayout => copied plan layout`, `isDoubleSided`。

**Implementation shape:** five direct getter overrides only; route behavior is inherited from existing encoders'
null branch and the already-complete Task41 bind implementation。

- [ ] **RED:** assert source contracts in `object_filter.dart`, `shadow_encoder.dart`, and `depth_prepass.dart`
  select `geometry.bind` when `depthOnlyVertex` is null and never select `bindPositionStream`; run the concrete
  Geometry's exact internal binding delegate through four named normal/depth/shadow/selection cases and require
  both slots plus FrameInfo each time. Run:
  `set -euo pipefail; title='depth shadow and selection use packed full bind'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** explicit null override only; never override/call position stream or superclass setters. Run
  geometry + scene integration + `shadow_cache_test.dart` + `spot_shadow_test.dart` +
  Run: `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_geometry_test.dart test/render/persistent_gpu_scene_integration_test.dart test/shadow_cache_test.dart test/spot_shadow_test.dart test/scene_semantics_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Feature: packed Geometry全描画経路を固定`。

### Task 44: exact material vertex variant (depends Task 43; 40–80 lines)

**Files:** Modify `lib/src/material/shader_stage.dart`; Modify
`lib/src/geometry/persistent_packed_instance_geometry.dart`; Modify
`test/shader_material_vertex_test.dart`。

**Interfaces:** Produces `MeshVariant.persistentPackedInstances('persistent_packed_instances')`, exact `fromName`
case, Geometry `materialVertexVariant` same wire name。

**Implementation shape:** append one enum case, add one exact string switch arm before default, and return the
same wire string from Geometry; change no generated fmat code。

- [ ] **RED:** exact enum name/fromName round-trip and Geometry wire name; `setVertexShader(null, variant: ...)`
  accepts the new typed enum without a GPU shader; existing unskinned/skinned/depth and unknown→unskinned remain
  unchanged. Source assertion requires `materialVertexShader` to index `_vertexShaders[kind]`. Run:
  `set -euo pipefail; title='ShaderMaterial keeps persistent packed instance variant exact'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/shader_material_vertex_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** public-only imports take factory tear-off and reference lifecycle/layout/state/retire; source rejects
  every internal symbol/export. Run:
  `set -euo pipefail; title='public Geometry barrel hides every transaction seam'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_public_api_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
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

- [ ] **RED:** source assertions require workflow, logical memory, no fallback/per-frame upload, the explicit
  external-instancing prohibition, #1603/#1604/#1605 and no physical evidence. Run:
  `set -euo pipefail; title='README states one upload and 36-float shader contract'; if out=$(mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_public_api_test.dart --plain-name "$title" 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; test -n "$out"; printf '%s\n' "$out"`。
- [ ] **GREEN:** add only consumer/provenance/deferred boundary. Run:
  `set -euo pipefail; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- flutter test --enable-impeller test/persistent_packed_instance_public_api_test.dart test/render/persistent_gpu_lifecycle_public_api_test.dart test/persistent_packed_instance_geometry_test.dart test/render/persistent_gpu_scene_integration_test.dart test/shader_material_vertex_test.dart; mise exec flutter@4dacd3fc91d96262a33e5c598e17d816f0b35641 -- dart analyze .; git --no-pager diff --check`。
- [ ] **Commit:** `Docs: packed Geometry契約を追加`。

### Top delivery, two-PR stack and immutable handoff (no commit)

```bash
set -euo pipefail
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
stack_json=$(gh stack view --json)
test -n "$stack_json"
jq -e '
  .trunk == "eqmonitor/flutter-4dacd3fc" and
  [.branches[].name] == ["feat/persistent-gpu-lifecycle",
                         "feat/persistent-packed-instance-geometry"] and
  (.branches[0].pr.state == "OPEN") and
  (.branches[1].pr.state == "OPEN") and
  (.branches[1].base == .branches[0].head)
' <<<"$stack_json" >/dev/null
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

**Implementation shape:** add consumer test first; replace only descriptor URL/ref scalars; let one root
`flutter pub get` regenerate both git lock descriptions and preserve their package paths。

- [ ] **RED:** before pin change, test takes lifecycle/Geometry factory tear-offs and checks generation1 zero
  snapshot. Run fail-closed:
  `set -euo pipefail; if out=$(mise exec -- flutter test packages/eqmonitor_map/test/flutter_scene/persistent_instance_public_api_test.dart 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'PersistentPackedInstanceGeometry' <<<"$out"`。
- [ ] **GREEN:** rerun top advertised-ref handoff; modify only URL/ref scalars; run `mise exec -- flutter pub get`,
  never edit lock manually. Run:
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

- [ ] **RED:** fixture happy/wrong descriptor URL calls missing verifier. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh descriptor 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'tool/verify_flutter_scene_pin.sh' <<<"$out"`。
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

- [ ] **RED:** fixture wrong requested ref and wrong resolved-ref currently pass Task48 verifier; lock group expects
  failure labels. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh lock 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'resolved-ref' <<<"$out"`。
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

- [ ] **RED:** matrix covers each descriptor URL/ref/path, each lock URL/ref/resolved-ref/path, short SHA,
  missing field, nonscalar field. Before helper/matrix each corrupt case is unasserted. Run:
  `set -euo pipefail; if out=$(bash scripts/ci/test_verify_flutter_scene_pin.sh corruption 2>&1); then exit 1; else rc=$?; fi; test "$rc" -ne 0; rg -F 'expect_pin_failure' <<<"$out"`。
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
