# 類似地震 UI 機能 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細画面に「類似地震」Card と全画面一覧を追加し、類似度を A→E グレード + 5セルゲージで表示する。

**Architecture:** 既存の `earthquake_history` feature に従い、API レスポンス(`SimilarEarthquakeResponse`)を app モデル(`SimilarEarthquakeGroup`)へ拡張変換 → Repository メソッド → Riverpod FutureProvider(family) → UI(Card / 全画面 Page)。タイルは既存 `EarthquakeHistoryListTile` を再利用。

**Tech Stack:** Flutter, Riverpod (codegen), Freezed, go_router (TypedGoRoute), flutter_hooks。

## Global Constraints

- Dart: `melos run analyze` が警告ゼロで通ること。
- Formatting: `dart format`。
- Imports: cross-package は package import。
- Generated files (`*.g.dart`, `*.freezed.dart`) はコミットする。注釈追加後に `melos run generate`。
- グレード閾値: A:`score < 50` / B:`50 ≤ score < 100` / C:`100 ≤ score < 200` / D:`200 ≤ score < 350` / E:`350 ≤ score`（500超も E）。
- ゲージ点灯セル数: A=5, B=4, C=3, D=2, E=1。点灯=グレード色、消灯=薄グレー。
- 空/エラー時は Card 非表示（`SizedBox.shrink()`）。

---

### Task 1: SimilarityGrade（グレード分類ロジック）
- score → A〜E、litCells(5..1)、label、color を持つ enum。境界値ユニットテスト。

### Task 2: SimilarEarthquakeGroup モデル + 変換拡張
- `{representative, score, groupedEarthquakes}` freezed + `grade` getter + `api.SimilarEarthquakeItem.toSimilarEarthquakeGroup`。

### Task 3: Repository メソッド + Provider
- `fetchSimilarEarthquakes(eventId)` + `similarEarthquakesProvider(eventId)` (FutureProvider family, codegen)。

### Task 4: SimilarEarthquakeGauge widget
- 5セル + グレード文字。点灯/消灯セルに Key を付与し widget テスト。

### Task 5: SimilarEarthquakeTile widget
- 既存 `EarthquakeHistoryListTile` 再利用 + ゲージ併記。タップで詳細遷移。

### Task 6: SimilarEarthquakeCard widget
- 上位3件表示、3件超で「もっと見る」→ 全画面。空/エラーは非表示。

### Task 7: SimilarEarthquakePage（全画面 + toggle展開）
- 全グループ一覧、代表行に toggle、配下に groupedEarthquakes。子0件は toggle 非表示。

### Task 8: ルート追加 + 詳細画面に Card 配置 + 全体生成/検証
- `SimilarEarthquakeRoute`(path: `/earthquake-history-details/:eventId/similar`) + Column 末尾に Card + codegen + analyze + test。

詳細な手順・コードは設計書(`docs/superpowers/specs/2026-06-27-similar-earthquakes-ui-design.md`)とコミット履歴に従う。
