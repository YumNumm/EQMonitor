# Seismicity PMTiles Decoder Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `SeismicityPmTilesArchive` の descriptor 指定 data zoom にある全震源を、厳密な schema v1 MVT 検証、境界重複排除、常駐 Isolate、`TransferableTypedData` を通して列形式 dataset へ変換する。

**Architecture:** opener が受理した唯一の descriptor を `SeismicityPmTilesArchive` が保持し、main isolate の decode operation は archive I/O・descriptor・worker の所有権を持つ。展開済み MVT tile bytes だけを1個の常駐 worker isolateへ順番に移譲し、workerは raw protobufを厳密検証してpublic typed columnとall-property canonical sidecarへ蓄積する。同一UUIDの幾何とschema-v1全propertyが完全一致するコピーだけを排除し、archive descriptor の identity/count gateを通過したときだけpublic chunk群を `TransferableTypedData` でmain isolateへ返す。

**Tech Stack:** Dart 3.11+ / `pmtiles_v3` / `seismicity_pmtiles` / `vector_tile` 4.0.0 raw protobuf API / `uuid` 4.6.x / Freezed / `dart:isolate` / `TransferableTypedData` / `test`

## Global Constraints

- Base branch is `feat/seismicity-pmtiles-network-reader`; this branch is `feat/seismicity-pmtiles-decoder` and must remain its direct stacked child.
- Scope is Issue #1601 only. Do not reimplement #1600 HTTP/File/Asset random access, and do not add #1602 projection, Flutter Scene, GPU, Shader, camera, or app UI code.
- Every Flutter/Dart command runs through `mise exec --`. Add dependencies only with `(cd packages/seismicity_pmtiles && mise exec -- flutter pub add 'vector_tile:^4.0.0' 'uuid:^4.6.0')`; do not hand-edit dependency declarations.
- Follow RED/GREEN TDD for every production behavior change. A later integration/regression task may begin GREEN when it only proves an already-implemented contract; in that case, do not manufacture a production diff. Every task is one independently reviewable logical commit targeting 30–100 production-plus-test handwritten changed lines in total; generated Freezed files and deterministic fixture bytes are recorded separately and committed with their source task.
- Use only named parameters for functions or constructors with two or more arguments. Do not add `dynamic`, `any`, explicit `Object`/`Object?`, null assertions, `print`, or private class methods.
- Do not retain one Freezed/Dart object per hypocenter. Per-feature transient values inside one worker callback are allowed; the returned 2M-scale representation is typed columns split into bounded chunks.
- Canonical/dictionary string paths must not use a `Map` whose key type is `String`, retain Dart `String` keys, or retain one string object per event. Encode accepted values immediately to UTF-8 and use typed byte arenas, entry offsets, row indexes, and typed open-address tables. The existing `Map<String, dynamic>` JSON boundary remains the only string-key-map exception.
- Missing `depth_km` and `magnitude` use `double.nan` plus a validity bitmap. A numeric zero is valid only when the source property explicitly contains zero; no missing value is replaced by zero.
- `SeismicityPmTilesArchiveDescriptor.schemaVersion` and `.dataZoom` are required archive-open inputs. The opened archive exposes that exact accepted descriptor; decoder/runner/factory accept no second descriptor and consume only `archive.descriptor`. Accept exactly schema version 1 and enumerate exactly `archive.descriptor.dataZoom`; never substitute 1 or 14 when metadata is absent.
- The current public `/v2/hypocenters/manifest` contract lacks `schema_version`, `data_zoom`, and `archive_revision`. That is a separate backend stacked dependency before app integration. This branch consumes a caller-complete descriptor and must not infer those fields from URL, PMTiles header, or producer constants.
- Cancellation, schema/type corruption, conflicting duplicate UUIDs, worker failure, descriptor identity mismatch, and count mismatch are typed failures. A finished transfer whose schema version, data zoom, archive revision, or unique count differs from `archive.descriptor` is rejected before publication. On every success, failure, and cancellation path, the decode operation closes the archive and retires the worker exactly once.
- No physical-device, simulator, real-network, or E2E run is required. Pure-Dart unit/integration tests and the deterministic 2,000,000-feature harness are required.
- Generated-file normalization must follow `docs/knowledge/20260708_build_runner_generated_diffs.md`; semantic manual edits to generated files are forbidden.
- Every task that runs build_runner must immediately run the tracked, file-limited `seismicity_pmtiles_exception.freezed.dart` normalizer, prove with `git diff --no-index --ignore-space-at-eol` that normalization changed only trailing whitespace, inspect semantic generated diffs, and commit every generated output with the source task that caused it. Never defer generated cleanup to the final documentation task.

## Reference Decisions

- Adopt the PMTiles official `tileIdToZxy` inverse Hilbert algorithm, ported with Dart integer arithmetic, from `protomaps/PMTiles` at `8b8ddea4dbff1b0104cf2bebf2f7ff35c91b41d5`. Keep forward/inverse round-trip tests in `pmtiles_v3`.
- Adopt `vector_tile` 4.0.0 only through its public `package:vector_tile/raw/raw_vector_tile.dart` protobuf model. Do not use its GeoJSON conversion, mutable high-level geometry decoder, or `VectorTileValue.value`: those paths allocate nested feature/GeoJSON objects, expose `Object`, and do not enforce this archive's strict single-Point/property contract.
- Adopt `bdero/dashmap` at `a6ff92edd999e922f81d26d209d8f589faee3fd0` as evidence for typed-data-only CPU worker jobs and keeping GPU/UI work outside the worker. Do not copy its per-job `Isolate.run`, web synchronous fallback, terrain streaming, tile selection, network cache, or Flutter Scene code; this issue requires one long-lived decoder isolate and has no renderer.
- Adopt `ingen084/KyoshinEewViewerIngen` at `3e9d6a01f62e754c9c6da4a413330c4cfcb4afab` only for the invariant that a complete point cache is built before replacing the visible dataset. Do not adopt its Avalonia/Skia renderer, zoom-dependent point layout, hover cache, Mercator UI layer, or earthquake presentation types as PMTiles/decode contracts.
- The backend producer at gitlink `8bdda33cd0ae0860a395d9b8465b5d226e422de5` defines layer `hypocenters`; required properties `hypocenter_id` and `origin_time_unix_ms`; optional `magnitude`, `depth_km`, `max_intensity`, `determination_flag`, `earthquake_event_id`, and `geometry_clamped`. Schema v1 rejects every other property name; internal-only properties are still typed and retained through duplicate classification.
- The producer validator accepts nullable arbitrary strings for `max_intensity` and `determination_flag`, but applies `nonEmpty` to a present `earthquake_event_id`. Preserve the first two byte-for-byte including empty and reject the third when present empty.

## Locked Data Contract

`SeismicityPmTilesChunk` is `@Freezed(equal: false)` and holds:

| Column | Type | Length / meaning |
|---|---|---|
| `hypocenterIds` | `Uint8List` | `length * 16`, canonical UUID bytes |
| `latitudes` | `Float64List` | `length` |
| `longitudes` | `Float64List` | `length` |
| `depthsKm` | `Float32List` | `length`; invalid slots are NaN |
| `depthValidity` | `Uint8List` | `(length + 7) ~/ 8` bitset |
| `magnitudes` | `Float32List` | `length`; invalid slots are NaN |
| `magnitudeValidity` | `Uint8List` | `(length + 7) ~/ 8` bitset |
| `originTimeUnixMilliseconds` | `Int64List` | `length` |
| `maxIntensityDictionaryIndexes` | `Uint32List` | `length`; read only when validity bit is set |
| `maxIntensityValidity` | `Uint8List` | `(length + 7) ~/ 8` bitset |
| `maxIntensityDictionaryUtf8` | `Uint8List` | concatenated exact UTF-8 strings |
| `maxIntensityDictionaryOffsets` | `Uint32List` | dictionary size + 1; starts at 0 and ends at UTF-8 byte length |

`SeismicityPmTilesDataset` is also `@Freezed(equal: false)` and holds the archive-accepted descriptor identity (`archiveRevision`, `schemaVersion`, `dataZoom`), exact `featureCount`, and `List<SeismicityPmTilesChunk>`. A dataset is publishable only after every chunk invariant, unique count, and descriptor identity/count gate have passed.

## Locked Internal Dedupe Contract

Boundary-copy classification retains no per-event objects or UUID/string keys. Each bounded builder owns a typed canonical sidecar parallel to its public output chunk:

| Canonical field | Internal representation |
|---|---|
| normalized point | `Int64List globalXs`, `Int64List globalYs` |
| magnitude/depth | pre-Float32 `Float64List` plus validity bitmaps; finite value bits are compared after canonicalizing `-0.0` to `0.0` |
| determination flag | UTF-8 byte arena, `Uint32List` entry offsets + row dictionary indexes, typed hash slots, validity bitmap |
| earthquake event ID | UTF-8 byte arena, `Uint32List` entry offsets + row dictionary indexes, typed hash slots, validity bitmap |
| geometry clamped | value bitmap plus separate validity bitmap |

The public UUID/origin-time/max-intensity columns and this sidecar together cover every schema-v1 property. Every accepted MVT string is encoded immediately to a transient `Uint8List`; builders retain only arena bytes and typed indexes/offsets. Duplicate comparison uses arena slices and the canonical numeric sidecar before lossy Float32 output conversion, so two finite inputs such as `5.1` and a distinct nearby double that round to the same Float32 remain a conflict. Missing matches only missing; present empty `max_intensity`/`determination_flag`, `false`, and numeric zero remain present values. Empty `earthquake_event_id` is rejected before accumulation. The three internal-only producer properties are discarded only after all tiles and the final count gate have passed.

## Locked MVT Schema v1

- Tile contains exactly one `hypocenters` layer. Its protobuf `version` and `extent` fields must be present; version must be 2 and extent must be positive.
- Every feature has type `POINT` and exactly one canonical `MoveTo(count=1)` point. MultiPoint, LineString, Polygon, unknown commands, truncated parameters, extra commands, odd tags, invalid key/value indexes, or repeated property keys are failures.
- Required: `hypocenter_id` is one canonical dashed UUID string; `origin_time_unix_ms` is an exact safe integer representable by `Int64List`.
- Optional decoded: `magnitude` and `depth_km` accept any single MVT numeric scalar only when the original double and its Float32 output conversion are both finite; `max_intensity` accepts a string.
- Optional internal-only: `determination_flag` accepts an exact string including empty, `earthquake_event_id` accepts only a non-empty exact string, and `geometry_clamped` is bool. Accepted strings are retained only as UTF-8 arenas/typed indexes through cross-tile dedupe and are not exposed in the published dataset.
- A raw MVT value must set exactly one of string/float/double/int/uint/sint/bool. Missing, multiple, or wrong scalar variants are failures.
- Point coordinates are transformed from local MVT integers to normalized global Web Mercator integers with tile X wrapping, then to finite longitude/latitude. Global Y outside `[0, extent * 2^zoom]` is rejected; it is never clamped.
- Same UUID plus identical normalized global point and all schema-v1 property values is a boundary copy and is emitted once. Same UUID with any different geometry or property is `duplicateConflict` and invalidates the whole dataset.

## File Map

| Path | Responsibility |
|---|---|
| `packages/pmtiles_v3/lib/src/archive/pmtiles_v3_tile_id.dart` | Bidirectional PMTiles TileID/Hilbert coordinate conversion. |
| `packages/seismicity_pmtiles/lib/src/archive/seismicity_pmtiles_archive.dart` | Own and expose the exact opener-accepted descriptor with archive I/O. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk.dart` | Public typed column chunk. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_dataset.dart` | Public completed dataset. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_decode_progress.dart` | Public raw/unique/tile progress. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_validity_bitmap.dart` | Packed typed-column presence bits. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk_validator.dart` | Public chunk length, offset, and validity invariants. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_schema_v1_validator.dart` | Descriptor and property-name contract. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart` | Exactly-one scalar conversion. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_point_decoder.dart` | Strict Point command and Web Mercator coordinate conversion. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoded_hypocenter.dart` | Callback-local typed row with transient UTF-8 values. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart` | Raw protobuf/layer/tag/feature streaming decode. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_uuid_index.dart` | Typed open-address UUID-to-row index. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_arena.dart` | Growable bounded UTF-8 byte arena and entry offsets. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_dictionary.dart` | Typed open-address byte-slice dictionary with no String-key map. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart` | Typed canonical sidecar for geometry, pre-round numerics, and internal-only schema properties. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart` | Bounded column/dictionary/validity construction. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart` | Cross-tile exact dedupe and chunk finalization. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decode_transfer.dart` | Typed columns to/from TTD messages. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_factory.dart` | Non-export worker handle/factory interfaces. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_protocol.dart` | Sealed isolate request/response protocol. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_isolate_launcher.dart` | Typed launcher/endpoint seam and its real Dart isolate adapter. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart` | Worker-side initialize/decode/finish request handling. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_router.dart` | Client-side request ID, acknowledgement, and progress routing. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_probe.dart` | Observable typed terminal transitions. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_coordinator.dart` | Pure first-terminal decision and cleanup actions. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_finisher.dart` | Descriptor identity/count/chunk validation before materialization. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart` | Real factory/handle composition and external endpoint lifecycle. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decode_operation.dart` | Public result/state/cancel boundary. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_run_lifecycle.dart` | Pure runner terminal-result and cleanup ownership decisions. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart` | Non-export injectable archive traversal/lifecycle runner. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart` | Public facade using the real worker factory by default. |
| `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart` | Deterministic raw MVT schema fixtures. |
| `packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation.dart` | Immutable typed raw-MVT mutation primitives. |
| `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator.dart` | Single-invariant corrupt MVT fixtures. |
| `packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory.dart` | Pausable/failable high-level worker fake. |
| `packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher.dart` | Deterministic response/error/exit/kill endpoint controls. |
| `packages/seismicity_pmtiles/test/support/controlled_seismicity_archive.dart` | Pausable/failable archive lifecycle seam. |
| `packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer.dart` | Exact test-only PMTiles v3 byte writer. |
| `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart` | Deterministic gzip PMTiles archive fixtures. |
| `packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_feature_source.dart` | Stateless deterministic feature primitives and expected bytes. |
| `packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_archive.dart` | On-demand deterministic occupied tiles and expected byte counts. |
| `packages/seismicity_pmtiles/benchmark/support/counting_decoder_worker_factory.dart` | Real-worker spawn-count delegate. |
| `packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark_runner.dart` | Correctness/timing/RSS runner with counted real worker. |
| `packages/seismicity_pmtiles/benchmark/seismicity_benchmark_arguments.dart` | Strict typed CLI argument parser. |
| `packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart` | Deterministic 2M correctness/timing harness. |

---

### Task 1: Add the PMTiles TileID inverse

**Files:**
- Modify: `packages/pmtiles_v3/lib/src/archive/pmtiles_v3_tile_id.dart`
- Modify: `packages/pmtiles_v3/test/archive/pmtiles_v3_tile_id_test.dart`
- Modify: `packages/pmtiles_v3/test/public_api_compile_test.dart`

**Interfaces:**
- Consumes: existing `PmTilesV3TileId.rangeForZoom`, `tileIdForZxy`, and public exception types.
- Produces: `({int z, int x, int y}) zxyForTileId({required int tileId})` on the already-public `PmTilesV3TileId`.

- [ ] **Step 1: Write the failing inverse tests**

```dart
expect(tileId.zxyForTileId(tileId: 0), (z: 0, x: 0, y: 0));
for (var z = 0; z <= 8; z++) {
  final side = 1 << z;
  for (var y = 0; y < side; y++) {
    for (var x = 0; x < side; x++) {
      final id = tileId.tileIdForZxy(z: z, x: x, y: y);
      expect(tileId.zxyForTileId(tileId: id), (z: z, x: x, y: y));
    }
  }
}
expect(
  () => tileId.zxyForTileId(tileId: -1),
  throwsA(isA<PmTilesV3InvalidTileIdException>()),
);
```

Also cover the first/last ID at zoom 31 and compile the call through `package:pmtiles_v3/pmtiles_v3.dart`.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/pmtiles_v3/test/archive/pmtiles_v3_tile_id_test.dart packages/pmtiles_v3/test/public_api_compile_test.dart`

Expected: compile failure because `zxyForTileId` does not exist.

- [ ] **Step 3: Implement the integer inverse**

Validate with `validateArgument`, find the unique zoom whose `rangeForZoom` contains the ID, subtract the zoom start, and run the standard inverse Hilbert loop:

```dart
var x = 0;
var y = 0;
var distance = tileId - range.start;
for (var scale = 1; scale < 1 << zoom; scale <<= 1) {
  final rx = 1 & (distance >> 1);
  final ry = 1 & (distance ^ rx);
  final rotated = rotateInverse(
    scale: scale,
    x: x,
    y: y,
    rx: rx,
    ry: ry,
  );
  x = rotated.x + scale * rx;
  y = rotated.y + scale * ry;
  distance >>= 2;
}
return (z: zoom, x: x, y: y);
```

`rotateInverse` is a separate top-level function, not a private class method. Use Dart integers only; do not introduce floating-point zoom inference.

- [ ] **Step 4: Run GREEN and package analysis**

Run: `mise exec -- dart test packages/pmtiles_v3/test/archive/pmtiles_v3_tile_id_test.dart packages/pmtiles_v3/test/public_api_compile_test.dart`

Run: `mise exec -- dart analyze packages/pmtiles_v3 --fatal-infos`

Expected: all tests pass, analysis reports no issues, and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/pmtiles_v3/lib/src/archive/pmtiles_v3_tile_id.dart \
  packages/pmtiles_v3/test/archive/pmtiles_v3_tile_id_test.dart \
  packages/pmtiles_v3/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles TileID逆変換を追加"
git push
```

### Task 2: Add decoder dependencies and typed failures

**Files:**
- Modify through pub: `packages/seismicity_pmtiles/pubspec.yaml`, root `pubspec.lock`
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Modify generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart`
- Modify: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

**Interfaces:**
- Consumes: existing source-aware `SeismicityPmTilesException` union.
- Produces: `unsupportedSchema`, `invalidVectorTile`, `invalidHypocenterFeature`, `duplicateConflict`, `featureCountMismatch`, and `decoderWorkerFailed` typed cases.

- [ ] **Step 1: Write failing public exception tests**

```dart
const unsupported = SeismicityPmTilesException.unsupportedSchema(
  expected: 1,
  actual: 2,
);
const mismatch = SeismicityPmTilesException.featureCountMismatch(
  expected: 2,
  actual: 1,
);
expect(unsupported, isA<SeismicityPmTilesUnsupportedSchemaException>());
expect(mismatch, isA<SeismicityPmTilesFeatureCountMismatchException>());
```

Add analogous type assertions for the four other cases. `duplicateConflict` carries canonical `hypocenterId`; feature failures carry `tileId`, `featureIndex`, and a stable `field`/`reason` code, not an arbitrary UI message.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected: compile failure for missing union constructors.

- [ ] **Step 3: Add packages and union cases**

Add the dependencies, then regenerate and immediately run the tracked limited normalizer:

```bash
(cd packages/seismicity_pmtiles && mise exec -- flutter pub add 'vector_tile:^4.0.0' 'uuid:^4.6.0')
(
  set -eu
  generated='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  scratch=$(mktemp -d)
  trap 'rm -r -- "$scratch"' EXIT
  (cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
  cp -- "$generated" "$scratch/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' "$generated"
  git diff --no-index --exit-code --ignore-space-at-eol "$scratch/before.dart" "$generated"
  git diff --check
  git --no-pager diff -- "$generated"
)
```

The no-index proof must exit 0. Inspect the generated exception diff against the union source in this task; stage it in this task's commit, never in the final docs task.

Use these exact public constructors:

```dart
const factory SeismicityPmTilesException.unsupportedSchema({
  required int expected,
  required int actual,
}) = SeismicityPmTilesUnsupportedSchemaException;
const factory SeismicityPmTilesException.invalidVectorTile({
  required int tileId,
  required String reason,
}) = SeismicityPmTilesInvalidVectorTileException;
const factory SeismicityPmTilesException.invalidHypocenterFeature({
  required int tileId,
  required int featureIndex,
  required String field,
  required String reason,
}) = SeismicityPmTilesInvalidHypocenterFeatureException;
const factory SeismicityPmTilesException.duplicateConflict({
  required String hypocenterId,
}) = SeismicityPmTilesDuplicateConflictException;
const factory SeismicityPmTilesException.featureCountMismatch({
  required int expected,
  required int actual,
}) = SeismicityPmTilesFeatureCountMismatchException;
const factory SeismicityPmTilesException.decoderWorkerFailed({
  required String reason,
}) = SeismicityPmTilesDecoderWorkerFailedException;
```

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected: all model tests pass and dependency/exception production-plus-test handwritten diff is 30–100 lines; generated output is counted separately.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/pubspec.yaml pubspec.lock \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart \
  packages/seismicity_pmtiles/test/model/public_contracts_test.dart
git commit -m "Feat: PMTiles decoder失敗型を追加"
git push
```

### Task 3: Define public columnar chunk and dataset contracts

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk.dart`
- Create generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk.freezed.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_dataset.dart`
- Create generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_dataset.freezed.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_decode_progress.dart`
- Create generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_decode_progress.freezed.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Create: `packages/seismicity_pmtiles/test/model/seismicity_pmtiles_dataset_test.dart`

**Interfaces:**
- Consumes: typed-list layout in “Locked Data Contract”.
- Produces: exported `SeismicityPmTilesChunk`, `SeismicityPmTilesDataset`, and `SeismicityPmTilesDecodeProgress`.

- [ ] **Step 1: Write the failing public model test**

Construct a one-row chunk with a 16-byte UUID, explicit depth 0 with a set validity bit, missing magnitude as NaN with a clear validity bit, one origin timestamp, and dictionary value `4`. Assert fields are identical typed-list instances and dataset equality is identity-disabled.

```dart
expect(chunk.depthsKm.single, 0);
expect(chunk.magnitudes.single.isNaN, isTrue);
expect(dataset.featureCount, 1);
expect(progress, const SeismicityPmTilesDecodeProgress(
  decodedTileCount: 1,
  rawFeatureCount: 2,
  uniqueFeatureCount: 1,
));
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_dataset_test.dart`

Expected: compile failure because the model files do not exist.

- [ ] **Step 3: Implement the exact Freezed contracts**

Both buffer-owning models use `@Freezed(equal: false)` and all constructors require every field; there are no default data values. Progress is a small normal Freezed value with the three non-negative counters shown above. Export only these public models through the package barrel.

Regenerate and normalize immediately:

```bash
set -eu
(
  generated='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  scratch=$(mktemp -d)
  trap 'rm -r -- "$scratch"' EXIT
  (cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
  cp -- "$generated" "$scratch/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' "$generated"
  git diff --no-index --exit-code --ignore-space-at-eol "$scratch/before.dart" "$generated"
  git diff --check
  git --no-pager diff -- packages/seismicity_pmtiles/lib/src/model
)
```

The no-index proof must exit 0. Inspect every new chunk/dataset/progress generated semantic diff against its annotation and commit those outputs with this task.

- [ ] **Step 4: Run GREEN and public compile coverage**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_dataset_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: all tests pass, imports use only the package barrel, and model/test handwritten diff is 30–100 lines; generated output is counted separately.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk* \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_dataset* \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_decode_progress* \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/model/seismicity_pmtiles_dataset_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: 震源列形式dataset契約を追加"
git push
```

### Task 4: Validate chunk layout and validity bitmaps

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_validity_bitmap.dart`
- Create: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk_validator.dart`
- Create: `packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`

**Interfaces:**
- Consumes: `SeismicityPmTilesChunk` from Task 3.
- Produces: exported `SeismicityValidityBitmap.isValid({bytes,index})` and internal builder mutation helper; `SeismicityPmTilesChunkValidator.validate({required chunk})`.

- [ ] **Step 1: Write failing bitmap and invariant tests**

Test indices 0, 7, 8, and 15. Reject every wrong column length, a set numeric-validity bit whose value is NaN or positive/negative infinity, a clear numeric-validity bit whose value is not NaN, dictionary offsets not starting at zero, descending/out-of-range offsets, and a valid dictionary index outside the dictionary.

```dart
expect(SeismicityValidityBitmap.isValid(bytes: bytes, index: 7), isTrue);
expect(
  () => const SeismicityPmTilesChunkValidator().validate(chunk: malformed),
  throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart`

Expected: compile failure for missing validator/helper.

- [ ] **Step 3: Implement exact validation**

`requiredByteLength({required int valueCount})` returns `(valueCount + 7) ~/ 8`; `setValid` and `isValid` use little bit order within each byte (`1 << (index & 7)`). Validate UUID length `length * 16`, every fixed-width column, all three bitmaps, numeric validity (`set => isFinite`, `clear => isNaN`; infinity is always corrupt), dictionary offset/index bounds, and exact terminal UTF-8 length. Negative lengths are corrupt.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart`

Expected: all focused tests pass and bitmap/validator/test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/model/seismicity_validity_bitmap.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk_validator.dart \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart
git commit -m "Feat: 震源列buffer整合性を検証"
git push
```

### Task 5: Bind the opened archive to its accepted descriptor

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/archive/seismicity_pmtiles_archive.dart`
- Modify: `packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:**
- Consumes: the descriptor already validated by `SeismicityPmTilesArchiveOpener.open`.
- Produces: `SeismicityPmTilesArchive.descriptor`, the exact accepted `SeismicityPmTilesArchiveDescriptor` instance.

- [ ] **Step 1: Write the failing descriptor-ownership test**

Open a valid fixture and assert `identical(archive.descriptor, acceptedDescriptor)`. Compile the getter through the package barrel and require every archive test double to expose its construction descriptor.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: compile failure because the archive interface does not expose the accepted descriptor.

- [ ] **Step 3: Store the accepted descriptor without copying**

Add the descriptor getter, pass the accepted object into `_SeismicityPmTilesArchiveImpl`, and derive source-aware exceptions from `descriptor.source`. Do not accept a replacement descriptor after open and do not reconstruct one from header/URL fields.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: identity/public compile tests pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/archive/seismicity_pmtiles_archive.dart \
  packages/seismicity_pmtiles/test/archive/seismicity_pmtiles_archive_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: archive descriptorの所有元を固定"
git push
```

### Task 6: Enforce the caller-complete schema descriptor

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_schema_v1_validator.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_schema_v1_validator_test.dart`

**Interfaces:**
- Consumes: `SeismicityPmTilesArchiveDescriptor`, `PmTilesV3TileId.maxZoom`.
- Produces: internal `SeismicitySchemaV1Validator.validateDescriptor({required descriptor})` and source-aware `validatePropertyName({required name, required tileId, required featureIndex})`.

- [ ] **Step 1: Write failing descriptor/property tests**

Accept an explicit schema 1/dataZoom 12 descriptor. Reject schema 0/2, negative or greater-than-`0x3fffffff` expected count, empty archive revision, reversed period, and data zoom outside 0–31. Accept exactly the eight producer properties and reject `source_kind` and arbitrary unknown names.

```dart
expect(
  () => validator.validateDescriptor(descriptor: schema2),
  throwsA(isA<SeismicityPmTilesUnsupportedSchemaException>()),
);
expect(
  () => validator.validatePropertyName(
    name: 'source_kind',
    tileId: 5,
    featureIndex: 0,
  ),
  throwsA(isA<SeismicityPmTilesInvalidHypocenterFeatureException>()),
);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_schema_v1_validator_test.dart`

Expected: compile failure for missing validator.

- [ ] **Step 3: Implement without metadata inference**

Use `supportedSchemaVersion = 1` only as an equality gate. Bound `expectedFeatureCount` to `0x3fffffff`, so the later UUID index can maintain a maximum 0.5 load factor in a power-of-two `Uint32List` whose largest representable capacity is `0x80000000`. Convert allocation failure to a typed descriptor failure. Do not expose `defaultSchemaVersion`, `defaultDataZoom`, or a descriptor-copying fallback. The accepted property set is:

```dart
const schemaV1Properties = <String>{
  'hypocenter_id',
  'origin_time_unix_ms',
  'magnitude',
  'depth_km',
  'max_intensity',
  'determination_flag',
  'earthquake_event_id',
  'geometry_clamped',
};
```

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_schema_v1_validator_test.dart`

Expected: descriptor/property production-plus-test handwritten diff is 30–100 lines and all tests pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_schema_v1_validator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_schema_v1_validator_test.dart
git commit -m "Feat: 震源schema descriptorを検証"
git push
```

### Task 7: Decode one scalar into canonical and Float32-safe values

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

**Interfaces:**
- Consumes: `VectorTile_Value` from `package:vector_tile/raw/raw_vector_tile.dart`.
- Produces: `requireString`, `requireFiniteFloat32Number`, `requireSafeInteger`, and `requireBool`, each with named `value`, `tileId`, `featureIndex`, and `field` arguments. The numeric result is `({double canonicalValue, double storageValue})`.

- [ ] **Step 1: Write failing table-driven scalar tests**

Create raw values for every protobuf scalar variant. Verify string/bool exactness, numeric acceptance for float/double/int/uint/sint, safe integer acceptance for epoch milliseconds, and typed rejection for no field, two fields, NaN, infinity, `1e100`/`-1e100` that are finite as Float64 but overflow Float32, fractional time, unsafe double integer, unsigned negative `Int64`, and wrong scalar type. Verify two distinct finite doubles that collapse to one Float32 retain distinct `canonicalValue`s while each has its rounded finite `storageValue`.

```dart
expect(
  decoder.requireFiniteFloat32Number(
    value: createVectorTileValue(doubleValue: 12.5),
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  ),
  (canonicalValue: 12.5, storageValue: 12.5),
);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

Expected: compile failure for the missing decoder.

- [ ] **Step 3: Implement cardinality before conversion**

Count `hasStringValue`, `hasFloatValue`, `hasDoubleValue`, `hasIntValue`, `hasUintValue`, `hasSintValue`, and `hasBoolValue`; require a count of exactly one before reading. For magnitude/depth, canonicalize negative zero, require the decoded Float64 value finite, write it through a one-element `Float32List`, read it back, and require that storage value finite before returning both values. `requireSafeInteger` accepts integer-family values in signed Int64 range or an integral double within `±9007199254740991`; reject float timestamps because Float32 cannot preserve arbitrary epoch-millisecond integers. Every failure, including Float32 overflow, throws `SeismicityPmTilesException.invalidHypocenterFeature` with the stable field and reason code.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

Expected: all scalar cases pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart
git commit -m "Feat: MVT scalar型を厳密に解析"
git push
```

### Task 8: Decode a strict Point and derive global coordinates

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_point_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_point_decoder_test.dart`

**Interfaces:**
- Consumes: tile `z/x/y`, positive layer extent, and raw feature geometry integers.
- Produces: `SeismicityMvtPoint(globalX, globalY, longitude, latitude)` through `decode({required geometry, required z, required x, required y, required extent, required tileId, required featureIndex})`.

- [ ] **Step 1: Write failing geometry and coordinate tests**

Test the canonical `[9, zigZag(x), zigZag(y)]` command, negative buffered local X, antimeridian wrapping, north/south Web Mercator boundaries, and matching global coordinates for two buffered copies. Reject empty geometry, MoveTo count 0/2, unknown command, truncated X/Y, trailing command/data, non-positive extent, multiplication overflow, and global Y outside the world.

```dart
final point = decoder.decode(
  geometry: [9, zigZagEncode(4092), zigZagEncode(100)],
  z: 14,
  x: 1,
  y: 3,
  extent: 4096,
  tileId: 1,
  featureIndex: 0,
);
expect(point.longitude.isFinite, isTrue);
expect(point.latitude.isFinite, isTrue);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_point_decoder_test.dart`

Expected: compile failure for missing point decoder.

- [ ] **Step 3: Implement strict command and Web Mercator math**

Accept exactly one command integer `(1 << 3) | 1` and exactly two zig-zag parameters. Compute `worldWidth = extent * (1 << z)`, normalize X with a positive modulo, retain Y without clamping, then use:

```dart
final longitude = globalX / worldWidth * 360 - 180;
final mercatorY = math.pi * (1 - 2 * globalY / worldWidth);
final latitude = math.atan(math.sinh(mercatorY)) * 180 / math.pi;
```

Reject any non-finite result. Put zig-zag and positive-modulo helpers at top level.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_point_decoder_test.dart`

Expected: all geometry/coordinate cases pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_point_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_point_decoder_test.dart
git commit -m "Feat: MVT Point座標を厳密に解析"
git push
```

### Task 9: Build deterministic schema-v1 MVT support

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder_test.dart`

**Interfaces:**
- Consumes: public `package:vector_tile/raw/raw_vector_tile.dart` constructors.
- Produces: test-only `SeismicityMvtFixtureBuilder` and typed `SeismicityFixtureScalar` variants for every raw MVT scalar.

- [ ] **Step 1: Write the failing fixture self-test**

Build one deterministic layer named `hypocenters`, version 2, extent 4096, and one Point feature. Assert raw parse round-trips deterministic key/value order, tags, geometry, and all eight schema property names. Builder inputs require every layer/feature field explicitly; no producer constant or data zoom default is hidden in support code.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder_test.dart`

Expected: compile failure because the support builder is absent.

- [ ] **Step 3: Implement only the happy fixture builder**

Use public raw protobuf constructors and top-level named-argument encoders. Support exact string, float, double, signed, unsigned, zig-zag signed, bool, and intentionally multi-set raw values. Encode Point commands deterministically. Do not import production decoder code and do not add corrupt-layer mutation helpers yet.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder_test.dart`

Expected: deterministic bytes and raw fields match. `git --no-pager diff --stat` must show 30–100 production-plus-test handwritten lines for this logical support slice; move optional scalar convenience cases to the following mutation-support task if larger.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart \
  packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder_test.dart
git commit -m "Test: 震源MVT fixture基盤を追加"
git push
```

### Task 10: Define typed raw-MVT mutation primitives

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation_test.dart`

**Interfaces:**
- Consumes: Task 9 raw fixture messages.
- Produces: test-only immutable layer/feature/value/byte mutation primitives.

- [ ] **Step 1: Write failing primitive tests**

Prove replace/remove/append layer, replace feature tags/geometry/type, replace one raw value, and truncate bytes each return a new fixture while the baseline remains byte-identical. Inputs are typed constructors, not a string selector.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation_test.dart`

Expected: compile failure for missing mutation primitives.

- [ ] **Step 3: Implement immutable mutations only**

Copy the minimum raw protobuf collection and serialize deterministically. Do not import production decoder code or embed expected exception types.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation_test.dart`

Expected: baseline isolation passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation.dart \
  packages/seismicity_pmtiles/test/support/seismicity_mvt_mutation_test.dart
git commit -m "Test: raw MVT変異primitiveを追加"
git push
```

### Task 11: Build the corrupt-MVT fixture catalog

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator_test.dart`

**Interfaces:**
- Consumes: Tasks 9–10.
- Produces: named single-invariant fixtures for layers, tags, geometry, scalar/property, and protobuf corruption.

- [ ] **Step 1: Write the failing catalog self-test**

Table-test missing/duplicate layer, missing version/extent, odd/out-of-range/repeated tags, wrong geometry, missing required property, unknown key, wrong/multi-set scalar, empty earthquake event ID, and truncation. Assert exactly one intended invariant changes.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator_test.dart`

Expected: compile failure for the missing catalog.

- [ ] **Step 3: Compose named corruption fixtures**

Build each fixture from Task 10 primitives with named arguments. Invalid UUID and Float32-overflow values are explicit scalar fixtures. Do not duplicate raw copy/serialization logic.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator_test.dart`

Expected: catalog cases are deterministic and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator.dart \
  packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_mutator_test.dart
git commit -m "Test: MVT破損fixture catalogを追加"
git push
```

### Task 12: Define the callback-local decoded row

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoded_hypocenter.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoded_hypocenter_test.dart`

**Interfaces:**
- Consumes: typed UUID/point/scalar outputs from Tasks 7–8.
- Produces: transient all-property `SeismicityDecodedHypocenter` with UTF-8 byte fields and explicit presence.

- [ ] **Step 1: Write the failing typed-row tests**

Construct complete and missing-optional rows. Assert the 16-byte UUID, source tile/feature identity, canonical/storage numerics, point, exact UTF-8 values, and optional presence. Prove present empty max-intensity/determination bytes are representable and present empty event bytes are rejected.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoded_hypocenter_test.dart`

Expected: compile failure for the missing typed row.

- [ ] **Step 3: Implement only the transient value boundary**

Use required named fields for `tileId`, `featureIndex`, UUID bytes, point, origin time, canonical/storage numerics, `maxIntensityUtf8`, `determinationFlagUtf8`, `earthquakeEventIdUtf8`, and `geometryClamped`. Validate fixed UUID length and non-empty present event bytes. Retain no Dart String/UUID text and add no parsing.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoded_hypocenter_test.dart`

Expected: typed-row invariants pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoded_hypocenter.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoded_hypocenter_test.dart
git commit -m "Feat: 震源decode行を型定義"
git push
```

### Task 13: Decode one valid schema-v1 MVT tile

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_happy_test.dart`

**Interfaces:**
- Consumes: `PmTilesV3TileId.zxyForTileId`, Tasks 6–12, raw protobuf.
- Produces: synchronous `decode({required tileId, required dataZoom, required tileBytes, required onHypocenter})` returning raw feature count.

- [ ] **Step 1: Write the failing all-property happy test**

Build one feature with canonical UUID, time, magnitude/depth, max intensity, determination flag, non-empty earthquake event ID, and geometry clamped. Assert callback row order, UUID bytes, global point, Float32 storage, canonical Float64, and exact UTF-8 bytes. Add a second feature proving explicit zero/false and empty max-intensity/determination flag differ from absence; leave earthquake event ID absent because present empty is invalid.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_happy_test.dart`

Expected: compile failure for the missing tile decoder.

- [ ] **Step 3: Implement only the happy streaming decoder**

Parse with `raw.VectorTile.fromBuffer`, use Tasks 6–8, parse UUID with strict RFC9562 validation plus canonical dashed-string equality, encode strings immediately, construct the Task 12 callback row, and never retain a feature list. Implement only valid single-layer/single-Point/property flow here; corruption branches belong to the following corruption task.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_happy_test.dart`

Expected: two rows decode in order and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_happy_test.dart
git commit -m "Feat: 震源MVT tileを列解析"
git push
```

### Task 14: Reject corrupt schema-v1 MVT tiles

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_corruption_test.dart`

**Interfaces:**
- Consumes: Task 11 single-invariant corruptions and Task 13 callback boundary.
- Produces: source-aware tile/feature failures with no callback after first corruption.

- [ ] **Step 1: Write failing table-driven corruption tests**

Reject invalid protobuf, zero/duplicate/unexpected layers, absent/wrong version or extent, non-Point/MultiPoint, odd/out-of-range/repeated tags, absent required fields, non-canonical UUID, empty earthquake event ID, every wrong scalar type, unknown property, Float32-overflowing `1e100`, and tile ID zoom different from `dataZoom`. Assert exact exception variant, tile ID, feature index/field/reason, and callback count zero after failure. Keep empty max-intensity/determination flag valid in the happy suite.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_corruption_test.dart`

Expected: the Task 13 happy-only decoder accepts at least the first malformed case.

- [ ] **Step 3: Add strict guards without fallback**

Require exactly one `hypocenters` layer, explicit version 2/positive extent, exact tags and property set, and Task 7 typed scalars. Do not use high-level `VectorTile.fromBytes`, `decodeGeometry`, `toGeoJson`, producer zoom 14, or a partial callback after an error.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_happy_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_corruption_test.dart`

Expected: happy and corrupt suites pass; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_corruption_test.dart
git commit -m "Fix: 破損震源MVTを拒否"
git push
```

### Task 15: Build a typed UUID index without per-event keys

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_uuid_index.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart`

**Interfaces:**
- Consumes: 16-byte UUID candidates and a named-argument exact-key callback into column storage.
- Produces: `SeismicityUuidIndex(expectedUniqueCount:)`, `int? find({required id, required equals})`, and `insert({required id, required rowIndex, required equals})`.

- [ ] **Step 1: Write failing collision/index tests**

Test empty lookup, insert/find for first and last expected rows, exact duplicate, two intentionally equal 32-bit hashes resolved by byte comparison, zero expected count, full expected capacity, wrong UUID length, duplicate insert, and insertion beyond expected count.

```dart
final found = index.find(
  id: candidate,
  equals: ({required rowIndex, required candidate}) =>
      bytesEqual(left: storedIds[rowIndex], right: candidate),
);
expect(found, expectedRowIndex);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart`

Expected: compile failure for missing index.

- [ ] **Step 3: Implement fixed-capacity open addressing**

Allocate a `Uint32List` whose power-of-two capacity is at least twice `expectedUniqueCount` (one slot for zero). Store `rowIndex + 1`, use a deterministic 32-bit FNV-1a hash for the probe start, and call the exact UUID comparator before declaring a hit. The index does not retain UUID strings, `Uint8List` key objects, or a `Map` entry per event. Require the Task 6 bound `expectedUniqueCount <= 0x3fffffff`, use checked next-power-of-two arithmetic, convert allocation failure to a typed descriptor failure, and never silently grow past the descriptor boundary.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart`

Expected: all tests pass, including forced hash collision, and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_uuid_index.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart
git commit -m "Feat: 震源UUIDをtyped index化"
git push
```

### Task 16: Build a bounded UTF-8 byte arena

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_arena.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_utf8_arena_test.dart`

**Interfaces:**
- Consumes: transient `Uint8List` values and injected byte/entry limits.
- Produces: append-only arena, `Uint32List` entry offsets, byte-slice equality, and exact-size build output.

- [ ] **Step 1: Write failing arena tests**

Append empty, ASCII, repeated bytes as separate entries, and multibyte UTF-8. Assert monotonic offsets, exact slices/equality, growth without aliasing, and typed rejection before injected byte/entry overflow.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_utf8_arena_test.dart`

Expected: compile failure for missing arena.

- [ ] **Step 3: Implement typed arena storage**

Grow a `Uint8List` geometrically with checked limits and preallocate/grow `Uint32List` offsets. Copy candidate bytes immediately; retain no `String`, list-of-strings, or string-key map. Expose equality by entry index plus candidate bytes.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_utf8_arena_test.dart`

Expected: byte/offset invariants pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_arena.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_utf8_arena_test.dart
git commit -m "Feat: UTF-8 byte arenaを追加"
git push
```

### Task 17: Intern UTF-8 strings with a typed hash index

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_dictionary.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_utf8_dictionary_test.dart`

**Interfaces:**
- Consumes: Task 16 arena and transient UTF-8 candidate bytes.
- Produces: `indexFor({required valueUtf8})`, `equalsAt({required index, required candidateUtf8})`, and arena bytes/entry offsets.

- [ ] **Step 1: Write failing dictionary/index tests**

Verify repeated exact bytes share one entry, empty/ASCII/multibyte bytes round-trip, forced FNV collisions compare arena slices, and full capacity/uint32 bounds fail typed. Assert retained fields are typed lists/arena only.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_utf8_dictionary_test.dart`

Expected: compile failure for missing dictionary.

- [ ] **Step 3: Implement typed open addressing**

Use a power-of-two `Uint32List` slot table storing entry index + 1, FNV-1a over candidate bytes, and Task 16 slice equality on collision. Append only a new value. Never create or retain `Map<String, int>`, a Dart String key, or one key object per row.

- [ ] **Step 4: Run GREEN and audit retained types**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_utf8_dictionary_test.dart`

Expected: lossless/collision cases pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_utf8_dictionary.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_utf8_dictionary_test.dart
git commit -m "Feat: UTF-8 typed dictionaryを追加"
git push
```

### Task 18: Store canonical all-property sidecars

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_storage_test.dart`

**Interfaces:**
- Consumes: all-property decoded rows, Task 4 bitmaps, Task 17 dictionaries.
- Produces: bounded canonical builder/add/build and immutable internal typed sidecar layout.

- [ ] **Step 1: Write failing canonical storage tests**

Add complete/missing rows. Assert typed global X/Y, negative-zero-normalized Float64 canonical numerics/validity, determination/event row dictionary indexes/validity, geometry value/validity bitmaps, exact arena bytes/entry offsets, and trimming. Present empty determination is retained; earthquake event IDs are non-empty because Task 13 rejected empty.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_storage_test.dart`

Expected: compile failure for the missing sidecar.

- [ ] **Step 3: Implement bounded typed canonical storage**

Preallocate `Int64List` coordinates, Float64 canonical numerics/validity, two Task 17 dictionaries with `Uint32List` row indexes/validity, and bool value/validity bitmaps. Retain no record, String, string-key map, or per-event key object. `build` trims typed arrays/arenas but stays worker-internal.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_storage_test.dart`

Expected: every canonical column has exact typed layout and production-plus-test handwritten diff is 30–100 lines. Matching is a separate following task.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_storage_test.dart
git commit -m "Feat: canonical property列を保持"
git push
```

### Task 19: Compare canonical sidecars without String keys

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_match_test.dart`

**Interfaces:**
- Consumes: Task 18 sidecar and transient UTF-8 candidate bytes.
- Produces: `matches({required localIndex, required record})` covering geometry and internal schema properties.

- [ ] **Step 1: Write failing mismatch matrix**

Vary global X/Y, pre-round magnitude/depth/presence, determination/event UTF-8 bytes/presence, and geometry-clamped presence/value. Include same-Float32/different-canonical doubles, negative-zero equality, absent versus zero/false/empty determination, and exact multibyte equality. Do not construct an empty event ID record.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_match_test.dart`

Expected: compile failure for missing `matches`.

- [ ] **Step 3: Implement byte-slice canonical comparison**

Compare normalized numeric bits/validity and Task 17 arena bytes selected by typed row indexes. Never decode retained bytes back to String and never allocate a string-key map during lookup.

- [ ] **Step 4: Run GREEN and allocation-contract audit**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_match_test.dart`

Expected: every single-field mismatch conflicts and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_canonical_property_chunk_match_test.dart
git commit -m "Feat: canonical propertyをbyte比較"
git push
```

### Task 20: Build bounded public typed column chunks

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart`

**Interfaces:**
- Consumes: decoded row, Task 4 validity helpers, Task 17 UTF-8 dictionary, Tasks 18–19 canonical sidecar.
- Produces: `add({required record})`, `matches({required localIndex, required record})`, `uuidEquals({required localIndex, required candidate})`, `isFull`, `length`, and `build()` returning a validated `SeismicityPmTilesChunk`.

- [ ] **Step 1: Write failing add/match/build tests**

Use capacity 2. Add one event with explicit magnitude/depth 0, intensity `4`, and all internal-only fields, then one event missing all optionals. Assert 16-byte IDs, Float64 coordinates, Int64 time, finite Float32 values, bitmaps, NaN missing slots, dictionary reuse, delegation to canonical matching, full-state rejection, and exact-size final arrays.

```dart
expect(chunk.depthsKm.first, 0);
expect(chunk.depthsKm.last.isNaN, isTrue);
expect(
  SeismicityValidityBitmap.isValid(bytes: chunk.depthValidity, index: 0),
  isTrue,
);
expect(
  SeismicityValidityBitmap.isValid(bytes: chunk.depthValidity, index: 1),
  isFalse,
);
```

Use `isNaN` matchers rather than direct equality for the second value.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart`

Expected: compile failure for missing chunk builder.

- [ ] **Step 3: Implement preallocated typed storage**

Require a positive capacity. Preallocate all public fixed columns and bitmaps once. On every add, copy 16 UUID bytes, write required columns, write the Task 7 verified finite Float32 storage value or NaN with a clear bit, dictionary-encode transient max-intensity UTF-8 through Task 17, and append the same row to Task 18. `matches` compares UUID/origin/max-intensity arena bytes plus Task 19, covering every schema-v1 property before Float32 roundoff without retaining String keys.

`build` returns exact-length typed lists and calls `SeismicityPmTilesChunkValidator`; it must not expose unused capacity.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart`

Expected: all builder/invariant tests pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart
git commit -m "Feat: 震源typed chunkを構築"
git push
```

### Task 21: Accumulate unique rows across chunk boundaries

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

**Interfaces:**
- Consumes: Tasks 15, 19, and 20.
- Produces: `SeismicityDatasetAccumulator(expectedUniqueCount:, chunkCapacity:)`, `bool add({required record})`, raw/unique counters, and `List<SeismicityPmTilesChunk> buildChunks()`.

- [ ] **Step 1: Write failing cross-chunk dedupe tests**

Use capacity 2 and four raw rows: A, B, identical A, C. Assert raw count 4, unique count 3, two output chunks of lengths 2/1, stable first-seen order, and exact UUID bytes. Change each of the eight schema properties or geometry of the second A in a table and assert `SeismicityPmTilesDuplicateConflictException`; include the same-Float32/different-canonical-double case. Reject a fourth unique row when expected count is 3 before writing outside the index.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

Expected: compile failure for missing accumulator.

- [ ] **Step 3: Implement exact duplicate classification**

Use the UUID index to find a global row. Resolve global row to `chunkIndex = rowIndex ~/ chunkCapacity` and local row to `rowIndex % chunkCapacity`. If UUID and `matches` are exact, increment raw count and return false. If payload differs, throw `duplicateConflict`. For a new UUID, create a new bounded chunk only when the current chunk is full, add it, insert its global row, increment both counters, and return true.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

Expected: exact copies dedupe, every conflict fails, and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart
git commit -m "Feat: 境界震源をUUIDで重複排除"
git push
```

### Task 22: Lock boundary copies and all-property conflicts

**Files:**
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`
- Modify only if RED exposes a defect: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`
- Modify only if RED exposes a defect: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart`

**Interfaces:**
- Consumes: normalized global points and canonical schema-v1 property sidecars.
- Produces: adjacent/wrapped boundary and final unique-count regression evidence.

- [ ] **Step 1: Write adjacent-boundary contract tests**

Place one UUID in adjacent z2 tiles as local `(4092, 100)` and `(-4, 100)` so both resolve to one global point. Identical all-property rows yield raw count 2/unique count 1. Vary each geometry/property independently, including determination/event/geometry-clamped presence, explicit numeric zero, explicit false, present empty max-intensity/determination flag, and doubles that collapse to one Float32; every variant must be `duplicateConflict`. Every present earthquake event ID in this matrix remains non-empty. Add an antimeridian copy separated by one world width.

- [ ] **Step 2: Run the focused test**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`

Expected: a missing canonical comparison fails. If all cases are already GREEN, keep the task test-only and do not manufacture production changes.

- [ ] **Step 3: Fix only a demonstrated canonical gap**

Compare normalized integer point and canonical typed sidecar values, not longitude/latitude or Float32 output. Missing matches only missing. Never weaken conflict to first/last-wins.

- [ ] **Step 4: Add descriptor-count cases and run GREEN**

For one unique/two raw copies, expected 2 fails actual 1. For two unique rows, expected 1 fails actual 2. Assert `featureCountMismatch` is distinct from conflict.

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`

Expected: all boundary, wrap, canonical-property, and count cases pass; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart
git add -u packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_canonical_property_chunk.dart
git commit -m "Test: 震源境界重複の全propertyを固定"
git push
```

The `git add -u` line stages only already-modified named files and is a no-op when the regression is GREEN.

### Task 23: Transfer chunks without copying object graphs

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decode_transfer.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decode_transfer_test.dart`

**Interfaces:**
- Consumes: validated chunk/dataset models.
- Produces: isolate-sendable `SeismicityChunkTransfer.fromChunk`, one-shot `materialize`, and `SeismicityDatasetTransfer` metadata/chunk collection.

- [ ] **Step 1: Write a failing transfer round-trip test**

Create a two-row chunk containing present/missing numeric values and a multibyte max intensity string. Wrap each typed column in TTD, cross an actual `Isolate.run`, materialize once, and assert exact column types, bytes, validity, dictionary, and dataset metadata. Assert a second materialization is rejected instead of returning corrupted data.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decode_transfer_test.dart`

Expected: compile failure for missing transfer types.

- [ ] **Step 3: Implement one TTD per typed column**

Create a `TransferableTypedData` from the exact byte range of each typed list, not its possibly larger backing buffer. Materialize each at byte offset zero into the locked typed-list class (`Float64List.view`, `Float32List.view`, `Int64List.view`, `Uint32List.view`, or `Uint8List.view`). Validate byte divisibility and call `SeismicityPmTilesChunkValidator` before returning a chunk. Dataset transfer carries `archiveRevision`, `schemaVersion`, `dataZoom`, `featureCount`, and the chunk transfers; it carries no per-event Dart models.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decode_transfer_test.dart`

Expected: the isolate round-trip preserves every bit and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decode_transfer.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decode_transfer_test.dart
git commit -m "Feat: 震源列bufferをTTD転送"
git push
```

### Task 24: Define non-export worker interfaces

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_factory.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_interface_test.dart`

**Interfaces:**
- Consumes: Task 23 transfer and public progress/result models.
- Produces: non-barrel factory `spawn({required acceptedDescriptor, required chunkCapacity})` and handle interfaces with decode, finish, cancel, close, and retired.

- [ ] **Step 1: Write the failing interface contract test**

Implement a minimal typed test double and prove the exact accepted descriptor object/chunk capacity at spawn, tile TTD/progress, finish transfer, idempotent cancel/close, and one `retired` future. Public barrel compile coverage must not expose either interface.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_interface_test.dart`

Expected: compile failure for missing interfaces.

- [ ] **Step 3: Add interfaces only**

Keep interfaces in `lib/src`; require `SeismicityPmTilesArchiveDescriptor acceptedDescriptor` at spawn and use named typed protocol-independent values. Do not accept a descriptor on later handle calls and do not implement fake or isolate behavior.

- [ ] **Step 4: Run GREEN and barrel audit**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_interface_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: interface contract passes, barrel remains narrow, and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_factory.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_interface_test.dart
git commit -m "Feat: decoder worker interfaceを追加"
git push
```

### Task 25: Build a controlled worker factory fake

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory.dart`
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory_test.dart`

**Interfaces:**
- Consumes: Task 24 interfaces.
- Produces: test-only pausable/failable factory and handle counters.

- [ ] **Step 1: Write the failing fake self-test**

Pause/fail spawn, decode, finish, cancel, close, and retirement independently. Assert the factory captures the identical accepted descriptor, spawn/finish/cancel/close counts, ordered tile calls, sticky configured failure, and concurrent idempotent methods.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory_test.dart`

Expected: compile failure for missing fake.

- [ ] **Step 3: Implement typed completer controls**

The fake owns typed completers/counters only; it does not emulate isolate ports. Retain tile bytes only when the test explicitly requests capture.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory_test.dart`

Expected: all schedules are deterministic and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory.dart \
  packages/seismicity_pmtiles/test/support/controlled_seismicity_decoder_worker_factory_test.dart
git commit -m "Test: worker factory fakeを追加"
git push
```

### Task 26: Define the sealed worker protocol

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_protocol.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_protocol_test.dart`

**Interfaces:**
- Consumes: Tasks 13–23.
- Produces: typed initialize/decode/finish/cancel requests and ready/progress/finished/failure responses.

- [ ] **Step 1: Write failing protocol sendability tests**

Round-trip every request/response through an actual isolate, including TTD, descriptor scalars, progress, dataset transfer, and typed failure. Assert request IDs and terminal variants remain exact.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_protocol_test.dart`

Expected: compile failure for missing sealed messages.

- [ ] **Step 3: Implement immutable typed messages**

Messages contain only sendable typed values, SendPort, TTD, and typed exceptions. No `dynamic`, `Object`, String-key map, callback, or per-event object collection.

- [ ] **Step 4: Run GREEN and exhaustiveness check**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_protocol_test.dart`

Expected: all messages cross an isolate and exhaustive switches compile; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_protocol.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_protocol_test.dart
git commit -m "Feat: decoder worker protocolを追加"
git push
```

### Task 27: Define isolate launcher and terminal probe seams

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_isolate_launcher.dart`
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_probe.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_seam_test.dart`

**Interfaces:**
- Consumes: Task 26 protocol.
- Produces: non-export launcher/endpoint and terminal-probe interfaces; no fake/default yet.

- [ ] **Step 1: Write failing interface tests**

Implement minimal doubles proving typed request/response/error/exit streams, send, closeReceivePort, kill, exited, and probe transition counters. No method accepts an untyped payload.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_seam_test.dart`

Expected: compile failure for missing seams.

- [ ] **Step 3: Add non-export interfaces only**

Model exact endpoint ownership and a typed terminal transition enum/record. Omit both from the package barrel and avoid private class methods.

- [ ] **Step 4: Run GREEN and boundary audit**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_seam_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: seams are typed/non-exported and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_isolate_launcher.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_probe.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_seam_test.dart
git commit -m "Feat: worker isolate seamを追加"
git push
```

### Task 28: Build a controlled isolate endpoint

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher.dart`
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher_test.dart`

**Interfaces:**
- Consumes: Tasks 26–27.
- Produces: test-only endpoint that injects response, invalid transfer, crash, port close, exit, and records kill/close/probe.

- [ ] **Step 1: Write the failing endpoint self-test**

Drive each typed response, error, unexpected response-port close, graceful exit, and kill. Assert exact event order, close/kill counts, exited completion, and probe transitions.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher_test.dart`

Expected: compile failure for missing controlled endpoint.

- [ ] **Step 3: Implement deterministic endpoint controls**

Use typed stream controllers/completers only. Invalid transfer means structurally sendable typed lists with a validator violation, not an untyped message.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher_test.dart`

Expected: every terminal signal is independently controllable and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher.dart \
  packages/seismicity_pmtiles/test/support/controlled_seismicity_isolate_launcher_test.dart
git commit -m "Test: worker isolate endpointを制御"
git push
```

### Task 29: Implement the real Dart isolate launcher

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_isolate_launcher.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_launcher_test.dart`

**Interfaces:**
- Consumes: Task 27 launcher/endpoint interface and Task 26 protocol envelopes.
- Produces: `DartSeismicityDecoderIsolateLauncher` that owns typed response/error/exit streams and endpoint operations.

- [ ] **Step 1: Write the failing launcher adapter test**

Spawn a minimal top-level typed echo entry, send one protocol probe, observe one response and one exit, then close/kill twice. Assert a single isolate, typed stream order, idempotent receive-port close/kill, and completed `exited`.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_launcher_test.dart`

Expected: compile failure for the missing real launcher adapter.

- [ ] **Step 3: Implement only the isolate/port adapter**

Wrap `Isolate.spawn`, response/error/exit ports, send, close, kill, and exited completion behind Task 27. Translate the Dart isolate boundary once into sealed typed events; add no decoder, accumulator, request routing, or terminal policy.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_launcher_test.dart`

Expected: adapter ownership passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_isolate_launcher.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_isolate_launcher_test.dart
git commit -m "Feat: decoder isolate launcherを実装"
git push
```

### Task 30: Implement the worker isolate entry

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_entry_test.dart`

**Interfaces:**
- Consumes: Tasks 13, 21, 26, and 29.
- Produces: top-level `seismicityDecoderWorkerEntry` initialize/decode acknowledgement path with one resident accumulator.

- [ ] **Step 1: Write the failing direct-entry test**

Launch the real entry through Task 29, initialize once with an accepted descriptor, decode two valid tile transfers, and assert ready plus ordered request IDs/progress/acknowledgements from one isolate. Reject decode before initialize and a second initialize. Leave finish/cancel terminal behavior to the later terminal tasks.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_entry_test.dart`

Expected: compile failure for the missing worker entry.

- [ ] **Step 3: Implement initialize/decode entry routing only**

Create exactly one Task 21 accumulator and Task 13 decoder after initialize, exhaustively switch the non-terminal requests, materialize each input TTD once, and return typed progress/acknowledgement. Do not create the client handle or finish/close policy here.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_entry_test.dart`

Expected: two tiles share one resident accumulator and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_entry_test.dart
git commit -m "Feat: decoder worker entryを実装"
git push
```

### Task 31: Route non-terminal worker responses

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_router.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_router_test.dart`

**Interfaces:**
- Consumes: Task 26 ready/progress/acknowledgement responses.
- Produces: `SeismicityDecoderWorkerRouter` request-ID allocation, pending decode completion, and ordered progress forwarding.

- [ ] **Step 1: Write the failing pure routing table**

Register two decode requests, deliver ready/progress/acknowledgements in valid order, and assert only the matching pending future completes. Reject unknown/duplicate IDs, acknowledgement before ready, progress regression, and registration after terminal; no isolate is spawned.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_router_test.dart`

Expected: compile failure for the missing router.

- [ ] **Step 3: Implement only typed request routing**

Use integer IDs, typed completers, and exhaustive protocol switches. Return actions/send envelopes to the caller; do not own ports, materialize finish data, or decide close/kill.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_router_test.dart`

Expected: routing table passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_router.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_router_test.dart
git commit -m "Feat: worker応答routingを分離"
git push
```

### Task 32: Make worker terminal decisions observable

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_coordinator.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_worker_terminal_coordinator_test.dart`

**Interfaces:**
- Consumes: typed protocol/error/exit/cancel/close signals.
- Produces: pure first-terminal decision with complete-pending, close-port, kill-isolate, and preserve-failure actions.

- [ ] **Step 1: Write the failing transition table**

Cover typed success/failure, crash, unexpected port close, graceful exit before/after terminal, cancel, close, and repeated terminal signals. Assert exact chosen result, probe transition, pending completion, port-close action, kill decision, and one retired decision. Dataset-transfer materialization is deliberately outside this coordinator.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_worker_terminal_coordinator_test.dart`

Expected: compile failure for missing coordinator.

- [ ] **Step 3: Implement a pure exhaustive coordinator**

Accept only a typed terminal result supplied by the caller. First authoritative result is sticky; later cleanup cannot replace it. Return typed actions instead of touching ports/isolate directly, and emit each action to Task 27 probe.

- [ ] **Step 4: Run GREEN and transition audit**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_worker_terminal_coordinator_test.dart`

Expected: crash/port-close/cancel/kill decisions are deterministic and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_worker_terminal_coordinator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_worker_terminal_coordinator_test.dart
git commit -m "Feat: worker terminal遷移を分離"
git push
```

### Task 33: Finish accumulation inside the worker

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finish_test.dart`

**Interfaces:**
- Consumes: Task 30 resident accumulator, Task 23 transfer, and the initialize descriptor.
- Produces: one worker-side finish response only after unique-count/chunk-sum validation and TTD construction.

- [ ] **Step 1: Write the failing direct finish tests**

Through the real entry, finish zero and nonzero valid accumulations and assert exact descriptor metadata/chunk transfer. Reject expected-count mismatch, finish twice, decode after finish, and any unchecked chunk sum before sending a finished response.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finish_test.dart`

Expected: Task 30 entry has no finish implementation.

- [ ] **Step 3: Implement worker-side finish only**

Validate the accumulator unique count against its initialize descriptor, build/validate chunks, verify their checked length sum, construct Task 23 transfer metadata from that same descriptor, and emit finish once. Do not materialize on main isolate or close external ports here.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finish_test.dart`

Expected: worker finish gates pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_entry.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finish_test.dart
git commit -m "Feat: worker finishの件数gateを実装"
git push
```

### Task 34: Validate and materialize the finished dataset

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_finisher.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finisher_test.dart`

**Interfaces:**
- Consumes: Task 23 dataset transfer and the archive-accepted descriptor.
- Produces: `materialize({required transfer, required acceptedDescriptor})` returning a validated dataset or typed worker failure.

- [ ] **Step 1: Write the failing finish-validation matrix**

Materialize one valid transfer. Independently mismatch schema version, data zoom, archive revision, feature count, chunk length sum, and a chunk offset/validity invariant. Assert every mismatch is typed, no dataset is returned, and later terminal cleanup cannot relabel it as another archive.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finisher_test.dart`

Expected: compile failure for the missing client finisher.

- [ ] **Step 3: Implement fail-closed identity and chunk validation**

Compare transfer schema/data zoom/archive revision exactly with the single accepted descriptor, require both transfer count and checked chunk sum to equal `acceptedDescriptor.expectedFeatureCount`, materialize once, and validate every chunk. Return no partially materialized/public dataset on any mismatch.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finisher_test.dart`

Expected: identity/count/corruption matrix passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_finisher.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_finisher_test.dart
git commit -m "Fix: worker結果のdescriptorを照合"
git push
```

### Task 35: Compose and retire the external worker handle

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_lifecycle_test.dart`

**Interfaces:**
- Consumes: Tasks 28–34 and Task 24 factory/handle interfaces.
- Produces: `IsolateSeismicityDecoderWorkerFactory` and exact pending/port/isolate/retired lifecycle.

- [ ] **Step 1: Write the failing composition/lifecycle tests**

Use Task 28 to drive ready/decode/valid finish, invalid finish, crash, response-port close, cancel, and late exit through the composed handle. Assert the router/finisher/coordinator outputs are applied, pending futures settle, closeReceivePort/kill each occur only when directed, and `retired` completes once. Add one real-launcher smoke path proving a single isolate is used.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_lifecycle_test.dart`

Expected: compile failure for the missing real factory/handle composition.

- [ ] **Step 3: Compose existing components and own cleanup**

Use Task 29 to spawn the Task 30 entry, route non-terminal responses through Task 31, validate finish through Task 34, and apply Task 32 actions. Memoize cancel/close, close the response port, await exit or kill exactly as directed, preserve the first result, and complete `retired` once. Default probe is no-op.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_lifecycle_test.dart`

Expected: controlled and real smoke paths pass and production-plus-test handwritten diff is 30–100 lines because routing, finish, and terminal decisions remain in Tasks 31–34.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_lifecycle_test.dart
git commit -m "Feat: worker handleを構成して破棄"
git push
```

### Task 36: Build a controlled archive test seam

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_archive.dart`
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_archive_test.dart`

**Interfaces:**
- Consumes: Task 5 `SeismicityPmTilesArchive.descriptor` contract and deterministic MVT bytes.
- Produces: test-only archive with one required accepted descriptor that controls enumeration/read completion and records zoom/read/close calls.

- [ ] **Step 1: Write the failing support self-test**

Construct with one descriptor plus occupied IDs/tile bytes; assert the identical descriptor is exposed. Pause before enumeration or one read, release explicitly or by close, and assert requested zoom/IDs, exact bytes, pending future behavior, configurable typed failures, and concurrent close calls sharing one close future/count.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_archive_test.dart`

Expected: compile failure for the missing controlled archive.

- [ ] **Step 3: Implement deterministic controls only**

Implement the public archive interface with a final required descriptor and typed queues/completers. Closing releases blocked enumeration/read with the configured failure and increments the count once. Do not permit descriptor replacement, duplicate PMTiles parsing, or random-access I/O.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/controlled_seismicity_archive_test.dart`

Expected: every pause/release/close transition is deterministic and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/controlled_seismicity_archive.dart \
  packages/seismicity_pmtiles/test/support/controlled_seismicity_archive_test.dart
git commit -m "Test: archive制御fixtureを追加"
git push
```

### Task 37: Define public decode operation and progress states

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decode_operation.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state.dart`
- Modify generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state.freezed.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decode_operation_test.dart`

**Interfaces:**
- Consumes: public dataset/progress/result models.
- Produces: exported `SeismicityPmTilesDecodeOperation` exposing result, states, and idempotent cancel; `decoding(progress:)` load state.

- [ ] **Step 1: Write a failing operation contract test**

Construct the non-export operation controller with typed futures/stream, expose only its public view, and assert ordered progress, one terminal result, idempotent cancel delegation, and closed state stream. Add barrel-only compile coverage.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decode_operation_test.dart`

Expected: compile failure for missing operation/decoding state.

- [ ] **Step 3: Implement the operation/state boundary and regenerate**

The public operation has exactly:

```dart
Future<SeismicityPmTilesResult<SeismicityPmTilesDataset>> get result;
Stream<SeismicityPmTilesLoadState> get states;
Future<void> cancel();
```

Add `decoding({required SeismicityPmTilesDecodeProgress progress})` to the Freezed union. Regenerate and immediately normalize/prove:

```bash
(
  set -eu
  generated='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  scratch=$(mktemp -d)
  trap 'rm -r -- "$scratch"' EXIT
  (cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
  cp -- "$generated" "$scratch/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' "$generated"
  git diff --no-index --exit-code --ignore-space-at-eol "$scratch/before.dart" "$generated"
  git diff --check
  git --no-pager diff -- packages/seismicity_pmtiles/lib/src/model
)
```

The proof must exit 0. Inspect load-state generated semantics against its source and stage all generated output in this originating task.

- [ ] **Step 4: Run GREEN and public compile test**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decode_operation_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: operation/state public contract passes; generated normalization proof exits 0; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decode_operation.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state* \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decode_operation_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles decode operationを公開"
git push
```

### Task 38: Decide runner terminal results and cleanup ownership

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_run_lifecycle.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_run_lifecycle_test.dart`

**Interfaces:**
- Consumes: typed success/failure/cancel signals plus archive/worker cleanup completions.
- Produces: pure `SeismicityDecoderRunLifecycle` first-result and exactly-once cleanup actions.

- [ ] **Step 1: Write the failing runner lifecycle table**

Cover success, source failure, worker failure, cancel before/after terminal, cleanup success/failure, and repeated cleanup requests. Assert first-result precedence, whether cleanup may replace an otherwise successful result, close/archive/worker action counts, and one state-stream close decision.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_run_lifecycle_test.dart`

Expected: compile failure for the missing pure lifecycle component.

- [ ] **Step 3: Implement pure lifecycle decisions only**

Store the first authoritative typed result, memoize cleanup action issuance, and return typed actions for archive close, worker cancel/close/retired wait, and state completion. Touch no archive, port, isolate, stream controller, or timer directly.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_run_lifecycle_test.dart`

Expected: transition table passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_run_lifecycle.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_run_lifecycle_test.dart
git commit -m "Feat: decoder run lifecycleを分離"
git push
```

### Task 39: Traverse an archive through the injected worker

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_happy_test.dart`

**Interfaces:**
- Consumes: controlled archive Task 36, controlled worker Task 25, operation Task 37, and lifecycle Task 38.
- Produces: non-export runner whose `start({required archive, required chunkCapacity})` accepts an injected required factory at construction.

- [ ] **Step 1: Write a failing injected happy-path test**

Configure an archive whose accepted descriptor uses data zoom 2 and two occupied IDs, plus two controlled worker acknowledgements. Assert synchronous operation return, deferred validation of `archive.descriptor` before spawn, exactly one spawn carrying that identical descriptor, enumeration at its zoom, sequential read/ack order, progress, one finish, exact dataset, archive close once, handle close once, and retirement awaited.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_happy_test.dart`

Expected: compile failure for the missing internal runner.

- [ ] **Step 3: Implement injected happy traversal only**

The internal runner accepts only archive/chunk capacity at `start`; its constructor requires a factory. Return the operation before spawn, schedule work next microtask, validate Task 6 against `archive.descriptor`, pass that identical object to spawn, enumerate only its data zoom, send each decompressed tile as TTD and await acknowledgement, finish once, and apply Task 38 cleanup. There is no second descriptor parameter.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_happy_test.dart`

Expected: fake counters prove one accepted descriptor/spawn/finish/close/retirement and production-plus-test handwritten diff is 30–100 lines. Failure/cancel branches remain separate later tasks.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_happy_test.dart
git commit -m "Feat: archive traversalをworkerへ接続"
git push
```

### Task 40: Expose the public decoder facade with the real default

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_facade_test.dart`

**Interfaces:**
- Consumes: Task 39 runner and Task 35 real worker factory.
- Produces: public `SeismicityPmTilesDecoder.start({required archive, required chunkCapacity})` with no descriptor/factory argument.

- [ ] **Step 1: Write the failing facade/API tests**

Compile the facade only through the barrel, assert its tear-off requires archive and chunk capacity, and prove no descriptor or worker factory can be supplied. With a minimal accepted archive, assert the facade selects `IsolateSeismicityDecoderWorkerFactory` and the result metadata comes from `archive.descriptor`.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_facade_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: compile failure for the missing public facade.

- [ ] **Step 3: Add only the public default adapter**

Construct Task 39 with the Task 35 real factory and delegate `start` using the supplied archive/chunk capacity. Do not copy its descriptor, expose injection seams, traverse tiles, or duplicate cleanup logic.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_facade_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: barrel/facade contract passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_facade_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles decoder facadeを公開"
git push
```

### Task 41: Reject decoder pipeline corruption without publication

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_corruption_test.dart`

**Interfaces:**
- Consumes: Task 39 runner, Task 38 lifecycle, and both controlled seams.
- Produces: typed first-failure/no-partial-dataset behavior before cancellation races.

- [ ] **Step 1: Write failing corruption-path tests**

Cover invalid archive descriptor before spawn, enumeration failure, read failure after one acknowledgement, typed worker decode failure, finish/count failure, invalid transferred chunk, and archive-close failure. Inject otherwise-valid datasets whose schema version, data zoom, feature count, or archive revision differs from `archive.descriptor`; each must fail closed with no completed state or misattributed dataset. Assert exact first failure fields, spawn count zero for invalid descriptor and one otherwise, no request after failure, and archive/worker retirement once.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_corruption_test.dart`

Expected: Task 39 happy-only runner leaks a later error, publishes partial state, or misses cleanup in at least one case.

- [ ] **Step 3: Add one authoritative failure path**

Choose the first typed decode/source failure before cleanup. Before completed publication, compare dataset schema/data zoom/archive revision/count with the archive-accepted descriptor even when an injected factory bypasses Task 34. Finish/materialize only after all tiles. Cleanup failure replaces only an otherwise successful result; it never masks a primary failure. Apply Task 38 actions and close the state stream after one terminal state.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_happy_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_corruption_test.dart`

Expected: no partial publication, exact first failure, deterministic counts, and 30–100 production-plus-test handwritten changed lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_corruption_test.dart
git commit -m "Fix: decoder破損時の公開を防止"
git push
```

### Task 42: Write deterministic PMTiles v3 archive bytes

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer_test.dart`

**Interfaces:**
- Consumes: typed tile IDs/payloads and explicit none/gzip codes.
- Produces: test-only exact header/root-directory/metadata/tile-data bytes.

- [ ] **Step 1: Write the failing writer byte test**

Assert exact 127-byte header fields, delta-varint entries, metadata `{}`, offsets/counts, min/max zoom, MVT type, clustered flag, and deterministic none/gzip output for two payloads.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer_test.dart`

Expected: compile failure for missing writer.

- [ ] **Step 3: Implement only byte assembly**

Use top-level checked varint/header functions and `gzip.encode`; accept all contract values explicitly. Do not open an archive, create a descriptor, or add corruption cases.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer_test.dart`

Expected: exact bytes are stable and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer.dart \
  packages/seismicity_pmtiles/test/support/seismicity_pmtiles_archive_writer_test.dart
git commit -m "Test: PMTiles fixture writerを追加"
git push
```

### Task 43: Build gzip archive fixtures and corrupt variants

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart`

**Interfaces:**
- Consumes: Task 42 writer and schema-v1 MVT bytes.
- Produces: in-memory archive bytes, exact opener/fixture descriptor, and isolated truncation variants.

- [ ] **Step 1: Write the failing fixture self-test**

Compose two z2 MVT payloads with gzip directory/tile compression. Open through Asset reader/archive, assert occupied IDs/decompressed bytes/descriptor, close once, and reject truncated header/directory/tile variants.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart`

Expected: compile failure for missing composed fixture.

- [ ] **Step 3: Implement fixture composition**

Delegate all bytes to Task 42. Supply schema/data zoom/count/revision explicitly and produce one-copy corrupt variants; no URL/header-derived fallback.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart`

Expected: gzip/corruption cases pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart \
  packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart
git commit -m "Test: gzip PMTiles fixtureを追加"
git push
```

### Task 44: Cancel safely before and during archive I/O

**Files:**
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_io_test.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`

**Interfaces:**
- Consumes: Task 38 lifecycle, Task 25 controlled worker, Task 36 controlled archive, and operation `cancel`.
- Produces: cancellation wiring for pre-spawn, enumeration, and tile-read phases.

- [ ] **Step 1: Write failing pre-worker/I/O cancellation tests**

Cover cancellation before spawn completes, during enumeration, and during tile read. Call `cancel()` twice concurrently in each phase. Assert one cancelled result/state, factory spawn at most once, archive close and any created handle cancel/close/retirement once, blocked I/O released, and no tile request or completed state after cancellation.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_io_test.dart`

Expected: at least one pre-spawn/I/O race exposes duplicate cleanup, a wrong terminal state, or a hanging future.

- [ ] **Step 3: Wire cancellation into archive I/O**

On cancel, submit the signal to Task 38, close the archive to release enumeration/read, cancel a handle only if spawn completed, and apply its memoized cleanup actions. Do not add a second terminal completer or lifecycle policy in the runner.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_io_test.dart`

Expected: no test times out, every I/O phase retires once, and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_io_test.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart
git commit -m "Fix: archive読込中の取消を直列化"
git push
```

### Task 45: Preserve terminal results across late cancellation and cleanup failure

**Files:**
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_terminal_test.dart`
- Modify only if RED exposes a wiring defect: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`

**Interfaces:**
- Consumes: Tasks 38–44 terminal/runner behavior and both controlled seams.
- Produces: finish/terminal/cleanup race regression evidence with first-result preservation.

- [ ] **Step 1: Write the failing late-race table**

Cover cancellation after acknowledgement, during finish, and after completed result, plus cancel racing spawn failure, read failure, worker finish failure, and archive-close failure. Assert cancellation wins only before an authoritative result; primary failures are never masked, successful cleanup failure is surfaced, and archive/worker close/retired plus state completion occur once.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_terminal_test.dart`

Expected: an unconnected Task 38 action or late terminal ordering fails; if all cases are GREEN, keep this task test-only.

- [ ] **Step 3: Fix only a demonstrated runner wiring gap**

Route the missing signal/action through Task 38. Do not change its precedence table, duplicate worker Task 32 terminal policy, or replace an earlier decode/cancel failure with cleanup failure.

- [ ] **Step 4: Run GREEN and inspect the combined handwritten size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_io_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_terminal_test.dart`

Expected: every race has one result and retirement; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_cancellation_terminal_test.dart
git add -u packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart
git commit -m "Test: decoder終端取消の優先順を固定"
git push
```

The `git add -u` line stages only a runner wiring defect demonstrated by RED and is a no-op for a GREEN test-only task.

### Task 46: Decode a gzip archive through the real default worker

**Files:**
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart`
- Modify only if RED identifies ownership: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart`
- Modify only if RED identifies ownership: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart`

**Interfaces:**
- Consumes: real Asset reader/archive, Task 43 gzip fixture, Task 40 public decoder facade, and Task 35 real worker default.
- Produces: archive-to-public-column integration evidence at explicit non-14 zoom.

- [ ] **Step 1: Write the full-pipeline integration test**

Build two gzip MVT tiles at data zoom 2. Include explicit zero/false/empty internal properties, missing optionals, and all-property exact boundary copy. Open with one descriptor and start only through the public facade with archive/chunk capacity 1. Assert dataset revision/schema/zoom/count equal `archive.descriptor`, exact chunks/UUID/coordinates/time/NaN-validity/dictionary, ordered states, and archive close. Add truncated archive and malformed second MVT; neither may publish a dataset.

- [ ] **Step 2: Run the real integration test**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart`

Expected: if all prior contracts compose, this may begin GREEN. Any failure must identify the owning earlier task; do not add an unscoped integration workaround.

- [ ] **Step 3: Fix only the owning boundary if RED**

Preserve data zoom 2 through enumeration/TileID/point/worker/dataset. Gzip remains archive-layer responsibility. If production changes are required, keep them file-specific and 30–100 production-plus-test handwritten lines; otherwise this is test-only.

- [ ] **Step 4: Run GREEN and retirement check**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_lifecycle_test.dart`

Expected: real default spawns one worker, completes one dataset only after all gates, then retires its ports/isolate and closes archive once.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart
git add -u packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder_runner.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart
git commit -m "Test: gzip archive decodeを実workerで固定"
git push
```

The `git add -u` line stages only tracked decoder fixes demonstrated by RED; omit it for a GREEN test-only task.

### Task 47: Generate deterministic benchmark feature primitives

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_feature_source.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_feature_source_test.dart`

**Interfaces:**
- Consumes: non-negative global row index.
- Produces: deterministic UUID bytes, geometry, scalar/UTF-8 properties, and expected public byte contribution.

- [ ] **Step 1: Write failing first/middle/last feature tests**

Assert canonical v4 UUID bytes/text only for fixture encoding, fixed data zoom 6 coordinates, deterministic presence pattern including empty allowed strings/non-empty event IDs, exact UTF-8 bytes, and checked public byte contribution. No random/clock input.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_feature_source_test.dart`

Expected: compile failure for missing feature source.

- [ ] **Step 3: Implement stateless index derivation**

Derive one transient fixture feature at a time, encode strings immediately, and retain no collection/map. Keep expected byte arithmetic independent of the decoder result.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_feature_source_test.dart`

Expected: repeatable primitives/bytes and 30–100 production-plus-test handwritten lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_feature_source.dart \
  packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_feature_source_test.dart
git commit -m "Perf: benchmark震源primitiveを追加"
git push
```

### Task 48: Build an on-demand benchmark archive

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_archive.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_archive_test.dart`

**Interfaces:**
- Consumes: Task 47 feature source and Task 5 archive descriptor contract.
- Produces: one accepted benchmark descriptor, occupied IDs, one on-demand MVT tile, expected first/last UUID and total bytes.

- [ ] **Step 1: Write a failing 10,000-row archive test**

Use 1,000 rows/tile. Assert the archive exposes its identical deterministic descriptor, occupied IDs, deterministic first/last tile bytes, expected UUID/byte metadata, one live payload at a time, read count, and close once.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_archive_test.dart`

Expected: compile failure for missing archive.

- [ ] **Step 3: Implement streaming tile construction**

Construct one final descriptor from the explicit benchmark arguments and generate one raw tile during `readTile` from Task 47, releasing it before the next. Never permit descriptor replacement or retain all payloads/2M rows.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_archive_test.dart`

Expected: archive counters/bytes pass and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_archive.dart \
  packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_archive_test.dart
git commit -m "Perf: 決定的benchmark archiveを追加"
git push
```

### Task 49: Count real worker spawns in benchmarks

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/support/counting_decoder_worker_factory.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/counting_decoder_worker_factory_test.dart`

**Interfaces:**
- Consumes: Task 24 factory and Task 35 real delegate.
- Produces: non-export counting delegate preserving exact handle behavior.

- [ ] **Step 1: Write a failing delegate test**

Wrap controlled and real factories, assert the accepted descriptor/chunk-capacity spawn arguments and handle identity, count exactly one per delegation, and preserve spawn failure without increment ambiguity.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/counting_decoder_worker_factory_test.dart`

Expected: compile failure for missing delegate.

- [ ] **Step 3: Implement the counter wrapper only**

Increment at one documented point before delegation, expose read-only count, and add no timing/archive/runner behavior.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/counting_decoder_worker_factory_test.dart`

Expected: success/failure counts are deterministic and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/support/counting_decoder_worker_factory.dart \
  packages/seismicity_pmtiles/test/benchmark/counting_decoder_worker_factory_test.dart
git commit -m "Perf: benchmark worker数を計測"
git push
```

### Task 50: Run benchmark correctness through one worker

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark_runner.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_runner_test.dart`

**Interfaces:**
- Consumes: Task 48 archive, Task 49 counting factory, non-export decoder runner.
- Produces: benchmark result with counts, bytes, worker spawns, close count, elapsed/RSS, optional threshold, and nullable `withinTarget`.

- [ ] **Step 1: Write a failing 10,000-row runner test**

Run the internal decoder runner with a counting factory that delegates to the real factory. Assert one spawn with `archive.descriptor`, exact descriptor identity/requested/unique/chunk sum, expected typed-column bytes, first/last UUID, one archive close, valid chunks, finite elapsed/RSS, and null `withinTarget` without threshold. With a supplied zero/large threshold, assert false/true but identical success.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_runner_test.dart`

Expected: compile failure for missing benchmark runner.

- [ ] **Step 3: Implement correctness-first runner**

`runSeismicityDecodeBenchmark` requires feature/tile/chunk counts and accepts nullable `Duration informationalTimeThreshold`. Use Task 49, Stopwatch/`ProcessInfo.currentRss`, validate every chunk and independent expected byte total, then return a typed result. A threshold comparison never changes success/failure.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_runner_test.dart`

Expected: correctness/OOM-crash propagation/worker-count/count/byte-size/close invariants determine success; time/RSS do not; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark_runner.dart \
  packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_runner_test.dart
git commit -m "Perf: decoder benchmarkの正しさを検証"
git push
```

### Task 51: Parse benchmark CLI arguments

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/seismicity_benchmark_arguments.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_arguments_test.dart`

**Interfaces:**
- Consumes: CLI string list.
- Produces: typed feature/tile/chunk counts and optional informational threshold.

- [ ] **Step 1: Write failing parser tests**

Assert defaults include exactly 2,000,000 rows and no threshold. Parse all positive integer flags. Reject missing values, unknown/duplicate flags, zero, negative, fraction, overflow, and positional input with typed usage failure.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_arguments_test.dart`

Expected: compile failure for missing parser.

- [ ] **Step 3: Implement parsing only**

Return one immutable typed arguments value. Do not run benchmark, read environment defaults, or invent an SLO.

- [ ] **Step 4: Run GREEN and inspect size**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_arguments_test.dart`

Expected: parser table passes and production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/seismicity_benchmark_arguments.dart \
  packages/seismicity_pmtiles/test/benchmark/seismicity_benchmark_arguments_test.dart
git commit -m "Perf: benchmark CLI引数を解析"
git push
```

### Task 52: Add the deterministic 2,000,000-row CLI

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_cli_test.dart`

**Interfaces:**
- Consumes: Tasks 50–51.
- Produces: one JSON line and correctness-only exit semantics.

- [ ] **Step 1: Write failing output/exit tests**

Inject a small runner. Assert JSON keys/counts/bytes/worker/elapsed/RSS/threshold/nullable `within_target`. Assert correctness/worker/count/byte/close failures exit nonzero, while threshold miss exits zero.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_cli_test.dart`

Expected: compile failure for missing entry/output adapter.

- [ ] **Step 3: Implement reporting and exit mapping**

Write fixed-key JSON with `stdout.writeln` without a retained string-key result map. OOM/crash naturally exit nonzero; correctness/worker/count/typed-byte/column/close failures map nonzero. Threshold/RSS never gate.

- [ ] **Step 4: Run GREEN and full 2M harness**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_cli_test.dart`

Run: `mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 --informational-time-threshold-ms 60000`

Expected: exactly 2M, one worker, exact bytes and observational timing; production-plus-test handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_cli_test.dart
git commit -m "Perf: 200万震源CLI harnessを追加"
git push
```

### Task 53: Document the decoder contract

**Files:**
- Modify: `packages/seismicity_pmtiles/README.md`
- Create: `docs/knowledge/20260809_seismicity_pmtiles_decoder.md`

**Interfaces:**
- Consumes: completed public API and ownership/schema invariants.
- Produces: package usage and durable decoder operational knowledge.

- [ ] **Step 1: Write a failing documentation-content check**

Define required phrases/links for caller-complete archive-open descriptor, `archive.descriptor` single ownership, data zoom, schema v1, all-property canonical dedupe, finite Float32, TTD worker, archive ownership/cancel, no partial dataset, and the 2M command. Run the check before creating the knowledge file.

- [ ] **Step 2: Run RED**

Run:

```bash
set -eu
test -f docs/knowledge/20260809_seismicity_pmtiles_decoder.md
for required in schemaVersion dataZoom archive.descriptor duplicateConflict TransferableTypedData 2000000; do
  rg -q "$required" packages/seismicity_pmtiles/README.md \
    docs/knowledge/20260809_seismicity_pmtiles_decoder.md
done
```

Expected: nonzero because the knowledge file/current README content is absent.

- [ ] **Step 3: Write current public documentation**

README shows a complete caller-owned flow: adapter supplies every descriptor field only while Factory/reader/archive open, the opened archive exposes that accepted descriptor, decoder starts with archive/chunk capacity only, states/result are consumed, and cancel is available. State decoder closes archive; describe schema v1 all-property canonical conflicts, descriptor identity/count gates, NaN+validity, finite Float32, max-intensity dictionary, no 1/14 fallback, TTD worker, and no partial dataset.

The knowledge file records the same invariants plus these reproducible commands:

```bash
mise exec -- dart test packages/seismicity_pmtiles/test
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
```

- [ ] **Step 4: Run GREEN and inspect size**

Run the Step 2 content check, `git diff --check`, and inspect all links/commands against current file names.

Expected: checks exit 0 and documentation handwritten diff is 30–100 lines.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/README.md \
  docs/knowledge/20260809_seismicity_pmtiles_decoder.md
git commit -m "Docs: 震源PMTiles decoder契約を記録"
git push
```

### Task 54: Record backend dependency and run the final gate

**Files:**
- Create: `docs/todo/950_seismicity_manifest_descriptor_fields.md`
- Do not commit regenerated files here; any generated drift belongs to its originating source task.

**Interfaces:**
- Consumes: backend manifest evidence and every prior task.
- Produces: explicit stacked backend dependency and clean verified branch evidence.

- [ ] **Step 1: Write the failing dependency-document check**

Confirm the checked-out backend manifest still lacks public `schema_version`, `data_zoom`, and `archive_revision`, then require a todo containing all three names, backend/OpenAPI/app ordering, and the prohibition on 1/14/URL inference.

- [ ] **Step 2: Run RED**

Run:

```bash
set -eu
test -f docs/todo/950_seismicity_manifest_descriptor_fields.md
for required in schema_version data_zoom archive_revision OpenAPI; do
  rg -q "$required" docs/todo/950_seismicity_manifest_descriptor_fields.md
done
```

Expected: nonzero because the todo does not exist.

- [ ] **Step 3: Add only the backend stacked dependency record**

Write 30–100 lines with current producer/API evidence, required backend manifest/OpenAPI fields, app adapter follow-up, validation/rollout order, and no decoder fallback. Start every multi-command shell block in the todo with `set -eu`. Do not implement backend or app integration in #1601.

- [ ] **Step 4: Regenerate, normalize, audit, and verify fresh**

First prove generation is reproducible with the tracked limited normalizer:

```bash
set -eu
(
  generated='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  scratch=$(mktemp -d)
  trap 'rm -r -- "$scratch"' EXIT
  (cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
  cp -- "$generated" "$scratch/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' "$generated"
  git diff --no-index --exit-code --ignore-space-at-eol "$scratch/before.dart" "$generated"
  git diff --check
  git diff --exit-code -- packages/seismicity_pmtiles/lib/src/model
)
```

Any model diff stops this task and must be committed by amending the originating Task 2, 3, or 37 commit. Then run from repository root:

```bash
set -eu
mise exec -- dart format --output=none --set-exit-if-changed packages/pmtiles_v3 packages/seismicity_pmtiles
mise exec -- dart analyze packages/pmtiles_v3 --fatal-infos
mise exec -- dart analyze packages/seismicity_pmtiles --fatal-infos
mise exec -- dart test packages/pmtiles_v3/test
mise exec -- dart test packages/seismicity_pmtiles/test
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
git diff --check feat/seismicity-pmtiles-network-reader...HEAD
git --no-pager diff --stat feat/seismicity-pmtiles-network-reader...HEAD
```

Expected: format/analyze/tests/harness/diff check exit 0; test output has zero failures; harness reports exactly 2,000,000. Do not report device/simulator/E2E, real network, fps, or GPU performance as verified.

Audit only EQMonitor-authored production/benchmark Dart files changed from the stack base; generated files are excluded, and only the explicitly allowed `Map<String, dynamic>` spelling may contain `dynamic`:

```bash
set -eu
changed_sources=$(mktemp)
trap 'rm -r -- "$changed_sources"' EXIT
git diff --name-only --diff-filter=ACMR feat/seismicity-pmtiles-network-reader...HEAD -- \
  packages/pmtiles_v3/lib packages/seismicity_pmtiles/lib \
  packages/seismicity_pmtiles/benchmark > "$changed_sources"
while IFS= read -r source; do
  case "$source" in
    *.freezed.dart|*.g.dart) continue ;;
  esac
  if rg -n --pcre2 'Map<String,(?! dynamic>)|(?<!Map<String, )\bdynamic\b|\bany\b|\bObject(?:\?)?(?=[^A-Za-z0-9_]|$)|print\s*\(|\.\./src/|defaultDataZoom|defaultSchemaVersion' "$source"; then
    exit 1
  fi
done < "$changed_sources"
if git diff --name-only feat/seismicity-pmtiles-network-reader...HEAD | \
  rg '(^app/|flutter_scene|MapLibre|shader|gpu)'; then
  exit 1
fi
git --no-pager diff --name-only feat/seismicity-pmtiles-network-reader...HEAD
```

Expected: no prohibited hit in changed authored sources, while existing/generated code and the sole allowed JSON map form do not cause false positives. Review dependency source separately.

- [ ] **Step 5: Commit the dependency record, push, and review the whole stack diff**

```bash
set -eu
git add docs/todo/950_seismicity_manifest_descriptor_fields.md
git commit -m "Docs: 震源manifest依存を記録"
git push
git diff --check feat/seismicity-pmtiles-network-reader...HEAD
git --no-pager diff --stat feat/seismicity-pmtiles-network-reader...HEAD
git status --short --branch
git rev-list --left-right --count HEAD...@{u}
```

Review every commit's production-plus-test handwritten line count against 30–100 using `git log --numstat feat/seismicity-pmtiles-network-reader..HEAD`; generated and deterministic fixture bytes are reported separately from handwritten lines. Resolve every Critical/Important finding, confirm clean/upstream 0/0, and do not stack until all task-to-commit mappings are explicit.

## Completion Checklist

- [ ] TileID inverse round-trips through public `pmtiles_v3` API.
- [ ] The opened archive exposes the exact accepted descriptor; decoder/runner accept no replacement descriptor and never substitute schema/data zoom 1/14.
- [ ] Raw MVT protobuf, layer, Point command, tags, scalar types, UUID, and properties are strict.
- [ ] Missing depth/magnitude are NaN plus clear validity, explicit zero remains valid, Float32 overflow such as `1e100` is a typed feature failure, and every valid numeric output slot is finite.
- [ ] Identical boundary/wrap copies dedupe only when geometry and all eight schema-v1 properties match in canonical typed form before Float32 roundoff; determination/event/geometry-clamped internal sidecars are covered.
- [ ] Canonical strings are retained as UTF-8 arena bytes, typed offsets/indexes/validity, and typed open-address slots; no per-event String/key object or string-key map survives decoding.
- [ ] Present empty `earthquake_event_id` is a typed feature failure; present empty `max_intensity` and `determination_flag` remain distinct from absence.
- [ ] Returned data is bounded typed chunks, not 2M Freezed/event objects.
- [ ] One long-lived worker receives and returns TTD; a non-export injectable factory/handle controls tests while the public facade uses the real default.
- [ ] Dataset schema version, data zoom, archive revision, transfer count, checked chunk sum, and descriptor expected count all match the archive-accepted descriptor before publication; mismatch publishes nothing.
- [ ] Typed launcher/probe seams and the pure terminal coordinator make invalid chunks, crashes, port closure, exit, cancellation, and kill observable; external handles close ports and retire workers exactly once.
- [ ] Gzip archive fixture and malformed schema/archive fixtures pass/fail as specified.
- [ ] Deterministic 2M harness exits 0 only for correct worker/count/byte-size/resource results; caller threshold, `within_target`, elapsed, and RSS remain observations.
- [ ] Every build_runner invocation is immediately normalized/proved and generated output is committed with its originating task.
- [ ] Tasks 1–54 map one-to-one to commits; each commit's production-plus-test handwritten total is 30–100 lines, with generated outputs and deterministic fixture bytes reported separately.
- [ ] Final prohibited-type audit covers only changed authored source, excludes generated files, and allows only `Map<String, dynamic>`.
- [ ] Backend manifest drift is documented as a separate stacked dependency.
- [ ] No #1600 I/O reimplementation and no #1602 Scene/projection/GPU code is present.

## References

- [PMTiles v3 specification and reference implementation](https://github.com/protomaps/PMTiles)
- [`vector_tile` 4.0.0 public package API](https://pub.dev/packages/vector_tile)
- [`bdero/dashmap` typed worker examples](https://github.com/bdero/dashmap)
- [`ingen084/KyoshinEewViewerIngen` point cache and layer reference](https://github.com/ingen084/KyoshinEewViewerIngen)
