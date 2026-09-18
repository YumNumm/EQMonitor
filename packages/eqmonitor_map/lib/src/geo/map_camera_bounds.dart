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
});
