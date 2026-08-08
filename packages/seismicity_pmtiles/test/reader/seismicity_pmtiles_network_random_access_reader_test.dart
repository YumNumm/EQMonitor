import 'dart:typed_data';

import 'package:dio/dio.dart';
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
}
