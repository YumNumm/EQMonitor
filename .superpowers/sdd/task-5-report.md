## Task 5 Report: SecureStorage Debug Routing

### Status: DONE_WITH_CONCERNS

### Changes Summary

- Added `DebugSecureStorageRoute` under debug routes with path `secure-storage`.
- Wired `/settings/debug/secure-storage` to `DebugSecureStoragePage`.
- Added the SecureStorage `ListTile` immediately after SharedPreferences in `debug_page.dart`.
- Regenerated `app/lib/core/router/router.g.dart` with build_runner.
- Included the uncommitted implementation plan in the same implementation commit.

### Commit

- `21bd9c1a7 feat: SecureStorageデバッグ画面への導線を追加`

### Verification

- `mise exec -- dart run build_runner build --delete-conflicting-outputs`: succeeded.
- `mise exec -- dart analyze ...`: blocked by analyzer plugin setup resolving `eqmonitor_custom_lints` from missing `app/tools/eqmonitor_custom_lints`.
- IDE diagnostics for touched Dart files: no linter errors found.

### Concerns

- The untracked `app/analysis_options.yaml` makes the custom lint plugin path resolve relative to `app/`, causing CLI analyze to fail before reporting Dart issues.
