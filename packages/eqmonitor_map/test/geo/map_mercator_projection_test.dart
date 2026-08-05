import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const projection = MapMercatorProjection();

  group('scale/worldSize', () {
    test('doubles per zoom level and scales the 512px tile basis', () {
      expect(projection.scaleForZoom(0), 1);
      expect(projection.scaleForZoom(10), 1024);
      expect(projection.worldSizeForZoom(0), 512);
      expect(projection.worldSizeForZoom(1), 1024);
    });

    test('rejects a non-finite zoom', () {
      for (final zoom in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ]) {
        expect(() => projection.scaleForZoom(zoom), throwsArgumentError);
      }
    });
  });

  group('lngLatToNormalized', () {
    test('maps the origin to the center of the normalized square', () {
      final normalized = projection.lngLatToNormalized(
        longitude: 0,
        latitude: 0,
      );
      expect(normalized.x, closeTo(0.5, 1e-12));
      expect(normalized.y, closeTo(0.5, 1e-12));
    });

    test('round-trips WGS84 <-> normalized for representative points', () {
      for (final point in [
        (longitude: 0.0, latitude: 0.0),
        (longitude: 139.767, latitude: 35.681), // 東京
        (longitude: -122.4, latitude: 37.7), // San Francisco
        (longitude: -179.5, latitude: -40.0),
        (longitude: 0.0, latitude: 60.0),
      ]) {
        final normalized = projection.lngLatToNormalized(
          longitude: point.longitude,
          latitude: point.latitude,
        );
        final back = projection.normalizedToLngLat(
          x: normalized.x,
          y: normalized.y,
        );
        expect(back.longitude, closeTo(point.longitude, 1e-9));
        expect(back.latitude, closeTo(point.latitude, 1e-9));
      }
    });

    test('clamps latitude beyond maxLatitude without mutating the input', () {
      const rawLatitude = 90.0;
      final overNorth = projection.lngLatToNormalized(
        longitude: 0,
        latitude: rawLatitude,
      );
      final clampedNorth = projection.lngLatToNormalized(
        longitude: 0,
        latitude: MapMercatorProjection.maxLatitude,
      );
      expect(overNorth.y, closeTo(clampedNorth.y, 1e-12));
      // clampは投影内部の話であり、呼び出し側のWGS84値は変わらない。
      expect(rawLatitude, 90.0);

      final overSouth = projection.lngLatToNormalized(
        longitude: 0,
        latitude: -90,
      );
      final clampedSouth = projection.lngLatToNormalized(
        longitude: 0,
        latitude: -MapMercatorProjection.maxLatitude,
      );
      expect(overSouth.y, closeTo(clampedSouth.y, 1e-12));
    });

    test('maps maxLatitude close to the normalized edges', () {
      final north = projection.lngLatToNormalized(
        longitude: 0,
        latitude: MapMercatorProjection.maxLatitude,
      );
      final south = projection.lngLatToNormalized(
        longitude: 0,
        latitude: -MapMercatorProjection.maxLatitude,
      );
      expect(north.y, closeTo(0, 1e-9));
      expect(south.y, closeTo(1, 1e-9));
    });

    test('wraps longitude across the date line to a continuous value', () {
      final beyondEast = projection.lngLatToNormalized(
        longitude: 181,
        latitude: 0,
      );
      final wrappedWest = projection.lngLatToNormalized(
        longitude: -179,
        latitude: 0,
      );
      expect(beyondEast.x, closeTo(wrappedWest.x, 1e-12));

      // 180度ちょうどは半開区間[-180,180)の-180側へ畳み込まれる。
      final exactlyDateLine = projection.lngLatToNormalized(
        longitude: 180,
        latitude: 0,
      );
      expect(exactlyDateLine.x, closeTo(0, 1e-12));

      for (final point in [
        projection.lngLatToNormalized(longitude: 181, latitude: 10),
        projection.lngLatToNormalized(longitude: -359, latitude: 10),
        projection.lngLatToNormalized(longitude: 720 + 1, latitude: 10),
      ]) {
        expect(point.x, inInclusiveRange(0, 1));
      }
    });

    test('rejects non-finite longitude or latitude', () {
      for (final value in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ]) {
        expect(
          () => projection.lngLatToNormalized(longitude: value, latitude: 0),
          throwsArgumentError,
        );
        expect(
          () => projection.lngLatToNormalized(longitude: 0, latitude: value),
          throwsArgumentError,
        );
      }
    });
  });

  group('normalizedToLngLat', () {
    test('rejects non-finite x or y', () {
      for (final value in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ]) {
        expect(
          () => projection.normalizedToLngLat(x: value, y: 0.5),
          throwsArgumentError,
        );
        expect(
          () => projection.normalizedToLngLat(x: 0.5, y: value),
          throwsArgumentError,
        );
      }
    });
  });
}
