import 'package:flutter/foundation.dart';

/// Geographic bounds in WGS84 degrees.
///
/// A value with [west] greater than [east] explicitly crosses the
/// antimeridian. Validation belongs to the pure bounds fitter so invalid
/// external inputs can be returned as typed failures instead of exceptions.
@immutable
final class const MapCameraBounds({
  required final double west,
  required final double south,
  required final double east,
  required final double north,
}) {
  @override
  bool operator ==(Object other) =>
      other is MapCameraBounds &&
      other.west == west &&
      other.south == south &&
      other.east == east &&
      other.north == north;

  @override
  int get hashCode => Object.hash(west, south, east, north);
}
