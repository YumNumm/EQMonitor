# App Launch Telemetry — Implementation Plan

**Spec:** `docs/superpowers/specs/2026-06-25-app-launch-telemetry-design.md`

## Global Constraints

- Follow existing code patterns in the repository (Riverpod providers, Freezed models, Retrofit clients)
- Generated files (`*.g.dart`, `*.freezed.dart`) must be regenerated after modifying annotated classes
- `dart analyze` must pass with no warnings
- `dart format` must be applied
- All cross-package imports use package imports (not relative)
- ClickHouse table follows existing patterns in `backend/clickhouse/init/`
- Backend follows existing patterns (Hono, TypeScript, async ClickHouse inserts)
- Non-fatal error handling for all analytics writes

## Task 1: ClickHouse table definition

**Goal:** Add the `app_launch` table DDL to the ClickHouse init scripts.

**Files to create/modify:**
- `backend/clickhouse/init/003_app_launch.sql` (new file)

**Steps:**
1. Read existing table definitions in `backend/clickhouse/init/001_create_tables.sql` to follow conventions (database name, engine settings, TTL patterns)
2. Create `backend/clickhouse/init/003_app_launch.sql` with the `CREATE TABLE IF NOT EXISTS eqmonitor.app_launch` statement exactly as defined in the spec
3. Verify the SQL is syntactically valid by checking against existing table patterns

**Verification:**
- File exists and contains valid ClickHouse DDL
- Follows same conventions as existing init files (CREATE TABLE IF NOT EXISTS, same database name `eqmonitor`)

## Task 2: Add `AppLaunchEvent` to `telemetry_store` package

**Goal:** Add the `AppLaunchEvent` variant to the existing `TelemetryEvent` sealed class and the `AppLaunchRecorder` with 30-second debounce logic.

**Files to modify/create:**
- `packages/telemetry_store/lib/src/telemetry_event.dart` — add `AppLaunchEvent` variant
- `packages/telemetry_store/lib/src/app_launch_recorder.dart` (new) — recorder with debounce
- `packages/telemetry_store/lib/telemetry_store.dart` — export new files
- Run `melos run generate` for the `telemetry_store` package to regenerate Freezed files

**Steps:**
1. Read `packages/telemetry_store/lib/src/telemetry_event.dart` to understand the existing Freezed sealed class structure and union types
2. Add `AppLaunchEvent` factory constructor to `TelemetryEvent` with fields:
   - `launchType` (enum: `coldStart`, `resume`)
   - `appVersion` (String)
   - `buildNumber` (int)
   - `platform` (enum: `ios`, `android`)
   - `osVersion` (String)
   - `deviceModel` (String)
   - `locale` (String)
   - `isPhysicalDevice` (bool)
   - `physicalRamMb` (int)
   - `cpuCores` (int)
   - `manufacturer` (String)
   - `androidSdkInt` (int?, nullable)
   - `securityPatch` (String?, nullable)
   - `isLowRamDevice` (bool?, nullable)
   - `installerStore` (String?, nullable)
3. Create `AppLaunchRecorder` class:
   - Constructor takes `TelemetryRecorder` and a `SharedPreferences` instance
   - `record(LaunchType, {required fields})` method:
     - Check last send timestamp from SharedPreferences
     - If < 30 seconds since last send, return without recording
     - Otherwise, create `AppLaunchEvent`, call `TelemetryRecorder.record()`, update timestamp
4. Add enums: `LaunchType` (coldStart, resume) and `AppPlatform` (ios, android) — or reuse existing if present
5. Export new files from barrel
6. Run code generation for this package: `cd packages/telemetry_store && dart run build_runner build --delete-conflicting-outputs`

**Verification:**
- `dart analyze packages/telemetry_store` passes
- `dart test packages/telemetry_store` passes (existing tests still work)
- Generated files are updated

## Task 3: Unit tests for `AppLaunchRecorder`

**Goal:** Test the 30-second debounce logic and event recording.

**Files to create:**
- `packages/telemetry_store/test/app_launch_recorder_test.dart`

**Steps:**
1. Read existing tests in `packages/telemetry_store/test/` to follow test patterns
2. Write tests:
   - Records event when no previous timestamp exists
   - Records event when >30 seconds since last send
   - Does NOT record when <30 seconds since last send
   - Records correct fields for iOS launch
   - Records correct fields for Android launch
   - Correctly distinguishes `cold_start` vs `resume` launch types
3. Use mock/fake SharedPreferences and TelemetryRecorder

**Verification:**
- `dart test packages/telemetry_store` passes with new tests
- All 6+ test cases pass

## Task 4: Integrate `AppLaunchRecorder` into the Flutter app

**Goal:** Wire up the recorder to fire on cold start and on resume from background.

**Files to modify:**
- `app/lib/feature/telemetry/provider/` — add `appLaunchRecorderProvider` and lifecycle integration
- `app/lib/main.dart` — trigger cold_start recording after initialization

**Steps:**
1. Read `app/lib/feature/telemetry/` to understand existing telemetry provider structure
2. Read `app/lib/main.dart` to understand initialization order and where to hook in
3. Read `app/lib/core/provider/device_info.dart` and `package_info.dart` to understand how device info is accessed
4. Create a Riverpod provider for `AppLaunchRecorder` that takes dependencies from existing providers
5. Create a provider or widget that:
   - On initialization (cold start): calls `recorder.record(LaunchType.coldStart, ...)`
   - Listens to `AppLifecycleListener` for resume: calls `recorder.record(LaunchType.resume, ...)`
   - Collects all fields from existing providers:
     - `packageInfoProvider` → appVersion, buildNumber
     - `androidDeviceInfoProvider` / `iosDeviceInfoProvider` → deviceModel, osVersion, manufacturer, physicalRamMb, etc.
     - `Platform.numberOfProcessors` → cpuCores
     - `Platform.localeName` → locale
6. Ensure the lifecycle listener is registered early in the widget tree

**Verification:**
- `dart analyze app` passes
- App compiles without errors
- Cold start triggers a telemetry event
- Background resume triggers a telemetry event (subject to 30s debounce)

## Task 5: Backend event routing to `app_launch` table

**Goal:** Route `app_launch` events from the existing telemetry endpoint to the dedicated ClickHouse table.

**Files to modify:**
- Backend telemetry handler (find the handler for `POST /v2/device/me/telemetry/events`)
- May need a new insert function for `app_launch` table

**Steps:**
1. Read the existing telemetry event handler to understand how events are received and inserted into `client_telemetry`
2. Read `backend/packages/clickhouse/src/client.ts` and existing insert patterns (e.g., `clickhouse-event.ts`)
3. Add routing logic: if `event.event_type === "app_launch"`, parse the payload and insert into `eqmonitor.app_launch` with proper field mapping
4. Add validation for `app_launch` payloads:
   - `app_version`: non-empty string
   - `build_number`: positive integer
   - `platform`: "ios" | "android"
   - `launch_type`: "cold_start" | "resume"
   - String fields: max 256 characters
5. `device_id` comes from the request header `x-eqmonitor-device-id` (already extracted by middleware)
6. Non-fatal: wrap in try/catch, log error on failure

**Verification:**
- TypeScript type check passes (`pnpm check-types`)
- Lint passes (`pnpm lint`)
- Existing telemetry tests still pass

## Task 6: Grafana dashboard JSON

**Goal:** Create the Grafana dashboard with 6 panels for app launch analytics.

**Files to create:**
- `backend/home8s/grafana/dashboard/eqmonitor-app-launch-telemetry.json`

**Steps:**
1. Read an existing dashboard JSON file (e.g., `backend/home8s/grafana/dashboard/eqmonitor-observability-overview.json`) to understand the structure, UID conventions, and data source references
2. Find the ClickHouse data source UID from the Grafana provisioning config or existing dashboards
3. Create the dashboard JSON with:
   - Template variables: `$platform` (custom: ios, android, All), `$app_version` (query from ClickHouse)
   - Panel 1: Version distribution time series (Stacked Area)
   - Panel 2: DAU trend (Time Series, iOS/Android lines)
   - Panel 3: Current version snapshot (Pie Chart, last 7 days)
   - Panel 4: OS version distribution (Table)
   - Panel 5: Top 20 device models (Bar Chart horizontal)
   - Panel 6: Low-end device ratio (Stacked Bar, RAM tiers)
4. Use the SQL queries from the spec for each panel
5. Apply `WHERE platform = '$platform'` filter where applicable (skip filter when $platform = 'All')

**Verification:**
- Valid JSON (parseable)
- All panels reference the correct ClickHouse data source UID
- SQL queries are syntactically correct
