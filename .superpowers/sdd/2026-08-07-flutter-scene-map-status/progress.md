# Flutter Scene マップ状態確認 — Progress Ledger

Started: 2026-08-07
Goal: `packages/eqmonitor_map` の Flutter Scene 実装の現状を調査し、完了/未完了/リスクを整理する。

## Tasks

- Task 1: Plan/Spec/TODO 達成状況の棚卸し — complete (task-1-report.md)
- Task 2: パッケージ構成・公開API・Scene描画層の実装成熟度 — complete (task-2-report.md)
- Task 3: アプリ本体への統合状況と MapLibre 移行ゲート — complete (task-3-report.md)
- Task 4: テスト/CI/既知不具合・deferred verification — complete (task-4-report.md)
- Task 5: dashmap (bdero) 参考実装の知見抽出 — complete (task-5-dashmap-report.md)
- 統合: status-report-draft.md 作成済み
- 知見記録: docs/knowledge/20260807_dashmap_flutter_scene_reference.md 作成済み (未commit)

## Findings so far

- design / scene spike / mise simplification の PR は merge 済み (#1565, #1566, #1574)。
  base-layer PMTiles 縦切りは実装済みだが partial (#1579, #1580)。
- plan のチェックボックスは3計画とも全件未チェック。進捗判定は merge commit / README / TODO に依存。
- `app` は `eqmonitor_map` に path 依存済みだが、実利用は
  `/settings/debug/eqmonitor-map` のデバッグページ (`BaseMapView`) のみ。
- todo 780 の production surface は 11 件すべて `MapLibreMap` 直接 host のまま。
  partially migrated と呼べる surface は無し。production 切替 feature flag も無し。
- 設計正本の `MapScene`/`MapNode`/reconciler、ラベル、動的 hazard layer、hit test、
  signed sidecar attestation は未実装。
- flood の食い違いは Task 2 で決着。真因は `setCustomAttribute('extrude')` が
  shader へ届かなかったこと。対策 (`texCoords` 経由 + NDC 半線幅換算) はコードに
  取り込み済みだが、**修正後の視覚確認証跡が無い**。README の「未着手」記述は stale。
  → 状態は「修正済み・post-fix visual verification pending」。
- 成熟度判定: foundation / alpha 手前。`FlutterSceneSpike*` は主経路ではなく
  `BaseMapView` が現行の app 向け経路。example のみ spike を表示。
- 設計正本の production API (`EqmonitorMapView` / `MapScene` / controller / reconciler)
  は未実装。現公開 API は `BaseMapView` + `VerifiedPmTilesSource` + limits 群。
- correctness debt: MVT extent が `BaseMapTileGeometry` に伝播せず 4096 固定、
  tile buffer の scissor 無し、miter+butt のみ、ancestor fallback の重複描画。
- toolchain 固定: Flutter `4dacd3fc9…`, flutter_scene `7f71993b7…`, iOS/Android のみ、
  `.fmat` は build hook の Dart Data Asset。

## Notes

Investigation only. Do not modify production code unless a critical correctness bug blocks status reporting.
