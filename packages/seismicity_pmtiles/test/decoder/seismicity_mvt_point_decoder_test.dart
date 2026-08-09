import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  const decoder = SeismicityMvtPointDecoder();

  SeismicityMvtPoint decode({
    required int z,
    required int x,
    required int y,
    required int localX,
    required int localY,
  }) => decoder.decode(
    geometry: pointGeometry(x: localX, y: localY),
    z: z,
    x: x,
    y: y,
    extent: 4096,
    tileId: 1,
    featureIndex: 0,
  );

  test('decodes one canonical MoveTo point to finite world coordinates', () {
    final point = decode(z: 14, x: 1, y: 3, localX: 4092, localY: 100);

    expect(point.globalX, 8188);
    expect(point.globalY, 12388);
    expect(point.longitude.isFinite, isTrue);
    expect(point.latitude.isFinite, isTrue);
  });

  test('normalizes buffered copies and antimeridian wrapping', () {
    final left = decode(z: 2, x: 0, y: 0, localX: 4092, localY: 100);
    final right = decode(z: 2, x: 1, y: 0, localX: -4, localY: 100);
    expect((right.globalX, right.globalY), (left.globalX, left.globalY));

    final wrapped = decode(z: 2, x: 0, y: 0, localX: -4, localY: 100);
    final east = decode(z: 2, x: 3, y: 0, localX: 4092, localY: 100);
    expect((wrapped.globalX, wrapped.globalY), (east.globalX, east.globalY));
    expect(wrapped.longitude, closeTo(179.912109375, 1e-12));
  });

  test('maps exact north and south Web Mercator boundaries', () {
    final north = decode(z: 0, x: 0, y: 0, localX: 0, localY: 0);
    final south = decode(z: 0, x: 0, y: 0, localX: 0, localY: 4096);

    expect(north.latitude, closeTo(85.0511287798066, 1e-12));
    expect(south.latitude, closeTo(-85.0511287798066, 1e-12));
  });

  test('rejects malformed Point command streams', () {
    final malformed = <List<int>>[
      [],
      [1, 0, 0],
      [17, 0, 0, 0, 0],
      [10, 0, 0],
      [9],
      [9, 0],
      [9, 0, 0, 9],
      [9, 0, 0, 0],
    ];
    for (final geometry in malformed) {
      expect(
        () => decoder.decode(
          geometry: geometry,
          z: 0,
          x: 0,
          y: 0,
          extent: 4096,
          tileId: 1,
          featureIndex: 0,
        ),
        throwsA(invalidPoint('invalid_point_geometry')),
      );
    }
  });

  test('rejects invalid extent, overflow, and out-of-world Y', () {
    void expectInvalid({
      required int extent,
      required int z,
      required int localY,
      required String reason,
    }) {
      expect(
        () => decoder.decode(
          geometry: pointGeometry(x: 0, y: localY),
          z: z,
          x: 0,
          y: 0,
          extent: extent,
          tileId: 1,
          featureIndex: 0,
        ),
        throwsA(invalidPoint(reason)),
      );
    }

    expectInvalid(extent: 0, z: 0, localY: 0, reason: 'invalid_extent');
    expectInvalid(extent: -1, z: 0, localY: 0, reason: 'invalid_extent');
    expectInvalid(
      extent: 1 << 62,
      z: 2,
      localY: 0,
      reason: 'coordinate_overflow',
    );
    expectInvalid(
      extent: 4096,
      z: 0,
      localY: -1,
      reason: 'global_y_out_of_range',
    );
    expectInvalid(
      extent: 4096,
      z: 0,
      localY: 4097,
      reason: 'global_y_out_of_range',
    );
  });
}

List<int> pointGeometry({required int x, required int y}) => [
  9,
  zigZagEncode(x),
  zigZagEncode(y),
];

int zigZagEncode(int value) => (value << 1) ^ (value >> 63);

Matcher invalidPoint(String reason) =>
    isA<SeismicityPmTilesInvalidHypocenterFeatureException>()
        .having((error) => error.tileId, 'tileId', 1)
        .having((error) => error.featureIndex, 'featureIndex', 0)
        .having((error) => error.field, 'field', 'geometry')
        .having((error) => error.reason, 'reason', reason);
