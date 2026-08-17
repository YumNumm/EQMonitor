# Earthquake History List Settings Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴一覧の背景塗りつぶし設定を反映し、日付見出しを「常に表示」「発生時刻順のときのみ」「表示しない」から選べるようにする。

**Architecture:** 一覧設定へ型安全な表示モードを追加し、表示判定をモデルで完結させる。設定画面はテスト可能な表示コンポーネントへ分離し、一覧は見出し表示時だけ grouped paging、非表示時は flat paging を使う。

**Tech Stack:** Flutter 3.44、Dart 3.11、Riverpod 3、Freezed、json_serializable、paging_view

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- 既存JSONに新規キーがなくても `onlyWhenDateSort` へ復元する。
- 発生時刻順は `EarthquakeSortBy.eventId` の昇順・降順を対象とする。
- 既存の未コミット変更はステージ・編集しない。
- ユーザー指示によりUIテストは対象外とし、モデルの単体テストと静的解析で検証する。

---

### Task 1: 日付見出し表示モード

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`
- Modify: `app/test/feature/earthquake_history/data/earthquake_history_config_test.dart`
- Modify generated: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.freezed.dart`
- Modify generated: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.g.dart`

**Interfaces:** Produces `DateHeaderDisplayMode` and `bool isVisible({required EarthquakeSortBy sortBy})`; imports `earthquake_sort_by.dart` and adds `dateHeaderDisplayMode` to `EarthquakeHistoryListConfig`.

- [x] Add failing tests for the default, JSON round-trip, and `always` / `onlyWhenDateSort` / `never` visibility against `eventId` and `magnitude`.
- [x] Run `mise exec -- flutter test test/feature/earthquake_history/data/earthquake_history_config_test.dart`; expect compile failure because the enum and field do not exist.
- [x] Add `@Default(DateHeaderDisplayMode.onlyWhenDateSort) DateHeaderDisplayMode dateHeaderDisplayMode` and:

```dart
enum DateHeaderDisplayMode {
  always,
  onlyWhenDateSort,
  never;

  bool isVisible({required EarthquakeSortBy sortBy}) => switch (this) {
    .always => true,
    .onlyWhenDateSort => sortBy == EarthquakeSortBy.eventId,
    .never => false,
  };
}
```

- [x] Run `mise exec -- dart run build_runner build --delete-conflicting-outputs`, then rerun the test and expect PASS.
- [x] Commit only model, generated files, and model tests as `Feat: 地震履歴の日付見出し設定を追加`.

### Task 2: 設定画面

**Files:**
- Create: `app/lib/feature/settings/children/config/earthquake_history/earthquake_history_list_config_view.dart`
- Modify: `app/lib/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart`

**Interfaces:** `EarthquakeHistoryListConfigView({required EarthquakeHistoryListConfig config, required Future<void> Function(EarthquakeHistoryListConfig) onChanged})` renders the background switch and a `RadioGroup<DateHeaderDisplayMode>`.

- [x] Implement the view with the existing background `ListTile` / `AppSwitch`, a `ListTile(title: Text('日付見出し'))`, and three `RadioListTile` children labeled `常に表示`, `発生時刻順のときのみ`, `表示しない`; every handler awaits `onChanged`.
- [x] Replace `_EarthquakeHistoryListConfigWidget` with a consumer wrapper that passes the current list config and persists updates through `EarthquakeHistoryConfigNotifier.save`.
- [x] Run static analysis for the view and page wiring.
- [x] Commit the view and page wiring as `Feat: 地震履歴の日付見出し設定UIを追加`.

### Task 3: 一覧への反映

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/earthquake_history_paging_list.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_page.dart`

**Interfaces:** `EarthquakeHistoryPagingList` consumes `EarthquakeHistoryDataSource`, `EarthquakeHistoryParameter`, and `EarthquakeHistoryListConfig`; it returns grouped or flat paging UI and forwards `isFillBackground` to every list tile.

- [x] Extract the current paging sliver into `EarthquakeHistoryPagingList`; choose grouped paging when `dateHeaderDisplayMode.isVisible(sortBy: parameter.sortBy)` is true and flat paging otherwise. Keep date headers sticky only in grouped mode and use a focused private row widget for shared tile/divider rendering.
- [x] Watch `earthquakeHistoryConfigProvider` in `_SliverListBody`, handle loading and errors explicitly, and pass the list config into `EarthquakeHistoryPagingList`.
- [x] Forward `isFillBackground` to every `EarthquakeHistoryListTile` and preserve source ordering with flat paging when headers are hidden.
- [x] Run both config model tests and static analysis for the changed production files.
- [x] Commit the paging component and page wiring as `Fix: 地震履歴一覧設定を表示へ反映`.

### Task 4: Verification and PR

**Files:**
- Modify: `docs/superpowers/plans/2026-08-16-earthquake-history-list-settings.md` (check completed steps)

- [x] Run `mise exec -- dart format` on changed Dart files.
- [x] Run targeted Flutter tests for the new and existing earthquake history config models.
- [x] Run `mise exec -- dart analyze` for changed production Dart files and resolve introduced diagnostics.
- [x] Run `git --no-pager diff --check`, inspect `git --no-pager diff origin/develop...HEAD`, and confirm unrelated working-tree files remain uncommitted.
- [x] Commit the checked plan as `Docs: 地震履歴一覧設定の実装手順を更新`, push `fix/earthquake-history-list-settings`, and create a draft PR targeting `develop` with test evidence.
