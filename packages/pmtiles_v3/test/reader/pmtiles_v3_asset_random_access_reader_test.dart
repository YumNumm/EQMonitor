import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:test/test.dart';

void main() {
  const assetKey = 'assets/archive.pmtiles';

  test('loads the asset once and serves independent slices', () async {
    var loadCount = 0;
    final loadedBytes = Uint8List.fromList([0, 1, 2, 3, 4, 5]);
    final reader = await PmTilesV3AssetRandomAccessReader.open(
      assetKey: assetKey,
      assetLoader: ({required assetKey}) async {
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
    final reader = await PmTilesV3AssetRandomAccessReader.open(
      assetKey: assetKey,
      assetLoader: ({required assetKey}) async => Uint8List(4),
    );
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 3, length: 2),
      throwsA(isA<PmTilesV3InvalidRangeException>()),
    );
    await expectLater(
      reader.readAt(offset: 0, length: 0),
      throwsA(isA<PmTilesV3InvalidRangeException>()),
    );
  });

  test('rejects reads after close', () async {
    final reader = await PmTilesV3AssetRandomAccessReader.open(
      assetKey: assetKey,
      assetLoader: ({required assetKey}) async => Uint8List(4),
    );

    await reader.close();

    await expectLater(
      reader.readAt(offset: 0, length: 1),
      throwsA(isA<PmTilesV3SourceReadFailedException>()),
    );
  });

  test('converts asset loader exceptions to typed source failures', () async {
    await expectLater(
      PmTilesV3AssetRandomAccessReader.open(
        assetKey: assetKey,
        assetLoader: ({required assetKey}) =>
            Future<Uint8List>.error(Exception('asset unavailable')),
      ),
      throwsA(
        isA<PmTilesV3SourceReadFailedException>().having(
          (exception) => exception.reason,
          'reason',
          contains('asset unavailable'),
        ),
      ),
    );
  });

  test('converts asset loader errors to typed source failures', () async {
    await expectLater(
      PmTilesV3AssetRandomAccessReader.open(
        assetKey: assetKey,
        assetLoader: ({required assetKey}) =>
            Future<Uint8List>.error(StateError('asset unavailable')),
      ),
      throwsA(
        isA<PmTilesV3SourceReadFailedException>().having(
          (exception) => exception.reason,
          'reason',
          contains('asset unavailable'),
        ),
      ),
    );
  });

  test('preserves typed loader failures', () async {
    const expected = PmTilesV3Exception.corruptArchive(
      reason: 'unsupported schema',
    );

    await expectLater(
      PmTilesV3AssetRandomAccessReader.open(
        assetKey: assetKey,
        assetLoader: ({required assetKey}) => Future<Uint8List>.error(expected),
      ),
      throwsA(equals(expected)),
    );
  });
}
