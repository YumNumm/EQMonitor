# Remove None Notification Preset Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 通知設定画面のプリセットを「推奨設定」「すべて」「カスタム」の3択にし、「通知しない」は master toggle に一本化する。

**Architecture:** `NotificationPresetSelector` の表示用リストだけを style ごとに分ける。`NotificationPreset.none` とその永続化・適用処理はオンボーディングおよび既存データ互換性のため維持する。

**Tech Stack:** Flutter, Dart, hooks_riverpod, flutter_test

## Global Constraints

- Flutter / Dart コマンドは `mise exec --` 経由で実行する。
- settings style は `recommended`, `all`, `custom` の3件だけを表示する。
- onboarding style は `recommended`, `all`, `custom`, `none` の4件を維持する。
- `NotificationPreset.none`、保存済み `none` 値、preset applier の動作は変更しない。
- 推奨設定とすべての通知条件は変更しない。

---

### Task 1: Style ごとのプリセット一覧を分離する

**Files:**
- Modify: `app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart`

**Interfaces:**
- Consumes: `NotificationPresetSelectorStyle` と既存の `NotificationPreset` enum。
- Produces: settings style の3択表示と onboarding style の従来どおりの4択表示。

- [ ] **Step 1: 表示差を固定する Widget test を追加する**

authorized permission で selector を描画し、次の2ケースを追加する。

```dart
testWidgets('設定画面では通知しないプリセットを表示しない', (tester) async {
  // settings style を描画
  expect(find.text('推奨設定'), findsOneWidget);
  expect(find.text('すべて'), findsOneWidget);
  expect(find.text('カスタム'), findsOneWidget);
  expect(find.text('通知しない'), findsNothing);
});

testWidgets('オンボーディングでは通知しないプリセットを表示する', (tester) async {
  // onboarding style を描画
  expect(find.text('通知しない'), findsOneWidget);
});
```

- [ ] **Step 2: settings のテストが期待どおり失敗することを確認する**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart
```

Expected: settings style で「通知しない」が1件見つかり、`findsNothing` が失敗する。onboarding style の新規テストは成功する。

- [ ] **Step 3: style ごとにプリセット順序を分ける**

`NotificationPresetSelector` の共有 `_presetOrder` を以下の2定数に置き換え、それぞれ対応する子 Widget へ渡す。

```dart
static const _onboardingPresetOrder = <NotificationPreset>[
  NotificationPreset.recommended,
  NotificationPreset.all,
  NotificationPreset.custom,
  NotificationPreset.none,
];

static const _settingsPresetOrder = <NotificationPreset>[
  NotificationPreset.recommended,
  NotificationPreset.all,
  NotificationPreset.custom,
];
```

- [ ] **Step 4: selector と preset 適用処理のテストを確認する**

Run:

```bash
mise exec -- flutter test app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart
```

Expected: 全テスト成功。

- [ ] **Step 5: 変更ファイルを format・analyze する**

Run:

```bash
mise exec -- dart format --output=none --set-exit-if-changed app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart
mise exec -- flutter analyze app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart
```

Expected: format 差分なし、analyzer issue なし。

- [ ] **Step 6: 実装をコミットする**

```bash
git add app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart
git commit -m "fix: 通知設定から通知しないプリセットを削除"
```
