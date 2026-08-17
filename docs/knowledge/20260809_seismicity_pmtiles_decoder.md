# Seismicity PMTiles decoder contracts

Date: 2026-08-09
Package: `packages/seismicity_pmtiles`

## Ownership

1. Caller/adapter supplies every `SeismicityPmTilesArchiveDescriptor` field
   (`schemaVersion`, `dataZoom`, `archiveRevision`, counts, periods, source)
   while opening Factory / reader / archive.
2. The opened archive exposes that accepted `archive.descriptor` as the only
   identity. Decoder/runner never accept a replacement descriptor.
3. Decoder starts with `archive` + `chunkCapacity` only. It closes the archive
   on success, failure, and cancel. No schema/data-zoom `1`/`14` fallback and
   no URL inference.

## Schema v1 decode

- Layer `hypocenters`, Point geometry, extent-aware tile local → global.
- All eight properties participate in canonical duplicate detection
  (`duplicateConflict` when geometry + properties collide).
- Missing depth/magnitude use NaN + clear validity; explicit zero stays valid.
- Numeric outputs are finite Float32 storage slots.
- Present empty `earthquake_event_id` fails; empty `max_intensity` /
  `determination_flag` remain distinct from absence.
- Max-intensity dictionary is typed UTF-8 offsets/indexes/validity.
- Publication validates every chunk, checked feature-count sum, and descriptor
  identity before returning a complete dataset. No partial dataset.

## Worker

- One long-lived isolate worker receives/returns `TransferableTypedData`.
- Public facade uses the real isolate factory; tests inject non-export seams.
- Cancel is client-side: close receive port, kill/wait isolate; no worker ack.

## Reproducible commands

```bash
mise exec -- dart test packages/seismicity_pmtiles/test
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
```

Harness exit is correctness-only (worker/count/bytes/close). Threshold,
`within_target`, elapsed, and RSS are observational.
