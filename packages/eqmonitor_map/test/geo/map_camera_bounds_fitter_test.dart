import 'dart:math' as math;

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures/maplibre_fit_bounds_fixtures.dart';

void main() {
  const fitter = MapCameraBoundsFitter();

  group('MapCameraBoundsFitter MapLibre parity', () {
    for (final fixture in mapLibreFitBoundsFixtures) {
      test(fixture.name, () {
        final result = fitter.fit(
          bounds: fixture.bounds,
          viewportLogicalSize: fixture.viewportLogicalSize,
          devicePixelRatio: 1,
          padding: fixture.padding,
          minZoom: fixture.minZoom,
          maxZoom: fixture.maxZoom,
        );

        expect(result, isA<MapCameraBoundsFitSucceeded>());
        final camera = (result as MapCameraBoundsFitSucceeded).camera;
        expect(camera.zoom, closeTo(fixture.expectedCamera.zoom, 1e-6));
        expect(
          projectedDistanceInLogicalPixels(
            actual: camera,
            expected: fixture.expectedCamera,
          ),
          lessThanOrEqualTo(0.5),
        );
      });
    }

    test('DPR 1 and 3 produce the same logical camera', () {
      final fixture = mapLibreFitBoundsFixtures.first;
      MapCamera fitAt(double devicePixelRatio) {
        final result = fitter.fit(
          bounds: fixture.bounds,
          viewportLogicalSize: fixture.viewportLogicalSize,
          devicePixelRatio: devicePixelRatio,
          padding: fixture.padding,
          minZoom: fixture.minZoom,
          maxZoom: fixture.maxZoom,
        );
        return (result as MapCameraBoundsFitSucceeded).camera;
      }

      expect(fitAt(3), fitAt(1));
    });

    test('clamps to caller max zoom', () {
      const fixture = mapLibreMaxZoomClampFixture;
      final result = fitter.fit(
        bounds: fixture.bounds,
        viewportLogicalSize: fixture.viewportLogicalSize,
        devicePixelRatio: 1,
        padding: fixture.padding,
        minZoom: fixture.minZoom,
        maxZoom: fixture.maxZoom,
      );

      final camera = (result as MapCameraBoundsFitSucceeded).camera;
      expect(camera.zoom, fixture.expectedCamera.zoom);
      expect(
        projectedDistanceInLogicalPixels(
          actual: camera,
          expected: fixture.expectedCamera,
        ),
        lessThanOrEqualTo(0.5),
      );
    });

    test('clamps a world-sized result to caller min zoom', () {
      final result = fitter.fit(
        bounds: const MapCameraBounds(
          west: -170,
          south: -80,
          east: 170,
          north: 80,
        ),
        viewportLogicalSize: const Size(200, 100),
        devicePixelRatio: 1,
        padding: EdgeInsets.zero,
        minZoom: 2,
        maxZoom: 14,
      );

      expect(
        (result as MapCameraBoundsFitSucceeded).camera.zoom,
        2,
      );
    });
  });

  group('MapCameraBoundsFitter invalid input', () {
    test('rejects non-finite bounds', () {
      final result = fitter.fit(
        bounds: const MapCameraBounds(
          west: double.nan,
          south: 30,
          east: 145,
          north: 46,
        ),
        viewportLogicalSize: const Size(800, 600),
        devicePixelRatio: 1,
        padding: EdgeInsets.zero,
        minZoom: 0,
        maxZoom: 20,
      );

      expectInvalid(result, MapCameraBoundsFitInvalidReason.nonFiniteBounds);
    });

    test('rejects latitude outside Web Mercator', () {
      final result = fitter.fit(
        bounds: const MapCameraBounds(
          west: 130,
          south: 30,
          east: 145,
          north: 86,
        ),
        viewportLogicalSize: const Size(800, 600),
        devicePixelRatio: 1,
        padding: EdgeInsets.zero,
        minZoom: 0,
        maxZoom: 20,
      );

      expectInvalid(result, MapCameraBoundsFitInvalidReason.invalidBounds);
    });

    test('rejects an empty or inverted bounds', () {
      for (final bounds in [
        const MapCameraBounds(west: 10, south: 20, east: 10, north: 30),
        const MapCameraBounds(west: 10, south: 30, east: 20, north: 20),
      ]) {
        final result = fitter.fit(
          bounds: bounds,
          viewportLogicalSize: const Size(800, 600),
          devicePixelRatio: 1,
          padding: EdgeInsets.zero,
          minZoom: 0,
          maxZoom: 20,
        );

        expectInvalid(result, MapCameraBoundsFitInvalidReason.invalidBounds);
      }
    });

    test('rejects empty and non-finite viewport dimensions', () {
      for (final size in [const Size(0, 600), const Size(double.nan, 600)]) {
        final result = fitter.fit(
          bounds: const MapCameraBounds(
            west: 130,
            south: 30,
            east: 145,
            north: 46,
          ),
          viewportLogicalSize: size,
          devicePixelRatio: 1,
          padding: EdgeInsets.zero,
          minZoom: 0,
          maxZoom: 20,
        );

        expectInvalid(result, MapCameraBoundsFitInvalidReason.invalidViewport);
      }
    });

    test('rejects invalid DPR, padding, and zoom limits', () {
      const bounds = MapCameraBounds(
        west: 130,
        south: 30,
        east: 145,
        north: 46,
      );
      MapCameraBoundsFitResult fit({
        double devicePixelRatio = 1,
        EdgeInsets padding = EdgeInsets.zero,
        double minZoom = 0,
        double maxZoom = 20,
      }) => fitter.fit(
        bounds: bounds,
        viewportLogicalSize: const Size(800, 600),
        devicePixelRatio: devicePixelRatio,
        padding: padding,
        minZoom: minZoom,
        maxZoom: maxZoom,
      );

      expectInvalid(
        fit(devicePixelRatio: 0),
        MapCameraBoundsFitInvalidReason.invalidDevicePixelRatio,
      );
      expectInvalid(
        fit(padding: const EdgeInsets.only(left: -1)),
        MapCameraBoundsFitInvalidReason.invalidPadding,
      );
      expectInvalid(
        fit(padding: const EdgeInsets.symmetric(horizontal: 400)),
        MapCameraBoundsFitInvalidReason.paddingConsumesViewport,
      );
      expectInvalid(
        fit(minZoom: 10, maxZoom: 9),
        MapCameraBoundsFitInvalidReason.invalidZoomRange,
      );
    });
  });
}

void expectInvalid(
  MapCameraBoundsFitResult result,
  MapCameraBoundsFitInvalidReason reason,
) {
  expect(result, isA<MapCameraBoundsFitInvalid>());
  expect((result as MapCameraBoundsFitInvalid).reason, reason);
}

double projectedDistanceInLogicalPixels({
  required MapCamera actual,
  required MapCamera expected,
}) {
  final worldSize = 512 * math.pow(2, expected.zoom);
  ({double x, double y}) project(MapCamera camera) {
    final latitudeRadians = camera.centerLatitude * math.pi / 180;
    return (
      x: (camera.centerLongitude + 180) / 360 * worldSize,
      y:
          (0.5 -
              math.log(math.tan(math.pi / 4 + latitudeRadians / 2)) /
                  (2 * math.pi)) *
          worldSize,
    );
  }

  final actualPoint = project(actual);
  final expectedPoint = project(expected);
  final rawDx = (actualPoint.x - expectedPoint.x).abs();
  final wrappedDx = math.min(rawDx, (worldSize - rawDx).abs());
  final dy = actualPoint.y - expectedPoint.y;
  return math.sqrt(wrappedDx * wrappedDx + dy * dy);
}
