# Seismicity PMTiles Network Reader Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `seismicity_pmtiles` に、Dio の検証済み HTTP byte-range だけで PMTiles を random access する Network reader を追加する。

**Architecture:** `pmtiles_v3` は HTTP を知らない pure-Dart core とし、既存 range validator だけを public barrel へ公開する。`seismicity_pmtiles` は request construction、HTTP identity、Content-Range/body validation、bounded LRU、in-flight coordination、cancellation、terminal generation state を focused collaborators に分ける。Network concrete reader は private とし、public Factory が既存 `PmTilesRandomAccessReader` interface で返す。

**Tech Stack:** Dart 3.11 / Flutter 3.44 / Dio / Freezed / build_runner / package:test / EQMonitor workspace lint

## Global Constraints

- Issue #1600 の Network reader、typed failures、Factory wiring、unit tests、依存宣言だけを変更する。manifest fetch、EQMonitor API conversion、MVT decode、app UI、real network、device、simulator、E2E は対象外。
- `packages/pmtiles_v3` に Dio/HTTP code を追加しない。`PmTilesRandomAccessReader` と File/Asset behavior は維持する。
- `PmTilesV3RangeValidator` は `package:pmtiles_v3/pmtiles_v3.dart` から export する。`package:pmtiles_v3/src/...` import は追加しない。
- Request は `GET`、`Range: bytes=<offset>-<inclusiveEnd>`、`ResponseType.bytes`。Dio `validateStatus` は `200 <= status < 500` の response を protocol validator へ渡す。validator は `206` だけ成功、`412` は generation failure、その他は typed protocol failure。`500+`/transport failure は typed network failure。
- Strong ETag は RFC entity-tag の `"` + etagc* + `"`。etagc は `0x21`、`0x23..0x7e`、`0x80..0xff`。`*`、`W/`、unquoted、inner quote、control、`0xff` 超 code unit は拒否する。
- 最初の fully validated `206` strong ETag を archive identity として固定し、後続 request に同じ `If-Match` を送る。identity 未確立時の異なる range は最初の request 完了を待つ。
- `412`、ETag missing/malformed/changed は terminal generation poison。最初の typed failure を保存し、LRU clear、peer in-flight cancel、future reads で同じ subtype/fields を再送出する。
- `Content-Range` は `bytes <start>-<end>/<total>` 完全一致。start/end/total と request/descriptor を照合し、body length も request length と一致させる。unsafe `200` の body は返さず cache しない。
- LRU key は archive URI、fixed strong ETag、offset、length。aggregate cached bytes は injected positive budget 以下。oversize value は返すが cache しない。
- Same-key concurrent reads は同じ Future を共有する。
- Caller `CancelToken` は authoritative Issue #1600 の「未完了 request 停止」に限定する non-terminal signal。cancel 時点の owned Dio request token だけを cancel し、その read は `SeismicityPmTilesCancelledException`。cache/ETag/reader は保持し、後続 `readAt` は利用可能。
- Evidence: Issue #1600 requirement 7 and design lines 120–126 say only that Dio `CancelToken` stops unfinished requests; terminal whole-reader failure is separately specified only for `412`/ETag change at design line 124. Therefore caller cancel is not promoted to generation poison.
- `close()` is terminal `SeismicityPmTilesClosedException`: cancel active owned tokens, reject future reads before cache lookup, await active Futures regardless of their failure, return one memoized successful close Future。
- Public failures are Freezed `SeismicityPmTilesException`; do not expose raw `DioException`, response body, or exception strings。
- New production code must not use declared `dynamic`, `Object`, null assertion, or class-private methods. Private concrete reader class is allowed; logic lives in focused collaborator classes with named arguments。
- Add Dio only with `(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)`. Generate with `mise exec -- dart run build_runner build --delete-conflicting-outputs`。
- Each logical commit targets about 30–100 hand-written lines; generated Freezed output stays with its contract commit. Include push after each future implementation commit, but do not push while editing this plan。

---

## Final Public Interfaces

```dart
abstract interface class PmTilesRandomAccessReader {
  int get sizeBytes;
  Future<Uint8List> readAt({required int offset, required int length});
  Future<void> close();
}

final class SeismicityRandomAccessReaderFactory {
  SeismicityRandomAccessReaderFactory({
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

Factory returns `invalidDescriptor` without HTTP when Network `expectedSizeBytes <= 0` or `networkMaxCacheBytes <= 0`; invalid callers cannot instantiate the private Network reader。

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
  required String? expectedEtag,
  required String? receivedEtag,
  required int statusCode,
}) = SeismicityPmTilesArchiveChangedException;

const factory SeismicityPmTilesException.cancelled({
  required SeismicityPmTilesSource source,
}) = SeismicityPmTilesCancelledException;

const factory SeismicityPmTilesException.closed({
  required SeismicityPmTilesSource source,
}) = SeismicityPmTilesClosedException;
```

## Final File Map

| File | Responsibility |
|---|---|
| `packages/pmtiles_v3/lib/pmtiles_v3.dart` | Existing range validator public export。 |
| `packages/pmtiles_v3/test/public_api_compile_test.dart` | Export compile test。 |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart` | Network/lifecycle failures。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart` | Range/If-Match/bytes/validateStatus Options。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_identity_validator.dart` | Status 206/412 and ETag grammar/equality。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_content_range_validator.dart` | Content-Range and body length。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart` | Private reader, LRU, in-flight, cancellation/lifecycle。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart` | Public source routing boundary。 |
| `packages/seismicity_pmtiles/test/support/network_range_test_support.dart` | Typed, socket-free adapter and descriptors。 |
| `packages/seismicity_pmtiles/test/reader/*_test.dart` | Focused literal/table-driven tests。 |

### Task 1: Export the existing PMTiles range validator

**Files:**

- Modify: `packages/pmtiles_v3/lib/pmtiles_v3.dart`
- Create: `packages/pmtiles_v3/test/public_api_compile_test.dart`

**Interfaces:** Existing `PmTilesV3RangeValidator.validate({offset, length, sizeBytes})` becomes available from the public barrel; no implementation change。

- [ ] **Step 1: Write RED compile test**

```dart
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:test/test.dart';

void main() {
  test('range validator is public', () {
    expect(
      () => const PmTilesV3RangeValidator().validate(
        offset: 15,
        length: 2,
        sizeBytes: 16,
      ),
      throwsA(isA<PmTilesV3InvalidRangeException>()),
    );
  });
}
```

Run: `mise exec -- dart test packages/pmtiles_v3/test/public_api_compile_test.dart`

Expected RED: compile FAIL because the barrel does not export `PmTilesV3RangeValidator`。

- [ ] **Step 2: Export, verify, commit, push**

```dart
export 'src/reader/pmtiles_v3_range_validator.dart'
    show PmTilesV3RangeValidator;
```

```bash
mise exec -- dart test packages/pmtiles_v3/test/public_api_compile_test.dart
git add packages/pmtiles_v3/lib/pmtiles_v3.dart packages/pmtiles_v3/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles範囲検証を公開"
git push -u origin feat/seismicity-pmtiles-network-reader
```

Expected GREEN: PASS。

### Task 2: Add Dio and typed Network failures

**Files:**

- Modify through pub: `packages/seismicity_pmtiles/pubspec.yaml`, root `pubspec.lock`
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Modify generated: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart`
- Modify: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

**Interfaces:** Produces the five exact Freezed cases in Final Public Interfaces。

- [ ] **Step 1: Write RED union test**

```dart
final source = SeismicityPmTilesSource.network(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);
final failures = <SeismicityPmTilesException>[
  SeismicityPmTilesException.networkRequestFailed(source: source, statusCode: 503),
  SeismicityPmTilesException.invalidNetworkResponse(
    source: source,
    statusCode: 200,
    reason: 'Expected HTTP 206 Partial Content.',
  ),
  SeismicityPmTilesException.archiveChanged(
    source: source,
    expectedEtag: '"v1"',
    receivedEtag: '"v2"',
    statusCode: 206,
  ),
  SeismicityPmTilesException.cancelled(source: source),
  SeismicityPmTilesException.closed(source: source),
];
expect(failures, everyElement(isA<Exception>()));
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected RED: compile FAIL because all five constructors are undefined。

- [ ] **Step 2: Add dependency/contracts, generate, verify, commit, push**

```bash
(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart
git add packages/seismicity_pmtiles/pubspec.yaml pubspec.lock \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart \
  packages/seismicity_pmtiles/test/model/public_contracts_test.dart
git commit -m "Feat: PMTiles通信失敗の型を追加"
git push origin HEAD
```

Expected GREEN: PASS with exhaustive switches。Generated output may exceed 100 lines; hand-written contract remains one logical change。

### Task 3: Create the typed mock adapter support

**Files:**

- Create: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Create: `packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

**Interfaces:**

```dart
final class NetworkRangeTestAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = <RequestOptions>[];
  void enqueueResponse({required int statusCode, required List<int> body, String? etag, String? contentRange});
  PendingRangeResponse enqueuePending206({required int offset, required int total, required String? etag});
  void enqueueDioFailure({required int? statusCode});
}

final class PendingRangeResponse {
  bool cancelled = false;
  void complete(List<int> bytes);
}
```

The adapter uses a typed `Queue<NetworkRangeReply>`, records `RequestOptions`, returns `ResponseBody.fromBytes`, stores header names as literal `'etag'` and `'content-range'`, and races pending completers against Dio's `cancelFuture`. Empty queue throws `StateError('No queued mock response.')`。

- [ ] **Step 1: Write RED fixture tests**

```dart
test('static response records request and literal headers', () async {
  final adapter = NetworkRangeTestAdapter()
    ..enqueueResponse(
      statusCode: 206,
      body: const [1, 2],
      etag: '"v1"',
      contentRange: 'bytes 0-1/16',
    );
  final options = RequestOptions(path: 'https://example.com/archive.pmtiles');
  final body = await adapter.fetch(options, null, null);
  expect(body.statusCode, 206);
  expect(body.headers['etag'], <String>['"v1"']);
  expect(adapter.requests, <RequestOptions>[options]);
});

test('pending response observes Dio cancellation', () async {
  final adapter = NetworkRangeTestAdapter();
  final pending = adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final cancelled = Completer<void>();
  final fetch = adapter.fetch(
    RequestOptions(path: 'https://example.com/archive.pmtiles'),
    null,
    cancelled.future,
  );
  cancelled.complete();
  await expectLater(fetch, throwsA(isA<DioException>()));
  expect(pending.cancelled, isTrue);
});
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

Expected RED: compile FAIL because `network_range_test_support.dart` and its adapter types do not exist。

- [ ] **Step 2: Implement fixture, verify, commit, push**

Implement the exact interfaces above with `NetworkRangeReply`, `StaticNetworkRangeReply`, `PendingRangeResponse`, and `FailingNetworkRangeReply` classes; each has a typed `resolve({required RequestOptions options, required Future<void>? cancelFuture})`。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git add packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git commit -m "Test: PMTiles通信のmock adapterを追加"
git push origin HEAD
```

Expected GREEN: PASS without opening a socket。

### Task 4: Build byte Range Options and strong ETag grammar

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart`

**Interfaces:**

```dart
final class SeismicityPmTilesHttpRangeRequestBuilder {
  const SeismicityPmTilesHttpRangeRequestBuilder();
  Options build({required int offset, required int length, required int sizeBytes, required String? strongEtag});
}

final class SeismicityPmTilesStrongEtagValidator {
  const SeismicityPmTilesStrongEtagValidator();
  bool isValid({required String value});
}
```

- [ ] **Step 1: Write table-driven RED tests**

```dart
test('builds exact byte Options and admits protocol statuses', () {
  final options = const SeismicityPmTilesHttpRangeRequestBuilder().build(
    offset: 4,
    length: 3,
    sizeBytes: 16,
    strongEtag: '"v1"',
  );
  expect(options.headers?['Range'], 'bytes=4-6');
  expect(options.headers?['If-Match'], '"v1"');
  expect(options.responseType, ResponseType.bytes);
  final validateStatus = options.validateStatus;
  if (validateStatus == null) {
    fail('validateStatus must be configured.');
  }
  expect(<int>[200, 204, 206, 404, 412].map(validateStatus), everyElement(isTrue));
  expect(<int?>[500, null].map(validateStatus), everyElement(isFalse));
});

for (final valid in <String>['""', '"archive-v1"', '"!#~ÿ"']) {
  test('accepts strong ETag $valid', () {
    expect(const SeismicityPmTilesStrongEtagValidator().isValid(value: valid), isTrue);
  });
}
for (final invalid in <String>['*', 'W/"v1"', 'v1', '"v"1"', '"line\nbreak"', '"Ā"']) {
  test('rejects ETag $invalid', () {
    expect(const SeismicityPmTilesStrongEtagValidator().isValid(value: invalid), isFalse);
  });
}
```

```dart
test('rejects an out-of-bounds range before building Options', () {
  expect(
    () => const SeismicityPmTilesHttpRangeRequestBuilder().build(
      offset: 15,
      length: 2,
      sizeBytes: 16,
      strongEtag: null,
    ),
    throwsA(
      isA<PmTilesV3InvalidRangeException>()
          .having((failure) => failure.offset, 'offset', 15)
          .having((failure) => failure.length, 'length', 2)
          .having((failure) => failure.sizeBytes, 'sizeBytes', 16),
    ),
  );
});
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart`

Expected RED: compile FAIL because request-builder file is not created yet。

- [ ] **Step 2: Implement, verify, commit, push**

Builder uses public `PmTilesV3RangeValidator`, `ResponseType.bytes`, headers above, and `validateStatus: (status) => status != null && status >= 200 && status < 500`。ETag validator checks exact quote/code-unit grammar without trimming。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart
git commit -m "Feat: PMTiles通信Range要求を構築"
git push origin HEAD
```

Expected GREEN: PASS, including `412 == true` at Dio Options level。

### Task 5: Validate HTTP status and archive identity

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_identity_validator.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_identity_validator_test.dart`

**Interfaces:**

```dart
final class SeismicityPmTilesHttpIdentityValidator {
  const SeismicityPmTilesHttpIdentityValidator();
  String validate({
    required int statusCode,
    required Headers headers,
    required SeismicityPmTilesNetworkSource source,
    required String? expectedEtag,
  });
}
```

- [ ] **Step 1: Write literal RED tests**

```dart
const validator = SeismicityPmTilesHttpIdentityValidator();
final source = SeismicityPmTilesNetworkSource(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);

test('returns exact strong ETag for 206', () {
  final etag = validator.validate(
    statusCode: 206,
    headers: Headers.fromMap(<String, List<String>>{'etag': <String>['"v1"']}),
    source: source,
    expectedEtag: null,
  );
  expect(etag, '"v1"');
});

test('412 is archiveChanged because validateStatus admitted it', () {
  expect(
    () => validator.validate(
      statusCode: 412,
      headers: Headers.fromMap(<String, List<String>>{'etag': <String>['"v2"']}),
      source: source,
      expectedEtag: '"v1"',
    ),
    throwsA(
      isA<SeismicityPmTilesArchiveChangedException>()
          .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
          .having((failure) => failure.receivedEtag, 'receivedEtag', '"v2"')
          .having((failure) => failure.statusCode, 'statusCode', 412),
    ),
  );
});
```

Use these executable tables for non-206 and identity rejection:

```dart
for (final status in <int>[200, 204, 404]) {
  test('rejects status $status as protocol failure', () {
    expect(
      () => validator.validate(
        statusCode: status,
        headers: Headers(),
        source: source,
        expectedEtag: null,
      ),
      throwsA(
        isA<SeismicityPmTilesInvalidNetworkResponseException>()
            .having((failure) => failure.statusCode, 'statusCode', status)
            .having((failure) => failure.reason, 'reason', 'Expected HTTP 206 Partial Content.'),
      ),
    );
  });
}

for (final received in <String?>[null, '*', 'W/"v1"', 'v1', '"v"1"', '"v2"']) {
  test('rejects archive identity $received', () {
    expect(
      () => validator.validate(
        statusCode: 206,
        headers: Headers.fromMap(<String, List<String>>{
          if (received != null) 'etag': <String>[received],
        }),
        source: source,
        expectedEtag: '"v1"',
      ),
      throwsA(
        isA<SeismicityPmTilesArchiveChangedException>()
            .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
            .having((failure) => failure.receivedEtag, 'receivedEtag', received)
            .having((failure) => failure.statusCode, 'statusCode', 206),
      ),
    );
  });
}
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_identity_validator_test.dart`

Expected RED: compile FAIL because identity-validator file is not created yet。

- [ ] **Step 2: Implement, verify, commit, push**

Status order is 412 → non-206 → ETag grammar → expected equality。Use only literal `'etag'` header lookup。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_identity_validator_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_identity_validator.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_identity_validator_test.dart
git commit -m "Feat: PMTiles通信の世代識別を検証"
git push origin HEAD
```

Expected GREEN: PASS。

### Task 6: Validate Content-Range and body length

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_content_range_validator.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_content_range_validator_test.dart`

**Interfaces:**

```dart
final class SeismicityPmTilesContentRangeValidator {
  const SeismicityPmTilesContentRangeValidator();
  Uint8List validate({
    required Headers headers,
    required Uint8List bytes,
    required SeismicityPmTilesNetworkSource source,
    required int requestedOffset,
    required int requestedLength,
    required int expectedSizeBytes,
  });
}
```

- [ ] **Step 1: Write table-driven RED tests**

```dart
const validator = SeismicityPmTilesContentRangeValidator();
final source = SeismicityPmTilesNetworkSource(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);

test('returns copied bytes for exact range and length', () {
  final input = Uint8List.fromList(<int>[4, 5, 6]);
  final output = validator.validate(
    headers: Headers.fromMap(<String, List<String>>{
      'content-range': <String>['bytes 4-6/16'],
    }),
    bytes: input,
    source: source,
    requestedOffset: 4,
    requestedLength: 3,
    expectedSizeBytes: 16,
  );
  expect(output, orderedEquals(<int>[4, 5, 6]));
  expect(identical(output, input), isFalse);
});

for (final value in <String?>[null, 'bytes 5-7/16', 'bytes 4-7/16', 'bytes 4-6/15', 'bytes 4-6/*']) {
  test('rejects Content-Range $value', () {
    expect(
      () => validator.validate(
        headers: Headers.fromMap(<String, List<String>>{
          if (value != null) 'content-range': <String>[value],
        }),
        bytes: Uint8List.fromList(<int>[4, 5, 6]),
        source: source,
        requestedOffset: 4,
        requestedLength: 3,
        expectedSizeBytes: 16,
      ),
      throwsA(
        isA<SeismicityPmTilesInvalidNetworkResponseException>()
            .having((failure) => failure.statusCode, 'statusCode', 206)
            .having((failure) => failure.reason, 'reason', 'Content-Range must equal bytes 4-6/16.'),
      ),
    );
  });
}
```

```dart
test('rejects short body with exact typed reason', () {
  expect(
    () => validator.validate(
      headers: Headers.fromMap(<String, List<String>>{
        'content-range': <String>['bytes 4-6/16'],
      }),
      bytes: Uint8List.fromList(<int>[4, 5]),
      source: source,
      requestedOffset: 4,
      requestedLength: 3,
      expectedSizeBytes: 16,
    ),
    throwsA(
      isA<SeismicityPmTilesInvalidNetworkResponseException>().having(
        (failure) => failure.reason,
        'reason',
        'Expected 3 response bytes but received 2.',
      ),
    ),
  );
});
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_content_range_validator_test.dart`

Expected RED: compile FAIL because content-range validator file is not created yet。

- [ ] **Step 2: Implement, verify, commit, push**

Use `RegExp(r'^bytes ([0-9]+)-([0-9]+)/([0-9]+)$')`, parse all captures, compare exact expected values, then length and copy。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_content_range_validator_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_content_range_validator.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_content_range_validator_test.dart
git commit -m "Feat: PMTiles通信Range応答を検証"
git push origin HEAD
```

Expected GREEN: PASS。

### Task 7: Add the private reader behind the public Factory

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:** Produces final public Factory signature; private reader composes Tasks 4–6 and implements sequential `readAt` plus minimal close。

- [ ] **Step 1: Write RED Factory/basic request tests**

Define in the reader test:

```dart
late NetworkRangeTestAdapter adapter;

setUp(() {
  adapter = NetworkRangeTestAdapter();
});

SeismicityPmTilesArchiveDescriptor networkDescriptor({required int sizeBytes}) =>
    SeismicityPmTilesArchiveDescriptor(
      source: SeismicityPmTilesSource.network(
        archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
      ),
      schemaVersion: 1,
      dataZoom: 8,
      expectedSizeBytes: sizeBytes,
      expectedFeatureCount: 1,
      archiveRevision: 'fixture-v1',
      periodFrom: DateTime.utc(2025),
      periodTo: DateTime.utc(2026),
    );

Future<PmTilesRandomAccessReader> createReader({
  required NetworkRangeTestAdapter adapter,
  required CancelToken callerToken,
  int cacheBytes = 8,
}) async {
  final dio = Dio()..httpClientAdapter = adapter;
  final factory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) async => Uint8List(0),
    dio: dio,
    networkMaxCacheBytes: cacheBytes,
  );
  return switch (await factory.create(
    descriptor: networkDescriptor(sizeBytes: 16),
    cancelToken: callerToken,
  )) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
}
```

```dart
test('pins first identity and sends If-Match next', () async {
  adapter
    ..enqueueResponse(statusCode: 206, body: const [0, 1], etag: '"v1"', contentRange: 'bytes 0-1/16')
    ..enqueueResponse(statusCode: 206, body: const [2, 3], etag: '"v1"', contentRange: 'bytes 2-3/16');
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  addTearDown(reader.close);
  expect(await reader.readAt(offset: 0, length: 2), orderedEquals(<int>[0, 1]));
  expect(await reader.readAt(offset: 2, length: 2), orderedEquals(<int>[2, 3]));
  expect(adapter.requests[0].headers.containsKey('If-Match'), isFalse);
  expect(adapter.requests[1].headers['If-Match'], '"v1"');
});
```

```dart
for (final fixture in <({int sizeBytes, int cacheBytes, String reason})>[
  (
    sizeBytes: 0,
    cacheBytes: 8,
    reason: 'Network expectedSizeBytes must be positive.',
  ),
  (
    sizeBytes: 16,
    cacheBytes: 0,
    reason: 'networkMaxCacheBytes must be positive.',
  ),
]) {
  test('rejects invalid Network input ${fixture.reason}', () async {
    final invalidFactory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) async => Uint8List(0),
      dio: Dio()..httpClientAdapter = adapter,
      networkMaxCacheBytes: fixture.cacheBytes,
    );
    final result = await invalidFactory.create(
      descriptor: networkDescriptor(sizeBytes: fixture.sizeBytes),
      cancelToken: CancelToken(),
    );
    expect(
      result,
      SeismicityPmTilesResult<PmTilesRandomAccessReader>.failure(
        exception: SeismicityPmTilesException.invalidDescriptor(
          reason: fixture.reason,
        ),
      ),
    );
    expect(adapter.requests, isEmpty);
  });
}

test('rejects unsafe 200 without returning its body', () async {
  adapter.enqueueResponse(
    statusCode: 200,
    body: const [0, 1],
    etag: '"v1"',
    contentRange: null,
  );
  final reader = await createReader(
    adapter: adapter,
    callerToken: CancelToken(),
  );
  addTearDown(reader.close);
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(
      isA<SeismicityPmTilesInvalidNetworkResponseException>()
          .having((failure) => failure.statusCode, 'statusCode', 200)
          .having(
            (failure) => failure.reason,
            'reason',
            'Expected HTTP 206 Partial Content.',
          ),
    ),
  );
  expect(adapter.requests, hasLength(1));
});

for (final statusCode in <int?>[null, 503]) {
  test('maps transport failure $statusCode without leaking DioException', () async {
    if (statusCode == null) {
      adapter.enqueueDioFailure(statusCode: null);
    } else {
      adapter.enqueueResponse(
        statusCode: statusCode,
        body: const [],
        etag: null,
        contentRange: null,
      );
    }
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);
    await expectLater(
      reader.readAt(offset: 0, length: 2),
      throwsA(
        isA<SeismicityPmTilesNetworkRequestFailedException>().having(
          (failure) => failure.statusCode,
          'statusCode',
          statusCode,
        ),
      ),
    );
  });
}
```

In `public_api_compile_test.dart`, import Dio and replace the old const Factory construction with:

```dart
final factory = SeismicityRandomAccessReaderFactory(
  assetLoader: loadPublicApiAsset,
  dio: Dio(),
  networkMaxCacheBytes: 1024,
);
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: compile FAIL because private reader file and descriptor-aware Factory API are not created yet。

- [ ] **Step 2: Implement sequential reader/minimal close, verify, commit, push**

The sequential reader initially passes the Factory caller token to Dio. Basic `close()` stores `closed`, cancels that token, and returns a memoized completed Future; Task 10 replaces this temporary wiring with owned per-request tokens, and Task 11 adds waiting across concurrent Futures。No concrete Network type is barrel-exported。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
mise exec -- flutter test packages/seismicity_pmtiles/test/public_api_compile_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles通信ReaderをFactoryへ接続"
git push origin HEAD
```

Expected GREEN: PASS。

### Task 8: Add aggregate-byte LRU

**Files:** Modify private reader and its test。

**Interfaces:** Cache key is `({Uri archiveUri, String strongEtag, int offset, int length})`; value is copied `Uint8List`。

- [ ] **Step 1: Write executable RED LRU test**

```dart
test('budget five evicts only oldest two-byte entry', () async {
  for (final range in <({int offset, List<int> bytes})>[
    (offset: 0, bytes: <int>[0, 1, 2]),
    (offset: 3, bytes: <int>[3, 4]),
    (offset: 5, bytes: <int>[5, 6]),
    (offset: 3, bytes: <int>[3, 4]),
  ]) {
    adapter.enqueueResponse(
      statusCode: 206,
      body: range.bytes,
      etag: '"v1"',
      contentRange: 'bytes ${range.offset}-${range.offset + range.bytes.length - 1}/16',
    );
  }
  final reader = await createReader(adapter: adapter, cacheBytes: 5, callerToken: CancelToken());
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 3, length: 2);
  await reader.readAt(offset: 0, length: 3); // touch 3-byte entry
  await reader.readAt(offset: 5, length: 2); // evicts only old offset 3 entry
  await reader.readAt(offset: 0, length: 3); // hit
  await reader.readAt(offset: 3, length: 2); // miss
  expect(adapter.requests, hasLength(4));
});
```

```dart
test('same range is served from LRU after the first read', () async {
  adapter.enqueueResponse(
    statusCode: 206,
    body: const [0, 1],
    etag: '"v1"',
    contentRange: 'bytes 0-1/16',
  );
  final reader = await createReader(
    adapter: adapter,
    callerToken: CancelToken(),
  );
  addTearDown(reader.close);
  expect(await reader.readAt(offset: 0, length: 2), orderedEquals(<int>[0, 1]));
  expect(await reader.readAt(offset: 0, length: 2), orderedEquals(<int>[0, 1]));
  expect(adapter.requests, hasLength(1));
});

test('value larger than budget is returned but not cached', () async {
  for (var request = 0; request < 2; request++) {
    adapter.enqueueResponse(
      statusCode: 206,
      body: const [0, 1, 2],
      etag: '"v1"',
      contentRange: 'bytes 0-2/16',
    );
  }
  final reader = await createReader(
    adapter: adapter,
    cacheBytes: 2,
    callerToken: CancelToken(),
  );
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(2));
});
```

Run reader test. Expected RED: repeated same range issues another request。

- [ ] **Step 2: Implement, verify, commit, push**

Use access-ordered `LinkedHashMap`, exact aggregate count, oldest eviction loop, no oversize insertion。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信RangeをLRU保持"
git push origin HEAD
```

### Task 9: Add identity gate and in-flight dedupe

**Files:** Modify private reader and its test。

**Interfaces:** One initial Future establishes ETag; later in-flight key includes URI/ETag/range。

- [ ] **Step 1: Write executable RED concurrency tests**

```dart
test('same pending range shares one request', () async {
  final pending = adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  addTearDown(reader.close);
  final first = reader.readAt(offset: 0, length: 3);
  final second = reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(1));
  pending.complete(<int>[0, 1, 2]);
  expect(await Future.wait(<Future<Uint8List>>[first, second]), everyElement(orderedEquals(<int>[0, 1, 2])));
});

test('different range waits for initial identity', () async {
  final pending = adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  adapter.enqueueResponse(statusCode: 206, body: const [3, 4], etag: '"v1"', contentRange: 'bytes 3-4/16');
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  addTearDown(reader.close);
  final first = reader.readAt(offset: 0, length: 3);
  final second = reader.readAt(offset: 3, length: 2);
  expect(adapter.requests, hasLength(1));
  pending.complete(<int>[0, 1, 2]);
  await first;
  await second;
  expect(adapter.requests[1].headers['If-Match'], '"v1"');
});
```

Run reader test. Expected RED: two requests start for same range or second range starts before identity exists。

- [ ] **Step 2: Implement, verify, commit, push**

Store Future before await, share by key, remove in `whenComplete`, and cache only validated success。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの同時取得を共有"
git push origin HEAD
```

### Task 10: Make caller cancellation non-terminal

**Files:** Modify private reader, mock support, and reader test。

**Interfaces:** A request coordinator creates owned tokens, watches the one-shot caller token, cancels active owned tokens at that moment, and does not store terminal failure。

- [ ] **Step 1: Write required pending-cancel-reuse test**

```dart
test('caller cancellation stops pending request and reader remains usable', () async {
  final callerToken = CancelToken();
  final pending = adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final reader = await createReader(adapter: adapter, callerToken: callerToken);
  addTearDown(reader.close);
  final cancelledRead = reader.readAt(offset: 0, length: 2);
  callerToken.cancel('period changed');
  await expectLater(
    cancelledRead,
    throwsA(
      isA<SeismicityPmTilesCancelledException>().having(
        (failure) => failure.source,
        'source',
        networkDescriptor(sizeBytes: 16).source,
      ),
    ),
  );
  expect(pending.cancelled, isTrue);

  adapter.enqueueResponse(
    statusCode: 206,
    body: const [2, 3],
    etag: '"v1"',
    contentRange: 'bytes 2-3/16',
  );
  expect(await reader.readAt(offset: 2, length: 2), orderedEquals(<int>[2, 3]));
  expect(adapter.requests, hasLength(2));
});
```

Run reader test. Expected RED: caller token is passed directly to Dio and its cancelled state incorrectly rejects the second read, or pending fixture is not cancelled。

- [ ] **Step 2: Implement coordinator, verify, commit, push**

Each HTTP fetch gets a fresh owned token. `callerToken.whenCancel` cancels only tokens active when signal fires. Dio cancel catch returns stored terminal failure if one exists; otherwise returns `cancelled` without clearing identity/cache or setting terminal state。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信要求の取消を分離"
git push origin HEAD
```

### Task 11: Make generation poison and close terminal

**Files:** Modify private reader and its test。

**Interfaces:** Stored terminal failure beats cancellation translation; close memoizes a Future that awaits all active reads and completes successfully。

- [ ] **Step 1: Write table-driven poison and close tests**

```dart
for (final fixture in <({int status, String? etag})>[
  (status: 412, etag: '"v2"'),
  (status: 206, etag: null),
  (status: 206, etag: '"v2"'),
  (status: 206, etag: '*'),
]) {
  test('identity failure ${fixture.status}/${fixture.etag} is terminal', () async {
    adapter.enqueueResponse(statusCode: 206, body: const [0, 1], etag: '"v1"', contentRange: 'bytes 0-1/16');
    final reader = await createReader(adapter: adapter, callerToken: CancelToken());
    addTearDown(reader.close);
    await reader.readAt(offset: 0, length: 2); // cached
    final peer = adapter.enqueuePending206(offset: 4, total: 16, etag: '"v1"');
    final peerRead = reader.readAt(offset: 4, length: 2);
    adapter.enqueueResponse(
      statusCode: fixture.status,
      body: fixture.status == 206 ? const [2, 3] : const [],
      etag: fixture.etag,
      contentRange: fixture.status == 206 ? 'bytes 2-3/16' : null,
    );
    final poisonedRead = reader.readAt(offset: 2, length: 2);
    final failureMatcher = isA<SeismicityPmTilesArchiveChangedException>()
        .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
        .having((failure) => failure.receivedEtag, 'receivedEtag', fixture.etag)
        .having((failure) => failure.statusCode, 'statusCode', fixture.status);
    await expectLater(poisonedRead, throwsA(failureMatcher));
    await expectLater(peerRead, throwsA(failureMatcher));
    final requestCountBeforeCachedRead = adapter.requests.length;
    await expectLater(
      reader.readAt(offset: 0, length: 2),
      throwsA(failureMatcher),
    );
    expect(adapter.requests, hasLength(requestCountBeforeCachedRead));
    expect(peer.cancelled, isTrue);
  });
}

test('close waits for failed inflight and future reads are closed', () async {
  adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  final read = reader.readAt(offset: 0, length: 2);
  final firstClose = reader.close();
  final secondClose = reader.close();
  expect(identical(firstClose, secondClose), isTrue);
  await expectLater(read, throwsA(isA<SeismicityPmTilesClosedException>()));
  await expectLater(firstClose, completes);
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(isA<SeismicityPmTilesClosedException>()));
});
```

Run reader test. Expected RED: peer/cache/future reads do not share terminal failure or close propagates the cancelled read error。

- [ ] **Step 2: Implement terminal transitions, verify, commit, push**

Poison stores first `ArchiveChanged`, clears LRU, cancels active owned tokens, and cancellation catches rethrow stored failure。Close stores `Closed` only if no previous terminal failure, snapshots active Futures, maps success/error to `Future<void>`, waits all, clears state, returns memoized Future without propagating read errors。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの世代と終了を管理"
git push origin HEAD
```

### Task 12: Preserve File/Asset behavior and run final gates

**Files:**

- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Verify: all changed package production/tests。

**Interfaces:** All sources still return `SeismicityPmTilesResult<PmTilesRandomAccessReader>`; Network never invokes asset loader。

- [ ] **Step 1: Add executable routing regression tests**

```dart
import 'package:dio/dio.dart';
import '../support/network_range_test_support.dart';

late NetworkRangeTestAdapter adapter;

setUp(() async {
  tempDirectory = await Directory.systemTemp.createTemp(
    'seismicity_pmtiles_reader_factory_',
  );
  archiveFile = File('${tempDirectory.path}/archive.pmtiles');
  await archiveFile.writeAsBytes(<int>[1, 2, 3, 4]);
  assetLoadCount = 0;
  adapter = NetworkRangeTestAdapter();
  factory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) async {
      assetLoadCount++;
      return Uint8List.fromList(<int>[5, 6, 7, 8]);
    },
    dio: Dio()..httpClientAdapter = adapter,
    networkMaxCacheBytes: 8,
  );
});

SeismicityPmTilesArchiveDescriptor descriptorFor({
  required SeismicityPmTilesSource source,
  required int sizeBytes,
}) {
  return SeismicityPmTilesArchiveDescriptor(
    source: source,
    schemaVersion: 1,
    dataZoom: 8,
    expectedSizeBytes: sizeBytes,
    expectedFeatureCount: 1,
    archiveRevision: 'fixture-v1',
    periodFrom: DateTime.utc(2025),
    periodTo: DateTime.utc(2026),
  );
}

PmTilesRandomAccessReader valueOf(
  SeismicityPmTilesResult<PmTilesRandomAccessReader> result,
) {
  return switch (result) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
}

test('File and Asset stay independent from Network transport', () async {
  final fileResult = await factory.create(
    descriptor: descriptorFor(source: SeismicityPmTilesSource.file(path: archiveFile.path), sizeBytes: 4),
    cancelToken: CancelToken(),
  );
  final fileReader = valueOf(fileResult);
  addTearDown(fileReader.close);
  expect(fileReader, isA<PmTilesV3FileRandomAccessReader>());
  expect(await fileReader.readAt(offset: 1, length: 2), orderedEquals(<int>[2, 3]));

  final assetResult = await factory.create(
    descriptor: descriptorFor(source: const SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles'), sizeBytes: 4),
    cancelToken: CancelToken(),
  );
  addTearDown(valueOf(assetResult).close);
  expect(assetLoadCount, 1);
  expect(adapter.requests, isEmpty);
});
```

```dart
test('missing File keeps exact typed source failure', () async {
  final source = SeismicityPmTilesSource.file(
    path: '${tempDirectory.path}/missing.pmtiles',
  );
  final result = await factory.create(
    descriptor: descriptorFor(source: source, sizeBytes: 4),
    cancelToken: CancelToken(),
  );
  expect(
    result,
    isA<SeismicityPmTilesFailure<PmTilesRandomAccessReader>>().having(
      (failure) => failure.exception,
      'exception',
      isA<SeismicityPmTilesSourceReadFailedException>().having(
        (failure) => failure.source,
        'source',
        source,
      ),
    ),
  );
});

test('throwing Asset loader keeps exact typed source failure', () async {
  const source = SeismicityPmTilesSource.asset(assetKey: 'missing.pmtiles');
  final errorFactory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) =>
        Future<Uint8List>.error(StateError('asset unavailable')),
    dio: Dio()..httpClientAdapter = adapter,
    networkMaxCacheBytes: 8,
  );
  final result = await errorFactory.create(
    descriptor: descriptorFor(source: source, sizeBytes: 4),
    cancelToken: CancelToken(),
  );
  expect(
    result,
    isA<SeismicityPmTilesFailure<PmTilesRandomAccessReader>>().having(
      (failure) => failure.exception,
      'exception',
      isA<SeismicityPmTilesSourceReadFailedException>().having(
        (failure) => failure.source,
        'source',
        source,
      ),
    ),
  );
});

test('unsafe Network 200 never falls back to Asset', () async {
  adapter.enqueueResponse(
    statusCode: 200,
    body: const [0, 1],
    etag: '"v1"',
    contentRange: null,
  );
  final reader = valueOf(
    await factory.create(
      descriptor: descriptorFor(
        source: SeismicityPmTilesSource.network(
          archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
        ),
        sizeBytes: 16,
      ),
      cancelToken: CancelToken(),
    ),
  );
  addTearDown(reader.close);
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(isA<SeismicityPmTilesInvalidNetworkResponseException>()),
  );
  expect(assetLoadCount, 0);
  expect(adapter.requests, hasLength(1));
});
```

- [ ] **Step 2: Run complete gates**

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test
mise exec -- dart test packages/pmtiles_v3/test
mise exec -- dart format --set-exit-if-changed packages/seismicity_pmtiles packages/pmtiles_v3
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
mise exec -- dart analyze packages/seismicity_pmtiles
mise exec -- dart analyze packages/pmtiles_v3
git diff --check
rg -n 'package:pmtiles_v3/src/|Headers\.etagHeader|ResponseType\.stream|HttpClient\(' packages/seismicity_pmtiles packages/pmtiles_v3
```

Expected: all commands exit 0; final `rg` has no matches; no real network/device/simulator/E2E/app/decoder/Scene changes。

- [ ] **Step 3: Commit and push regressions**

```bash
git add packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart
git commit -m "Test: PMTiles FileとAsset経路を回帰確認"
git push origin HEAD
```

## Plan Self-Review

- Spec coverage: Task 4 covers Range/bytes/validateStatus including 412 admission; Task 5 covers 206/412/ETag; Task 6 covers exact Content-Range/body; Task 8 LRU; Task 9 identity/in-flight; Task 10 non-terminal caller cancel; Task 11 terminal generation/close; Task 12 File/Asset/no fallback。
- Cancellation decision: non-terminal caller cancel is grounded in Issue #1600 requirement 7 and design lines 120–126; only 412/ETag generation change is specified as whole-reader failure。Task 10 proves pending cancellation plus successful reuse。
- Literal correctness: header key is `'etag'`; every `Uri.parse` source is `final`; every RED reason names a not-yet-created file/API or an expected runtime mismatch in the current task order。
- Type consistency: Factory returns `Result<reader>`; concrete Network reader stays private; response identity failures use `ArchiveChanged`; caller cancellation uses `Cancelled` without terminal storage; close uses `Closed`。
- Granularity: 12 task/commit boundaries isolate public export, contracts, mock support, Options/ETag grammar, identity protocol, content/body, basic Factory, LRU, in-flight, caller cancellation, poison/close, and route regression。Every commit is followed by push command。
- Placeholder scan: no deferred implementation marker or undefined production interface remains; table-driven tests specify literal status/header/body/failure fields。

## Execution Handoff

Plan complete at `docs/superpowers/plans/2026-08-09-seismicity-pmtiles-network-reader.md`. Implement with `superpowers:subagent-driven-development`, reviewing each task before its commit/push commands。
