# Task 4 Report: Flow + Debug UI

## Summary

- Added `DebugDeviceLifecycleFlow` for debug-only device deletion, reprovisioning, and per-token force resync.
- Added `DebugDeviceLifecycleMessages` and `DebugDeviceLifecycleConfirmDialog` helpers instead of private Flow methods.
- Added a debug device lifecycle UI section and per-token resend controls in `DebugDeviceSettingsPage`.
- Kept private page provider invalidation in the UI layer via `MutationSuccess` listeners.

## Verification

- `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`
  - Completed successfully.
- `cd app && mise exec -- dart format lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart lib/feature/devices/ui/page/debug_device_settings_page.dart`
  - Completed successfully.
- `cd app && mise exec -- dart analyze lib/feature/devices/data/flow/debug_device_lifecycle_flow.dart lib/feature/devices/ui/page/debug_device_settings_page.dart`
  - Failed because `eqmonitor_custom_lints` plugin path is missing at `app/tools/eqmonitor_custom_lints`.
  - After fixing the missing `PushTokenKind` import, no additional Dart analyzer issues were reported before the plugin setup failure output.
- Cursor IDE diagnostics reported no linter errors for the changed source files.

## Self Review

- Flow does not access page-private providers.
- New Flow helpers avoid private methods.
- New UI widgets do not define additional methods or getters beyond `build`.
- Delete and reprovision buttons are disabled while either lifecycle mutation is pending.
- Token resend buttons are hidden for non-applicable or not-yet-loaded token states and disabled while the token is syncing or a force-resync mutation is pending.

## Notes

- `build_runner` also changed provider hash lines in existing notifier `.g.dart` files. They are not part of this task and were left uncommitted.
- Existing dirty change in `app/lib/feature/map/data/repository/base_map_pmtiles_repository.dart` was left untouched.
# Task 4 Report: SecureStorage Debug Page UI

## Status

**Completed** — `DebugSecureStoragePage` を作成し、ページファイルのみコミット済み。

## Deliverable

- Created: `app/lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart`
- `HookConsumerWidget` / AppBar refresh / `AsyncValue.when` / `RefreshIndicator` / `ListView.builder` / FAB を実装
- 各行に key、マスク既定の value preview、目アイコンの表示切替、削除、編集ダイアログを実装
- 新規追加ダイアログはキー名と値の `TextField` を持ち、既存 `debugSecureStorageActionProvider` の `write` を使用
- Routing は未変更（Task 5 担当）

## Verify

- `cd app && mise exec -- dart format lib/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart`: OK
- `cd app && mise exec -- dart analyze lib/feature/settings/children/config/debug/secure_storage/`: **No issues found!**
- IDE `ReadLints`: 問題なし

## Commits

- `8dd4e8a0f feat: SecureStorageデバッグ画面のUIを追加`

## Concerns

- `dart format` 実行時に `packages/eqmonitor_lints/lib/analysis_options.yaml` が読めない Warning が出たが、format と analyze は完了。
- 画面への導線は Task 5 まで未接続。

# Final Review Fix: Device Provisioning Migration Guard

## Fix Details

- `DeviceProvisioningNotifier.provision()` の migration 分岐に `wasMigratedFromLegacy()` の確認を追加。
- legacy ID が残っていても移行済みなら durable migration workflow を再実行せず、通常の `registerDevice` 経路へ進むように修正。
- `device_provisioning_migration_test.dart` に、移行済みフラグあり + legacy ID 残存時は `migrateFromLegacy` を呼ばず `registerDevice` を呼ぶ回帰テストを追加。

## Test Results

- `cd app && mise exec -- dart format lib/feature/devices/data/notifier/device_provisioning_notifier.dart test/feature/devices/device_provisioning_migration_test.dart`
  - OK。`packages/eqmonitor_lints/lib/analysis_options.yaml` が読めない Warning は既存環境由来として表示。
- Cursor IDE diagnostics
  - 変更ファイルに linter error なし。
- `cd app && mise exec -- flutter test test/feature/devices/`
  - OK。91 tests passed。
