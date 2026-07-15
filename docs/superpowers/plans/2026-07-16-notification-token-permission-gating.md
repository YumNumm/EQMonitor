# Notification Token Permission Gating Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 通知配信可能な権限状態でのみ FCM、APNs 通知、APNs push-to-start token を取得・同期し、初回デバイス登録から暗黙の権限要求を除去する。

**Architecture:** `OsNotificationPermission` が「UI上の完全許可」と「remote notification受信可能」を別々に表し、`osNotificationPermissionProvider` を権限状態の正本にする。`notificationTokenStreamProvider` は子Token Streamを購読する前に権限を判定し、`authorized` / `provisional` のときだけ既存Token取得・同期経路を起動する。

**Tech Stack:** Flutter, Dart, Riverpod 3, Firebase Messaging, flutter_test

## Global Constraints

- Flutter / Dart コマンドは必ず `mise exec --` 経由で実行する。
- production code より先に失敗する test を書き、RED を確認する。
- `authorized` と `provisional` のみ Token 取得対象にする。
- `notDetermined` と `denied` では Token API を一度も呼ばない。
- Token Stream から `requestPermission` を呼ばない。
- provisional authorization は既存 UI では完全許可として扱わない。
- FCM、APNs 通知、APNs push-to-start の全Tokenを同じ権限ゲートの対象にする。
- 権限状態取得に失敗した場合は許可済みへフォールバックしない。
- `dynamic`、`Object`、null assertion を新規利用しない。
- 生成コードは直接編集せず `dart run build_runner build --delete-conflicting-outputs` で更新する。

---

### Task 1: 通知受信可能判定と共有権限Provider

**Files:**
- Modify: `app/lib/core/provider/notification/os_notification_permission.dart`
- Modify: `app/lib/core/provider/notification/os_notification_permission_provider.dart`
- Modify: `app/lib/feature/permission/data/notification_permission_provider.dart`
- Modify: `app/lib/feature/permission/data/notifier/permission_notifier.dart`
- Modify: `app/lib/feature/permission/ui/component/notification_permission_banner.dart`
- Modify: `app/test/core/provider/notification/os_notification_permission_test.dart`
- Modify: `app/test/feature/permission/notification_permission_provider_test.dart`
- Create: `app/test/feature/permission/notification_permission_refresh_test.dart`
- Modify: `app/test/feature/permission/notification_permission_banner_test.dart`

**Interfaces:**
- Produces: `OsNotificationPermission.canReceiveRemoteNotifications`.
- Produces: lifecycle-aware `osNotificationPermissionProvider` as the single permission settings source.
- Preserves: `OsNotificationPermission.isOsNotificationGranted == true` only for `AuthorizationStatus.authorized`.
- Consumes: `appLifecycleProvider`, `firebaseMessagingProvider`, and permission request results.

- [ ] **Step 1: Write failing model and derived-provider tests**

Add one table-driven test to `os_notification_permission_test.dart`:

```dart
for (final entry in {
  AuthorizationStatus.authorized: true,
  AuthorizationStatus.provisional: true,
  AuthorizationStatus.notDetermined: false,
  AuthorizationStatus.denied: false,
}.entries) {
  test('${entry.key} の Token 取得可否は ${entry.value}', () {
    final permission = OsNotificationPermission.fromNotificationSettings(
      _notificationSettings(authorizationStatus: entry.key),
    );
    expect(permission.canReceiveRemoteNotifications, entry.value);
  });
}
```

Update `notification_permission_provider_test.dart` so `isNotificationPermissionGrantedProvider` is fed by an override of `osNotificationPermissionProvider`; retain the assertion that provisional is `false`.

- [ ] **Step 2: Run tests and verify RED**

Run:

```bash
cd app
mise exec -- flutter test --no-pub \
  test/core/provider/notification/os_notification_permission_test.dart \
  test/feature/permission/notification_permission_provider_test.dart
```

Expected: FAIL because `canReceiveRemoteNotifications` does not exist and the granted provider still reads `PermissionRepository` directly.

- [ ] **Step 3: Implement the model and shared provider**

Add to `OsNotificationPermission`:

```dart
bool get canReceiveRemoteNotifications =>
    authorizationStatus == AuthorizationStatus.authorized ||
    authorizationStatus == AuthorizationStatus.provisional;
```

Make `osNotificationPermissionProvider` refresh on foreground return without requesting permission:

```dart
@riverpod
Future<OsNotificationPermission> osNotificationPermission(Ref ref) async {
  ref.listen(appLifecycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      ref.invalidateSelf();
    }
  });
  final messaging = ref.watch(firebaseMessagingProvider);
  final settings = await messaging.getNotificationSettings();
  return settings.toOsNotificationPermission();
}
```

Derive the existing UI boolean from the shared provider:

```dart
@Riverpod(keepAlive: true)
Future<bool> isNotificationPermissionGranted(Ref ref) async {
  final permission = await ref.watch(osNotificationPermissionProvider.future);
  return permission.isOsNotificationGranted;
}
```

- [ ] **Step 4: Write failing permission-request refresh tests**

In `notification_permission_refresh_test.dart`, override `permissionRepositoryProvider` with a repository that returns authorized from `requestNotificationPermission`, keep `osNotificationPermissionProvider` listened, invoke `permissionProvider.notifier.requestNotification()`, and assert the OS permission provider build count changes from 1 to 2.

In `notification_permission_banner_test.dart`, add a tap test with a successful fake repository and the same build counter. Tap the banner body and assert the OS permission provider rebuilds without opening system settings.

- [ ] **Step 5: Run refresh tests and verify RED**

Run:

```bash
cd app
mise exec -- flutter test --no-pub \
  test/feature/permission/notification_permission_refresh_test.dart \
  test/feature/permission/notification_permission_banner_test.dart
```

Expected: FAIL because both permission request paths invalidate only the old UI boolean or do not invalidate the shared OS provider.

- [ ] **Step 6: Invalidate the shared provider after explicit requests**

After `requestNotificationPermission()` completes in `PermissionNotifier.requestNotification`, add:

```dart
ref.invalidate(osNotificationPermissionProvider);
```

After the banner request completes, replace direct invalidation of `isNotificationPermissionGrantedProvider` with:

```dart
ref.invalidate(osNotificationPermissionProvider);
```

Because `isNotificationPermissionGrantedProvider` watches the OS provider, Riverpod invalidates the derived UI state automatically.

- [ ] **Step 7: Verify Task 1 GREEN and commit**

Run the four Task 1 test files. Expected: PASS, including provisional remaining UI-ungranted.

```bash
git add app/lib/core/provider/notification \
  app/lib/feature/permission/data \
  app/lib/feature/permission/ui/component/notification_permission_banner.dart \
  app/test/core/provider/notification \
  app/test/feature/permission
git commit -m "fix: 通知権限状態をToken取得判定と共有"
```

### Task 2: Token取得前の権限ゲート

**Files:**
- Modify: `app/lib/feature/devices/data/provider/notification_token_stream.dart`
- Regenerate: `app/lib/feature/devices/data/provider/notification_token_stream.g.dart`
- Create: `app/test/feature/devices/notification_token_stream_permission_test.dart`

**Interfaces:**
- Consumes: `osNotificationPermissionProvider` and `canReceiveRemoteNotifications` from Task 1.
- Produces: public override boundaries `firebaseMessagingTokenStreamProvider`, `apnsTokenStreamProvider`, and `apnsPushToStartTokenStreamProvider`.
- Preserves: `notificationTokenApnsSupportedProvider` platform mapping and existing token refresh behavior.

- [ ] **Step 1: Write failing denied/notDetermined tests**

Create recording `StreamController<String>` instances for all three child streams. Override `osNotificationPermissionProvider` with denied or notDetermined, override the child providers with the recording streams, and await the first `notificationTokenStreamProvider` value.

For each denied status assert:

```dart
expect(token, const NotificationToken());
expect(firebaseMessaging.requestPermissionCalls, 0);
expect(fcmListenCount, 0);
expect(apnsListenCount, 0);
expect(pushToStartListenCount, 0);
```

The fake `FirebaseMessaging.requestPermission` increments `requestPermissionCalls`; no Token API may be hidden behind a child stream subscription.

- [ ] **Step 2: Run denied tests and verify RED**

Run:

```bash
cd app
mise exec -- flutter test --no-pub \
  test/feature/devices/notification_token_stream_permission_test.dart
```

Expected: FAIL because the current provider calls `requestPermission(provisional: true)` and subscribes to child Token providers without checking authorization.

- [ ] **Step 3: Implement the acquisition gate and test boundaries**

At the start of `notificationTokenStream`, before watching any child Token provider, add:

```dart
final permission = await ref.watch(osNotificationPermissionProvider.future);
if (!permission.canReceiveRemoteNotifications) {
  yield const NotificationToken();
  return;
}
```

Delete:

```dart
final messaging = ref.watch(firebaseMessagingProvider);
await messaging.requestPermission(provisional: true);
```

Rename the three private annotated providers and every reference to them:

```dart
firebaseMessagingTokenStreamProvider
apnsTokenStreamProvider
apnsPushToStartTokenStreamProvider
```

The providers are public only as dependency-injection boundaries; their implementations remain unchanged.

- [ ] **Step 4: Write failing authorized/provisional and permission-change tests**

Add tests that override each child provider with one emitted token and assert both `authorized` and `provisional` eventually produce:

```dart
const NotificationToken(
  fcmToken: 'fcm-token',
  apnsToken: 'apns-token',
  apnsPushToStartToken: 'push-to-start-token',
)
```

In the same ProviderContainer, start with denied, change a mutable fake's `NotificationSettings` to provisional, invalidate `osNotificationPermissionProvider`, and assert Token acquisition starts without recreating the container.

- [ ] **Step 5: Run tests and verify GREEN**

Run the Task 2 test file. Expected: PASS for all four statuses, zero permission requests, and runtime permission reevaluation.

- [ ] **Step 6: Regenerate Riverpod code and commit**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- dart format \
  lib/feature/devices/data/provider/notification_token_stream.dart \
  test/feature/devices/notification_token_stream_permission_test.dart
mise exec -- flutter test --no-pub \
  test/feature/devices/notification_token_stream_permission_test.dart
```

Expected: generated provider names match the public boundaries and tests PASS.

```bash
git add app/lib/feature/devices/data/provider/notification_token_stream.dart \
  app/lib/feature/devices/data/provider/notification_token_stream.g.dart \
  app/test/feature/devices/notification_token_stream_permission_test.dart
git commit -m "fix: 通知許可時のみPush Tokenを取得"
```

### Task 3: 同期配線とオンボーディング回帰

**Files:**
- Modify: `app/test/feature/devices/push_token_sync_wiring_test.dart`
- Verify: `app/test/feature/onboarding/onboarding_page_test.dart`
- Verify: `app/test/feature/permission/permission_state_test.dart`

**Interfaces:**
- Consumes: permission-gated `notificationTokenStreamProvider` from Task 2.
- Verifies: empty `NotificationToken` never invokes `DeviceRepository.syncPushTokens`.
- Preserves: device registration gate, error dialog, and provisional UI semantics.

- [ ] **Step 1: Write the failing/characterization sync test**

Add a second test to `push_token_sync_wiring_test.dart`. Emit `const NotificationToken()` after wiring starts, await the resulting `PushTokenSyncSnapshot`, and assert:

```dart
expect(deviceRepository.tokens, isEmpty);
expect(snapshot.hasPending, isFalse);
```

If this passes immediately, keep it as a characterization test proving Task 2's empty-token output cannot reach the server. The RED proof for the bug remains Task 2's acquisition test.

- [ ] **Step 2: Run focused regression tests**

Run:

```bash
cd app
mise exec -- flutter test --no-pub \
  test/feature/devices/push_token_sync_wiring_test.dart \
  test/feature/onboarding/onboarding_page_test.dart \
  test/feature/permission/permission_state_test.dart
```

Expected: PASS; provisional remains `PermissionItemDecision.notRequested`, welcome navigation stays gated by device registration, and empty Token state performs no API sync.

- [ ] **Step 3: Run complete focused suite and analyze**

Run:

```bash
cd app
mise exec -- flutter test --no-pub \
  test/core/provider/notification/os_notification_permission_test.dart \
  test/feature/permission \
  test/feature/devices/notification_token_stream_permission_test.dart \
  test/feature/devices/push_token_sync_wiring_test.dart \
  test/feature/onboarding/onboarding_page_test.dart
mise exec -- flutter analyze
```

Expected: all tests PASS and analyze exits 0 without warnings.

- [ ] **Step 4: Verify forbidden behavior is absent**

Run:

```bash
rg -n "requestPermission" \
  app/lib/feature/devices/data/provider/notification_token_stream.dart
```

Expected: no matches.

Run:

```bash
git --no-pager diff --check
git -c status.submodulesummary=false status --short --branch --ignore-submodules=all
```

Expected: no whitespace errors and only files in this plan are changed.

- [ ] **Step 5: Commit regression coverage**

```bash
git add app/test/feature/devices/push_token_sync_wiring_test.dart
git commit -m "test: 通知未許可時のToken同期を回帰検証"
```

### Task 4: Publish Draft PR

**Files:**
- No production changes; inspect and publish Tasks 1-3.

**Interfaces:**
- Produces: pushed branch `codex/fix-notification-token-permission` and Draft PR to `develop`.

- [ ] **Step 1: Review complete scope**

Run:

```bash
git status -sb
git --no-pager diff origin/develop...HEAD --stat
git --no-pager diff origin/develop...HEAD
```

Expected: design, plan, permission model/provider, Token Stream, generated provider, and focused tests only.

- [ ] **Step 2: Push the verified branch**

```bash
git push -u origin codex/fix-notification-token-permission
```

Expected: origin contains all implementation commits.

- [ ] **Step 3: Create Draft PR to develop**

Use the GitHub connector when available. Fall back to:

```bash
gh pr create \
  --draft \
  --base develop \
  --head codex/fix-notification-token-permission \
  --title "fix: 通知許可時のみPush Tokenを取得" \
  --body-file /tmp/eqmonitor-notification-token-permission-pr.md
```

The PR body must describe the root cause, authorization status table, changed acquisition behavior, and exact verification commands/results.
