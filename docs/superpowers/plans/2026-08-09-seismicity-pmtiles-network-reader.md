# Seismicity PMTiles Network Reader Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `seismicity_pmtiles` に、Dio の検証済み HTTP byte-range だけを使って PMTiles を random access する Network reader を追加する。

**Architecture:** `pmtiles_v3` は `PmTilesRandomAccessReader` と File/Asset 実装を維持する純 Dart core とし、Dio、HTTP 応答検証、ETag 世代、range LRU、request lifecycle は `seismicity_pmtiles` の data-side reader に閉じ込める。Factory は既存の File/Asset 分岐を同じ reader interface のまま保持し、Network source だけに descriptor の期待ファイル長、Dio、byte budget、CancelToken を渡す。

**Tech Stack:** Dart 3.11 / Flutter 3.44 / Dio / Freezed / build_runner / package:test / EQMonitor workspace lint

## Global Constraints

- 変更対象は Issue #1600 の Network PMTiles reader、公開契約、unit test、依存宣言だけとし、manifest 取得、MVT decode、アプリ UI、実機・E2E は後続 Issue に残す。
- `packages/pmtiles_v3` に Dio 依存や HTTP 実装を追加しない。`PmTilesRandomAccessReader` の `sizeBytes`、`readAt`、`close` 契約は維持する。
- Network request は `GET`、`Range: bytes=<offset>-<inclusiveEnd>`、`ResponseType.bytes` で行い、status `206` 以外、とくに `200 OK` 全文応答を受理しない。
- 最初に成功した response の weak ではない ETag を archive identity として固定し、その後の request に完全一致の `If-Match` を送る。`412`、ETag 欠落、weak ETag、ETag 変更は archive 世代変更として失敗させる。
- `Content-Range` は要求 offset、inclusive end、descriptor の `expectedSizeBytes` と一致し、body length は要求 length と一致しなければならない。範囲外の read は request を発行せず既存の typed invalid-range failure にする。
- cache key は archive URI、固定 strong ETag、offset、length とする。LRU は aggregate cached-byte budget を超えず、同一 key の同時 read は同一 in-flight Future を共有する。
- `CancelToken` の cancel と `close()` は未完了 Dio request を止め、新しい read を拒否し、close の重複呼び出しは同じ Future を返す。Network source は Asset loader や全 archive load へ fallback しない。
- public failure は `SeismicityPmTilesException` の Freezed union で表す。Dio exception、HTTP protocol failure、archive generation change、cancellation を生の `DioException` や response data として公開しない。
- `dynamic`、`Object`、null-assertion、private helper method を新規 Dart production code に使わない。小さな public/internal responsibility classes と named arguments で分離する。
- Dio 追加は手編集ではなく `(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)` で行う。生成コードは `mise exec -- dart run build_runner build --delete-conflicting-outputs` で更新する。
- 全 Network test は `HttpClientAdapter` の mock response だけを使い、実ネットワーク、device、simulator、E2E を使わない。

---

## File Structure

| File | Responsibility |
|---|---|
| `packages/seismicity_pmtiles/pubspec.yaml` | `dio` を package dependency として解決する。lockfile は pub command の出力だけを commit する。 |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart` | transport/protocol/generation/cancellation の source-aware typed failures を追加する。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart` | Dio Range request、strict response validation、fixed ETag、bounded LRU、in-flight sharing、CancelToken と close lifecycle を実装する。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart` | descriptor を入力にし、Network source を上記 reader、File/Asset を既存 reader に route する。 |
| `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart` | Network reader を barrel の明示的 public API として export する。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart` | mock adapter による request/header/protocol/ETag/cache/in-flight/cancel/close の unit test を置く。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart` | factory の Network wiring と File/Asset no-regression を確認する。 |
| `packages/seismicity_pmtiles/test/model/public_contracts_test.dart` | 新規 Freezed failure case の exhaustive switch を更新する。 |
| `packages/seismicity_pmtiles/test/public_api_compile_test.dart` | barrel から Network reader と constructor contract を compile できることを確認する。 |

## Public Interfaces

```dart
final class SeismicityPmTilesNetworkRandomAccessReader
    implements PmTilesRandomAccessReader {
  SeismicityPmTilesNetworkRandomAccessReader({
    required Dio dio,
    required SeismicityPmTilesNetworkSource source,
    required int sizeBytes,
    required int maxCacheBytes,
    required CancelToken cancelToken,
  });

  @override
  int get sizeBytes;

  @override
  Future<Uint8List> readAt({required int offset, required int length});

  @override
  Future<void> close();
}

final class SeismicityRandomAccessReaderFactory {
  const SeismicityRandomAccessReaderFactory({
    required SeismicityPmTilesAssetLoader assetLoader,
    required Dio dio,
    required int networkMaxCacheBytes,
  });

  Future<SeismicityPmTilesResult<PmTilesRandomAccessReader>> create({
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required CancelToken cancelToken,
  });
}
```

`SeismicityPmTilesException` adds these cases; `source` is always the descriptor's source:

```dart
const factory SeismicityPmTilesException.networkRequestFailed({
  required SeismicityPmTilesSource source,
  required int? statusCode,
}) = SeismicityPmTilesNetworkRequestFailedException;

const factory SeismicityPmTilesException.invalidNetworkResponse({
  required SeismicityPmTilesSource source,
  required int statusCode,
  required String reason,
}) = SeismicityPmTilesInvalidNetworkResponseException;

const factory SeismicityPmTilesException.archiveChanged({
  required SeismicityPmTilesSource source,
  required String expectedEtag,
  required String? receivedEtag,
  required int statusCode,
}) = SeismicityPmTilesArchiveChangedException;

const factory SeismicityPmTilesException.cancelled({
  required SeismicityPmTilesSource source,
}) = SeismicityPmTilesCancelledException;
```

The implementation treats only an ETag that is nonempty and does not start with `W/` as strong. `Content-Range` accepts exactly `bytes <start>-<end>/<total>` with decimal non-negative values, `end >= start`, and no extra characters. It must not use a permissive parser or a response-provided total as a replacement for descriptor metadata.

### Task 1: Add the Network reader dependency and typed public contract

**Files:**

- Modify: `packages/seismicity_pmtiles/pubspec.yaml`
- Modify: workspace `pubspec.lock` only as generated by `flutter pub add`
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Modify: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

**Interfaces:**

- Consumes: existing `SeismicityPmTilesNetworkSource`, `PmTilesRandomAccessReader`, `SeismicityPmTilesResult<T>`.
- Produces: the four Network-specific `SeismicityPmTilesException` variants used by Tasks 2–4.

- [ ] **Step 1: Write the failing public-contract tests**

Add the four variants to the existing exhaustive exception list.

```dart
const source = SeismicityPmTilesSource.network(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);
const failures = <SeismicityPmTilesException>[
  SeismicityPmTilesException.networkRequestFailed(
    source: source,
    statusCode: 503,
  ),
  SeismicityPmTilesException.invalidNetworkResponse(
    source: source,
    statusCode: 206,
    reason: 'Content-Range does not match the requested range.',
  ),
  SeismicityPmTilesException.archiveChanged(
    source: source,
    expectedEtag: '"v1"',
    receivedEtag: '"v2"',
    statusCode: 206,
  ),
  SeismicityPmTilesException.cancelled(source: source),
];
```

- [ ] **Step 2: Run the contract tests to verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected: FAIL because the Network-specific exception variants do not exist.

- [ ] **Step 3: Add Dio through pub and declare the typed cases**

Run exactly:

```bash
(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)
```

Add the four `const factory` declarations above to `SeismicityPmTilesException` and regenerate Freezed code. Do not add Dio to `pmtiles_v3`; Task 2 adds the Network reader only when its complete strict-protocol behavior and tests are added together.

- [ ] **Step 4: Generate contracts and run GREEN**

Run:

```bash
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart
```

Expected: PASS; every `SeismicityPmTilesException` switch remains exhaustive and only `seismicity_pmtiles` depends on Dio.

- [ ] **Step 5: Commit the contract slice**

```bash
git add packages/seismicity_pmtiles/pubspec.yaml pubspec.lock \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart \
  packages/seismicity_pmtiles/test/model/public_contracts_test.dart
git commit -m "Feat: PMTiles通信Readerの公開契約を追加"
```

### Task 2: Enforce one validated range response and pin the archive generation

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:**

- Consumes: `Dio.get<Uint8List>`, `SeismicityPmTilesNetworkSource`, `PmTilesV3RangeValidator`, and the Task 1 typed failures.
- Produces: `readAt({required int offset, required int length}) -> Future<Uint8List>` that sends exactly one validated range request before cache/in-flight behavior is introduced in Task 3.

- [ ] **Step 1: Write failing strict-protocol tests using a recording mock adapter**

Define a test-only `HttpClientAdapter` with typed `List<RequestOptions> requests` and a response queue. Each response uses `ResponseBody.fromBytes` and explicit headers; no socket is opened. Add these literal cases:

```dart
test('pins a strong ETag and sends the exact first range request', () async {
  final bytes = await reader.readAt(offset: 4, length: 3);
  expect(bytes, orderedEquals([4, 5, 6]));
  expect(adapter.requests.single.headers['Range'], 'bytes=4-6');
  expect(adapter.requests.single.responseType, ResponseType.bytes);
  expect(adapter.requests.single.headers.containsKey('If-Match'), isFalse);
});

test('uses the pinned ETag as If-Match on the second uncached range', () async {
  await reader.readAt(offset: 0, length: 2);
  await reader.readAt(offset: 2, length: 2);
  expect(adapter.requests[1].headers['If-Match'], '"archive-v1"');
});
```

Add one test each that expects `SeismicityPmTilesInvalidNetworkResponseException` for: status `200`; status `204`; missing ETag on the first `206`; `W/"archive-v1"`; missing `Content-Range`; `bytes 5-7/16` for requested `4..6`; `bytes 4-7/16`; `bytes 4-6/15`; malformed `Content-Range`; and a 2-byte body for requested length 3. Add one test each that expects `SeismicityPmTilesArchiveChangedException` for status `412`, changed strong ETag, and missing ETag after identity was pinned. Each assertion verifies source, expected/received ETag where applicable, and status code.

- [ ] **Step 2: Run the strict-protocol tests to verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart --plain-name "pins a strong ETag and sends the exact first range request"`

Expected: FAIL because `readAt` is not implemented.

- [ ] **Step 3: Implement the request and validation collaborators**

Keep request construction and response validation in focused non-private classes in the same reader directory. Their behavior is equivalent to this code and must not inspect `Response.data` as `dynamic`:

```dart
final response = await dio.get<Uint8List>(
  source.archiveUri.toString(),
  options: Options(
    headers: <String, String>{
      'Range': 'bytes=$offset-${offset + length - 1}',
      if (pinnedEtag != null) 'If-Match': pinnedEtag,
    },
    responseType: ResponseType.bytes,
    validateStatus: (status) => status != null && status >= 200 && status < 500,
  ),
  cancelToken: cancelToken,
);
```

Validate `offset + length - 1` only after `PmTilesV3RangeValidator` accepts the range. Require status 206 before reading headers. Parse exactly `bytes <start>-<end>/<total>`; require `start == offset`, `end == offset + length - 1`, `total == sizeBytes`, and `response.data?.length == length`. Pin the first strong ETag only after every response check passes. Translate `DioExceptionType.cancel` and an already-cancelled token to `cancelled`; translate all other Dio transport errors to `networkRequestFailed` with `error.response?.statusCode`; do not leak the exception text.

Create the complete public `SeismicityPmTilesNetworkRandomAccessReader` constructor shown above, export it from `seismicity_pmtiles.dart`, and add the same constructor call to `public_api_compile_test.dart`. The class must have working `readAt` and idempotent `close` behavior in this task; do not commit a throwing or skeletal reader.

- [ ] **Step 4: Run all strict-protocol tests to verify GREEN**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected: PASS; every rejected response produces a typed failure and never returns body bytes.

- [ ] **Step 5: Commit the protocol slice**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/lib/seismicity_pmtiles.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles通信Range応答を厳密検証"
```

### Task 3: Add byte-bounded LRU, in-flight deduplication, cancellation, and close semantics

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

**Interfaces:**

- Consumes: Task 2's validated range fetch and its pinned `"etag"` archive identity.
- Produces: the same `readAt` and `close` signatures with LRU/in-flight/lifecycle semantics; callers do not receive a cache or request coordinator type.

- [ ] **Step 1: Write failing cache, concurrency, cancellation, and close tests**

Use the mock adapter's `Completer<ResponseBody>` to hold a request open. Add these literal tests:

```dart
test('returns a cache hit without a second request for same identity offset and length', () async {
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(1));
});

test('deduplicates concurrent reads of one range', () async {
  final first = reader.readAt(offset: 0, length: 3);
  final second = reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(1));
  adapter.completeNext(body: [0, 1, 2]);
  expect(await Future.wait([first, second]), everyElement(orderedEquals([0, 1, 2])));
});
```

With `maxCacheBytes: 5`, fetch ranges `(0, 3)` then `(3, 2)`, touch `(0, 3)`, then fetch `(5, 3)` and assert range `(3, 2)` was evicted while `(0, 3)` remains a hit; assert cached bytes never exceed 5. Add a different-ETag fixture and assert it cannot read a prior archive's entry. Add cancellation tests for: caller `CancelToken.cancel()` while adapter is pending returns `SeismicityPmTilesCancelledException`; `close()` cancels the pending request and causes its Future to fail with that same type; read after close fails without a request; concurrent `close()` calls return the identical Future; and a completed cache hit after close is rejected rather than returned.

- [ ] **Step 2: Run one concurrency test to verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart --plain-name "deduplicates concurrent reads of one range"`

Expected: FAIL because two requests are issued or the pending request is not shared.

- [ ] **Step 3: Implement bounded lifecycle-safe state**

Create immutable key/value records and focused state classes rather than `Map<String, Object>`. The key contains `Uri archiveUri`, `String etag`, `int offset`, `int length`; an access-ordered `LinkedHashMap` retains values and subtracts `Uint8List.length` before each eviction. A value larger than `maxCacheBytes` is returned but never cached, so the aggregate budget remains exact.

Store one `Future<Uint8List>` per key in an in-flight map before awaiting it, and remove it in `whenComplete`. Before ETag pinning, use an equivalent pending key with the requested URI/offset/length and promote only the successfully validated bytes to the ETag key; no cache entry exists without an identity. `close` sets the closed state first, calls `cancelToken.cancel('PMTiles reader closed')`, waits for the currently tracked futures to settle, clears in-flight and LRU state, and memoizes that Future. Every read checks closed/cancelled state before both LRU lookup and request creation.

- [ ] **Step 4: Run cache/lifecycle tests to verify GREEN**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected: PASS; one key has one request, LRU eviction respects aggregate bytes, and close/cancel leaves no reusable range or active future.

- [ ] **Step 5: Commit the lifecycle slice**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信ReaderのLRUと取消を追加"
```

### Task 4: Route descriptors through the Factory and protect File/Asset behavior

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:**

- Consumes: Task 3 Network reader, `SeismicityPmTilesArchiveDescriptor`, existing File/Asset readers.
- Produces: `create({required descriptor, required cancelToken})`, returning `SeismicityPmTilesResult<PmTilesRandomAccessReader>` for all three source variants.

- [ ] **Step 1: Write failing factory tests**

Replace source-only calls with descriptor/cancel-token calls. Add a Network descriptor with `expectedSizeBytes: 16` and assert the success value is `SeismicityPmTilesNetworkRandomAccessReader`, its `sizeBytes` is 16, the asset loader has not run, and no request occurs until `readAt`. Add invalid Network `expectedSizeBytes: 0` and `networkMaxCacheBytes: 0` cases, each asserting `SeismicityPmTilesInvalidDescriptorException` without an adapter request. Keep and update the existing File reader, Asset single-load, missing-file, and asset-loader-failure tests; assert they use the same returned implementation types and never call the network adapter.

- [ ] **Step 2: Run factory tests to verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`

Expected: FAIL because Factory still accepts only `source` and rejects Network.

- [ ] **Step 3: Implement descriptor-aware routing**

Make Factory constructor require `assetLoader`, `dio`, and `networkMaxCacheBytes`. Make `create` require `descriptor` and `cancelToken`. For `SeismicityPmTilesNetworkSource`, validate positive `descriptor.expectedSizeBytes` and positive `networkMaxCacheBytes`, then return a Network reader without performing HTTP. For File and Asset, retain exactly the current open/typed `PmTilesV3Exception` translation behavior; descriptor metadata is not a substitute for their readers' own size/read validation. Never call `assetLoader` for Network.

- [ ] **Step 4: Run Factory and File/Asset regression tests to verify GREEN**

Run:

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart
mise exec -- flutter test packages/pmtiles_v3/test/reader/pmtiles_v3_file_random_access_reader_test.dart packages/pmtiles_v3/test/reader/pmtiles_v3_asset_random_access_reader_test.dart
```

Expected: PASS; the three sources share only the random-access interface, File/Asset behavior is unchanged, and Network has no full-load fallback.

- [ ] **Step 5: Commit the Factory integration slice**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles通信ReaderをFactoryへ接続"
```

### Task 5: Run the package gate and perform the focused PR review

**Files:**

- Verify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Verify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Verify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Verify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`
- Verify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Verify: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`
- Verify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:**

- Consumes: the Task 1–4 public contract and all mock-adapter tests.
- Produces: a clean, generated, formatter- and analyzer-verified Network reader PR with no application integration.

- [ ] **Step 1: Add final literal regression cases before the full gate**

Ensure the Network test file has separate named tests for all of the following: zero/negative/out-of-file range produces `SeismicityPmTilesInvalidRangeException` and no request; inclusive end is `offset + length - 1`; safe `206` exact body succeeds; unsafe `200` cannot populate LRU; status `412` and changed ETag cannot populate LRU; transport `DioException` is `networkRequestFailed`; `DioExceptionType.cancel` is `cancelled`; and no test creates a real `HttpClient`.

- [ ] **Step 2: Run the complete focused test suite**

Run:

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test
mise exec -- flutter test packages/pmtiles_v3/test
```

Expected: PASS; all File/Asset/core tests and every mocked Network protocol/lifecycle test pass.

- [ ] **Step 3: Format, analyze, regenerate, and repeat tests**

Run:

```bash
mise exec -- dart format --set-exit-if-changed packages/seismicity_pmtiles
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
mise exec -- dart analyze packages/seismicity_pmtiles
mise exec -- flutter test packages/seismicity_pmtiles/test
git diff --check
```

Expected: every command exits 0 and generated Freezed files match source contracts.

- [ ] **Step 4: Review Issue #1600 boundaries before commit**

Confirm the diff contains no `app/` source change, no manifest fetch, no MVT decoder, no `pmtiles_v3` Dio dependency, no Asset fallback from Network, no `200` acceptance, and no unbounded cache. Compare `bdero/dashmap` only for general cache organization; the Issue #1600 requirements and this repository's reader contracts are authoritative.

- [ ] **Step 5: Commit the verified implementation**

```bash
git add packages/seismicity_pmtiles pubspec.lock
git commit -m "Feat: 震源PMTiles通信Readerを追加"
```

## Plan Self-Review

- Coverage: Task 2 covers Dio Range/206/Content-Range/body-length/strong-ETag/If-Match/412; Task 3 covers byte-bounded LRU, in-flight dedupe, cancellation and close; Task 4 covers all source routing and File/Asset preservation; Task 5 makes mocked tests and no-real-network verification explicit.
- Scope: no app manifest adapter, decoder, Scene, UI, real-network, device, simulator, or E2E work is introduced; these remain #1601 and later stack layers.
- Type consistency: all `readAt` callers use `Future<Uint8List>`, Factory takes `SeismicityPmTilesArchiveDescriptor` plus `CancelToken`, and all public failures are named `SeismicityPmTilesException` union cases.
- Placeholder check: no deferred implementation marker, unspecified test, or implicit validation step remains; each rejection condition and verification command is literal.

## Execution Handoff

Plan complete and saved to `docs/superpowers/plans/2026-08-09-seismicity-pmtiles-network-reader.md`. The implementation should use `superpowers:subagent-driven-development` task-by-task with reviewer gates because this is a safety-sensitive protocol boundary.
