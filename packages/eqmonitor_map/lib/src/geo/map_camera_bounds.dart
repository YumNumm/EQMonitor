import 'package:flutter/foundation.dart';

/// Geographic bounds in WGS84 degrees.
///
/// A value with [west] greater than [east] explicitly crosses the
/// antimeridian. Validation belongs to the pure bounds fitter so invalid
/// external inputs can be returned as typed failures instead of exceptions.
@immutable
final class MapCameraBounds {
  const new({
    required this.west,
    required this.south,
    required this.east,
    required this.north,
  });

  final double west;
  final double south;
  final double east;
  final double north;
}
