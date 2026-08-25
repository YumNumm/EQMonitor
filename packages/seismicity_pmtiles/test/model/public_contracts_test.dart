import 'package:pmtiles_v3/pmtiles_v3.dart';
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
      SeismicityPmTilesLoadState.decoding(
        progress: SeismicityPmTilesDecodeProgress(
          decodedTileCount: 1,
          rawFeatureCount: 1,
          uniqueFeatureCount: 1,
        ),
      ),
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
          SeismicityPmTilesLoadDecoding() => 'decoding',
          SeismicityPmTilesLoadCompleted() => 'completed',
          SeismicityPmTilesLoadFailed() => 'failed',
          SeismicityPmTilesLoadCancelled() => 'cancelled',
        },
      ),
      [
        'idle',
        'openingSource',
        'readingDirectory',
        'decoding',
        'completed',
        'failed',
        'cancelled',
      ],
    );
  });

  test('maps PMTiles resource failures without payload diagnostics', () {
    const source = SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles');
    const failure = PmTilesV3Exception.resourceLimitExceeded(
      resource: PmTilesV3Resource.directoryDecoded,
      limitBytes: 8,
      actualBytes: 9,
    );

    final mapped = failure.toSeismicityException(source: source);

    expect(mapped, isA<SeismicityPmTilesResourceLimitExceededException>());
    expect(
      mapped.toString(),
      allOf(contains('directoryDecoded'), isNot(contains('payload'))),
    );
  });

  test('network exception cases are public Exception types', () {
    final source = SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
    );
    final failures = <SeismicityPmTilesException>[
      SeismicityPmTilesException.networkRequestFailed(
        source: source,
        statusCode: 503,
      ),
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
  });

  test('decoder exception cases expose their concrete public types', () {
    const unsupported = SeismicityPmTilesException.unsupportedSchema(
      expected: 1,
      actual: 2,
    );
    const invalidTile = SeismicityPmTilesException.invalidVectorTile(
      tileId: 42,
      reason: 'malformed_protobuf',
    );
    const invalidFeature = SeismicityPmTilesException.invalidHypocenterFeature(
      tileId: 42,
      featureIndex: 3,
      field: 'hypocenter_id',
      reason: 'missing_required_field',
    );
    const conflict = SeismicityPmTilesException.duplicateConflict(
      hypocenterId: '123e4567-e89b-12d3-a456-426614174000',
    );
    const mismatch = SeismicityPmTilesException.featureCountMismatch(
      expected: 2,
      actual: 1,
    );
    const workerFailure = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'worker_exited',
    );

    expect(unsupported, isA<SeismicityPmTilesUnsupportedSchemaException>());
    expect(invalidTile, isA<SeismicityPmTilesInvalidVectorTileException>());
    expect(
      invalidFeature,
      isA<SeismicityPmTilesInvalidHypocenterFeatureException>(),
    );
    expect(conflict, isA<SeismicityPmTilesDuplicateConflictException>());
    expect(mismatch, isA<SeismicityPmTilesFeatureCountMismatchException>());
    expect(
      workerFailure,
      isA<SeismicityPmTilesDecoderWorkerFailedException>(),
    );
  });
}
