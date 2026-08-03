import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

void main() {
  group('JSON contracts', () {
    test('archive descriptor round-trips with its network source', () {
      final descriptor = SeismicityPmTilesArchiveDescriptor(
        source: SeismicityPmTilesSource.network(
          archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
        ),
        schemaVersion: 1,
        dataZoom: 8,
        expectedSizeBytes: 123456,
        expectedFeatureCount: 2000000,
        archiveRevision: '2026-08-03T00:00:00Z',
        periodFrom: DateTime.utc(2025),
        periodTo: DateTime.utc(2026),
      );

      expect(
        SeismicityPmTilesArchiveDescriptor.fromJson(descriptor.toJson()),
        descriptor,
      );
    });

    test('bounds round-trip', () {
      const bounds = SeismicityPmTilesBounds(
        minLongitude: 122,
        minLatitude: 20,
        maxLongitude: 154,
        maxLatitude: 46,
      );

      expect(SeismicityPmTilesBounds.fromJson(bounds.toJson()), bounds);
    });
  });

  test('source union preserves all source-specific identifiers', () {
    final sources = <SeismicityPmTilesSource>[
      SeismicityPmTilesSource.network(
        archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
      ),
      const SeismicityPmTilesSource.file(path: '/data/archive.pmtiles'),
      const SeismicityPmTilesSource.asset(
        assetKey: 'assets/seismicity/archive.pmtiles',
      ),
    ];

    final identifiers = sources.map(
      (source) => switch (source) {
        SeismicityPmTilesNetworkSource(:final archiveUri) =>
          archiveUri.toString(),
        SeismicityPmTilesFileSource(:final path) => path,
        SeismicityPmTilesAssetSource(:final assetKey) => assetKey,
      },
    );

    expect(
      identifiers,
      [
        'https://example.com/archive.pmtiles',
        '/data/archive.pmtiles',
        'assets/seismicity/archive.pmtiles',
      ],
    );
    for (final source in sources) {
      expect(SeismicityPmTilesSource.fromJson(source.toJson()), source);
    }
  });

  test('generic result exposes success and typed failure', () {
    const success = SeismicityPmTilesResult<int>.success(value: 42);
    const failure = SeismicityPmTilesResult<int>.failure(
      exception: SeismicityPmTilesException.corruptArchive(
        reason: 'invalid directory',
      ),
    );

    final successValue = switch (success) {
      SeismicityPmTilesSuccess(:final value) => value,
      SeismicityPmTilesFailure() => -1,
    };
    final failureReason = switch (failure) {
      SeismicityPmTilesSuccess() => '',
      SeismicityPmTilesFailure(
        exception: SeismicityPmTilesCorruptArchiveException(:final reason),
      ) =>
        reason,
      SeismicityPmTilesFailure() => 'unexpected',
    };

    expect(successValue, 42);
    expect(failureReason, 'invalid directory');
  });

  test('exception and load-state unions are exhaustive', () {
    const source = SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles');
    const exceptions = <SeismicityPmTilesException>[
      SeismicityPmTilesException.invalidDescriptor(reason: 'schema'),
      SeismicityPmTilesException.invalidRange(
        offset: 10,
        length: 5,
        sizeBytes: 12,
      ),
      SeismicityPmTilesException.corruptArchive(reason: 'header'),
      SeismicityPmTilesException.unsupportedCompression(compression: 4),
      SeismicityPmTilesException.unsupportedSource(source: source),
      SeismicityPmTilesException.sourceReadFailed(
        source: source,
        reason: 'closed',
      ),
      SeismicityPmTilesException.tileNotFound(tileId: 5),
      SeismicityPmTilesException.invalidTileId(
        tileId: -1,
        minTileId: 0,
        maxTileId: 10,
      ),
    ];
    const states = <SeismicityPmTilesLoadState>[
      SeismicityPmTilesLoadState.idle(),
      SeismicityPmTilesLoadState.openingSource(),
      SeismicityPmTilesLoadState.readingDirectory(),
      SeismicityPmTilesLoadState.completed(),
      SeismicityPmTilesLoadState.failed(
        exception: SeismicityPmTilesException.invalidDescriptor(
          reason: 'schema',
        ),
      ),
      SeismicityPmTilesLoadState.cancelled(),
    ];

    expect(exceptions, everyElement(isA<Exception>()));
    expect(
      states.map(
        (state) => switch (state) {
          SeismicityPmTilesLoadIdle() => 'idle',
          SeismicityPmTilesLoadOpeningSource() => 'openingSource',
          SeismicityPmTilesLoadReadingDirectory() => 'readingDirectory',
          SeismicityPmTilesLoadCompleted() => 'completed',
          SeismicityPmTilesLoadFailed() => 'failed',
          SeismicityPmTilesLoadCancelled() => 'cancelled',
        },
      ),
      [
        'idle',
        'openingSource',
        'readingDirectory',
        'completed',
        'failed',
        'cancelled',
      ],
    );
  });
}
