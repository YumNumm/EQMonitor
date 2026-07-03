# Seismicity GeoJSON Backend Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the backend half of the seismicity visualization feature: an hourly CronJob that generates 1/3/12-month hypocenter GeoJSON files from the `earthquake` table, uploads them to the existing SeaweedFS "tiles" bucket, and a new `GET /v2/seismicity/manifest` API endpoint that reports layer metadata to the app.

**Architecture:** A new one-shot Node service (`service/seismicity-geojson-generator`) queries Postgres for `NORMAL` earthquakes with known coordinates, converts rows to a `FeatureCollection` per span, and uploads 3 GeoJSON files plus one internal `manifest.json` to the **existing** `tiles` SeaweedFS bucket under a `seismicity/` key prefix — this bucket is already public-read via the existing `nginx-tiles` proxy (`tiles.eqmonitor.app` / `dev.tiles.eqmonitor.app`) and is already used for non-tile static assets (`INTENSITY_MAP_S3_BUCKET=tiles`), so no new bucket, no new nginx location, and no new Cloudflare Tunnel hostname are needed. A Kubernetes `CronJob` (new — no prior CronJob exists in this chart) runs the service hourly. `api/api` gets a new `features/seismicity` slice that reads `seismicity/manifest.json` from S3 (small file, cached in-process for 60s) and reshapes it into the public contract shape.

**Tech Stack:** TypeScript, pnpm, Turbo, Hono, `hono-openapi` + Valibot, Drizzle ORM (relational query API v2), Vitest, `@aws-sdk/client-s3`, Vite (bundling to `dist/index.mjs`), Docker (mise multi-stage), Kubernetes (Helm chart in `deploy/k8s/charts/eqmonitor`).

## Global Constraints

- New API endpoint: `GET /v2/seismicity/manifest`. Response shape (snake_case) is fixed and must not change:
  ```json
  {
    "layers": [
      { "type": "geojson", "span": "P1M", "url": "https://.../hypocenters_1m.geojson", "generated_at": "2026-07-03T09:00:00+09:00", "count": 1234 }
    ]
  }
  ```
  `span` is one of `"P1M" | "P3M" | "P12M"`.
- GeoJSON: `FeatureCollection`, each `Feature` is a `Point` (`[lng, lat]`), `properties`: `event_id` (string), `origin_time` (ISO8601 string or null), `magnitude` (number|null), `depth` (number|null, km), `max_intensity` (string|null, JMA intensity enum value).
- Extraction condition: `earthquake` table, `originTime >= now - span`, `latitude`/`longitude` non-NULL, `status = 'NORMAL'`.
- `pnpm` only — never `npm`/`npx`.
- No `typedef`, no `Impl` suffix, no unnecessary `abstract interface class`. Prefer enums/literal unions over bare strings where the codebase already does so.
- API field naming: snake_case in all request/response bodies (per `docs/hono-api-design-guidelines.md`).
- `dart analyze`/`melos` commands are irrelevant here — this plan touches `backend/` (TypeScript) only.
- `pnpm lint` = `oxlint --type-aware --type-check --deny-warnings --fix --fix-suggestions --fix-dangerously --report-unused-disable-directives && oxfmt` (run from repo root or via `turbo run lint` if scoped). `pnpm check-types` = `turbo run check-types`. `pnpm test` = `turbo run test`.
- Every new TypeScript file must pass `tsgo --noEmit` (`check-types` script) and `oxlint --type-aware` rules: no `any`, `import type` for type-only imports, exhaustive switches (not applicable here — no switches are introduced), `prefer-const`, `no-var`, `eqeqeq`.

---

## File Structure

```
service/seismicity-geojson-generator/        # NEW package — one-shot hourly job
  package.json
  tsconfig.json
  vite.config.ts
  vitest.config.ts
  Dockerfile
  src/
    environments.ts                          # Valibot env schema, parses process.env
    logger.ts                                 # minimal structured JSON logger
    spans.ts                                  # pure: span<->months<->object key, date math
    spans.test.ts
    geojson-transformer.ts                    # pure: DB rows -> FeatureCollection
    geojson-transformer.test.ts
    earthquake-geo-datasource.ts              # Drizzle query (NORMAL, coords non-null, originTime>=since)
    earthquake-geo-datasource.test.ts
    storage.ts                                # StorageAdapter + S3StorageAdapter (PutObjectCommand)
    storage.test.ts
    generate-and-upload.ts                    # orchestrates: for each span -> query -> transform -> upload; then manifest.json
    generate-and-upload.test.ts
    index.ts                                  # entrypoint: parse env, getDatabase, run, process.exit

api/api/src/features/seismicity/             # NEW feature slice
  routes/seismicity.ts                        # GET /manifest
  model/responses.ts                          # Valibot: SeismicityManifestResponse etc.
  datasource/seismicity-manifest-datasource.ts # reads seismicity/manifest.json from S3, 60s cache
  datasource/seismicity-manifest-datasource.test.ts
  transformer/seismicity-manifest-transformer.ts # internal manifest -> public response shape
  transformer/seismicity-manifest-transformer.test.ts
api/api/test/seismicity/seismicity-routes.test.ts

# Modified files
api/api/src/index.ts                          # mount .route('/v2/seismicity', seismicity)
api/api/src/openapi.ts                        # add 'Seismicity' tag
api/api/src/env.ts                            # document SEISMICITY_S3_BUCKET / SEISMICITY_PUBLIC_BASE_URL
api/api/openapi.json                          # regenerated

deploy/k8s/charts/eqmonitor/templates/seismicity-geojson-generator-cronjob.yaml  # NEW
deploy/k8s/charts/eqmonitor/templates/api-deployment.yaml                       # + SEISMICITY_* env vars
deploy/k8s/charts/eqmonitor/values.yaml                                         # + seismicityGeojsonGenerator, + ingress.tilesHost
deploy/k8s/values/tokyo/develop.yaml                                            # + ingress.tilesHost override

.github/workflows/deploy.yaml                 # + ALL_COMPONENTS entry
release-please-config.json                    # + packages entry
```

**Design decisions locked in for this plan (do not deviate):**

1. **Reuse the `tiles` SeaweedFS bucket** under key prefix `seismicity/` instead of creating a new bucket. Precedent: `api-deployment.yaml` already sets `INTENSITY_MAP_S3_BUCKET: 'tiles'` — the "tiles" bucket is already the general-purpose public-static-asset bucket, not just PMTiles. This means: no new `seaweedfs-create-bucket-job.yaml` entry, no `nginx-tiles-deployment.yaml` change (it already proxies `location / { proxy_pass .../tiles$uri; }` for *any* path under the bucket), no new Cloudflare Tunnel hostname (`tiles.eqmonitor.app` / `dev.tiles.eqmonitor.app` already route to `nginx-tiles`, confirmed in the `home8s` submodule's `terraform/cloudflare/main.tf` — out of scope to edit, and not needed).
2. **Object keys:** `seismicity/hypocenters_1m.geojson`, `seismicity/hypocenters_3m.geojson`, `seismicity/hypocenters_12m.geojson`, `seismicity/manifest.json` (internal metadata file, not the public API contract shape — see below).
3. **Internal `manifest.json` shape** (written by the generator, read by the API) is intentionally *not* the same as the public API response — it stores object keys, not full URLs, so the API can decide the public base URL per environment:
   ```json
   {
     "generated_at": "2026-07-03T09:00:00+09:00",
     "layers": [
       { "span": "P1M", "object_key": "seismicity/hypocenters_1m.geojson", "count": 1234 }
     ]
   }
   ```
   The API's transformer combines `object_key` with an env-configured `SEISMICITY_PUBLIC_BASE_URL` to build the public `url`, and copies `type: 'geojson'` + the shared `generated_at` onto every layer.
4. **No OpenTelemetry/metrics instrumentation** in the new generator service (YAGNI — not required by the spec; CronJob failures are visible via pod status / existing OTel stack at the cluster level, matching the spec's "既存の監視系(OTel)でアラート" note which refers to infra-level Job-failure alerting, not custom app instrumentation).
5. **`generated_at` is JST (`+09:00`)**, computed once per run and reused for all 3 layers (single generation pass).

---

## Task 1: Pure span/date utilities and GeoJSON transformer

**Files:**
- Create: `service/seismicity-geojson-generator/package.json`
- Create: `service/seismicity-geojson-generator/tsconfig.json`
- Create: `service/seismicity-geojson-generator/vitest.config.ts`
- Create: `service/seismicity-geojson-generator/src/spans.ts`
- Test: `service/seismicity-geojson-generator/src/spans.test.ts`
- Create: `service/seismicity-geojson-generator/src/geojson-transformer.ts`
- Test: `service/seismicity-geojson-generator/src/geojson-transformer.test.ts`

**Interfaces:**
- Produces: `SEISMICITY_SPANS: readonly ['P1M', 'P3M', 'P12M']`, `SeismicitySpan` type, `spanToMonths(span): number`, `spanToObjectKey(span): string`, `SEISMICITY_MANIFEST_KEY: string`, `computeSinceIso(now: Date, months: number): string`, `toJstIsoString(date: Date): string`, `EarthquakeGeoRow` interface, `HypocenterFeatureCollection` interface, `toHypocenterFeatureCollection(rows: EarthquakeGeoRow[]): HypocenterFeatureCollection`. Later tasks (2, 4) import all of these by exact name.

- [ ] **Step 1: Scaffold the package**

Create `service/seismicity-geojson-generator/package.json`:

```json
{
  "name": "@eqmonitor-backend/seismicity-geojson-generator",
  "private": true,
  "type": "module",
  "scripts": {
    "build": "vite build",
    "start": "node dist/index.mjs",
    "check-types": "tsgo --noEmit",
    "test": "vitest run",
    "test:watch": "vitest"
  },
  "dependencies": {
    "@aws-sdk/client-s3": "^3.1075.0",
    "@eqmonitor-backend/database": "workspace:*",
    "valibot": "^1.4.1"
  },
  "devDependencies": {
    "@types/node": "^26.0.1",
    "@typescript/native-preview": "7.0.0-dev.20260624.1",
    "typescript": "^6.0.3",
    "vite": "^8.1.0",
    "vitest": "^4.1.9"
  },
  "packageManager": "pnpm@11.9.0"
}
```

Create `service/seismicity-geojson-generator/tsconfig.json`:

```json
{
  "extends": "../../packages/config/tsconfig.json",
  "compilerOptions": {
    "rootDir": "./src",
    "outDir": "./dist"
  },
  "exclude": ["test", "src/**/*.test.ts"],
  "include": ["src/**/*.ts"]
}
```

Create `service/seismicity-geojson-generator/vitest.config.ts`:

```typescript
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
  },
});
```

- [ ] **Step 2: Install dependencies**

Run: `cd /home/yumnumm/EQMonitor/backend && pnpm install`
Expected: pnpm resolves `@eqmonitor-backend/seismicity-geojson-generator` as a new workspace package (matched by the `service/*` glob in `pnpm-workspace.yaml`) and updates `pnpm-lock.yaml`. No version conflicts (all dependency versions above already exist elsewhere in the lockfile).

- [ ] **Step 3: Write the failing test for span/date utilities**

Create `service/seismicity-geojson-generator/src/spans.test.ts`:

```typescript
import { describe, expect, it } from 'vitest';

import {
  computeSinceIso,
  SEISMICITY_MANIFEST_KEY,
  SEISMICITY_SPANS,
  spanToMonths,
  spanToObjectKey,
  toJstIsoString,
} from './spans';

describe('spans', () => {
  it('lists exactly the three contract spans in order', () => {
    expect(SEISMICITY_SPANS).toEqual(['P1M', 'P3M', 'P12M']);
  });

  it('maps each span to its month count', () => {
    expect(spanToMonths('P1M')).toBe(1);
    expect(spanToMonths('P3M')).toBe(3);
    expect(spanToMonths('P12M')).toBe(12);
  });

  it('maps each span to a stable seismicity/ prefixed object key', () => {
    expect(spanToObjectKey('P1M')).toBe('seismicity/hypocenters_1m.geojson');
    expect(spanToObjectKey('P3M')).toBe('seismicity/hypocenters_3m.geojson');
    expect(spanToObjectKey('P12M')).toBe('seismicity/hypocenters_12m.geojson');
  });

  it('exposes the internal manifest object key', () => {
    expect(SEISMICITY_MANIFEST_KEY).toBe('seismicity/manifest.json');
  });

  it('computes an ISO timestamp N months before now', () => {
    const now = new Date('2026-07-03T09:00:00.000Z');
    expect(computeSinceIso(now, 1)).toBe('2026-06-03T09:00:00.000Z');
    expect(computeSinceIso(now, 12)).toBe('2025-07-03T09:00:00.000Z');
  });

  it('formats a UTC date as a JST (+09:00) ISO string', () => {
    expect(toJstIsoString(new Date('2026-07-03T00:00:00.000Z'))).toBe(
      '2026-07-03T09:00:00+09:00',
    );
    // crosses midnight into the next day in JST
    expect(toJstIsoString(new Date('2026-07-03T20:00:00.000Z'))).toBe(
      '2026-07-04T05:00:00+09:00',
    );
  });
});
```

- [ ] **Step 4: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: FAIL — `Cannot find module './spans'` (file does not exist yet).

- [ ] **Step 5: Implement `spans.ts`**

Create `service/seismicity-geojson-generator/src/spans.ts`:

```typescript
export const SEISMICITY_SPANS = ['P1M', 'P3M', 'P12M'] as const;
export type SeismicitySpan = (typeof SEISMICITY_SPANS)[number];

export const SEISMICITY_MANIFEST_KEY = 'seismicity/manifest.json';

const SPAN_MONTHS: Record<SeismicitySpan, number> = {
  P1M: 1,
  P3M: 3,
  P12M: 12,
};

const SPAN_OBJECT_KEYS: Record<SeismicitySpan, string> = {
  P1M: 'seismicity/hypocenters_1m.geojson',
  P3M: 'seismicity/hypocenters_3m.geojson',
  P12M: 'seismicity/hypocenters_12m.geojson',
};

export function spanToMonths(span: SeismicitySpan): number {
  return SPAN_MONTHS[span];
}

export function spanToObjectKey(span: SeismicitySpan): string {
  return SPAN_OBJECT_KEYS[span];
}

/** `months` 前の時刻を ISO8601(UTC) で返す */
export function computeSinceIso(now: Date, months: number): string {
  const since = new Date(now.getTime());
  since.setUTCMonth(since.getUTCMonth() - months);
  return since.toISOString();
}

/** UTC の Date を JST(+09:00) の ISO8601 文字列に変換する（Node に依存しない手計算） */
export function toJstIsoString(date: Date): string {
  const jst = new Date(date.getTime() + 9 * 60 * 60 * 1000);
  const pad = (n: number): string => String(n).padStart(2, '0');
  const year = jst.getUTCFullYear();
  const month = pad(jst.getUTCMonth() + 1);
  const day = pad(jst.getUTCDate());
  const hours = pad(jst.getUTCHours());
  const minutes = pad(jst.getUTCMinutes());
  const seconds = pad(jst.getUTCSeconds());
  return `${year}-${month}-${day}T${hours}:${minutes}:${seconds}+09:00`;
}
```

- [ ] **Step 6: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: PASS (6 tests).

- [ ] **Step 7: Write the failing test for the GeoJSON transformer**

Create `service/seismicity-geojson-generator/src/geojson-transformer.test.ts`:

```typescript
import { describe, expect, it } from 'vitest';

import { toHypocenterFeatureCollection } from './geojson-transformer';

describe('toHypocenterFeatureCollection', () => {
  it('converts a DB row into a Point Feature with snake_case properties', () => {
    const result = toHypocenterFeatureCollection([
      {
        eventId: '20260703090000',
        originTime: '2026-07-03T00:00:00.000Z',
        magnitude: '5.2',
        depth: 10,
        latitude: '35.681',
        longitude: '139.767',
        maxIntensity: '4',
      },
    ]);

    expect(result).toEqual({
      type: 'FeatureCollection',
      features: [
        {
          type: 'Feature',
          geometry: { type: 'Point', coordinates: [139.767, 35.681] },
          properties: {
            event_id: '20260703090000',
            origin_time: '2026-07-03T00:00:00.000Z',
            magnitude: 5.2,
            depth: 10,
            max_intensity: '4',
          },
        },
      ],
    });
  });

  it('maps null magnitude/depth/max_intensity through as null', () => {
    const result = toHypocenterFeatureCollection([
      {
        eventId: '1',
        originTime: null,
        magnitude: null,
        depth: null,
        latitude: '0',
        longitude: '0',
        maxIntensity: null,
      },
    ]);

    expect(result.features[0].properties).toEqual({
      event_id: '1',
      origin_time: null,
      magnitude: null,
      depth: null,
      max_intensity: null,
    });
  });

  it('skips rows with a null latitude or longitude (defensive; DB query already filters these)', () => {
    const result = toHypocenterFeatureCollection([
      {
        eventId: '1',
        originTime: null,
        magnitude: null,
        depth: null,
        latitude: null,
        longitude: '139.0',
        maxIntensity: null,
      },
    ]);

    expect(result.features).toHaveLength(0);
  });

  it('returns an empty FeatureCollection for an empty input', () => {
    expect(toHypocenterFeatureCollection([])).toEqual({
      type: 'FeatureCollection',
      features: [],
    });
  });
});
```

- [ ] **Step 8: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: FAIL — `Cannot find module './geojson-transformer'`.

- [ ] **Step 9: Implement `geojson-transformer.ts`**

Create `service/seismicity-geojson-generator/src/geojson-transformer.ts`:

```typescript
export interface EarthquakeGeoRow {
  eventId: string;
  originTime: string | null;
  magnitude: string | null;
  depth: number | null;
  latitude: string | null;
  longitude: string | null;
  maxIntensity: string | null;
}

export interface HypocenterFeature {
  type: 'Feature';
  geometry: {
    type: 'Point';
    coordinates: [number, number];
  };
  properties: {
    event_id: string;
    origin_time: string | null;
    magnitude: number | null;
    depth: number | null;
    max_intensity: string | null;
  };
}

export interface HypocenterFeatureCollection {
  type: 'FeatureCollection';
  features: HypocenterFeature[];
}

export function toHypocenterFeatureCollection(
  rows: EarthquakeGeoRow[],
): HypocenterFeatureCollection {
  const features = rows
    .filter(
      (row): row is EarthquakeGeoRow & { latitude: string; longitude: string } =>
        row.latitude !== null && row.longitude !== null,
    )
    .map(
      (row): HypocenterFeature => ({
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [Number(row.longitude), Number(row.latitude)],
        },
        properties: {
          event_id: row.eventId,
          origin_time: row.originTime,
          magnitude: row.magnitude === null ? null : Number(row.magnitude),
          depth: row.depth,
          max_intensity: row.maxIntensity,
        },
      }),
    );

  return { type: 'FeatureCollection', features };
}
```

- [ ] **Step 10: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: PASS (4 tests, 10 total with Step 6's suite).

- [ ] **Step 11: Type-check**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm check-types`
Expected: no errors.

- [ ] **Step 12: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add service/seismicity-geojson-generator/package.json \
  service/seismicity-geojson-generator/tsconfig.json \
  service/seismicity-geojson-generator/vitest.config.ts \
  service/seismicity-geojson-generator/src/spans.ts \
  service/seismicity-geojson-generator/src/spans.test.ts \
  service/seismicity-geojson-generator/src/geojson-transformer.ts \
  service/seismicity-geojson-generator/src/geojson-transformer.test.ts \
  pnpm-lock.yaml
git commit -m "feat(seismicity-geojson-generator): add pure span and GeoJSON transform utilities"
```

---

## Task 2: Earthquake DB datasource

**Files:**
- Create: `service/seismicity-geojson-generator/src/earthquake-geo-datasource.ts`
- Test: `service/seismicity-geojson-generator/src/earthquake-geo-datasource.test.ts`

**Interfaces:**
- Consumes: `EarthquakeGeoRow` from `./geojson-transformer` (Task 1); `Database` type from `@eqmonitor-backend/database`.
- Produces: `fetchNormalEarthquakesSince(db: Database, sinceIso: string): Promise<EarthquakeGeoRow[]>` — imported by Task 4's orchestration.

- [ ] **Step 1: Write the failing test**

Create `service/seismicity-geojson-generator/src/earthquake-geo-datasource.test.ts`:

```typescript
import { describe, expect, it, vi } from 'vitest';

import { fetchNormalEarthquakesSince } from './earthquake-geo-datasource';

function createDb(findManyResult: unknown[]) {
  const findMany = vi
    .fn<(...args: unknown[]) => Promise<unknown[]>>()
    .mockResolvedValue(findManyResult);
  const db = {
    query: { earthquake: { findMany } },
  } as unknown as Parameters<typeof fetchNormalEarthquakesSince>[0];
  return { db, findMany };
}

describe('fetchNormalEarthquakesSince', () => {
  it('queries NORMAL earthquakes with non-null coordinates since the given time', async () => {
    const { db, findMany } = createDb([]);

    await fetchNormalEarthquakesSince(db, '2026-06-03T00:00:00.000Z');

    expect(findMany).toHaveBeenCalledOnce();
    const config = findMany.mock.calls[0][0] as {
      where: {
        status: string;
        originTime: { gte: string };
        latitude: { isNotNull: boolean };
        longitude: { isNotNull: boolean };
      };
      columns: Record<string, boolean>;
    };
    expect(config.where.status).toBe('NORMAL');
    expect(config.where.originTime).toEqual({ gte: '2026-06-03T00:00:00.000Z' });
    expect(config.where.latitude).toEqual({ isNotNull: true });
    expect(config.where.longitude).toEqual({ isNotNull: true });
    expect(config.columns).toEqual({
      eventId: true,
      originTime: true,
      magnitude: true,
      depth: true,
      latitude: true,
      longitude: true,
      maxIntensity: true,
    });
  });

  it('returns the rows from the database unchanged', async () => {
    const row = {
      eventId: '20260703090000',
      originTime: '2026-07-03T00:00:00.000Z',
      magnitude: '5.2',
      depth: 10,
      latitude: '35.681',
      longitude: '139.767',
      maxIntensity: '4',
    };
    const { db } = createDb([row]);

    const result = await fetchNormalEarthquakesSince(db, '2026-06-03T00:00:00.000Z');

    expect(result).toEqual([row]);
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: FAIL — `Cannot find module './earthquake-geo-datasource'`.

- [ ] **Step 3: Implement `earthquake-geo-datasource.ts`**

Create `service/seismicity-geojson-generator/src/earthquake-geo-datasource.ts`:

```typescript
import type { Database } from '@eqmonitor-backend/database';

import type { EarthquakeGeoRow } from './geojson-transformer';

/**
 * `status = 'NORMAL'` かつ緯度経度が非NULLの地震を、指定時刻以降で取得する。
 * `sinceIso` は ISO8601 (UTC 推奨、PostgreSQL の timestamptz 比較にそのまま渡せる)。
 */
export async function fetchNormalEarthquakesSince(
  db: Database,
  sinceIso: string,
): Promise<EarthquakeGeoRow[]> {
  const rows = await db.query.earthquake.findMany({
    columns: {
      eventId: true,
      originTime: true,
      magnitude: true,
      depth: true,
      latitude: true,
      longitude: true,
      maxIntensity: true,
    },
    where: {
      status: 'NORMAL',
      originTime: { gte: sinceIso },
      latitude: { isNotNull: true },
      longitude: { isNotNull: true },
    },
  });

  return rows;
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: PASS.

- [ ] **Step 5: Type-check**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm check-types`
Expected: no errors. (If `findMany`'s inferred return type doesn't structurally match `EarthquakeGeoRow[]` exactly — e.g. extra `null` vs `undefined` variance on optional columns — adjust `EarthquakeGeoRow` in `geojson-transformer.ts` to match the Drizzle-inferred column types exactly; do not use `as` casts to paper over a mismatch.)

- [ ] **Step 6: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add service/seismicity-geojson-generator/src/earthquake-geo-datasource.ts \
  service/seismicity-geojson-generator/src/earthquake-geo-datasource.test.ts
git commit -m "feat(seismicity-geojson-generator): add earthquake DB datasource"
```

---

## Task 3: S3 storage adapter

**Files:**
- Create: `service/seismicity-geojson-generator/src/storage.ts`
- Test: `service/seismicity-geojson-generator/src/storage.test.ts`

**Interfaces:**
- Produces: `StorageAdapter` interface (`upload(key: string, body: Buffer, contentType: string): Promise<void>`), `S3StorageConfig` interface, `S3StorageAdapter` class implementing `StorageAdapter`. Consumed by Task 4 (`generate-and-upload.ts`) and Task 4's `index.ts` entrypoint.

- [ ] **Step 1: Write the failing test**

Create `service/seismicity-geojson-generator/src/storage.test.ts`:

```typescript
import type { PutObjectCommand } from '@aws-sdk/client-s3';

import { afterEach, describe, expect, it, vi } from 'vitest';

const sendMock = vi.fn<(...args: unknown[]) => Promise<unknown>>();

vi.mock('@aws-sdk/client-s3', async () => {
  const actual =
    await vi.importActual<typeof import('@aws-sdk/client-s3')>('@aws-sdk/client-s3');
  return {
    ...actual,
    S3Client: vi.fn().mockImplementation(() => ({ send: sendMock })),
  };
});

const { S3StorageAdapter } = await import('./storage');

describe('S3StorageAdapter', () => {
  afterEach(() => {
    sendMock.mockReset();
  });

  it('uploads the given key, body and content type via PutObjectCommand', async () => {
    sendMock.mockResolvedValueOnce({});
    const adapter = new S3StorageAdapter({
      endpoint: 'http://localhost:8333',
      region: 'us-east-1',
      accessKeyId: 'key',
      secretAccessKey: 'secret',
      bucketName: 'tiles',
    });

    await adapter.upload(
      'seismicity/manifest.json',
      Buffer.from('{}'),
      'application/json',
    );

    expect(sendMock).toHaveBeenCalledOnce();
    const command = sendMock.mock.calls[0][0] as PutObjectCommand;
    expect(command.input).toEqual({
      Bucket: 'tiles',
      Key: 'seismicity/manifest.json',
      Body: Buffer.from('{}'),
      ContentType: 'application/json',
    });
  });
});
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: FAIL — `Cannot find module './storage'`.

- [ ] **Step 3: Implement `storage.ts`**

Create `service/seismicity-geojson-generator/src/storage.ts`:

```typescript
import { PutObjectCommand, S3Client } from '@aws-sdk/client-s3';

export interface StorageAdapter {
  upload(key: string, body: Buffer, contentType: string): Promise<void>;
}

export interface S3StorageConfig {
  endpoint: string;
  region: string;
  accessKeyId: string;
  secretAccessKey: string;
  bucketName: string;
}

/** SeaweedFS 等の S3 互換 API への保存（既存の tiles バケットを再利用） */
export class S3StorageAdapter implements StorageAdapter {
  private readonly client: S3Client;
  private readonly bucketName: string;

  constructor(config: S3StorageConfig) {
    this.bucketName = config.bucketName;
    this.client = new S3Client({
      region: config.region,
      endpoint: config.endpoint,
      forcePathStyle: true,
      credentials: {
        accessKeyId: config.accessKeyId,
        secretAccessKey: config.secretAccessKey,
      },
    });
  }

  async upload(key: string, body: Buffer, contentType: string): Promise<void> {
    await this.client.send(
      new PutObjectCommand({
        Bucket: this.bucketName,
        Key: key,
        Body: body,
        ContentType: contentType,
      }),
    );
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: PASS.

- [ ] **Step 5: Type-check**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm check-types`
Expected: no errors.

- [ ] **Step 6: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add service/seismicity-geojson-generator/src/storage.ts \
  service/seismicity-geojson-generator/src/storage.test.ts
git commit -m "feat(seismicity-geojson-generator): add S3 storage adapter"
```

---

## Task 4: Orchestration, env/logger, entrypoint, build, Dockerfile

**Files:**
- Create: `service/seismicity-geojson-generator/src/environments.ts`
- Create: `service/seismicity-geojson-generator/src/logger.ts`
- Create: `service/seismicity-geojson-generator/src/generate-and-upload.ts`
- Test: `service/seismicity-geojson-generator/src/generate-and-upload.test.ts`
- Create: `service/seismicity-geojson-generator/src/index.ts`
- Create: `service/seismicity-geojson-generator/vite.config.ts`
- Create: `service/seismicity-geojson-generator/Dockerfile`

**Interfaces:**
- Consumes: `fetchNormalEarthquakesSince` (Task 2), `toHypocenterFeatureCollection` (Task 1), `StorageAdapter` (Task 3), `SEISMICITY_SPANS`/`spanToMonths`/`spanToObjectKey`/`SEISMICITY_MANIFEST_KEY`/`computeSinceIso`/`toJstIsoString` (Task 1), `getDatabase` from `@eqmonitor-backend/database`.
- Produces: `generateAndUploadAll({ db, storage, now? }): Promise<void>` — the only export other tasks/ops need to know about; `index.ts` is the process entrypoint and is not imported elsewhere.

- [ ] **Step 1: Implement `environments.ts` (no test needed — thin Valibot wrapper, exercised end-to-end by Docker build/run in Task 5)**

Create `service/seismicity-geojson-generator/src/environments.ts`:

```typescript
import * as v from 'valibot';

export const environmentsSchema = v.object({
  DATABASE_URL: v.pipe(v.string(), v.minLength(1)),
  S3_ENDPOINT: v.pipe(v.string(), v.minLength(1)),
  S3_BUCKET: v.pipe(v.string(), v.minLength(1)),
  S3_ACCESS_KEY: v.pipe(v.string(), v.minLength(1)),
  S3_SECRET_KEY: v.pipe(v.string(), v.minLength(1)),
  S3_REGION: v.optional(v.pipe(v.string(), v.minLength(1)), 'us-east-1'),
  LOG_LEVEL: v.optional(v.string()),
});

export type Environments = v.InferOutput<typeof environmentsSchema>;

export const environments = v.parse(environmentsSchema, process.env);
```

- [ ] **Step 2: Implement `logger.ts` (no test needed — trivial console wrapper, matches `service/ixac41-pmtiles-generator/src/logger.ts` convention minus OTel)**

Create `service/seismicity-geojson-generator/src/logger.ts`:

```typescript
type LogLevel = 'error' | 'warn' | 'info' | 'debug';
type LogMeta = Record<string, unknown>;

const levelPriority: Record<LogLevel, number> = {
  error: 0,
  warn: 1,
  info: 2,
  debug: 3,
};

const configuredLevel = (process.env.LOG_LEVEL ?? 'info').toLowerCase();
const minimumLevel: LogLevel =
  configuredLevel === 'error' ||
  configuredLevel === 'warn' ||
  configuredLevel === 'info' ||
  configuredLevel === 'debug'
    ? configuredLevel
    : 'info';

function shouldLog(level: LogLevel): boolean {
  return levelPriority[level] <= levelPriority[minimumLevel];
}

function log(level: LogLevel, message: string, meta?: LogMeta): void {
  if (!shouldLog(level)) return;
  console.log(
    JSON.stringify({
      level,
      message,
      timestamp: new Date().toISOString(),
      ...meta,
    }),
  );
}

export const logger = {
  error: (message: string, meta?: LogMeta) => log('error', message, meta),
  warn: (message: string, meta?: LogMeta) => log('warn', message, meta),
  info: (message: string, meta?: LogMeta) => log('info', message, meta),
  debug: (message: string, meta?: LogMeta) => log('debug', message, meta),
};
```

- [ ] **Step 3: Write the failing test for orchestration**

Create `service/seismicity-geojson-generator/src/generate-and-upload.test.ts`:

```typescript
import { describe, expect, it, vi } from 'vitest';

vi.mock('./earthquake-geo-datasource', () => ({
  fetchNormalEarthquakesSince: vi.fn(),
}));

const { fetchNormalEarthquakesSince } = await import('./earthquake-geo-datasource');
const { generateAndUploadAll } = await import('./generate-and-upload');
type StorageAdapter = import('./storage').StorageAdapter;

describe('generateAndUploadAll', () => {
  it('uploads one GeoJSON file per span plus a manifest, in span order', async () => {
    const fetchMock = vi.mocked(fetchNormalEarthquakesSince);
    fetchMock.mockResolvedValue([
      {
        eventId: '1',
        originTime: '2026-07-03T00:00:00.000Z',
        magnitude: '5.0',
        depth: 10,
        latitude: '35.0',
        longitude: '139.0',
        maxIntensity: '4',
      },
    ]);

    const uploadCalls: { key: string; contentType: string }[] = [];
    const storage: StorageAdapter = {
      upload: vi.fn(async (key: string, _body: Buffer, contentType: string) => {
        uploadCalls.push({ key, contentType });
      }),
    };

    await generateAndUploadAll({
      db: {} as never,
      storage,
      now: new Date('2026-07-03T00:00:00.000Z'),
    });

    expect(uploadCalls).toEqual([
      { key: 'seismicity/hypocenters_1m.geojson', contentType: 'application/geo+json' },
      { key: 'seismicity/hypocenters_3m.geojson', contentType: 'application/geo+json' },
      { key: 'seismicity/hypocenters_12m.geojson', contentType: 'application/geo+json' },
      { key: 'seismicity/manifest.json', contentType: 'application/json' },
    ]);
    expect(fetchMock).toHaveBeenCalledTimes(3);
  });

  it('writes a manifest with per-span counts and a shared JST generated_at', async () => {
    const fetchMock = vi.mocked(fetchNormalEarthquakesSince);
    fetchMock
      .mockResolvedValueOnce([
        {
          eventId: '1',
          originTime: null,
          magnitude: null,
          depth: null,
          latitude: '1',
          longitude: '1',
          maxIntensity: null,
        },
      ])
      .mockResolvedValueOnce([])
      .mockResolvedValueOnce([]);

    let manifestBody: Buffer | undefined;
    const storage: StorageAdapter = {
      upload: vi.fn(async (key: string, body: Buffer) => {
        if (key === 'seismicity/manifest.json') manifestBody = body;
      }),
    };

    await generateAndUploadAll({
      db: {} as never,
      storage,
      now: new Date('2026-07-03T00:00:00.000Z'),
    });

    expect(JSON.parse(manifestBody?.toString() ?? '{}')).toEqual({
      generated_at: '2026-07-03T09:00:00+09:00',
      layers: [
        { span: 'P1M', object_key: 'seismicity/hypocenters_1m.geojson', count: 1 },
        { span: 'P3M', object_key: 'seismicity/hypocenters_3m.geojson', count: 0 },
        { span: 'P12M', object_key: 'seismicity/hypocenters_12m.geojson', count: 0 },
      ],
    });
  });
});
```

- [ ] **Step 4: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: FAIL — `Cannot find module './generate-and-upload'`.

- [ ] **Step 5: Implement `generate-and-upload.ts`**

Create `service/seismicity-geojson-generator/src/generate-and-upload.ts`:

```typescript
import type { Database } from '@eqmonitor-backend/database';

import type { StorageAdapter } from './storage';

import { fetchNormalEarthquakesSince } from './earthquake-geo-datasource';
import { toHypocenterFeatureCollection } from './geojson-transformer';
import { logger } from './logger';
import {
  computeSinceIso,
  SEISMICITY_MANIFEST_KEY,
  SEISMICITY_SPANS,
  spanToMonths,
  spanToObjectKey,
  toJstIsoString,
} from './spans';

export interface GenerateAndUploadDeps {
  db: Database;
  storage: StorageAdapter;
  now?: Date;
}

interface ManifestLayer {
  span: (typeof SEISMICITY_SPANS)[number];
  object_key: string;
  count: number;
}

export async function generateAndUploadAll({
  db,
  storage,
  now = new Date(),
}: GenerateAndUploadDeps): Promise<void> {
  const generatedAt = toJstIsoString(now);
  const manifestLayers: ManifestLayer[] = [];

  for (const span of SEISMICITY_SPANS) {
    const sinceIso = computeSinceIso(now, spanToMonths(span));
    const rows = await fetchNormalEarthquakesSince(db, sinceIso);
    const featureCollection = toHypocenterFeatureCollection(rows);
    const objectKey = spanToObjectKey(span);

    await storage.upload(
      objectKey,
      Buffer.from(JSON.stringify(featureCollection)),
      'application/geo+json',
    );
    logger.info('Uploaded seismicity GeoJSON layer', {
      span,
      objectKey,
      count: featureCollection.features.length,
    });

    manifestLayers.push({
      span,
      object_key: objectKey,
      count: featureCollection.features.length,
    });
  }

  const manifest = {
    generated_at: generatedAt,
    layers: manifestLayers,
  };

  await storage.upload(
    SEISMICITY_MANIFEST_KEY,
    Buffer.from(JSON.stringify(manifest)),
    'application/json',
  );
  logger.info('Uploaded seismicity manifest', { generatedAt });
}
```

- [ ] **Step 6: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm test`
Expected: PASS (all suites in the package).

- [ ] **Step 7: Implement the process entrypoint**

Create `service/seismicity-geojson-generator/src/index.ts`:

```typescript
import { getDatabase } from '@eqmonitor-backend/database';

import { environments } from './environments';
import { generateAndUploadAll } from './generate-and-upload';
import { logger } from './logger';
import { S3StorageAdapter } from './storage';

async function main(): Promise<void> {
  const db = getDatabase(environments.DATABASE_URL);
  const storage = new S3StorageAdapter({
    endpoint: environments.S3_ENDPOINT,
    region: environments.S3_REGION,
    accessKeyId: environments.S3_ACCESS_KEY,
    secretAccessKey: environments.S3_SECRET_KEY,
    bucketName: environments.S3_BUCKET,
  });

  await generateAndUploadAll({ db, storage });
}

main()
  .then(() => {
    logger.info('seismicity-geojson-generator finished successfully');
    process.exit(0);
  })
  .catch((error: unknown) => {
    logger.error('seismicity-geojson-generator failed', {
      error: error instanceof Error ? error.message : String(error),
    });
    process.exit(1);
  });
```

- [ ] **Step 8: Add the Vite build config**

Create `service/seismicity-geojson-generator/vite.config.ts`:

```typescript
import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    ssr: 'src/index.ts',
    outDir: 'dist',
    target: 'node24',
    minify: 'oxc',
    rollupOptions: {
      output: {
        entryFileNames: 'index.mjs',
      },
    },
  },
  ssr: {
    noExternal: true,
    external: ['pg-native'],
  },
  resolve: {
    // @ts-expect-error -- resolve.extensionAlias is supported at runtime; not yet in all Vite typings
    extensionAlias: {
      '.js': ['.ts', '.js'],
    },
  },
});
```

- [ ] **Step 9: Build and verify the bundle**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm build`
Expected: `dist/index.mjs` is created without errors.

- [ ] **Step 10: Type-check**

Run: `cd /home/yumnumm/EQMonitor/backend/service/seismicity-geojson-generator && pnpm check-types`
Expected: no errors.

- [ ] **Step 11: Add the Dockerfile**

Create `service/seismicity-geojson-generator/Dockerfile`:

```dockerfile
# syntax=docker/dockerfile:1.7

FROM debian:13-slim AS mise-base
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates git xz-utils libatomic1 \
    && rm -rf /var/lib/apt/lists/*
ENV MISE_DATA_DIR=/mise \
    MISE_CONFIG_DIR=/mise \
    MISE_CACHE_DIR=/mise/cache \
    MISE_INSTALL_PATH=/usr/local/bin/mise \
    MISE_YES=1 \
    PATH=/mise/shims:/usr/local/bin:/usr/bin:/bin
RUN curl https://mise.run | sh
WORKDIR /app
COPY mise.toml mise.lock ./
RUN --mount=type=cache,target=/mise/cache,sharing=locked \
    mise trust && mise install node pnpm \
    && ln -sfn "$(mise where node)" /opt/node

FROM mise-base AS pruner
COPY . .
RUN pnpm dlx turbo prune @eqmonitor-backend/seismicity-geojson-generator --docker

FROM mise-base AS installer
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 make g++ \
    && rm -rf /var/lib/apt/lists/*
COPY --from=pruner /app/out/json/ .
RUN --mount=type=cache,target=/root/.local/share/pnpm/store,sharing=locked \
    pnpm install --frozen-lockfile
COPY --from=pruner /app/out/full/ .
WORKDIR /app/service/seismicity-geojson-generator
RUN pnpm build

FROM debian:13-slim AS runner
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
RUN groupadd --system --gid 1001 nodejs \
    && useradd --system --uid 1001 --gid nodejs appuser
COPY --from=installer /opt/node/bin/node /usr/local/bin/node
WORKDIR /app
COPY --from=installer --chown=appuser:nodejs /app/service/seismicity-geojson-generator/dist ./dist
USER appuser
CMD ["node", "dist/index.mjs"]
```

Note: unlike `service/ixac41-pmtiles-generator/Dockerfile`, there is no `tippecanoe` build stage and no `EXPOSE` — this container runs once and exits (batch job), it does not serve HTTP.

- [ ] **Step 12: Build the Docker image locally to verify the multi-stage build works**

Run: `cd /home/yumnumm/EQMonitor/backend && docker build -f service/seismicity-geojson-generator/Dockerfile -t seismicity-geojson-generator:local .`
Expected: image builds successfully through all 4 stages (`mise-base` → `pruner` → `installer` → `runner`).

- [ ] **Step 13: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add service/seismicity-geojson-generator/src/environments.ts \
  service/seismicity-geojson-generator/src/logger.ts \
  service/seismicity-geojson-generator/src/generate-and-upload.ts \
  service/seismicity-geojson-generator/src/generate-and-upload.test.ts \
  service/seismicity-geojson-generator/src/index.ts \
  service/seismicity-geojson-generator/vite.config.ts \
  service/seismicity-geojson-generator/Dockerfile
git commit -m "feat(seismicity-geojson-generator): add orchestration, entrypoint, build and Dockerfile"
```

---

## Task 5: CI registration (deploy matrix + release-please)

**Files:**
- Modify: `.github/workflows/deploy.yaml:29-42`
- Modify: `release-please-config.json:39-67`

**Interfaces:**
- Consumes: component name `seismicity-geojson-generator`, Dockerfile path `service/seismicity-geojson-generator/Dockerfile` (Task 4).
- Produces: nothing consumed by later tasks — this only wires the existing CI pipeline to build/tag/release the new image.

- [ ] **Step 1: Add the component to `ALL_COMPONENTS` in `deploy.yaml`**

In `/home/yumnumm/EQMonitor/backend/.github/workflows/deploy.yaml`, the `ALL_COMPONENTS` JSON array currently reads (lines 29-42):

```yaml
          ALL_COMPONENTS='[
            {"name":"eqmonitor-api","context":".","dockerfile":"api/api/Dockerfile"},
            {"name":"dmdata-websocket-proxy","context":".","dockerfile":"service/dmdata-websocket-proxy/Dockerfile"},
            {"name":"notification-resolver","context":".","dockerfile":"service/notification-resolver/Dockerfile"},
            {"name":"notification-sender","context":".","dockerfile":"service/notification-sender/Dockerfile"},
            {"name":"telegram-db-writer","context":".","dockerfile":"service/telegram-db-writer/Dockerfile"},
            {"name":"ixac41-parser","context":".","dockerfile":"ixac41_parser/Dockerfile"},
            {"name":"ixac41-pmtiles-generator","context":".","dockerfile":"service/ixac41-pmtiles-generator/Dockerfile"},
            {"name":"replay-generator","context":"KyoshinEewViewerIngen","dockerfile":"KyoshinEewViewerIngen/src/Sandboxes/ReplayGenerator/Dockerfile"},
            {"name":"failover-controller","context":".","dockerfile":"service/failover-controller/Dockerfile"},
            {"name":"eqmonitor-websocket","context":".","dockerfile":"api/websocket/Dockerfile"},
            {"name":"dmdata-websocket-stub","context":".","dockerfile":"service/dmdata-websocket-stub/Dockerfile"},
            {"name":"eqmonitor-api-stub","context":".","dockerfile":"api/api-stub/Dockerfile"}
          ]'
```

Add a new entry (order does not matter functionally; append after `ixac41-pmtiles-generator` for locality):

```yaml
          ALL_COMPONENTS='[
            {"name":"eqmonitor-api","context":".","dockerfile":"api/api/Dockerfile"},
            {"name":"dmdata-websocket-proxy","context":".","dockerfile":"service/dmdata-websocket-proxy/Dockerfile"},
            {"name":"notification-resolver","context":".","dockerfile":"service/notification-resolver/Dockerfile"},
            {"name":"notification-sender","context":".","dockerfile":"service/notification-sender/Dockerfile"},
            {"name":"telegram-db-writer","context":".","dockerfile":"service/telegram-db-writer/Dockerfile"},
            {"name":"ixac41-parser","context":".","dockerfile":"ixac41_parser/Dockerfile"},
            {"name":"ixac41-pmtiles-generator","context":".","dockerfile":"service/ixac41-pmtiles-generator/Dockerfile"},
            {"name":"seismicity-geojson-generator","context":".","dockerfile":"service/seismicity-geojson-generator/Dockerfile"},
            {"name":"replay-generator","context":"KyoshinEewViewerIngen","dockerfile":"KyoshinEewViewerIngen/src/Sandboxes/ReplayGenerator/Dockerfile"},
            {"name":"failover-controller","context":".","dockerfile":"service/failover-controller/Dockerfile"},
            {"name":"eqmonitor-websocket","context":".","dockerfile":"api/websocket/Dockerfile"},
            {"name":"dmdata-websocket-stub","context":".","dockerfile":"service/dmdata-websocket-stub/Dockerfile"},
            {"name":"eqmonitor-api-stub","context":".","dockerfile":"api/api-stub/Dockerfile"}
          ]'
```

- [ ] **Step 2: Validate the YAML/embedded JSON syntax**

Run: `cd /home/yumnumm/EQMonitor/backend && python3 -c "import yaml,sys; yaml.safe_load(open('.github/workflows/deploy.yaml'))" && echo OK`
Expected: `OK` (no YAML parse error). Then extract and lint the embedded JSON:
Run: `awk '/ALL_COMPONENTS=.\[/,/\]./' .github/workflows/deploy.yaml | sed "s/^ *ALL_COMPONENTS='//;s/'$//" | python3 -c "import json,sys; json.loads(sys.stdin.read()); print('OK')"`
Expected: `OK`.

- [ ] **Step 3: Add the component to `release-please-config.json`**

In `/home/yumnumm/EQMonitor/backend/release-please-config.json`, the `packages` object currently is (lines 39-67):

```json
  "packages": {
    "api/api": {
      "component": "eqmonitor-api"
    },
    "service/dmdata-websocket-proxy": {
      "component": "dmdata-websocket-proxy"
    },
    "service/notification-resolver": {
      "component": "notification-resolver"
    },
    "service/notification-sender": {
      "component": "notification-sender"
    },
    "service/telegram-db-writer": {
      "component": "telegram-db-writer"
    },
    "ixac41_parser": {
      "component": "ixac41-parser"
    },
    "service/ixac41-pmtiles-generator": {
      "component": "ixac41-pmtiles-generator"
    },
    "api/websocket": {
      "component": "eqmonitor-websocket"
    },
    "service/failover-controller": {
      "component": "failover-controller"
    }
  }
```

Add a new entry after `service/ixac41-pmtiles-generator`:

```json
  "packages": {
    "api/api": {
      "component": "eqmonitor-api"
    },
    "service/dmdata-websocket-proxy": {
      "component": "dmdata-websocket-proxy"
    },
    "service/notification-resolver": {
      "component": "notification-resolver"
    },
    "service/notification-sender": {
      "component": "notification-sender"
    },
    "service/telegram-db-writer": {
      "component": "telegram-db-writer"
    },
    "ixac41_parser": {
      "component": "ixac41-parser"
    },
    "service/ixac41-pmtiles-generator": {
      "component": "ixac41-pmtiles-generator"
    },
    "service/seismicity-geojson-generator": {
      "component": "seismicity-geojson-generator"
    },
    "api/websocket": {
      "component": "eqmonitor-websocket"
    },
    "service/failover-controller": {
      "component": "failover-controller"
    }
  }
```

- [ ] **Step 4: Validate JSON syntax**

Run: `cd /home/yumnumm/EQMonitor/backend && python3 -c "import json; json.load(open('release-please-config.json')); print('OK')"`
Expected: `OK`.

- [ ] **Step 5: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add .github/workflows/deploy.yaml release-please-config.json
git commit -m "ci: register seismicity-geojson-generator component"
```

---

## Task 6: Kubernetes — CronJob, values, api-deployment env vars

**Files:**
- Create: `deploy/k8s/charts/eqmonitor/templates/seismicity-geojson-generator-cronjob.yaml`
- Modify: `deploy/k8s/charts/eqmonitor/values.yaml` (add `seismicityGeojsonGenerator` block near `ixac41PmtilesGenerator`; add `ingress.tilesHost`)
- Modify: `deploy/k8s/values/tokyo/develop.yaml` (add `ingress.tilesHost` override)
- Modify: `deploy/k8s/charts/eqmonitor/templates/api-deployment.yaml` (add `SEISMICITY_S3_BUCKET` / `SEISMICITY_PUBLIC_BASE_URL` env vars)

**Interfaces:**
- Consumes: image name `seismicity-geojson-generator` (Task 5), bucket name `tiles` (already provisioned), secrets `eqmonitor-secrets` (key `POSTGRES_CONNECTION_STRING`) and `seaweedfs-s3-credentials` (keys `access_key`/`secret_key`) — both already exist in the cluster (used by `ixac41-pmtiles-generator-deployment.yaml` and `api-deployment.yaml` respectively).
- Produces: env vars `SEISMICITY_S3_BUCKET` and `SEISMICITY_PUBLIC_BASE_URL` on the `eqmonitor-api` pod — consumed by Task 7's datasource/route code via `process.env`.

- [ ] **Step 1: Add the `seismicityGeojsonGenerator` values block to the base chart values**

In `/home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor/values.yaml`, insert immediately after the `ixac41PmtilesGenerator:` block (currently ending around line 135, right before `replayGenerator:`):

```yaml
seismicityGeojsonGenerator:
  enabled: true
  image:
    tag: latest
  resources:
    requests:
      memory: '128Mi'
      cpu: '100m'
    limits:
      memory: '512Mi'
      cpu: '500m'
```

- [ ] **Step 2: Add `ingress.tilesHost` to the base chart values**

In the same file, the `ingress:` block currently reads (lines 288-290):

```yaml
ingress:
  apiHost: v2.api.eqmonitor.app
  wsHost: v2.ws.eqmonitor.app
```

Change it to:

```yaml
ingress:
  apiHost: v2.api.eqmonitor.app
  wsHost: v2.ws.eqmonitor.app
  tilesHost: tiles.eqmonitor.app
```

- [ ] **Step 3: Override `ingress.tilesHost` for the develop environment**

In `/home/yumnumm/EQMonitor/backend/deploy/k8s/values/tokyo/develop.yaml`, the `ingress:` block currently reads (lines 184-186):

```yaml
ingress:
  apiHost: dev.v2.api.eqmonitor.app
  wsHost: dev.v2.ws.eqmonitor.app
```

Change it to:

```yaml
ingress:
  apiHost: dev.v2.api.eqmonitor.app
  wsHost: dev.v2.ws.eqmonitor.app
  tilesHost: dev.tiles.eqmonitor.app
```

(No change is needed in `production.yaml` — it inherits `tilesHost: tiles.eqmonitor.app` from the base chart values.)

- [ ] **Step 4: Add the CronJob template**

Create `/home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor/templates/seismicity-geojson-generator-cronjob.yaml`:

```yaml
{{- if .Values.seismicityGeojsonGenerator.enabled }}
# 毎時、直近1/3/12ヶ月分の地震活動 GeoJSON + manifest を生成し
# 既存の SeaweedFS "tiles" バケット (seismicity/ プレフィックス) にアップロードする。
# nginx-tiles 経由で https://tiles.eqmonitor.app/seismicity/*.geojson として配信される。
apiVersion: batch/v1
kind: CronJob
metadata:
  name: seismicity-geojson-generator
  annotations:
    argocd.argoproj.io/sync-wave: '20'
spec:
  schedule: '0 * * * *'
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 3
  jobTemplate:
    spec:
      ttlSecondsAfterFinished: 3600
      backoffLimit: 2
      template:
        metadata:
          labels:
            app: seismicity-geojson-generator
          annotations:
            k8s.grafana.com/beyla-instrument: 'true'
        spec:
          restartPolicy: OnFailure
          imagePullSecrets:
            - name: gar-pull-secret
          containers:
            - name: seismicity-geojson-generator
              image: asia-northeast1-docker.pkg.dev/home8s/home8s-docker/seismicity-geojson-generator:{{ .Values.seismicityGeojsonGenerator.image.tag }}
              imagePullPolicy: Always
              env:
                - name: DATABASE_URL
                  valueFrom:
                    secretKeyRef:
                      name: eqmonitor-secrets
                      key: POSTGRES_CONNECTION_STRING
                - name: S3_ENDPOINT
                  value: 'http://seaweedfs-s3-internal.{{ .Release.Namespace }}.svc.cluster.local:8333'
                - name: S3_BUCKET
                  value: 'tiles'
                - name: S3_ACCESS_KEY
                  valueFrom:
                    secretKeyRef:
                      name: seaweedfs-s3-credentials
                      key: access_key
                - name: S3_SECRET_KEY
                  valueFrom:
                    secretKeyRef:
                      name: seaweedfs-s3-credentials
                      key: secret_key
                - name: S3_REGION
                  value: 'us-east-1'
              resources:
                {{- toYaml .Values.seismicityGeojsonGenerator.resources | nindent 16 }}
{{- end }}
```

- [ ] **Step 5: Add the new env vars to `api-deployment.yaml`**

In `/home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor/templates/api-deployment.yaml`, the existing S3 env block reads (lines 122-138):

```yaml
            # SeaweedFS S3（リプレイファイル署名付き URL 用。replay-generator と同一バケット）
            - name: S3_ENDPOINT
              value: 'http://seaweedfs-s3-internal.{{ .Release.Namespace }}.svc.cluster.local:8333'
            - name: S3_BUCKET
              value: 'eqmonitor-replay'
            - name: INTENSITY_MAP_S3_BUCKET
              value: 'tiles'
            - name: S3_ACCESS_KEY
              valueFrom:
                secretKeyRef:
                  name: seaweedfs-s3-credentials
                  key: access_key
            - name: S3_SECRET_KEY
              valueFrom:
                secretKeyRef:
                  name: seaweedfs-s3-credentials
                  key: secret_key
```

Insert two new env vars right after `INTENSITY_MAP_S3_BUCKET` (before `S3_ACCESS_KEY`):

```yaml
            # SeaweedFS S3（リプレイファイル署名付き URL 用。replay-generator と同一バケット）
            - name: S3_ENDPOINT
              value: 'http://seaweedfs-s3-internal.{{ .Release.Namespace }}.svc.cluster.local:8333'
            - name: S3_BUCKET
              value: 'eqmonitor-replay'
            - name: INTENSITY_MAP_S3_BUCKET
              value: 'tiles'
            - name: SEISMICITY_S3_BUCKET
              value: 'tiles'
            - name: SEISMICITY_PUBLIC_BASE_URL
              value: 'https://{{ .Values.ingress.tilesHost }}'
            - name: S3_ACCESS_KEY
              valueFrom:
                secretKeyRef:
                  name: seaweedfs-s3-credentials
                  key: access_key
            - name: S3_SECRET_KEY
              valueFrom:
                secretKeyRef:
                  name: seaweedfs-s3-credentials
                  key: secret_key
```

- [ ] **Step 6: Lint the Helm chart**

Run: `cd /home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor && helm lint . -f ../../values/tokyo/develop.yaml`
Expected: `0 chart(s) failed` (no template/YAML errors).

- [ ] **Step 7: Render the templates to verify the CronJob and new env vars appear correctly**

Run: `cd /home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor && helm template . -f ../../values/tokyo/develop.yaml --show-only templates/seismicity-geojson-generator-cronjob.yaml`
Expected: renders a single `CronJob` manifest with `schedule: 0 * * * *`, image `.../seismicity-geojson-generator:latest`, and `S3_BUCKET: tiles`.

Run: `cd /home/yumnumm/EQMonitor/backend/deploy/k8s/charts/eqmonitor && helm template . -f ../../values/tokyo/develop.yaml --show-only templates/api-deployment.yaml | grep -A1 SEISMICITY`
Expected:
```
            - name: SEISMICITY_S3_BUCKET
              value: tiles
            - name: SEISMICITY_PUBLIC_BASE_URL
              value: https://dev.tiles.eqmonitor.app
```

Run the same against production values (`../../values/tokyo/production.yaml`) and confirm `SEISMICITY_PUBLIC_BASE_URL` renders as `https://tiles.eqmonitor.app`.

- [ ] **Step 8: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add deploy/k8s/charts/eqmonitor/templates/seismicity-geojson-generator-cronjob.yaml \
  deploy/k8s/charts/eqmonitor/templates/api-deployment.yaml \
  deploy/k8s/charts/eqmonitor/values.yaml \
  deploy/k8s/values/tokyo/develop.yaml
git commit -m "feat(k8s): add hourly seismicity GeoJSON CronJob and api env vars"
```

---

## Task 7: `api/api` seismicity manifest feature

**Files:**
- Create: `api/api/src/features/seismicity/model/responses.ts`
- Create: `api/api/src/features/seismicity/datasource/seismicity-manifest-datasource.ts`
- Test: `api/api/src/features/seismicity/datasource/seismicity-manifest-datasource.test.ts`
- Create: `api/api/src/features/seismicity/transformer/seismicity-manifest-transformer.ts`
- Test: `api/api/src/features/seismicity/transformer/seismicity-manifest-transformer.test.ts`
- Create: `api/api/src/features/seismicity/routes/seismicity.ts`
- Test: `api/api/test/seismicity/seismicity-routes.test.ts`
- Modify: `api/api/src/index.ts` (mount route)
- Modify: `api/api/src/openapi.ts` (add tag)
- Modify: `api/api/src/env.ts` (document new env vars)
- Modify: `api/api/openapi.json` (regenerated)

**Interfaces:**
- Consumes: env vars `S3_ENDPOINT`, `S3_ACCESS_KEY`, `S3_SECRET_KEY`, `SEISMICITY_S3_BUCKET`, `SEISMICITY_PUBLIC_BASE_URL` (Task 6); internal manifest shape `{ generated_at, layers: [{ span, object_key, count }] }` written by the generator (Task 4).
- Produces: `GET /v2/seismicity/manifest` returning `{ layers: [{ type: 'geojson', span, url, generated_at, count }] }` — this is the fixed public contract, consumed by the separate app-side plan.

- [ ] **Step 1: Write the response models**

Create `api/api/src/features/seismicity/model/responses.ts`:

```typescript
import * as v from 'valibot';

export const SeismicityLayerSpan = v.pipe(
  v.picklist(['P1M', 'P3M', 'P12M']),
  v.metadata({ ref: 'SeismicityLayerSpan' }),
);
export type SeismicityLayerSpan = v.InferOutput<typeof SeismicityLayerSpan>;

export const SeismicityManifestLayer = v.pipe(
  v.object({
    type: v.literal('geojson'),
    span: SeismicityLayerSpan,
    url: v.pipe(v.string(), v.url()),
    generated_at: v.string(),
    count: v.pipe(v.number(), v.integer(), v.minValue(0)),
  }),
  v.metadata({ ref: 'SeismicityManifestLayer' }),
);
export type SeismicityManifestLayer = v.InferOutput<typeof SeismicityManifestLayer>;

export const SeismicityManifestResponse = v.pipe(
  v.object({
    layers: v.array(SeismicityManifestLayer),
  }),
  v.metadata({ ref: 'SeismicityManifestResponse' }),
);
export type SeismicityManifestResponse = v.InferOutput<
  typeof SeismicityManifestResponse
>;

export const SeismicityServiceUnavailableResponse = v.pipe(
  v.object({
    code: v.literal('SERVICE_UNAVAILABLE'),
    message: v.string(),
  }),
  v.metadata({ ref: 'SeismicityServiceUnavailableResponse' }),
);
export type SeismicityServiceUnavailableResponse = v.InferOutput<
  typeof SeismicityServiceUnavailableResponse
>;
```

- [ ] **Step 2: Write the failing test for the manifest datasource**

Create `api/api/src/features/seismicity/datasource/seismicity-manifest-datasource.test.ts`:

```typescript
import { afterEach, describe, expect, it, vi } from 'vitest';

const sendMock = vi.fn<(...args: unknown[]) => Promise<unknown>>();

vi.mock('@aws-sdk/client-s3', async () => {
  const actual =
    await vi.importActual<typeof import('@aws-sdk/client-s3')>('@aws-sdk/client-s3');
  return {
    ...actual,
    S3Client: vi.fn().mockImplementation(() => ({ send: sendMock })),
  };
});

const { SeismicityManifestDatasource, SeismicityManifestUnavailableError } =
  await import('./seismicity-manifest-datasource');

function mockManifestBody(value: unknown) {
  return {
    Body: {
      transformToString: async () => JSON.stringify(value),
    },
  };
}

describe('SeismicityManifestDatasource', () => {
  afterEach(() => {
    sendMock.mockReset();
  });

  it('parses the manifest.json object fetched from S3', async () => {
    sendMock.mockResolvedValueOnce(
      mockManifestBody({
        generated_at: '2026-07-03T09:00:00+09:00',
        layers: [
          { span: 'P1M', object_key: 'seismicity/hypocenters_1m.geojson', count: 1 },
        ],
      }),
    );
    const datasource = new SeismicityManifestDatasource({
      endpoint: 'http://localhost:8333',
      region: 'us-east-1',
      accessKeyId: 'key',
      secretAccessKey: 'secret',
      bucket: 'tiles',
    });

    const result = await datasource.getManifest();

    expect(result).toEqual({
      generated_at: '2026-07-03T09:00:00+09:00',
      layers: [
        { span: 'P1M', object_key: 'seismicity/hypocenters_1m.geojson', count: 1 },
      ],
    });
  });

  it('caches the manifest for subsequent calls within the TTL', async () => {
    sendMock.mockResolvedValueOnce(
      mockManifestBody({ generated_at: 'a', layers: [] }),
    );
    const datasource = new SeismicityManifestDatasource({
      endpoint: 'http://localhost:8333',
      region: 'us-east-1',
      accessKeyId: 'key',
      secretAccessKey: 'secret',
      bucket: 'tiles',
    });

    await datasource.getManifest();
    await datasource.getManifest();

    expect(sendMock).toHaveBeenCalledOnce();
  });

  it('throws SeismicityManifestUnavailableError when the object body is empty', async () => {
    sendMock.mockResolvedValueOnce({ Body: undefined });
    const datasource = new SeismicityManifestDatasource({
      endpoint: 'http://localhost:8333',
      region: 'us-east-1',
      accessKeyId: 'key',
      secretAccessKey: 'secret',
      bucket: 'tiles',
    });

    await expect(datasource.getManifest()).rejects.toThrow(
      SeismicityManifestUnavailableError,
    );
  });
});
```

- [ ] **Step 3: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run src/features/seismicity/datasource/seismicity-manifest-datasource.test.ts`
Expected: FAIL — `Cannot find module './seismicity-manifest-datasource'`.

- [ ] **Step 4: Implement the manifest datasource**

Create `api/api/src/features/seismicity/datasource/seismicity-manifest-datasource.ts`:

```typescript
import { GetObjectCommand, S3Client } from '@aws-sdk/client-s3';

export interface SeismicityManifestLayerRaw {
  span: 'P1M' | 'P3M' | 'P12M';
  object_key: string;
  count: number;
}

export interface SeismicityManifestRaw {
  generated_at: string;
  layers: SeismicityManifestLayerRaw[];
}

export class SeismicityManifestUnavailableError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'SeismicityManifestUnavailableError';
  }
}

export interface SeismicityManifestDatasourceConfig {
  endpoint: string;
  region: string;
  accessKeyId: string;
  secretAccessKey: string;
  bucket: string;
  manifestKey?: string;
}

const CACHE_TTL_MS = 60_000;

interface CacheEntry {
  value: SeismicityManifestRaw;
  fetchedAt: number;
}

export class SeismicityManifestDatasource {
  private readonly client: S3Client;
  private readonly bucket: string;
  private readonly manifestKey: string;
  private cache: CacheEntry | null = null;

  constructor(config: SeismicityManifestDatasourceConfig) {
    this.bucket = config.bucket;
    this.manifestKey = config.manifestKey ?? 'seismicity/manifest.json';
    this.client = new S3Client({
      region: config.region,
      endpoint: config.endpoint,
      forcePathStyle: true,
      credentials: {
        accessKeyId: config.accessKeyId,
        secretAccessKey: config.secretAccessKey,
      },
    });
  }

  async getManifest(): Promise<SeismicityManifestRaw> {
    if (this.cache && Date.now() - this.cache.fetchedAt < CACHE_TTL_MS) {
      return this.cache.value;
    }

    let body: string | undefined;
    try {
      const result = await this.client.send(
        new GetObjectCommand({ Bucket: this.bucket, Key: this.manifestKey }),
      );
      body = await result.Body?.transformToString();
    } catch (error) {
      throw new SeismicityManifestUnavailableError(
        `Failed to fetch seismicity manifest: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
    }

    if (!body) {
      throw new SeismicityManifestUnavailableError('Empty seismicity manifest body');
    }

    const value = JSON.parse(body) as SeismicityManifestRaw;
    this.cache = { value, fetchedAt: Date.now() };
    return value;
  }
}
```

- [ ] **Step 5: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run src/features/seismicity/datasource/seismicity-manifest-datasource.test.ts`
Expected: PASS (3 tests).

- [ ] **Step 6: Write the failing test for the manifest transformer**

Create `api/api/src/features/seismicity/transformer/seismicity-manifest-transformer.test.ts`:

```typescript
import { describe, expect, it } from 'vitest';

import { toSeismicityManifestResponse } from './seismicity-manifest-transformer';

describe('toSeismicityManifestResponse', () => {
  it('builds public manifest layers with absolute urls and a shared generated_at', () => {
    const result = toSeismicityManifestResponse(
      {
        generated_at: '2026-07-03T09:00:00+09:00',
        layers: [
          { span: 'P1M', object_key: 'seismicity/hypocenters_1m.geojson', count: 12 },
          { span: 'P3M', object_key: 'seismicity/hypocenters_3m.geojson', count: 34 },
        ],
      },
      'https://tiles.eqmonitor.app',
    );

    expect(result).toEqual({
      layers: [
        {
          type: 'geojson',
          span: 'P1M',
          url: 'https://tiles.eqmonitor.app/seismicity/hypocenters_1m.geojson',
          generated_at: '2026-07-03T09:00:00+09:00',
          count: 12,
        },
        {
          type: 'geojson',
          span: 'P3M',
          url: 'https://tiles.eqmonitor.app/seismicity/hypocenters_3m.geojson',
          generated_at: '2026-07-03T09:00:00+09:00',
          count: 34,
        },
      ],
    });
  });

  it('strips a trailing slash from the base url', () => {
    const result = toSeismicityManifestResponse(
      {
        generated_at: '2026-07-03T09:00:00+09:00',
        layers: [
          { span: 'P12M', object_key: 'seismicity/hypocenters_12m.geojson', count: 1 },
        ],
      },
      'https://tiles.eqmonitor.app/',
    );

    expect(result.layers[0].url).toBe(
      'https://tiles.eqmonitor.app/seismicity/hypocenters_12m.geojson',
    );
  });
});
```

- [ ] **Step 7: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run src/features/seismicity/transformer/seismicity-manifest-transformer.test.ts`
Expected: FAIL — `Cannot find module './seismicity-manifest-transformer'`.

- [ ] **Step 8: Implement the transformer**

Create `api/api/src/features/seismicity/transformer/seismicity-manifest-transformer.ts`:

```typescript
import type { SeismicityManifestRaw } from '../datasource/seismicity-manifest-datasource';
import type { SeismicityManifestResponse } from '../model/responses';

export function toSeismicityManifestResponse(
  raw: SeismicityManifestRaw,
  publicBaseUrl: string,
): SeismicityManifestResponse {
  const base = publicBaseUrl.replace(/\/$/, '');
  return {
    layers: raw.layers.map(layer => ({
      type: 'geojson' as const,
      span: layer.span,
      url: `${base}/${layer.object_key}`,
      generated_at: raw.generated_at,
      count: layer.count,
    })),
  };
}
```

- [ ] **Step 9: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run src/features/seismicity/transformer/seismicity-manifest-transformer.test.ts`
Expected: PASS (2 tests).

- [ ] **Step 10: Write the failing route test**

Create `api/api/test/seismicity/seismicity-routes.test.ts`:

```typescript
import { Hono } from 'hono';
import { afterEach, describe, expect, it, vi } from 'vitest';

const sendMock = vi.fn<(...args: unknown[]) => Promise<unknown>>();

vi.mock('@aws-sdk/client-s3', async () => {
  const actual =
    await vi.importActual<typeof import('@aws-sdk/client-s3')>('@aws-sdk/client-s3');
  return {
    ...actual,
    S3Client: vi.fn().mockImplementation(() => ({ send: sendMock })),
  };
});

const { default: seismicityRoutes } = await import(
  '../../src/features/seismicity/routes/seismicity'
);

const ORIGINAL_ENV = { ...process.env };

function createTestApp() {
  const app = new Hono();
  app.route('/seismicity', seismicityRoutes);
  return app;
}

describe('GET /seismicity/manifest', () => {
  afterEach(() => {
    process.env = { ...ORIGINAL_ENV };
    sendMock.mockReset();
  });

  it('returns 503 when S3 configuration is missing', async () => {
    delete process.env.S3_ENDPOINT;
    delete process.env.SEISMICITY_S3_BUCKET;
    delete process.env.SEISMICITY_PUBLIC_BASE_URL;

    const res = await createTestApp().request('/seismicity/manifest');

    expect(res.status).toBe(503);
  });

  it('returns the public manifest when configured', async () => {
    process.env.S3_ENDPOINT = 'http://localhost:8333';
    process.env.S3_ACCESS_KEY = 'key';
    process.env.S3_SECRET_KEY = 'secret';
    process.env.SEISMICITY_S3_BUCKET = 'tiles';
    process.env.SEISMICITY_PUBLIC_BASE_URL = 'https://tiles.eqmonitor.app';
    sendMock.mockResolvedValueOnce({
      Body: {
        transformToString: async () =>
          JSON.stringify({
            generated_at: '2026-07-03T09:00:00+09:00',
            layers: [
              { span: 'P1M', object_key: 'seismicity/hypocenters_1m.geojson', count: 5 },
            ],
          }),
      },
    });

    const res = await createTestApp().request('/seismicity/manifest');
    const body = (await res.json()) as {
      layers: { span: string; url: string; count: number }[];
    };

    expect(res.status).toBe(200);
    expect(body.layers).toEqual([
      {
        type: 'geojson',
        span: 'P1M',
        url: 'https://tiles.eqmonitor.app/seismicity/hypocenters_1m.geojson',
        generated_at: '2026-07-03T09:00:00+09:00',
        count: 5,
      },
    ]);
  });
});
```

- [ ] **Step 11: Run test to verify it fails**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run test/seismicity/seismicity-routes.test.ts`
Expected: FAIL — `Cannot find module '../../src/features/seismicity/routes/seismicity'`.

- [ ] **Step 12: Implement the route**

Create `api/api/src/features/seismicity/routes/seismicity.ts`:

```typescript
import type { HonoBindings } from '../../../index';

import { Hono } from 'hono';
import { describeRoute, resolver } from 'hono-openapi';

import { InternalServerErrorResponse } from '../../../shared/model/common-response';
import {
  SeismicityManifestDatasource,
  SeismicityManifestUnavailableError,
} from '../datasource/seismicity-manifest-datasource';
import {
  SeismicityManifestResponse,
  SeismicityServiceUnavailableResponse,
} from '../model/responses';
import { toSeismicityManifestResponse } from '../transformer/seismicity-manifest-transformer';

function createSeismicityManifestDatasource(): SeismicityManifestDatasource | null {
  const endpoint = process.env.S3_ENDPOINT?.trim();
  const accessKeyId = process.env.S3_ACCESS_KEY?.trim();
  const secretAccessKey = process.env.S3_SECRET_KEY?.trim();
  const bucket = process.env.SEISMICITY_S3_BUCKET?.trim();
  if (!endpoint || !accessKeyId || !secretAccessKey || !bucket) {
    return null;
  }
  return new SeismicityManifestDatasource({
    endpoint,
    accessKeyId,
    secretAccessKey,
    bucket,
    region: process.env.S3_REGION?.trim() || 'us-east-1',
  });
}

const app = new Hono<HonoBindings>()
  .use((c, next) => {
    c.res.headers.set(
      'Cache-Control',
      process.env.CACHE_SEISMICITY_MANIFEST ||
        'public, max-age=60, stale-while-revalidate=300, stale-if-error=3600',
    );
    return next();
  })
  .get(
    '/manifest',
    describeRoute({
      tags: ['Seismicity'],
      description: '地震活動可視化用GeoJSONレイヤーのmanifest',
      responses: {
        200: {
          description: '震源レイヤーmanifest',
          content: {
            'application/json': { schema: resolver(SeismicityManifestResponse) },
          },
        },
        503: {
          description: 'manifestが利用できません',
          content: {
            'application/json': {
              schema: resolver(SeismicityServiceUnavailableResponse),
            },
          },
        },
        500: {
          description: '内部サーバエラー',
          content: {
            'application/json': { schema: resolver(InternalServerErrorResponse) },
          },
        },
      },
    }),
    async c => {
      const datasource = createSeismicityManifestDatasource();
      const publicBaseUrl = process.env.SEISMICITY_PUBLIC_BASE_URL?.trim();
      if (!datasource || !publicBaseUrl) {
        return c.json(
          {
            code: 'SERVICE_UNAVAILABLE',
            message: 'Seismicity manifest is not configured.',
          },
          503,
        );
      }
      try {
        const raw = await datasource.getManifest();
        return c.json(toSeismicityManifestResponse(raw, publicBaseUrl));
      } catch (error) {
        if (error instanceof SeismicityManifestUnavailableError) {
          return c.json(
            {
              code: 'SERVICE_UNAVAILABLE',
              message: 'Seismicity manifest is not available.',
            },
            503,
          );
        }
        throw error;
      }
    },
  );

export default app;
```

- [ ] **Step 13: Run test to verify it passes**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm vitest run test/seismicity/seismicity-routes.test.ts`
Expected: PASS (2 tests).

- [ ] **Step 14: Mount the route in the main app**

In `/home/yumnumm/EQMonitor/backend/api/api/src/index.ts`, add the import near the other feature imports and add `.route('/v2/seismicity', seismicity)` to the chain (currently lines 252-265):

```typescript
    .route('/v1/changelog', changelog)
    .route('/v1/start', start)
    .route('/v2/admin', admin)
    .route('/v2/device', device)
    .route('/v2/earthquake', earthquake)
    .route('/v2/eew', eew)
    .route('/v2/feeds', feed)
    .route('/v2/parameters', parameters)
    .route('/v2/seismicity', seismicity)
    .route('/v2/subscription', subscription)
    .route('/v2/telegram', telegram)
    .route('/v2/tsunami', tsunami)
    .route('/v2/user', user)
    .route('/v2/realtime', realtime)
    .route('/webhooks', revenuecatWebhook)
```

And add the corresponding import alongside the existing `import parameters from './features/parameters/routes/parameters';`:

```typescript
import seismicity from './features/seismicity/routes/seismicity';
```

- [ ] **Step 15: Add the `Seismicity` OpenAPI tag**

In `/home/yumnumm/EQMonitor/backend/api/api/src/openapi.ts`, the `tags` array currently reads:

```typescript
    tags: [
      { name: 'Start', description: 'アプリ起動情報' },
      { name: 'Changelog', description: 'バージョン履歴' },
      { name: 'Earthquake', description: '地震情報' },
      { name: 'EEW', description: '緊急地震速報' },
      { name: 'Telegram', description: '気象庁電文' },
      { name: 'User', description: 'ユーザー' },
      { name: 'Realtime', description: 'リアルタイム（SSE）' },
      { name: 'Device', description: 'デバイス' },
      { name: 'Parameters', description: 'アプリ配信用パラメーターデータ' },
    ],
```

Add a new entry after `Parameters`:

```typescript
    tags: [
      { name: 'Start', description: 'アプリ起動情報' },
      { name: 'Changelog', description: 'バージョン履歴' },
      { name: 'Earthquake', description: '地震情報' },
      { name: 'EEW', description: '緊急地震速報' },
      { name: 'Telegram', description: '気象庁電文' },
      { name: 'User', description: 'ユーザー' },
      { name: 'Realtime', description: 'リアルタイム（SSE）' },
      { name: 'Device', description: 'デバイス' },
      { name: 'Parameters', description: 'アプリ配信用パラメーターデータ' },
      { name: 'Seismicity', description: '地震活動可視化（震央分布manifest）' },
    ],
```

- [ ] **Step 16: Document the new env vars in `env.ts`**

In `/home/yumnumm/EQMonitor/backend/api/api/src/env.ts`, add the two new optional keys next to the existing `S3_*` entries:

```typescript
  S3_ENDPOINT: v.optional(v.string()),
  S3_BUCKET: v.optional(v.string()),
  S3_INTENSITY_MAP_BUCKET: v.optional(v.string()),
  S3_ACCESS_KEY: v.optional(v.string()),
  S3_SECRET_KEY: v.optional(v.string()),
  S3_REGION: v.optional(v.string()),
  SEISMICITY_S3_BUCKET: v.optional(v.string()),
  SEISMICITY_PUBLIC_BASE_URL: v.optional(v.string()),
```

(These are read directly via `process.env` in `routes/seismicity.ts`, following the same pattern already used by `src/features/earthquake/lib/s3-presigned-get-url.ts` for `S3_ENDPOINT`/`S3_ACCESS_KEY`/etc. — `EnvSchema` here serves as documentation/validation of the full env var surface, not as the only read path.)

- [ ] **Step 17: Run the full api/api test suite**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm test`
Expected: all tests pass, including the new seismicity datasource/transformer/route tests and all pre-existing tests (no regressions).

- [ ] **Step 18: Type-check**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm check-types`
Expected: no errors.

- [ ] **Step 19: Regenerate the OpenAPI spec**

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && pnpm generate:openapi > openapi.json`
Expected: `openapi.json` is rewritten and now includes a `/v2/seismicity/manifest` path with the `Seismicity` tag and the `SeismicityManifestResponse`/`SeismicityServiceUnavailableResponse` schemas.

Run: `cd /home/yumnumm/EQMonitor/backend/api/api && python3 -c "import json; d=json.load(open('openapi.json')); assert '/v2/seismicity/manifest' in d['paths']; print('OK')"`
Expected: `OK`.

- [ ] **Step 20: Commit**

```bash
cd /home/yumnumm/EQMonitor/backend
git add api/api/src/features/seismicity \
  api/api/test/seismicity \
  api/api/src/index.ts \
  api/api/src/openapi.ts \
  api/api/src/env.ts \
  api/api/openapi.json
git commit -m "feat(api): add GET /v2/seismicity/manifest endpoint"
```

---

## Task 8: End-to-end verification

**Files:** none (verification only — no code changes).

**Interfaces:**
- Consumes: everything produced by Tasks 1-7.
- Produces: confidence that the full pipeline (DB → generator → S3 → nginx-tiles → API manifest) works before merging.

- [ ] **Step 1: Full monorepo lint**

Run: `cd /home/yumnumm/EQMonitor/backend && pnpm lint`
Expected: no errors (oxlint `--deny-warnings` passes for both the new `service/seismicity-geojson-generator` package and the modified `api/api` files; `oxfmt` reports no diffs).

- [ ] **Step 2: Full monorepo type-check**

Run: `cd /home/yumnumm/EQMonitor/backend && pnpm check-types`
Expected: no errors across all workspace packages (turbo runs `check-types` for every package including the two touched in this plan).

- [ ] **Step 3: Full monorepo test run**

Run: `cd /home/yumnumm/EQMonitor/backend && pnpm test`
Expected: all packages' test suites pass, including:
- `service/seismicity-geojson-generator`: `spans.test.ts`, `geojson-transformer.test.ts`, `earthquake-geo-datasource.test.ts`, `storage.test.ts`, `generate-and-upload.test.ts`
- `api/api`: `seismicity-manifest-datasource.test.ts`, `seismicity-manifest-transformer.test.ts`, `seismicity-routes.test.ts`, plus every pre-existing test (no regressions from mounting the new route or editing `env.ts`/`openapi.ts`).

- [ ] **Step 4: Local end-to-end dry run against docker-compose**

Run:
```bash
cd /home/yumnumm/EQMonitor/backend
docker compose up -d postgres
cd service/seismicity-geojson-generator
DATABASE_URL="postgres://postgres:postgres@localhost:5432/eqmonitor" \
S3_ENDPOINT="http://localhost:8333" \
S3_BUCKET="tiles" \
S3_ACCESS_KEY="test" \
S3_SECRET_KEY="test" \
node dist/index.mjs
```
Expected: if a local SeaweedFS/MinIO container is available on `localhost:8333` with a `tiles` bucket, the process logs `Uploaded seismicity GeoJSON layer` three times and `Uploaded seismicity manifest` once, then exits with code `0`. If no local S3-compatible endpoint is available, this step may instead be verified against the `develop` cluster's SeaweedFS via `kubectl port-forward svc/seaweedfs-s3-internal 8333:8333 -n eqmonitor-tokyo-develop` and the same env vars pointed at `localhost:8333`.

- [ ] **Step 5: Verify the uploaded objects are publicly reachable**

Run: `curl -s -o /dev/null -w '%{http_code}\n' https://dev.tiles.eqmonitor.app/seismicity/hypocenters_1m.geojson`
Expected: `200` (after Task 6's CronJob or Step 4's manual run has executed at least once against the `develop` environment).

Run: `curl -s https://dev.tiles.eqmonitor.app/seismicity/hypocenters_1m.geojson | python3 -c "import json,sys; d=json.load(sys.stdin); assert d['type']=='FeatureCollection'; print('features:', len(d['features']))"`
Expected: prints `features: <N>` with no assertion error.

- [ ] **Step 6: Verify the manifest API end-to-end (once deployed to develop)**

Run: `curl -s https://dev.v2.api.eqmonitor.app/v2/seismicity/manifest | python3 -m json.tool`
Expected:
```json
{
  "layers": [
    {
      "type": "geojson",
      "span": "P1M",
      "url": "https://dev.tiles.eqmonitor.app/seismicity/hypocenters_1m.geojson",
      "generated_at": "2026-07-03T09:00:00+09:00",
      "count": 0
    },
    {
      "type": "geojson",
      "span": "P3M",
      "url": "https://dev.tiles.eqmonitor.app/seismicity/hypocenters_3m.geojson",
      "generated_at": "2026-07-03T09:00:00+09:00",
      "count": 0
    },
    {
      "type": "geojson",
      "span": "P12M",
      "url": "https://dev.tiles.eqmonitor.app/seismicity/hypocenters_12m.geojson",
      "generated_at": "2026-07-03T09:00:00+09:00",
      "count": 0
    }
  ]
}
```
(exact `count`/`generated_at` values depend on develop DB contents and last CronJob run time — the structural shape and 3 spans in order is what matters).

- [ ] **Step 7: Confirm CronJob scheduling in the cluster (post-deploy)**

Run: `kubectl get cronjob seismicity-geojson-generator -n eqmonitor-tokyo-develop`
Expected: `SCHEDULE` column shows `0 * * * *`, `SUSPEND` is `False`.

Run: `kubectl get jobs -n eqmonitor-tokyo-develop -l app=seismicity-geojson-generator`
Expected: at least one `Job` with `COMPLETIONS 1/1` after the first hourly tick.

---

## Self-Review

**1. Spec coverage:**
- Hourly CronJob generating 1/3/12-month GeoJSON → Task 6 (CronJob) + Task 4 (generator logic that produces exactly 3 spans).
- Upload to SeaweedFS S3 → Task 3 (`S3StorageAdapter`) + Task 4 (`generate-and-upload.ts`).
- Static delivery via nginx → reused existing `nginx-tiles` + `tiles` bucket (documented design decision in File Structure section) — no new infra needed, verified in Task 8 Step 5.
- Manifest API providing layer source description `{ type, span, url, generated_at, count }` → Task 7, exact shape verified by transformer test (Step 6-9) and route test (Step 10-13).
- Extraction condition (`originTime >= now - span`, non-null lat/lon, `status = 'NORMAL'`) → Task 2's datasource + its test asserting the exact `where` clause.
- GeoJSON Feature shape (`Point`, `event_id`/`origin_time`/`magnitude`/`depth`/`max_intensity`) → Task 1's transformer + test.
- `span` fixed to `"P1M" | "P3M" | "P12M"` → `SeismicityLayerSpan` picklist (Task 7) and `SEISMICITY_SPANS` const (Task 1) both enumerate exactly these three values.
- CI registration (deploy matrix, release-please) → Task 5.
- No DB schema changes → confirmed; this plan reads the existing `earthquake` table only, no migration task included.
- No new bucket/nginx changes → explicitly decided against in the File Structure section, with the precedent (`INTENSITY_MAP_S3_BUCKET=tiles`) cited as justification.

**2. Placeholder scan:** No "TBD"/"add validation"/"similar to Task N" phrases were used; every step that changes code shows the complete file content or an exact before/after diff with real line numbers from the files read during research. Step 4 of Task 8 acknowledges an environment-dependent fallback (local vs port-forwarded S3) but still gives concrete commands for both paths, not a vague placeholder.

**3. Type consistency check:**
- `EarthquakeGeoRow` (Task 1) is used identically in Task 2's datasource return type and Task 1's transformer input — same field names/types throughout (`eventId: string`, `originTime: string | null`, `magnitude: string | null`, `depth: number | null`, `latitude/longitude: string | null`, `maxIntensity: string | null`).
- `StorageAdapter.upload(key, body, contentType)` (Task 3) signature matches every call site in Task 4 (`generate-and-upload.ts`) and every test mock (Task 4's test, Task 8 references).
- `SEISMICITY_SPANS`/`spanToMonths`/`spanToObjectKey`/`SEISMICITY_MANIFEST_KEY`/`computeSinceIso`/`toJstIsoString` (Task 1) are imported by exactly those names in Task 4 — no renaming drift.
- Internal manifest shape `{ generated_at, layers: [{ span, object_key, count }] }` is produced by Task 4 (`generate-and-upload.ts`) and consumed by Task 7 (`SeismicityManifestRaw` / `SeismicityManifestLayerRaw` in the datasource, and `toSeismicityManifestResponse`'s first parameter) — field names (`generated_at`, `object_key`, `span`, `count`) match exactly on both sides.
- Public response shape `{ layers: [{ type, span, url, generated_at, count }] }` (Task 7's `SeismicityManifestResponse`) matches the fixed contract in Global Constraints verbatim, and the route test (Task 7 Step 10) asserts this exact JSON shape.
- Env var names `SEISMICITY_S3_BUCKET` / `SEISMICITY_PUBLIC_BASE_URL` are identical across Task 6 (K8s env injection), Task 7 Step 12 (route reads `process.env.SEISMICITY_S3_BUCKET` / `process.env.SEISMICITY_PUBLIC_BASE_URL`), and Task 7 Step 16 (`env.ts` documentation).

No gaps found requiring additional tasks.

