// ignore_for_file: prefer_int_literals

import 'package:eqmonitor/core/util/map/hypocenter_error_range_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('halfPrecision', () {
    test('小数1桁 → 0.05', () {
      expect(halfPrecision(45.7), closeTo(0.05, 1e-10));
      expect(halfPrecision(139.1), closeTo(0.05, 1e-10));
    });

    test('小数2桁 → 0.005', () {
      expect(halfPrecision(45.83), closeTo(0.005, 1e-10));
      expect(halfPrecision(139.16), closeTo(0.005, 1e-10));
    });

    test('整数（小数点なし）→ 0.5', () {
      expect(halfPrecision(35.0), closeTo(0.5, 1e-10));
      expect(halfPrecision(135.0), closeTo(0.5, 1e-10));
    });

    test('小数3桁 → 0.0005', () {
      expect(halfPrecision(139.769), closeTo(0.0005, 1e-10));
    });
  });

  group('hypocenterErrorPolygon', () {
    test('(45.7, 139.1) → ±0.05 の矩形', () {
      const lat = 45.7;
      const lon = 139.1;
      final coords = hypocenterErrorPolygon(lat, lon);

      expect(coords.length, 5); // closed ring
      expect(coords[0], [closeTo(lon - 0.05, 1e-10), closeTo(lat - 0.05, 1e-10)]);
      expect(coords[1], [closeTo(lon + 0.05, 1e-10), closeTo(lat - 0.05, 1e-10)]);
      expect(coords[2], [closeTo(lon + 0.05, 1e-10), closeTo(lat + 0.05, 1e-10)]);
      expect(coords[3], [closeTo(lon - 0.05, 1e-10), closeTo(lat + 0.05, 1e-10)]);
      expect(coords[4], equals(coords[0]));
    });

    test('(45.83, 139.16) → lat ±0.005, lon ±0.005', () {
      const lat = 45.83;
      const lon = 139.16;
      final coords = hypocenterErrorPolygon(lat, lon);

      expect(coords[0][0], closeTo(lon - 0.005, 1e-10));
      expect(coords[0][1], closeTo(lat - 0.005, 1e-10));
      expect(coords[2][0], closeTo(lon + 0.005, 1e-10));
      expect(coords[2][1], closeTo(lat + 0.005, 1e-10));
    });

    test('(35.0, 135.0) → ±0.5 の矩形', () {
      const lat = 35.0;
      const lon = 135.0;
      final coords = hypocenterErrorPolygon(lat, lon);

      expect(coords[0][0], closeTo(lon - 0.5, 1e-10));
      expect(coords[2][0], closeTo(lon + 0.5, 1e-10));
    });

    test('(35.68, 139.769) → lat ±0.005, lon ±0.0005', () {
      const lat = 35.68;
      const lon = 139.769;
      final coords = hypocenterErrorPolygon(lat, lon);

      expect(coords[0][0], closeTo(lon - 0.0005, 1e-10));
      expect(coords[0][1], closeTo(lat - 0.005, 1e-10));
      expect(coords[2][0], closeTo(lon + 0.0005, 1e-10));
      expect(coords[2][1], closeTo(lat + 0.005, 1e-10));
    });
  });
}
