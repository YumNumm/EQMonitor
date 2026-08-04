import 'dart:ui';

import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exposes the width/height aspect ratio', () {
    final viewport = MapViewport(
      logicalSize: const Size(200, 100),
      devicePixelRatio: 2,
    );
    expect(viewport.aspectRatio, 2);
  });

  test('is unaffected by devicePixelRatio and equal across common values', () {
    for (final devicePixelRatio in [1.0, 2.0, 2.625, 3.0]) {
      final viewport = MapViewport(
        logicalSize: const Size(390, 844),
        devicePixelRatio: devicePixelRatio,
      );
      expect(viewport.aspectRatio, closeTo(390 / 844, 1e-12));
      expect(viewport.devicePixelRatio, devicePixelRatio);
    }
  });

  test('supports value equality', () {
    final a = MapViewport(
      logicalSize: const Size(100, 200),
      devicePixelRatio: 2,
    );
    final b = MapViewport(
      logicalSize: const Size(100, 200),
      devicePixelRatio: 2,
    );
    final c = MapViewport(
      logicalSize: const Size(100, 200),
      devicePixelRatio: 3,
    );
    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(c));
  });

  test('rejects invalid logical dimensions', () {
    for (final logicalSize in [
      const Size(0, 100),
      const Size(100, -1),
      const Size(double.infinity, 100),
      const Size(double.nan, 100),
    ]) {
      expect(
        () => MapViewport(logicalSize: logicalSize, devicePixelRatio: 1),
        throwsArgumentError,
      );
    }
  });

  test('rejects invalid device pixel ratios', () {
    for (final devicePixelRatio in [0.0, -1.0, double.nan, double.infinity]) {
      expect(
        () => MapViewport(
          logicalSize: const Size(100, 100),
          devicePixelRatio: devicePixelRatio,
        ),
        throwsArgumentError,
      );
    }
  });
}
