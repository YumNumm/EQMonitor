import 'dart:convert';

import 'package:eqmonitor/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  const builder = LatLngGridGeoJsonBuilder();

  Map<String, dynamic> decode(String value) =>
      jsonDecode(value) as Map<String, dynamic>;

  List<Map<String, dynamic>> featuresOf(String value) =>
      List<Map<String, dynamic>>.from(decode(value)['features']);

  List<List<num>> coordinatesOf(Map<String, dynamic> feature) {
    final geometry = feature['geometry'] as Map<String, dynamic>;
    return [
      List<num>.from(geometry['coordinates'][0]),
      List<num>.from(geometry['coordinates'][1]),
    ];
  }

  test('builds a stable FeatureCollection with longitude-latitude pairs', () {
    const bounds = LngLatBounds(
      longitudeWest: 139,
      longitudeEast: 140,
      latitudeSouth: 35,
      latitudeNorth: 36,
    );

    final first = builder.build(bounds: bounds, zoomLevel: 7);
    final second = builder.build(bounds: bounds, zoomLevel: 7);
    final decoded = decode(first);
    final features = featuresOf(first);

    expect(first, second);
    expect(decoded['type'], 'FeatureCollection');
    expect(features, hasLength(6));
    expect(
      features.take(3).map((feature) => coordinatesOf(feature).first.first),
      [139, 139.5, 140],
    );
    expect(
      features.skip(3).map((feature) => coordinatesOf(feature).first.last),
      [35, 35.5, 36],
    );
    expect(
      features.map(coordinatesOf).expand((coordinates) => coordinates),
      everyElement(hasLength(2)),
    );
    expect(coordinatesOf(features[0]), [
      [139, 35],
      [139, 36],
    ]);
    expect(coordinatesOf(features[3]), [
      [139, 35],
      [140, 35],
    ]);
  });

  test('splits horizontal lines and emits the antimeridian only once', () {
    final features = featuresOf(
      builder.build(
        bounds: const LngLatBounds(
          longitudeWest: 179,
          longitudeEast: -179,
          latitudeSouth: 0,
          latitudeNorth: 1,
        ),
        zoomLevel: 7,
      ),
    );

    expect(features, hasLength(11));
    expect(
      features.take(5).map((feature) => coordinatesOf(feature).first.first),
      [-180, -179.5, -179, 179, 179.5],
    );
    expect(
      features
          .take(5)
          .where((feature) => coordinatesOf(feature).first.first.abs() == 180),
      hasLength(1),
    );
    expect(coordinatesOf(features[5]), [
      [179, 0],
      [180, 0],
    ]);
    expect(coordinatesOf(features[6]), [
      [-180, 0],
      [-179, 0],
    ]);
    expect(coordinatesOf(features[7]), [
      [179, 0.5],
      [180, 0.5],
    ]);
  });

  test('deduplicates exact -180 and 180 bounds', () {
    final features = featuresOf(
      builder.build(
        bounds: const LngLatBounds(
          longitudeWest: -180,
          longitudeEast: 180,
          latitudeSouth: 0,
          latitudeNorth: 0,
        ),
        zoomLevel: 0,
      ),
    );
    final verticalLongitudes = features
        .take(8)
        .map((feature) => coordinatesOf(feature).first.first)
        .toList();

    expect(features, hasLength(9));
    expect(verticalLongitudes, [-180, -135, -90, -45, 0, 45, 90, 135]);
  });

  test('returns an empty collection when tiny bounds contain no grid line', () {
    final result = builder.build(
      bounds: const LngLatBounds(
        longitudeWest: 139.1,
        longitudeEast: 139.2,
        latitudeSouth: 35.1,
        latitudeNorth: 35.2,
      ),
      zoomLevel: 7,
    );

    expect(result, LatLngGridGeoJsonBuilder.emptyFeatureCollection);
  });

  test('clips line endpoints to the Web Mercator latitude limits', () {
    final features = featuresOf(
      builder.build(
        bounds: const LngLatBounds(
          longitudeWest: 135,
          longitudeEast: 135,
          latitudeSouth: -90,
          latitudeNorth: 90,
        ),
        zoomLevel: 0,
      ),
    );

    expect(coordinatesOf(features.first), [
      [135, -85.051128779807],
      [135, 85.051128779807],
    ]);
  });

  test('returns an empty collection outside the Web Mercator region', () {
    final result = builder.build(
      bounds: const LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 140,
        latitudeSouth: 86,
        latitudeNorth: 90,
      ),
      zoomLevel: 7,
    );

    expect(result, LatLngGridGeoJsonBuilder.emptyFeatureCollection);
  });

  test('normalizes negative zero in emitted coordinates', () {
    final result = builder.build(
      bounds: const LngLatBounds(
        longitudeWest: -0.0,
        longitudeEast: 0,
        latitudeSouth: -0.0,
        latitudeNorth: 0,
      ),
      zoomLevel: 0,
    );

    expect(result, isNot(contains('-0.0')));
    expect(featuresOf(result), hasLength(2));
  });

  test('includes decimal interval boundaries despite IEEE 754 rounding', () {
    const cases = [
      (zoomLevel: 9, extent: 0.3, expectedCount: 14),
      (zoomLevel: 11, extent: 0.05, expectedCount: 10),
    ];

    for (final testCase in cases) {
      final features = featuresOf(
        builder.build(
          bounds: LngLatBounds(
            longitudeWest: -testCase.extent,
            longitudeEast: testCase.extent,
            latitudeSouth: -testCase.extent,
            latitudeNorth: testCase.extent,
          ),
          zoomLevel: testCase.zoomLevel,
        ),
      );
      final verticalCount = testCase.expectedCount ~/ 2;

      expect(features, hasLength(testCase.expectedCount));
      expect(coordinatesOf(features.first).first.first, -testCase.extent);
      expect(
        coordinatesOf(features[verticalCount - 1]).first.first,
        testCase.extent,
      );
      expect(
        coordinatesOf(features[verticalCount]).first.last,
        -testCase.extent,
      );
      expect(coordinatesOf(features.last).first.last, testCase.extent);
    }
  });

  test('rejects every non-finite bounds field', () {
    const invalidBounds = [
      LngLatBounds(
        longitudeWest: double.nan,
        longitudeEast: 140,
        latitudeSouth: 35,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: double.infinity,
        latitudeSouth: 35,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 140,
        latitudeSouth: double.negativeInfinity,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 140,
        latitudeSouth: 35,
        latitudeNorth: double.nan,
      ),
    ];

    for (final bounds in invalidBounds) {
      expect(
        () => builder.build(bounds: bounds, zoomLevel: 7),
        throwsArgumentError,
      );
    }
  });

  test('rejects reversed latitude bounds', () {
    expect(
      () => builder.build(
        bounds: const LngLatBounds(
          longitudeWest: 139,
          longitudeEast: 140,
          latitudeSouth: 36,
          latitudeNorth: 35,
        ),
        zoomLevel: 7,
      ),
      throwsArgumentError,
    );
  });

  test('rejects out-of-range longitude and latitude values', () {
    const invalidBounds = [
      LngLatBounds(
        longitudeWest: -181,
        longitudeEast: 140,
        latitudeSouth: 35,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 181,
        latitudeSouth: 35,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 140,
        latitudeSouth: -91,
        latitudeNorth: 36,
      ),
      LngLatBounds(
        longitudeWest: 139,
        longitudeEast: 140,
        latitudeSouth: 35,
        latitudeNorth: 91,
      ),
    ];

    for (final bounds in invalidBounds) {
      expect(
        () => builder.build(bounds: bounds, zoomLevel: 7),
        throwsRangeError,
      );
    }
  });

  test('rejects zoom levels outside 0 through 30', () {
    const bounds = LngLatBounds(
      longitudeWest: 139,
      longitudeEast: 140,
      latitudeSouth: 35,
      latitudeNorth: 36,
    );

    expect(
      () => builder.build(bounds: bounds, zoomLevel: -1),
      throwsRangeError,
    );
    expect(
      () => builder.build(bounds: bounds, zoomLevel: 31),
      throwsRangeError,
    );
  });

  test('rejects requests that would exceed the feature limit', () {
    expect(
      () => builder.build(
        bounds: const LngLatBounds(
          longitudeWest: -180,
          longitudeEast: 180,
          latitudeSouth: 0,
          latitudeNorth: 0,
        ),
        zoomLevel: 30,
      ),
      throwsStateError,
    );
  });
}
