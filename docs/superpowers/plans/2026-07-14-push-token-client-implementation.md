# Push Token Client Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** アプリ起動ごとにFCM/APNs/push-to-start tokenを独立upsertし、更新監視と成功までの自動リトライを実装する。

**Architecture:** Riverpod wiringはプラットフォーム別token Streamを購読し、3つの`PushTokenSyncWorker`へ最新値を渡す。ワーカーは起動セッション内だけ重複排除し、retryableエラーを最大60秒のバックオフで無期限再試行する。iOS 18未満ではDartとSwiftの両方でpush-to-startを無効化する。

**Tech Stack:** Flutter, Dart, Riverpod 3, Firebase Messaging, ActivityKit Swift FFI, flutter_test

## Global Constraints

- 3計画の最初にこのclient planを完了し、その後backend lifecycle plan、最後にcleanup workflow planを実行する。
- Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。
- production codeより先に失敗するtestを書き、REDを確認する。
- `dynamic`/`Object`/null assertionを新規利用しない。
- クラス内private methodを追加しない。2引数以上はnamed parameterにする。
- SharedPreferencesへtokenまたはtoken hashを保存しない。
- `last_fcm_token_hash`、`last_apns_token_hash`、`last_apns_push_to_start_token_hash`のkey定義と読み書きを削除する。
- iOS 17以下ではpush-to-start tokenの取得、監視、API送信を一度も行わない。
- retryable失敗は`2, 4, 8, 16, 32, 60, 60...`秒で成功まで再試行する。
- 既存のデバイスプロビジョニング用`RetryController`の6回制限は変更しない。
- Swift FFI再生成とiOS buildはmacOS/Xcode環境で行い、Linux上では完了扱いにしない。

---

### Task 1: Platform CapabilityとiOS 18 Guard

**Files:**
- Create: `app/lib/feature/devices/data/model/push_token_platform_capabilities.dart`
- Create: `app/lib/feature/devices/data/provider/push_token_platform_capabilities.dart`
- Create: `app/test/feature/devices/push_token_platform_capabilities_test.dart`
- Modify: `app/lib/feature/devices/data/provider/notification_token_stream.dart`
- Modify: `packages/live_activity_util/ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift`
- Regenerate: `packages/live_activity_util/lib/src/live_activity_util.dart`
- Regenerate: `packages/live_activity_util/lib/src/live_activity_util.dart.m`

**Interfaces:**
- Produces: `PushTokenPlatformCapabilities({required bool supportsFcm, required bool supportsApns, required bool supportsPushToStart})`.
- Produces: `pushTokenPlatformCapabilitiesProvider`, overridden directly in unit tests.
- Consumes: `iosDeviceInfoProvider.systemVersion` and Swift `#available(iOS 18.0, *)`.

- [ ] **Step 1: Write failing capability tests**

```dart
void main() {
  test('iOS 17 syncs FCM and APNs without push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 17,
    );
    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isTrue);
    expect(value.supportsPushToStart, isFalse);
  });

  test('iOS 18 enables push-to-start', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.ios,
      iosMajorVersion: 18,
    );
    expect(value.supportsPushToStart, isTrue);
  });

  test('Android only enables FCM', () {
    final value = PushTokenPlatformCapabilities.forPlatform(
      platform: PushTokenPlatform.android,
    );
    expect(value.supportsFcm, isTrue);
    expect(value.supportsApns, isFalse);
    expect(value.supportsPushToStart, isFalse);
  });
}
```

- [ ] **Step 2: Run the test and verify RED**

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_platform_capabilities_test.dart`

Expected: FAIL because `PushTokenPlatformCapabilities` and `PushTokenPlatform` do not exist.

- [ ] **Step 3: Implement the immutable capability model and provider**

```dart
enum PushTokenPlatform { android, ios, unsupported }

final class PushTokenPlatformCapabilities {
  const PushTokenPlatformCapabilities({
    this.supportsFcm = false,
    this.supportsApns = false,
    this.supportsPushToStart = false,
  });

  factory PushTokenPlatformCapabilities.forPlatform({
    required PushTokenPlatform platform,
    int? iosMajorVersion,
  }) => switch (platform) {
    .android => const PushTokenPlatformCapabilities(supportsFcm: true),
    .ios => PushTokenPlatformCapabilities(
      supportsFcm: true,
      supportsApns: true,
      supportsPushToStart: (iosMajorVersion ?? 0) >= 18,
    ),
    .unsupported => const PushTokenPlatformCapabilities(),
  };

  final bool supportsFcm;
  final bool supportsApns;
  final bool supportsPushToStart;
}
```

The provider maps `kIsWeb`/`Platform` to `PushTokenPlatform`, parses only the leading numeric component of `iosDeviceInfoProvider.systemVersion`, and returns `.unsupported` when it cannot prove iOS 18. Tests override this provider; do not expose `Platform` inside the worker.

- [ ] **Step 4: Gate Dart and Swift token access**

In `notification_token_stream.dart`, replace the APNs boolean provider with the capability object. Watch the push-to-start Stream only when `supportsPushToStart` is true.

In Swift, change both method annotations from `@available(iOS 17.2, *)` to `@available(iOS 18.0, *)`, change `isPushToStartSupported()` to require iOS 18, and guard both methods:

```swift
public func pushToStartToken() -> String? {
  guard #available(iOS 18.0, *), isLiveActivitySupported() else { return nil }
  return Activity<MockLiveActivityAttributes>.pushToStartToken?
    .map { String(format: "%02x", $0) }.joined()
}

public func observePushToStartTokenUpdates(
  _ onUpdate: @escaping @Sendable @convention(block) (NSString) -> Void
) {
  guard #available(iOS 18.0, *), isLiveActivitySupported() else { return }
  Task {
    for await tokenData in Activity<MockLiveActivityAttributes>.pushToStartTokenUpdates {
      onUpdate(tokenData.map { String(format: "%02x", $0) }.joined() as NSString)
    }
  }
}
```

- [ ] **Step 5: Regenerate bindings and verify GREEN**

Run: `cd app && mise exec -- flutter build ios --simulator --debug --no-codesign`

Expected: build succeeds and regenerated bindings expose push-to-start at iOS 18.

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_platform_capabilities_test.dart`

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/feature/devices/data/model/push_token_platform_capabilities.dart app/lib/feature/devices/data/provider/push_token_platform_capabilities.dart app/lib/feature/devices/data/provider/notification_token_stream.dart app/test/feature/devices/push_token_platform_capabilities_test.dart packages/live_activity_util
git commit -m "feat: push-to-startをiOS 18以上に制限"
```

### Task 2: Interruptible Backoff

**Files:**
- Create: `app/lib/feature/devices/data/retry/interruptible_backoff.dart`
- Create: `app/test/feature/devices/interruptible_backoff_test.dart`

**Interfaces:**
- Produces: `PushTokenBackoff.durationFor({required int attempt, Duration? retryAfter})`.
- Produces: `InterruptibleBackoff.wait(Duration)`, `interrupt()`, and `dispose()`.
- Consumes: worker Task 3 uses this class to wake immediately for a newer token.

- [ ] **Step 1: Write failing policy tests**

```dart
test('delay grows exponentially and caps at 60 seconds', () {
  const policy = PushTokenBackoff();
  expect(
    List.generate(8, (i) => policy.durationFor(attempt: i)),
    const [
      Duration(seconds: 2), Duration(seconds: 4),
      Duration(seconds: 8), Duration(seconds: 16),
      Duration(seconds: 32), Duration(seconds: 60),
      Duration(seconds: 60), Duration(seconds: 60),
    ],
  );
});

test('Retry-After is capped at 60 seconds', () {
  const policy = PushTokenBackoff();
  expect(
    policy.durationFor(
      attempt: 0,
      retryAfter: const Duration(minutes: 5),
    ),
    const Duration(seconds: 60),
  );
});
```

Add an async test where `wait(const Duration(days: 1))` completes after `interrupt()`, and a dispose test where pending wait completes without scheduling another operation.

- [ ] **Step 2: Verify RED**

Run: `cd app && mise exec -- flutter test test/feature/devices/interruptible_backoff_test.dart`

Expected: FAIL because both classes are missing.

- [ ] **Step 3: Implement policy and interruptible wait**

Use one `Completer<void>?` field for the active wake signal. `wait` races the injected delay against that signal with `Future.any`. `interrupt` completes the signal. `dispose` marks the instance disposed and calls `interrupt`. Do not use a private helper method or a null assertion.

- [ ] **Step 4: Verify GREEN and commit**

Run: `cd app && mise exec -- flutter test test/feature/devices/interruptible_backoff_test.dart`

Expected: PASS without pending timer warnings.

```bash
git add app/lib/feature/devices/data/retry/interruptible_backoff.dart app/test/feature/devices/interruptible_backoff_test.dart
git commit -m "feat: トークン同期用バックオフを追加"
```

### Task 3: Independent Push Token Sync Worker

**Files:**
- Create: `app/lib/feature/devices/data/model/push_token_sync_worker_state.dart`
- Create: `app/lib/feature/devices/data/repository/push_token_sync_worker.dart`
- Create: `app/test/feature/devices/push_token_sync_worker_test.dart`

**Interfaces:**
- Consumes: `Future<void> Function(String token) upsert`, `InterruptibleBackoff`, `PushTokenBackoff`.
- Produces: `accept({required String token})`, `retry()`, `dispose()`, `state`, and `states`.
- Produces states: absent, syncing, waiting, synced, failed, disposed with attempt/error/resumeAt where applicable.

- [ ] **Step 1: Write RED tests for session behavior**

Create a recording upsert closure and verify:

```dart
worker.accept(token: 'same-token');
await synced.first;
worker.accept(token: 'same-token');
await Future<void>.delayed(Duration.zero);
expect(upserts, ['same-token']);

worker.accept(token: 'new-token');
await synced.skip(1).first;
expect(upserts, ['same-token', 'new-token']);
```

Add separate tests for:

- seven retryable failures followed by success, proving no six-attempt cutoff;
- non-retryable failure stops until `retry()`;
- a new token interrupts a pending delay and only the newest value becomes synced;
- a new token arriving during an in-flight request is sent immediately after completion;
- `dispose()` prevents subsequent upserts.

- [ ] **Step 2: Verify RED**

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_sync_worker_test.dart`

Expected: FAIL because worker types do not exist.

- [ ] **Step 3: Implement the worker pump**

`accept` stores the latest non-empty token, interrupts a wait, and starts `process()` only when a pump is not already running. `process()` is a public method because project rules forbid class-private methods. It loops until disposed, synced with latest, or failed non-retryably.

Core success guard:

```dart
final attemptedToken = latestToken;
if (attemptedToken == null || attemptedToken.isEmpty) return;
await upsert(attemptedToken);
if (latestToken == attemptedToken) {
  lastSyncedToken = attemptedToken;
  state = const PushTokenSyncWorkerState.synced();
  return;
}
attempt = 0;
```

Catch only `DeviceProvisioningException`. On retryable errors publish waiting state and await `InterruptibleBackoff`; on non-retryable errors publish failed state and return. Complete the pump future in `whenComplete` so a later token can restart it. Never mark an old attempted token as the latest synced value.

- [ ] **Step 4: Verify GREEN**

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_sync_worker_test.dart`

Expected: all worker tests PASS and no asynchronous errors escape the zone.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/devices/data/model/push_token_sync_worker_state.dart app/lib/feature/devices/data/repository/push_token_sync_worker.dart app/test/feature/devices/push_token_sync_worker_test.dart
git commit -m "feat: トークン種別ごとの同期ワーカーを追加"
```

### Task 4: Per-kind Repository API

**Files:**
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
- Modify: `app/test/feature/devices/device_repository_apns_kind_test.dart`
- Modify: `app/test/feature/devices/device_repository_apns_environment_test.dart`
- Create: `app/test/feature/devices/device_repository_fcm_token_test.dart`

**Interfaces:**
- Produces: `Future<Result<void, Exception>> upsertPushToken({required PushTokenKind kind, required String token})`.
- Consumes: `PushTokenKind` and the repository's injected APNs environment/platform capability.

- [ ] **Step 1: Write failing endpoint-mapping tests**

Use the existing recording `HttpClientAdapter` pattern and verify one HTTP request per kind:

```dart
await repository.upsertPushToken(kind: .fcm, token: 'fcm');
await repository.upsertPushToken(kind: .apnsPushToStart, token: 'pts');

expect(adapter.requests.map((request) => request.path), [
  '/v2/device/me/fcm',
  '/v2/device/me/apns/LIVE_ACTIVITY_START',
]);
expect(adapter.requests.map((request) => request.data), [
  {'token': 'fcm'},
  {'token': 'pts', 'environment': expectedEnvironment.json},
]);
```

Also verify non-Apple platforms return `NotApplicable` through wiring and never call APNs repository methods; do not silently return success from an APNs repository call made on an unsupported platform.

- [ ] **Step 2: Verify RED**

Run: `cd app && mise exec -- flutter test test/feature/devices/device_repository_fcm_token_test.dart test/feature/devices/device_repository_apns_kind_test.dart test/feature/devices/device_repository_apns_environment_test.dart`

Expected: FAIL because `upsertPushToken` is missing.

- [ ] **Step 3: Implement one-kind-per-call upsert**

Use one switch expression to select exactly one endpoint. Return `Result.capture` and keep `api.ApnsEnvironment` mapping unchanged. Remove the composite `syncPushTokens` method after all callers move in Task 5.

- [ ] **Step 4: Verify GREEN and commit**

Run the same three test files; expected PASS.

```bash
git add app/lib/feature/devices/data/repository/device_repository.dart app/test/feature/devices
git commit -m "refactor: プッシュトークンAPIを種別単位に分離"
```

### Task 5: Riverpod Wiring, Snapshot Aggregation, and Hash Removal

**Files:**
- Modify: `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`
- Modify: `app/lib/feature/devices/data/provider/push_token_sync_wiring.dart`
- Modify: `app/lib/feature/devices/data/model/push_token_sync_snapshot.dart`
- Modify: `app/lib/feature/devices/data/repository/device_provisioning_repository.dart`
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Modify: `app/lib/feature/devices/ui/component/device_provisioning_banner.dart`
- Modify: `app/lib/feature/devices/ui/page/debug_device_settings_page.dart`
- Modify: `app/lib/page/home_page.dart`
- Modify: `app/test/feature/devices/push_token_sync_wiring_test.dart`
- Modify: `app/test/feature/devices/push_token_sync_auth_recovery_test.dart`
- Replace: `app/test/feature/devices/push_token_sync_snapshot_test.dart`

**Interfaces:**
- Consumes: three `PushTokenSyncWorker` instances and `notificationTokenStreamProvider`.
- Produces: `PushTokenSyncSnapshot` compatible with existing debug rows plus aggregate `RetryControllerState` for the banner.
- Produces: `accept(NotificationToken)`, `retryFailed()`, and `disposeWorkers()` on the notifier.

- [ ] **Step 1: Replace hash tests with session/wiring RED tests**

Add tests that create two fresh ProviderContainers with the same emitted token and assert each container performs one upsert. In one container, emit the same token twice and assert one upsert. Emit FCM/APNs/push-to-start together, fail FCM retryably, and assert both APNs workers reach synced without waiting for FCM.

Keep the authentication recovery assertion: unauthenticated upsert clears `deviceProvisioned` and does not enter infinite retry.

- [ ] **Step 2: Verify RED**

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_sync_wiring_test.dart test/feature/devices/push_token_sync_auth_recovery_test.dart test/feature/devices/push_token_sync_snapshot_test.dart`

Expected: FAIL because current hash persistence skips the second container and sync is serial.

- [ ] **Step 3: Rebuild notifier around workers**

In `build`, create only workers supported by `pushTokenPlatformCapabilitiesProvider`; initialize unsupported kinds as `NotApplicableTokenState`. Each worker's state callback updates only its entry in the immutable snapshot. Convert waiting/running/failed worker states to the existing banner `RetryControllerState` in a public snapshot getter, selecting failures first, then waiting, then running.

`pushTokenSyncWiring` must:

1. await successful provisioning;
2. await notifier build;
3. listen to `notificationTokenStreamProvider`;
4. call `accept` for every non-null token field;
5. register `disposeWorkers` with `ref.onDispose`.

Remove the Mutation-pending guard from automatic stream handling; each worker provides its own single-flight behavior. Keep the Mutation only for the manual retry button, where `sync()` delegates to `retryFailed()` and returns immediately.

- [ ] **Step 4: Remove hash persistence**

Delete `computeSnapshot`, `_computeKindState`, `_loadHash`, `saveTokenHash`, `_computeHash`, and `_hashKey` from `DeviceProvisioningRepository`. Remove the three `last*TokenHash` enum members and the now-unused `dart:convert` and `package:crypto/crypto.dart` imports from that file. Keep the app's `crypto` dependency because `device_id.dart`, `string_ex.dart`, and `map_style_util.dart` still consume it.

- [ ] **Step 5: Update UI and provisioning caller**

Keep user-facing messages based on `DeviceProvisioningException.userMessage`. Update `DeviceProvisioningBanner` to read aggregate retry state from snapshot/notifier, and update debug rows to render syncing and waiting states without fixed text height. Remove the duplicate home-page auto-sync listener if startup wiring and provisioning completion already feed the token Stream; retain exactly one automatic path.

- [ ] **Step 6: Verify GREEN**

Run the three focused test files. Expected: PASS.

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Expected: Riverpod generated files update without conflicts.

- [ ] **Step 7: Commit**

```bash
git add app/lib app/test/feature/devices app/pubspec.yaml pubspec.lock
git commit -m "feat: 起動時プッシュトークン同期を常駐化"
```

### Task 6: Remove per-activity Update Token Client Path

**Files:**
- Delete: `app/lib/feature/live_activity/data/provider/live_activity_token_stream.dart`
- Delete: `app/lib/feature/live_activity/data/provider/live_activity_token_stream.g.dart`
- Delete: `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart`
- Delete: `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.g.dart`
- Modify: `app/lib/main.dart`
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
- Modify: `packages/live_activity_util/ios/live_activity_util/Sources/live_activity_util/EQMLiveActivityUtil.swift`
- Regenerate: `packages/live_activity_util/lib/src/live_activity_util.dart`
- Regenerate: `packages/live_activity_util/lib/src/live_activity_util.dart.m`

**Interfaces:**
- Removes: per-activity `pushTokenUpdates` observation and `syncLiveActivityUpdateToken`.
- Preserves: push-to-start initial read/update observation and Broadcast-based Live Activity behavior.

- [ ] **Step 1: Add a source-contract test**

Create `app/test/feature/live_activity/live_activity_token_contract_test.dart` that reads the Swift source and asserts it contains `pushToStartTokenUpdates` but does not contain `activityUpdates`, `pushTokenUpdates`, `observeEewActivityPushTokenUpdates`, or `observeShakeDetectionActivityPushTokenUpdates`.

- [ ] **Step 2: Verify RED**

Run: `cd app && mise exec -- flutter test test/feature/live_activity/live_activity_token_contract_test.dart`

Expected: FAIL because per-activity observers still exist.

- [ ] **Step 3: Delete obsolete paths**

Remove both Swift observer methods and the EEW/Shake mirror attribute types. Delete Dart Stream/service files, their imports, `liveActivityTokenSyncWiringProvider` startup read, and repository update-token method. Do not remove `MockLiveActivityAttributes`, push-to-start methods, or Broadcast widget code.

- [ ] **Step 4: Regenerate FFI and verify**

Run: `cd app && mise exec -- flutter build ios --simulator --debug --no-codesign`

Expected: iOS simulator build succeeds and generated bindings no longer contain observer selectors.

Run the contract test; expected PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib app/test/feature/live_activity packages/live_activity_util
git commit -m "refactor: Live Activity更新トークン同期を削除"
```

### Task 7: Client Regression Verification

**Files:**
- Modify only files required by formatter/analyzer findings from Tasks 1-6.

**Interfaces:**
- Verifies the complete client contract; produces no new API.

- [ ] **Step 1: Format and analyze**

Run: `mise exec -- dart format app/lib app/test packages/live_activity_util/lib packages/live_activity_util/test`

Run: `cd app && mise exec -- flutter analyze`

Expected: both exit 0 with no warnings.

- [ ] **Step 2: Run focused and full tests**

Run: `cd app && mise exec -- flutter test test/feature/devices test/feature/live_activity`

Run: `cd app && mise exec -- flutter test`

Expected: all tests PASS.

- [ ] **Step 3: Verify forbidden remnants**

Run:

```bash
rg -n "lastFcmTokenHash|lastApnsTokenHash|lastApnsPushToStartTokenHash|syncLiveActivityUpdateToken|observeEewActivityPushTokenUpdates|observeShakeDetectionActivityPushTokenUpdates" app packages/live_activity_util
```

Expected: no matches outside migration history/design documents.

- [ ] **Step 4: Commit verification tests and fixes**

```bash
git add app packages/live_activity_util
git commit -m "test: プッシュトークン同期の回帰検証を追加"
git push origin develop
```
