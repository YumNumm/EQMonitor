# Device Auth Token Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ensure device registration, notification settings updates, FCM token sync, and APNs token sync work against the current backend Bearer JWT device authentication contract.

**Architecture:** Persist `DeviceRegisterResponse.deviceToken` in secure storage after registration, attach it as `Authorization: Bearer ...` only to `/v2/device/me...` API calls, and clear provisioning state when the backend reports an invalid/revoked token. Keep registration protected by App Check and keep realtime ticket behavior on `x-eqmonitor-device-id`.

**Tech Stack:** Flutter, Dart, Riverpod, Dio interceptors, Retrofit generated client, FlutterSecureStorage, Hono backend OpenAPI.

---

## Finding Summary

The backend currently mounts `backend/api/api/src/features/device/routes/device.ts` at `/v2/device`. Every `/v2/device/me...` route uses `deviceBearerAuthMiddleware`, which requires `Authorization: Bearer <deviceToken>`.

The app registers with `POST /v2/device`, but `app/lib/feature/devices/data/repository/device_repository.dart` discards `DeviceRegisterResponse.deviceToken`. `app/lib/core/provider/dio_provider.dart` only installs `AppCheckInterceptor` and `DeviceIdInterceptor`; no interceptor adds `Authorization`.

Impact:

- Device registration itself can succeed.
- `GET /v2/device/me`, notification settings reads/writes, FCM token sync, APNs token sync, and Live Activity device APIs fail with 401.
- `deviceProvisioned` may remain true locally even when the auth token is missing, so the app can get stuck retrying authenticated calls without re-registering.

## File Structure

- Modify: `app/lib/core/data/preferences/secure/secure_storage_key.dart`  
  Add the secure storage key for the device JWT.
- Create: `app/lib/feature/devices/data/repository/device_auth_repository.dart`  
  Owns device token persistence. No API calls.
- Create generated: `app/lib/feature/devices/data/repository/device_auth_repository.g.dart`  
  Produced by build_runner.
- Create: `app/lib/core/provider/interceptor/device_auth_token_interceptor.dart`  
  Adds `Authorization: Bearer ...` to `/v2/device/me...` requests when a token exists.
- Modify: `app/lib/core/provider/dio_provider.dart`  
  Installs `DeviceAuthTokenInterceptor`.
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`  
  Saves token returned from registration and clears token on delete.
- Modify: `app/lib/feature/devices/data/repository/device_provisioning_repository.dart`  
  Adds `clearProvisioned()` so auth recovery can force re-registration.
- Modify: `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart`  
  Clears stale auth state before re-registration if needed.
- Modify: `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`  
  Turns 401/token auth failures into local deprovisioning and a visible retry path.
- Test: `app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart`
- Test: `app/test/feature/devices/device_repository_auth_token_test.dart`
- Test: `app/test/feature/devices/push_token_sync_auth_recovery_test.dart`

### Task 1: Add Device Token Storage and Auth Interceptor

**Files:**

- Modify: `app/lib/core/data/preferences/secure/secure_storage_key.dart`
- Create: `app/lib/feature/devices/data/repository/device_auth_repository.dart`
- Create: `app/lib/core/provider/interceptor/device_auth_token_interceptor.dart`
- Test: `app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart`

- [ ] **Step 1: Write failing interceptor tests**

Create `app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart`.

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds bearer token to /v2/device/me requests', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => 'jwt-1');
    final options = RequestOptions(path: '/v2/device/me/fcm', method: 'PATCH');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers['Authorization'], 'Bearer jwt-1');
    expect(handler.nextOptions, same(options));
  });

  test('does not add bearer token to device registration', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => 'jwt-1');
    final options = RequestOptions(path: '/v2/device', method: 'POST');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add bearer token to realtime ticket', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => 'jwt-1');
    final options = RequestOptions(path: '/v2/realtime/ticket', method: 'GET');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });

  test('does not add Authorization when token is missing', () async {
    final interceptor = DeviceAuthTokenInterceptor(readToken: () async => null);
    final options = RequestOptions(path: '/v2/device/me/settings/eew', method: 'GET');
    final handler = _CapturingRequestHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('Authorization'), isFalse);
    expect(handler.nextOptions, same(options));
  });
}

final class _CapturingRequestHandler extends RequestInterceptorHandler {
  RequestOptions? nextOptions;

  @override
  void next(RequestOptions requestOptions) {
    nextOptions = requestOptions;
  }
}
```

- [ ] **Step 2: Run the failing test**

Run:

```bash
mise exec -- flutter test app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart
```

Expected: FAIL because `DeviceAuthTokenInterceptor` does not exist.

- [ ] **Step 3: Add secure storage key**

Update `app/lib/core/data/preferences/secure/secure_storage_key.dart`.

```dart
enum SecureStorageKey {
  userId('user_id'),
  deviceToken('device_token'),
  ;

  const SecureStorageKey(this.key);
  final String key;
}
```

- [ ] **Step 4: Add device auth repository**

Create `app/lib/feature/devices/data/repository/device_auth_repository.dart`.

```dart
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_auth_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DeviceAuthRepository> deviceAuthRepository(Ref ref) async {
  final preferences = await ref.watch(securePreferencesDataSourceProvider.future);
  return DeviceAuthRepository(preferences);
}

class DeviceAuthRepository {
  DeviceAuthRepository(this._preferences);

  final PreferencesDataSource<SecureStorageKey> _preferences;

  Future<String?> readToken() =>
      _preferences.getString(key: SecureStorageKey.deviceToken);

  Future<void> saveToken(String token) => _preferences.setString(
    key: SecureStorageKey.deviceToken,
    value: token,
  );

  Future<void> clearToken() =>
      _preferences.remove(key: SecureStorageKey.deviceToken);
}
```

- [ ] **Step 5: Add auth token interceptor**

Create `app/lib/core/provider/interceptor/device_auth_token_interceptor.dart`.

```dart
import 'package:dio/dio.dart';

typedef DeviceAuthTokenReader = Future<String?> Function();

class DeviceAuthTokenInterceptor extends Interceptor {
  DeviceAuthTokenInterceptor({required DeviceAuthTokenReader readToken})
    : _readToken = readToken;

  static const _authorizationHeader = 'Authorization';
  static const _deviceMePath = '/v2/device/me';

  final DeviceAuthTokenReader _readToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.startsWith(_deviceMePath)) {
      handler.next(options);
      return;
    }

    final token = await _readToken();
    if (token != null && token.isNotEmpty) {
      options.headers[_authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

- [ ] **Step 6: Run interceptor tests**

Run:

```bash
mise exec -- flutter test app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart
```

Expected: PASS.

- [ ] **Step 7: Generate Riverpod code**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: `app/lib/feature/devices/data/repository/device_auth_repository.g.dart` is generated and build_runner exits 0.

- [ ] **Step 8: Commit**

```bash
git add app/lib/core/data/preferences/secure/secure_storage_key.dart app/lib/feature/devices/data/repository/device_auth_repository.dart app/lib/feature/devices/data/repository/device_auth_repository.g.dart app/lib/core/provider/interceptor/device_auth_token_interceptor.dart app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart
git commit -m "fix: デバイス認証トークンの保存基盤を追加"
```

### Task 2: Persist Registration Token and Attach Authorization

**Files:**

- Modify: `app/lib/core/provider/dio_provider.dart`
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
- Test: `app/test/feature/devices/device_repository_auth_token_test.dart`
- Test: `app/test/feature/devices/device_repository_apns_kind_test.dart`
- Test: `app/test/core/provider/interceptor/device_registration_interceptor_test.dart`

- [ ] **Step 1: Write repository token persistence test**

Create `app/test/feature/devices/device_repository_auth_token_test.dart`.

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registerDevice persists returned device token', () async {
    final adapter = _DeviceRegisterAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final authRepository = _MemoryDeviceAuthRepository();
    final repository = DeviceRepository(api.ApiClient(dio), authRepository);

    final result = await repository.registerDevice(
      deviceId: 'local-device-id',
      devicePlatform: DevicePlatform.ios,
      deviceLocale: DeviceLocale.ja,
    );

    expect(result, isA<Success<RegisteredDevice, Exception>>());
    expect(authRepository.savedToken, 'device-jwt');
    expect(adapter.paths, ['/v2/device', '/v2/device/me']);
  });
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  String? savedToken;

  @override
  Future<void> saveToken(String token) async {
    savedToken = token;
  }

  @override
  Future<String?> readToken() async => savedToken;

  @override
  Future<void> clearToken() async {
    savedToken = null;
  }
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async {
    values[key] = value;
  }

  @override
  Future<String?> getString({required SecureStorageKey key}) async => values[key];

  @override
  Future<void> setInt({required SecureStorageKey key, required int value}) async {
    values[key] = value.toString();
  }

  @override
  Future<int?> getInt({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : int.tryParse(value);
  }

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : double.tryParse(value);
  }

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {
    values[key] = value.toString();
  }

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async {
    final value = values[key];
    return value == null ? null : bool.tryParse(value);
  }

  @override
  Future<void> remove({required SecureStorageKey key}) async {
    values.remove(key);
  }

  @override
  Future<void> clear() async {
    values.clear();
  }
}

final class _DeviceRegisterAdapter implements HttpClientAdapter {
  final paths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    if (options.path == '/v2/device') {
      return ResponseBody.fromString(
        jsonEncode({
          'deviceId': 'server-device-id',
          'deviceToken': 'device-jwt',
          'expiresAt': null,
        }),
        201,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }
    if (options.path == '/v2/device/me') {
      return ResponseBody.fromString(
        jsonEncode({
          'id': 'server-device-id',
          'type': 'IOS',
          'locale': 'ja',
          'registrationType': 'app_check',
          'userId': null,
          'createdAt': '2026-06-05T00:00:00.000Z',
          'updatedAt': '2026-06-05T00:00:00.000Z',
        }),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }
    return ResponseBody.fromString('', 404);
  }

  @override
  void close({bool force = false}) {}
}
```

- [ ] **Step 2: Run the failing repository test**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/device_repository_auth_token_test.dart
```

Expected: FAIL because `DeviceRepository` has no `DeviceAuthRepository` constructor parameter and does not save the returned token.

- [ ] **Step 3: Install auth interceptor in Dio**

Update `app/lib/core/provider/dio_provider.dart`.

```dart
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
```

Inside `dio(Ref ref)`, after `deviceId` is read:

```dart
final deviceAuthRepository = await ref.watch(deviceAuthRepositoryProvider.future);
```

Install the interceptor before the logger:

```dart
dio.interceptors.add(AppCheckInterceptor());
dio.interceptors.add(DeviceIdInterceptor(deviceId: deviceId));
dio.interceptors.add(
  DeviceAuthTokenInterceptor(readToken: deviceAuthRepository.readToken),
);
dio.interceptors.add(
  TalkerDioLogger(
    settings: TalkerDioLoggerSettings(
      errorPen: AnsiPen()..red(),
      requestPen: AnsiPen()..yellow(),
      responsePen: AnsiPen()..green(),
      printRequestHeaders: true,
      hiddenHeaders: {'X-Firebase-AppCheck', 'Authorization'},
      printResponseData: false,
      printErrorMessage: false,
    ),
    talker: talker,
  ),
);
```

- [ ] **Step 4: Persist token in DeviceRepository**

Update `app/lib/feature/devices/data/repository/device_repository.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
```

Change the provider and constructor:

```dart
@Riverpod(keepAlive: true)
Future<DeviceRepository> deviceRepository(Ref ref) async => DeviceRepository(
  await ref.watch(apiClientProvider.future),
  await ref.watch(deviceAuthRepositoryProvider.future),
);

class DeviceRepository {
  DeviceRepository(this._api, this._authRepository);

  final api.ApiClient _api;
  final DeviceAuthRepository _authRepository;
```

Change `registerDevice()` so it saves the returned token before reading `/me`:

```dart
Future<Result<RegisteredDevice, Exception>> registerDevice({
  required String deviceId,
  required DevicePlatform devicePlatform,
  required DeviceLocale deviceLocale,
}) => Result.capture(() async {
  final registerResponse = await _api.device.postV2Device(
    body: api.DeviceRegisterBody(
      type: devicePlatform.toDeviceType,
      locale: deviceLocale.toDeviceLocale,
    ),
  );
  await _authRepository.saveToken(registerResponse.data.deviceToken);
  final getResponse = await _api.device.getV2DeviceMe();
  return getResponse.data.toRegisteredDevice;
});
```

Change `deleteDevice()` so it clears the token after a successful delete:

```dart
Future<Result<void, Exception>> deleteDevice(String deviceId) =>
    Result.capture(() async {
      await _api.device.deleteV2DeviceMe();
      await _authRepository.clearToken();
    });
```

- [ ] **Step 5: Fix tests affected by constructor change**

Update existing tests and fakes that call `DeviceRepository(...)`.

For `app/test/feature/devices/device_repository_apns_kind_test.dart`, construct a memory auth repository:

```dart
final client = api.ApiClient(dio);
final repository = DeviceRepository(client, _MemoryDeviceAuthRepository());
```

For `app/test/feature/migration/v3_migration_workflow_test.dart`, update `FakeDeviceRepository` to call:

```dart
super(api.ApiClient(Dio()), _MemoryDeviceAuthRepository());
```

Define `_MemoryDeviceAuthRepository` in each test file or a shared test helper only if a helper already exists.

- [ ] **Step 6: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/device_repository_auth_token_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart app/test/core/provider/interceptor/device_registration_interceptor_test.dart app/test/feature/migration/v3_migration_workflow_test.dart
```

Expected: PASS.

- [ ] **Step 7: Run code generation**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: generated files are up to date.

- [ ] **Step 8: Commit**

```bash
git add app/lib/core/provider/dio_provider.dart app/lib/feature/devices/data/repository/device_repository.dart app/lib/feature/devices/data/repository/device_repository.g.dart app/test/feature/devices/device_repository_auth_token_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart app/test/feature/migration/v3_migration_workflow_test.dart
git commit -m "fix: デバイス登録トークンを保存して認証に利用"
```

### Task 3: Recover From Missing or Revoked Device Tokens

**Files:**

- Modify: `app/lib/feature/devices/data/repository/device_provisioning_repository.dart`
- Modify: `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart`
- Modify: `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`
- Test: `app/test/feature/devices/push_token_sync_auth_recovery_test.dart`

- [ ] **Step 1: Write auth recovery test**

Create `app/test/feature/devices/push_token_sync_auth_recovery_test.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('auth failure is treated as recoverable deprovisioning signal', () {
    const exception = AuthorizationException(
      reason: AuthorizationFailureReason.unauthenticated,
    );

    expect(exception.isRetryable, isFalse);
    expect(exception.userMessage, '認証が必要です');
  });
}
```

This first test documents the existing domain signal. Add provider-level tests after Step 3 once `clearProvisioned()` exists.

- [ ] **Step 2: Add provisioning clear API**

Update `app/lib/feature/devices/data/repository/device_provisioning_repository.dart`.

```dart
Future<void> clearProvisioned() =>
    _prefs.setBool(SharedPreferencesKey.deviceProvisioned.key, false);
```

- [ ] **Step 3: Clear stale local auth before re-registration**

Update `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
```

Inside `provision()`, before calling `registerDevice()` or the migration workflow:

```dart
final authRepository = await ref.read(deviceAuthRepositoryProvider.future);
await authRepository.clearToken();
```

Keep the existing `repo.markProvisioned()` only after registration or migration succeeds.

- [ ] **Step 4: Clear provisioning state when sync gets 401**

Update `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
```

Add this helper as a public method on the class, not a private method:

```dart
Future<void> handleAuthenticationFailure() async {
  final repo = ref.read(deviceProvisioningRepositoryProvider);
  await repo.clearProvisioned();
  ref
    ..invalidate(deviceProvisioningProvider)
    ..invalidateSelf();
}
```

In the `on DeviceProvisioningException catch (e)` branch inside `sync()`, add:

```dart
if (e is AuthorizationException &&
    e.reason == AuthorizationFailureReason.unauthenticated) {
  await handleAuthenticationFailure();
}
```

Then keep the existing failed token state and `lastError` behavior so the banner still communicates the failure.

- [ ] **Step 5: Add provider-level recovery test**

Extend `app/test/feature/devices/push_token_sync_auth_recovery_test.dart` with a provider test using `SharedPreferences.setMockInitialValues`.

```dart
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart' as plugin_prefs;
import 'package:shared_preferences/shared_preferences.dart' hide SharedPreferencesAsync;
```

Add:

```dart
test('handleAuthenticationFailure clears provisioned flag', () async {
  SharedPreferences.setMockInitialValues({'device_provisioned': true});
  final plugin = await plugin_prefs.SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(SharedPreferencesAsync(plugin)),
    ],
  );
  addTearDown(container.dispose);

  final notifier = container.read(pushTokenSyncProvider.notifier);

  await notifier.handleAuthenticationFailure();

  final repo = container.read(deviceProvisioningRepositoryProvider);
  expect(repo.isProvisioned(), isFalse);
});
```

- [ ] **Step 6: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/push_token_sync_auth_recovery_test.dart
```

Expected: PASS.

- [ ] **Step 7: Run generation**

Run:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: generated files are up to date.

- [ ] **Step 8: Commit**

```bash
git add app/lib/feature/devices/data/repository/device_provisioning_repository.dart app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart app/lib/feature/devices/data/repository/device_provisioning_repository.g.dart app/lib/feature/devices/data/notifier/device_provisioning_notifier.g.dart app/lib/feature/devices/data/notifier/push_token_sync_notifier.g.dart app/test/feature/devices/push_token_sync_auth_recovery_test.dart
git commit -m "fix: デバイス認証失敗時に再登録へ復帰"
```

### Task 4: Verify End-to-End Device Flows

**Files:**

- Modify only if tests reveal failures.
- Test: existing device, notification settings, and migration tests.

- [ ] **Step 1: Run device and notification settings tests**

Run:

```bash
mise exec -- flutter test app/test/core/provider/interceptor/device_registration_interceptor_test.dart app/test/core/provider/interceptor/device_auth_token_interceptor_test.dart app/test/feature/devices/device_repository_auth_token_test.dart app/test/feature/devices/device_repository_apns_kind_test.dart app/test/feature/devices/push_token_sync_auth_recovery_test.dart
```

Expected: PASS.

- [ ] **Step 2: Run analyzer for app**

Run:

```bash
mise exec -- melos run analyze
```

Expected: PASS with no new warnings.

- [ ] **Step 3: Run broader Flutter test suite if time allows**

Run:

```bash
mise exec -- melos run test:flutter
```

Expected: PASS. If this is too slow, record the timeout or failure in the final handoff with the exact failing command and first failing test.

- [ ] **Step 4: Manual backend contract check**

Use the current backend contract as the acceptance criteria:

```text
POST /v2/device
  request: X-Firebase-AppCheck, body { type, locale }
  response: { deviceId, deviceToken, expiresAt }

GET /v2/device/me
PATCH /v2/device/me/fcm
PATCH /v2/device/me/apns/{kind}
PATCH /v2/device/me/settings/*
  request: Authorization: Bearer <deviceToken>
```

Confirm in Dio logs or a test adapter that:

```text
POST /v2/device                  -> no Authorization, has X-Firebase-AppCheck
GET /v2/device/me                -> has Authorization
PATCH /v2/device/me/fcm          -> has Authorization
PATCH /v2/device/me/apns/*       -> has Authorization
PATCH /v2/device/me/settings/*   -> has Authorization
GET /v2/realtime/ticket          -> no Authorization, keeps existing AppCheck/device-id behavior
```

- [ ] **Step 5: Commit verification-only fixes if needed**

If Step 1 or Step 2 required small fixes:

```bash
git add <changed-files>
git commit -m "test: デバイス認証フローの検証を補強"
```

If no files changed, do not create a commit.

## Self-Review

- Spec coverage: Covers device registration, foreground notification settings updates, background-driven current-location notification settings updates, FCM token sync at startup/stream, and APNs token sync at startup/stream because all depend on the same `/v2/device/me...` authorization contract.
- Placeholder scan: No unfinished placeholder wording remains. Each code-changing step includes concrete code or an exact command.
- Type consistency: `DeviceAuthRepository`, `DeviceAuthTokenInterceptor`, `SecureStorageKey.deviceToken`, and `clearProvisioned()` are used consistently across tasks.
- Backend compatibility: Matches the mounted backend route in `backend/api/api/src/features/device/routes/device.ts`, not the legacy unmounted `routes/fcm.ts` / `routes/apns.ts` files.
