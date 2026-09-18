import 'dart:math' as math;

class const EarthquakeActivityBounds({
  required final double latitudeGte,
  required final double latitudeLte,
  required final double longitudeGte,
  required final double longitudeLte,
});

class const EarthquakeActivityBoundsCalculator() {
  static const _earthRadiusKm = 6371.0;

  EarthquakeActivityBounds calculate({
    required double latitude,
    required double longitude,
    required int radiusKm,
  }) {
    final angularDistance = radiusKm / _earthRadiusKm;
    final latitudeRadians = latitude * math.pi / 180;
    final latitudeDelta = angularDistance * 180 / math.pi;
    final cosine = math.cos(latitudeRadians).abs();
    final longitudeDelta = cosine < 0.000001
        ? 180.0
        : math.asin((math.sin(angularDistance) / cosine).clamp(-1.0, 1.0)) *
              180 /
              math.pi;

    return EarthquakeActivityBounds(
      latitudeGte: (latitude - latitudeDelta).clamp(-90, 90),
      latitudeLte: (latitude + latitudeDelta).clamp(-90, 90),
      longitudeGte: (longitude - longitudeDelta).clamp(-180, 180),
      longitudeLte: (longitude + longitudeDelta).clamp(-180, 180),
    );
  }
}
