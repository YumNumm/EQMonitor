# 950: Seismicity manifest descriptor fields (stacked backend dependency)

Priority: 950
Scope: documentation only for #1601. Do **not** implement backend, OpenAPI,
or app adapter changes in this PR stack.

## Current evidence (checked out)

### Producer / internal S3 hypocenter manifest

`backend/api/api/src/features/hypocenter/datasource/manifest-datasource.ts`
already validates:

- `schema_version` (literal `1`)
- per-archive `archive_revision`
- `feature_count`, `size_bytes`, period, object_key

It does **not** define `data_zoom`. Decoder `dataZoom` therefore cannot be
taken from the producer manifest today.

### Public OpenAPI / `eqmonitor_api` clients

Public client models used by the app still lack the three decoder identity
fields as first-class JSON:

- `schema_version`
- `data_zoom`
- `archive_revision`

Examples:

- `SeismicityManifestLayer` exposes `type` / `span` / `url` / `generated_at` /
  `count` only (`packages/eqmonitor_api/lib/src/models/seismicity_manifest_layer.dart`).
- `HypocenterManifestResponse` wraps `Data2` + `HypocenterMeta` without those
  three public fields for archive identity.

Decoder ownership requires a caller-complete
`SeismicityPmTilesArchiveDescriptor`. Until OpenAPI and the app adapter
surface the fields, the decoder must not invent `schemaVersion=1`,
`dataZoom=14`, or values derived from the PMTiles URL.

## Required stacked work (outside #1601)

1. **Backend producer**
   - Add `data_zoom` to each archive (or top-level if globally fixed) in the
     hypocenter/seismicity manifest schema.
   - Keep `schema_version` and `archive_revision` authoritative; do not allow
     silent drift.
2. **OpenAPI**
   - Publish `schema_version`, `data_zoom`, and `archive_revision` on the
     public manifest response used by Flutter.
   - Regenerate `packages/eqmonitor_api` only after OpenAPI lands.
3. **App adapter**
   - Map every descriptor field from the public manifest while opening
     Factory / reader / archive.
   - Pass `archive.descriptor` unchanged into `SeismicityPmTilesDecoder`.

## Validation / rollout order

```bash
set -eu
# 1) Backend contract + producer tests
# 2) OpenAPI regen into eqmonitor_api
# 3) App adapter wiring (no decoder fallback)
# 4) Decode harness remains correctness-only:
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
```

## Prohibitions

- No decoder fallback to schema/data zoom `1` / `14`.
- No inferring descriptor fields from archive URL path segments.
- No partial dataset publication when identity/count gates fail.
- No backend rewrite/merge inside the #1601 seismicity decoder stack tip.

## Acceptance for the follow-up stack

- Public manifest JSON includes `schema_version`, `data_zoom`, and
  `archive_revision`.
- App adapter builds a complete descriptor without hard-coded zoom/schema.
- Decoder still treats `archive.descriptor` as the single ownership boundary.
