import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:test/test.dart';

void main() {
  test('resource limit failures expose only bounded diagnostics', () {
    const exception = PmTilesV3Exception.resourceLimitExceeded(
      resource: PmTilesV3Resource.tileDecoded,
      limit: 1024,
      actual: 1025,
    );

    expect(exception, isA<PmTilesV3ResourceLimitExceededException>());
    const typed = exception as PmTilesV3ResourceLimitExceededException;
    expect(typed.resource, PmTilesV3Resource.tileDecoded);
    expect(typed.limit, 1024);
    expect(typed.actual, 1025);
    expect(exception.toString(), isNot(contains('raw-payload')));
  });

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
