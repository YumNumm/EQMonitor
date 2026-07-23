# Full Realtime Payloads Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Earthquake・EEW・揺れ検知の完全な REST read model を WebSocket で配信し、OpenAPI 生成型で parse して REST 再取得なしにアプリのメモリ状態を更新する。

**Architecture:** backend の REST route と realtime publisher は共有 repository/transformer を利用する。Valibot の realtime union を OpenAPI components に追加し、生成された `eqmonitor_api` 型を WebSocket parser と feature providers が利用する。Earthquake/EEW は record upsert、揺れ検知は active snapshot 置換とする。

**Tech Stack:** TypeScript 6、Valibot、Drizzle、Hono OpenAPI、Vitest、Dart 3.11、Freezed/json_serializable、Riverpod 3、Flutter test、mise。

## Global Constraints

- 旧 WebSocket payload との後方互換性は実装しない。
- event 受信時に REST を呼ばない。REST は `ready` 後の初期同期と再接続時だけ使用する。
- backend Valibot schema と生成 OpenAPI を payload 型の正本にする。
- upsert の full record 構築に失敗した場合、partial payload を publish しない。
- full payload を切り詰めず、既存の backpressure と payload byte metrics を維持する。
- Flutter/Dart コマンドは常に `mise exec --` 経由で実行する。
- backend コマンドもルートから `mise exec -- pnpm --dir backend ...` を使用する。
- generated Dart/OpenAPI files は生成コマンドで更新し、手編集しない。

---

## File map

### Backend shared models

- Create `backend/packages/types/src/shake-detection.ts`: active snapshot と full event schema。
- Modify `backend/packages/types/src/index.ts`: shake detection schemas を export。
- Create `backend/packages/database/src/repository/earthquake-detail.ts`: full Earthquake relations query。
- Move `backend/api/api/src/features/earthquake/transformer/earthquake-transformer.ts` to `backend/packages/database/src/transformers/earthquake-transformer.ts`: REST/publisher 共通変換。
- Move `backend/api/api/src/features/earthquake/transformer/earthquake-intensity-tree-transformer.ts` to `backend/packages/database/src/transformers/earthquake-intensity-tree-transformer.ts`。
- Create `backend/packages/database/src/repository/shake-detection-active.ts`: active snapshot query/build。
- Modify `backend/packages/database/src/index.ts`: shared repository/transformer exports。

### Backend contracts and publishers

- Modify `backend/packages/notification-common/src/types/realtime.ts`: new full envelope union。
- Modify `backend/service/telegram-db-writer/src/realtime/publish-telegram-realtime.ts`: full Earthquake と normalized EEW publish。
- Modify `backend/service/notification-resolver/src/realtime/publish-shake.ts`: DB 再構成 active snapshot publish。
- Modify `backend/service/notification-resolver/src/handlers/shake-detection/handler.ts`: DB write 後 publisher に DB を渡す。
- Create/modify `backend/api/api/src/features/shake-detection/`: active REST route と shared repository 利用。
- Modify `backend/api/api/bin/generate-openapi.ts`: realtime schemas を components に追加。
- Modify `backend/app/specs/backend/realtime/websocket.md` and `shake-detection.md`: canonical contract。

### Generated Dart and app

- Regenerate `backend/api/api/openapi.json` and `packages/eqmonitor_api/` generated sources。
- Replace handwritten domain payload classes under `packages/eqmonitor_websocket/lib/src/` with generated API payload types。
- Modify `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart`: lossless generated records。
- Modify `app/lib/core/realtime/model/realtime_event.dart`: full records/snapshot。
- Modify Earthquake, EEW, and shake detection providers to apply in-memory records directly。

---

### Task 1: Define full realtime schemas and expose them through OpenAPI

**Files:**
- Create: `backend/packages/types/src/shake-detection.ts`
- Modify: `backend/packages/types/src/index.ts`
- Modify: `backend/packages/notification-common/src/types/realtime.ts`
- Test: `backend/packages/notification-common/src/types/realtime.test.ts`
- Modify: `backend/api/api/bin/generate-openapi.ts`
- Create: `backend/api/api/bin/append-realtime-schemas.ts`
- Test: `backend/api/api/bin/append-realtime-schemas.test.ts`

**Interfaces:**
- Produces: `RealtimeEarthquakeUpsertPayloadSchema`, `RealtimeEarthquakeDeletePayloadSchema`, `RealtimeEewUpsertPayloadSchema`, `RealtimeShakeDetectionSnapshotPayloadSchema`, `RealtimeEventEnvelopeSchema`。
- Produces: `ShakeDetectionActiveSnapshotSchema` shared by REST and realtime。

- [ ] **Step 1: Write failing contract tests**

Add fixtures that parse a full Earthquake containing `intensity.intensity_tree`, `telegrams`, and `catalog`; parse EEW `warning`; parse a shake snapshot containing `points`, `mergedEvents`, and `correlatedEew`. Also assert that the old uppercase `EEW`, old `shake_detected`, and Earthquake partial record throw.

```ts
expect(() =>
  parseRealtimeEventEnvelope({
    type: 'earthquake',
    operation: 'upsert',
    event_id: fullEarthquake.event_id,
    record: partialEarthquake,
  }),
).toThrow();

const parsed = parseRealtimeEventEnvelope({
  type: 'eew',
  operation: 'upsert',
  event_id: fullEew.event_id,
  record: fullEew,
});
expect(parsed.type).toBe('eew');
```

- [ ] **Step 2: Verify RED**

Run: `mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-common test -- src/types/realtime.test.ts`

Expected: FAIL because the new schemas and lowercase EEW discriminator do not exist.

- [ ] **Step 3: Add the active shake detection schemas**

Define the API-shape schema with snake/camel names matching the existing generated API contract exactly:

```ts
export const ShakeDetectionActiveSnapshotSchema = v.pipe(
  v.object({
    type: v.literal('shake_detection'),
    revision: v.number(),
    responseAt: v.pipe(v.string(), v.isoTimestamp()),
    events: v.array(ShakeDetectionActiveEventSchema),
  }),
  v.metadata({ ref: 'ShakeDetectionActiveSnapshot' }),
);
```

`ShakeDetectionActiveEventSchema` must include `eventId`, `serialNo`, `createdAt`, `updatedAt`, `expiresAt`, `level`, `changeReasons`, `mergedEvents`, `pointCount`, `region`, `points`, optional `test`, and optional `correlatedEew`.

- [ ] **Step 4: Replace the realtime union**

Use `Earthquake`, `EewItemWithRelations`, and `ShakeDetectionActiveSnapshotSchema` directly:

```ts
export const RealtimeEarthquakeUpsertPayloadSchema = v.object({
  type: v.literal('earthquake'),
  operation: v.literal('upsert'),
  event_id: v.string(),
  record: Earthquake,
});

export const RealtimeEewUpsertPayloadSchema = v.object({
  type: v.literal('eew'),
  operation: v.literal('upsert'),
  event_id: v.string(),
  record: EewItemWithRelations,
});

export const RealtimeShakeDetectionSnapshotPayloadSchema = v.object({
  type: v.literal('shake_detection'),
  operation: v.literal('snapshot'),
  record: ShakeDetectionActiveSnapshotSchema,
});
```

Create a separate Earthquake delete schema and form `RealtimeEventEnvelopeSchema` with `v.variant('type', ...)`; for the two Earthquake operations use a nested `v.variant('operation', ...)` member so upsert requires `record` and delete forbids it.

- [ ] **Step 5: Verify schema tests GREEN**

Run the Step 2 command.

Expected: PASS; old payload assertions remain rejected.

- [ ] **Step 6: Add OpenAPI component injection test**

Test `appendRealtimeSchemas(spec)` and assert:

```ts
expect(spec.components?.schemas).toHaveProperty(
  'RealtimeEventEnvelope',
);
expect(
  JSON.stringify(spec.components?.schemas?.RealtimeEventEnvelope),
).toContain('discriminator');
```

- [ ] **Step 7: Verify OpenAPI test RED**

Run: `mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api test -- bin/append-realtime-schemas.test.ts`

Expected: FAIL because the helper does not exist.

- [ ] **Step 8: Implement OpenAPI component injection**

Use `@valibot/to-json-schema` to convert each public schema, promote it into `components.schemas`, and explicitly attach `discriminator.propertyName = 'type'` to `RealtimeEventEnvelope`. Call the helper after `generateSpecs` and before nullable patching:

```ts
const specs = await generateSpecs(app, openapiConfig);
appendRealtimeSchemas(specs);
patchOpenApiOptionalPropertiesNullable(specs);
```

Do not add a fake HTTP route.

- [ ] **Step 9: Verify OpenAPI test GREEN and generate spec**

Run:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api test -- bin/append-realtime-schemas.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api generate:openapi
```

Expected: PASS and `backend/api/api/openapi.json` contains all five realtime components.

- [ ] **Step 10: Commit backend schemas**

```bash
git -C backend add packages/types packages/notification-common api/api/bin api/api/openapi.json
git -C backend commit -m "feat: 完全Realtimeペイロード型をOpenAPIへ追加"
```

---

### Task 2: Share the full Earthquake read model

**Files:**
- Create: `backend/packages/database/src/repository/earthquake-detail.ts`
- Move: the two API Earthquake transformer files into `backend/packages/database/src/transformers/`
- Modify: `backend/packages/database/src/index.ts`
- Modify: `backend/api/api/src/features/earthquake/datasource/datasource.ts`
- Modify: `backend/api/api/src/features/earthquake/routes/earthquake.ts`
- Test: `backend/packages/database/src/transformers/earthquake-transformer.test.ts`
- Test: `backend/api/api/test/earthquake/earthquake-routes.test.ts`

**Interfaces:**
- Produces: `EarthquakeDetailRepository.findByEventId(eventId: string): Promise<EarthquakeDetailResult | null>`。
- Produces: `EarthquakeTransformer.toEarthquake(data: EarthquakeDetailResult): Earthquake`。

- [ ] **Step 1: Write a failing shared transformer test**

Construct an `EarthquakeDetailResult` containing region/city/station intensity rows, telegram comments, and catalog rows. Assert the output includes `intensity_tree`, `telegrams`, comments, and catalog.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database test -- src/transformers/earthquake-transformer.test.ts`

Expected: FAIL because the database package does not export the full transformer.

- [ ] **Step 3: Move the existing proven transformers**

Use `git mv` for both transformer files, replace API-local type imports with the new `EarthquakeDetailResult`, and keep conversion behavior unchanged. Export them from `packages/database/src/index.ts`.

- [ ] **Step 4: Add the detail repository**

Implement one Drizzle query with all relations currently selected by `EarthquakeDatasource.findEarthquakeByEventId`: regions, prefectures, cities, stations, telegrams with comments, catalog hypocenters/stations/links. Return `null` when absent.

- [ ] **Step 5: Delegate the REST route to shared code**

Keep list/search behavior in the API datasource. Replace only detail query/transformation with `EarthquakeDetailRepository` and the shared transformer.

- [ ] **Step 6: Verify GREEN and no REST regression**

Run:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database test -- src/transformers/earthquake-transformer.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api test -- test/earthquake/earthquake-routes.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database check-types
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api type-check
```

Expected: all PASS.

- [ ] **Step 7: Commit shared read model**

```bash
git -C backend add packages/database api/api/src/features/earthquake
git -C backend commit -m "refactor: 地震詳細Read Modelを共有"
```

---

### Task 3: Publish full Earthquake and normalized EEW records

**Files:**
- Modify: `backend/service/telegram-db-writer/src/realtime/publish-telegram-realtime.ts`
- Test: `backend/service/telegram-db-writer/__tests__/publish-telegram-realtime.test.ts`
- Modify: `backend/service/telegram-db-writer/README.md`

**Interfaces:**
- Consumes: shared Earthquake detail repository/transformer and existing `toEewItemWithRelations`。
- Produces: new Earthquake/EEW realtime envelopes.

- [ ] **Step 1: Change publisher tests first**

Assert Earthquake publish includes full transformer output and EEW uses:

```ts
event: {
  type: 'eew',
  operation: 'upsert',
  event_id: item.event_id,
  record: item,
}
```

Add a test that a missing/invalid full Earthquake read model performs no publish and logs the failure.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- pnpm --dir backend --filter @eqmonitor-backend/telegram-db-writer test -- __tests__/publish-telegram-realtime.test.ts`

Expected: FAIL with partial Earthquake and uppercase EEW output.

- [ ] **Step 3: Implement full publishers**

Replace `EarthquakePartialRepository/toEarthquakePartial` with `EarthquakeDetailRepository/toEarthquake`. Make upsert return without publish when DB/read model is unavailable. Preserve delete publication without record.

- [ ] **Step 4: Verify GREEN and types**

Run:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/telegram-db-writer test -- __tests__/publish-telegram-realtime.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/telegram-db-writer check-types
```

Expected: PASS.

- [ ] **Step 5: Commit publisher**

```bash
git -C backend add service/telegram-db-writer
git -C backend commit -m "fix: 地震とEEWの完全データをRealtime配信"
```

---

### Task 4: Build and publish full shake detection active snapshots

**Files:**
- Create: `backend/packages/database/src/repository/shake-detection-active.ts`
- Modify: `backend/packages/database/src/schema/schema.ts`
- Generate and rename: `backend/packages/database/drizzle/20260723130000_shake_detection_active_snapshot/migration.sql` and `snapshot.json`
- Modify: `backend/packages/database/src/index.ts`
- Create: `backend/api/api/src/features/shake-detection/routes/shake-detection.ts`
- Modify: `backend/api/api/src/index.ts`
- Modify: `backend/service/notification-resolver/src/realtime/publish-shake.ts`
- Modify: `backend/service/notification-resolver/src/repository/shake-detection.ts`
- Modify: `backend/service/notification-resolver/src/handlers/shake-detection/handler.ts`
- Test: repository test, API route test, and `backend/service/notification-resolver/test/realtime/publish-shake.test.ts`

**Interfaces:**
- Produces: `ShakeDetectionActiveRepository.fetch(now: Date): Promise<ShakeDetectionActiveSnapshot>`。
- Publisher consumes the repository after DB write and publishes `operation: 'snapshot'`.

- [ ] **Step 1: Write failing repository and publisher tests**

Repository fixture must include two serials, an expired event, merged event IDs, points, and correlated EEW. Assert only active canonical latest records appear and all fields survive. Publisher test must assert the full snapshot envelope.

- [ ] **Step 2: Verify RED**

Run:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database test -- src/repository/shake-detection-active.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-resolver test -- test/realtime/publish-shake.test.ts
```

Expected: FAIL because the active repository and snapshot publisher do not exist.

- [ ] **Step 3: Persist every field required by the full event**

Extend the producer/input schema to require `updatedAt`, `expiresAt`, `changeReasons`, and `mergedEvents`; persist them together with optional `correlatedEew` and a database-generated monotonic `revision`. Do not derive expiry or merge data from guessed constants. Generate the Drizzle migration with the repository command and inspect both SQL and snapshot.

- [ ] **Step 4: Implement active snapshot repository**

Query non-expired shake events, select the latest serial per canonical event, preserve JSON points, derive region coordinates without rounding, and include merge/correlation fields. Snapshot revision is the maximum persisted monotonic revision; `responseAt` is the read time.

- [ ] **Step 5: Implement/align the active REST route**

Expose `GET /v2/shake-detection/active` using exactly `ShakeDetectionActiveSnapshotSchema` and the shared repository. Return the shared object without a second mapper.

- [ ] **Step 6: Publish after persistence**

Change `publishShakeRealtime` to accept `ShakeDetectionActiveRepository`, fetch the active snapshot after write/merge, validate it, and publish:

```ts
event: {
  type: 'shake_detection',
  operation: 'snapshot',
  record: snapshot,
}
```

- [ ] **Step 7: Verify GREEN**

Run:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database test -- src/repository/shake-detection-active.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api test -- test/shake-detection/shake-detection-routes.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-resolver test -- test/realtime/publish-shake.test.ts
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database check-types
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api type-check
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-resolver check-types
```

Expected: all PASS.

- [ ] **Step 8: Commit shake snapshot**

```bash
git -C backend add packages/database api/api/src service/notification-resolver
git -C backend commit -m "feat: 揺れ検知の完全SnapshotをRealtime配信"
```

---

### Task 5: Regenerate Dart API types and parse WebSocket data with them

**Files:**
- Generated: `packages/eqmonitor_api/openapi/openapi.json`, models, exports
- Modify: `packages/eqmonitor_api/bin/generate.dart`
- Modify: `packages/eqmonitor_websocket/lib/src/realtime_event_envelope.dart`
- Remove: `packages/eqmonitor_websocket/lib/src/ws_shake_detection_snapshot.dart`
- Remove: `packages/eqmonitor_websocket/lib/src/ws_shake_observation_point.dart`
- Remove: `packages/eqmonitor_websocket/lib/src/ws_shake_payload.dart`
- Remove: `packages/eqmonitor_websocket/lib/src/ws_snapshot_data.dart`
- Remove: their generated `.freezed.dart` and `.g.dart` parts
- Test: `packages/eqmonitor_websocket/test/ws_message_test.dart`

**Interfaces:**
- Produces generated concrete realtime payload classes plus a generated `RealtimeEventEnvelope` sealed dispatcher.

- [ ] **Step 1: Add failing Dart contract fixtures**

Copy representative backend JSON fixtures into tests. Assert full Earthquake trees/telegrams/catalog, EEW warning, and shake points/merged/correlation parse. Assert old payloads throw `CheckedFromJsonException`.

- [ ] **Step 2: Verify RED**

Run: `mise exec -- dart test packages/eqmonitor_websocket/test/ws_message_test.dart`

Expected: FAIL because generated realtime classes do not exist and current models expect partial/old snapshot forms.

- [ ] **Step 3: Generate API client**

Extend `packages/eqmonitor_api/bin/generate.dart` so every generation run reads the `RealtimeEventEnvelope` discriminator and deterministically emits the sealed dispatcher after `swagger_parser` emits the concrete OpenAPI payload classes. The dispatcher may select a generated concrete class by `type` and `operation`, but must not redeclare any payload fields.

Run: `mise exec -- dart run packages/eqmonitor_api/bin/generate.dart`

- [ ] **Step 4: Simplify WebSocket parser**

Keep `WsMessage` outer parsing. Parse `data` through generated realtime payload classes and export those types from `eqmonitor_api`. Delete superseded Freezed payload models and generation parts.

- [ ] **Step 5: Regenerate local Freezed files**

Run from the EQMonitor repository root: `mise exec -- dart run build_runner build --delete-conflicting-outputs`.

- [ ] **Step 6: Verify GREEN**

Run:

```bash
mise exec -- dart test packages/eqmonitor_websocket/test/ws_message_test.dart
mise exec -- dart analyze packages/eqmonitor_api packages/eqmonitor_websocket
```

Expected: PASS with no warnings.

- [ ] **Step 7: Commit generated contract**

```bash
git add packages/eqmonitor_api packages/eqmonitor_websocket
git commit -m "feat: OpenAPI生成型でRealtimeを解析"
```

---

### Task 6: Apply full realtime records to app memory without REST

**Files:**
- Modify: `app/lib/core/realtime/model/realtime_event.dart`
- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
- Modify: `app/lib/feature/eew/data/eew.dart`
- Modify: `app/lib/feature/shake_detection/data/model/shake_detection_event.dart`
- Modify: `app/lib/feature/shake_detection/data/model/shake_detection_snapshot.dart`
- Modify: `app/lib/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart`
- Modify: `app/lib/feature/shake_detection/data/provider/shake_detection_provider.dart`
- Test: `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`
- Create test: `app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart`
- Create test: `app/test/feature/eew/data/eew_realtime_test.dart`
- Create test: `app/test/feature/shake_detection/data/shake_detection_realtime_snapshot_test.dart`

**Interfaces:**
- Produces lossless `RealtimeEarthquakeUpsertEvent(record: api.Earthquake)`, `RealtimeEewUpsertEvent(record: api.EewItemWithRelations)`, and `RealtimeShakeSnapshotEvent(record: api.ShakeDetectionActiveSnapshot)`.

- [ ] **Step 1: Write failing mapper tests**

Assert identity/equality of the full generated records and explicitly inspect fields previously lost: earthquake telegram comments, EEW warning zones, shake point code and merged event ID.

- [ ] **Step 2: Verify mapper RED**

Run: `mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

Expected: FAIL because mapper accepts old event variants and converts shake data to a lossy DTO.

- [ ] **Step 3: Make mapper lossless**

Replace reconstructed models with the generated records directly. Search `RealtimeShakeEventData` references with `rg`; update every reference in the listed shake files, then delete the obsolete type from `realtime_event.dart`.

- [ ] **Step 4: Write failing provider tests**

Use `ProviderContainer` overrides and a repository spy. Cover:

```dart
expect(repository.detailFetchCount, 1); // initial load only
controller.add(matchingFullEarthquakeEvent);
await container.pump();
expect(container.read(detailsProvider(eventId)).value, updatedEarthquake);
expect(repository.detailFetchCount, 1); // no realtime REST fetch
```

Add another-event no-op, EEW newer/older serial, and shake newer revision/full snapshot replacement tests.

- [ ] **Step 5: Verify provider RED**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart
mise exec -- flutter test app/test/feature/eew/data/eew_realtime_test.dart
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_realtime_snapshot_test.dart
```

Expected: Earthquake details stay stale and shake fields are absent.

- [ ] **Step 6: Implement provider updates**

Convert full API Earthquake to the app display model once and replace matching detail state. Derive list partial presentation from the same full record. Keep generated EEW/shake records in the accepted in-memory source of truth and derive existing UI models without dropping source fields.

- [ ] **Step 7: Verify GREEN and broader feature slice**

Run the four Step 5 commands, then:

```bash
mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_upsert_test.dart
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_provider_test.dart
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_repository_test.dart
mise exec -- flutter analyze app/lib/core/realtime app/lib/feature/earthquake_history app/lib/feature/eew app/lib/feature/shake_detection
```

- [ ] **Step 8: Commit app update**

```bash
git add app/lib app/test
git commit -m "fix: 完全Realtimeデータで画面状態を更新"
```

---

### Task 7: Update specifications and verify the end-to-end contract

**Files:**
- Modify: `backend/app/specs/backend/realtime/websocket.md`
- Modify: `backend/app/specs/backend/realtime/shake-detection.md`
- Modify: `backend/service/telegram-db-writer/README.md`
- Update: backend gitlink in parent repository

- [ ] **Step 1: Update canonical backend specs**

Document exact envelope JSON, required records, REST-equivalent schemas, no compatibility, ready/REST semantics, and payload size observability.

- [ ] **Step 2: Run backend verification**

Run every backend test command listed in Tasks 1-4, then:

```bash
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-common build
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/database check-types
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/telegram-db-writer check-types
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/notification-resolver check-types
mise exec -- pnpm --dir backend --filter @eqmonitor-backend/api type-check
git -C backend diff --check
```

Expected: all PASS and clean diff check.

- [ ] **Step 3: Run parent verification**

```bash
mise exec -- dart test packages/eqmonitor_websocket/test
mise exec -- flutter test app/test/core/realtime app/test/feature/earthquake_history app/test/feature/eew app/test/feature/shake_detection
mise exec -- dart analyze packages/eqmonitor_api packages/eqmonitor_websocket
git diff --check
```

If broad directories contain unrelated known failures, record exact failures and rerun every touched test file individually; do not hide touched-seam failures.

- [ ] **Step 4: Commit backend docs and parent gitlink**

```bash
git -C backend add app/specs service/telegram-db-writer/README.md
git -C backend commit -m "docs: 完全Realtimeペイロード仕様を更新"
git add backend
git commit -m "build: backendのRealtime契約更新を反映"
```

- [ ] **Step 5: Final status check**

Run `git --no-pager status --short`, `git -C backend --no-pager status --short`, and both `git diff --check` commands. Expected: no uncommitted files.
