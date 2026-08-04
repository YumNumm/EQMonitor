import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

void main() {
  late Directory tempDirectory;
  late File archiveFile;
  late int assetLoadCount;
  late SeismicityRandomAccessReaderFactory factory;

  setUp(() async {
    tempDirectory = await Directory.systemTemp.createTemp(
      'seismicity_pmtiles_reader_factory_',
    );
    archiveFile = File('${tempDirectory.path}/archive.pmtiles');
    await archiveFile.writeAsBytes([1, 2, 3, 4]);
    assetLoadCount = 0;
    factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) async {
        assetLoadCount++;
        return Uint8List.fromList([5, 6, 7, 8]);
      },
    );
  });

  tearDown(() => tempDirectory.delete(recursive: true));

  test('routes file sources to the file reader', () async {
    final result = await factory.create(
      source: SeismicityPmTilesSource.file(path: archiveFile.path),
    );

    switch (result) {
      case SeismicityPmTilesSuccess(:final value):
        addTearDown(value.close);
        expect(value, isA<PmTilesV3FileRandomAccessReader>());
        expect(await value.readAt(offset: 1, length: 2), orderedEquals([2, 3]));
      case SeismicityPmTilesFailure(:final exception):
        fail('Expected file reader, got $exception');
    }
    expect(assetLoadCount, 0);
  });

  test('routes asset sources through the injected loader once', () async {
    final result = await factory.create(
      source: const SeismicityPmTilesSource.asset(assetKey: 'archive.pmtiles'),
    );

    switch (result) {
      case SeismicityPmTilesSuccess(:final value):
        addTearDown(value.close);
        expect(value, isA<PmTilesV3AssetRandomAccessReader>());
        expect(await value.readAt(offset: 0, length: 2), orderedEquals([5, 6]));
        expect(await value.readAt(offset: 2, length: 2), orderedEquals([7, 8]));
      case SeismicityPmTilesFailure(:final exception):
        fail('Expected asset reader, got $exception');
    }
    expect(assetLoadCount, 1);
  });

  test('returns unsupportedSource for network without fallback', () async {
    final source = SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
    );

    final result = await factory.create(source: source);

    expect(
      result,
      SeismicityPmTilesResult<PmTilesRandomAccessReader>.failure(
        exception: SeismicityPmTilesException.unsupportedSource(source: source),
      ),
    );
    expect(assetLoadCount, 0);
  });

  test('returns typed failure when a selected file cannot be opened', () async {
    final source = SeismicityPmTilesSource.file(
      path: '${tempDirectory.path}/missing.pmtiles',
    );

    final result = await factory.create(source: source);

    switch (result) {
      case SeismicityPmTilesSuccess():
        fail('Expected source read failure');
      case SeismicityPmTilesFailure(:final exception):
        expect(exception, isA<SeismicityPmTilesSourceReadFailedException>());
    }
    expect(assetLoadCount, 0);
  });

  test('returns typed failure when the asset loader throws an Error', () async {
    const source = SeismicityPmTilesSource.asset(
      assetKey: 'missing.pmtiles',
    );
    final errorFactory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required assetKey}) =>
          Future<Uint8List>.error(StateError('asset unavailable')),
    );

    final result = await errorFactory.create(source: source);

    switch (result) {
      case SeismicityPmTilesSuccess():
        fail('Expected source read failure');
      case SeismicityPmTilesFailure(:final exception):
        expect(
          exception,
          isA<SeismicityPmTilesSourceReadFailedException>()
              .having((failure) => failure.source, 'source', source)
              .having(
                (failure) => failure.reason,
                'reason',
                contains('asset unavailable'),
              ),
        );
    }
  });
}
