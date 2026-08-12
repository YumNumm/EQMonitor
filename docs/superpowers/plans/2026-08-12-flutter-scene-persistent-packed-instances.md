# Flutter Scene Persistent Packed Instances Implementation Plan

> **For Codex:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` and
> `superpowers:subagent-driven-development`; use `gh-stack` only with its
> non-interactive flags. Stop after every PR in this plan has been created.

**Goal:** Issue #1602 向けに、static packed instance data を一度だけ GPU へ
upload し、GPU submission 完了まで安全に retire できる汎用 Geometry を
`YumNumm/flutter_scene` fork へ追加する。EQMonitor は公開 API だけを使い、fork の
immutable commit SHA へ依存を固定する。

**Architecture:** EQMonitor の現行 Flutter Scene pin を compatibility base とし、
submission tracker の watermark に連動する resource registry、その上の明示的な
context generation lifecycle、最後に immutable な 2-stream Geometry を積む。
Geometry は base vertex と instance record を persistent device buffer に初回だけ
書き込み、描画時は bind と小さな `FrameInfo` uniform 更新だけを行う。更新は in-place
で行わず、旧 Geometry を retire して新規作成する。

**Tech Stack:** Flutter `4dacd3fc91d96262a33e5c598e17d816f0b35641`
(3.47.0-1.0.pre-97)、Dart 3.14.0-29.0.dev、Flutter GPU/Impeller、
Flutter Scene `7f71993b7e2a0ab1d2f59726a406098709be7291`、Dart/Flutter test、
`mise exec --`、`gh stack`。

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

## 3. 固定する公開 API と不変条件

`package:flutter_scene/scene.dart` から次だけを export する。EQMonitor は
`package:flutter_scene/src/...`、`package:flutter_gpu/...`、internal annotation 付き API を
import/call しない。

```dart
enum PersistentGpuResourceLifecycleState { active, invalidated, disposed }
enum PersistentGpuResourceState { active, retirementPending, retired }

final class PersistentGpuMemorySnapshot {
  final PersistentGpuResourceLifecycleState lifecycleState;
  final int contextGeneration;
  final int activeResourceCount;
  final int retiringResourceCount;
  final int activeTotalBytes;
  final int retiringTotalBytes;
  final int activeInstanceBytes;
  final int retiringInstanceBytes;
  final int latestSubmission;
  final int completedThrough;
}

final class PersistentGpuResourceLifecycle {
  PersistentGpuResourceLifecycle();
  int get contextGeneration;
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

API review 中に引数名を変える場合も、次の semantics は変えない。

1. `vertexLayout` は slot 0 が per-vertex、slot 1 が per-instance のちょうど 2 buffers。
   attribute 名、offset、stride は既存 `VertexLayoutDescriptor.toGpuLayout()` の検証も通す。
2. `vertexCount` / `instanceCount` は正数。各 ByteData の長さは
   `count * correspondingStride` と完全一致させ、余剰/不足、0 byte、index width 不整合は
   `ArgumentError` とする。勝手な切り捨てや空 Geometry fallback はしない。
3. bounds は caller が全 instance を pack した同じ snapshot から算出して必須指定する。
   Geometry 側は200万件を走査せず、AABB から bounding sphere だけを定数時間で導く。
4. base vertex と instance は同じ non-index host-visible buffer へ置き、instance offset は
   16-byte alignment する。index は WebGL が巨大 buffer を element/non-element 用に複製
   しないよう別 buffer とする。各 source bytes は constructor 内で一度だけ `overwrite`
   し、まとめて一度 `flush` する。caller の ByteData は保持しない。
5. `bind` は persistent views と小さい `FrameInfo`（camera/model matrix、camera position）だけを
   bind する。`instanceTransients.emplace`、instance 全件 copy、camera change による再 upload
   を禁止する。data change は旧 object の `retire()` + 新 object の生成で表す。
6. Geometry は model transform を `FrameInfo` uniform から読むため
   `bindsModelTransformInstance == false`。独自 `MeshVariant.persistentPackedInstances` を追加し、
   material vertex override が誤って unskinned variant に fallback しないようにする。
7. `retire()`、`invalidateContext()`、`dispose()` は同期的に future bind/draw を拒否し、同じ
   `Future` を返す idempotent operation とする。最後に参照した submission の completion
   watermark を越えるまでは buffer references を保持する。
8. generation は 1 から開始する。`invalidateContext()` は active resources をすべて retire
   して state を即時 invalidated にし、`recreateContext()` は retirement 完了後だけ generation
   を increment して active へ戻る。古い Geometry は terminal のまま再利用しない。
9. completion callback が来ない場合は resource と recreate を保留する。CPU frame 数や固定
   delay で安全と推測しない。Flutter GPU が自動 context-loss event を公開していないため、
   lifecycle 呼び出しは adapter owner の明示操作であり、自動復旧済みとは主張しない。
10. snapshot の bytes は fork が保持する logical allocation/reference の観測値であり、driver の
    resident bytes や即時解放を表さない。active/retiring と instance/total を分け、5分 memory
    gate で「増加理由を説明できる」値を提供する。

## 4. Repository と PR stack

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

### Task 0: fork 作成と clean worktree を準備する

**Files:** 変更なし。

**Step 1: authority gate**

owner/admin が `YumNumm/flutter_scene` を `bdero/flutter_scene` の fork として作成する。
agent が実行する場合は org repository 作成の明示許可を得てからにする。作成後、次を確認する。

```bash
gh repo view YumNumm/flutter_scene \
  --json nameWithOwner,parent,defaultBranchRef,viewerPermission
```

期待: `parent.nameWithOwner == "bdero/flutter_scene"` かつ push 権限あり。repository が見えない、
parent が異なる、push 権限がない場合は blocked とし、代替 repository を推測しない。

**Step 2: fork worktree と compatibility trunk**

clone/worktree 先は active EQMonitor worktree の外に置く。fork clone の `upstream` が bdero、
`origin` が YumNumm であることを確認し、remote branch を明示的に作る。

```bash
git fetch upstream master
git cat-file -e 7f71993b7e2a0ab1d2f59726a406098709be7291^{commit}
git branch eqmonitor/flutter-4dacd3fc \
  7f71993b7e2a0ab1d2f59726a406098709be7291
git push origin eqmonitor/flutter-4dacd3fc:eqmonitor/flutter-4dacd3fc
git config rerere.enabled true
git config remote.pushDefault origin
gh stack init --base eqmonitor/flutter-4dacd3fc \
  feat/persistent-gpu-lifecycle feat/persistent-packed-instance-geometry
```

`gh stack init` 後は bottom の `feat/persistent-gpu-lifecycle` へ checkout して Task 1 を開始する。
既存 branch が見つかった場合は SHA/owner を確認し、上書きや force push をしない。

**Step 3: pinned toolchain と baseline**

fork 自体は Flutter を pin していないため、全 Flutter/Dart command は EQMonitor の mise 環境を
注入した shell 内で実行する。以下の `<fork>` は絶対 path へ置換し、文字列のまま実行しない。

```bash
cd /path/to/EQMonitor
mise exec -- bash -c 'cd <fork> && flutter --version --machine'
mise exec -- bash -c 'cd <fork> && flutter pub get'
mise exec -- bash -c \
  'cd <fork>/packages/flutter_scene && flutter test --enable-impeller \
   test/render/frame_transients_test.dart'
```

version JSON の framework SHA が `4dacd3fc...` でなければ中断する。baseline failure は既存失敗と
今回差分を分離して PR body に記録し、成功扱いにしない。実機、Simulator、smoke-render E2E は
今回のユーザー指定により実行しない。

### Task 1: submission completion listener を追加する（fork bottom）

**Files:**
- Modify: `packages/flutter_scene/lib/src/render/frame_transients.dart`
- Test: `packages/flutter_scene/test/render/frame_transients_test.dart`

**Step 1: failing tests**

`GpuSubmissionTracker` に completion listener の契約を追加する。out-of-order で `b` が先に
終わっても watermark 0、`a` 完了時に watermark `b`、duplicate/unknown completion では通知
しないことを test する。listener が見る値は completed id ではなく更新後の
`completedThrough` とする。

**Step 2: focused test を RED で確認**

```bash
flutter test --enable-impeller test/render/frame_transients_test.dart \
  --plain-name 'completion listeners observe the contiguous watermark'
```

**Step 3: minimal implementation**

`addCompletionListener(void Function(int completedThrough) listener)` を追加し、`complete(id)` は
pending に存在した id を削除した場合だけ listener へ更新後 watermark を通知する。既存の
before-submit listener と record/submit の順序を変えない。

**Step 4: GREEN、commit、push**

```bash
flutter test --enable-impeller test/render/frame_transients_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/src/render/frame_transients.dart \
  packages/flutter_scene/test/render/frame_transients_test.dart
git commit -m 'Feature: GPU submission完了通知を追加'
git push
```

### Task 2: completion-aware registry と memory snapshot を作る（fork bottom）

**Files:**
- Create: `packages/flutter_scene/lib/src/render/persistent_gpu_resources.dart`
- Create: `packages/flutter_scene/test/render/persistent_gpu_resources_test.dart`

**Step 1: pure state-machine tests**

実 GPU buffer ではなく release callback を持つ allocation record で次を test する。

- 未使用 resource の retire は即時 release。
- bind 済み resource は次 submission に stamp され、completion 前は release されない。
- 複数 submission/out-of-order completion は最大 `lastSubmission` の watermark まで待つ。
- retire request 後の mark-used は `StateError`。
- previous frame に mark されたが submission がなかった record は `beginFrame()` で unstamped
  と判定され、安全に release できる。
- snapshot が active/retiring count、total/instance bytes、latest/completed id を正しく分離する。
- `retire()` は同一 Future を返し、release callback は一度だけ呼ぶ。

**Step 2: RED を確認して registry を実装**

`PersistentGpuResourceRegistry` は1個の before-submit listener と1個の completion listener を
tracker へ登録する。`markUsed` は Set に入れ、before-submit で id を stamp、completion で
`lastSubmission <= completedThrough` の retiring records だけ release する。固定 frames-in-flight
や timer は入れない。public snapshot value types と state enum も同じ file に置くが、registry
自体は `scene.dart` から export しない。

**Step 3: focused tests、commit、push**

```bash
flutter test --enable-impeller test/render/persistent_gpu_resources_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/src/render/persistent_gpu_resources.dart \
  packages/flutter_scene/test/render/persistent_gpu_resources_test.dart
git commit -m 'Feature: 永続GPU resource retirementを追加'
git push
```

### Task 3: public lifecycle と context generation を積む（fork bottom）

**Files:**
- Modify: `packages/flutter_scene/lib/src/render/persistent_gpu_resources.dart`
- Modify: `packages/flutter_scene/lib/src/scene.dart`
- Modify: `packages/flutter_scene/lib/scene.dart`
- Test: `packages/flutter_scene/test/render/persistent_gpu_resources_test.dart`

**Step 1: lifecycle tests**

initial active/generation 1、invalidate で future use 拒否と全 retire、retirement 中の recreate
拒否、完了後 recreate で generation +1、old record の再登録/利用拒否、dispose terminal、各操作の
idempotence を test する。2 lifecycle が同じ global registry を使っても count/generation が
混線しないことも含める。

**Step 2: lifecycle と frame boundary**

`PersistentGpuResourceLifecycle` を実装し、Geometry 用 registration は `@internal` として
consumer の supported surface から除外する。`Scene` の既存 transients `beginFrame()` と同じ
位置で global registry の `beginFrame()` を一度呼び、前 frame の unsubmitted marks を閉じる。
automatic context-loss detection や buffer 強制破棄 API は追加しない。

**Step 3: export、GREEN、commit、push**

`scene.dart` の show-list には lifecycle、2 state enums、snapshot だけを追加する。

```bash
flutter test --enable-impeller test/render/frame_transients_test.dart \
  test/render/persistent_gpu_resources_test.dart
dart analyze packages/flutter_scene
git --no-pager diff --check
git add packages/flutter_scene/lib/src/render/persistent_gpu_resources.dart \
  packages/flutter_scene/lib/src/scene.dart packages/flutter_scene/lib/scene.dart \
  packages/flutter_scene/test/render/persistent_gpu_resources_test.dart
git commit -m 'Feature: GPU context generationを公開'
git push
```

### Task 4: lifecycle PR を検証して公開する（fork bottom PR）

**Files:**
- Modify: `packages/flutter_scene/README.md`

**Step 1: contract documentation**

README に lifecycle state diagram、`invalidateContext → await → recreateContext` の順序、
completion が来ない場合は fail-closed であること、snapshot が logical bytes であることを書く。
「context loss を自動検知」「driver memory を即時 free」とは書かない。

**Step 2: non-device verification**

```bash
dart format --output=none --set-exit-if-changed \
  packages/flutter_scene/lib packages/flutter_scene/test
dart analyze packages/flutter_scene
cd packages/flutter_scene
flutter test --enable-impeller
```

すべて Task 0 の pinned mise shell から実行する。GPU unavailable による既存 conditional skip は
skip として記録し、GPU pass に読み替えない。failure が今回差分起因なら PR 作成前に修正する。

**Step 3: commit、push、bottom PR**

```bash
git add packages/flutter_scene/README.md
git commit -m 'Docs: 永続GPU lifecycle契約を記載'
git push
gh stack submit --auto --open --remote origin
gh stack view --json
```

PR body の Remaining tasks に必ず次を残す。

- stacked geometry PR で persistent packed upload/bind を追加する。
- top commit を EQMonitor の固定 dependency へ渡す。
- Flutter GPU 自動 context-loss signal と実 resident-memory reclaim は未観測。
- #1603/#1604/#1605、特に #1604 の物理端末 30fps/5分 gate は未実施。
- 欠落している 2026-08-07 canonical issue spec の provenance 回収。

### Task 5: packed input contract を test-first で作る（fork top）

**Files:**
- Create: `packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart`
- Create: `packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart`

**Step 1: top branch を追加**

bottom PR の HEAD が clean/pushed であることを確認してから追加する。

```bash
gh stack checkout feat/persistent-gpu-lifecycle
gh stack add feat/persistent-packed-instance-geometry
```

**Step 2: pure validation tests**

GPU 初期化より前に検証できる upload plan を file 内に分離し、次を test する。

- exactly two slots、slot 0 vertex/slot 1 instance の happy path。
- duplicate attribute、attribute end > stride、誤 step mode を拒否。
- vertex/instance byte length の不足と余剰、zero/negative count を拒否。
- int16/int32 index byte alignment を拒否し、index count を正しく導出。
- base data 後の instance offset は16-byte aligned、logical padding/total bytes が正確。
- overflow や不正 bounds（NaN/infinity/min > max）を upload 前に拒否。

**Step 3: RED の後に最小 validation を実装**

`VertexLayoutDescriptor.toGpuLayout()` の既存検証を再利用し、同じ attribute 検査を複製しない。
validation failure 後に lifecycle へ resource が登録されていないことも確認する。

**Step 4: focused GREEN、commit、push**

```bash
flutter test --enable-impeller \
  test/persistent_packed_instance_geometry_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart \
  packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart
git commit -m 'Feature: packed instance入力検証を追加'
git push
```

### Task 6: immutable buffer upload と retirement を接続する（fork top）

**Files:**
- Modify: `packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart`
- Modify: `packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart`

**Step 1: GPU-gated upload tests**

既存 test の `_gpuAvailable()` pattern で、GPU がある場合だけ次を確認する。

- constructor 後の snapshot が instance exact bytes、padding/index を含む total bytes を示す。
- source ByteData を constructor 後に変更しても resource metadata は変化しない。
- 未描画 `retire()` は即時 retired、snapshot count/bytes は 0。
- overwrite failure を test seam で発生させると、未登録のまま `StateError` となり fallback しない。

GPU がない runner では明示 skip とする。upload 回数の重要な invariant は internal allocator seam
へ fake を入れ、base once、instance once、index 0/1、flush once を pure test でも固定する。

**Step 2: upload storage**

validation 完了後にだけ non-index buffer を確保し、base を offset 0、instance を aligned offset
へ各1回 overwrite する。index があれば別 buffer へ1回 overwrite。全 return value を検査し、
失敗時は registration 前に references を落として throw する。成功後に lifecycle generation と
total/instance bytes を registry へ登録する。

**Step 3: focused GREEN、commit、push**

```bash
flutter test --enable-impeller \
  test/persistent_packed_instance_geometry_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart \
  packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart
git commit -m 'Feature: packed instanceを永続GPU bufferへupload'
git push
```

### Task 7: Geometry bind/draw と fail-closed state を実装する（fork top）

**Files:**
- Modify: `packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart`
- Modify: `packages/flutter_scene/lib/src/material/shader_stage.dart`
- Modify: `packages/flutter_scene/lib/src/material/shader_material.dart`
- Modify: `packages/flutter_scene/test/shader_material_vertex_test.dart`
- Modify: `packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart`

**Step 1: rendering contract tests**

`MeshVariant.persistentPackedInstances` が unknown/unskinned へ collapse せず、明示設定した shader
だけを返すことを test する。Geometry の active/current generation check、retirementPending/
retired/old generation の bind/draw 拒否は GPU 非依存 state method で test する。

**Step 2: bind/draw**

`vertexStreamCount == 2`、`bindsModelTransformInstance == false`、provided layout、provided
vertex shader、required `doubleSided` を override する。bind 順序は lifecycle current check、
registry `markUsed`、slot 0 vertex、slot 1 instance、optional index、`FrameInfo` uniform とする。
draw は supplied vertex/index count と immutable instance count だけを使い、引数の外部
`instanceCount` で packed record 数を変更させない。

material-less depth/shadow pass も instance slot が必要なため position-only shortcut を返さず、
同じ packed layout/shader を使う。custom shader は `FrameInfo` と必要な `v_*` outputs を満たす
契約を dartdoc に記載する。

**Step 3: GREEN、commit、push**

```bash
flutter test --enable-impeller test/shader_material_vertex_test.dart \
  test/persistent_packed_instance_geometry_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart \
  packages/flutter_scene/lib/src/material/shader_stage.dart \
  packages/flutter_scene/lib/src/material/shader_material.dart \
  packages/flutter_scene/test/shader_material_vertex_test.dart \
  packages/flutter_scene/test/persistent_packed_instance_geometry_test.dart
git commit -m 'Feature: packed instance Geometryを描画'
git push
```

### Task 8: public export と consumer-facing example を追加する（fork top）

**Files:**
- Modify: `packages/flutter_scene/lib/scene.dart`
- Modify: `packages/flutter_scene/README.md`
- Create: `packages/flutter_scene/test/persistent_packed_instance_public_api_test.dart`

**Step 1: public-only compile test**

test は `dart:typed_data`、`vector_math`、`package:flutter_scene/scene.dart`、
`package:flutter_scene/gpu.dart` だけを import する。lifecycle/snapshot、2-slot descriptor、Geometry
constructor type、retire API が解決し、`src/` import が不要なことを compile で固定する。

**Step 2: README example**

24-byte instance record の例を使い、CPU pack → Geometry 1回生成 → camera draw → data revision
変更時 retire/replace → lifecycle invalidate/recreate の順を記載する。サンプルに per-frame full
scan、固定 delay、例外時の標準 Geometry fallback を入れない。

**Step 3: focused GREEN、commit、push**

```bash
flutter test --enable-impeller \
  test/persistent_packed_instance_public_api_test.dart
git --no-pager diff --check
git add packages/flutter_scene/lib/scene.dart packages/flutter_scene/README.md \
  packages/flutter_scene/test/persistent_packed_instance_public_api_test.dart
git commit -m 'Feature: packed instance公開APIを追加'
git push
```

### Task 9: fork top PR を検証し、immutable SHA を引き渡す

**Files:** 変更なし（検証と PR metadata のみ）。

**Step 1: forbidden-path audit**

```bash
rg -n 'instanceTransients\.emplace|List<Matrix4>|Future\.delayed|Timer\(' \
  packages/flutter_scene/lib/src/geometry/persistent_packed_instance_geometry.dart \
  packages/flutter_scene/lib/src/render/persistent_gpu_resources.dart
```

期待: 0件。さらに constructor 以外から instance source の `overwrite`/copy が呼ばれず、
retirement callback だけが buffer references を clear することを diff review する。

**Step 2: fork full non-device gate**

```bash
dart format --output=none --set-exit-if-changed \
  packages/flutter_scene/lib packages/flutter_scene/test
dart analyze packages/flutter_scene
cd packages/flutter_scene
flutter test --enable-impeller
```

テスト件数、pass/fail/skip、Flutter framework/engine SHA を保存する。device/simulator/E2E と
#1604 の2M performance gate はこの PR の合格証拠に含めない。

**Step 3: stacked PR submit と SHA capture**

```bash
gh stack submit --auto --open --remote origin
gh stack view --json
git status --short
git rev-parse HEAD
```

`gh stack view --json` で bottom/base と top/base が設計通りか、両 PR が OPEN かを確認する。
top HEAD SHA は full 40 chars で記録し、EQMonitor pin の `ref` にだけ使う。branch 名、tag、短縮
SHA は dependency に使わない。

top PR body の Remaining tasks には bottom PR と同じ未完了事項に加え、次を書く。

- EQMonitor pubspec/lock/README をこの top commit へ固定する PR。
- EQMonitor adapter での実利用は #1604、scene lifecycle wiring は #1603。
- physical iPhone 13 相当での 30fps/5分 memory evidence は #1604 まで明示 defer。
- current upstream master `ed04205...` への forward-port と upstream 提案は別作業。

### Task 10: EQMonitor pin branch を既存 stack の上に作る

**Files:** 変更なし。

**Step 1: clean worktree**

active seismicity worktree を再利用しない。`origin/feat/seismicity-pmtiles-decoder` を fetch し、
その immutable HEAD（開始時に記録）から
`feat/seismicity-flutter-scene-fork-pin` worktree を作る。既存同名 branch がある場合は owner/SHA を
確認し、上書きしない。

**Step 2: stack metadata を保つ**

まず #1620 が GitHub stack に属するか非対話で確認する。属する場合は stack number に新 branch
を append する。属さない場合だけ、#1620 の現在 base を明示して link する。

```bash
gh stack checkout 1620
gh stack view --json
# existing stack:
gh stack link <stack-number> feat/seismicity-flutter-scene-fork-pin \
  --remote origin
# no existing stack:
gh stack link --base feat/seismicity-pmtiles-network-reader \
  1620 feat/seismicity-flutter-scene-fork-pin --remote origin
```

`<stack-number>` は JSON の実値へ置換する。#1620 の base を default `develop` へ変更しない。
branch に commit がない段階で `link` が PR を作ろうとする場合は、Task 11 完了後まで link を
遅らせる。

### Task 11: fork URL/SHA と lockfile を atomic に更新する（EQMonitor top）

**Files:**
- Modify: `packages/eqmonitor_map/pubspec.yaml`
- Modify: `packages/eqmonitor_map/example/pubspec.yaml`
- Modify: `pubspec.lock`

**Step 1: dependency descriptors**

package の `flutter_scene`、override `scene`、example の `flutter_scene` をすべて
`https://github.com/YumNumm/flutter_scene.git` と Task 9 の top full SHA へ更新する。同じ
monorepo の `packages/flutter_scene` / `packages/scene` path は維持する。

**Step 2: resolver だけで lock を生成**

手編集せず root で `mise exec -- flutter pub get` を実行する。example は workspace member のため
別 lockfile を新規作成しない。root lock の両 package が同じ URL/ref/resolved-ref か確認する。

```bash
mise exec -- flutter pub get
rg -n 'YumNumm/flutter_scene|resolved-ref|7f71993|bdero/flutter_scene' \
  packages/eqmonitor_map/pubspec.yaml \
  packages/eqmonitor_map/example/pubspec.yaml pubspec.lock
```

期待: dependency 現役3箇所と lock 2 entries は fork/full SHA、旧 URL/SHA は0件。

**Step 3: commit、push**

```bash
git --no-pager diff --check
git add packages/eqmonitor_map/pubspec.yaml \
  packages/eqmonitor_map/example/pubspec.yaml pubspec.lock
git commit -m 'Package: Flutter Scene fork SHAへ固定'
git push -u origin feat/seismicity-flutter-scene-fork-pin
```

