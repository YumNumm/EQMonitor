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

  test('tile ID inverse is public', () {
    expect(
      const PmTilesV3TileId().zxyForTileId(tileId: 0),
      (z: 0, x: 0, y: 0),
    );
  });
}
