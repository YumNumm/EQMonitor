# v2→v3 マイグレーション監査 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** v2→v3 デバイスマイグレーションの観測性を確保する（backend: ClickHouse イベント記録、app: 結果ログ）とともに、app/backend の不足単体テストと develop の既存テスト腐敗を修正する。

**Architecture:** backend は既存の `recordDeviceEvent()`（device_event テーブル）を migration ルートに fire-and-forget で追加。app は `migrateFromLegacy()` を生成 API クライアントに置き換えてレスポンス（移行件数）を talker にログし、リポジトリ層・例外マッパー・Notifier のテストを新設する。既存の公開インターフェース（シグネチャ）は変更しない。

**Tech Stack:** backend = Hono + Valibot + Vitest（vi.mock / mock-db）、app = Flutter + Riverpod + flutter_test（HttpClientAdapter モック / ProviderContainer overrides / グローバル talker）

## Global Constraints

- backend ブランチは origin/main `a82e9185` から作成: `feat/migration-clickhouse-observability`。作業ディレクトリは `/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.claude/worktrees/v2-migration-audit/backend`
- app ブランチは既存の `worktree-v2-migration-audit`（develop `7906eedd3` 起点）。作業ディレクトリは `/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor/.claude/worktrees/v2-migration-audit`
- **公開インターフェース（クラス・関数のシグネチャ）を新規追加・変更しない**。新しい public クラス/関数/Provider が必要になったら BLOCKED として報告する（ユーザー事前承認が必要なため）
- ClickHouse イベント名は既存の snake_case 過去形規約に従い、正確に `migration_v2_completed` / `migration_v2_skipped` / `migration_v2_failed` の3種のみ
- app のログは既存規約どおりグローバル `talker`（`package:eqmonitor/core/provider/log/talker.dart`）を直接使用。テストでは `talker_lib.talker = Talker();` で初期化（`test/core/realtime/eqmonitor_ws_provider_test.dart:63` と同じパターン）
- app のログメッセージ接頭辞は `[V2Migration]`（migrateFromLegacy）と `[Provisioning]`（notifier）で統一
- backend のコミットは conventional commits（release-please 対象）。app のコミットは既存リポジトリの短い日本語スタイルで可
- backend 検証: `pnpm vitest run test/migration`（api/api 内）、`pnpm check-types`、`pnpm lint`（リポジトリルート）
- app 検証: `mise exec -- flutter test <対象>`（app/ 内）。ローカル `dart analyze` は既知の eqmonitor_lints プラグイン競合で exit 4 になる場合がある（pre-existing、無視してよいのは plugin エラーのみで、通常の analyzer warning は不可）
- flutter/dart コマンドは `mise exec --` 経由で実行する

---

### Task 1: backend — migration ルートに ClickHouse device_event 記録を追加

**Files:**
- Modify: `api/api/src/features/migration/routes/migration.ts`
- Modify: `clickhouse/init/001_create_tables.sql:100`（event カラムのコメント）
- Test: `api/api/test/migration/migration-routes.test.ts`

**Interfaces:**
- Consumes: `recordDeviceEvent(deviceId: string, event: string, opts?: {deviceType?, locale?, metadata?: Record<string, unknown>}): Promise<void>`（`api/api/src/clickhouse-event.ts:10`、既存）
- Produces: ClickHouse `eqmonitor.device_event` 行（event = `migration_v2_completed` | `migration_v2_skipped` | `migration_v2_failed`）。コード上の新規エクスポートは無し

**前提知識:**
- ブランチ作成: `cd backend && git checkout -b feat/migration-clickhouse-observability a82e9185`（既に別ブランチにいる場合。detached HEAD `a82e9185` にいる場合はそのまま `git checkout -b feat/migration-clickhouse-observability`）
- 既存の呼び出し規約は `recordDeviceEvent(deviceId, 'registered', {...}).catch(() => {});`（`api/api/src/features/device/routes/device.ts:256` 参照）— await せず fire-and-forget
- `migration-routes.test.ts` は `vi.mock` で SupabaseReader / MigrationWriter / logger / withSpan をモックする既存構成。モック関数の宣言方法は既存ファイルの流儀（`vi.hoisted` または既存の書き方）に合わせること

- [ ] **Step 1: 失敗するテストを書く**

`api/api/test/migration/migration-routes.test.ts` に clickhouse-event のモックを追加し（既存モック群の隣）、既存テストケースへのアサーション追加＋新規1ケースを書く。

モック追加（ファイル先頭のモック群に追加。既存モックの宣言スタイルに合わせる）:

```typescript
const { mockRecordDeviceEvent } = vi.hoisted(() => ({
  mockRecordDeviceEvent: vi.fn().mockResolvedValue(undefined),
}));

vi.mock('../../src/clickhouse-event', () => ({
  recordDeviceEvent: mockRecordDeviceEvent,
  chClient: {},
}));
```

`beforeEach` の `vi.clearAllMocks()`（あれば）で自動リセットされることを確認。無ければ `mockRecordDeviceEvent.mockClear()` を追加。

各既存テストケースへのアサーション追加:

```typescript
// 正常系(200)のテスト内に追加:
expect(mockRecordDeviceEvent).toHaveBeenCalledWith(
  VALID_DEVICE_ID,
  'migration_v2_completed',
  {
    metadata: expect.objectContaining({
      old_device_id: OLD_DEVICE_ID,
      earthquake_regions: 1,
      eew_regions: 2,
      notification_settings: true,
      duration_ms: expect.any(Number),
    }),
  },
);

// 409 (AlreadyMigratedError) のテスト内に追加:
expect(mockRecordDeviceEvent).toHaveBeenCalledWith(
  VALID_DEVICE_ID,
  'migration_v2_skipped',
  { metadata: { old_device_id: OLD_DEVICE_ID, reason: 'already_migrated' } },
);

// 404 (OldDeviceNotFoundError) のテスト内に追加:
expect(mockRecordDeviceEvent).toHaveBeenCalledWith(
  VALID_DEVICE_ID,
  'migration_v2_failed',
  { metadata: { old_device_id: OLD_DEVICE_ID, reason: 'old_device_not_found' } },
);

// 400 (SupabaseMigrationReaderConfigError, 環境変数欠落) のテスト内に追加:
expect(mockRecordDeviceEvent).toHaveBeenCalledWith(
  VALID_DEVICE_ID,
  'migration_v2_failed',
  { metadata: { old_device_id: OLD_DEVICE_ID, reason: 'config_missing' } },
);

// 500 (DB書き込み失敗等) のテスト内に追加:
expect(mockRecordDeviceEvent).toHaveBeenCalledWith(
  VALID_DEVICE_ID,
  'migration_v2_failed',
  {
    metadata: expect.objectContaining({
      old_device_id: OLD_DEVICE_ID,
      reason: 'internal_error',
    }),
  },
);
```

新規テストケース（ClickHouse 記録失敗はレスポンスに影響しない）:

```typescript
it('ClickHouse 記録が失敗しても 200 を返す', async () => {
  mockRecordDeviceEvent.mockRejectedValueOnce(new Error('clickhouse down'));
  // 既存の正常系テストと同じセットアップ（mockReadOldDeviceData / mockMigrate /
  // mockMarkAsMigrated を resolve させる）をここに複製する
  const { app } = createTestApp();
  const res = await app.request('/migrate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ old_device_id: OLD_DEVICE_ID }),
  }, {
    ...testApiEnv,
    SUPABASE_URL: 'https://example.supabase.co',
    SUPABASE_SECRET_KEY: 'secret',
  });
  expect(res.status).toBe(200);
});
```

（定数名 `VALID_DEVICE_ID` / `OLD_DEVICE_ID` / `createTestApp` / `testApiEnv` は既存テストファイルで定義済みのものを使う。実名が異なる場合は既存名に合わせる）

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd api/api && pnpm vitest run test/migration/migration-routes.test.ts`
Expected: FAIL（`mockRecordDeviceEvent` が呼ばれていない）

- [ ] **Step 3: 実装**

`api/api/src/features/migration/routes/migration.ts` を変更:

import 追加（logger の import の隣）:

```typescript
import { recordDeviceEvent } from '../../../clickhouse-event';
```

成功パス — `logger.info('Migration completed', {...});`（L117-126）の直後に追加:

```typescript
recordDeviceEvent(deviceId, 'migration_v2_completed', {
  metadata: {
    old_device_id: oldDeviceId,
    earthquake_regions: migrated.earthquake_regions,
    eew_regions: migrated.eew_regions,
    notification_settings: migrated.notification_settings,
    duration_ms: Date.now() - startedAt,
  },
}).catch(() => {});
```

`SupabaseMigrationReaderConfigError` 分岐 — `logger.warn(...)` の直後、`return c.json(...)` の前:

```typescript
recordDeviceEvent(deviceId, 'migration_v2_failed', {
  metadata: { old_device_id: oldDeviceId, reason: 'config_missing' },
}).catch(() => {});
```

`AlreadyMigratedError` 分岐 — `logger.info(...)` の直後:

```typescript
recordDeviceEvent(deviceId, 'migration_v2_skipped', {
  metadata: { old_device_id: oldDeviceId, reason: 'already_migrated' },
}).catch(() => {});
```

`OldDeviceNotFoundError` 分岐 — `logger.warn(...)` の直後:

```typescript
recordDeviceEvent(deviceId, 'migration_v2_failed', {
  metadata: { old_device_id: oldDeviceId, reason: 'old_device_not_found' },
}).catch(() => {});
```

catch 末尾（500 パス） — `logger.error('Migration failed', {...});` の直後、`throw error;` の前:

```typescript
recordDeviceEvent(deviceId, 'migration_v2_failed', {
  metadata: {
    old_device_id: oldDeviceId,
    reason: 'internal_error',
    error: error instanceof Error ? error.message : String(error),
  },
}).catch(() => {});
```

`clickhouse/init/001_create_tables.sql` L100 のコメントを更新:

```sql
  event         LowCardinality(String) COMMENT 'registered / token_fcm_updated / token_apns_updated / settings_earthquake_updated / settings_eew_updated / settings_tsunami_updated / settings_shake_detection_updated / migration_v2_completed / migration_v2_skipped / migration_v2_failed',
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd api/api && pnpm vitest run test/migration`
Expected: PASS（既存23 + 新規1 = 24ケース）

- [ ] **Step 5: 型チェック・lint**

Run: リポジトリルート（backend/）で `pnpm check-types && pnpm lint`
Expected: エラーなし（lint が oxfmt の整形差分を指摘したら `pnpm lint --fix` 相当で整形）

- [ ] **Step 6: コミット**

```bash
git add api/api/src/features/migration/routes/migration.ts api/api/test/migration/migration-routes.test.ts clickhouse/init/001_create_tables.sql
git commit -m "feat(api): record v2 migration outcomes to ClickHouse device_event"
```

---

### Task 2: app — develop 既存テスト腐敗（is_pro 欠落）の修正

**Files:**
- Modify: `app/test/feature/devices/device_repository_auth_token_test.dart`
- Modify: `app/test/feature/devices/push_token_sync_auth_recovery_test.dart`

**Interfaces:**
- Consumes: `DeviceMeResponse`（`packages/eqmonitor_api/lib/src/models/device_me_response.dart:24-25` — `@JsonKey(name: 'is_pro') required bool isPro`）
- Produces: なし（テストのみの修正）

**背景:** 生成モデル `DeviceMeResponse` に必須フィールド `is_pro` が追加されたが、上記2テストファイルの `/v2/device/me` モックレスポンス JSON に `is_pro` が無く、develop 上で6テストが `CheckedFromJsonException: There is a problem with "is_pro"` で失敗している（pre-existing）。

- [ ] **Step 1: 失敗を確認（すでに失敗している）**

Run: `cd app && mise exec -- flutter test test/feature/devices/device_repository_auth_token_test.dart test/feature/devices/push_token_sync_auth_recovery_test.dart`
Expected: FAIL 6件（Expected Success / Actual Failure）

- [ ] **Step 2: モック JSON に is_pro を追加**

両ファイル内の `/v2/device/me` に対する `jsonEncode({...})` レスポンス（`'id': 'server-device-id'` 等を含むマップ）すべてに 1 キー追加:

```dart
            'registrationType': 'APP_CHECK',
            'userId': null,
            'is_pro': false,
```

`grep -n "registrationType" <両ファイル>` で全出現箇所を確認し、漏れなく追加する。

- [ ] **Step 3: テストが通ることを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices test/feature/migration`
Expected: 全件 PASS（0 fail）

- [ ] **Step 4: コミット**

```bash
git add app/test/feature/devices/device_repository_auth_token_test.dart app/test/feature/devices/push_token_sync_auth_recovery_test.dart
git commit -m "fix: DeviceMeResponse の is_pro 必須化にテストモックを追随"
```

---

### Task 3: app — migrateFromLegacy を型付きクライアント化し結果をログ、リポジトリ層テスト新設

**Files:**
- Modify: `app/lib/feature/devices/data/repository/device_repository.dart:148-166`（Step 3 部分のみ）
- Create: `app/test/feature/devices/device_repository_migrate_test.dart`

**Interfaces:**
- Consumes:
  - `_api.device.postV2DeviceMeMigrate({required api.MigrateRequest body})` → `Future<HttpResponse<api.MigrationResponse>>`（生成済みクライアント、現状未使用）
  - `api.MigrateRequest({required String oldDeviceId})`（JSON キーは `old_device_id`）
  - `api.MigrationResponse.migrated` → `MigrationResultResponse(earthquakeRegions: num, eewRegions: num, notificationSettings: bool)`
  - グローバル `talker`（`core/provider/log/talker.dart`）
- Produces: `migrateFromLegacy` のシグネチャは**不変**（`Future<Result<void, Exception>>`）。挙動変更は「生 Dio → 型付きクライアント」「talker への結果ログ追加」のみ

- [ ] **Step 1: 失敗するテストを書く**

Create `app/test/feature/devices/device_repository_migrate_test.dart`:

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _oldDeviceId = 'legacy-supabase-id';

void main() {
  setUpAll(() {
    talker_lib.talker = Talker();
  });

  DeviceRepository buildRepository(_MigrateAdapter adapter) {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    return DeviceRepository(
      api.ApiClient(dio),
      _MemoryDeviceAuthRepository(),
      dio,
      apnsEnvironment: api.ApnsEnvironment.development,
    );
  }

  test('既登録デバイスで migrate 成功なら Success を返し old_device_id を送信する', () async {
    final adapter = _MigrateAdapter();
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
    expect(adapter.paths, ['/v2/device/me', '/v2/device/me/migrate']);
    expect(adapter.migrateRequestBody, {'old_device_id': _oldDeviceId});
  });

  test('migrate が 409 なら冪等成功として Success を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 409);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
  });

  test('migrate が 404 (旧デバイスなし) なら非致命として Success を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 404);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
  });

  test('migrate が 500 なら Failure を返す', () async {
    final adapter = _MigrateAdapter(migrateStatus: 500);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Failure<void, Exception>>());
  });

  test('GET /v2/device/me が予期しないエラーなら migrate を呼ばず Failure', () async {
    final adapter = _MigrateAdapter(getMeStatus: 500);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Failure<void, Exception>>());
    expect(adapter.paths, ['/v2/device/me']);
  });

  test('デバイス未登録 (404) なら登録してから migrate する', () async {
    final adapter = _MigrateAdapter(firstGetMeStatus: 404);
    final repository = buildRepository(adapter);

    final result = await repository.migrateFromLegacy(
      deviceId: 'device-id',
      oldDeviceId: _oldDeviceId,
    );

    expect(result, isA<Success<void, Exception>>());
    expect(adapter.paths, [
      '/v2/device/me', // step 1: 404
      '/v2/device', // register
      '/v2/device/me', // register 内の確認 GET
      '/v2/device/me/migrate',
    ]);
  });
}

final class _MigrateAdapter implements HttpClientAdapter {
  _MigrateAdapter({
    this.migrateStatus = 200,
    this.getMeStatus = 200,
    this.firstGetMeStatus,
  });

  /// POST /v2/device/me/migrate が返すステータス。
  final int migrateStatus;

  /// GET /v2/device/me が常に返すステータス。
  final int getMeStatus;

  /// 最初の GET /v2/device/me のみ返すステータス（未登録→登録フロー用）。
  final int? firstGetMeStatus;

  final paths = <String>[];
  Map<String, Object?>? migrateRequestBody;
  var _getMeCalls = 0;

  static const _jsonHeaders = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    if (options.path == '/v2/device/me/migrate') {
      migrateRequestBody = (options.data as Map).cast<String, Object?>();
      if (migrateStatus != 200) {
        throw DioException.badResponse(
          statusCode: migrateStatus,
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: migrateStatus),
        );
      }
      return ResponseBody.fromString(
        jsonEncode({
          'migrated': {
            'earthquake_regions': 2,
            'eew_regions': 1,
            'notification_settings': true,
          },
        }),
        200,
        headers: _jsonHeaders,
      );
    }
    if (options.path == '/v2/device/me') {
      _getMeCalls++;
      final status = (_getMeCalls == 1 && firstGetMeStatus != null)
          ? firstGetMeStatus!
          : getMeStatus;
      if (status != 200) {
        throw DioException.badResponse(
          statusCode: status,
          requestOptions: options,
          response: Response(requestOptions: options, statusCode: status),
        );
      }
      return ResponseBody.fromString(
        jsonEncode({
          'id': 'server-device-id',
          'type': 'IOS',
          'locale': 'ja',
          'registrationType': 'APP_CHECK',
          'userId': null,
          'is_pro': false,
          'createdAt': '2026-06-05T00:00:00.000Z',
          'updatedAt': '2026-06-05T00:00:00.000Z',
        }),
        200,
        headers: _jsonHeaders,
      );
    }
    if (options.path == '/v2/device') {
      return ResponseBody.fromString(
        jsonEncode({
          'deviceId': 'server-device-id',
          'deviceToken': 'device-jwt',
          'expiresAt': null,
        }),
        201,
        headers: _jsonHeaders,
      );
    }
    return ResponseBody.fromString('', 404);
  }

  @override
  void close({bool force = false}) {}
}

final class _MemoryDeviceAuthRepository extends DeviceAuthRepository {
  _MemoryDeviceAuthRepository() : super(_MemorySecurePreferencesDataSource());

  String? savedToken;

  @override
  Future<void> saveToken({required String token}) async => savedToken = token;

  @override
  Future<String?> readToken() async => savedToken;

  @override
  Future<void> clearToken() async => savedToken = null;
}

final class _MemorySecurePreferencesDataSource
    implements PreferencesDataSource<SecureStorageKey> {
  final values = <SecureStorageKey, String>{};

  @override
  Future<void> setString({
    required SecureStorageKey key,
    required String value,
  }) async => values[key] = value;

  @override
  Future<String?> getString({required SecureStorageKey key}) async =>
      values[key];

  @override
  Future<void> setInt({
    required SecureStorageKey key,
    required int value,
  }) async {}

  @override
  Future<int?> getInt({required SecureStorageKey key}) async => null;

  @override
  Future<void> setDouble({
    required SecureStorageKey key,
    required double value,
  }) async {}

  @override
  Future<double?> getDouble({required SecureStorageKey key}) async => null;

  @override
  Future<void> setBool({
    required SecureStorageKey key,
    required bool value,
  }) async {}

  @override
  Future<bool?> getBool({required SecureStorageKey key}) async => null;

  @override
  Future<void> remove({required SecureStorageKey key}) async {}

  @override
  Future<void> clear() async {}
}
```

注意: 6番目のテスト（未登録→登録フロー）の期待パス列は `registerDevice()` の実装（保存トークン無し時: POST /v2/device → GET /v2/device/me）に基づく。実行して実際の呼び出し列と食い違ったら、実装を読み直して期待値を実装の真の挙動に合わせる（実装側は変更しない）。

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices/device_repository_migrate_test.dart`
Expected: 1番目のテストが FAIL（現行実装は生 Dio 直叩きだが、`migrateRequestBody` の検証と talker 未初期化に依らず、現行でも一部パスする可能性がある。**最低限、実装変更で挙動が保たれることを検証するのが目的なので、全ケースの現状結果を記録しておく**）

- [ ] **Step 3: 実装 — Step 3 部分を型付きクライアントに置換**

`app/lib/feature/devices/data/repository/device_repository.dart` に import 追加:

```dart
import 'package:eqmonitor/core/provider/log/talker.dart';
```

L148-166 の Step 3 ブロックを以下に置換:

```dart
    // Step 3 — call migration endpoint to transfer Supabase settings
    return Result.capture(() async {
      try {
        final response = await _api.device.postV2DeviceMeMigrate(
          body: api.MigrateRequest(oldDeviceId: oldDeviceId),
        );
        final migrated = response.data.migrated;
        talker.info(
          '[V2Migration] migrate succeeded: '
          'earthquakeRegions=${migrated.earthquakeRegions}, '
          'eewRegions=${migrated.eewRegions}, '
          'notificationSettings=${migrated.notificationSettings}',
        );
      } on DioException catch (e) {
        // 409 = already migrated; treat as idempotent success
        if (e.response?.statusCode == 409) {
          talker.info('[V2Migration] already migrated (409); skipping');
          return;
        }
        // 404 = old device not found in Supabase; non-fatal
        if (e.response?.statusCode == 404) {
          talker.warning(
            '[V2Migration] old device not found (404); nothing migrated',
          );
          return;
        }
        rethrow;
      }
    });
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices/device_repository_migrate_test.dart test/feature/migration`
Expected: 全 PASS（既存の workflow テスト7件にも影響なし）

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/devices/data/repository/device_repository.dart app/test/feature/devices/device_repository_migrate_test.dart
git commit -m "update: migrateFromLegacy を型付きAPIクライアント化し移行結果を talker にログ"
```

---

### Task 4: app — dio_exception_mapper の単体テスト新設

**Files:**
- Test: `app/test/feature/devices/dio_exception_mapper_test.dart`（新規）

**Interfaces:**
- Consumes:
  - `mapDioToProvisioningException(DioException e, [StackTrace? stack]): DeviceProvisioningException`（`app/lib/feature/devices/data/exception/dio_exception_mapper.dart:6`）
  - `AppCheckRejection`（`app/lib/feature/devices/data/exception/app_check_rejection.dart` — コンストラクタ引数は実装を読んで合わせる）
  - 例外クラス群（`device_provisioning_exception.dart`）: `NetworkUnreachableException` / `AuthorizationException(reason:)` / `RateLimitedException(retryAfter:)` / `InvalidRequestException(statusCode:)` / `ServerErrorException(statusCode:)` / `UnexpectedProvisioningException`
- Produces: なし（テストのみ）

- [ ] **Step 1: テストを書く**

Create `app/test/feature/devices/dio_exception_mapper_test.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/devices/data/exception/app_check_rejection.dart';
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/exception/dio_exception_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _badResponse(int status, {Map<String, List<String>>? headers}) {
  final options = RequestOptions(path: '/v2/device');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response(
      requestOptions: options,
      statusCode: status,
      headers: Headers.fromMap(headers ?? {}),
    ),
  );
}

DioException _typed(DioExceptionType type) => DioException(
  requestOptions: RequestOptions(path: '/v2/device'),
  type: type,
);

void main() {
  test('AppCheckRejection を伴う cancel は appCheckUnavailable', () {
    final e = DioException(
      requestOptions: RequestOptions(path: '/v2/device'),
      type: DioExceptionType.cancel,
      error: const AppCheckRejection(),
    );
    final mapped = mapDioToProvisioningException(e);
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.appCheckUnavailable,
    );
    expect(mapped.isRetryable, isTrue);
  });

  for (final type in [
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
    DioExceptionType.badCertificate,
  ]) {
    test('$type は NetworkUnreachableException', () {
      expect(
        mapDioToProvisioningException(_typed(type)),
        isA<NetworkUnreachableException>(),
      );
    });
  }

  test('401 は unauthenticated (再試行不可)', () {
    final mapped = mapDioToProvisioningException(_badResponse(401));
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.unauthenticated,
    );
    expect(mapped.isRetryable, isFalse);
  });

  test('403 は forbidden', () {
    final mapped = mapDioToProvisioningException(_badResponse(403));
    expect(mapped, isA<AuthorizationException>());
    expect(
      (mapped as AuthorizationException).reason,
      AuthorizationFailureReason.forbidden,
    );
  });

  test('429 は RateLimitedException で Retry-After 秒数を解析する', () {
    final mapped = mapDioToProvisioningException(
      _badResponse(429, headers: {'Retry-After': ['30']}),
    );
    expect(mapped, isA<RateLimitedException>());
    expect(
      (mapped as RateLimitedException).retryAfter,
      const Duration(seconds: 30),
    );
  });

  test('429 で Retry-After が無ければ retryAfter は null', () {
    final mapped = mapDioToProvisioningException(_badResponse(429));
    expect((mapped as RateLimitedException).retryAfter, isNull);
  });

  test('429 で Retry-After が HTTP-date 形式なら null (未対応)', () {
    final mapped = mapDioToProvisioningException(
      _badResponse(429, headers: {
        'Retry-After': ['Wed, 21 Oct 2026 07:28:00 GMT'],
      }),
    );
    expect((mapped as RateLimitedException).retryAfter, isNull);
  });

  test('400 は InvalidRequestException', () {
    final mapped = mapDioToProvisioningException(_badResponse(400));
    expect(mapped, isA<InvalidRequestException>());
    expect((mapped as InvalidRequestException).statusCode, 400);
    expect(mapped.isRetryable, isFalse);
  });

  test('422 は InvalidRequestException', () {
    expect(
      mapDioToProvisioningException(_badResponse(422)),
      isA<InvalidRequestException>(),
    );
  });

  test('500/503 は ServerErrorException (再試行可)', () {
    for (final status in [500, 503]) {
      final mapped = mapDioToProvisioningException(_badResponse(status));
      expect(mapped, isA<ServerErrorException>());
      expect((mapped as ServerErrorException).statusCode, status);
      expect(mapped.isRetryable, isTrue);
    }
  });

  test('未知のステータス (418) は UnexpectedProvisioningException', () {
    expect(
      mapDioToProvisioningException(_badResponse(418)),
      isA<UnexpectedProvisioningException>(),
    );
  });

  test('badResponse で statusCode が null なら Unexpected', () {
    final options = RequestOptions(path: '/v2/device');
    final e = DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
    );
    expect(
      mapDioToProvisioningException(e),
      isA<UnexpectedProvisioningException>(),
    );
  });

  test('unknown タイプは UnexpectedProvisioningException', () {
    expect(
      mapDioToProvisioningException(_typed(DioExceptionType.unknown)),
      isA<UnexpectedProvisioningException>(),
    );
  });
}
```

注意: `AppCheckRejection` のコンストラクタが `const AppCheckRejection()` で無い場合（引数必須など）は実装ファイルを読んで正しい生成に直す。`isRetryable` プロパティ名が異なる場合（例: `retryable`）も `device_provisioning_exception.dart` の実名に合わせる。プロパティが存在しない場合はその expect 行を削除してよい。

- [ ] **Step 2: テストを実行**

Run: `cd app && mise exec -- flutter test test/feature/devices/dio_exception_mapper_test.dart`
Expected: 全 PASS（実装は既存のため、これは仕様固定のための characterization test。FAIL したらテスト側の期待を実装の実挙動に合わせる。実装のバグを見つけた場合は BLOCKED ではなく DONE_WITH_CONCERNS で報告）

- [ ] **Step 3: コミット**

```bash
git add app/test/feature/devices/dio_exception_mapper_test.dart
git commit -m "test: dio_exception_mapper の単体テストを追加"
```

---

### Task 5: app — provision() にマイグレーションログを追加

**Files:**
- Modify: `app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart:53-104`

**Interfaces:**
- Consumes: グローバル `talker`（`core/provider/log/talker.dart`）
- Produces: シグネチャ変更なし。ログ追加のみ。**Task 6 のテストは本タスクの変更後のコードを前提とする**

- [ ] **Step 1: 実装（ログ追加のみ、テストは Task 6 で書く）**

import 追加:

```dart
import 'package:eqmonitor/core/provider/log/talker.dart';
```

`provision()` 内を以下のように変更（変更行のみ示す。構造は既存のまま）:

```dart
        final legacy = repo.readLegacyDeviceId();
        if (legacy != null && legacy.isNotEmpty) {
          talker.info(
            '[Provisioning] legacy device detected; '
            'running v2→v3 migration workflow',
          );
          await runV3MigrationWorkflow(
            runner: repo.buildRunner(),
            repository: deviceRepo,
            deviceId: deviceId,
            oldDeviceId: legacy,
          );
          await repo.markMigratedFromLegacy();
          talker.info('[Provisioning] v2→v3 migration workflow completed');
        } else {
```

catch 節を以下に変更:

```dart
      } on DeviceProvisioningException catch (e, st) {
        talker.error('[Provisioning] failed', e, st);
        rethrow;
      } on DioException catch (e, st) {
        final mapped = mapDioToProvisioningException(e, st);
        talker.error('[Provisioning] failed', mapped, st);
        throw mapped;
      } catch (e, st) {
        talker.error('[Provisioning] unexpected failure', e, st);
        throw UnexpectedProvisioningException(cause: e, stackTrace: st);
      }
```

- [ ] **Step 2: 既存テストが壊れないことを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices test/feature/migration`
Expected: 全 PASS。もし既存テストが provision() を呼んでいて `LateInitializationError: Field 'talker'` で落ちる場合は、そのテストファイルの `setUp`/`setUpAll` に `talker_lib.talker = Talker();`（`import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;` と `import 'package:talker_flutter/talker_flutter.dart';`）を追加する（既存規約: `test/core/realtime/eqmonitor_ws_provider_test.dart:63`）

- [ ] **Step 3: コミット**

```bash
git add app/lib/feature/devices/data/notifier/device_provisioning_notifier.dart
git commit -m "update: provision() にマイグレーション進行と失敗の talker ログを追加"
```

---

### Task 6: app — provision() マイグレーション経路の Notifier テスト新設

**Files:**
- Test: `app/test/feature/devices/device_provisioning_migration_test.dart`（新規）

**Interfaces:**
- Consumes:
  - `DeviceProvisioningNotifier.provision()`（Task 5 適用後）
  - `FakeDeviceRepository`（`app/test/feature/migration/v3_migration_workflow_test.dart:246` の既存パターン。**private クラスなのでコピーして本テストファイル内に定義する**）
  - Provider overrides: `app_prefs.sharedPreferencesProvider` / `deviceAuthRepositoryProvider` / `deviceRepositoryProvider` / `deviceIdProvider`（`core/provider/device_id.dart`）/ `pushTokenSyncProvider`
  - `SharedPreferencesKey.legacyDeviceId.key` = `'device_id'` 相当（`shared_preferences_key.dart:22` の実値を使う）
- Produces: なし（テストのみ）

- [ ] **Step 1: テストを書く**

Create `app/test/feature/devices/device_provisioning_migration_test.dart`:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/model/registered_device.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_provisioning_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

const _deviceId = 'test-device-id';
const _legacyId = 'legacy-supabase-id';

const _fakeDevice = RegisteredDevice(
  id: _deviceId,
  platform: DevicePlatform.ios,
  userId: null,
  locale: DeviceLocale.ja,
  createdAtIso: '2026-01-01T00:00:00Z',
  updatedAtIso: '2026-01-01T00:00:00Z',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    talker_lib.talker = Talker();
  });

  Future<(ProviderContainer, FakeDeviceRepository, SharedPreferences)>
  buildContainer({
    required Map<String, Object> initialPrefs,
    required FakeDeviceRepository deviceRepo,
  }) async {
    SharedPreferences.setMockInitialValues(initialPrefs);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        deviceAuthRepositoryProvider.overrideWith(
          (ref) async => _MemoryDeviceAuthRepository()..savedToken = 'jwt',
        ),
        deviceRepositoryProvider.overrideWith((ref) async => deviceRepo),
        deviceIdProvider.overrideWith((ref) async => _deviceId),
        pushTokenSyncProvider.overrideWith(_NoopPushTokenSync.new),
      ],
    );
    addTearDown(container.dispose);
    return (container, deviceRepo, prefs);
  }

  test('legacy ID があればワークフロー実行後に移行済みフラグとprovisionedが立つ', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {SharedPreferencesKey.legacyDeviceId.key: _legacyId},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      ),
    );

    await container
        .read(deviceProvisioningProvider.notifier)
        .provision();

    expect(deviceRepo.migrateCalls, 1);
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isTrue,
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceProvisioned.key),
      isTrue,
    );
  });

  test('legacy ID が無ければ registerDevice のみで migrate は呼ばれない', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: () => const Success(null),
      ),
    );

    await container
        .read(deviceProvisioningProvider.notifier)
        .provision();

    expect(deviceRepo.migrateCalls, 0);
    expect(deviceRepo.putCalls, 1);
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isNot(isTrue),
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceProvisioned.key),
      isTrue,
    );
  });

  test('migrate が非再試行エラー(400)なら例外が伝播しフラグは立たない', () async {
    final (container, deviceRepo, prefs) = await buildContainer(
      initialPrefs: {SharedPreferencesKey.legacyDeviceId.key: _legacyId},
      deviceRepo: FakeDeviceRepository(
        getResult: () => const Success(_fakeDevice),
        putResult: () => const Success(_fakeDevice),
        migrateResult: _badRequest,
      ),
    );

    await expectLater(
      container.read(deviceProvisioningProvider.notifier).provision(),
      throwsA(isA<InvalidRequestException>()),
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceMigratedFromLegacy.key),
      isNot(isTrue),
    );
    expect(
      prefs.getBool(SharedPreferencesKey.deviceProvisioned.key),
      isNot(isTrue),
    );
  });
}

Result<void, Exception> _badRequest() {
  final options = RequestOptions(path: '/v2/device/me/migrate');
  return Failure(
    DioException.badResponse(
      statusCode: 400,
      requestOptions: options,
      response: Response(requestOptions: options, statusCode: 400),
    ),
  );
}

final class _NoopPushTokenSync extends PushTokenSyncNotifier {
  @override
  Future<void> sync() async {}
}

// ---- 以下、v3_migration_workflow_test.dart の Fake/Memory 実装をコピー ----
// FakeDeviceRepository, _MemoryDeviceAuthRepository,
// _MemorySecurePreferencesDataSource を
// app/test/feature/migration/v3_migration_workflow_test.dart:246 以降から
// そのままコピーして貼り付ける（private のため import 不可）。
```

注意:
- `pushTokenSyncProvider` のクラス名・override 方法（`overrideWith(_NoopPushTokenSync.new)` が型エラーになる場合は `PushTokenSyncNotifier` の実際の基底に合わせる。Notifier 系は `overrideWith(() => _NoopPushTokenSync())` 形式のこともある）は `push_token_sync_notifier.dart` を読んで合わせる。
- `deviceProvisioningProvider` の実プロバイダ名（`deviceProvisioningProvider` / `deviceProvisioningNotifierProvider`）は `device_provisioning_notifier.g.dart` の生成名に合わせる。
- 失敗ケースは**必ず非再試行エラー（400）を使う**。再試行可能エラー（500等）だと `RetryController` が指数バックオフ（2s〜）で最大6回再試行し、テストが分オーダーで遅くなる。
- `RegisteredDevice` のコンストラクタ形状が異なる場合は `v3_migration_workflow_test.dart` 冒頭の `_fakeDevice` 定義をそのままコピーする。

- [ ] **Step 2: テストが通ることを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices/device_provisioning_migration_test.dart`
Expected: 3件 PASS

- [ ] **Step 3: devices/migration 全体の回帰確認**

Run: `cd app && mise exec -- flutter test test/feature/devices test/feature/migration`
Expected: 全 PASS

- [ ] **Step 4: コミット**

```bash
git add app/test/feature/devices/device_provisioning_migration_test.dart
git commit -m "test: provision() の v2→v3 マイグレーション経路テストを追加"
```

---

## 実行後の残作業（コントローラーが実施、プランタスク外）

1. app 全体テスト＋`melos run analyze` 相当の確認、backend `pnpm check-types && pnpm lint`
2. backend PR 作成（`gh pr create --repo YumNumm/eqmonitor-backend`、base main）
3. app PR 作成（`gh pr create --repo YumNumm/EQMonitor`、base develop）。backend submodule pin はこの PR では**変更しない**（backend PR マージ後に別途）
4. 調査で見つかった懸念点の Issue 化（backend: 堅牢性グループ / app: 設計・UXグループ）
5. 最終 whole-branch レビュー

---

### Task 7: app — push_token_sync のテレメトリ記録を非致命化（残り2件のベースライン失敗修正）

**Files:**
- Modify: `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`（L100-107 / L116-123 / L131-138 の3つの telemetry ブロック）

**Interfaces:**
- Consumes: `telemetryRecorderProvider` / `telemetryUploaderProvider`（既存）、`TelemetryEvent.error(errorType:, message:)`
- Produces: シグネチャ変更なし。private ヘルパー `_recordSyncFailureTelemetry` を追加（public インターフェースではない）

**背景:** `sync()` の catch 節内の `ref.read(telemetryRecorderProvider)` が、テレメトリ provider の build 失敗時に ProviderException を同期 throw し、本来伝播すべき `DeviceProvisioningException`（認証復旧のトリガー）を握りつぶす。develop 上で `push_token_sync_auth_recovery_test.dart` の2テストがこれで失敗中（pre-existing）。テレメトリ（観測用副作用）は本処理の制御フローを壊してはならない。

- [ ] **Step 1: 失敗を確認（すでに失敗している）**

Run: `cd app && mise exec -- flutter test test/feature/devices/push_token_sync_auth_recovery_test.dart`
Expected: FAIL 2件（`which is not an instance of 'AuthorizationException'`、stack に `throwProviderException` → `push_token_sync_notifier.dart 101:17`）

- [ ] **Step 2: 実装 — telemetry ブロックを非致命ヘルパーに集約**

`push_token_sync_notifier.dart` に private メソッドを追加（クラス内、`_syncKind` の近く）:

```dart
  /// テレメトリは観測用の副作用であり、記録失敗（provider 初期化失敗を含む）が
  /// トークン同期やエラー伝播を壊してはならない。
  void _recordSyncFailureTelemetry(PushTokenKind kind, Object error) {
    try {
      unawaited(
        ref
            .read(telemetryRecorderProvider)
            .record(
              TelemetryEvent.error(
                errorType: 'push_token_sync_failed',
                message: '${kind.name}: $error',
              ),
            )
            .then((_) => ref.read(telemetryUploaderProvider).flush())
            .catchError((Object _) {}),
      );
    } on Object {
      // 非致命: 記録できない場合は黙って継続する
    }
  }
```

3箇所の `unawaited(ref.read(telemetryRecorderProvider).record(...).then(...))` ブロック（L100-107 / L116-123 / L131-138）をそれぞれ 1 行に置換:

```dart
          _recordSyncFailureTelemetry(kind, e);
```

（2つ目のブロックは元コードが `message: '${kind.name}: $e'` と生の DioException `e` を渡しているため、置換後も `_recordSyncFailureTelemetry(kind, e);` — mapped ではなく e を渡す。挙動を変えない）

- [ ] **Step 3: テストが通ることを確認**

Run: `cd app && mise exec -- flutter test test/feature/devices test/feature/migration`
Expected: 全 PASS（push_token_sync_auth_recovery_test.dart の2件を含む）

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart
git commit -m "fix: push token sync のテレメトリ記録失敗が認証エラー伝播を壊さないよう非致命化"
```
