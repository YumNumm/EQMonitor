# Seismicity PMTiles Decoder Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `SeismicityPmTilesArchive` の descriptor 指定 data zoom にある全震源を、厳密な schema v1 MVT 検証、境界重複排除、常駐 Isolate、`TransferableTypedData` を通して列形式 dataset へ変換する。

**Architecture:** archive I/O と所有権は main isolate の decode operation が持ち、展開済み MVT tile bytes だけを1個の常駐 worker isolateへ順番に移譲する。workerは raw protobufを厳密検証し、UUIDを固定16 byteに変換してtyped columnへ蓄積し、同一UUIDの完全一致コピーだけを排除する。全tile完了後に descriptor の期待ユニーク件数と照合し、成功時だけ chunk群を `TransferableTypedData` でmain isolateへ返す。

**Tech Stack:** Dart 3.11+ / `pmtiles_v3` / `seismicity_pmtiles` / `vector_tile` 4.0.0 raw protobuf API / `uuid` 4.6.x / Freezed / `dart:isolate` / `TransferableTypedData` / `test`

## Global Constraints

- Base branch is `feat/seismicity-pmtiles-network-reader`; this branch is `feat/seismicity-pmtiles-decoder` and must remain its direct stacked child.
- Scope is Issue #1601 only. Do not reimplement #1600 HTTP/File/Asset random access, and do not add #1602 projection, Flutter Scene, GPU, Shader, camera, or app UI code.
- Every Flutter/Dart command runs through `mise exec --`. Add dependencies only with `(cd packages/seismicity_pmtiles && mise exec -- flutter pub add vector_tile uuid)`; do not hand-edit dependency declarations.
- Follow RED/GREEN TDD for every production behavior change. A later integration/regression task may begin GREEN when it only proves an already-implemented contract; in that case, do not manufacture a production diff. Every task is one independently reviewable logical commit, targeting 30–100 handwritten changed lines; generated Freezed files and deterministic fixtures are committed with their source task.
- Use only named parameters for functions or constructors with two or more arguments. Do not add `dynamic`, `any`, explicit `Object`/`Object?`, null assertions, `print`, or private class methods.
- Do not retain one Freezed/Dart object per hypocenter. Per-feature transient values inside one worker callback are allowed; the returned 2M-scale representation is typed columns split into bounded chunks.
- Missing `depth_km` and `magnitude` use `double.nan` plus a validity bitmap. A numeric zero is valid only when the source property explicitly contains zero; no missing value is replaced by zero.
- `SeismicityPmTilesArchiveDescriptor.schemaVersion` and `.dataZoom` are required caller inputs. Accept exactly schema version 1 and enumerate exactly `descriptor.dataZoom`; never substitute 1 or 14 when metadata is absent.
- The current public `/v2/hypocenters/manifest` contract lacks `schema_version`, `data_zoom`, and `archive_revision`. That is a separate backend stacked dependency before app integration. This branch consumes a caller-complete descriptor and must not infer those fields from URL, PMTiles header, or producer constants.
- Cancellation, schema/type corruption, conflicting duplicate UUIDs, worker failure, and count mismatch are typed failures. On every success, failure, and cancellation path, the decode operation closes the archive and retires the worker exactly once.
- No physical-device, simulator, real-network, or E2E run is required. Pure-Dart unit/integration tests and the deterministic 2,000,000-feature harness are required.
- Generated-file normalization must follow `docs/knowledge/20260708_build_runner_generated_diffs.md`; semantic manual edits to generated files are forbidden.

## Reference Decisions

- Adopt the PMTiles official `tileIdToZxy` inverse Hilbert algorithm, ported with Dart integer arithmetic, from `protomaps/PMTiles` at `8b8ddea4dbff1b0104cf2bebf2f7ff35c91b41d5`. Keep forward/inverse round-trip tests in `pmtiles_v3`.
- Adopt `vector_tile` 4.0.0 only through its public `package:vector_tile/raw/raw_vector_tile.dart` protobuf model. Do not use its GeoJSON conversion, mutable high-level geometry decoder, or `VectorTileValue.value`: those paths allocate nested feature/GeoJSON objects, expose `Object`, and do not enforce this archive's strict single-Point/property contract.
- Adopt `bdero/dashmap` at `a6ff92edd999e922f81d26d209d8f589faee3fd0` as evidence for typed-data-only CPU worker jobs and keeping GPU/UI work outside the worker. Do not copy its per-job `Isolate.run`, web synchronous fallback, terrain streaming, tile selection, network cache, or Flutter Scene code; this issue requires one long-lived decoder isolate and has no renderer.
- Adopt `ingen084/KyoshinEewViewerIngen` at `3e9d6a01f62e754c9c6da4a413330c4cfcb4afab` only for the invariant that a complete point cache is built before replacing the visible dataset. Do not adopt its Avalonia/Skia renderer, zoom-dependent point layout, hover cache, Mercator UI layer, or earthquake presentation types as PMTiles/decode contracts.
- The backend producer at gitlink `8bdda33cd0ae0860a395d9b8465b5d226e422de5` defines layer `hypocenters`; required properties `hypocenter_id` and `origin_time_unix_ms`; optional `magnitude`, `depth_km`, `max_intensity`, `determination_flag`, `earthquake_event_id`, and `geometry_clamped`. Schema v1 rejects every other property name and validates even the ignored optional properties' scalar types.

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

`SeismicityPmTilesDataset` is also `@Freezed(equal: false)` and holds the caller descriptor identity (`archiveRevision`, `schemaVersion`, `dataZoom`), exact `featureCount`, and `List<SeismicityPmTilesChunk>`. A dataset is publishable only after every chunk invariant, unique count, and descriptor count have passed.

## Locked MVT Schema v1

- Tile contains exactly one `hypocenters` layer. Its protobuf `version` and `extent` fields must be present; version must be 2 and extent must be positive.
- Every feature has type `POINT` and exactly one canonical `MoveTo(count=1)` point. MultiPoint, LineString, Polygon, unknown commands, truncated parameters, extra commands, odd tags, invalid key/value indexes, or repeated property keys are failures.
- Required: `hypocenter_id` is one canonical dashed UUID string; `origin_time_unix_ms` is an exact safe integer representable by `Int64List`.
- Optional decoded: `magnitude` and `depth_km` accept any single MVT numeric scalar only when finite; `max_intensity` accepts a string.
- Optional validated but not retained in this stack: `determination_flag` and `earthquake_event_id` are strings; `geometry_clamped` is bool.
- A raw MVT value must set exactly one of string/float/double/int/uint/sint/bool. Missing, multiple, or wrong scalar variants are failures.
- Point coordinates are transformed from local MVT integers to normalized global Web Mercator integers with tile X wrapping, then to finite longitude/latitude. Global Y outside `[0, extent * 2^zoom]` is rejected; it is never clamped.
- Same UUID plus identical normalized global point and all schema-v1 property values is a boundary copy and is emitted once. Same UUID with any different geometry or property is `duplicateConflict` and invalidates the whole dataset.

## File Map

| Path | Responsibility |
|---|---|
| `packages/pmtiles_v3/lib/src/archive/pmtiles_v3_tile_id.dart` | Bidirectional PMTiles TileID/Hilbert coordinate conversion. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk.dart` | Public typed column chunk. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_dataset.dart` | Public completed dataset. |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_decode_progress.dart` | Public raw/unique/tile progress. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_schema_v1_validator.dart` | Descriptor and property-name contract. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart` | Exactly-one scalar conversion. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_point_decoder.dart` | Strict Point command and Web Mercator coordinate conversion. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart` | Raw protobuf/layer/tag/feature streaming decode. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_uuid_index.dart` | Typed open-address UUID-to-row index. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart` | Bounded column/dictionary/validity construction. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart` | Cross-tile exact dedupe and chunk finalization. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decode_transfer.dart` | Typed columns to/from TTD messages. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart` | Long-lived isolate protocol and lifecycle. |
| `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart` | Public operation, archive traversal, count gate, cancel/close. |
| `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart` | Deterministic raw MVT schema fixtures. |
| `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart` | Deterministic gzip PMTiles archive fixtures. |
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

Expected: all tests pass and analysis reports no issues.

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

Run exactly:

```bash
(cd packages/seismicity_pmtiles && mise exec -- flutter pub add vector_tile uuid)
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
```

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

Expected: all model tests pass.

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

Run generation:

```bash
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
```

- [ ] **Step 4: Run GREEN and public compile coverage**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_dataset_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: all tests pass and imports use only the package barrel.

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

Test indices 0, 7, 8, and 15. Reject every wrong column length, a set numeric-validity bit whose value is NaN, a clear numeric-validity bit whose value is not NaN, dictionary offsets not starting at zero, descending/out-of-range offsets, and a valid dictionary index outside the dictionary.

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

`requiredByteLength({required int valueCount})` returns `(valueCount + 7) ~/ 8`; `setValid` and `isValid` use little bit order within each byte (`1 << (index & 7)`). Validate UUID length `length * 16`, every fixed-width column, all three bitmaps, numeric NaN/validity parity, dictionary offset/index bounds, and exact terminal UTF-8 length. Negative lengths are corrupt.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart`

Expected: all focused tests pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/model/seismicity_validity_bitmap.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_chunk_validator.dart \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/model/seismicity_pmtiles_chunk_validator_test.dart
git commit -m "Feat: 震源列buffer整合性を検証"
git push
```

### Task 5: Enforce the caller-complete schema descriptor

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

Use `supportedSchemaVersion = 1` only as an equality gate. Bound `expectedFeatureCount` to `0x3fffffff`, so Task 9 can maintain a maximum 0.5 load factor in a power-of-two `Uint32List` whose largest representable capacity is `0x80000000`. Convert allocation failure to a typed descriptor failure. Do not expose `defaultSchemaVersion`, `defaultDataZoom`, or a descriptor-copying fallback. The accepted property set is:

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

Expected: all tests pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_schema_v1_validator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_schema_v1_validator_test.dart
git commit -m "Feat: 震源schema descriptorを検証"
git push
```

### Task 6: Decode exactly one typed MVT scalar

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

**Interfaces:**
- Consumes: `VectorTile_Value` from `package:vector_tile/raw/raw_vector_tile.dart`.
- Produces: `requireString`, `requireFiniteNumber`, `requireSafeInteger`, and `requireBool`, each with named `value`, `tileId`, `featureIndex`, and `field` arguments.

- [ ] **Step 1: Write failing table-driven scalar tests**

Create raw values for every protobuf scalar variant. Verify string/bool exactness, numeric acceptance for float/double/int/uint/sint, safe integer acceptance for epoch milliseconds, and typed rejection for no field, two fields, NaN, infinity, fractional time, unsafe double integer, unsigned negative `Int64`, and wrong scalar type.

```dart
expect(
  decoder.requireFiniteNumber(
    value: createVectorTileValue(doubleValue: 12.5),
    tileId: 5,
    featureIndex: 0,
    field: 'depth_km',
  ),
  12.5,
);
```

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

Expected: compile failure for the missing decoder.

- [ ] **Step 3: Implement cardinality before conversion**

Count `hasStringValue`, `hasFloatValue`, `hasDoubleValue`, `hasIntValue`, `hasUintValue`, `hasSintValue`, and `hasBoolValue`; require a count of exactly one before reading. `requireSafeInteger` accepts integer-family values or an integral double within `±9007199254740991`; reject float timestamps because Float32 cannot preserve arbitrary epoch-millisecond integers. Every failure throws `SeismicityPmTilesException.invalidHypocenterFeature` with the stable field and reason code.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart`

Expected: all scalar cases pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_value_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_value_decoder_test.dart
git commit -m "Feat: MVT scalar型を厳密に解析"
git push
```

### Task 7: Decode a strict Point and derive global coordinates

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

Expected: all geometry and coordinate cases pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_point_decoder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_point_decoder_test.dart
git commit -m "Feat: MVT Point座標を厳密に解析"
git push
```

### Task 8: Stream schema-v1 hypocenters from one MVT tile

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoded_hypocenter.dart`
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_test.dart`

**Interfaces:**
- Consumes: `PmTilesV3TileId.zxyForTileId`, Tasks 5–7, raw vector-tile protobuf.
- Produces: transient `SeismicityDecodedHypocenter` and synchronous `int decode({required tileId, required dataZoom, required tileBytes, required onHypocenter})` where the return value is raw feature count.

- [ ] **Step 1: Add a deterministic raw MVT fixture builder and failing happy-path test**

The support builder uses public `raw` constructors, deterministic key/value ordering, Point command encoding, and no production imports from `test/`. Build one `hypocenters` layer with explicit version 2/extent 4096 and these values:

```dart
const id = '018f0f4e-7b84-7c00-8000-123456789abc';
const properties = <String, SeismicityFixtureScalar>{
  'hypocenter_id': SeismicityFixtureScalar.string(id),
  'origin_time_unix_ms': SeismicityFixtureScalar.integer(1710000000123),
  'magnitude': SeismicityFixtureScalar.number(5.1),
  'depth_km': SeismicityFixtureScalar.number(0),
  'max_intensity': SeismicityFixtureScalar.string('4'),
};
```

Assert callback count 1, canonical 16 UUID bytes, explicit depth 0, origin time, and optional values.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_test.dart`

Expected: compile failure for the missing production decoder.

- [ ] **Step 3: Implement protobuf/layer/tag/property streaming decode**

Parse with `raw.VectorTile.fromBuffer` inside a typed conversion boundary. Require one `hypocenters` layer, explicit version 2 and extent, POINT type, even tags, in-range key/value indexes, unique keys, both required properties, and the eight-name schema. Validate ignored fields using Task 6. Parse UUID with `UuidValue.withValidation(input, ValidationMode.strictRFC9562)`, require `value.toFormattedString() == input`, and emit its 16 bytes. Never call high-level `VectorTile.fromBytes`, `decodeGeometry`, or `toGeoJson`.

The transient type has exact fields:

```dart
final class SeismicityDecodedHypocenter {
  const SeismicityDecodedHypocenter({
    required this.hypocenterId,
    required this.hypocenterIdText,
    required this.globalX,
    required this.globalY,
    required this.longitude,
    required this.latitude,
    required this.originTimeUnixMilliseconds,
    required this.magnitude,
    required this.depthKm,
    required this.maxIntensity,
  });
  final Uint8List hypocenterId;
  final String hypocenterIdText;
  final int globalX;
  final int globalY;
  final double longitude;
  final double latitude;
  final int originTimeUnixMilliseconds;
  final double? magnitude;
  final double? depthKm;
  final String? maxIntensity;
}
```

- [ ] **Step 4: Add strict rejection coverage and run GREEN**

Use fixture mutations to reject invalid protobuf, missing/duplicate/unexpected layers, missing/invalid layer fields, non-Point and MultiPoint, odd/out-of-range/repeated tags, missing required fields, non-canonical UUID, each wrong scalar type, unknown properties, and tile ID whose zoom differs from `dataZoom`.

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_test.dart`

Expected: every corrupt fixture yields the typed feature/tile exception and no later callback.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoded_hypocenter.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_mvt_tile_decoder.dart \
  packages/seismicity_pmtiles/test/support/seismicity_mvt_fixture_builder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_mvt_tile_decoder_test.dart
git commit -m "Feat: 震源MVT tileを厳密に解析"
git push
```

### Task 9: Build a typed UUID index without per-event keys

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

Allocate a `Uint32List` whose power-of-two capacity is at least twice `expectedUniqueCount` (one slot for zero). Store `rowIndex + 1`, use a deterministic 32-bit FNV-1a hash for the probe start, and call the exact UUID comparator before declaring a hit. The index does not retain UUID strings, `Uint8List` key objects, or a `Map` entry per event. Require the Task 5 bound `expectedUniqueCount <= 0x3fffffff`, use checked next-power-of-two arithmetic, convert allocation failure to a typed descriptor failure, and never silently grow past the descriptor boundary.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart`

Expected: all tests pass, including forced hash collision.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_uuid_index.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_uuid_index_test.dart
git commit -m "Feat: 震源UUIDをtyped index化"
git push
```

### Task 10: Encode max intensity as a lossless chunk dictionary

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_string_dictionary_builder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_string_dictionary_builder_test.dart`

**Interfaces:**
- Consumes: exact schema-v1 `max_intensity` strings.
- Produces: `indexFor({required value})`, `valueAt({required index})`, and `build()` returning `({Uint8List utf8, Uint32List offsets})`.

- [ ] **Step 1: Write failing dictionary tests**

Verify repeated `4` shares one index, `5-`, `5+`, `!5-`, empty string, and Japanese/UTF-8 strings round-trip exactly; offsets start at 0 and end at byte length. Reject dictionary byte size or index count above uint32 representation limits using an injected small test limit.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_string_dictionary_builder_test.dart`

Expected: compile failure for missing builder.

- [ ] **Step 3: Implement per-chunk lossless encoding**

Use one small `Map<String, int>` per chunk, retain each distinct string once, append exact UTF-8 bytes, and produce monotonically increasing uint32 offsets. Do not convert strings to a guessed JMA intensity enum and do not coerce unknown values.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_string_dictionary_builder_test.dart`

Expected: all dictionary cases pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_string_dictionary_builder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_string_dictionary_builder_test.dart
git commit -m "Feat: 最大震度列を辞書符号化"
git push
```

### Task 11: Build bounded typed column chunks

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart`

**Interfaces:**
- Consumes: `SeismicityDecodedHypocenter`, Task 4 validity helpers, Task 10 dictionary.
- Produces: `add({required record})`, `matches({required localIndex, required record})`, `uuidEquals({required localIndex, required candidate})`, `isFull`, `length`, and `build()` returning a validated `SeismicityPmTilesChunk`.

- [ ] **Step 1: Write failing add/match/build tests**

Use capacity 2. Add one event with explicit magnitude/depth 0 and intensity `4`, then one event missing all optionals. Assert 16-byte IDs, Float64 coordinates, Int64 time, Float32 values, bitmaps, NaN missing slots, dictionary reuse, exact matching, every single-field mismatch, full-state rejection, and exact-size final arrays.

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

Require a positive capacity. Preallocate all fixed columns and bitmaps once. On every add, copy 16 UUID bytes, write required columns, write NaN before leaving either optional numeric validity bit clear, and dictionary-encode only a present max intensity. `matches` compares normalized `globalX/globalY` retained in internal `Int64List`s plus every output property exactly; these internal coordinate columns are not exposed in the public chunk.

`build` returns exact-length typed lists and calls `SeismicityPmTilesChunkValidator`; it must not expose unused capacity.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart`

Expected: all builder and invariant tests pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_chunk_builder.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_chunk_builder_test.dart
git commit -m "Feat: 震源typed chunkを構築"
git push
```

### Task 12: Accumulate unique rows across chunk boundaries

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

**Interfaces:**
- Consumes: Tasks 9 and 11.
- Produces: `SeismicityDatasetAccumulator(expectedUniqueCount:, chunkCapacity:)`, `bool add({required record})`, raw/unique counters, and `List<SeismicityPmTilesChunk> buildChunks()`.

- [ ] **Step 1: Write failing cross-chunk dedupe tests**

Use capacity 2 and four raw rows: A, B, identical A, C. Assert raw count 4, unique count 3, two output chunks of lengths 2/1, stable first-seen order, and exact UUID bytes. Change each geometry/property of the second A in a table and assert `SeismicityPmTilesDuplicateConflictException`. Reject a fourth unique row when expected count is 3 before writing outside the index.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

Expected: compile failure for missing accumulator.

- [ ] **Step 3: Implement exact duplicate classification**

Use the UUID index to find a global row. Resolve global row to `chunkIndex = rowIndex ~/ chunkCapacity` and local row to `rowIndex % chunkCapacity`. If UUID and `matches` are exact, increment raw count and return false. If payload differs, throw `duplicateConflict`. For a new UUID, create a new bounded chunk only when the current chunk is full, add it, insert its global row, increment both counters, and return true.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart`

Expected: exact copies dedupe and every conflict fails.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_dataset_accumulator_test.dart
git commit -m "Feat: 境界震源をUUIDで重複排除"
git push
```

### Task 13: Transfer chunks without copying object graphs

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

Expected: the isolate round-trip preserves every bit.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decode_transfer.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decode_transfer_test.dart
git commit -m "Feat: 震源列bufferをTTD転送"
git push
```

### Task 14: Spawn one long-lived decoder worker

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_protocol.dart`
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

**Interfaces:**
- Consumes: tile decoder, accumulator, TTD transfer.
- Produces: `SeismicityDecoderWorker.spawn({required expectedUniqueCount, required chunkCapacity, required dataZoom})`, `decodeTile({required tileId, required tileBytes})`, `finish({required descriptor})`, and idempotent `cancel()`/`close()`.

- [ ] **Step 1: Write a failing multi-request worker test**

Spawn once, send two MVT tiles as `TransferableTypedData`, await a progress response after each, then finish. Assert decoded tile count 2, cumulative raw/unique counts, stable rows from both messages, and one final dataset transfer. Sending after finish, failure, cancel, or close must return the same terminal typed failure and start no second worker.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

Expected: compile failure for missing worker.

- [ ] **Step 3: Implement the typed request/response protocol**

Use private immutable message classes under sealed `SeismicityDecoderWorkerRequest` and `SeismicityDecoderWorkerResponse` protocol bases, containing only ints, strings, `SendPort`, public typed exceptions, and TTD. Cast each `ReceivePort` once to its protocol base before iterating it, then exhaustively switch on the sealed message type; EQMonitor-authored code must not expose or declare the port's underlying dynamic element type. The worker entry point creates exactly one `SeismicityMvtTileDecoder` and one `SeismicityDatasetAccumulator`, serializes requests on one future chain, materializes each input once, and returns one progress value. `finish` first compares unique count with the descriptor expectation, then builds and transfers chunks. Any decode error becomes a terminal response; subsequent messages repeat that first failure.

The main handle owns `ReceivePort`, `SendPort`, a stored routing `Future<void>`, pending typed completers, and `Isolate`. Route with `await for (final message in receivePort.cast<SeismicityDecoderWorkerResponse>())` and an exhaustive switch; do not declare `dynamic`, `Object`, or `Object?`. Closing the ReceivePort completes the stored routing future. Split routing and lifecycle into top-level/internal classes so no private class method is introduced.

- [ ] **Step 4: Run GREEN and leak checks**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

Expected: multi-tile state persists in one worker; every terminal path completes pending requests and closes ports.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker_protocol.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart
git commit -m "Feat: 常駐震源decoder workerを追加"
git push
```

### Task 15: Finalize worker datasets only at the count gate

**Files:**
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart`
- Modify: `packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

**Interfaces:**
- Consumes: caller-complete descriptor and cumulative worker state.
- Produces: final transfer only when unique count equals `descriptor.expectedFeatureCount` and every chunk validates.

- [ ] **Step 1: Add failing finish-gate tests**

Test expected counts smaller and larger than unique decoded count, expected zero with no rows, raw count greater than expected only because of identical boundary copies, schema mismatch at finish, and an invalid chunk injected through a test factory. Assert no transfer materializes on a failing gate.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

Expected: count/schema cases do not yet return the specified typed failure.

- [ ] **Step 3: Put all gates before TTD creation**

Run Task 5 descriptor validation again inside worker initialization, compare the final unique count, validate every built chunk, sum chunk lengths with checked integer arithmetic, and compare that sum to both accumulator count and descriptor count. Only then construct `SeismicityDatasetTransfer`. A mismatch throws `featureCountMismatch`; no partial dataset is returned.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart`

Expected: only complete, exact-count datasets transfer.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_decoder_worker_test.dart
git commit -m "Feat: 震源unique件数gateを追加"
git push
```

### Task 16: Expose an owning archive decode operation

**Files:**
- Create: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state.dart`
- Modify generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state.freezed.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_test.dart`

**Interfaces:**
- Consumes: an already-open `SeismicityPmTilesArchive`, complete descriptor, positive chunk capacity.
- Produces: exported synchronous `SeismicityPmTilesDecoder.start(...) -> SeismicityPmTilesDecodeOperation`; operation exposes `Future<SeismicityPmTilesResult<SeismicityPmTilesDataset>> result`, `Stream<SeismicityPmTilesLoadState> states`, and `Future<void> cancel()`.

- [ ] **Step 1: Write a failing fake-archive operation test**

The fake archive yields two occupied tile IDs at the descriptor zoom and tracks enumeration zoom, reads, and close count. Assert states begin with `readingDirectory`, emit `decoding(progress:)` after each worker acknowledgement, then `completed`; result is success and archive close count is exactly one.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_test.dart`

Expected: compile failure for missing decoder/decoding state.

- [ ] **Step 3: Implement streaming traversal and ownership**

Use this public start boundary with no defaults:

```dart
SeismicityPmTilesDecodeOperation start({
  required SeismicityPmTilesArchive archive,
  required SeismicityPmTilesArchiveDescriptor descriptor,
  required int chunkFeatureCapacity,
});
```

Return the operation before worker spawn so an immediate caller cancellation is observable. Schedule its stored run future on the next microtask, validate descriptor before spawning, then iterate `archive.occupiedTileIdsAtZoom(zoom: descriptor.dataZoom)` without collecting a full coordinate grid. Read each expanded tile, wrap exact bytes in TTD, and await worker acknowledgement before the next tile. On finish, materialize and validate the dataset, then return success. Put archive close, worker close, state-controller close, and primary-error preservation in one explicit lifecycle coordinator, not private helper methods.

Add `decoding({required SeismicityPmTilesDecodeProgress progress})` to the load-state union and regenerate.

- [ ] **Step 4: Run GREEN and public compile test**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected: traversal uses descriptor data zoom, returns one complete dataset, and closes once.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_load_state* \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles archive decodeを統合"
git push
```

### Task 17: Build deterministic gzip archive fixtures

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart`
- Create: `packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart`

**Interfaces:**
- Consumes: schema-v1 MVT bytes, PMTiles v3 root entries, none/gzip compression.
- Produces: deterministic in-memory archive bytes plus exact descriptor fields and archive-to-column integration evidence at an explicit non-14 data zoom.

- [ ] **Step 1: Write the failing fixture self-test**

Build a root-only archive with two occupied IDs at zoom 2, two distinct schema-v1 MVT payloads, gzip internal compression, and gzip tile compression. Open through `SeismicityRandomAccessReaderFactory` Asset source and `SeismicityPmTilesArchive`, assert occupied IDs and exact decompressed MVT bytes, then close once. Also build a corrupt truncated variant.

In the archive decoder test, include one explicit depth 0/magnitude 0 row and one row with both values absent. Start the public decoder with explicit chunk capacity 1, await states/result, and assert exact chunks, UUID bytes, coordinates, time, NaN/validity, max-intensity dictionaries, descriptor identity, feature count, and archive close. Add a valid archive containing one malformed MVT tile after one valid tile; it must fail without a partial dataset and close once. This test must compile-fail with the missing fixture builder before any integration adjustment.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart`

Expected: compile failure for missing fixture builder.

- [ ] **Step 3: Implement the minimal PMTiles v3 fixture writer**

Write the exact 127-byte header, delta-varint root directory, metadata `{}`, and tile-data offsets. Set tile type MVT, requested min/max zoom, clustered flag, and none/gzip codes explicitly. Reuse one deterministic top-level varint encoder and `gzip.encode`; do not read external files or network data. Return descriptor values from bytes and caller-supplied schema/data zoom/count/revision rather than defaulting them. Keep `descriptor.dataZoom == 2` through enumeration, TileID inverse, point conversion, worker initialization, and dataset metadata; gzip remains the archive layer's responsibility.

- [ ] **Step 4: Run GREEN**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart`

Expected: strict archive core reads both gzip payloads, the full public pipeline returns two exact typed chunks at data zoom 2, truncation is rejected, and malformed MVT never publishes a partial dataset.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder.dart \
  packages/seismicity_pmtiles/test/support/seismicity_archive_fixture_builder_test.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_archive_test.dart
git commit -m "Test: gzip PMTiles decodeを統合"
git push
```

### Task 18: Lock boundary copies, conflicts, and descriptor counts

**Files:**
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`
- Modify only if RED exposes a defect: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart`

**Interfaces:**
- Consumes: normalized global integer points and UUID exact match.
- Produces: regression coverage for buffered/wrapped tile copies and final unique-count safety.

- [ ] **Step 1: Write adjacent-boundary contract tests**

Place the same UUID in adjacent z2 tiles as local `(4092, 100)` and `(-4, 100)` so both resolve to one global point. With identical properties, assert raw count 2, unique/output count 1, and descriptor count 1 succeeds.

Then vary exactly one of global coordinate, origin time, magnitude presence/value, depth presence/value, or max intensity. Each case must return `duplicateConflict` and no dataset. Include an antimeridian pair whose X differs by one world width and must dedupe after wrapping.

- [ ] **Step 2: Run the focused contract test**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`

Expected: any missing exact-comparison case fails. If every case is already GREEN, keep this task test-only and do not manufacture a production change.

- [ ] **Step 3: Fix only the demonstrated comparison gap**

Compare global integer X/Y and required/optional raw values, not rounded longitude/latitude. Treat NaN only through validity: two absent numeric values match; absent versus explicit NaN is impossible because explicit non-finite input is rejected; absent versus explicit 0 conflicts.

- [ ] **Step 4: Add final count mismatch cases and run GREEN**

For one unique/two raw copies, descriptor expected 2 must fail actual 1. For two unique rows, descriptor expected 1 must fail actual 2. Assert these are `featureCountMismatch`, distinct from duplicate conflict.

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart`

Expected: all exact-copy, conflict, wrap, and count cases pass.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_boundary_dedupe_test.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_dataset_accumulator.dart
git commit -m "Test: 震源境界重複と件数gateを固定"
git push
```

If the production file is unchanged, omit it from `git add`.

### Task 19: Make cancellation and resource retirement race-safe

**Files:**
- Create: `packages/seismicity_pmtiles/test/support/controlled_seismicity_archive.dart`
- Create: `packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_lifecycle_test.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart`

**Interfaces:**
- Consumes: operation `cancel`, archive `close`, worker terminal state.
- Produces: exactly-once retirement and first-terminal-result semantics.

- [ ] **Step 1: Write failing controlled-race tests**

The support archive can pause directory enumeration or `readTile`, records calls, and releases pending work when closed. Cover cancellation before worker spawn completes, during enumeration, during tile read, after worker acknowledgement, during finish, and after completed result. Call `cancel()` twice concurrently. Assert result/state is cancelled for pre-completion cancel, archive close exactly once, worker/ports retired, pending futures complete, and no later completed state appears.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_lifecycle_test.dart`

Expected: at least one race exposes duplicate close, wrong terminal state, or a hanging future.

- [ ] **Step 3: Implement a single terminal lifecycle coordinator**

Use one terminal completer and one memoized close future. Cancellation wins only when requested before a terminal result is chosen; it closes the archive to abort I/O and cancels the worker. Success/failure chooses the result first, then cleanup runs in `finally`. A cleanup failure never replaces an existing decode/cancel failure; a cleanup failure after otherwise successful decode becomes `sourceReadFailed` using `descriptor.source`. Await every cleanup future.

- [ ] **Step 4: Add failure retirement and run GREEN**

Cover worker spawn error, typed tile failure, archive read failure, worker finish failure, and archive close failure. Assert the first authoritative typed failure is preserved and all owned resources retire once.

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_lifecycle_test.dart`

Expected: no test times out; every path has one terminal result and one close.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/test/support/controlled_seismicity_archive.dart \
  packages/seismicity_pmtiles/test/decoder/seismicity_pmtiles_decoder_lifecycle_test.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_pmtiles_decoder.dart \
  packages/seismicity_pmtiles/lib/src/decoder/seismicity_decoder_worker.dart
git commit -m "Fix: decoder取消とarchive終了を直列化"
git push
```

### Task 20: Add the deterministic 2,000,000-feature harness

**Files:**
- Create: `packages/seismicity_pmtiles/benchmark/support/seismicity_benchmark_archive.dart`
- Create: `packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart`
- Create: `packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_test.dart`

**Interfaces:**
- Consumes: public decoder API with an in-memory archive that generates one MVT tile on demand.
- Produces: `runSeismicityDecodeBenchmark({required featureCount, required featuresPerTile, required chunkFeatureCapacity, Duration? informationalTimeThreshold})` and a CLI whose default feature count is exactly 2,000,000 and whose optional time threshold is caller-supplied and non-gating.

- [ ] **Step 1: Write a failing 10,000-feature harness test**

Use fixed data zoom 6 and 1,000 features per tile. Generate canonical UUIDs from the global feature index (`00000000-0000-4000-8000-` plus twelve lowercase hex digits), deterministic local coordinates/properties, and no random/time-derived input. Assert exact requested count, chunk sum, stable first/last UUID, output typed-column byte size, archive close once, exactly one worker spawn, and no retained per-event model collection.

- [ ] **Step 2: Run RED**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_test.dart`

Expected: compile failure for missing benchmark runner/archive.

- [ ] **Step 3: Implement on-demand deterministic tiles and CLI reporting**

The archive yields only occupied TileIDs and constructs each raw MVT payload in `readTile`; it never holds all tile payloads or 2M feature objects simultaneously. The CLI parses only positive integer `--features`, `--features-per-tile`, `--chunk-capacity`, and optional `--informational-time-threshold-ms` arguments. Use `Stopwatch` and `ProcessInfo.currentRss`, and emit one JSON line with `stdout.writeln` containing counts, output typed-column byte size, worker spawn count, elapsed milliseconds, RSS, the caller-supplied threshold when present, and nullable `within_target`.

No elapsed-time or RSS threshold changes the exit code. Correctness failure, OOM/crash, worker spawn count other than one, row/chunk count mismatch, typed-column byte-size mismatch, invalid columns, or close count other than one does change it. Issue #1601 defines no performance SLO, so the harness must not invent a default threshold; CI or the operator may supply a comparison value explicitly and records it as evidence only.

- [ ] **Step 4: Run the small GREEN test and full harness**

Run: `mise exec -- dart test packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_test.dart`

Run: `mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 --informational-time-threshold-ms 60000`

Expected: both exit 0; the CLI reports exactly 2,000,000 unique/output features and whether the observed time is within the supplied 60-second comparison value. Record elapsed/RSS and the boolean as observations only; crossing the time threshold is not a failure.

- [ ] **Step 5: Commit and push**

```bash
git add packages/seismicity_pmtiles/benchmark \
  packages/seismicity_pmtiles/test/benchmark/seismicity_pmtiles_decode_benchmark_test.dart
git commit -m "Perf: 200万震源decoder harnessを追加"
git push
```

### Task 21: Document and verify the decoder stack layer

**Files:**
- Modify: `packages/seismicity_pmtiles/README.md`
- Create: `docs/knowledge/20260809_seismicity_pmtiles_decoder.md`
- Create: `docs/todo/950_seismicity_manifest_descriptor_fields.md`
- Modify generated files only through build_runner/normalization if reproduction requires it.

**Interfaces:**
- Consumes: all completed public APIs and verification evidence.
- Produces: current package usage, schema/ownership rules, explicit backend dependency, and a clean reviewed branch.

- [ ] **Step 1: Write current public documentation**

README must show a complete caller-owned flow: app/backend adapter supplies every descriptor field, Factory opens a reader, archive opens, decoder starts with explicit chunk capacity, operation states/result are consumed, and cancel is available. State plainly that decoder owns and closes the archive. Document strict schema v1, exact duplicate behavior, NaN+validity, max-intensity dictionary, no 1/14 fallback, TTD worker, and no partial dataset on failure.

The knowledge file records the same invariants plus these reproducible commands:

```bash
mise exec -- dart test packages/seismicity_pmtiles/test
mise exec -- dart run packages/seismicity_pmtiles/benchmark/seismicity_pmtiles_decode_benchmark.dart \
  --features 2000000 --features-per-tile 1000 --chunk-capacity 65536 \
  --informational-time-threshold-ms 60000
```

The todo names the missing public manifest fields `schema_version`, `data_zoom`, and `archive_revision`, requires a separate backend stacked PR/OpenAPI regeneration before app integration, and explicitly forbids deriving them as 1/14/URL values.

- [ ] **Step 2: Regenerate and normalize deterministically**

Run:

```bash
(
  set -eu
  generated='packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart'
  scratch=$(mktemp -d)
  (cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
  cp -- "$generated" "$scratch/before.dart"
  perl -0pi -e 's{(class SeismicityPmTilesNetworkRequestFailedException\b.*?)(?=\nclass SeismicityPmTilesTileNotFoundException\b)}{my $block = $1; $block =~ s/[ \t]+$//mg; $block}gse' "$generated"
  git diff --no-index --exit-code --ignore-space-at-eol "$scratch/before.dart" "$generated"
  rm -r -- "$scratch"
)
```

Expected: the comparison proves normalization changes only line-end whitespace. Inspect every generated semantic diff against its source annotation.

- [ ] **Step 3: Run the full fresh verification gate**

Run every command from repository root:

```bash
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

- [ ] **Step 4: Audit scope and source rules**

Run:

```bash
if rg -n "\bdynamic\b|\bObject\??\b|print\(|\.\./src/|defaultDataZoom|defaultSchemaVersion" \
  packages/seismicity_pmtiles/lib packages/seismicity_pmtiles/benchmark \
  -g '*.dart' -g '!*.freezed.dart' -g '!*.g.dart'; then
  exit 1
fi
if rg -n "flutter_scene|package:flutter|MapLibre|Shader|Gpu|GPU" \
  packages/seismicity_pmtiles/lib; then
  exit 1
fi
git --no-pager diff --name-only feat/seismicity-pmtiles-network-reader...HEAD
```

Expected: no prohibited source hit in new decoder/benchmark code and no Scene/app/UI file in the diff. Review dependency source separately; this source audit applies to EQMonitor-authored code.

- [ ] **Step 5: Commit docs/generated normalization and push**

```bash
git diff --exit-code -- packages/seismicity_pmtiles/lib/src/model
git add packages/seismicity_pmtiles/README.md \
  docs/knowledge/20260809_seismicity_pmtiles_decoder.md \
  docs/todo/950_seismicity_manifest_descriptor_fields.md
git commit -m "Docs: 震源PMTiles decoder契約を記録"
git push
```

The model diff command must be clean; generated changes belong to their source task and must not be swept into the docs commit. Finish with `git status --short --branch`, `git rev-list --left-right --count HEAD...@{u}`, and a whole-branch review against `feat/seismicity-pmtiles-network-reader`; resolve every Critical/Important finding before stacking.

## Completion Checklist

- [ ] TileID inverse round-trips through public `pmtiles_v3` API.
- [ ] Descriptor schema/data zoom are caller-required and never replaced by 1/14.
- [ ] Raw MVT protobuf, layer, Point command, tags, scalar types, UUID, and properties are strict.
- [ ] Missing depth/magnitude are NaN plus clear validity, while explicit zero remains valid.
- [ ] Identical boundary/wrap copies dedupe; conflicting UUID copies reject the entire dataset.
- [ ] Returned data is bounded typed chunks, not 2M Freezed/event objects.
- [ ] One long-lived worker receives and returns TTD; archive/GPU/UI remain outside it.
- [ ] Unique count and descriptor count match before any dataset is published.
- [ ] Cancel/success/failure close archive and worker exactly once.
- [ ] Gzip archive fixture and malformed schema/archive fixtures pass/fail as specified.
- [ ] Deterministic 2M harness exits 0 with exact count; time/RSS remain observations.
- [ ] Backend manifest drift is documented as a separate stacked dependency.
- [ ] No #1600 I/O reimplementation and no #1602 Scene/projection/GPU code is present.

## References

- [PMTiles v3 specification and reference implementation](https://github.com/protomaps/PMTiles)
- [`vector_tile` 4.0.0 public package API](https://pub.dev/packages/vector_tile)
- [`bdero/dashmap` typed worker examples](https://github.com/bdero/dashmap)
- [`ingen084/KyoshinEewViewerIngen` point cache and layer reference](https://github.com/ingen084/KyoshinEewViewerIngen)
