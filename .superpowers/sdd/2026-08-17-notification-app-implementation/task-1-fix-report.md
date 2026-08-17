# Task 1 Fix Report: EEW警報契約テストのnull安全化

## Scope

- `notification_slot_repository_test.dart` の新規 `lastRequestBody!` 2箇所だけを修正した。
- nullable な request body を `containsPair` matcher へ直接渡し、body が null の場合も通常の assertion failure として扱う。
- production code と既存のユーザーdirtyファイルは変更していない。

## Verification

### Format

Command (from `app`):

```text
mise exec -- dart format test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
```

Result: exit 0、`Formatted 1 file (0 changed)`。

### Focused tests

Command (from `app`):

```text
mise exec -- flutter test test/feature/settings/features/notification_settings/eew_warning_settings_model_test.dart test/feature/settings/features/notification_settings/notification_override_model_test.dart test/feature/settings/features/notification_settings/notification_slot_repository_test.dart
```

Result: exit 0、`23/23` tests passed。

### Diff checks

- `git diff --check`: exit 0。
- 対象diffは2 assertionのnull-safe matcher化と本reportのみ。
- stage対象は対象テストと本reportに限定する。
