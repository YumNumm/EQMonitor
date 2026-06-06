# Push Token Sync Reliability Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ensure FCM/APNs token changes are automatically synchronized after startup, and APNs tokens are stored with the correct APNs environment.

**Architecture:** Add a keepAlive wiring provider, started from `main.dart`, that listens to `pushTokenSyncProvider` and runs sync when any token becomes pending. Extend the backend `/v2/device/me/apns/{kind}` request schema to accept APNs `environment`, regenerate the API client, and make the app send `development` for dev/debug flavor and `production` for prod/release flavor.

**Tech Stack:** Flutter, Dart, Riverpod, Firebase Messaging, Dio/Retrofit, Hono, Valibot, OpenAPI generation, swagger_parser.

---

## Finding Summary

Two push-token defects are independent from the device Bearer-auth work in `docs/superpowers/plans/2026-06-05-device-auth-token-sync.md`:

- `PushTokenSyncNotifier.build()` recomputes a `PendingTokenState` when `notificationTokenStreamProvider` emits a refreshed FCM/APNs token, but no listener calls `sync()` after initial provisioning. Refreshed tokens can remain unsent to the backend.
- The mounted backend route `PATCH /v2/device/me/apns/{kind}` currently stores APNs tokens without `environment`, so database default `production` is used. Development/sandbox APNs tokens can be sent to the production APNs endpoint and fail.

## File Structure

- Modify: `backend/api/api/src/features/device/routes/device.ts`  
  Accept optional `environment` in the mounted APNs route and pass it to `upsertApnsToken`.
- Modify generated: `backend/api/api/openapi.json`  
  Regenerate after backend schema change.
- Modify generated fixtures: `backend/api/api-stub/generated/contract-fixtures/*.json`  
  Regenerate after OpenAPI change.
- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.dart`
- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.freezed.dart`
- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.g.dart`
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`  
  Send APNs environment.
- Create: `app/lib/feature/devices/data/provider/apns_environment.dart`  
  Provides `development` or `production` for APNs token registration.
- Create generated: `app/lib/feature/devices/data/provider/apns_environment.g.dart`
- Create: `app/lib/feature/devices/data/provider/push_token_sync_wiring.dart`  
  Starts automatic sync on pending token snapshots.
- Create generated: `app/lib/feature/devices/data/provider/push_token_sync_wiring.g.dart`
- Modify: `app/lib/main.dart`  
  Starts push token sync wiring once the `ProviderContainer` exists.
- Modify: `app/lib/feature/devices/data/model/push_token_sync_snapshot.dart`  
  Fix `allSynced` semantics for platform-inapplicable tokens.
- Test: `app/test/feature/devices/device_repository_apns_environment_test.dart`
- Test: `app/test/feature/devices/push_token_sync_wiring_test.dart`
- Test: `app/test/feature/devices/push_token_sync_snapshot_test.dart`

### Task 1: Extend Backend APNs Environment Contract

**Files:**

- Modify: `backend/api/api/src/features/device/routes/device.ts`
- Modify generated: `backend/api/api/openapi.json`
- Modify generated: `backend/api/api-stub/generated/contract-fixtures/*.json`

- [ ] **Step 1: Add backend route test or schema assertion**

If `backend/api/api/test` already has device route tests, add this test there. If there is no device route test harness, add a focused schema assertion test under `backend/api/api/test/device/device-apns-route.test.ts`.

```ts
import { describe, expect, test } from 'vitest';
import * as v from 'valibot';

const ApnsEnvironment = v.picklist(['development', 'production']);
const MountedApnsTokenRequest = v.object({
  token: v.pipe(v.string(), v.minLength(1)),
  environment: v.optional(ApnsEnvironment),
});

describe('mounted device APNs token request schema', () => {
  test('accepts APNs environment', () => {
    const parsed = v.parse(MountedApnsTokenRequest, {
      token: 'apns-token',
      environment: 'development',
    });

    expect(parsed).toEqual({
      token: 'apns-token',
      environment: 'development',
    });
  });
});
```

Expected initial behavior: this standalone schema test passes by itself, but it documents the request shape that the mounted route must implement. If the existing route test harness supports HTTP requests, prefer an HTTP test that asserts `DeviceDatasource.upsertApnsToken(..., 'development')` is called.

- [ ] **Step 2: Update mounted APNs route schema**

In `backend/api/api/src/features/device/routes/device.ts`, introduce local schemas near the existing device schemas.

```ts
const ApnsEnvironmentSchema = v.union([
  v.literal('development'),
  v.literal('production'),
]);

const ApnsKindParamSchema = v.object({
  kind: v.union([v.literal('notification'), v.literal('liveActivityStart')]),
});

const ApnsTokenRequestSchema = v.pipe(
  v.object({
    token: v.pipe(v.string(), v.minLength(1)),
    environment: v.optional(ApnsEnvironmentSchema),
  }),
  v.metadata({ ref: 'V2DeviceMeApnsKindRequestBody' }),
);
```

Replace the inline APNs route validators:

```ts
vValidator('json', ApnsTokenRequestSchema),
vValidator('param', ApnsKindParamSchema),
```

Update the handler:

```ts
const { token, environment } = c.req.valid('json');
const { kind } = c.req.valid('param');
const datasource = c.get('datasource');
const apnsType = kind === 'notification' ? 'NOTIFICATION' : 'LIVE_ACTIVITY_START';
await datasource.upsertApnsToken(deviceId, apnsType, token, environment);
return c.body(null, 204);
```

- [ ] **Step 3: Run backend targeted tests**

Run:

```bash
mise exec -- pnpm --dir backend/api/api test device-apns-route
```

Expected: PASS. If that script/filter does not exist, run the closest existing API test command and record the exact command in the task commit message body.

- [ ] **Step 4: Regenerate backend OpenAPI**

Run:

```bash
cd backend/api/api && mise exec -- pnpm --silent generate:openapi > openapi.json
```

Validate JSON:

```bash
python3 -c 'import json; json.load(open("backend/api/api/openapi.json")); print("ok")'
```

Expected: prints `ok`.

- [ ] **Step 5: Regenerate contract fixtures**

Run:

```bash
cd backend/api/api-stub && mise exec -- pnpm generate:fixtures
```

Expected: fixture generation exits 0.

- [ ] **Step 6: Commit backend API contract**

```bash
git -C backend add api/api/src/features/device/routes/device.ts api/api/openapi.json api/api-stub/generated/contract-fixtures
git -C backend commit -m "fix: APNsトークン環境をdevice APIで受け取る"
```

Do not push unless the user explicitly asks during execution.

### Task 2: Regenerate Dart API Client and Send APNs Environment

**Files:**

- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.dart`
- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.freezed.dart`
- Modify generated: `packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.g.dart`
- Create: `app/lib/feature/devices/data/provider/apns_environment.dart`
- Create generated: `app/lib/feature/devices/data/provider/apns_environment.g.dart`
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
- Test: `app/test/feature/devices/device_repository_apns_environment_test.dart`

- [ ] **Step 1: Regenerate Dart API client**

Run:

```bash
cd packages/eqmonitor_api && mise exec -- dart run bin/generate.dart
```

Expected: `V2DeviceMeApnsKindRequestBody` has an optional APNs environment field generated from OpenAPI.

- [ ] **Step 2: Add APNs environment provider**

Create `app/lib/feature/devices/data/provider/apns_environment.dart`.

```dart
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apns_environment.g.dart';

@Riverpod(keepAlive: true)
String apnsEnvironment(Ref ref) {
  final buildConfig = ref.watch(buildConfigProvider);
  return switch (buildConfig.flavor) {
    Flavor.dev => 'development',
    Flavor.prod => 'production',
  };
}
```

- [ ] **Step 3: Inject APNs environment into device repository**

Update `app/lib/feature/devices/data/repository/device_repository.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/provider/apns_environment.dart';
```

Add a constructor parameter:

```dart
@Riverpod(keepAlive: true)
Future<DeviceRepository> deviceRepository(Ref ref) async => DeviceRepository(
  await ref.watch(apiClientProvider.future),
  ref.watch(apnsEnvironmentProvider),
);

class DeviceRepository {
  DeviceRepository(this._api, this._apnsEnvironment);

  final api.ApiClient _api;
  final String _apnsEnvironment;
```

If the device auth plan has already been implemented, keep its `DeviceAuthRepository` constructor parameter too:

```dart
DeviceRepository(this._api, this._authRepository, this._apnsEnvironment);
```

Update both APNs request bodies:

```dart
body: api.V2DeviceMeApnsKindRequestBody(
  token: apns,
  environment: _apnsEnvironment,
),
```

and:

```dart
body: api.V2DeviceMeApnsKindRequestBody(
  token: pushToStart,
  environment: _apnsEnvironment,
),
```

- [ ] **Step 4: Write APNs environment request test**

Create `app/test/feature/devices/device_repository_apns_environment_test.dart`.

```dart
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('syncPushTokens sends APNs environment', () async {
    final adapter = _ApnsEnvironmentAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = DeviceRepository(api.ApiClient(dio), 'development');

    await repository.syncPushTokens(
      deviceId: 'unused',
      token: const NotificationToken(
        apnsToken: 'apns-token',
        apnsPushToStartToken: 'push-to-start-token',
      ),
    );

    expect(adapter.requests.map((request) => request.data), [
      {'token': 'apns-token', 'environment': 'development'},
      {'token': 'push-to-start-token', 'environment': 'development'},
    ]);
  });
}

final class _ApnsEnvironmentAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
```

If the device auth plan has already changed the constructor, instantiate with the memory auth repository plus `'development'`:

```dart
final repository = DeviceRepository(
  api.ApiClient(dio),
  _MemoryDeviceAuthRepository(),
  'development',
);
```

- [ ] **Step 5: Generate app Riverpod code**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `apns_environment.g.dart` is generated and device repository generated code is updated.

- [ ] **Step 6: Run targeted app tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/device_repository_apns_environment_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit app APNs environment support**

```bash
git add packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.dart packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.freezed.dart packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.g.dart app/lib/feature/devices/data/provider/apns_environment.dart app/lib/feature/devices/data/provider/apns_environment.g.dart app/lib/feature/devices/data/repository/device_repository.dart app/lib/feature/devices/data/repository/device_repository.g.dart app/test/feature/devices/device_repository_apns_environment_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart
git commit -m "fix: APNsトークン環境を同期する"
```

### Task 3: Auto-Sync Refreshed FCM/APNs Tokens

**Files:**

- Create: `app/lib/feature/devices/data/provider/push_token_sync_wiring.dart`
- Create generated: `app/lib/feature/devices/data/provider/push_token_sync_wiring.g.dart`
- Modify: `app/lib/main.dart`
- Test: `app/test/feature/devices/push_token_sync_wiring_test.dart`

- [ ] **Step 1: Write wiring test**

Create `app/test/feature/devices/push_token_sync_wiring_test.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shouldSyncPushTokens returns true when any token is pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: PendingTokenState(),
      apnsNotification: SyncedTokenState(),
      apnsPushToStart: SyncedTokenState(),
    );

    expect(shouldSyncPushTokens(snapshot), isTrue);
  });

  test('shouldSyncPushTokens returns false with no pending tokens', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(shouldSyncPushTokens(snapshot), isFalse);
  });
}
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/push_token_sync_wiring_test.dart
```

Expected: FAIL because `push_token_sync_wiring.dart` does not exist.

- [ ] **Step 3: Add push token sync wiring provider**

Create `app/lib/feature/devices/data/provider/push_token_sync_wiring.dart`.

```dart
import 'dart:async';

import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_wiring.g.dart';

bool shouldSyncPushTokens(PushTokenSyncSnapshot snapshot) => snapshot.hasPending;

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncWiring(Ref ref) async {
  final provisionStatus = await ref.watch(deviceProvisioningProvider.future);
  if (provisionStatus != DeviceProvisioningStatus.notRequired) {
    return;
  }

  ref.listen<AsyncValue<PushTokenSyncSnapshot>>(
    pushTokenSyncProvider,
    (_, next) {
      final snapshot = next.value;
      if (snapshot == null || !shouldSyncPushTokens(snapshot)) {
        return;
      }
      final mutation = PushTokenSyncNotifier.syncMutation;
      if (ref.read(mutation) is MutationPending) {
        return;
      }
      unawaited(
        mutation.run(
          ref,
          (tsx) async => tsx.get(pushTokenSyncProvider.notifier).sync(),
        ),
      );
    },
  );
}
```

- [ ] **Step 4: Start wiring from main**

Update `app/lib/main.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/provider/push_token_sync_wiring.dart';
```

After `container.listen(backgroundLocationServiceProvider, (_, _) {});`, add:

```dart
container.read(pushTokenSyncWiringProvider.future);
```

Keep the existing `HomePage` provisioning listener for initial registration. If initial token sync becomes duplicated, remove only the token-sync listener from `HomePage` after adding a regression test that proves wiring triggers initial pending sync.

- [ ] **Step 5: Run generation**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `push_token_sync_wiring.g.dart` is generated.

- [ ] **Step 6: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/push_token_sync_wiring_test.dart
```

Expected: PASS.

- [ ] **Step 7: Commit**

```bash
git add app/lib/feature/devices/data/provider/push_token_sync_wiring.dart app/lib/feature/devices/data/provider/push_token_sync_wiring.g.dart app/lib/main.dart app/test/feature/devices/push_token_sync_wiring_test.dart
git commit -m "fix: プッシュトークン更新時に自動同期"
```

### Task 4: Correct Token Snapshot Completion Semantics

**Files:**

- Modify: `app/lib/feature/devices/data/model/push_token_sync_snapshot.dart`
- Test: `app/test/feature/devices/push_token_sync_snapshot_test.dart`

- [ ] **Step 1: Write snapshot tests**

Create `app/test/feature/devices/push_token_sync_snapshot_test.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('allSynced is true when platform-inapplicable tokens are not pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: NotApplicableTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isTrue);
  });

  test('allSynced is false when any token is pending', () {
    const snapshot = PushTokenSyncSnapshot(
      fcm: SyncedTokenState(),
      apnsNotification: PendingTokenState(),
      apnsPushToStart: NotApplicableTokenState(),
    );

    expect(snapshot.allSynced, isFalse);
  });
}
```

- [ ] **Step 2: Run tests to verify failure**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/push_token_sync_snapshot_test.dart
```

Expected: first test FAILS with current strict `SyncedTokenState` requirement.

- [ ] **Step 3: Update `allSynced`**

Update `PushTokenSyncSnapshot.allSynced`.

```dart
bool get allSynced => kindEntries.every(
  (entry) => switch (entry.value) {
    SyncedTokenState() || NotApplicableTokenState() || AbsentTokenState() => true,
    PendingTokenState() || FailedTokenState() => false,
  },
);
```

- [ ] **Step 4: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/push_token_sync_snapshot_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/devices/data/model/push_token_sync_snapshot.dart app/test/feature/devices/push_token_sync_snapshot_test.dart
git commit -m "fix: プッシュトークン同期完了判定を修正"
```

### Task 5: Verify Push Token Flows

**Files:**

- Modify only if verification reveals failures.

- [ ] **Step 1: Run backend checks**

Run:

```bash
mise exec -- pnpm --dir backend/api/api check-types
```

Expected: PASS. If `check-types` is not available in that package, run:

```bash
mise exec -- pnpm --dir backend check-types
```

- [ ] **Step 2: Run app push-token tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/device_repository_apns_environment_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart app/test/feature/devices/push_token_sync_wiring_test.dart app/test/feature/devices/push_token_sync_snapshot_test.dart
```

Expected: PASS.

- [ ] **Step 3: Run Dart analyzer**

Run:

```bash
mise exec -- melos run analyze
```

Expected: PASS with no new warnings.

- [ ] **Step 4: Manual acceptance checklist**

Confirm these behaviors:

```text
FCM startup:
  Initial token becomes Pending and sync runs.

FCM refresh:
  notificationTokenStream emits a new FCM token.
  pushTokenSyncProvider becomes Pending.
  pushTokenSyncWiringProvider runs sync().
  PATCH /v2/device/me/fcm receives the new token.

APNs notification token:
  PATCH /v2/device/me/apns/notification includes token and environment.

APNs push-to-start token:
  PATCH /v2/device/me/apns/liveActivityStart includes token and environment.

Development flavor:
  environment = development.

Production flavor:
  environment = production.
```

- [ ] **Step 5: Commit verification-only fixes if needed**

If verification reveals small fixes in this plan's files:

```bash
git add backend/api/api/src/features/device/routes/device.ts backend/api/api/openapi.json backend/api/api-stub/generated/contract-fixtures packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.dart packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.freezed.dart packages/eqmonitor_api/lib/src/models/v2_device_me_apns_kind_request_body.g.dart app/lib/feature/devices/data/provider/apns_environment.dart app/lib/feature/devices/data/provider/apns_environment.g.dart app/lib/feature/devices/data/provider/push_token_sync_wiring.dart app/lib/feature/devices/data/provider/push_token_sync_wiring.g.dart app/lib/feature/devices/data/repository/device_repository.dart app/lib/feature/devices/data/repository/device_repository.g.dart app/lib/feature/devices/data/model/push_token_sync_snapshot.dart app/lib/main.dart app/test/feature/devices/device_repository_apns_environment_test.dart app/test/feature/devices/push_token_sync_wiring_test.dart app/test/feature/devices/push_token_sync_snapshot_test.dart
git commit -m "test: プッシュトークン同期フローの検証を補強"
```

If no files changed, do not create a commit.

## Self-Review

- Spec coverage: Covers FCM token refresh sync, APNs notification token refresh sync, APNs push-to-start sync, APNs environment persistence, generated client regeneration, and Android/non-APNs completion semantics.
- Completeness scan: No unfinished wording remains.
- Type consistency: `environment` is introduced at backend schema, OpenAPI, generated Dart model, app provider, and repository call sites.
- Backend compatibility: The app continues to use the currently mounted `/v2/device/me/apns/{kind}` route. The legacy separate `routes/apns.ts` route is not required for this fix.
