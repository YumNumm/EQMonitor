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

### Task 3: Create the static typed mock adapter

**Files:**

- Create: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Create: `packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

**Interfaces:**

```dart
sealed class NetworkRangeReply {
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  });
}

final class NetworkRangeTestAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = <RequestOptions>[];
  void enqueueResponse({required int statusCode, required List<int> body, String? etag, String? contentRange});
}

final class StaticNetworkRangeReply implements NetworkRangeReply {
  const StaticNetworkRangeReply({
    required this.statusCode,
    required this.body,
    required this.etag,
    required this.contentRange,
  });
}
```

The adapter uses a typed `Queue<NetworkRangeReply>`, records `RequestOptions`, returns `ResponseBody.fromBytes`, and stores header names as literal `'etag'` and `'content-range'`。Empty queue throws `StateError('No queued mock response.')`。

- [ ] **Step 1: Write the static-response RED fixture test**

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

```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

Expected RED: compile FAIL because `network_range_test_support.dart` and its static adapter types do not exist。

- [ ] **Step 2: Implement fixture, verify, commit, push**

Implement the exact interfaces above; `StaticNetworkRangeReply.resolve` returns a literal-header `ResponseBody.fromBytes` and ignores the nullable cancellation Future。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git add packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git commit -m "Test: PMTiles通信の固定mock応答を追加"
git push origin HEAD
```

Expected GREEN: PASS without opening a socket。

### Task 4: Add the failing mock reply

**Files:**

- Modify: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Modify: `packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

**Interfaces:** Extends Task 3 without changing its static reply contract。

```dart
final class NetworkRangeTestAdapter implements HttpClientAdapter {
  void enqueueDioFailure({required int? statusCode});
}

final class FailingNetworkRangeReply implements NetworkRangeReply {
  const FailingNetworkRangeReply({required this.statusCode});
  final int? statusCode;
}

```

- [ ] **Step 1: Write the RED Dio-failure fixture test**

```dart
test('failing reply preserves the nullable response status', () async {
  final adapter = NetworkRangeTestAdapter()
    ..enqueueDioFailure(statusCode: 503);
  final fetch = adapter.fetch(
    RequestOptions(path: 'https://example.com/archive.pmtiles'),
    null,
    null,
  );
  await expectLater(
    fetch,
    throwsA(
      isA<DioException>().having(
        (failure) => failure.response?.statusCode,
        'statusCode',
        503,
      ),
    ),
  );
});
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

Expected RED: compile FAIL because `enqueueDioFailure` and `FailingNetworkRangeReply` do not exist。

- [ ] **Step 2: Implement replies, verify, commit, push**

`FailingNetworkRangeReply.resolve` throws a typed `DioException`, attaching `Response<void>(statusCode: statusCode)` only when status is non-null。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git add packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git commit -m "Test: PMTiles通信mockの失敗応答を追加"
git push origin HEAD
```

Expected GREEN: PASS without a socket。

### Task 5: Add the pending cancellable mock reply

**Files:**

- Modify: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Modify: `packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart`

**Interfaces:** Extends the Task 3 adapter with one cancellable reply。

```dart
final class NetworkRangeTestAdapter implements HttpClientAdapter {
  PendingRangeResponse enqueuePending206({
    required int offset,
    required int total,
    required String? etag,
  });
}

final class PendingRangeResponse implements NetworkRangeReply {
  bool cancelled = false;
  void complete(List<int> bytes);
}
```

- [ ] **Step 1: Write the RED pending-cancellation fixture test**

```dart
test('pending response observes Dio cancellation', () async {
  final adapter = NetworkRangeTestAdapter();
  final pending = adapter.enqueuePending206(
    offset: 0,
    total: 16,
    etag: '"v1"',
  );
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

Expected RED: compile FAIL because `enqueuePending206` and `PendingRangeResponse` do not exist。

- [ ] **Step 2: Implement pending reply, verify, commit, push**

Race its byte completer against `cancelFuture`; cancellation sets `cancelled = true` and throws `DioExceptionType.cancel`。Successful completion builds an exact `206`/ETag/Content-Range response through the Task 3 response helper。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git add packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support_test.dart
git commit -m "Test: PMTiles通信mockのpending応答を追加"
git push origin HEAD
```

Expected GREEN: PASS; the cancellation branch wins without opening a socket。

### Task 6: Build byte Range Options and strong ETag grammar

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

### Task 7: Validate HTTP status and archive identity

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

### Task 8: Validate Content-Range and body length

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

### Task 9: Migrate the public Factory contract

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:** Produces the final public Factory constructor/create signature。Valid Network remains the existing `unsupportedSource` result until Task 11; File/Asset behavior is unchanged。

- [ ] **Step 1: Write the RED Factory contract migration**

Add this helper to the existing Factory test and route every existing source test through it:

```dart
import 'package:dio/dio.dart';
import '../support/network_range_test_support.dart';

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

Future<SeismicityPmTilesResult<PmTilesRandomAccessReader>> createFor({
  required SeismicityRandomAccessReaderFactory factory,
  required SeismicityPmTilesSource source,
  required int sizeBytes,
}) {
  return factory.create(
    descriptor: descriptorFor(source: source, sizeBytes: sizeBytes),
    cancelToken: CancelToken(),
  );
}
```

Replace the existing Factory-test setup with the final injected transport:

```dart
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
```

In `public_api_compile_test.dart`, import Dio and replace the old const fixture with:

```dart
final factory = SeismicityRandomAccessReaderFactory(
  assetLoader: loadPublicApiAsset,
  dio: Dio(),
  networkMaxCacheBytes: 1024,
);
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart`

Expected RED: compile FAIL because the Factory does not accept Dio/cache, descriptor, or caller token yet。

- [ ] **Step 2: Migrate Factory, verify, commit, push**

Switch on `descriptor.source` and preserve the existing valid-Network unsupported result。Update the five existing Factory tests with `createFor`, using size `4` for File/Asset and `16` for Network。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart packages/seismicity_pmtiles/test/public_api_compile_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Refactor: PMTiles Reader Factory契約を更新"
git push origin HEAD
```

Expected GREEN: PASS, with zero adapter requests。

### Task 10: Reject invalid Network Factory inputs

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`

**Interfaces:** Network `expectedSizeBytes <= 0` or `networkMaxCacheBytes <= 0` returns exact `invalidDescriptor` before any reader/request construction。

- [ ] **Step 1: Write the exact RED preflight table**

```dart
for (final fixture in <({int sizeBytes, int cacheBytes, String reason})>[
  (sizeBytes: 0, cacheBytes: 8, reason: 'Network expectedSizeBytes must be positive.'),
  (sizeBytes: 16, cacheBytes: 0, reason: 'networkMaxCacheBytes must be positive.'),
]) {
  test('rejects invalid Network input ${fixture.reason}', () async {
    final invalidFactory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) async => Uint8List(0),
      dio: Dio()..httpClientAdapter = adapter,
      networkMaxCacheBytes: fixture.cacheBytes,
    );
    final result = await createFor(
      factory: invalidFactory,
      source: SeismicityPmTilesSource.network(
        archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
      ),
      sizeBytes: fixture.sizeBytes,
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
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`

Expected RED: FAIL because valid and invalid Network descriptors still return the same `unsupportedSource` failure。

- [ ] **Step 2: Implement preflight, verify, commit, push**

Validate both positive integers only inside the Network switch branch and return the literal reasons above before constructing any Network reader。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart
git commit -m "Feat: PMTiles通信Reader設定を事前検証"
git push origin HEAD
```

### Task 11: Connect the sequential Network reader

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

**Interfaces:** A private concrete reader composes Tasks 6–8 and is returned only as `PmTilesRandomAccessReader` by the Task 9 Factory。

- [ ] **Step 1: Write the RED happy-path reader test**

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
  final factory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) async => Uint8List(0),
    dio: Dio()..httpClientAdapter = adapter,
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

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because valid Network still returns `unsupportedSource` and no private reader exists。

- [ ] **Step 2: Implement sequential reader, verify, commit, push**

The reader validates ranges before I/O, sends Dio GET with Task 6 Options, applies Tasks 7–8 validators, and fixes the first identity。It initially passes the Factory caller token directly to Dio; Task 15 introduces owned request tokens。Basic close becomes final in Task 18。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信ReaderをFactoryへ接続"
git push origin HEAD
```

Expected GREEN: PASS; no concrete Network class is barrel-exported。

### Task 12: Map unsafe responses and transport failures

**Files:** Modify the private reader and its test。

**Interfaces:** Non-206 admitted responses use Task 7 protocol failures; Dio/500+ failures become `SeismicityPmTilesNetworkRequestFailedException` without raw body/exception leakage。

- [ ] **Step 1: Write RED failure-mapping tests**

```dart
test('rejects unsafe 200 without returning its body', () async {
  adapter.enqueueResponse(statusCode: 200, body: const [0, 1], etag: '"v1"', contentRange: null);
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  addTearDown(reader.close);
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(
      isA<SeismicityPmTilesInvalidNetworkResponseException>()
          .having((failure) => failure.statusCode, 'statusCode', 200)
          .having((failure) => failure.reason, 'reason', 'Expected HTTP 206 Partial Content.'),
    ),
  );
  expect(adapter.requests, hasLength(1));
});

for (final statusCode in <int?>[null, 503]) {
  test('maps transport failure $statusCode without leaking DioException', () async {
    if (statusCode == null) {
      adapter.enqueueDioFailure(statusCode: null);
    } else {
      adapter.enqueueResponse(statusCode: 503, body: const [], etag: null, contentRange: null);
    }
    final reader = await createReader(adapter: adapter, callerToken: CancelToken());
    addTearDown(reader.close);
    await expectLater(
      reader.readAt(offset: 0, length: 2),
      throwsA(
        isA<SeismicityPmTilesNetworkRequestFailedException>()
            .having((failure) => failure.statusCode, 'statusCode', statusCode),
      ),
    );
  });
}
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because a Dio failure escapes as `DioException`; the unsafe 200 assertion already passes through the protocol validator。

- [ ] **Step 2: Map Dio failures, verify, commit, push**

Catch non-cancel Dio failures at the private reader boundary and throw only `networkRequestFailed(source, response?.statusCode)`。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信失敗を型へ変換"
git push origin HEAD
```

### Task 13: Add aggregate-byte LRU

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

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because the repeated same range issues another request。

- [ ] **Step 2: Implement, verify, commit, push**

Use access-ordered `LinkedHashMap`, exact aggregate count, oldest eviction loop, no oversize insertion。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信RangeをLRU保持"
git push origin HEAD
```

### Task 14: Add identity gate and in-flight dedupe

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

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because two requests start for the same range or the second range starts before identity exists。

- [ ] **Step 2: Implement, verify, commit, push**

Store Future before await, share by key, remove in `whenComplete`, and cache only validated success。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの同時取得を共有"
git push origin HEAD
```

### Task 15: Make caller cancellation non-terminal

**Files:** Modify the private reader and its test; consume the Task 5 pending fixture unchanged。

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

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because the caller token is passed directly to Dio and its cancelled state rejects the second read, or the pending fixture is not cancelled。

- [ ] **Step 2: Implement coordinator, verify, commit, push**

Each HTTP fetch gets a fresh owned token. `callerToken.whenCancel` cancels only tokens active when signal fires. Dio cancel catch returns stored terminal failure if one exists; otherwise returns `cancelled` without clearing identity/cache or setting terminal state。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信要求の取消を分離"
git push origin HEAD
```

### Task 16: Poison on an invalid initial ETag

**Files:** Modify the private reader and its test。

**Interfaces:** A missing or malformed ETag on the first `206` stores the exact first `ArchiveChanged` failure before any archive identity or cache entry exists。

- [ ] **Step 1: Write the literal initial-identity poison table**

```dart
for (final receivedEtag in <String?>[null, '*']) {
  test('initial ETag $receivedEtag poisons without another request', () async {
    adapter.enqueueResponse(
      statusCode: 206,
      body: const [0, 1],
      etag: receivedEtag,
      contentRange: 'bytes 0-1/16',
    );
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);
    final failureMatcher = isA<SeismicityPmTilesArchiveChangedException>()
        .having(
          (failure) => failure.source,
          'source',
          networkDescriptor(sizeBytes: 16).source,
        )
        .having((failure) => failure.expectedEtag, 'expectedEtag', null)
        .having((failure) => failure.receivedEtag, 'receivedEtag', receivedEtag)
        .having((failure) => failure.statusCode, 'statusCode', 206);

    await expectLater(
      reader.readAt(offset: 0, length: 2),
      throwsA(failureMatcher),
    );
    final requestCountAfterFirstFailure = adapter.requests.length;
    await expectLater(
      reader.readAt(offset: 2, length: 2),
      throwsA(failureMatcher),
    );
    expect(adapter.requests, hasLength(requestCountAfterFirstFailure));
  });
}
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because the first typed failure is not stored, so the second read attempts an unqueued request instead of throwing the same fields。

- [ ] **Step 2: Store the first identity failure, verify, commit, push**

Catch only `SeismicityPmTilesArchiveChangedException` from identity validation, store the first instance, clear LRU, and check stored terminal failure before cache/request lookup。Peer cancellation is added in Task 17。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの初回世代失敗を固定"
git push origin HEAD
```

### Task 17: Propagate a pinned generation change

**Files:** Modify the private reader and its test。

**Interfaces:** After a valid `"v1"` pin, `412` or a valid different ETag stores one `ArchiveChanged`, clears cached `"v1"` bytes, cancels peers, and rethrows that same failure。

- [ ] **Step 1: Write the pinned-generation poison table**

```dart
for (final fixture in <({int status, String etag})>[
  (status: 412, etag: '"v2"'),
  (status: 206, etag: '"v2"'),
]) {
  test('pinned generation failure ${fixture.status} is terminal', () async {
    adapter.enqueueResponse(statusCode: 206, body: const [0, 1], etag: '"v1"', contentRange: 'bytes 0-1/16');
    final reader = await createReader(adapter: adapter, callerToken: CancelToken());
    addTearDown(reader.close);
    await reader.readAt(offset: 0, length: 2);
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
    await expectLater(reader.readAt(offset: 0, length: 2), throwsA(failureMatcher));
    expect(adapter.requests, hasLength(requestCountBeforeCachedRead));
    expect(peer.cancelled, isTrue);
  });
}
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because Task 16 stores the failure but does not yet cancel the pending peer or translate its Dio cancellation into the stored generation failure。

- [ ] **Step 2: Cancel peers with the stored generation, verify, commit, push**

On poison, cancel every other active owned token。A cancel catch rethrows the stored terminal failure when present; it returns caller `Cancelled` only when no terminal failure exists。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの世代変更を伝播"
git push origin HEAD
```

### Task 18: Make close terminal and await active reads

**Files:** Modify the private reader and its test。

**Interfaces:** Close memoizes one Future, cancels active owned tokens, rejects future reads before cache lookup, awaits all active reads, and completes successfully。

- [ ] **Step 1: Write the RED close lifecycle test**

```dart
test('close waits for failed inflight and future reads are closed', () async {
  adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final reader = await createReader(adapter: adapter, callerToken: CancelToken());
  final read = reader.readAt(offset: 0, length: 2);
  final firstClose = reader.close();
  final secondClose = reader.close();
  expect(identical(firstClose, secondClose), isTrue);
  await expectLater(read, throwsA(isA<SeismicityPmTilesClosedException>()));
  await expectLater(firstClose, completes);
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(isA<SeismicityPmTilesClosedException>()),
  );
});
```

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected RED: FAIL because close does not yet await concurrent Futures or consistently translate the cancelled read to the stored closed failure。

- [ ] **Step 2: Implement final close semantics, verify, commit, push**

Store `Closed` only when no earlier generation failure exists。Snapshot active Futures, map both success/error to `Future<void>`, wait all, clear state, and return the memoized close Future without propagating read errors。

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの終了を管理"
git push origin HEAD
```

### Task 19: Preserve routing behavior and run final gates

**Files:**

- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Verify: all changed package production/tests。

**Interfaces:** Task 9 File/Asset tests remain green; a valid Network source never invokes the injected Asset loader, including an unsafe `200` response。

- [ ] **Step 1: Strengthen source identity and no-fallback regressions**

```dart
test('missing File keeps exact typed source failure', () async {
  final source = SeismicityPmTilesSource.file(
    path: '${tempDirectory.path}/missing.pmtiles',
  );
  final result = await createFor(
    factory: factory,
    source: source,
    sizeBytes: 4,
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
  var networkAssetLoadCount = 0;
  final networkAdapter = NetworkRangeTestAdapter()
    ..enqueueResponse(
      statusCode: 200,
      body: const [0, 1],
      etag: '"v1"',
      contentRange: null,
    );
  final networkFactory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) async {
      networkAssetLoadCount++;
      return Uint8List(0);
    },
    dio: Dio()..httpClientAdapter = networkAdapter,
    networkMaxCacheBytes: 8,
  );
  final result = await networkFactory.create(
    descriptor: descriptorFor(
      source: SeismicityPmTilesSource.network(
        archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
      ),
      sizeBytes: 16,
    ),
    cancelToken: CancelToken(),
  );
  final reader = switch (result) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
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
  expect(networkAssetLoadCount, 0);
  expect(networkAdapter.requests, hasLength(1));
});
```

Replace the throwing-Asset-loader assertion with this exact nested matcher after its Task 9 call migration:

```dart
isA<SeismicityPmTilesSourceReadFailedException>().having(
  (failure) => failure.source,
  'source',
  source,
)
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
git commit -m "Test: PMTiles通信のAsset fallbackを防止"
git push origin HEAD
```

## Plan Self-Review

- Spec coverage: Task 6 covers Range/bytes/validateStatus including 412 admission; Task 7 covers 206/412/ETag; Task 8 covers exact Content-Range/body; Task 13 covers LRU; Task 14 covers identity/in-flight; Task 15 covers non-terminal caller cancel; Tasks 16–17 cover initial and pinned generation poison separately; Task 18 covers close; Tasks 9 and 19 preserve File/Asset/no fallback。
- Cancellation decision: non-terminal caller cancel is grounded in Issue #1600 requirement 7 and design lines 120–126; only 412/ETag generation change is specified as whole-reader failure。Task 15 proves pending cancellation plus successful reuse。
- Initial-generation coverage: Task 16 sends missing and malformed `*` ETags as the first mocked `206`, asserts the first exact typed failure, rethrows the same fields on the second read, and proves no second request。Task 17 separately starts from a valid `"v1"` pin before testing `412`/`"v2"` propagation。
- Literal correctness: header key is `'etag'`; every `Uri.parse` source is `final`; every RED reason names a not-yet-created file/API or an expected runtime mismatch in the current task order。
- Type consistency: Factory returns `Result<reader>`; concrete Network reader stays private; response identity failures use `ArchiveChanged`; caller cancellation uses `Cancelled` without terminal storage; close uses `Closed`。
- Granularity: 19 task/commit boundaries split mock support into static/failing/pending replies; split the former oversized Reader task into Factory migration, Network preflight, sequential Reader, and failure mapping; and split initial poison, pinned-generation propagation, and close。Each boundary has its own focused test cycle and push command。
- Placeholder scan: no deferred implementation marker or undefined production interface remains; table-driven tests specify literal status/header/body/failure fields。

## Execution Handoff

Plan complete at `docs/superpowers/plans/2026-08-09-seismicity-pmtiles-network-reader.md`. Implement with `superpowers:subagent-driven-development`, reviewing each task before its commit/push commands。
