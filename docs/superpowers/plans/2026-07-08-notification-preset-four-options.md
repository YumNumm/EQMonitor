# Notification Preset Four Options Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** オンボーディングと設定画面の通知プリセットを4択（推奨設定 / すべて / カスタム / 通知しない）に拡張し、OS通知権限・重大な通知権限に応じた選択制御を実装する。

**Architecture:** `NotificationPreset` enum を4値に拡張し、OS権限 Provider・`NotificationPresetApplier` Action・共有 `NotificationPresetSelector` UI を新設。オンボーディングと設定画面の両方が共有コンポーネントを利用する。

**Tech Stack:** Flutter 3.44 / Dart ^3.11、Riverpod 3、Firebase Messaging、flutter_hooks、mise exec 経由の flutter/dart コマンド

**Spec:** `docs/superpowers/specs/2026-07-08-notification-preset-four-options-design.md`

## Global Constraints

- Flutter/Dart コマンドは常に `mise exec --` 経由
- 生成ファイル（`*.g.dart`）は直接編集しない。`dart run build_runner build --delete-conflicting-outputs` で再生成
- `dynamic` / `any` / `Object` 型は `Map<String,dynamic>` 以外禁止
- `!` 演算子禁止。HookWidget / HookConsumerWidget を使用
- Widget 内プライベートメソッド禁止。Action クラスに切り出し、`ref`/`context` はメソッド引数で渡す
- top-level 関数禁止
- プリセット表示順: 推奨設定 → すべて → カスタム → 通知しない
- OS権限 `authorized`/`provisional` のみ4択可能。`denied`/`notDetermined` は **通知しない** のみ
- 無効プリセットタップ時ダイアログ: タイトル「通知権限が無効です」、本文「通知を受け取るには、通知の許可が必要です。許可しますか？」
- 重大通知リンク文言: 「重大な通知が許可されていません」（`Text.rich` + `TapGestureRecognizer`）
- 重大通知ダイアログ: タイトル「重大な通知が許可されていません」、本文「緊急地震速報(警報)を確実に受け取るには、重大な通知の許可が必要です。許可しますか？」
- 推奨設定: `putCurrentLocation(eewMinIntensity: JmaIntensity.four, earthquakeMinIntensity: JmaIntensity.one, eewEnabled: true, earthquakeEnabled: true)` + `notificationEnabled: true`
- すべて: 上記 + `putNationwide(eewMinIntensity: defaultNotificationSlotMinIntensity, earthquakeMinIntensity: defaultNotificationSlotMinIntensity, eewEnabled: true, earthquakeEnabled: true)` + `notificationEnabled: true`
- 通知しない: `notificationEnabled: false`、スロット作成しない（既存スロット削除しない）
- 移行ユーザー `_MigratedNotificationSettingsStepPage` は変更しない
- コミットメッセージ: 英語prefix + 日本語1行説明

---

### Task 1: NotificationPreset enum 拡張と Notifier 永続化

**Files:**
- Modify: `app/lib/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart`
- Modify: `app/lib/feature/onboarding/ui/model/onboarding_permission_status.dart`（`_NotificationPreset` 削除）
- Test: `app/test/feature/settings/features/notification_settings/notification_preset_notifier_test.dart`

**Interfaces:**
- Consumes: 既存 `SharedPreferencesKey.notificationPreset`
- Produces:
  ```dart
  enum NotificationPreset { recommended, all, custom, none }
  // notificationPresetProvider — AsyncNotifier<NotificationPreset>
  // select(NotificationPreset preset) => Future<void>
  // build(): custom→custom, all→all, none→none, その他→recommended
  ```

- [ ] **Step 1: Write failing tests**

```dart
// notification_preset_notifier_test.dart
test('loads all and none from preferences', () async { ... });
test('defaults unknown values to recommended', () async { ... });
```

- [ ] **Step 2: Run test — expect FAIL**

Run: `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/notification_preset_notifier_test.dart -v`

- [ ] **Step 3: Implement enum + notifier + remove _NotificationPreset**

- [ ] **Step 4: Run build_runner**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 5: Run tests — expect PASS**

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/settings/features/notification_settings/data/notifier/ \
  app/lib/feature/onboarding/ui/model/onboarding_permission_status.dart \
  app/test/feature/settings/features/notification_settings/notification_preset_notifier_test.dart
git commit -m "feat: NotificationPresetを4値に拡張"
```

---

### Task 2: OS 通知権限 Provider

**Files:**
- Create: `app/lib/core/provider/notification/os_notification_permission_provider.dart`
- Create: `app/lib/core/provider/notification/os_notification_permission.dart`（extension/model）
- Test: `app/test/core/provider/notification/os_notification_permission_test.dart`

**Interfaces:**
- Consumes: `firebaseMessagingProvider`, `NotificationSettings` from FCM
- Produces:
  ```dart
  @riverpod
  Future<OsNotificationPermission> osNotificationPermission(Ref ref);

  class OsNotificationPermission {
    bool get isOsNotificationGranted; // authorized || provisional
    bool get isCriticalAlertSupported; // criticalAlert != notSupported
    bool get isCriticalAlertGranted; // criticalAlert == enabled
    AuthorizationStatus get authorizationStatus;
  }
  ```

- [ ] **Step 1–6:** TDD で Provider 実装、build_runner、テスト、コミット

Run tests: `cd app && mise exec -- flutter test test/core/provider/notification/os_notification_permission_test.dart -v`

Commit: `feat: OS通知権限Providerを追加`

---

### Task 3: NotificationPresetApplier Action

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/data/action/notification_preset_applier.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_preset_applier_test.dart`

**Interfaces:**
- Consumes: `notificationSlotsProvider.notifier`, `generalNotificationSettingsProvider.notifier`, `notificationPresetProvider.notifier`
- Produces:
  ```dart
  @riverpod
  NotificationPresetApplier notificationPresetApplier(Ref ref);

  class NotificationPresetApplier {
    Future<void> apply(NotificationPreset preset);
    // recommended/all/none: preset保存 + API
    // custom: putCurrentLocationのみ（preset保存は呼び出し側）
  }
  ```

- [ ] **Step 1–6:** TDD。各 preset のモック検証。コミット `feat: NotificationPresetApplierを追加`

---

### Task 4: 権限ダイアログ

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/ui/dialog/notification_permission_dialog.dart`

**Interfaces:**
- Consumes: `firebaseMessagingProvider`, `Geolocator.openAppSettings()` or `app_settings`
- Produces:
  ```dart
  Future<void> showOsNotificationPermissionDialog(BuildContext context, WidgetRef ref);
  Future<void> showCriticalAlertPermissionDialog(BuildContext context, WidgetRef ref);
  ```

- [ ] **Step 1:** ダイアログ実装（`showDialog` + `AlertDialog`）
- [ ] **Step 2:** `requestPermission(criticalAlert: true)` 後 `ref.invalidate(osNotificationPermissionProvider)`
- [ ] **Step 3:** `deniedForever` 時は「設定を開く」
- [ ] **Step 4:** Commit `feat: 通知権限ダイアログを追加`

---

### Task 5: NotificationPresetSelector 共有 UI

**Files:**
- Create: `app/lib/feature/settings/features/notification_settings/ui/component/notification_preset_selector.dart`
- Test: `app/test/feature/settings/features/notification_settings/notification_preset_selector_test.dart`

**Interfaces:**
- Consumes: `OsNotificationPermission`, `NotificationPreset`, dialog functions from Task 4
- Produces:
  ```dart
  enum NotificationPresetSelectorStyle { onboarding, settings }

  class NotificationPresetSelector extends HookConsumerWidget {
    const NotificationPresetSelector({
      required this.selectedPreset,
      required this.onChanged,
      required this.style,
      this.onCustomSettingsTap,
    });
  }
  ```

**Behavior:**
- 4カード/タイルを表示（順序: 推奨→すべて→カスタム→通知しない）
- OS権限オフ: 推奨/すべて/カスタムは `enabled: false` 相当の見た目、タップで OS ダイアログ
- OS権限オフ + 他プリセット選択中: `useEffect` で `none` に自動切り替え
- 推奨/すべて選択中 + criticalAlert未許可(iOS): カード下部に `Text.rich` リンク
- onboarding style: 既存 `_PresetCard` 相当
- settings style: 既存 `_PresetOptionGroup` 相当（カスタム行に trailing）

- [ ] **Step 1–6:** Widget test（権限オフでダイアログ、重大通知リンク表示）含め実装・コミット

Commit: `feat: NotificationPresetSelector共有UIを追加`

---

### Task 6: オンボーディング統合

**Files:**
- Modify: `app/lib/feature/onboarding/ui/components/notification_settings_step_page.dart`

**Interfaces:**
- Consumes: `NotificationPresetSelector`, `NotificationPresetApplier`, `NotificationPreset`

- [ ] **Step 1:** `_NewUserNotificationSettingsStepPage` を `NotificationPreset` + `NotificationPresetSelector` に置き換え
- [ ] **Step 2:** `onNext` で `recommended`/`all`/`none` → applier.apply → nextPage
- [ ] **Step 3:** `custom` → applier（putCurrentLocation）→ push custom → nextPage
- [ ] **Step 4:** `_PresetCard` 削除（selector に移行済みなら）
- [ ] **Step 5:** `mise exec -- flutter analyze` + 関連テスト
- [ ] **Step 6:** Commit `feat: オンボーディング通知設定を4択に更新`

---

### Task 7: 設定画面統合

**Files:**
- Modify: `app/lib/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart`
- Modify: `app/test/feature/settings/features/notification_settings/notification_settings_page_eew_warning_test.dart`（fake preset 対応）

**Interfaces:**
- Consumes: `NotificationPresetSelector`, `NotificationPresetApplier`

- [ ] **Step 1:** `_PresetOptionGroup` 等を `NotificationPresetSelector(style: settings)` に置換
- [ ] **Step 2:** `onChanged` で `applier.apply(preset)` + preset notifier 更新
- [ ] **Step 3:** 未使用 private widget 削除
- [ ] **Step 4:** 既存 widget test 修正
- [ ] **Step 5:** `mise exec -- flutter test test/feature/settings/features/notification_settings/ -v`
- [ ] **Step 6:** Commit `feat: 設定画面の通知プリセットを4択に更新`

---

### Task 8: 最終検証

**Files:** （変更なし、検証のみ）

- [ ] **Step 1:** `cd app && mise exec -- dart analyze`
- [ ] **Step 2:** `cd app && mise exec -- flutter test test/feature/settings/features/notification_settings/ test/core/provider/notification/ -v`
- [ ] **Step 3:** 問題があれば修正コミット
