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

