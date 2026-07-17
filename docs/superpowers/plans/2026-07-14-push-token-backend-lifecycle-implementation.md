# Push Token Backend Lifecycle Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Token upsert時刻をDBへ記録し、30日以上更新されていないFCM/APNs tokenを原子的に削除するCLIを提供し、観測専用Live Activity update token経路を廃止する。

**Architecture:** `device_fcm_token`と`device_apns_token`へ`updated_at`を追加し、既存upsertが同値でも時刻を更新する。notification-resolverイメージへ独立cleanup entrypointを同梱し、注入した基準時刻に対してDrizzle transactionで行単位削除・種別集計する。Live Activityはpush-to-startとBroadcast Channelだけを残す。

**Tech Stack:** TypeScript 6, Drizzle ORM, PostgreSQL, Hono, Vite, Vitest, pnpm, Dart OpenAPI generator

## Global Constraints

- client implementation plan完了後にこのplanを実行し、生成Dart clientからupdate-token APIを削除してもappがcompile可能な状態にする。
- Backendの作業は`backend/` submodule内で行い、コミット・pushもsubmoduleを先に実施する。
- production codeより先に失敗するVitestを書き、REDを確認する。
- cleanup cutoffは`execution_started_at - 30 days`、比較は`updated_at <= cutoff`とする。
- FCMとAPNs削除は一つのDB transactionにする。
- デバイス本体、認証情報、通知設定は削除しない。
- 無効token応答による既存の即時削除経路は維持する。
- per-activity update tokenのAPI、DB、resolver書込、metricsを同一変更セットで削除する。
- 生成ファイルを手編集せず、指定generatorを実行する。

---

### Task 1: Token Timestamp Schema and Upsert Semantics

**Files:**
- Modify: `backend/packages/database/src/schema/schema.ts`
- Modify: `backend/api/api/src/features/device/datasource/datasource.ts`
- Modify: `backend/api/api/test/datasource/device-datasource.test.ts`
- Generate: `backend/packages/database/drizzle/` (the timestamped directory created by `drizzle-kit:generate`)

**Interfaces:**
- Produces: non-null `deviceFcmToken.updatedAt` and `deviceApnsToken.updatedAt` string timestamps.
- Produces: indexes `device_fcm_token_updated_at_idx` and `device_apns_token_updated_at_idx`.
- Consumes: existing `DeviceDatasource.upsertFcmToken` and `upsertApnsToken` callers unchanged.

- [ ] **Step 1: Add failing datasource tests**

In the existing datasource test helpers, freeze `new Date()` with Vitest fake timers. Assert both insert values and conflict-update sets contain the same ISO timestamp:

```ts
vi.useFakeTimers();
vi.setSystemTime(new Date('2026-07-14T00:00:00.000Z'));

await datasource.upsertFcmToken('device-1', 'fcm-token');
expect(mockValues).toHaveBeenCalledWith({
  deviceId: 'device-1',
  token: 'fcm-token',
  updatedAt: '2026-07-14T00:00:00.000Z',
});
expect(mockOnConflict).toHaveBeenCalledWith(expect.objectContaining({
  set: {
    token: 'fcm-token',
    updatedAt: '2026-07-14T00:00:00.000Z',
  },
}));
```

Repeat for APNs and include the existing environment in the set.

- [ ] **Step 2: Verify RED**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/api test -- test/datasource/device-datasource.test.ts`

Expected: FAIL because timestamp fields are absent.

- [ ] **Step 3: Add schema fields and set timestamps on every upsert**

Add this field to both token tables:

```ts
updatedAt: timestamp('updated_at', { mode: 'string', withTimezone: true })
  .defaultNow()
  .notNull(),
```

Add a btree index on each `updatedAt`. In each datasource upsert capture `const updatedAt = new Date().toISOString()` once and use it in insert and conflict-update values. Preserve unique-token owner deletion and APNs environment selection.

- [ ] **Step 4: Verify GREEN**

Run the focused datasource test; expected PASS.

- [ ] **Step 5: Generate and inspect migration**

Run: `cd backend/packages/database && mise exec -- pnpm drizzle-kit:generate`

Expected migration SQL adds both columns as `NOT NULL DEFAULT now()` and both indexes without dropping token constraints.

Run: `cd backend/packages/database && mise exec -- pnpm drizzle-kit:check`

Expected: exit 0.

- [ ] **Step 6: Commit**

```bash
git -C backend add packages/database/src/schema/schema.ts packages/database/drizzle api/api/src/features/device/datasource/datasource.ts api/api/test/datasource/device-datasource.test.ts
git -C backend commit -m "feat: 通知トークンの更新日時を記録"
```

### Task 2: Atomic Stale Token Cleanup Repository

**Files:**
- Create: `backend/service/notification-resolver/src/repository/stale-device-token.ts`
- Create: `backend/service/notification-resolver/test/repository/stale-device-token.test.ts`

**Interfaces:**
- Produces: `StaleDeviceTokenCleanupReport` with `startedAt`, `finishedAt`, `cutoff`, and three deletion counts.
- Produces: `StaleDeviceTokenRepository.cleanup(startedAt?: Date): Promise<StaleDeviceTokenCleanupReport>`.
- Consumes: injected `Database`; does not create its own connection in tests.

- [ ] **Step 1: Write failing boundary/count tests**

Use a mocked Drizzle transaction whose FCM delete returns two rows and APNs delete returns one `NOTIFICATION` and two `LIVE_ACTIVITY_START` rows. Assert:

```ts
expect(report).toEqual({
  status: 'success',
  startedAt: '2026-07-14T00:00:00.000Z',
  finishedAt: '2026-07-14T00:00:01.000Z',
  cutoff: '2026-06-14T00:00:00.000Z',
  deleted: {
    fcm: 2,
    apnsNotification: 1,
    apnsPushToStart: 2,
    total: 5,
  },
});
```

Compile the Drizzle where expressions and assert they use `<= cutoff`, not `< cutoff`. Add a test where the APNs delete throws and assert the transaction rejects without returning a partial report. Add a second-run test with empty returned rows and all counts zero.

- [ ] **Step 2: Verify RED**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/repository/stale-device-token.test.ts`

Expected: FAIL because repository/report types are missing.

- [ ] **Step 3: Implement cleanup transaction**

Use one `db.transaction(async tx => ...)`. Delete FCM rows with `.where(lte(deviceFcmToken.updatedAt, cutoffIso)).returning({ deviceId })`. Delete APNs rows with the same cutoff and `.returning({ type })`; count the two APNs types from returned rows. Calculate cutoff from a copy of `startedAt` using milliseconds (`30 * 24 * 60 * 60 * 1000`) so the definition is fixed 30 days, not calendar-month subtraction.

The repository constructor accepts:

```ts
constructor(
  private readonly db: Database,
  private readonly now: () => Date = () => new Date(),
) {}
```

Expose `cleanup(startedAt: Date = this.now())`; use `this.now()` again only for `finishedAt`.

- [ ] **Step 4: Verify GREEN and commit**

Run the focused repository test; expected PASS.

```bash
git -C backend add service/notification-resolver/src/repository/stale-device-token.ts service/notification-resolver/test/repository/stale-device-token.test.ts
git -C backend commit -m "feat: 期限切れ通知トークン削除を追加"
```

### Task 3: Cleanup CLI and Resolver Image Entry

**Files:**
- Create: `backend/service/notification-resolver/src/cli/cleanup-device-tokens.ts`
- Create: `backend/service/notification-resolver/test/cli/cleanup-device-tokens.test.ts`
- Modify: `backend/service/notification-resolver/vite.config.ts`
- Modify: `backend/service/notification-resolver/package.json`

**Interfaces:**
- Produces executable: `node dist/cleanup-device-tokens.mjs`.
- Produces one JSON report on stdout and exit code 0 on success; one JSON error report on stderr and exit code 1 on failure.
- Consumes: `DATABASE_URL`, `getDatabase`, `StaleDeviceTokenRepository`.

- [ ] **Step 1: Write failing CLI tests around an exported runner**

Define the intended interface in tests:

```ts
const exitCode = await runDeviceTokenCleanup({
  databaseUrl: 'postgres://test',
  createRepository: () => fakeRepository,
  stdout: value => output.push(value),
  stderr: value => errors.push(value),
});
expect(exitCode).toBe(0);
expect(JSON.parse(output[0])).toEqual(successReport);
```

Add failure cases for missing `DATABASE_URL` and repository rejection. Verify errors do not include the database URL.

- [ ] **Step 2: Verify RED**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/cli/cleanup-device-tokens.test.ts`

Expected: FAIL because CLI runner is missing.

- [ ] **Step 3: Implement runner and process adapter**

Export `runDeviceTokenCleanup` with injected output/repository factory. At module bottom, create the database with `getDatabase`, call the runner with `process.env.DATABASE_URL`, write JSON with `console.log`/`console.error`, close the pool in `finally` with `await db.$client.end()`, and assign `process.exitCode` without calling `process.exit()`.

- [ ] **Step 4: Add a second Vite entry**

Change `build.ssr` to named entries and preserve the existing names:

```ts
ssr: {
  index: 'src/index.ts',
  'cleanup-device-tokens': 'src/cli/cleanup-device-tokens.ts',
},
rollupOptions: {
  output: { entryFileNames: '[name].mjs' },
},
```

Add package script `cleanup:device-tokens: "node dist/cleanup-device-tokens.mjs"`.

- [ ] **Step 5: Verify tests and built artifact**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/cli/cleanup-device-tokens.test.ts`

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver build`

Expected: test PASS and both `dist/index.mjs` and `dist/cleanup-device-tokens.mjs` exist.

- [ ] **Step 6: Commit**

```bash
git -C backend add service/notification-resolver
git -C backend commit -m "feat: 通知トークン削除CLIを追加"
```

### Task 4: Remove Backend per-activity Update Token Path

**Files:**
- Delete: `backend/api/api/src/features/device/routes/live-activity.ts`
- Delete: `backend/service/notification-resolver/src/repository/live-activity-token.ts`
- Modify: `backend/api/api/src/features/device/routes/device.ts`
- Modify: `backend/api/api/src/features/device/datasource/datasource.ts`
- Modify: `backend/api/api/src/features/device/model/requests.ts`
- Modify: `backend/api/api/src/features/device/model/responses.ts`
- Modify: `backend/api/api/src/metrics.ts`
- Delete: `backend/api/api/test/device/live-activity-routes.test.ts`
- Modify: `backend/api/api/test/datasource/device-datasource.test.ts`
- Modify: `backend/api/api/test/helpers/mock-db.ts`
- Modify: `backend/packages/database/src/schema/schema.ts`
- Modify: `backend/packages/database/src/schema/relations.ts`
- Modify: `backend/service/notification-resolver/src/handlers/eew/message-generator.ts`
- Modify: `backend/service/notification-resolver/src/handlers/shake-detection/handler.ts`
- Modify: `backend/service/notification-resolver/src/index.ts`
- Modify: `backend/service/notification-resolver/test/message/eew-message.test.ts`
- Modify: `backend/service/notification-resolver/test/message/shake-detection-message.test.ts`
- Generate: same Drizzle migration series from Task 1 with `DROP TABLE live_activity_update_token`

**Interfaces:**
- Removes: `/v2/device/me/live-activity` GET and token PUT/DELETE endpoints, update-token persistence, latency Histogram, missing-token Gauge.
- Preserves: push-to-start APNs messages and Broadcast start channel/update/end payloads.

- [ ] **Step 1: Add/strengthen delivery regression tests before deletion**

In EEW and shake message tests, assert start messages still use the device push-to-start token and include `input-push-channel`. Assert update/end messages use `apns-channel-id` and a Broadcast URL, and never contain an activity update token.

```ts
expect(startMessage.token).toBe('push-to-start-token');
expect(startMessage.payload.aps['input-push-channel']).toBe(channelId);
expect(updateMessage.headers['apns-channel-id']).toBe(channelId);
expect(JSON.stringify(updateMessage)).not.toContain('updateToken');
```

- [ ] **Step 2: Run regression tests before removal**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/message/eew-message.test.ts test/message/shake-detection-message.test.ts`

Expected: new assertions PASS on current Broadcast behavior.

- [ ] **Step 3: Remove API and datasource contracts**

Delete route registration and file. Remove live-activity request/response Valibot schemas and the four datasource methods for list/get/update/delete. Remove API tests and mock query entries that exist only for this table. Remove `liveActivityTokenLatencyHistogram` and all imports.

- [ ] **Step 4: Remove resolver writes and Gauge**

Delete `LiveActivityTokenRepository`, its construction, `createLiveActivityTokens` calls after EEW/shake starts, the periodic missing-token query, and its Gauge definition. Start enqueue failures and Broadcast behavior must remain unchanged.

- [ ] **Step 5: Remove schema and relation**

Delete `liveActivityUpdateToken` and the `devices.liveActivityUpdateTokens` relation. Regenerate the migration after the final schema shape so it both adds token timestamps/indexes and drops the observation table.

- [ ] **Step 6: Verify focused tests and forbidden references**

Run resolver regression tests and API datasource/device route tests.

Run:

```bash
rg -n "liveActivityUpdateToken|live_activity_update_token|liveActivityTokenLatencyHistogram|createLiveActivityTokens|start_without_update_token" backend/api backend/packages backend/service
```

Expected: no source/test matches outside migration snapshots and historical docs.

- [ ] **Step 7: Commit**

```bash
git -C backend add api packages/database service/notification-resolver
git -C backend commit -m "refactor: Live Activity更新トークン経路を削除"
```

### Task 5: Regenerate OpenAPI and Dart Client

**Files:**
- Generate: `backend/api/api/openapi.json`
- Generate: `backend/api/api-stub/generated/contract-fixtures/**`
- Generate: `packages/eqmonitor_api/openapi/openapi.json`
- Generate: `packages/eqmonitor_api/lib/src/**`
- Generate: `packages/eqmonitor_api/test/fixtures/contract/**`

**Interfaces:**
- Removes generated update-token client methods and models.
- Preserves generated FCM/APNs endpoints used by the client plan.

- [ ] **Step 1: Regenerate backend OpenAPI and fixtures**

Run: `cd backend/api/api && mise exec -- pnpm --silent generate:openapi > openapi.json`

Run: `cd backend/api/api-stub && mise exec -- pnpm generate:fixtures`

Expected: generated OpenAPI contains `/v2/device/me/fcm` and `/v2/device/me/apns/{kind}`, but no `/v2/device/me/live-activity` path.

- [ ] **Step 2: Commit and push backend submodule**

```bash
git -C backend add api/api/openapi.json api/api-stub/generated/contract-fixtures
git -C backend commit -m "chore: Live Activity API契約を更新"
git -C backend push origin main
```

- [ ] **Step 3: Regenerate Dart API package**

Run: `cd packages/eqmonitor_api && mise exec -- dart run bin/generate.dart`

Expected: `DeviceApiClient` no longer contains live-activity update-token methods, and `live_activity_token_request/response` files are removed by regeneration.

- [ ] **Step 4: Verify API package**

Run: `cd packages/eqmonitor_api && mise exec -- dart test`

Run: `cd packages/eqmonitor_api && mise exec -- dart analyze`

Expected: PASS.

- [ ] **Step 5: Commit root generated changes and submodule pin**

```bash
git add backend packages/eqmonitor_api
git commit -m "chore: 通知トークンAPIクライアントを更新"
```

### Task 6: Backend Regression Verification

**Files:**
- Modify only files required by formatter, linter, or test findings from Tasks 1-5.

**Interfaces:**
- Verifies the backend lifecycle contract; produces no new API.

- [ ] **Step 1: Run focused tests**

Run:

```bash
cd backend
mise exec -- pnpm --filter @eqmonitor-backend/api test -- test/datasource/device-datasource.test.ts test/device/device-routes.test.ts
mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/repository/stale-device-token.test.ts test/cli/cleanup-device-tokens.test.ts test/message/eew-message.test.ts test/message/shake-detection-message.test.ts
```

Expected: PASS.

- [ ] **Step 2: Run typecheck, lint, API tests, and resolver tests**

Run:

```bash
cd backend
mise exec -- pnpm check-types
mise exec -- pnpm lint
mise exec -- pnpm --filter @eqmonitor-backend/api test
mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test
```

Expected: all exit 0 with no warnings.

- [ ] **Step 3: Validate migration and build**

Run:

```bash
cd backend/packages/database
mise exec -- pnpm drizzle-kit:check
cd ../../service/notification-resolver
mise exec -- pnpm build
test -f dist/cleanup-device-tokens.mjs
```

Expected: schema check and build pass; cleanup entry exists.

- [ ] **Step 4: Commit and push verification fixes**

```bash
git -C backend add api packages service
git -C backend commit -m "test: 通知トークンライフサイクルを検証"
git -C backend push origin main
git add backend
git commit -m "chore: Backend参照を更新"
```
