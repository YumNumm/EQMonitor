import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
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
}

List<int> pointGeometry({required int x, required int y}) => [
  9,
  zigZagEncode(x),
  zigZagEncode(y),
];

int zigZagEncode(int value) => (value << 1) ^ (value >> 63);
