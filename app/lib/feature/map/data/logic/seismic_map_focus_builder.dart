import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:maplibre/maplibre.dart';

const seismicMapFocusMargin = 0.1;

typedef SeismicMapGeoCoordinate = ({double latitude, double longitude});

class SeismicMapFocusBuilder {
  const SeismicMapFocusBuilder();

  LngLatBounds forRealtime({
    required LngLatBounds fallbackBounds,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) {
    final targets = realtimeTargetCoordinates(eews: eews, shakes: shakes);
    return boundsForTargets(targets: targets, fallbackBounds: fallbackBounds);
  }

  List<SeismicMapGeoCoordinate> realtimeTargetCoordinates({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) => [
    ...eews.expand(eewTargetCoordinates),
    ...shakes.expand(shakeTargetCoordinates),
  ];
}

Iterable<SeismicMapGeoCoordinate> eewTargetCoordinates(
  EewTelegramItem eew,
) sync* {
  final hypocenter = eew.hypocenter;
  final coordinate = seismicMapGeoCoordinate(
    latitude: hypocenter?.latitude,
    longitude: hypocenter?.longitude,
  );
  if (coordinate != null) {
    yield coordinate;
  }
}

Iterable<SeismicMapGeoCoordinate> shakeTargetCoordinates(
  ShakeDetectionEvent shake,
) sync* {
  if (shake.correlatedEewEventId != null) {
    return;
  }
  final minimum = seismicMapGeoCoordinate(
    latitude: shake.minLat,
    longitude: shake.minLng,
  );
  final maximum = seismicMapGeoCoordinate(
    latitude: shake.maxLat,
    longitude: shake.maxLng,
  );
  if (minimum == null || maximum == null) {
    return;
  }
  if (minimum.latitude > maximum.latitude ||
      minimum.longitude > maximum.longitude) {
    return;
  }
  yield minimum;
  yield maximum;
}

LngLatBounds boundsForTargets({
  required List<SeismicMapGeoCoordinate> targets,
  required LngLatBounds fallbackBounds,
}) {
  if (targets.isEmpty) {
    return fallbackBounds;
  }
  final first = targets.first;
  final minLat = targets.fold(
    first.latitude,
    (value, point) => point.latitude < value ? point.latitude : value,
  );
  final maxLat = targets.fold(
    first.latitude,
    (value, point) => point.latitude > value ? point.latitude : value,
  );
  final minLng = targets.fold(
    first.longitude,
    (value, point) => point.longitude < value ? point.longitude : value,
  );
  final maxLng = targets.fold(
    first.longitude,
    (value, point) => point.longitude > value ? point.longitude : value,
  );
  return LngLatBounds(
    longitudeWest: (minLng - seismicMapFocusMargin).clamp(-180, 180).toDouble(),
    longitudeEast: (maxLng + seismicMapFocusMargin).clamp(-180, 180).toDouble(),
    latitudeSouth: (minLat - seismicMapFocusMargin).clamp(-90, 90).toDouble(),
    latitudeNorth: (maxLat + seismicMapFocusMargin).clamp(-90, 90).toDouble(),
  );
}

SeismicMapGeoCoordinate? seismicMapGeoCoordinate({
  required double? latitude,
  required double? longitude,
}) {
  if (latitude == null || longitude == null) {
    return null;
  }
  if (!latitude.isFinite || !longitude.isFinite) {
    return null;
  }
  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
    return null;
  }
  return (latitude: latitude, longitude: longitude);
}
