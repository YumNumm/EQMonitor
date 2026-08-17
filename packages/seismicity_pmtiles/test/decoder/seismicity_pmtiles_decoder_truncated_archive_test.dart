import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import '../support/seismicity_archive_fixture_builder.dart';

void main() {
  final fixtures = _Task63Fixtures();

  for (final case_ in fixtures.cases()) {
    test(
      'rejects truncated ${case_.name} before public decode publication',
      () async {
        final counted = await fixtures.openCountingReader(
          bytes: case_.bytes,
          descriptor: case_.descriptor,
        );
        var decodeStarted = false;
        Object? openFailure;
        SeismicityPmTilesResult<SeismicityPmTilesDataset>? result;
        var states = <SeismicityPmTilesLoadState>[];

        try {
          final archive = await SeismicityPmTilesArchive.open(
            reader: counted,
            descriptor: case_.descriptor,
          );
          decodeStarted = true;
          final operation = SeismicityPmTilesDecoder().start(
            archive: archive,
            chunkCapacity: 1,
          );
          states = await operation.states.toList();
          result = await operation.result;
          await archive.close();
        } on SeismicityPmTilesException catch (error) {
          openFailure = error;
        }

        expect(decodeStarted, isFalse);
        expect(result, isNull);
        expect(states, isEmpty);
        expect(openFailure, case_.matcher);
        expect(counted.closeCount, 1);
        await counted.close();
        expect(counted.closeCount, 1);
      },
    );
  }
}

final class _Task63Case {
  const _Task63Case({
    required this.name,
    required this.bytes,
    required this.descriptor,
    required this.matcher,
  });

  final String name;
  final Uint8List bytes;
  final SeismicityPmTilesArchiveDescriptor descriptor;
  final Matcher matcher;
}

final class _CountingReader implements PmTilesRandomAccessReader {
  _CountingReader({required this.inner}) : closeCount = 0;

  final PmTilesRandomAccessReader inner;
  Future<void>? _close;
  int closeCount;

  @override
  int get sizeBytes => inner.sizeBytes;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) =>
      inner.readAt(offset: offset, length: length);

  @override
  Future<void> close() {
    final existing = _close;
    if (existing != null) {
      return existing;
    }
    closeCount = 1;
    return _close = inner.close();
  }
}

final class _Task63Fixtures {
  final builder = SeismicityArchiveFixtureBuilder();

  List<_Task63Case> cases() {
    final fixture = builder.buildGzipZ2(
      schemaVersion: 1,
      expectedFeatureCount: 2,
      archiveRevision: 'rev-task-63',
      periodFrom: DateTime.utc(2024),
      periodTo: DateTime.utc(2025),
    );
    return [
      _Task63Case(
        name: 'header',
        bytes: fixture.truncatedHeader,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedHeader.length,
        ),
        matcher: isA<SeismicityPmTilesInvalidRangeException>()
            .having((error) => error.offset, 'offset', 0)
            .having((error) => error.length, 'length', 127)
            .having(
              (error) => error.sizeBytes,
              'sizeBytes',
              fixture.truncatedHeader.length,
            ),
      ),
      _Task63Case(
        name: 'root directory',
        bytes: fixture.truncatedDirectory,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedDirectory.length,
        ),
        matcher: isA<SeismicityPmTilesCorruptArchiveException>().having(
          (error) => error.reason,
          'reason',
          'The root directory section exceeds the archive bounds.',
        ),
      ),
      _Task63Case(
        name: 'tile data',
        bytes: fixture.truncatedTileData,
        descriptor: fixture.descriptor.copyWith(
          expectedSizeBytes: fixture.truncatedTileData.length,
        ),
        matcher: isA<SeismicityPmTilesCorruptArchiveException>().having(
          (error) => error.reason,
          'reason',
          'The tile data section exceeds the archive bounds.',
        ),
      ),
    ];
  }

  Future<_CountingReader> openCountingReader({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) async {
        expect(assetKey, SeismicityArchiveFixtureBuilder.assetKey);
        return bytes;
      },
      dio: Dio(),
      networkMaxCacheBytes: 1024,
    );
    final opened = await factory.create(
      descriptor: descriptor,
      cancelToken: CancelToken(),
    );
    final reader = switch (opened) {
      SeismicityPmTilesSuccess<PmTilesRandomAccessReader>(:final value) =>
        value,
      SeismicityPmTilesFailure<PmTilesRandomAccessReader>(:final exception) =>
        throw exception,
    };
    return _CountingReader(inner: reader);
  }
}
