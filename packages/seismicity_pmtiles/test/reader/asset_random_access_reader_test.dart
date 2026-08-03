import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/reader/asset_random_access_reader.dart';
import 'package:test/test.dart';

void main() {
  const source = SeismicityPmTilesAssetSource(
    assetKey: 'assets/seismicity/archive.pmtiles',
  );

  test('loads the asset once and serves independent slices', () async {
    var loadCount = 0;
    final loadedBytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);
    final reader = await AssetRandomAccessReader.open(
      source: source,
      assetLoader: ({required assetKey}) async {
        expect(assetKey, source.assetKey);
        loadCount++;
        return loadedBytes;
      },
    );
    addTearDown(reader.close);

    loadedBytes[2] = 99;
    final first = await reader.readAt(offset: 1, length: 3);
    first[1] = 88;

    expect(await reader.readAt(offset: 1, length: 3), orderedEquals([1, 2, 3]));
    expect(reader.sizeBytes, 6);
    expect(loadCount, 1);
  });

  test('rejects invalid ranges', () async {
    final reader = await AssetRandomAccessReader.open(
      source: source,
      assetLoader: ({required assetKey}) async => Uint8List(4),
    );
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 3, length: 2),
      throwsA(isA<SeismicityPmTilesInvalidRangeException>()),
    );
    await expectLater(
      reader.readAt(offset: 0, length: 0),
      throwsA(isA<SeismicityPmTilesInvalidRangeException>()),
    );
  });

  test('rejects reads after close', () async {
    final reader = await AssetRandomAccessReader.open(
      source: source,
      assetLoader: ({required assetKey}) async => Uint8List(4),
    );

    await reader.close();

    await expectLater(
      reader.readAt(offset: 0, length: 1),
      throwsA(isA<SeismicityPmTilesSourceReadFailedException>()),
    );
  });

  test('converts asset loader exceptions to typed source failures', () async {
    await expectLater(
      AssetRandomAccessReader.open(
        source: source,
        assetLoader: ({required assetKey}) =>
            Future<Uint8List>.error(Exception('asset unavailable')),
      ),
      throwsA(
        isA<SeismicityPmTilesSourceReadFailedException>()
            .having((exception) => exception.source, 'source', source)
            .having(
              (exception) => exception.reason,
              'reason',
              contains('asset unavailable'),
            ),
      ),
    );
  });

  test('converts asset loader errors to typed source failures', () async {
    await expectLater(
      AssetRandomAccessReader.open(
        source: source,
        assetLoader: ({required assetKey}) =>
            Future<Uint8List>.error(StateError('asset unavailable')),
      ),
      throwsA(
        isA<SeismicityPmTilesSourceReadFailedException>()
            .having((exception) => exception.source, 'source', source)
            .having(
              (exception) => exception.reason,
              'reason',
              contains('asset unavailable'),
            ),
      ),
    );
  });

  test('preserves typed loader failures', () async {
    const expected = SeismicityPmTilesException.invalidDescriptor(
      reason: 'unsupported schema',
    );

    await expectLater(
      AssetRandomAccessReader.open(
        source: source,
        assetLoader: ({required assetKey}) => Future<Uint8List>.error(expected),
      ),
      throwsA(equals(expected)),
    );
  });
}
