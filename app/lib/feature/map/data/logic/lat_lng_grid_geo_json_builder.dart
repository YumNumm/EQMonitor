import 'dart:convert';
import 'dart:math' as math;

import 'package:eqmonitor/feature/map/data/logic/lat_lng_grid_interval_selector.dart';
import 'package:maplibre/maplibre.dart';

final class LatLngGridGeoJsonBuilder {
  const LatLngGridGeoJsonBuilder({
    this.intervalSelector = const LatLngGridIntervalSelector(),
  });

  static const mercatorLimit = 85.0511287798066;
  static const maxFeatureCount = 20;
  static const coordinateScale = 1000000000000;
  static const emptyFeatureCollection =
      '{"type":"FeatureCollection","features":[]}';

  final LatLngGridIntervalSelector intervalSelector;

  String build({required LngLatBounds bounds, required int zoomLevel}) {
    final longitudeWest = bounds.longitudeWest;
    final longitudeEast = bounds.longitudeEast;
    final latitudeSouth = bounds.latitudeSouth;
    final latitudeNorth = bounds.latitudeNorth;
    final values = <double>[
      longitudeWest,
      longitudeEast,
      latitudeSouth,
      latitudeNorth,
    ];
    if (values.any((value) => !value.isFinite)) {
      throw ArgumentError.value(bounds, 'bounds', 'Values must be finite');
    }
    if (longitudeWest < -180 || longitudeWest > 180) {
      throw RangeError.range(longitudeWest, -180, 180, 'longitudeWest');
    }
    if (longitudeEast < -180 || longitudeEast > 180) {
      throw RangeError.range(longitudeEast, -180, 180, 'longitudeEast');
    }
    if (latitudeSouth < -90 || latitudeSouth > 90) {
      throw RangeError.range(latitudeSouth, -90, 90, 'latitudeSouth');
    }
    if (latitudeNorth < -90 || latitudeNorth > 90) {
      throw RangeError.range(latitudeNorth, -90, 90, 'latitudeNorth');
    }
    if (latitudeSouth > latitudeNorth) {
      throw ArgumentError.value(
        bounds,
        'bounds',
        'latitudeSouth must not exceed latitudeNorth',
      );
    }

    final interval = intervalSelector.select(zoomLevel: zoomLevel);
    final clippedSouth = math.max(latitudeSouth, -mercatorLimit);
    final clippedNorth = math.min(latitudeNorth, mercatorLimit);
    if (clippedSouth > clippedNorth) {
      return emptyFeatureCollection;
    }

    final longitudeSegments = longitudeWest <= longitudeEast
        ? [(west: longitudeWest, east: longitudeEast)]
        : [
            (west: longitudeWest, east: 180.0),
            (west: -180.0, east: longitudeEast),
          ];
    final scaledInterval = (interval * coordinateScale).round();
    int ceilIndex(int scaledCoordinate) {
      final quotient = scaledCoordinate ~/ scaledInterval;
      return scaledCoordinate.remainder(scaledInterval) > 0
          ? quotient + 1
          : quotient;
    }

    int floorIndex(int scaledCoordinate) {
      final quotient = scaledCoordinate ~/ scaledInterval;
      return scaledCoordinate.remainder(scaledInterval) < 0
          ? quotient - 1
          : quotient;
    }

    final verticalValues = <double>{};
    for (final segment in longitudeSegments) {
      final scaledWest = (segment.west * coordinateScale).round();
      final scaledEast = (segment.east * coordinateScale).round();
      final firstIndex = ceilIndex(scaledWest);
      final lastIndex = floorIndex(scaledEast);
      for (var index = firstIndex; index <= lastIndex; index++) {
        final value = double.parse((index * interval).toStringAsFixed(12));
        verticalValues.add(value == -0.0 ? 0.0 : value);
      }
    }
    if (verticalValues.contains(-180.0) && verticalValues.contains(180.0)) {
      verticalValues.remove(180.0);
    }
    final sortedVerticalValues = verticalValues.toList()..sort();

    final horizontalValues = <double>[];
    final scaledSouth = (clippedSouth * coordinateScale).round();
    final scaledNorth = (clippedNorth * coordinateScale).round();
    final firstLatitudeIndex = ceilIndex(scaledSouth);
    final lastLatitudeIndex = floorIndex(scaledNorth);
    for (var index = firstLatitudeIndex; index <= lastLatitudeIndex; index++) {
      final value = double.parse((index * interval).toStringAsFixed(12));
      horizontalValues.add(value == -0.0 ? 0.0 : value);
    }

    final featureCount =
        sortedVerticalValues.length +
        horizontalValues.length * longitudeSegments.length;
    if (featureCount > maxFeatureCount) {
      throw StateError(
        'Grid request produces $featureCount features; '
        'the limit is $maxFeatureCount',
      );
    }

    final normalizedSouth = double.parse(clippedSouth.toStringAsFixed(12));
    final normalizedNorth = double.parse(clippedNorth.toStringAsFixed(12));
    final features = <Map<String, dynamic>>[];
    for (final longitude in sortedVerticalValues) {
      features.add({
        'type': 'Feature',
        'properties': <String, dynamic>{},
        'geometry': {
          'type': 'LineString',
          'coordinates': [
            [longitude, normalizedSouth == -0.0 ? 0.0 : normalizedSouth],
            [longitude, normalizedNorth == -0.0 ? 0.0 : normalizedNorth],
          ],
        },
      });
    }
    for (final latitude in horizontalValues) {
      for (final segment in longitudeSegments) {
        final normalizedWest = double.parse(segment.west.toStringAsFixed(12));
        final normalizedEast = double.parse(segment.east.toStringAsFixed(12));
        features.add({
          'type': 'Feature',
          'properties': <String, dynamic>{},
          'geometry': {
            'type': 'LineString',
            'coordinates': [
              [normalizedWest == -0.0 ? 0.0 : normalizedWest, latitude],
              [normalizedEast == -0.0 ? 0.0 : normalizedEast, latitude],
            ],
          },
        });
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
