import 'dart:math' as math;

final class const GeoDistanceCalculator() {
  static const _earthRadiusKm = 6371.0;

  double epicentral({
    required double latitude1,
    required double longitude1,
    required double latitude2,
    required double longitude2,
  }) {
    const toRadians = math.pi / 180;
    final latitudeDelta = (latitude2 - latitude1) * toRadians;
    final longitudeDelta = (longitude2 - longitude1) * toRadians;
    final a =
        math.sin(latitudeDelta / 2) * math.sin(latitudeDelta / 2) +
        math.cos(latitude1 * toRadians) *
            math.cos(latitude2 * toRadians) *
            math.sin(longitudeDelta / 2) *
            math.sin(longitudeDelta / 2);
    return _earthRadiusKm * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  double hypocentral({
    required double epicentralDistance,
    required double depth,
  }) => math.sqrt(epicentralDistance * epicentralDistance + depth * depth);
}
