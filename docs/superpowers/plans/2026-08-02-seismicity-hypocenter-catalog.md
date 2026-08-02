# Seismicity Hypocenter Catalog Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 「地震活動」に全震源/有感地震モードを追加し、全震源を複数YEAR/DAY PMTilesで描画しながら、矩形分析を同一revisionの検索API全件から生成する。

**Architecture:** Backendの既存manifest/searchへarchive単位の `query_revision` と検索precondition `expected_revision` を追加し、そのOpenAPIからDartクライアントを再生成する。Flutterはmanifest/PMTilesを地図表示、検索APIを分析表示に分離し、既存 `SeismicityEvent` とチャート群を再利用する。

**Tech Stack:** TypeScript 6 / Hono / Valibot / Vitest / PostgreSQL、Flutter 3.44.4 / Dart 3.11 / Riverpod 3 / Freezed / Dio / Retrofit / MapLibre / flutter_hooks / flutter_test

## Global Constraints

- Backend submoduleは `origin/main` の震源カタログ実装済みcommitを基点にし、`codex/seismicity-hypocenter-catalog` branchへ実装して先にpushする。
- 親リポジトリは `codex/seismicity-hypocenter-catalog` branchを作成し、push済みBackend commitをgitlinkとして記録する。
- Flutter / Dartコマンドは必ず `mise exec --` 経由で実行する。Cloud Agentでは `--no-deps flutter@3.44.4-stable` を明示する。
- Backendコマンドは導入済みNode/pnpmを `mise exec --no-deps node@24.18.0 pnpm@11.10.0 --` で実行する。
- 生成API型は `as api` importし、repository境界でアプリ固有型へ変換する。UIへ生成API型を渡さない。
- 新規ロジックはprivate methodへ置かず、単一責務クラスへ分離してRiverpodでDIする。
- `dynamic`、null assertion、`print()`、固定のarchive一覧・URL、固定データへのフォールバックを追加しない。
- 選択状態は永続化せず、画面生成時に全震源 + 最新DAY 1件へ戻す。
- 部分的なAPI分析結果を完全な結果として表示しない。PMTilesの部分表示は失敗期間を明示する。
- 仕様書: `docs/superpowers/specs/2026-08-02-seismicity-hypocenter-catalog-design.md`

---

### Task 1: Backend archive query revision

**Files:**
- Modify: `backend/service/hypocenter-catalog/package.json`
- Modify: `backend/pnpm-lock.yaml`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/archive-planner.ts`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/archive-planner.test.ts`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/generator.ts`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/generator.test.ts`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/validator.ts`
- Modify: `backend/service/hypocenter-catalog/src/pmtiles/validator.test.ts`

**Interfaces:**
- Consumes: `computeHypocenterRevision(states)` from `@eqmonitor-backend/database`.
- Produces: `ArchivePlan.queryRevision: string` and PMTiles metadata `query_revision` matching search API `meta.dataset_revision` for the archive period.

- [ ] **Step 1: Move Backend submodule to a feature branch based on current main**

```bash
git -C backend switch -c codex/seismicity-hypocenter-catalog origin/main
git -C backend status --short --branch
```

Expected: branch starts at or after `fb16a19d8f6a7b49c448829a86d10f47a7547c83`; nested submodules remain unchanged.

- [ ] **Step 2: Write failing archive revision tests**

Add a test using two states whose partition kind/key must affect the hash:

```ts
it('uses the search API partition revision algorithm', () => {
  const [plan] = planArchives({
    now: new Date('2026-07-31T08:00:00Z'),
    coverage: {
      from: '2026-07-30T15:00:00.000Z',
      to: '2026-07-31T08:00:00.000Z',
    },
    states: [states[4]],
  });
  expect(plan.queryRevision).toBe(
    computeHypocenterRevision([
      {
        partitionKind: states[4].partition,
        partitionKey: states[4].key,
        revision: states[4].revision,
      },
    ]),
  );
});
```

Update generator/validator tests to require `metadata.query_revision === plan.queryRevision`.

- [ ] **Step 3: Run tests and verify RED**

Run:

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog exec vitest run src/pmtiles/archive-planner.test.ts src/pmtiles/generator.test.ts src/pmtiles/validator.test.ts
```

Expected: FAIL because `queryRevision` and `query_revision` do not exist.

- [ ] **Step 4: Add the workspace dependency and implement the revision**

Run:

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog add '@eqmonitor-backend/database@workspace:*'
```

Change `ArchivePlan` and `makePlan`:

```ts
import { computeHypocenterRevision } from '@eqmonitor-backend/database';

export interface ArchivePlan {
  partition: 'YEAR' | 'DAY';
  key: string;
  period: { from: string; to: string };
  range: { from: string; toExclusive: string };
  sourceRevisions: string[];
  queryRevision: string;
  revision: string;
}

const selectedStates = input.states.filter(state =>
  intersects(from, toExclusive, Date.parse(state.coverageFrom), Date.parse(state.coverageTo)),
);
const queryRevision = computeHypocenterRevision(
  selectedStates.map(state => ({
    partitionKind: state.partition,
    partitionKey: state.key,
    revision: state.revision,
  })),
);
```

Write both metadata keys during the transition, with equal values:

```ts
return {
  ...tippecanoeMetadata,
  archive_revision: plan.revision,
  dataset_revision: plan.queryRevision,
  query_revision: plan.queryRevision,
  period: plan.period,
  generated_at: generatedAt,
  fields: ARCHIVE_FIELD_DEFINITIONS,
};
```

Require the same value in `validator.ts`.

- [ ] **Step 5: Run focused tests and type checking**

Run:

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog exec vitest run src/pmtiles/archive-planner.test.ts src/pmtiles/generator.test.ts src/pmtiles/validator.test.ts
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog check-types
```

Expected: all focused tests pass and type checking exits 0.

- [ ] **Step 6: Commit Backend archive revision**

```bash
git -C backend add service/hypocenter-catalog/package.json pnpm-lock.yaml service/hypocenter-catalog/src/pmtiles
git -C backend commit -m "feat: 震源PMTilesに検索revisionを付与"
```

### Task 2: Backend manifest query revision

**Files:**
- Modify: `backend/service/hypocenter-catalog/src/publication/model.ts`
- Modify: `backend/service/hypocenter-catalog/src/publication/publisher.ts`
- Modify: `backend/service/hypocenter-catalog/src/publication/publisher.test.ts`
- Modify: `backend/api/api/src/features/hypocenter/datasource/manifest-datasource.ts`
- Modify: `backend/api/api/src/features/hypocenter/model/responses.ts`
- Modify: `backend/api/api/src/features/hypocenter/routes/hypocenter.ts`
- Modify: `backend/api/api/test/hypocenter/hypocenter-routes.test.ts`
- Modify: `backend/api/api/test/hypocenter/manifest-datasource.test.ts`
- Modify: `backend/api/api-stub/src/features/hypocenter/fixtures.ts`

**Interfaces:**
- Consumes: `ArchivePlan.queryRevision` from Task 1.
- Produces: manifest archive JSON `{ ..., query_revision: string }`, validated as 24 lowercase hex characters.

- [ ] **Step 1: Write failing publisher and route tests**

Add `query_revision: plan.queryRevision` to expected raw manifest descriptors and assert the public route output:

```ts
expect(body.data.archives[0]).toMatchObject({
  partition: 'YEAR',
  query_revision: '1234567890abcdef12345678',
});
```

Add invalid raw manifest coverage:

```ts
await expect(
  datasourceWith({ query_revision: 'not-a-revision' }).getManifest(),
).rejects.toThrow(HypocenterManifestUnavailableError);
```

- [ ] **Step 2: Run tests and verify RED**

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog exec vitest run src/publication/publisher.test.ts
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api exec vitest run test/hypocenter/hypocenter-routes.test.ts test/hypocenter/manifest-datasource.test.ts
```

Expected: FAIL because manifest archive schemas do not contain `query_revision`.

- [ ] **Step 3: Persist and validate query revision**

Add the field to raw/public types and validators:

```ts
export interface HypocenterManifestArchive {
  partition: 'YEAR' | 'DAY';
  key: string;
  period: ManifestPeriod;
  archive_revision: string;
  object_key: string;
  feature_count: number;
  size_bytes: number;
  query_revision: string;
}

query_revision: v.pipe(v.string(), v.regex(/^[a-f0-9]{24}$/)),
```

In `publishArchives`, copy `plan.queryRevision`; include it in canonical descriptors so changing the query snapshot changes `manifest_revision`. In the API route, map it unchanged to the public archive. Update stub default and empty fixtures with valid revisions.

- [ ] **Step 4: Run focused tests and type checks**

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog exec vitest run src/publication/publisher.test.ts
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api exec vitest run test/hypocenter/hypocenter-routes.test.ts test/hypocenter/manifest-datasource.test.ts
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api-stub test
```

Expected: all commands exit 0.

- [ ] **Step 5: Commit Backend manifest contract**

```bash
git -C backend add service/hypocenter-catalog/src/publication api/api/src/features/hypocenter api/api/test/hypocenter api/api-stub/src/features/hypocenter/fixtures.ts
git -C backend commit -m "feat: 震源manifestに検索revisionを公開"
```

### Task 3: Backend expected revision precondition and generated contract

**Files:**
- Modify: `backend/api/api/src/features/hypocenter/model/requests.ts`
- Modify: `backend/api/api/src/features/hypocenter/routes/hypocenter.ts`
- Modify: `backend/api/api/test/hypocenter/hypocenter-routes.test.ts`
- Generate: `backend/api/api/openapi.json`
- Generate: `backend/api/api-stub/generated/contract-fixtures/get__v2_hypocenters.json`
- Generate: `backend/api/api-stub/generated/contract-fixtures/get__v2_hypocenters_manifest.json`
- Generate: `backend/api/api-stub/generated/contract-fixtures/index.json`

**Interfaces:**
- Consumes: archive `query_revision` from Task 2.
- Produces: optional search query `expected_revision`; mismatch returns existing `409 DATASET_REVISION_CHANGED` before returning page 1.

- [ ] **Step 1: Write failing request/route tests**

Add tests for valid, invalid, and mismatched revisions:

```ts
it('passes expected_revision to the first repository search', async () => {
  const repository = { search: vi.fn(async () => result) };
  const response = await createApp({ repository }).app.request(
    validUrl(`&expected_revision=${REVISION}`),
  );
  expect(response.status).toBe(200);
  expect(repository.search).toHaveBeenCalledWith(
    expect.objectContaining({ expectedRevision: REVISION }),
  );
});

it('rejects an invalid expected_revision', async () => {
  expect((await createApp().app.request(validUrl('&expected_revision=x'))).status).toBe(400);
});
```

Also assert that a cursor revision and a different explicit revision returns 400 instead of choosing one silently.

- [ ] **Step 2: Run route tests and verify RED**

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api exec vitest run test/hypocenter/hypocenter-routes.test.ts
```

Expected: FAIL because `expected_revision` is ignored.

- [ ] **Step 3: Implement the precondition without changing query hashing**

Add to Valibot input only:

```ts
expected_revision: v.optional(
  v.pipe(v.string(), v.regex(/^[a-f0-9]{24}$/, 'Invalid expected revision')),
),
```

Keep `expected_revision` out of `NormalizedHypocenterQuery`, because it is a precondition rather than a result filter. In the route:

```ts
if (
  decoded &&
  rawQuery.expected_revision !== undefined &&
  rawQuery.expected_revision !== decoded.datasetRevision
) return badRequest(c, 'Expected revision does not match cursor revision');

input.expectedRevision = decoded?.datasetRevision ?? rawQuery.expected_revision;
```

The existing repository throws `HypocenterRevisionChangedError`, which the route already maps to 409.

- [ ] **Step 4: Generate OpenAPI and contract fixtures**

```bash
cd backend/api/api
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --silent generate:openapi
cd ../api-stub
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm generate:fixtures
```

Expected: OpenAPI contains archive `query_revision` and query parameter `expected_revision`; fixtures include `query_revision`.

- [ ] **Step 5: Verify Backend packages**

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog test
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api exec vitest run test/hypocenter
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api type-check
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api-stub type-check
```

Expected: all tests/type checks pass.

- [ ] **Step 6: Commit and push Backend**

```bash
git -C backend add api/api/src/features/hypocenter api/api/test/hypocenter api/api/openapi.json api/api-stub
git -C backend commit -m "feat: 震源検索にrevision事前条件を追加"
git -C backend push -u origin codex/seismicity-hypocenter-catalog
```

### Task 4: Regenerate Dart API client and record Backend gitlink

**Files:**
- Generate: `packages/eqmonitor_api/openapi/openapi.json`
- Generate: `packages/eqmonitor_api/lib/src/api_client.dart`
- Generate: `packages/eqmonitor_api/lib/src/clients/hypocenters_api_client.dart`
- Generate: `packages/eqmonitor_api/lib/src/models/hypocenter_manifest_response.dart`
- Generate: `packages/eqmonitor_api/lib/src/models/hypocenter_manifest_response_data_archives_inner.dart`
- Generate: `packages/eqmonitor_api/lib/src/models/hypocenter_list_response.dart`
- Generate: `packages/eqmonitor_api/lib/src/models/hypocenter_response_item.dart`
- Generate: `packages/eqmonitor_api/lib/src/export.dart`
- Generate: Freezed/JSON/Retrofit companions for the listed hypocenter client/models
- Generate: `packages/eqmonitor_api/test/fixtures/contract/`
- Modify: `backend` gitlink

**Interfaces:**
- Consumes: Backend OpenAPI and fixtures from Task 3.
- Produces: `apiClient.hypocenters`, manifest archive `queryRevision`, and `getV2Hypocenters` parameters `expectedRevision` / `cursor`.

- [ ] **Step 1: Create the parent feature branch**

```bash
git switch -c codex/seismicity-hypocenter-catalog
```

- [ ] **Step 2: Regenerate the package**

```bash
cd packages/eqmonitor_api
mise exec --no-deps flutter@3.44.4-stable -- dart run bin/generate.dart
```

- [ ] **Step 3: Verify generated contract signatures**

```bash
rg -n "queryRevision|expectedRevision|getV2Hypocenters" packages/eqmonitor_api/lib/src
rg -n "liveActivity|LiveActivity" packages/eqmonitor_api/lib/src
```

Expected: hypocenter fields/methods exist and Live Activity generated surfaces remain present.

- [ ] **Step 4: Test and analyze generated package**

```bash
cd packages/eqmonitor_api
mise exec --no-deps flutter@3.44.4-stable -- dart test
mise exec --no-deps flutter@3.44.4-stable -- dart analyze
```

Expected: both exit 0.

- [ ] **Step 5: Commit generated contract and Backend pointer**

```bash
git add backend packages/eqmonitor_api
git commit -m "build: 震源カタログAPI契約を更新"
```

### Task 5: Flutter archive domain and ephemeral selection

**Files:**
- Create: `app/lib/feature/seismicity/data/model/seismicity_data_mode.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_archive_partition.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_archive_id.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_archive.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_manifest.dart`
- Create: `app/lib/feature/seismicity/data/logic/hypocenter_archive_selector.dart`
- Create: `app/test/feature/seismicity/data/logic/hypocenter_archive_selector_test.dart`
- Generate: matching Freezed files

**Interfaces:**
- Produces: stable `HypocenterArchiveId(partition, jstLabel)`, archive model, latest-DAY selection, and selection remapping after manifest refresh.

- [ ] **Step 1: Write failing selector tests**

```dart
test('latest DAY is selected and YEAR is not used as a fallback', () {
  final selector = HypocenterArchiveSelector();
  expect(selector.initialSelection(archives: archives).single.jstLabel, '2026-08-02');
  expect(selector.initialSelection(archives: yearOnlyArchives), isEmpty);
});

test('selection survives URL and period-end revision changes', () {
  final remapped = const HypocenterArchiveSelector().remap(
    selected: {const HypocenterArchiveId(partition: .year, jstLabel: '2026')},
    archives: refreshedArchives,
  );
  expect(remapped.single.url, endsWith('new.pmtiles'));
});
```

- [ ] **Step 2: Run the test and verify RED**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/logic/hypocenter_archive_selector_test.dart
```

- [ ] **Step 3: Implement minimal immutable models and selector**

Use Freezed models and JST label conversion based only on `period.from`:

```dart
@freezed
abstract class HypocenterArchive with _$HypocenterArchive {
  const factory HypocenterArchive({
    required HypocenterArchiveId id,
    required DateTime periodFrom,
    required DateTime periodTo,
    required String url,
    required int featureCount,
    required int sizeBytes,
    required String queryRevision,
  }) = _HypocenterArchive;
}
```

`HypocenterArchiveSelector` exposes `initialSelection` and `remap`; it has no Riverpod/UI dependency.

- [ ] **Step 4: Generate and verify**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- dart run build_runner build --delete-conflicting-outputs
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/logic/hypocenter_archive_selector_test.dart
```

- [ ] **Step 5: Commit domain models**

```bash
git add app/lib/feature/seismicity/data/model app/lib/feature/seismicity/data/logic/hypocenter_archive_selector.dart app/test/feature/seismicity/data/logic/hypocenter_archive_selector_test.dart
git commit -m "feat: 震源アーカイブ選択モデルを追加"
```

### Task 6: Flutter manifest repository and PMTiles range probe

**Files:**
- Create: `app/lib/feature/seismicity/data/model/hypocenter_api_exception.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_archive_probe_result.dart`
- Create: `app/lib/feature/seismicity/data/data_source/hypocenter_archive_probe.dart`
- Create: `app/lib/feature/seismicity/data/repository/hypocenter_manifest_repository.dart`
- Create: `app/lib/feature/seismicity/data/provider/hypocenter_manifest_repository_provider.dart`
- Create: `app/lib/feature/seismicity/data/notifier/hypocenter_manifest_notifier.dart`
- Create: `app/test/feature/seismicity/data/data_source/hypocenter_archive_probe_test.dart`
- Create: `app/test/feature/seismicity/data/repository/hypocenter_manifest_repository_test.dart`

**Interfaces:**
- Consumes: generated `api.HypocentersApiClient` and archive models from Task 5.
- Produces: `Future<Result<HypocenterManifest, HypocenterApiException>>` and per-archive availability without downloading a whole PMTiles file.

- [ ] **Step 1: Write failing converter and probe tests**

Test API conversion, 206 + `Content-Range`, PMTiles magic/version bytes, 200 rejection, and malformed header rejection. The success fixture begins with:

```dart
final header = Uint8List.fromList([...ascii.encode('PMTiles'), 3]);
```

Assert that a 200 response with a large body is canceled and never accepted.

- [ ] **Step 2: Run tests and verify RED**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/data_source/hypocenter_archive_probe_test.dart test/feature/seismicity/data/repository/hypocenter_manifest_repository_test.dart
```

- [ ] **Step 3: Implement repository conversion**

```dart
extension HypocenterManifestResponseConverter on api.HypocenterManifestResponse {
  HypocenterManifest toModel() => HypocenterManifest(
    archives: data.archives.map((archive) => archive.toModel()).toList(),
    datasetRevision: meta.datasetRevision,
    dataUpdatedAt: DateTime.parse(meta.dataUpdatedAt),
  );
}
```

`HypocenterManifestRepository.fetch` imports `core/foundation/result.dart`, captures Dio/API failures, and returns `Failure(HypocenterApiException(message: error.message ?? 'Hypocenter manifest request failed', statusCode: error.response?.statusCode))`; it never throws a raw `DioException` across the repository boundary.

The probe sends `Range: bytes=0-127` with `ResponseType.stream`, requires status 206 and a matching `Content-Range`, reads only enough bytes for the PMTiles signature, then cancels the subscription. It never falls back to a normal GET.

- [ ] **Step 4: Implement Riverpod providers**

Use `HypocenterManifestNotifier` with `CachedNotifier<HypocenterManifest>`: cache-only read first, HTTP-cache revalidation in the background, and `preserveValueOnBackgroundError` so a stale value remains visible with `DataKind.cache`. The notifier unwraps the repository `Result` into its typed AsyncError boundary. Use a header-free absolute-URL Dio for archive probes; do not copy device headers to the PMTiles host.

- [ ] **Step 5: Run tests and analyze the data layer**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/data_source/hypocenter_archive_probe_test.dart test/feature/seismicity/data/repository/hypocenter_manifest_repository_test.dart
mise exec --no-deps flutter@3.44.4-stable -- dart analyze lib/feature/seismicity/data
```

- [ ] **Step 6: Commit manifest and probe**

```bash
git add app/lib/feature/seismicity/data app/test/feature/seismicity/data
git commit -m "feat: 震源manifest取得とPMTiles検証を追加"
```

### Task 7: Flutter multi-archive PMTiles map layer

**Files:**
- Create: `app/lib/feature/seismicity/ui/layer/hypocenter_pmtiles_layer.dart`
- Create: `app/lib/feature/seismicity/ui/layer/hypocenter_pmtiles_layer_lifecycle.dart`
- Create: `app/lib/feature/seismicity/ui/layer/hypocenter_pmtiles_style_builder.dart`
- Create: `app/test/feature/seismicity/ui/layer/hypocenter_pmtiles_layer_lifecycle_test.dart`
- Create: `app/test/feature/seismicity/ui/layer/hypocenter_pmtiles_style_builder_test.dart`

**Interfaces:**
- Consumes: successfully probed `HypocenterArchive` values.
- Produces: one `VectorSource` per archive, `clusters` at zoom 0–6, `hypocenters` at zoom 7–14, stable IDs, and safe add/remove/recreate lifecycle.

- [ ] **Step 1: Write failing lifecycle/style tests**

```dart
test('remote URL receives the PMTiles scheme exactly once', () {
  final source = const HypocenterPmTilesLayerLifecycle().sourceFor(archive);
  expect(source.url, 'pmtiles://https://tiles.example/archive.pmtiles');
});

test('style switches clusters and points at zoom 7', () {
  final layers = const HypocenterPmTilesStyleBuilder().build(archive: archive, now: now);
  expect(layers.cluster.maxZoom, 7);
  expect(layers.hypocenter.minZoom, 7);
});
```

Also test distinct stable source IDs for multiple archives and URL-change recreation with the same logical ID.

- [ ] **Step 2: Run tests and verify RED**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/ui/layer/hypocenter_pmtiles_layer_lifecycle_test.dart test/feature/seismicity/ui/layer/hypocenter_pmtiles_style_builder_test.dart
```

- [ ] **Step 3: Implement focused builders and layer widget**

Use source layers and properties from Backend:

```dart
VectorSource(id: sourceId, url: normalizedPmtilesUrl, volatile: true);
CircleStyleLayer(id: clusterLayerId, sourceId: sourceId, sourceLayer: 'clusters', maxZoom: 7);
CircleStyleLayer(id: pointLayerId, sourceId: sourceId, sourceLayer: 'hypocenters', minZoom: 7, maxZoom: 15);
```

Cluster paint uses `count`/`max_magnitude`; point paint uses `magnitude` and either `origin_time_unix_ms` or magnitude color mode. Missing magnitudes use an explicit neutral style, not numeric zero.

- [ ] **Step 4: Run tests and analyze**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/ui/layer/hypocenter_pmtiles_layer_lifecycle_test.dart test/feature/seismicity/ui/layer/hypocenter_pmtiles_style_builder_test.dart
mise exec --no-deps flutter@3.44.4-stable -- dart analyze lib/feature/seismicity/ui/layer
```

- [ ] **Step 5: Commit PMTiles layer**

```bash
git add app/lib/feature/seismicity/ui/layer app/test/feature/seismicity/ui/layer
git commit -m "feat: 複数震源PMTilesレイヤーを追加"
```

### Task 8: Flutter exact rectangle analysis pipeline

**Files:**
- Create: `app/lib/feature/seismicity/data/model/hypocenter_analysis_progress.dart`
- Create: `app/lib/feature/seismicity/data/model/hypocenter_analysis_result.dart`
- Create: `app/lib/feature/seismicity/data/repository/hypocenter_analysis_repository.dart`
- Create: `app/lib/feature/seismicity/data/logic/hypocenter_analysis_loader.dart`
- Create: `app/lib/feature/seismicity/data/notifier/hypocenter_analysis_notifier.dart`
- Create: `app/test/feature/seismicity/data/repository/hypocenter_analysis_repository_test.dart`
- Create: `app/test/feature/seismicity/data/logic/hypocenter_analysis_loader_test.dart`
- Create: `app/test/feature/seismicity/data/notifier/hypocenter_analysis_notifier_test.dart`

**Interfaces:**
- Consumes: selected archives, `SeismicityBounds`, and generated search client.
- Produces: all-or-nothing `Result<List<SeismicityEvent>, HypocenterApiException>`, progress, cancellation, one automatic 409 refresh/retry.

- [ ] **Step 1: Write failing repository pagination tests**

Assert exact request mapping:

```dart
verify(
  () => client.getV2Hypocenters(
    originTimeGte: archive.periodFrom.toUtc().toIso8601String(),
    originTimeLte: archive.periodTo.toUtc().toIso8601String(),
    area: '139.0,35.0;140.0,35.0;140.0,36.0;139.0,36.0',
    limit: '1000',
    expectedRevision: archive.queryRevision,
    cursor: null,
  ),
).called(1);
```

Return two pages and assert `nextToken` becomes the next `cursor`; assert response `meta.datasetRevision` must equal `archive.queryRevision` on every page.

- [ ] **Step 2: Write failing loader tests**

Use a fake repository that records active calls. Assert at most two archives run concurrently, pages stay sequential inside one archive, any failure discards all events, cancellation prevents late state publication, and a 409 refreshes/remaps/retries once.

- [ ] **Step 3: Run tests and verify RED**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/repository/hypocenter_analysis_repository_test.dart test/feature/seismicity/data/logic/hypocenter_analysis_loader_test.dart test/feature/seismicity/data/notifier/hypocenter_analysis_notifier_test.dart
```

- [ ] **Step 4: Implement repository and converter**

Convert each `api.HypocenterResponseItem`:

```dart
SeismicityEvent(
  eventId: item.hypocenterId,
  originTime: DateTime.parse(item.originTime),
  magnitude: item.magnitude,
  depth: item.depthKm,
  latitude: item.latitude,
  longitude: item.longitude,
  maxIntensity: item.maxIntensity,
);
```

Use a `CancelToken` per archive chain. Convert Dio/409/revision mismatch into `HypocenterApiException`, return `Failure`, and never return a partial success list.

- [ ] **Step 5: Implement bounded loader and notifier**

`HypocenterAnalysisLoader.load` accepts archives, bounds, a progress callback, and cancellation signal. Maintain a two-worker queue; each worker fully finishes one archive before dequeuing another. `HypocenterAnalysisNotifier` owns the current generation token and ignores results from older generations.

- [ ] **Step 6: Run tests and analyze**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/repository/hypocenter_analysis_repository_test.dart test/feature/seismicity/data/logic/hypocenter_analysis_loader_test.dart test/feature/seismicity/data/notifier/hypocenter_analysis_notifier_test.dart
mise exec --no-deps flutter@3.44.4-stable -- dart analyze lib/feature/seismicity/data
```

- [ ] **Step 7: Commit analysis pipeline**

```bash
git add app/lib/feature/seismicity/data app/test/feature/seismicity/data
git commit -m "feat: 全震源の矩形分析取得を追加"
```

### Task 9: Flutter mode/archive UI and page integration

**Files:**
- Move: `app/lib/feature/seismicity/ui/seismicity_page.dart` -> `app/lib/feature/seismicity/ui/page/seismicity_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Create: `app/lib/feature/seismicity/data/notifier/seismicity_view_state_notifier.dart`
- Create: `app/lib/feature/seismicity/ui/components/seismicity_data_mode_selector.dart`
- Create: `app/lib/feature/seismicity/ui/components/seismicity_control_bar.dart`
- Create: `app/lib/feature/seismicity/ui/components/hypocenter_archive_summary_button.dart`
- Create: `app/lib/feature/seismicity/ui/components/hypocenter_archive_selector_sheet.dart`
- Create: `app/lib/feature/seismicity/ui/components/hypocenter_status_banner.dart`
- Modify: `app/lib/feature/seismicity/ui/components/seismicity_span_selector.dart`
- Modify: `app/lib/feature/seismicity/ui/panel/seismicity_analysis_panel.dart`
- Create: `app/test/feature/seismicity/data/notifier/seismicity_view_state_notifier_test.dart`

**Interfaces:**
- Consumes: mode/archive state, manifest/probe providers, PMTiles layer, analysis notifier, existing felt dataset provider.
- Produces: default all-hypocenter screen, multiple YEAR/DAY selection, felt mode preservation, explicit loading/empty/partial/error states.

- [ ] **Step 1: Write the failing view-state Unit test**

```dart
test('fresh state defaults to allHypocenters and synchronizes latest DAY', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  final notifier = container.read(seismicityViewStateNotifierProvider.notifier);
  notifier.synchronizeManifest(manifest);
  final state = container.read(seismicityViewStateNotifierProvider);
  expect(state.mode, SeismicityDataMode.allHypocenters);
  expect(state.selectedArchiveIds.single.jstLabel, '2026-08-02');
});
```

Add notifier-only cases for mode switching, felt-span retention, empty-DAY initialization, and manifest-refresh selection remapping. Do not add Widget tests.

- [ ] **Step 2: Run tests and verify RED**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/notifier/seismicity_view_state_notifier_test.dart
```

- [ ] **Step 3: Implement ephemeral view state**

The notifier holds mode, selected logical archive IDs, and felt span. It has no Preferences dependency. On manifest refresh it calls `HypocenterArchiveSelector.remap`; on a fresh build it selects only the latest DAY.

- [ ] **Step 4: Implement mode and archive controls**

Use Material 3 segmented controls and a scrollable Bottom Sheet containing YEAR and DAY `FilterChip` lists. The Apply action is disabled when the draft set is empty. Labels come from archive IDs; no fixed year/date options are built.

- [ ] **Step 5: Integrate page data flow**

In all-hypocenter mode:

- watch the cache-first manifest notifier and show its stale/cache state explicitly;
- probe selected archives and pass only successful archives to `HypocenterPmTilesLayer`;
- show a persistent partial warning for failed probes;
- start analysis only after rectangle selection;
- display progress before replacing the panel with complete charts;
- keep the map visible on analysis error.

In felt mode, retain the current `seismicityDatasetNotifierProvider(span)` and GeoJSON `SeismicityEpicenterLayer`. Remove existing null assertions by pattern matching the selected bounds into a local value.

- [ ] **Step 6: Run state tests and feature analysis**

```bash
cd app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/notifier/seismicity_view_state_notifier_test.dart
mise exec --no-deps flutter@3.44.4-stable -- dart analyze lib/feature/seismicity lib/core/router/router.dart
```

- [ ] **Step 7: Commit UI integration**

```bash
git add app/lib/core/router/router.dart app/lib/feature/seismicity app/test/feature/seismicity
git commit -m "feat: 地震活動に全震源表示を統合"
```

### Task 10: Operational knowledge, full verification, and push

**Files:**
- Create: `docs/knowledge/20260802_maplibre_remote_pmtiles_preflight.md`

**Interfaces:**
- Produces: recorded platform constraint, clean Backend/Flutter verification, pushed Backend and parent branches.

- [ ] **Step 1: Record the MapLibre platform finding**

Document:

- current Flutter MapLibre wrapper exposes no per-source resource error event;
- remote PMTiles must use `pmtiles://https://...`;
- availability is checked with `Range: bytes=0-127`, 206, `Content-Range`, and PMTiles signature;
- never fall back to a whole-file GET;
- verification commands for a deployed URL using `curl -H 'Range: bytes=0-127'`.

- [ ] **Step 2: Re-run code generation and confirm no drift**

```bash
cd packages/eqmonitor_api
mise exec --no-deps flutter@3.44.4-stable -- dart run bin/generate.dart
cd ../../app
mise exec --no-deps flutter@3.44.4-stable -- dart run build_runner build --delete-conflicting-outputs
git status --short
```

Expected: only intentional generated files are changed; after staging them there is no unexplained drift.

- [ ] **Step 3: Run full focused Backend verification**

```bash
cd backend
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog test
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/hypocenter-catalog check-types
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api exec vitest run test/hypocenter
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api type-check
mise exec --no-deps node@24.18.0 pnpm@11.10.0 -- pnpm --filter @eqmonitor-backend/api-stub type-check
```

- [ ] **Step 4: Run full Flutter feature/package verification**

```bash
cd packages/eqmonitor_api
mise exec --no-deps flutter@3.44.4-stable -- dart test
mise exec --no-deps flutter@3.44.4-stable -- dart analyze
cd ../../app
mise exec --no-deps flutter@3.44.4-stable -- flutter test test/feature/seismicity/data/logic test/feature/seismicity/data/repository test/feature/seismicity/data/notifier test/feature/seismicity/ui/layer
mise exec --no-deps flutter@3.44.4-stable -- dart analyze lib/feature/seismicity lib/core/router/router.dart
```

- [ ] **Step 5: Commit knowledge/final generated drift**

```bash
git add docs/knowledge/20260802_maplibre_remote_pmtiles_preflight.md packages/eqmonitor_api app/lib app/test backend
git commit -m "docs: 震源PMTilesの事前検証手順を記録"
```

If only the knowledge file changed, stage only that file. Never stage unrelated user changes.

- [ ] **Step 6: Verify branch history and clean state**

```bash
git -C backend status --short --branch
git -C backend log --oneline origin/main..HEAD
git status --short --branch
git log --oneline develop..HEAD
git submodule status --recursive
```

Expected: both worktrees are clean; parent gitlink equals the pushed Backend HEAD.

- [ ] **Step 7: Push both repositories**

```bash
git -C backend push origin codex/seismicity-hypocenter-catalog
git push -u origin codex/seismicity-hypocenter-catalog
```

Expected: both pushes succeed. Report branch names, final commit IDs, and verification command results.
