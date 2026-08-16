# Theme Settings Back Navigation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** テーマプリセット変更後もテーマ設定画面の戻るボタンを維持し、表示設定へ戻れるようにする。

**Architecture:** 表示設定からテーマ設定への遷移を、URL置換の `go` から履歴追加の `push` に変更する。実際の `GoRouter` と `appThemeProvider` を組み合わせたWidgetテストで、テーマ変更による `MaterialApp.router` 再構築後の戻る操作を検証する。

**Tech Stack:** Flutter、Dart、go_router、Riverpod、flutter_test

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- AppBar に独自の戻るボタンを追加せず、Navigator の履歴と標準 leading を一致させる。
- 既存のテーマ保存ロジックとテーマエディターへの遷移は変更しない。
- 既存の無関係な作業ツリー差分をステージしない。

---

### Task 1: テーマ設定の戻る履歴を保持する

**Files:**
- Modify: `app/lib/feature/settings/features/display_settings/ui/display_settings.dart:40`
- Test: `app/test/feature/settings/features/display_settings/theme_settings_page_test.dart`

**Interfaces:**
- Consumes: `ThemeSettingsRoute.push<void>(BuildContext context)`、`appThemeProvider`
- Produces: 表示設定を戻り先として保持するテーマ設定導線

- [x] **Step 1: プリセット変更後の戻る操作を表すWidgetテストを追加する**

  `GoRouter` にホームと設定配下の階層を登録し、ホームから設定・表示設定を
  `push` してテーマ設定を開く。`JMA Standard` を選択して
  `appThemeProvider` が更新された後、テーマ設定から表示設定・設定へ戻っても
  `BackButton` が存在し、さらにホームへ戻れることを検証する。

- [x] **Step 2: テストを実行して修正前に失敗することを確認する**

  Run from `app/`: `mise exec -- flutter test test/feature/settings/features/display_settings/theme_settings_page_test.dart --plain-name 'テーマ変更後も設定画面からホームへ戻れる'`

  Expected: 設定画面まで戻った時点で `BackButton` が見つからずFAILする。

- [x] **Step 3: テーマ設定への遷移を履歴追加へ変更する**

  ```dart
  onTap: () async => const ThemeSettingsRoute().push<void>(context),
  ```

- [x] **Step 4: 対象テストを再実行して成功を確認する**

  Run from `app/`: `mise exec -- flutter test test/feature/settings/features/display_settings/theme_settings_page_test.dart`

  Expected: 全テストPASS。

- [x] **Step 5: 静的解析と差分検査を実行する**

  Run from `app/`: `mise exec -- dart format --output=none --set-exit-if-changed lib/feature/settings/features/display_settings/ui/display_settings.dart test/feature/settings/features/display_settings/theme_settings_page_test.dart`

  Run from `app/`: `mise exec -- flutter analyze lib/feature/settings/features/display_settings/ui/display_settings.dart test/feature/settings/features/display_settings/theme_settings_page_test.dart`

  Run: `git --no-pager diff --check`

- [ ] **Step 6: 対象ファイルだけをコミットする**

  ```bash
  git add app/lib/feature/settings/features/display_settings/ui/display_settings.dart \
    app/test/feature/settings/features/display_settings/theme_settings_page_test.dart \
    docs/superpowers/plans/2026-08-16-theme-settings-back-navigation.md
  git commit -m "Fix: テーマ変更後の戻る履歴を保持"
  ```
