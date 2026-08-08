# Seismicity PMTiles Network Reader Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `seismicity_pmtiles` に、Dio の検証済み HTTP byte-range だけを使って PMTiles を random access する Network reader を追加する。

**Architecture:** `pmtiles_v3` は HTTP を知らない pure-Dart core とし、既存 range validator だけを public barrel へ公開する。Dio request、strict response validation、strong ETag generation、bounded LRU、in-flight coordination、terminal lifecycle は `seismicity_pmtiles` 内に置く。Network の具象 reader は private にし、既存の public `SeismicityRandomAccessReaderFactory` が `PmTilesRandomAccessReader` として返す。

**Tech Stack:** Dart 3.11 / Flutter 3.44 / Dio / Freezed / build_runner / package:test / EQMonitor workspace lint

## Global Constraints

- Issue #1600 の Network reader、public failures、Factory wiring、unit tests、依存宣言だけを変更する。manifest 取得、EQMonitor API 型変換、MVT decode、app UI、実ネットワーク、device、simulator、E2E は対象外。
- `packages/pmtiles_v3` に Dio や HTTP code を追加しない。`PmTilesRandomAccessReader` の `sizeBytes`、`readAt`、`close` signature と File/Asset 実装を維持する。
- `PmTilesV3RangeValidator` は `package:pmtiles_v3/pmtiles_v3.dart` から export する。`package:pmtiles_v3/src/...` import は production/test のどちらにも追加しない。
- Network request は `GET`、`Range: bytes=<offset>-<inclusiveEnd>`、`ResponseType.bytes` を使う。status `206` だけを受理し、`200` 全文応答を cache/bytes として扱わない。
- ETag は RFC entity-tag の strong form、すなわち `"` + etagc* + `"` だけを受理する。etagc は `0x21`、`0x23..0x7e`、`0x80..0xff`。`*`、`W/`、unquoted、内側の `"`、control、`0xff` 超の code unit は拒否する。
- 最初の完全検証済み `206` の strong ETag を固定し、後続 request に同じ文字列を `If-Match` として送る。identity 確立前の異なる range は最初の request 完了まで待機する。
- `412`、ETag 欠落、不正 ETag、固定 ETag と異なる ETag は reader を terminally poison する。保存した typed failure を future reads に再送出し、LRU を消去し、別の in-flight request を cancel する。
- `Content-Range` は `bytes <start>-<end>/<total>` の完全一致 grammar とし、start/end/total を requested offset/inclusive end/descriptor `expectedSizeBytes` と照合する。body length も requested length と一致させる。
- LRU key は archive URI、固定 strong ETag、offset、length。aggregate `Uint8List.length` は injected positive byte budget 以下。budget より大きい value は返すが cache しない。
- 同一 key の同時 read は同じ in-flight Future を共有する。caller `CancelToken`、terminal poison、`close()` は未完了 Dio request を停止する。
- Active reader の `close()` は terminal `closed` を設定して request を cancel し、in-flight Futures が success/failure どちらで settle しても正常完了する。同じ close Future を返す。read-after-close は `SeismicityPmTilesClosedException`、外部 cancel 後は `SeismicityPmTilesCancelledException`。
- public failures は Freezed `SeismicityPmTilesException`。Dio exception、raw response body、例外文字列を caller へ露出しない。
- 新規 production code に `dynamic`、`Object`、null assertion、class 内 private method を使わない。private concrete reader は許可し、処理は named public methods を持つ focused collaborator classes に分割する。
- Dio は `(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)` で追加する。`pubspec.yaml` を直接編集しない。生成は `mise exec -- dart run build_runner build --delete-conflicting-outputs`。
- 各 logical commit は概ね 30–100 hand-written lines に収め、生成 Freezed output は同じ contract commit に含める。各 commit 後の push command は plan に含めるが、この plan 修正作業では実行しない。

---

## File Structure

| File | Responsibility |
|---|---|
| `packages/pmtiles_v3/lib/pmtiles_v3.dart` | 既存 `PmTilesV3RangeValidator` を public export する。 |
| `packages/pmtiles_v3/test/public_api_compile_test.dart` | barrel 経由で validator contract が利用可能なことを固定する。 |
| `packages/seismicity_pmtiles/pubspec.yaml` / root `pubspec.lock` | pub command で Dio dependency を解決する。 |
| `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart` | transport/protocol/generation/cancel/closed typed failures。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart` | validated offset/length から Range/If-Match Dio Options を作る。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_response_validator.dart` | 206、Content-Range、body、strong ETag を pure validation する。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart` | private reader、ETag generation、LRU、in-flight、cancel/close terminal state。 |
| `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart` | descriptor から private Network reader または既存 File/Asset reader を返す public boundary。 |
| `packages/seismicity_pmtiles/test/support/network_range_test_support.dart` | socket を使わない typed `HttpClientAdapter` fixture。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart` | Range/If-Match request unit tests。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_response_validator_test.dart` | literal protocol/ETag/body validation tests。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart` | Factory 経由の identity/cache/in-flight/lifecycle tests。 |
| `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart` | Network wiring と File/Asset no-regression。 |
| `packages/seismicity_pmtiles/test/model/public_contracts_test.dart` | 新規 failure union の exhaustive compile coverage。 |
| `packages/seismicity_pmtiles/test/public_api_compile_test.dart` | public Factory signature と `PmTilesRandomAccessReader` return type。 |

## Public Interfaces

Network concrete class は export しない。既存 reader interface と変更後 Factory だけが public API になる。

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

The Factory returns `invalidDescriptor` without HTTP when Network `expectedSizeBytes <= 0` or `networkMaxCacheBytes <= 0`. Therefore no invalid public path can instantiate the private Network reader.

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

## Test Fixture Interfaces

The reader/Factory tests create these concrete helpers in `test/support/network_range_test_support.dart`; later task snippets use only these names.

```dart
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';

sealed class NetworkRangeReply {
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  });
}

final class StaticNetworkRangeReply implements NetworkRangeReply {
  const StaticNetworkRangeReply({
    required this.statusCode,
    required this.body,
    required this.etag,
    required this.contentRange,
  });

  final int statusCode;
  final List<int> body;
  final String? etag;
  final String? contentRange;

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) async {
    return responseBody(
      statusCode: statusCode,
      body: body,
      etag: etag,
      contentRange: contentRange,
    );
  }
}

final class FailingNetworkRangeReply implements NetworkRangeReply {
  const FailingNetworkRangeReply({required this.statusCode});

  final int? statusCode;

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) {
    final status = statusCode;
    return Future<ResponseBody>.error(
      DioException(
        requestOptions: options,
        response: status == null
            ? null
            : Response<void>(requestOptions: options, statusCode: status),
        type: DioExceptionType.connectionError,
      ),
    );
  }
}

final class PendingRangeResponse implements NetworkRangeReply {
  PendingRangeResponse({
    required this.offset,
    required this.total,
    required this.etag,
  });

  final int offset;
  final int total;
  final String? etag;
  final Completer<List<int>> completer = Completer<List<int>>();
  bool cancelled = false;

  void complete(List<int> bytes) => completer.complete(bytes);

  @override
  Future<ResponseBody> resolve({
    required RequestOptions options,
    required Future<void>? cancelFuture,
  }) {
    final success = completer.future.then(
      (bytes) => responseBody(
        statusCode: 206,
        body: bytes,
        etag: etag,
        contentRange: 'bytes $offset-${offset + bytes.length - 1}/$total',
      ),
    );
    final cancellation = cancelFuture;
    if (cancellation == null) {
      return success;
    }
    return Future<ResponseBody>.any(<Future<ResponseBody>>[
      success,
      cancellation.then<ResponseBody>((_) {
        cancelled = true;
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
        );
      }),
    ]);
  }
}

final class NetworkRangeTestAdapter implements HttpClientAdapter {
  final Queue<NetworkRangeReply> replies = Queue<NetworkRangeReply>();
  final List<RequestOptions> requests = <RequestOptions>[];

  void enqueue206({
    required int offset,
    required List<int> bytes,
    required int total,
    required String? etag,
  }) {
    enqueueResponse(
      statusCode: 206,
      body: bytes,
      etag: etag,
      contentRange: 'bytes $offset-${offset + bytes.length - 1}/$total',
    );
  }

  void enqueueResponse({
    required int statusCode,
    required List<int> body,
    String? etag,
    String? contentRange,
  }) {
    replies.add(
      StaticNetworkRangeReply(
        statusCode: statusCode,
        body: body,
        etag: etag,
        contentRange: contentRange,
      ),
    );
  }

  void enqueueDioFailure({required int? statusCode}) {
    replies.add(FailingNetworkRangeReply(statusCode: statusCode));
  }

  PendingRangeResponse enqueuePending206({
    required int offset,
    required int total,
    required String? etag,
  }) {
    final reply = PendingRangeResponse(
      offset: offset,
      total: total,
      etag: etag,
    );
    replies.add(reply);
    return reply;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    if (replies.isEmpty) {
      throw StateError('No queued mock response.');
    }
    return replies.removeFirst().resolve(
      options: options,
      cancelFuture: cancelFuture,
    );
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody responseBody({
  required int statusCode,
  required List<int> body,
  required String? etag,
  required String? contentRange,
}) {
  return ResponseBody.fromBytes(
    body,
    statusCode,
    headers: <String, List<String>>{
      if (etag != null) Headers.etagHeader: <String>[etag],
      if (contentRange != null) 'content-range': <String>[contentRange],
    },
  );
}

SeismicityPmTilesArchiveDescriptor networkDescriptor({
  required int sizeBytes,
}) {
  return descriptorFor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
    ),
    sizeBytes: sizeBytes,
  );
}

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

SeismicityRandomAccessReaderFactory networkFactory({
  required NetworkRangeTestAdapter adapter,
  required int maxCacheBytes,
}) {
  final dio = Dio()..httpClientAdapter = adapter;
  return SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) async => Uint8List(0),
    dio: dio,
    networkMaxCacheBytes: maxCacheBytes,
  );
}

Future<PmTilesRandomAccessReader> readerFrom(
  Future<SeismicityPmTilesResult<PmTilesRandomAccessReader>> result,
) async {
  return switch (await result) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
}

Future<PmTilesRandomAccessReader> successfulNetworkReader({
  required NetworkRangeTestAdapter adapter,
  int maxCacheBytes = 8,
  CancelToken? cancelToken,
}) {
  return readerFrom(
    networkFactory(adapter: adapter, maxCacheBytes: maxCacheBytes).create(
      descriptor: networkDescriptor(sizeBytes: 16),
      cancelToken: cancelToken ?? CancelToken(),
    ),
  );
}
```

An empty queue throws `StateError('No queued mock response.')`, making every unexpected request fail the test.

### Task 1: Export the existing core range validator

**Files:**

- Modify: `packages/pmtiles_v3/lib/pmtiles_v3.dart`
- Create: `packages/pmtiles_v3/test/public_api_compile_test.dart`

**Interfaces:**

- Consumes: existing `PmTilesV3RangeValidator.validate({required int offset, required int length, required int sizeBytes})`.
- Produces: the same class through `package:pmtiles_v3/pmtiles_v3.dart`; later tasks never import `src/`.

- [ ] **Step 1: Write the failing public barrel test**

```dart
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:test/test.dart';

void main() {
  test('range validator is available from the public barrel', () {
    const validator = PmTilesV3RangeValidator();
    expect(
      () => validator.validate(offset: 15, length: 2, sizeBytes: 16),
      throwsA(
        isA<PmTilesV3InvalidRangeException>()
            .having((failure) => failure.offset, 'offset', 15)
            .having((failure) => failure.length, 'length', 2)
            .having((failure) => failure.sizeBytes, 'sizeBytes', 16),
      ),
    );
  });
}
```

- [ ] **Step 2: Verify RED**

Run: `mise exec -- dart test packages/pmtiles_v3/test/public_api_compile_test.dart`

Expected: compile FAIL with `Method not found: 'PmTilesV3RangeValidator'` because the barrel does not export it.

- [ ] **Step 3: Export the validator and verify GREEN**

Add exactly:

```dart
export 'src/reader/pmtiles_v3_range_validator.dart'
    show PmTilesV3RangeValidator;
```

Run: `mise exec -- dart test packages/pmtiles_v3/test/public_api_compile_test.dart`

Expected: PASS.

- [ ] **Step 4: Commit and push the core boundary**

```bash
git add packages/pmtiles_v3/lib/pmtiles_v3.dart \
  packages/pmtiles_v3/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles範囲検証を公開"
git push -u origin feat/seismicity-pmtiles-network-reader
```

### Task 2: Add Dio and typed Network lifecycle failures

**Files:**

- Modify: `packages/seismicity_pmtiles/pubspec.yaml` through pub command
- Modify: root `pubspec.lock` through pub command
- Modify: `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart`
- Modify: generated `packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart`
- Modify: `packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

**Interfaces:**

- Consumes: existing `SeismicityPmTilesSource` and exception union.
- Produces: the five exact failure constructors in Public Interfaces.

- [ ] **Step 1: Write the failing exhaustive contract test**

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
    reason: 'Content-Range must equal bytes 4-6/16.',
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

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected: compile FAIL because `networkRequestFailed`, `invalidNetworkResponse`, `archiveChanged`, `cancelled`, and `closed` are undefined.

- [ ] **Step 3: Add the dependency and failures**

Run exactly:

```bash
(cd packages/seismicity_pmtiles && mise exec -- flutter pub add dio)
```

Add the five constructors from Public Interfaces and regenerate:

```bash
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
```

- [ ] **Step 4: Verify GREEN**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/model/public_contracts_test.dart`

Expected: PASS with an exhaustive switch arm for every new subtype.

- [ ] **Step 5: Commit and push the failure contract**

```bash
git add packages/seismicity_pmtiles/pubspec.yaml pubspec.lock \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.dart \
  packages/seismicity_pmtiles/lib/src/model/seismicity_pmtiles_exception.freezed.dart \
  packages/seismicity_pmtiles/test/model/public_contracts_test.dart
git commit -m "Feat: PMTiles通信失敗の型を追加"
git push origin HEAD
```

Generated Freezed output may exceed 100 lines; the hand-written contract/test portion remains one reviewable failure-model change.

### Task 3: Build exact Range requests and parse strong ETags

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart`

**Interfaces:**

- Consumes: public `PmTilesV3RangeValidator`, Dio `Options`.
- Produces:

```dart
final class SeismicityPmTilesHttpRangeRequestBuilder {
  const SeismicityPmTilesHttpRangeRequestBuilder();

  Options build({
    required int offset,
    required int length,
    required int sizeBytes,
    required String? strongEtag,
  });
}

final class SeismicityPmTilesStrongEtagValidator {
  const SeismicityPmTilesStrongEtagValidator();
  bool isValid({required String value});
}
```

- [ ] **Step 1: Write executable request/ETag tests**

```dart
test('builds inclusive Range bytes and ResponseType.bytes', () {
  final options = const SeismicityPmTilesHttpRangeRequestBuilder().build(
    offset: 4,
    length: 3,
    sizeBytes: 16,
    strongEtag: null,
  );
  expect(options.headers, <String, String>{'Range': 'bytes=4-6'});
  expect(options.responseType, ResponseType.bytes);
});

test('adds the exact pinned ETag as If-Match', () {
  final options = const SeismicityPmTilesHttpRangeRequestBuilder().build(
    offset: 2,
    length: 2,
    sizeBytes: 16,
    strongEtag: '"archive-v1"',
  );
  expect(options.headers?['If-Match'], '"archive-v1"');
});

test('rejects invalid range before constructing Options', () {
  expect(
    () => const SeismicityPmTilesHttpRangeRequestBuilder().build(
      offset: 15,
      length: 2,
      sizeBytes: 16,
      strongEtag: null,
    ),
    throwsA(isA<PmTilesV3InvalidRangeException>()),
  );
});

for (final valid in ['""', '"archive-v1"', '"!#~ÿ"']) {
  test('accepts quoted strong entity-tag $valid', () {
    expect(
      const SeismicityPmTilesStrongEtagValidator().isValid(value: valid),
      isTrue,
    );
  });
}

for (final invalid in [
  '*',
  'W/"archive-v1"',
  'archive-v1',
  '"archive"v1"',
  '"line\nbreak"',
  '"Ā"',
  '"unterminated',
]) {
  test('rejects non-strong entity-tag $invalid', () {
    expect(
      const SeismicityPmTilesStrongEtagValidator().isValid(value: invalid),
      isFalse,
    );
  });
}
```

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart`

Expected: compile FAIL because the new request-builder library does not exist.

- [ ] **Step 3: Implement the two focused classes**

Use `PmTilesV3RangeValidator.validate` before calculating inclusive end. `isValid` checks the opening/closing quote and every inner `codeUnit` against `0x21 || 0x23..0x7e || 0x80..0xff`; it does not trim or normalize the header.

- [ ] **Step 4: Verify GREEN, commit, and push**

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_http_range_request.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_http_range_request_test.dart
git commit -m "Feat: PMTiles通信Range要求を構築"
git push origin HEAD
```

### Task 4: Validate every HTTP response field before returning bytes

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_response_validator.dart`
- Create: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_response_validator_test.dart`

**Interfaces:**

- Consumes: `Response<Uint8List>`, Task 3 strong ETag validator, Task 2 failures.
- Produces:

```dart
final class SeismicityPmTilesValidatedRangeResponse {
  const SeismicityPmTilesValidatedRangeResponse({
    required this.bytes,
    required this.strongEtag,
  });
  final Uint8List bytes;
  final String strongEtag;
}

final class SeismicityPmTilesNetworkResponseValidator {
  const SeismicityPmTilesNetworkResponseValidator();

  SeismicityPmTilesValidatedRangeResponse validate({
    required Response<Uint8List> response,
    required SeismicityPmTilesNetworkSource source,
    required int requestedOffset,
    required int requestedLength,
    required int expectedSizeBytes,
    required String? expectedEtag,
  });
}
```

- [ ] **Step 1: Create the typed response fixture and executable success test**

```dart
Response<Uint8List> rangeResponseFixture({
  required int statusCode,
  required List<int> body,
  required String? etag,
  required String? contentRange,
}) {
  return Response<Uint8List>(
    requestOptions: RequestOptions(path: 'https://example.com/archive.pmtiles'),
    statusCode: statusCode,
    data: Uint8List.fromList(body),
    headers: Headers.fromMap(<String, List<String>>{
      if (etag != null) Headers.etagHeader: <String>[etag],
      if (contentRange != null) 'content-range': <String>[contentRange],
    }),
  );
}

test('accepts only the exact validated 206 response', () {
  final result = validator.validate(
    response: rangeResponseFixture(
      statusCode: 206,
      body: [4, 5, 6],
      etag: '"archive-v1"',
      contentRange: 'bytes 4-6/16',
    ),
    source: source,
    requestedOffset: 4,
    requestedLength: 3,
    expectedSizeBytes: 16,
    expectedEtag: null,
  );
  expect(result.bytes, orderedEquals([4, 5, 6]));
  expect(result.strongEtag, '"archive-v1"');
});
```

- [ ] **Step 2: Add literal typed rejection tests**

```dart
test('rejects unsafe 200 without returning its full body', () {
  expect(
    () => validator.validate(
      response: rangeResponseFixture(
        statusCode: 200,
        body: List<int>.filled(16, 1),
        etag: '"archive-v1"',
        contentRange: null,
      ),
      source: source,
      requestedOffset: 4,
      requestedLength: 3,
      expectedSizeBytes: 16,
      expectedEtag: null,
    ),
    throwsA(
      isA<SeismicityPmTilesInvalidNetworkResponseException>()
          .having((failure) => failure.source, 'source', source)
          .having((failure) => failure.statusCode, 'statusCode', 200)
          .having(
            (failure) => failure.reason,
            'reason',
            'Expected HTTP 206 Partial Content.',
          ),
    ),
  );
});

test('maps 412 to archiveChanged with exact identity fields', () {
  expect(
    () => validator.validate(
      response: rangeResponseFixture(
        statusCode: 412,
        body: const [],
        etag: '"archive-v2"',
        contentRange: null,
      ),
      source: source,
      requestedOffset: 4,
      requestedLength: 3,
      expectedSizeBytes: 16,
      expectedEtag: '"archive-v1"',
    ),
    throwsA(
      isA<SeismicityPmTilesArchiveChangedException>()
          .having((failure) => failure.expectedEtag, 'expectedEtag', '"archive-v1"')
          .having((failure) => failure.receivedEtag, 'receivedEtag', '"archive-v2"')
          .having((failure) => failure.statusCode, 'statusCode', 412),
    ),
  );
});
```

Execute the complete invalid-response table below:

```dart
final invalidResponses = <({
  String name,
  int status,
  List<int> body,
  String? etag,
  String? contentRange,
  String reason,
})>[
  (name: '204', status: 204, body: const [], etag: '"archive-v1"', contentRange: null, reason: 'Expected HTTP 206 Partial Content.'),
  (name: 'missing first ETag', status: 206, body: const [4, 5, 6], etag: null, contentRange: 'bytes 4-6/16', reason: 'Response ETag must be one quoted strong entity-tag.'),
  (name: 'wildcard ETag', status: 206, body: const [4, 5, 6], etag: '*', contentRange: 'bytes 4-6/16', reason: 'Response ETag must be one quoted strong entity-tag.'),
  (name: 'weak ETag', status: 206, body: const [4, 5, 6], etag: 'W/"archive-v1"', contentRange: 'bytes 4-6/16', reason: 'Response ETag must be one quoted strong entity-tag.'),
  (name: 'unquoted ETag', status: 206, body: const [4, 5, 6], etag: 'archive-v1', contentRange: 'bytes 4-6/16', reason: 'Response ETag must be one quoted strong entity-tag.'),
  (name: 'missing Content-Range', status: 206, body: const [4, 5, 6], etag: '"archive-v1"', contentRange: null, reason: 'Content-Range must equal bytes 4-6/16.'),
  (name: 'wrong start', status: 206, body: const [4, 5, 6], etag: '"archive-v1"', contentRange: 'bytes 5-7/16', reason: 'Content-Range must equal bytes 4-6/16.'),
  (name: 'wrong end', status: 206, body: const [4, 5, 6], etag: '"archive-v1"', contentRange: 'bytes 4-7/16', reason: 'Content-Range must equal bytes 4-6/16.'),
  (name: 'wrong total', status: 206, body: const [4, 5, 6], etag: '"archive-v1"', contentRange: 'bytes 4-6/15', reason: 'Content-Range must equal bytes 4-6/16.'),
  (name: 'malformed range', status: 206, body: const [4, 5, 6], etag: '"archive-v1"', contentRange: 'bytes 4-6/*', reason: 'Content-Range must equal bytes 4-6/16.'),
  (name: 'short body', status: 206, body: const [4, 5], etag: '"archive-v1"', contentRange: 'bytes 4-6/16', reason: 'Expected 3 response bytes but received 2.'),
];

for (final fixture in invalidResponses) {
  test('rejects ${fixture.name}', () {
    expect(
      () => validator.validate(
        response: rangeResponseFixture(
          statusCode: fixture.status,
          body: fixture.body,
          etag: fixture.etag,
          contentRange: fixture.contentRange,
        ),
        source: source,
        requestedOffset: 4,
        requestedLength: 3,
        expectedSizeBytes: 16,
        expectedEtag: null,
      ),
      throwsA(
        isA<SeismicityPmTilesInvalidNetworkResponseException>()
            .having((failure) => failure.source, 'source', source)
            .having((failure) => failure.statusCode, 'statusCode', fixture.status)
            .having((failure) => failure.reason, 'reason', fixture.reason),
      ),
    );
  });
}
```

Add the changed/missing-follow-up cases with this executable table and body:

```dart
for (final fixture in <({String name, String? received})>[
  (name: 'missing follow-up ETag', received: null),
  (name: 'changed follow-up ETag', received: '"archive-v2"'),
]) {
  test(fixture.name, () {
    expect(
      () => validator.validate(
        response: rangeResponseFixture(
          statusCode: 206,
          body: const [4, 5, 6],
          etag: fixture.received,
          contentRange: 'bytes 4-6/16',
        ),
        source: source,
        requestedOffset: 4,
        requestedLength: 3,
        expectedSizeBytes: 16,
        expectedEtag: '"archive-v1"',
      ),
      throwsA(
        isA<SeismicityPmTilesArchiveChangedException>()
            .having((failure) => failure.source, 'source', source)
            .having((failure) => failure.expectedEtag, 'expectedEtag', '"archive-v1"')
            .having((failure) => failure.receivedEtag, 'receivedEtag', fixture.received)
            .having((failure) => failure.statusCode, 'statusCode', 206),
      ),
    );
  });
}
```

- [ ] **Step 3: Verify RED, implement pure validation, and verify GREEN**

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_response_validator_test.dart
```

Expected RED: compile FAIL because validator and fixture files do not exist.

Implement exact status order: handle `412`; require `206`; validate ETag grammar/equality; match `Content-Range` with `RegExp(r'^bytes ([0-9]+)-([0-9]+)/([0-9]+)$')`; compare all integers; compare body length; copy bytes into the validated result.

Run the same test command. Expected GREEN: PASS.

- [ ] **Step 4: Commit and push response validation**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_response_validator.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_response_validator_test.dart
git commit -m "Feat: PMTiles通信応答を厳密検証"
git push origin HEAD
```

### Task 5: Add the private reader behind the public Factory

**Files:**

- Create: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Create: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Modify: `packages/seismicity_pmtiles/test/public_api_compile_test.dart`

**Interfaces:**

- Consumes: Tasks 1–4 collaborators and failures.
- Produces: public Factory signature in Public Interfaces; private `_SeismicityPmTilesNetworkRandomAccessReader`; no concrete Network class barrel export.

- [ ] **Step 1: Write executable Factory invariants and sequential identity tests**

```dart
test('rejects invalid Network construction inputs without HTTP', () async {
  for (final fixture in <({int sizeBytes, int cacheBytes, String reason})>[
    (sizeBytes: 0, cacheBytes: 8, reason: 'Expected archive size must be positive.'),
    (sizeBytes: 16, cacheBytes: 0, reason: 'Network cache byte budget must be positive.'),
  ]) {
    final result = await networkFactory(
      adapter: adapter,
      maxCacheBytes: fixture.cacheBytes,
    ).create(
      descriptor: networkDescriptor(sizeBytes: fixture.sizeBytes),
      cancelToken: CancelToken(),
    );
    expect(
      result,
      isA<SeismicityPmTilesFailure<PmTilesRandomAccessReader>>().having(
        (failure) => failure.exception,
        'exception',
        isA<SeismicityPmTilesInvalidDescriptorException>().having(
          (failure) => failure.reason,
          'reason',
          fixture.reason,
        ),
      ),
    );
  }
  expect(adapter.requests, isEmpty);
});

test('pins first ETag and sends If-Match on next range', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: '"v1"');
  adapter.enqueue206(offset: 2, bytes: [2, 3], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  expect(await reader.readAt(offset: 0, length: 2), orderedEquals([0, 1]));
  expect(await reader.readAt(offset: 2, length: 2), orderedEquals([2, 3]));
  expect(adapter.requests[0].headers.containsKey('If-Match'), isFalse);
  expect(adapter.requests[1].headers['If-Match'], '"v1"');
});
```

Add the exact invalid-range, transport, and external-cancel bodies:

```dart
test('rejects out-of-file range before HTTP', () async {
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  await expectLater(
    reader.readAt(offset: 15, length: 2),
    throwsA(
      isA<SeismicityPmTilesInvalidRangeException>()
          .having((failure) => failure.offset, 'offset', 15)
          .having((failure) => failure.length, 'length', 2)
          .having((failure) => failure.sizeBytes, 'sizeBytes', 16),
    ),
  );
  expect(adapter.requests, isEmpty);
});

test('translates Dio transport failure without leaking DioException', () async {
  adapter.enqueueDioFailure(statusCode: 503);
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  final source = networkDescriptor(sizeBytes: 16).source;
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(
      isA<SeismicityPmTilesNetworkRequestFailedException>()
          .having((failure) => failure.source, 'source', source)
          .having((failure) => failure.statusCode, 'statusCode', 503),
    ),
  );
});

test('external cancellation is terminal and sends no request', () async {
  final cancelToken = CancelToken()..cancel('fixture cancelled');
  final reader = await successfulNetworkReader(
    adapter: adapter,
    cancelToken: cancelToken,
  );
  addTearDown(reader.close);
  final source = networkDescriptor(sizeBytes: 16).source;
  final matcher = isA<SeismicityPmTilesCancelledException>()
      .having((failure) => failure.source, 'source', source);
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
  await expectLater(reader.readAt(offset: 2, length: 2), throwsA(matcher));
  expect(adapter.requests, isEmpty);
});
```

- [ ] **Step 2: Verify RED**

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected: compile FAIL because the reader file and descriptor-aware Factory API do not exist; it is not a `readAt` runtime failure.

- [ ] **Step 3: Implement the private reader and minimal close contract**

The Factory validates positive `expectedSizeBytes` and `networkMaxCacheBytes`, then creates the private reader. `readAt` performs one request at a time, pins only a fully validated ETag, and translates `PmTilesV3Exception` with the existing extension.

In this task, `close()` has the minimal contract required before in-flight bookkeeping exists: it synchronously sets terminal `closed`, calls the shared `CancelToken.cancel`, memoizes and returns `Future<void>.value()`. It does not wait for a request Future yet. A pending request observes cancellation and resolves as `SeismicityPmTilesClosedException`; read-after-close throws the same subtype before request construction. Task 7 strengthens close to wait for all tracked Futures while preserving these public outcomes.

- [ ] **Step 4: Add exact minimal close tests and verify GREEN**

```dart
test('minimal close is idempotent and read-after-close is typed', () async {
  final reader = await successfulNetworkReader(adapter: adapter);
  final firstClose = reader.close();
  final secondClose = reader.close();
  expect(identical(firstClose, secondClose), isTrue);
  await firstClose;
  await expectLater(
    reader.readAt(offset: 0, length: 2),
    throwsA(
      isA<SeismicityPmTilesClosedException>()
          .having((failure) => failure.source, 'source', source),
    ),
  );
  expect(adapter.requests, isEmpty);
});
```

Run:

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
mise exec -- flutter test packages/seismicity_pmtiles/test/public_api_compile_test.dart
```

Expected: PASS. `public_api_compile_test` constructs only `SeismicityRandomAccessReaderFactory`; it never names the private reader.

- [ ] **Step 5: Commit and push the Factory/reader slice**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart \
  packages/seismicity_pmtiles/test/public_api_compile_test.dart
git commit -m "Feat: PMTiles通信ReaderをFactoryへ接続"
git push origin HEAD
```

### Task 6: Add aggregate-byte LRU behavior

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

**Interfaces:**

- Consumes: Task 5 private reader and pinned ETag.
- Produces: per-reader cache keyed by `({Uri archiveUri, String strongEtag, int offset, int length})` with exact aggregate byte accounting.

- [ ] **Step 1: Write executable hit/eviction/oversize tests**

```dart
test('same identity offset and length is a cache hit', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1, 2], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter, maxCacheBytes: 5);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(1));
});

test('evicts only the least-recently-used two-byte entry at budget five', () async {
  adapter
    ..enqueue206(offset: 0, bytes: [0, 1, 2], total: 16, etag: '"v1"')
    ..enqueue206(offset: 3, bytes: [3, 4], total: 16, etag: '"v1"')
    ..enqueue206(offset: 5, bytes: [5, 6], total: 16, etag: '"v1"')
    ..enqueue206(offset: 3, bytes: [3, 4], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter, maxCacheBytes: 5);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 3, length: 2);
  await reader.readAt(offset: 0, length: 3); // touch the 3-byte entry
  await reader.readAt(offset: 5, length: 2); // 3 + 2 + 2; evict old (3, 2)
  await reader.readAt(offset: 0, length: 3); // still cached
  await reader.readAt(offset: 3, length: 2); // fetched again
  expect(adapter.requests, hasLength(4));
});

test('returns but does not cache a value larger than budget', () async {
  adapter
    ..enqueue206(offset: 0, bytes: [0, 1, 2], total: 16, etag: '"v1"')
    ..enqueue206(offset: 0, bytes: [0, 1, 2], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter, maxCacheBytes: 2);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 3);
  await reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(2));
});
```

- [ ] **Step 2: Verify RED, implement LRU, and verify GREEN**

Run the reader test file. Expected RED: cache-hit test records 2 requests.

Use an access-ordered `LinkedHashMap` and integer cached-byte count. Copy inserted bytes. Evict oldest entries until `cachedBytes + newBytes.length <= maxCacheBytes`. Never insert an oversize value.

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected GREEN: PASS, including the corrected 5-byte arithmetic above.

- [ ] **Step 3: Commit and push LRU**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信RangeをLRU保持"
git push origin HEAD
```

### Task 7: Coordinate identity establishment and in-flight requests

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/test/support/network_range_test_support.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

**Interfaces:**

- Consumes: Task 5 terminal failures and Task 6 LRU.
- Produces: same public reader interface with one initial identity gate and same-key Future dedupe. Terminal poison and close settlement remain Task 8.

- [ ] **Step 1: Add executable identity and concurrency tests**

```dart
test('shares one Future for concurrent reads of one range', () async {
  final pending = adapter.enqueuePending206(
    offset: 0,
    total: 16,
    etag: '"v1"',
  );
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  final first = reader.readAt(offset: 0, length: 3);
  final second = reader.readAt(offset: 0, length: 3);
  expect(adapter.requests, hasLength(1));
  pending.complete([0, 1, 2]);
  expect(await first, orderedEquals([0, 1, 2]));
  expect(await second, orderedEquals([0, 1, 2]));
});

test('waits for identity before sending a different range', () async {
  final pending = adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  adapter.enqueue206(offset: 3, bytes: [3, 4], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  final first = reader.readAt(offset: 0, length: 3);
  final second = reader.readAt(offset: 3, length: 2);
  expect(adapter.requests, hasLength(1));
  pending.complete([0, 1, 2]);
  await first;
  await second;
  expect(adapter.requests[1].headers['If-Match'], '"v1"');
});

```

- [ ] **Step 2: Verify RED, implement identity/in-flight coordination, and verify GREEN**

Run the reader test file. Expected RED: two same-range requests are recorded or different initial ranges start together.

Implement one pre-identity gate Future. Concurrent reads of the same pre-identity range reuse it; a different range awaits it and is then sent with `If-Match`. After identity exists, store one Future per URI/ETag/offset/length key before awaiting, remove it in `whenComplete`, and cache only the validated result.

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected GREEN: PASS.

- [ ] **Step 3: Commit and push in-flight coordination**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの同時取得を共有"
git push origin HEAD
```

### Task 8: Make poison and close terminal across all in-flight requests

**Files:**

- Modify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

**Interfaces:**

- Consumes: Task 7 in-flight registry and Task 6 LRU.
- Produces: sticky poison/closed/cancelled states, peer cancellation, cache clearing, and a memoized close Future that settles successfully after all reads settle.

- [ ] **Step 1: Add executable close-settlement test**

```dart
test('close waits for cancelled inflight and completes successfully', () async {
  adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter);
  final read = reader.readAt(offset: 0, length: 3);
  final firstClose = reader.close();
  final secondClose = reader.close();
  expect(identical(firstClose, secondClose), isTrue);
  await expectLater(read, throwsA(isA<SeismicityPmTilesClosedException>()));
  await expectLater(firstClose, completes);
});
```

- [ ] **Step 2: Add executable poison tests**

```dart
test('changed ETag poisons reader, clears cache, cancels peers, and is sticky', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter, maxCacheBytes: 8);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 2); // cached under v1

  final peer = adapter.enqueuePending206(offset: 4, total: 16, etag: '"v1"');
  final peerRead = reader.readAt(offset: 4, length: 2);
  adapter.enqueue206(offset: 2, bytes: [2, 3], total: 16, etag: '"v2"');
  final changedRead = reader.readAt(offset: 2, length: 2);

  final matcher = isA<SeismicityPmTilesArchiveChangedException>()
      .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
      .having((failure) => failure.receivedEtag, 'receivedEtag', '"v2"')
      .having((failure) => failure.statusCode, 'statusCode', 206);
  await expectLater(changedRead, throwsA(matcher));
  await expectLater(peerRead, throwsA(matcher));
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
  expect(peer.cancelled, isTrue);
  expect(adapter.requests.where((request) => request.headers['Range'] == 'bytes=0-1'), hasLength(1));
});
```

Add this executable poison matrix for invalid identity responses; `enqueueResponse` uses `contentRange: 'bytes 2-3/16'` and body `[2, 3]`:

```dart
for (final invalidEtag in <String>[
  '*',
  'W/"v1"',
  'v1',
  '"v"1"',
]) {
  test('invalid ETag $invalidEtag poisons and remains sticky', () async {
    adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: '"v1"');
    final reader = await successfulNetworkReader(adapter: adapter);
    addTearDown(reader.close);
    await reader.readAt(offset: 0, length: 2);

    final peer = adapter.enqueuePending206(offset: 4, total: 16, etag: '"v1"');
    final peerRead = reader.readAt(offset: 4, length: 2);
    adapter.enqueueResponse(
      statusCode: 206,
      body: const [2, 3],
      etag: invalidEtag,
      contentRange: 'bytes 2-3/16',
    );
    final poisonRead = reader.readAt(offset: 2, length: 2);

    final matcher = isA<SeismicityPmTilesInvalidNetworkResponseException>()
        .having((failure) => failure.statusCode, 'statusCode', 206)
        .having(
          (failure) => failure.reason,
          'reason',
          'Response ETag must be one quoted strong entity-tag.',
        );
    await expectLater(poisonRead, throwsA(matcher));
    await expectLater(peerRead, throwsA(matcher));
    await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
    expect(peer.cancelled, isTrue);
  });
}

test('412 poisons with archiveChanged and remains sticky', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 2);
  final peer = adapter.enqueuePending206(offset: 4, total: 16, etag: '"v1"');
  final peerRead = reader.readAt(offset: 4, length: 2);
  adapter.enqueueResponse(
    statusCode: 412,
    body: const [],
    etag: '"v2"',
    contentRange: null,
  );
  final matcher = isA<SeismicityPmTilesArchiveChangedException>()
      .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
      .having((failure) => failure.receivedEtag, 'receivedEtag', '"v2"')
      .having((failure) => failure.statusCode, 'statusCode', 412);
  await expectLater(reader.readAt(offset: 2, length: 2), throwsA(matcher));
  await expectLater(peerRead, throwsA(matcher));
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
  expect(peer.cancelled, isTrue);
});

test('missing follow-up ETag poisons with archiveChanged', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: '"v1"');
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  await reader.readAt(offset: 0, length: 2);
  final peer = adapter.enqueuePending206(offset: 4, total: 16, etag: '"v1"');
  final peerRead = reader.readAt(offset: 4, length: 2);
  adapter.enqueue206(offset: 2, bytes: [2, 3], total: 16, etag: null);
  final matcher = isA<SeismicityPmTilesArchiveChangedException>()
      .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
      .having((failure) => failure.receivedEtag, 'receivedEtag', isNull)
      .having((failure) => failure.statusCode, 'statusCode', 206);
  await expectLater(reader.readAt(offset: 2, length: 2), throwsA(matcher));
  await expectLater(peerRead, throwsA(matcher));
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
  expect(peer.cancelled, isTrue);
});

test('missing first ETag poisons before identity and is sticky', () async {
  adapter.enqueue206(offset: 0, bytes: [0, 1], total: 16, etag: null);
  final reader = await successfulNetworkReader(adapter: adapter);
  addTearDown(reader.close);
  final matcher = isA<SeismicityPmTilesInvalidNetworkResponseException>()
      .having((failure) => failure.statusCode, 'statusCode', 206)
      .having(
        (failure) => failure.reason,
        'reason',
        'Response ETag must be one quoted strong entity-tag.',
      );
  await expectLater(reader.readAt(offset: 0, length: 2), throwsA(matcher));
  await expectLater(reader.readAt(offset: 2, length: 2), throwsA(matcher));
  expect(adapter.requests, hasLength(1));
});
```

- [ ] **Step 3: Verify RED, implement terminal lifecycle, and verify GREEN**

Run the reader test file. Expected RED: poison does not cancel peer reads/stick to future reads, or close completes before pending cancellation settles.

Implement a stored terminal failure. The poison transition stores the first generation/protocol failure, clears LRU, cancels the shared token, and makes all cancellation catch paths prefer the stored poison over `cancelled`. The close transition stores `closed` only when no prior terminal failure exists, cancels, snapshots in-flight Futures, converts each success/failure to `Future<void>`, waits for all, clears maps, and returns the memoized Future without propagating read failures.

Run: `mise exec -- flutter test packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart`

Expected GREEN: PASS.

- [ ] **Step 4: Commit and push coordination**

```bash
git add packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart \
  packages/seismicity_pmtiles/test/support/network_range_test_support.dart \
  packages/seismicity_pmtiles/test/reader/seismicity_pmtiles_network_random_access_reader_test.dart
git commit -m "Feat: PMTiles通信Readerの世代と取消を管理"
git push origin HEAD
```

### Task 9: Preserve File/Asset behavior and run the complete gate

**Files:**

- Modify: `packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart`
- Verify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_random_access_reader_factory.dart`
- Verify: `packages/seismicity_pmtiles/lib/src/reader/seismicity_pmtiles_network_random_access_reader.dart`
- Verify: all `packages/seismicity_pmtiles/test/**/*.dart`
- Verify: all `packages/pmtiles_v3/test/**/*.dart`

**Interfaces:**

- Consumes: all Task 1–8 contracts.
- Produces: mock-only package proof that Network is isolated and File/Asset behavior is unchanged.

- [ ] **Step 1: Add executable File/Asset/Network routing regressions**

```dart
test('File still uses file random access without Dio or asset loading', () async {
  final result = await factory.create(
    descriptor: descriptorFor(
      source: SeismicityPmTilesSource.file(path: archiveFile.path),
      sizeBytes: 4,
    ),
    cancelToken: CancelToken(),
  );
  final reader = switch (result) {
    SeismicityPmTilesSuccess(:final value) => value,
    SeismicityPmTilesFailure(:final exception) => throw exception,
  };
  addTearDown(reader.close);
  expect(reader, isA<PmTilesV3FileRandomAccessReader>());
  expect(await reader.readAt(offset: 1, length: 2), orderedEquals([2, 3]));
  expect(adapter.requests, isEmpty);
  expect(assetLoadCount, 0);
});

test('Asset still loads once and Network never falls back to Asset', () async {
  final assetResult = await factory.create(
    descriptor: descriptorFor(
      source: const SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles'),
      sizeBytes: 4,
    ),
    cancelToken: CancelToken(),
  );
  expect(assetResult, isA<SeismicityPmTilesSuccess<PmTilesRandomAccessReader>>());
  expect(assetLoadCount, 1);

  adapter.enqueueResponse(statusCode: 200, body: List<int>.filled(16, 1));
  final networkReader = await readerFrom(
    factory.create(
      descriptor: networkDescriptor(sizeBytes: 16),
      cancelToken: CancelToken(),
    ),
  );
  addTearDown(networkReader.close);
  await expectLater(
    networkReader.readAt(offset: 0, length: 2),
    throwsA(isA<SeismicityPmTilesInvalidNetworkResponseException>()),
  );
  expect(assetLoadCount, 1);
});
```

Retain missing-file and throwing-asset-loader behavior with these exact bodies:

```dart
test('missing File remains a source-aware typed failure', () async {
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
  expect(adapter.requests, isEmpty);
  expect(assetLoadCount, 0);
});

test('throwing Asset loader remains a source-aware typed failure', () async {
  const source = SeismicityPmTilesSource.asset(assetKey: 'missing.pmtiles');
  final dio = Dio()..httpClientAdapter = adapter;
  final failingFactory = SeismicityRandomAccessReaderFactory(
    assetLoader: ({required assetKey}) =>
        Future<Uint8List>.error(StateError('asset unavailable')),
    dio: dio,
    networkMaxCacheBytes: 8,
  );
  final result = await failingFactory.create(
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
  expect(adapter.requests, isEmpty);
});
```

- [ ] **Step 2: Run the complete focused gate**

```bash
mise exec -- flutter test packages/seismicity_pmtiles/test
mise exec -- dart test packages/pmtiles_v3/test
mise exec -- dart format --set-exit-if-changed packages/seismicity_pmtiles packages/pmtiles_v3
(cd packages/seismicity_pmtiles && mise exec -- dart run build_runner build --delete-conflicting-outputs)
mise exec -- dart analyze packages/seismicity_pmtiles
mise exec -- dart analyze packages/pmtiles_v3
git diff --check
```

Expected: every command exits 0. Tests use only the typed mock adapter; no `HttpClient`, device, simulator, E2E, app source, or real URL fetch appears.

- [ ] **Step 3: Commit and push the no-regression tests**

```bash
git add packages/seismicity_pmtiles/test/reader/seismicity_random_access_reader_factory_test.dart
git commit -m "Test: PMTiles FileとAsset経路を回帰確認"
git push origin HEAD
```

- [ ] **Step 4: Review final scope and commit sizes**

Run:

```bash
git --no-pager diff origin/develop...HEAD --stat
git --no-pager log --oneline --stat origin/develop..HEAD
rg -n 'package:pmtiles_v3/src/|ResponseType\.stream|HttpClient\(' \
  packages/seismicity_pmtiles packages/pmtiles_v3
```

Expected: no `src/` import, no Network full-body/stream fallback, no unbounded cache, no application/decoder/Scene code, and each hand-written implementation commit is approximately 30–100 lines. Generated Freezed changes stay paired with Task 2.

## Plan Self-Review

- Spec coverage: Task 3 handles exact Range and quoted strong ETag grammar; Task 4 handles 206/Content-Range/body; Task 5 pins identity and maps transport/cancel/closed; Task 6 handles aggregate-byte LRU; Task 7 handles initial identity serialization and in-flight dedupe; Task 8 handles poison, peer cancellation, sticky future failures, and close settlement; Task 9 preserves File/Asset and forbids Network full-load fallback.
- Public-boundary coverage: Task 1 exports the already-existing core validator; no `src/` import is planned. Network concrete implementation remains private and every constructor invariant is checked by the public Factory before construction.
- Literal-test coverage: every status, ETag grammar class, range mismatch, body mismatch, LRU calculation, terminal transition, read-after-close, close error settlement, and File/Asset route has executable fixture/test code with typed fields.
- Type consistency: Factory always returns `SeismicityPmTilesResult<PmTilesRandomAccessReader>`; `readAt` always returns `Future<Uint8List>`; `archiveChanged.expectedEtag` is nullable for a `412` before identity exists; future reads rethrow the stored `SeismicityPmTilesException` subtype.
- Commit granularity: nine independently reviewable tasks separate core export, failures/dependency, request/ETag parsing, response validation, Factory/basic reader, LRU, in-flight coordination, terminal lifecycle, and route regression. Every commit step is immediately followed by push.
- Placeholder scan: no deferred marker, unspecified behavior, or unnamed failure remains. Implementation prose is paired with exact interfaces, literal fixtures, commands, and expected RED/GREEN outcomes.

## Execution Handoff

Plan complete at `docs/superpowers/plans/2026-08-09-seismicity-pmtiles-network-reader.md`. Implement task-by-task with `superpowers:subagent-driven-development`; perform review after each task before running its commit and push commands.
