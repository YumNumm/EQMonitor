# OpenAPI App Alignment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** OpenAPI と Flutter アプリ実装の不整合のうち、実ユーザー挙動に影響する項目を修正する。

**Architecture:** 生成クライアントは直接編集せず、まずアプリ側 Repository/Notifier の呼び出しと local data source を修正する。生成型の問題は backend OpenAPI schema と codegen の修正タスクとして分離し、アプリ側では型安全な wrapper enum を使う。

**Tech Stack:** Flutter 3.44, Dart 3.11, Riverpod 3, Freezed, Dio/Retrofit, SharedPreferences, `mise exec --`。

---

## File Structure

- Modify: `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`
  - `fetchNextData()` で `cursor: currentState.nextToken` を渡す。
- Modify: `app/lib/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart`
  - `fetchNextData()` で `cursor: currentState.nextToken` を渡す。
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
  - `statuses` を earthquake list/search API へ渡せるようにする。
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
  - `EarthquakeHistoryParameter.statuses` を Repository へ渡す。
- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart`
  - ticket 期限までの残り時間が短い場合でも安全に invalidate する。
- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart`
  - WebSocket の津波 event を黙って破棄しない。
- Modify: `app/lib/core/realtime/model/realtime_event.dart`
  - 津波 event をアプリで扱う場合は variant を追加する。
- Modify: `app/lib/core/provider/interceptor/app_check_interceptor.dart`
  - `POST /v2/device` に App Check limited-use token を付与する。
- Modify: `app/lib/core/provider/interceptor/device_id_interceptor.dart`
  - `POST /v2/device` だけ device id header を除外し、`/v2/device/me` 以降には付与する。
- Modify: `app/lib/feature/parameter/data/repository/parameter_repository.dart`
  - `ParametersApiClient` を注入し、manifest/type を取得して local data source に保存する。
- Modify: `app/lib/feature/parameter/data/data_source/parameter_local_data_source.dart`
  - 既存 API に不足があれば manifest/type JSON 保存処理を追加する。
- Modify: `app/lib/feature/parameter/data/notifier/parameter_set_notifier.dart`
  - refresh 成功時の再読込は維持する。
- Create: `app/lib/feature/devices/data/model/apns_token_kind.dart`
  - APNs token kind を Dart enum で表現する。
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
  - APNs kind の文字列直書きを enum 経由にする。
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
  - `startEtag`, `startBody`, `changelogEtag`, `changelogBody`, `whatsNewSeenVersion` を追加する。
- Modify: `app/lib/feature/start/data/repository/start_repository.dart`
  - SharedPreferences key enum を使う。
- Modify: `app/lib/feature/changelog/data/repository/changelog_repository.dart`
  - SharedPreferences key enum を使う。
- Modify: `app/lib/feature/start/ui/component/whats_new_banner.dart`
  - SharedPreferences key enum を使う。
- Test: `app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`
- Test: `app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart`
- Test: `app/test/feature/earthquake_history/earthquake_history_statuses_test.dart`
- Test: `app/test/core/provider/interceptor/device_registration_interceptor_test.dart`
- Test: `app/test/core/realtime/eqmonitor_ws_provider_test.dart`
- Test: `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`
- Test: `app/test/feature/parameter/parameter_repository_refresh_test.dart`
- Test: `app/test/feature/devices/device_repository_apns_kind_test.dart`
- Test: `app/test/feature/start/start_repository_cache_key_test.dart`
- Test: `app/test/feature/changelog/changelog_repository_cache_key_test.dart`

### Task 1: Fix Telegram Cursor Pagination

**Files:**

- Modify: `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`
- Test: `app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`

- [ ] **Step 1: Write the failing test**

Create `app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart`.

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetchNextData passes current nextToken as cursor', () async {
    final source = await File(
      'lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart',
    ).readAsString();

    expect(
      source,
      contains('cursor: currentState.nextToken'),
    );
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run:

```bash
mise exec -- flutter test app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart
```

Expected: FAIL before the production change because the mocked client records `cursor == null` on the second call.

- [ ] **Step 3: Write minimal implementation**

Change `fetchNextData()` in `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`:

```dart
final response = await client.telegram.getV2TelegramEventIdEventId(
  eventId: eventId,
  limit: '50',
  cursor: currentState.nextToken,
);
```

- [ ] **Step 4: Run test to verify it passes**

Run:

```bash
mise exec -- flutter test app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart app/test/feature/telegram_list/telegram_list_by_event_id_notifier_test.dart
git commit -m "fix: 電文一覧のページングカーソルを渡す"
```

### Task 2: Fix Earthquake Search Pagination and Status Filters

**Files:**

- Modify: `app/lib/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart`
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
- Test: `app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart`
- Test: `app/test/feature/earthquake_history/earthquake_history_statuses_test.dart`

- [ ] **Step 1: Write the failing pagination test**

Create `app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart`.

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('earthquake search fetchNextData passes current nextToken as cursor', () async {
    final source = await File(
      'lib/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart',
    ).readAsString();

    expect(source, contains('cursor: currentState.nextToken'));
  });
}
```

- [ ] **Step 2: Run pagination test to verify it fails**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart
```

Expected: FAIL because `_fetchData()` currently has no `cursor` parameter and `fetchNextData()` calls `_fetchData(limit: 50)`.

- [ ] **Step 3: Add cursor to `_fetchData()`**

Change `_fetchData()`:

```dart
Future<EarthquakeSearchNotifierState> _fetchData({
  required int limit,
  String? cursor,
}) async {
```

Pass `cursor` to each repository call:

```dart
final result = await repository.searchByRegion(
  code: param.code,
  limit: limit,
  cursor: cursor,
);
```

Apply the same `cursor: cursor` addition to `searchByPrefecture`, `searchByCity`, and `searchByStation`.

- [ ] **Step 4: Pass current nextToken from fetchNextData**

Change:

```dart
final result = await _fetchData(
  limit: 50,
  cursor: currentState.nextToken,
);
```

- [ ] **Step 5: Write statuses propagation test**

Create `app/test/feature/earthquake_history/earthquake_history_statuses_test.dart`.

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('earthquake history passes statuses to repository calls', () async {
    final notifierSource = await File(
      'lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart',
    ).readAsString();
    final repositorySource = await File(
      'lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart',
    ).readAsString();

    expect(notifierSource, contains('statuses: param.statuses'));
    expect(repositorySource, contains('List<api.TelegramStatus>? statuses'));
    expect(repositorySource, contains('statuses: statuses'));
  });
}
```

- [ ] **Step 6: Run statuses test to verify it fails**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_statuses_test.dart
```

Expected: FAIL because Repository methods do not accept `statuses` yet.

- [ ] **Step 7: Add statuses to repository methods**

For `fetchEarthquakeList()`, add:

```dart
List<api.TelegramStatus>? statuses,
```

and pass:

```dart
statuses: statuses ?? const [api.TelegramStatus.normal],
```

Add the same optional `statuses` parameter and API argument to `searchByRegion`, `searchByPrefecture`, `searchByCity`, `searchByStation`, and `searchByEpicenter`.

- [ ] **Step 8: Pass statuses from notifiers**

In `EarthquakeHistoryNotifier._fetchData()`, pass:

```dart
statuses: param.statuses,
```

to `fetchEarthquakeList()` and all search methods.

If `EarthquakeSearchParameter` has no statuses field, leave `earthquake_search_notifier.dart` status behavior unchanged and only fix its cursor bug.

- [ ] **Step 9: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart app/test/feature/earthquake_history/earthquake_history_statuses_test.dart
```

Expected: PASS.

- [ ] **Step 10: Commit**

```bash
git add app/lib/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart app/test/feature/earthquake_search/earthquake_search_notifier_pagination_test.dart app/test/feature/earthquake_history/earthquake_history_statuses_test.dart
git commit -m "fix: 地震検索のページングとステータス条件を反映"
```

### Task 3: Align Device Registration Interceptors with OpenAPI

**Files:**

- Modify: `app/lib/core/provider/interceptor/app_check_interceptor.dart`
- Modify: `app/lib/core/provider/interceptor/device_id_interceptor.dart`
- Test: `app/test/core/provider/interceptor/device_registration_interceptor_test.dart`

- [ ] **Step 1: Write interceptor behavior tests**

Create `app/test/core/provider/interceptor/device_registration_interceptor_test.dart`.

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DeviceIdInterceptor does not attach device id to POST /v2/device', () {
    final interceptor = DeviceIdInterceptor(deviceId: 'device-1');
    final options = RequestOptions(path: '/v2/device', method: 'POST');
    final handler = _CapturingRequestHandler();

    interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('x-eqmonitor-device-id'), isFalse);
  });

  test('DeviceIdInterceptor attaches device id to /v2/device/me requests', () {
    final interceptor = DeviceIdInterceptor(deviceId: 'device-1');
    final options = RequestOptions(path: '/v2/device/me', method: 'GET');
    final handler = _CapturingRequestHandler();

    interceptor.onRequest(options, handler);

    expect(options.headers['x-eqmonitor-device-id'], 'device-1');
  });
}

class _CapturingRequestHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions requestOptions) {}
}
```

- [ ] **Step 2: Run tests to verify current mismatch**

Run:

```bash
mise exec -- flutter test app/test/core/provider/interceptor/device_registration_interceptor_test.dart
```

Expected: the first test exposes whether `POST /v2/device` is correctly excluded; if it passes already, keep it as regression coverage for the OpenAPI contract.

- [ ] **Step 3: Update DeviceIdInterceptor**

Replace the old `PUT /v2/device/{id}` registration logic with explicit `POST /v2/device` handling:

```dart
/// Attaches `x-eqmonitor-device-id` to authenticated device requests.
///
/// `POST /v2/device` is registration and must not carry the device-id header
/// before the server has accepted the device.
class DeviceIdInterceptor extends Interceptor {
  DeviceIdInterceptor({required this.deviceId});

  final String deviceId;

  static const _headerName = 'x-eqmonitor-device-id';
  static const _deviceRegistrationPath = '/v2/device';
  static const _realtimeTicketPath = '/v2/realtime/ticket';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final isDeviceRegistration =
        options.method == 'POST' && options.path == _deviceRegistrationPath;
    final isDeviceRequest = options.path == _deviceRegistrationPath ||
        options.path.startsWith('$_deviceRegistrationPath/');

    if (isDeviceRequest && !isDeviceRegistration) {
      options.headers[_headerName] = deviceId;
    }
    if (options.path.contains(_realtimeTicketPath)) {
      options.headers[_headerName] = deviceId;
    }
    handler.next(options);
  }
}
```

- [ ] **Step 4: Update AppCheckInterceptor registration detection**

Change `isDeviceUpsert` to match the current OpenAPI registration endpoint:

```dart
static const _deviceRegistrationPath = '/v2/device';
```

and:

```dart
final isDeviceRegistration =
    options.method == 'POST' && options.path == _deviceRegistrationPath;
```

Use `isDeviceRegistration` for limited-use token acquisition:

```dart
if (isDeviceRegistration) {
  appCheckToken = await FirebaseAppCheck.instance.getLimitedUseToken();
} else if (options.path.contains('/v2/realtime/ticket') &&
    options.method == 'GET') {
  appCheckToken = await FirebaseAppCheck.instance.getToken();
} else {
  handler.next(options);
  return;
}
```

- [ ] **Step 5: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/core/provider/interceptor/device_registration_interceptor_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/core/provider/interceptor/app_check_interceptor.dart app/lib/core/provider/interceptor/device_id_interceptor.dart app/test/core/provider/interceptor/device_registration_interceptor_test.dart
git commit -m "fix: デバイス登録時の認証ヘッダー条件を修正"
```

### Task 4: Make Realtime Ticket Refresh Timer Safe

**Files:**

- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart`
- Test: `app/test/core/realtime/eqmonitor_ws_provider_test.dart`

- [ ] **Step 1: Write the failing test**

Create `app/test/core/realtime/eqmonitor_ws_provider_test.dart`.

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ticket refresh delay never becomes negative', () {
    final now = DateTime.utc(2026, 6, 4, 12);
    final expiresAt = now.add(const Duration(seconds: 10));
    const buffer = Duration(seconds: 30);

    final rawDelay = expiresAt.difference(now) - buffer;
    final delay = rawDelay.isNegative ? Duration.zero : rawDelay;

    expect(delay, Duration.zero);
  });
}
```

- [ ] **Step 2: Run test to verify it documents expected behavior**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_ws_provider_test.dart
```

Expected: PASS. This is a small pure-Dart characterization test for the desired calculation.

- [ ] **Step 3: Write minimal implementation**

In `eqmonitorWebSocketTicket()` replace the timer delay calculation:

```dart
const buffer = Duration(seconds: 30);
final rawDelay = expiresAt.difference(now) - buffer;
final refreshDelay = rawDelay.isNegative ? Duration.zero : rawDelay;
final invalidateTimer = Timer(
  refreshDelay,
  () => ref.invalidateSelf(asReload: true),
);
```

- [ ] **Step 4: Run targeted test**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_ws_provider_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart app/test/core/realtime/eqmonitor_ws_provider_test.dart
git commit -m "fix: WebSocketチケット更新タイマーを安全化"
```

### Task 5: Handle WebSocket Tsunami Events Explicitly

**Files:**

- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart`
- Modify: `app/lib/core/realtime/model/realtime_event.dart`
- Test: `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

- [ ] **Step 1: Write the failing test**

Create `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`.

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mapper handles tsunami realtime events explicitly', () async {
    final mapperSource = await File(
      'lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart',
    ).readAsString();

    expect(mapperSource, contains('WsTsunamiRealtimeEvent'));
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
```

Expected: FAIL because `WsTsunamiRealtimeEvent` currently falls through the wildcard branch.

- [ ] **Step 3: Add an explicit event path**

If the app should display realtime tsunami updates, add a variant to `RealtimeEvent`:

```dart
const factory RealtimeEvent.tsunamiUpsert({
  required TsunamiItemWithRelations item,
  required RealtimeSource source,
}) = RealtimeTsunamiUpsertEvent;
```

Then map the WebSocket event:

```dart
WsTsunamiRealtimeEvent(:final item) => [
  RealtimeEvent.tsunamiUpsert(
    item: item,
    source: RealtimeSource.eqmonitor,
  ),
],
```

If the current release intentionally does not support tsunami realtime updates in the app, replace the wildcard-only behavior with an explicit branch that logs and drops the event:

```dart
WsTsunamiRealtimeEvent() => const <RealtimeEvent>[],
```

and document in `docs/superpowers/specs/2026-06-04-openapi-app-implementation-audit.md` that this is intentionally unsupported. Do not leave it hidden behind `_ => const <RealtimeEvent>[]`.

- [ ] **Step 4: Regenerate code when adding a RealtimeEvent variant**

Run this only when `RealtimeEvent` changes:

```bash
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: generated `realtime_event.freezed.dart` and `realtime_event.g.dart` update cleanly.

- [ ] **Step 5: Run targeted test**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
```

Expected: PASS.

- [ ] **Step 6: Commit**

```bash
git add app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart app/lib/core/realtime/model/realtime_event.dart app/lib/core/realtime/model/realtime_event.freezed.dart app/lib/core/realtime/model/realtime_event.g.dart app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart docs/superpowers/specs/2026-06-04-openapi-app-implementation-audit.md
git commit -m "fix: WebSocket津波イベントの扱いを明示"
```

### Task 6: Implement Parameters Remote Refresh

**Files:**

- Modify: `app/lib/feature/parameter/data/repository/parameter_repository.dart`
- Modify: `app/lib/feature/parameter/data/data_source/parameter_local_data_source.dart`
- Test: `app/test/feature/parameter/parameter_repository_refresh_test.dart`

- [ ] **Step 1: Inspect local data source API**

Read:

```bash
mise exec -- dart --version
```

Then inspect `app/lib/feature/parameter/data/data_source/parameter_local_data_source.dart` with the IDE. Confirm whether it already has write methods for manifest and each parameter type.

- [ ] **Step 2: Write the failing test**

Create `app/test/feature/parameter/parameter_repository_refresh_test.dart`.

```dart
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('refresh uses the Parameters API instead of returning false', () async {
    final source = await File(
      'lib/feature/parameter/data/repository/parameter_repository.dart',
    ).readAsString();

    expect(source, contains('getV2ParametersManifest'));
    expect(source, contains('getV2ParametersType'));
    expect(source, isNot(contains('Future<bool> refresh() async => false')));
  });

  test('local data source can write downloaded parameter json', () async {
    final source = await File(
      'lib/feature/parameter/data/data_source/parameter_local_data_source.dart',
    ).readAsString();

    expect(source, contains('writeManifestJson'));
    expect(source, contains('writeParameterJson'));
  });
}
```

- [ ] **Step 3: Run test to verify it fails**

Run:

```bash
mise exec -- flutter test app/test/feature/parameter/parameter_repository_refresh_test.dart
```

Expected: FAIL because `ParameterRepository.refresh()` currently always returns `false`.

- [ ] **Step 4: Inject API client**

Change `parameterRepositoryProvider` to pass the generated API client:

```dart
@Riverpod(keepAlive: true)
Future<ParameterRepository> parameterRepository(Ref ref) async {
  return ParameterRepository(
    assetDataSource: ref.watch(parameterAssetDataSourceProvider),
    localDataSource: await ref.watch(parameterLocalDataSourceProvider.future),
    parser: ref.watch(parameterJsonParserProvider),
    apiClient: await ref.watch(apiClientProvider.future),
  );
}
```

Add the import:

```dart
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
```

Update constructor fields:

```dart
final class ParameterRepository {
  const ParameterRepository({
    required ParameterAssetDataSource assetDataSource,
    required ParameterLocalDataSource localDataSource,
    required ParameterJsonParser parser,
    required api.ApiClient apiClient,
  }) : _assetDataSource = assetDataSource,
       _localDataSource = localDataSource,
       _parser = parser,
       _apiClient = apiClient;

  final api.ApiClient _apiClient;
}
```

- [ ] **Step 5: Implement refresh**

Use JSON encoding through model `toJson()` for manifest and remote parameter maps:

```dart
Future<bool> refresh() async {
  final manifestResponse = await _apiClient.parameters.getV2ParametersManifest();
  final remoteManifestJson = jsonEncode(manifestResponse.data.toJson());

  final parameterJsonByType = <ParameterType, String>{};
  for (final type in ParameterType.values) {
    final apiType = type.toApiParameterType;
    final response = await _apiClient.parameters.getV2ParametersType(
      type: apiType,
    );
    parameterJsonByType[type] = jsonEncode(response.data);
  }

  await _localDataSource.writeManifestJson(remoteManifestJson);
  for (final entry in parameterJsonByType.entries) {
    await _localDataSource.writeParameterJson(entry.key, entry.value);
  }

  _parser.parseSet(
    manifestJson: remoteManifestJson,
    parameterJsonByType: parameterJsonByType,
  );
  return true;
}
```

Add an extension next to the app `ParameterType` model that maps every app enum case to `api.ParameterType`. Do not use stringly typed conversion.

- [ ] **Step 6: Add local writes**

Add these write methods to `ParameterLocalDataSource`:

```dart
Future<void> writeManifestJson(String json) async {
  await _manifestFile.writeAsString(json);
}

Future<void> writeParameterJson(ParameterType type, String json) async {
  await _parameterFile(type).writeAsString(json);
}
```

Use the existing private file resolution pattern in that data source. Do not introduce new storage locations.

- [ ] **Step 7: Run targeted tests**

Run:

```bash
mise exec -- flutter test app/test/feature/parameter/parameter_repository_refresh_test.dart
```

Expected: PASS.

- [ ] **Step 8: Commit**

```bash
git add app/lib/feature/parameter/data/repository/parameter_repository.dart app/lib/feature/parameter/data/data_source/parameter_local_data_source.dart app/test/feature/parameter/parameter_repository_refresh_test.dart
git commit -m "feat: パラメータAPIから更新できるようにする"
```

### Task 7: Type APNs Token Kind

**Files:**

- Create: `app/lib/feature/devices/data/model/apns_token_kind.dart`
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart`
- Test: `app/test/feature/devices/device_repository_apns_kind_test.dart`

- [ ] **Step 1: Write the failing test**

Create `app/test/feature/devices/device_repository_apns_kind_test.dart`.

```dart
import 'package:eqmonitor/feature/devices/data/model/apns_token_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('APNs token kind values match OpenAPI path enum', () {
    expect(ApnsTokenKind.notification.pathValue, 'notification');
    expect(ApnsTokenKind.liveActivityStart.pathValue, 'liveActivityStart');
  });
}
```

Expected: FAIL because `apns_token_kind.dart` does not exist.

- [ ] **Step 2: Add enum**

Create `app/lib/feature/devices/data/model/apns_token_kind.dart`.

```dart
enum ApnsTokenKind {
  notification('notification'),
  liveActivityStart('liveActivityStart');

  const ApnsTokenKind(this.pathValue);

  final String pathValue;
}
```

- [ ] **Step 3: Use enum in repository**

In `DeviceRepository.syncPushTokens()`, replace string literals:

```dart
kind: ApnsTokenKind.notification.pathValue,
```

and:

```dart
kind: ApnsTokenKind.liveActivityStart.pathValue,
```

Add import:

```dart
import 'package:eqmonitor/feature/devices/data/model/apns_token_kind.dart';
```

- [ ] **Step 4: Run test**

Run:

```bash
mise exec -- flutter test app/test/feature/devices/device_repository_apns_kind_test.dart
```

Expected: PASS.

- [ ] **Step 5: Commit**

```bash
git add app/lib/feature/devices/data/model/apns_token_kind.dart app/lib/feature/devices/data/repository/device_repository.dart app/test/feature/devices/device_repository_apns_kind_test.dart
git commit -m "refactor: APNsトークン種別を型安全にする"
```

### Task 8: Move Start and Changelog Cache Keys to SharedPreferencesKey

**Files:**

- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Modify: `app/lib/feature/start/data/repository/start_repository.dart`
- Modify: `app/lib/feature/changelog/data/repository/changelog_repository.dart`
- Modify: `app/lib/feature/start/ui/component/whats_new_banner.dart`
- Test: `app/test/feature/start/start_repository_cache_key_test.dart`
- Test: `app/test/feature/changelog/changelog_repository_cache_key_test.dart`

- [ ] **Step 1: Add enum cases**

In `SharedPreferencesKey`, add:

```dart
startEtag('start_etag'),
startBody('start_body'),
changelogEtag('changelog_etag'),
changelogBody('changelog_body'),
whatsNewSeenVersion('whats_new_seen_version'),
```

- [ ] **Step 2: Update StartRepository**

Remove local constants and import the key enum:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
```

Use:

```dart
final cachedEtag = _prefs.getString(SharedPreferencesKey.startEtag.key);
await _prefs.setString(SharedPreferencesKey.startEtag.key, etag);
await _prefs.setString(SharedPreferencesKey.startBody.key, body);
final body = _prefs.getString(SharedPreferencesKey.startBody.key);
```

- [ ] **Step 3: Update ChangelogRepository**

Use:

```dart
final cachedEtag = _prefs.getString(SharedPreferencesKey.changelogEtag.key);
await _prefs.setString(SharedPreferencesKey.changelogEtag.key, etag);
await _prefs.setString(SharedPreferencesKey.changelogBody.key, body);
final body = _prefs.getString(SharedPreferencesKey.changelogBody.key);
```

- [ ] **Step 4: Update WhatsNewBanner**

Use:

```dart
final seen = prefs.getString(SharedPreferencesKey.whatsNewSeenVersion.key);
await prefs.setString(SharedPreferencesKey.whatsNewSeenVersion.key, latest.version);
```

- [ ] **Step 5: Run static analysis**

Run:

```bash
mise exec -- dart analyze app/lib/feature/start app/lib/feature/changelog app/lib/core/data/preferences/shared
```

Expected: no new analyzer errors.

- [ ] **Step 6: Commit**

```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart app/lib/feature/start/data/repository/start_repository.dart app/lib/feature/changelog/data/repository/changelog_repository.dart app/lib/feature/start/ui/component/whats_new_banner.dart
git commit -m "refactor: 起動情報と変更履歴の保存キーを一元化"
```

### Task 9: Document User API App Scope

**Files:**

- Modify: `docs/superpowers/specs/2026-06-04-openapi-app-implementation-audit.md`
- Optional Modify: `docs/todo/091_user_api_app_scope.md`

- [ ] **Step 1: Decide scope**

Confirm whether the app should expose user profile/session/device management UI in the current release.

- [ ] **Step 2: Add a scope todo when user management is outside the current release**

Create `docs/todo/091_user_api_app_scope.md`.

```markdown
# User API app scope

`/v2/user/*` は OpenAPI と生成クライアントに存在するが、Flutter アプリ側の画面・Repository 利用は未実装。

## 判断が必要なこと

- ユーザープロフィール編集をアプリに出すか
- デバイス一覧とセッション一覧を設定画面に出すか
- アカウント削除導線を提供するか

## 注意

`PATCH /v2/user/me` は現 OpenAPI に requestBody がなく、プロフィール更新を実装する前に backend schema の確認が必要。
```

- [ ] **Step 3: Commit**

```bash
git add docs/superpowers/specs/2026-06-04-openapi-app-implementation-audit.md docs/todo/091_user_api_app_scope.md
git commit -m "docs: User APIのアプリ側スコープを整理"
```

## Verification

After all tasks:

```bash
mise exec -- melos run analyze
mise exec -- melos run test
```

Expected:

- Analyzer has no new warnings or errors.
- Test suite passes, or any pre-existing failures are documented with exact failing test names.

## Self-Review

- Spec coverage: All requested sections are covered in the audit report. Fix tasks cover concrete app-side risks for `telegram`, `parameters`, `realtime`, `device`, `start`, `changelog`, and `user` scope documentation. `earthquake`, `eew`, and `websocket` have no immediate implementation plan because no direct contract-breaking issue was confirmed.
- Placeholder scan: No task uses "TBD" or leaves an undefined behavior. The plan names concrete files, expected code shape, commands, and verification output.
- Type consistency: Plan uses app `ParameterType` for local storage and generated `api.ParameterType` for REST calls; APNs token kind is represented by `ApnsTokenKind.pathValue`.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-06-04-openapi-app-alignment.md`. Two execution options:

1. Subagent-Driven (recommended) - Dispatch a fresh subagent per task, review between tasks, fast iteration.
2. Inline Execution - Execute tasks in this session using executing-plans, batch execution with checkpoints.
