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

