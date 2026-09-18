import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';

/// One validated point sprite and its immutable batch policies.
final class MapPointSpriteFeature {
  const MapPointSpriteFeature._({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.spriteRegionId,
    required this.sizeScale,
    required this.opacity,
    required this.priority,
  });

  final String id;
  final double longitude;
  final double latitude;
  final String spriteRegionId;
  final MapZoomLinearRange sizeScale;
  final MapZoomStep opacity;
  final int priority;
}

MapPointSpriteFeature createMapPointSpriteFeature({
  required String id,
  required double longitude,
  required double latitude,
  required String spriteRegionId,
  required MapZoomLinearRange sizeScale,
  required MapZoomStep opacity,
  required int priority,
}) {
  if (id.trim().isEmpty) {
    throw ArgumentError.value(id, 'id', 'must not be blank');
  }
  if (spriteRegionId.trim().isEmpty) {
    throw ArgumentError.value(
      spriteRegionId,
      'spriteRegionId',
      'must not be blank',
    );
  }
  if (!longitude.isFinite || longitude < -180 || longitude > 180) {
    throw ArgumentError.value(longitude, 'longitude');
  }
  if (!latitude.isFinite || latitude < -90 || latitude > 90) {
    throw ArgumentError.value(latitude, 'latitude');
  }
  if (priority.isNegative) {
    throw ArgumentError.value(priority, 'priority', 'must not be negative');
  }
  return MapPointSpriteFeature._(
    id: id,
    longitude: longitude,
    latitude: latitude,
    spriteRegionId: spriteRegionId,
    sizeScale: sizeScale,
    opacity: opacity,
    priority: priority,
  );
}
