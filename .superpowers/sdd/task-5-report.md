## Task 5 Report: Riverpod Wiring, Snapshot Aggregation, and Hash Removal

### Status: COMPLETE

### Changes Summary

#### 1. `push_token_sync_snapshot.dart` - Added `SyncingTokenState`
- New sealed class `SyncingTokenState` for actively-syncing tokens
- Updated `allSynced` to return `false` for `SyncingTokenState`
- Added `syncing` factory shortcut

#### 2. `push_token_sync_notifier.dart` - Rewrote with 3 independent workers
- Replaced `RetryController` + serial hash-based sync with 3 `PushTokenSyncWorker` instances
- Workers created per supported kind from `pushTokenPlatformCapabilitiesProvider`
- `accept(NotificationToken)` routes each non-null field to the appropriate worker
- `retryFailed()` calls `retry()` on all failed workers
- `disposeWorkers()` disposes all workers and cancels stream subscriptions
- `retryState` getter aggregates worker states into `RetryControllerState` (failed > waiting > syncing > idle)
- `sync()` delegates to `retryFailed()` for banner manual retry compatibility
- `_upsertToken` calls `deviceRepo.upsertPushToken(kind:token:)`, maps `DioException` via `mapDioToProvisioningException()`, handles auth failure, and records telemetry
- Removed: `_syncKind`, `_tokenFor`, serial sync loop, hash persistence calls

#### 3. `push_token_sync_wiring.dart` - Rewrote to feed tokens via Stream
- Awaits provisioning (`deviceProvisioningProvider.future`)
- Awaits notifier build (`pushTokenSyncProvider.future`)
- Listens to `notificationTokenStreamProvider` and calls `notifier.accept(token)`
- Registers `notifier.disposeWorkers` via `ref.onDispose`
- Removed: `MutationPending` guard, snapshot-watching auto-sync trigger

#### 4. `device_provisioning_repository.dart` - Removed hash persistence
- Deleted: `computeSnapshot`, `_computeKindState`, `_loadHash`, `saveTokenHash`, `_computeHash`, `_hashKey`
- Removed imports: `dart:convert`, `package:crypto`, `notification_token.dart`, `push_token_sync_snapshot.dart`
- Kept: `isProvisioned`, `markProvisioned`, `clearProvisioned`, `readLegacyDeviceId`, `wasMigratedFromLegacy`, `markMigratedFromLegacy`, `buildRunner`

#### 5. `shared_preferences_key.dart` - Removed 3 hash entries
- Deleted: `lastFcmTokenHash`, `lastApnsTokenHash`, `lastApnsPushToStartTokenHash`

#### 6. `home_page.dart` - Removed duplicate auto-sync listener
- Deleted second `ref.listen(deviceProvisioningProvider, ...)` block that triggered `sync()` after provisioning
- Removed unused `push_token_sync_notifier.dart` import
- First listener (auto-provisioning) preserved

#### 7. `debug_device_settings_page.dart` - Added SyncingTokenState handling
- `_TokenStatusRow` now renders `SyncingTokenState` with sync icon and text
- `PendingTokenState` label changed to reflect backoff waiting

#### 8. Tests - All 17 tests pass
- `push_token_sync_snapshot_test.dart`: 9 tests
- `push_token_sync_wiring_test.dart`: 4 tests
- `push_token_sync_auth_recovery_test.dart`: 4 tests
- Fixed pre-existing `talker` LateInitializationError by using `setUpAll`

### Concerns
- `syncPushTokens` (old bulk API) still in `device_repository.dart` - Task 6 scope
- Telemetry recording throws in tests (expected, safely caught)
- `device_provisioning_notifier.dart` still calls `sync()` after provisioning (harmless no-op)
