import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import '../support/network_range_test_support.dart';

SeismicityPmTilesArchiveDescriptor networkDescriptor({
  required int sizeBytes,
}) {
  return SeismicityPmTilesArchiveDescriptor(
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
}

Future<PmTilesRandomAccessReader> createReader({
  required NetworkRangeTestAdapter adapter,
  required CancelToken callerToken,
  Interceptor? responseInterceptor,
  int cacheBytes = 8,
}) async {
  final dio = Dio()..httpClientAdapter = adapter;
  if (responseInterceptor != null) {
    dio.interceptors.add(responseInterceptor);
  }
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

Future<SeismicityPmTilesArchiveChangedException> archiveChangedFailureOf({
  required Future<Uint8List> read,
}) async {
  try {
    await read;
  } on SeismicityPmTilesArchiveChangedException catch (failure) {
    return failure;
  }
  fail('Expected SeismicityPmTilesArchiveChangedException.');
}

void main() {
  late NetworkRangeTestAdapter adapter;

  setUp(() {
    adapter = NetworkRangeTestAdapter();
  });

  test('pins first identity and sends If-Match next', () async {
    adapter
      ..enqueueResponse(
        statusCode: 206,
        body: const [0, 1],
        etag: '"v1"',
        contentRange: 'bytes 0-1/16',
      )
      ..enqueueResponse(
        statusCode: 206,
        body: const [2, 3],
        etag: '"v1"',
        contentRange: 'bytes 2-3/16',
      );
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);

    expect(
      await reader.readAt(offset: 0, length: 2),
      orderedEquals(<int>[0, 1]),
    );
    expect(
      await reader.readAt(offset: 2, length: 2),
      orderedEquals(<int>[2, 3]),
    );
    expect(adapter.requests[0].headers.containsKey('If-Match'), isFalse);
    expect(adapter.requests[1].headers['If-Match'], '"v1"');
  });

  test('rejects unsafe 200 without returning its body', () async {
    adapter.enqueueResponse(
      statusCode: 200,
      body: const [0, 1],
      etag: '"v1"',
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

  for (final receivedEtag in <String?>[null, '*']) {
    test(
      'initial ETag $receivedEtag poisons without another request',
      () async {
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
            .having(
              (failure) => failure.receivedEtag,
              'receivedEtag',
              receivedEtag,
            )
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
      },
    );
  }

  for (final statusCode in <int?>[null, 503]) {
    test(
      'maps transport failure $statusCode without leaking DioException',
      () async {
        if (statusCode == null) {
          adapter.enqueueDioFailure(statusCode: null);
        } else {
          adapter.enqueueResponse(
            statusCode: 503,
            body: const [],
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
            isA<SeismicityPmTilesNetworkRequestFailedException>()
                .having(
                  (failure) => failure.source,
                  'source',
                  networkDescriptor(sizeBytes: 16).source,
                )
                .having(
                  (failure) => failure.statusCode,
                  'statusCode',
                  statusCode,
                ),
          ),
        );
      },
    );
  }

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
        contentRange:
            'bytes ${range.offset}-${range.offset + range.bytes.length - 1}/16',
      );
    }
    final reader = await createReader(
      adapter: adapter,
      cacheBytes: 5,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 3);
    await reader.readAt(offset: 3, length: 2);
    await reader.readAt(offset: 0, length: 3);
    await reader.readAt(offset: 5, length: 2);
    await reader.readAt(offset: 0, length: 3);
    await reader.readAt(offset: 3, length: 2);

    expect(adapter.requests, hasLength(4));
  });

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

    expect(
      await reader.readAt(offset: 0, length: 2),
      orderedEquals(<int>[0, 1]),
    );
    expect(
      await reader.readAt(offset: 0, length: 2),
      orderedEquals(<int>[0, 1]),
    );

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

  test('same pending range shares one request', () async {
    final pending = adapter.enqueuePending206(
      offset: 0,
      total: 16,
      etag: '"v1"',
    );
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);

    final first = reader.readAt(offset: 0, length: 3);
    final second = reader.readAt(offset: 0, length: 3);

    expect(identical(first, second), isTrue);
    await pending.requestStarted;
    expect(adapter.requests, hasLength(1));
    pending.complete(<int>[0, 1, 2]);
    expect(
      await Future.wait(<Future<Uint8List>>[first, second]),
      everyElement(orderedEquals(<int>[0, 1, 2])),
    );
  });

  test('different range waits for initial identity', () async {
    final pending = adapter.enqueuePending206(
      offset: 0,
      total: 16,
      etag: '"v1"',
    );
    adapter.enqueueResponse(
      statusCode: 206,
      body: const [3, 4],
      etag: '"v1"',
      contentRange: 'bytes 3-4/16',
    );
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);

    final first = reader.readAt(offset: 0, length: 3);
    final second = reader.readAt(offset: 3, length: 2);

    await pending.requestStarted;
    expect(adapter.requests, hasLength(1));
    pending.complete(<int>[0, 1, 2]);
    await first;
    await second;
    expect(adapter.requests[1].headers['If-Match'], '"v1"');
  });

  test(
    'invalid initial range does not reject a concurrent valid read',
    () async {
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

      final invalid = reader.readAt(offset: -1, length: 2);
      final valid = reader.readAt(offset: 0, length: 2);
      final invalidExpectation = expectLater(
        invalid,
        throwsA(isA<PmTilesV3InvalidRangeException>()),
      );
      final validExpectation = expectLater(
        valid,
        completion(orderedEquals(<int>[0, 1])),
      );

      await Future.wait(<Future<void>>[invalidExpectation, validExpectation]);
      expect(adapter.requests, hasLength(1));
    },
  );

  test('same range waiting for initial identity shares one future', () async {
    final pending = adapter.enqueuePending206(
      offset: 0,
      total: 16,
      etag: '"v1"',
    );
    adapter.enqueueResponse(
      statusCode: 206,
      body: const [3, 4],
      etag: '"v1"',
      contentRange: 'bytes 3-4/16',
    );
    final reader = await createReader(
      adapter: adapter,
      callerToken: CancelToken(),
    );
    addTearDown(reader.close);

    final initial = reader.readAt(offset: 0, length: 3);
    final firstWaiting = reader.readAt(offset: 3, length: 2);
    final secondWaiting = reader.readAt(offset: 3, length: 2);

    expect(identical(firstWaiting, secondWaiting), isTrue);
    await pending.requestStarted;
    expect(adapter.requests, hasLength(1));
    pending.complete(<int>[0, 1, 2]);
    await initial;
    expect(
      await Future.wait(<Future<Uint8List>>[firstWaiting, secondWaiting]),
      everyElement(orderedEquals(<int>[3, 4])),
    );
    expect(adapter.requests, hasLength(2));
    expect(adapter.requests[1].headers['If-Match'], '"v1"');
  });

  test('same range retries after a transport failure', () async {
    adapter
      ..enqueueDioFailure(statusCode: null)
      ..enqueueResponse(
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

    await expectLater(
      reader.readAt(offset: 0, length: 2),
      throwsA(isA<SeismicityPmTilesNetworkRequestFailedException>()),
    );
    expect(
      await reader.readAt(offset: 0, length: 2),
      orderedEquals(<int>[0, 1]),
    );
    expect(adapter.requests, hasLength(2));
  });

  test(
    'caller cancellation stops pending request and reader remains usable',
    () async {
      final callerToken = CancelToken();
      final pending = adapter.enqueuePending206(
        offset: 0,
        total: 16,
        etag: '"v1"',
      );
      final reader = await createReader(
        adapter: adapter,
        callerToken: callerToken,
      );
      addTearDown(reader.close);

      final cancelledRead = reader.readAt(offset: 0, length: 2);
      await pending.requestStarted;
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
      expect(
        await reader.readAt(offset: 2, length: 2),
        orderedEquals(<int>[2, 3]),
      );
      expect(adapter.requests, hasLength(2));
    },
  );

  test(
    'caller cancellation immediately returns a typed read failure',
    () async {
      final callerToken = CancelToken();
      adapter.enqueuePending206(offset: 0, total: 16, etag: '"v1"');
      final reader = await createReader(
        adapter: adapter,
        callerToken: callerToken,
      );
      addTearDown(reader.close);

      final cancelledRead = reader.readAt(offset: 0, length: 2);
      callerToken.cancel('period changed');

      await expectLater(
        cancelledRead,
        throwsA(isA<SeismicityPmTilesCancelledException>()),
      );
    },
  );

  test(
    'read started after caller cancellation uses the next generation',
    () async {
      final callerToken = CancelToken();
      adapter.enqueueResponse(
        statusCode: 206,
        body: const [0, 1],
        etag: '"v1"',
        contentRange: 'bytes 0-1/16',
      );
      final reader = await createReader(
        adapter: adapter,
        callerToken: callerToken,
      );
      addTearDown(reader.close);

      callerToken.cancel('period changed');

      expect(
        await reader.readAt(offset: 0, length: 2),
        orderedEquals(<int>[0, 1]),
      );
      expect(adapter.requests, hasLength(1));
    },
  );

  test(
    'post-cancel read does not inherit the cancelled initial identity future',
    () async {
      final callerToken = CancelToken();
      final pending = adapter.enqueuePending206(
        offset: 0,
        total: 16,
        etag: '"v1"',
      );
      adapter.enqueueResponse(
        statusCode: 206,
        body: const [3, 4],
        etag: '"v1"',
        contentRange: 'bytes 3-4/16',
      );
      final reader = await createReader(
        adapter: adapter,
        callerToken: callerToken,
      );
      addTearDown(reader.close);

      final cancelledRead = reader.readAt(offset: 0, length: 2);
      await pending.requestStarted;
      callerToken.cancel('period changed');
      final nextGenerationRead = reader.readAt(offset: 3, length: 2);

      await expectLater(
        cancelledRead,
        throwsA(isA<SeismicityPmTilesCancelledException>()),
      );
      expect(
        await nextGenerationRead,
        orderedEquals(<int>[3, 4]),
      );
      expect(adapter.requests, hasLength(2));
    },
  );

  test(
    'reader created with a cancelled caller token stays fail closed',
    () async {
      final callerToken = CancelToken()..cancel('period changed');
      final reader = await createReader(
        adapter: adapter,
        callerToken: callerToken,
      );
      addTearDown(reader.close);

      for (final offset in <int>[0, 2]) {
        await expectLater(
          reader.readAt(offset: offset, length: 2),
          throwsA(
            isA<SeismicityPmTilesCancelledException>().having(
              (failure) => failure.source,
              'source',
              networkDescriptor(sizeBytes: 16).source,
            ),
          ),
        );
      }
      expect(adapter.requests, isEmpty);
    },
  );

  for (final fixture in <({int status, String etag})>[
    (status: 412, etag: '"v2"'),
    (status: 206, etag: '"v2"'),
  ]) {
    test('completed peer gets terminal ${fixture.status} instance', () async {
      final coordinator = PoisonFirstResponseCoordinator(
        peerRange: 'bytes=4-5',
        poisonRange: 'bytes=2-3',
      );
      adapter
        ..enqueueResponse(
          statusCode: 206,
          body: const [0, 1],
          etag: '"v1"',
          contentRange: 'bytes 0-1/16',
        )
        ..enqueueResponse(
          statusCode: 206,
          body: const [4, 5],
          etag: '"v1"',
          contentRange: 'bytes 4-5/16',
        )
        ..enqueueResponse(
          statusCode: fixture.status,
          body: fixture.status == 206 ? const [2, 3] : const [],
          etag: fixture.etag,
          contentRange: fixture.status == 206 ? 'bytes 2-3/16' : null,
        );
      final reader = await createReader(
        adapter: adapter,
        callerToken: CancelToken(),
        responseInterceptor: coordinator.interceptor,
      );
      addTearDown(reader.close);
      await reader.readAt(offset: 0, length: 2);
      final peerRead = reader.readAt(offset: 4, length: 2);
      final peerFailure = archiveChangedFailureOf(read: peerRead);
      await coordinator.peerReady;
      final poisonedRead = reader.readAt(offset: 2, length: 2);
      final poisonedFailure = await archiveChangedFailureOf(
        read: poisonedRead,
      );
      final completedPeerFailure = await peerFailure;
      final requestCountBeforeCachedRead = adapter.requests.length;
      final laterFailure = await archiveChangedFailureOf(
        read: reader.readAt(offset: 0, length: 2),
      );

      expect(poisonedFailure.expectedEtag, '"v1"');
      expect(poisonedFailure.receivedEtag, fixture.etag);
      expect(poisonedFailure.statusCode, fixture.status);
      expect(identical(completedPeerFailure, poisonedFailure), isTrue);
      expect(identical(laterFailure, poisonedFailure), isTrue);
      expect(adapter.requests, hasLength(requestCountBeforeCachedRead));
    });
  }
}
