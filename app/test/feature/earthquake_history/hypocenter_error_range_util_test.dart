import 'package:eqmonitor/core/util/map/hypocenter_error_range_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('halfPrecision', () {
    test('小数0桁 → 0.5', () {
      expect(halfPrecision(decimalPlaces: 0), closeTo(0.5, 1e-10));
    });

    test('小数1桁 → 0.05', () {
      expect(halfPrecision(decimalPlaces: 1), closeTo(0.05, 1e-10));
    });

    test('小数2桁 → 0.005', () {
      expect(halfPrecision(decimalPlaces: 2), closeTo(0.005, 1e-10));
    });

    test('小数3桁 → 0.0005', () {
      expect(halfPrecision(decimalPlaces: 3), closeTo(0.0005, 1e-10));
    });
  });

  group('hypocenterErrorPolygon', () {
    test('VXSE61 なしは ±0.5 の矩形', () {
      const lat = 35.6;
      const lon = 139.0;
      final coords = hypocenterErrorPolygon(
        lat: lat,
        lon: lon,
        decimalPlaces: 0,
      );

      expect(coords.length, 5); // closed ring
      expect(coords[0], [
        closeTo(138.5, 1e-10),
        closeTo(35.1, 1e-10),
      ]);
      expect(coords[1], [
        closeTo(139.5, 1e-10),
        closeTo(35.1, 1e-10),
      ]);
      expect(coords[2], [
        closeTo(139.5, 1e-10),
        closeTo(36.1, 1e-10),
      ]);
      expect(coords[3], [
        closeTo(138.5, 1e-10),
        closeTo(36.1, 1e-10),
      ]);
      expect(coords[4], equals(coords[0]));
    });

    test('VXSE61 ありは ±0.0005 の矩形', () {
      const lat = 35.6;
      const lon = 139.123;
      final coords = hypocenterErrorPolygon(
        lat: lat,
        lon: lon,
        decimalPlaces: 3,
      );

      expect(coords[0][0], closeTo(139.1225, 1e-10));
      expect(coords[0][1], closeTo(35.5995, 1e-10));
      expect(coords[2][0], closeTo(139.1235, 1e-10));
      expect(coords[2][1], closeTo(35.6005, 1e-10));
    });

    test('VXSE61 ありの 139.0 は 139.000 として扱う', () {
      const lat = 35.6;
      const lon = 139.0;
      final coords = hypocenterErrorPolygon(
        lat: lat,
        lon: lon,
        decimalPlaces: 3,
      );

      expect(coords[0][0], closeTo(138.9995, 1e-10));
      expect(coords[2][0], closeTo(139.0005, 1e-10));
    });
  });
}
