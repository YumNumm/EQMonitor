import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:maplibre/maplibre.dart';

const liveMonitorMapSafeSpacing = 8.0;

typedef LiveMonitorGeoCoordinate = ({double latitude, double longitude});
typedef LiveMonitorMapObscuredInsets = ({double top, double bottom});

class LiveMonitorMapFocusBuilder {
  const LiveMonitorMapFocusBuilder();

  /// [SafeArea] が確保する余白のうち、地図側の固定余白を超える分と
  /// Card の実測高さを合成する。
  static LiveMonitorMapObscuredInsets obscuredInsets({
    required double systemTopInset,
    required double systemBottomInset,
    required double topCardHeight,
    required double bottomCardHeight,
  }) {
    final effectiveTopInset = systemTopInset > liveMonitorMapSafeSpacing
        ? systemTopInset
        : liveMonitorMapSafeSpacing;
    final effectiveBottomInset = systemBottomInset > liveMonitorMapSafeSpacing
        ? systemBottomInset
        : liveMonitorMapSafeSpacing;
    return (
      top:
          effectiveTopInset -
          liveMonitorMapSafeSpacing +
          (topCardHeight.isNegative ? 0 : topCardHeight),
      bottom:
          effectiveBottomInset -
          liveMonitorMapSafeSpacing +
          (bottomCardHeight.isNegative ? 0 : bottomCardHeight),
    );
  }

  LiveMonitorMapFocus forRealtime({
    required LiveMonitorGeoBounds homeBounds,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
    required double obscuredBottom,
  }) {
    final bounds = const SeismicMapFocusBuilder().forRealtime(
      fallbackBounds: LngLatBounds(
        longitudeWest: homeBounds.minLng,
        longitudeEast: homeBounds.maxLng,
        latitudeSouth: homeBounds.minLat,
        latitudeNorth: homeBounds.maxLat,
      ),
      eews: eews,
      shakes: shakes,
    );
    return forBounds(
      bounds: LiveMonitorGeoBounds(
        minLat: bounds.latitudeSouth,
        maxLat: bounds.latitudeNorth,
        minLng: bounds.longitudeWest,
        maxLng: bounds.longitudeEast,
      ),
      obscuredTop: 0,
      obscuredBottom: obscuredBottom,
    );
  }

  LiveMonitorMapFocus forEarthquake({
    required Earthquake earthquake,
    required LiveMonitorGeoBounds fallbackBounds,
    required double obscuredTop,
    required double obscuredBottom,
  }) => forTargets(
    targets: earthquakeTargetCoordinates(earthquake).toList(),
    fallbackBounds: fallbackBounds,
    obscuredTop: obscuredTop,
    obscuredBottom: obscuredBottom,
  );

  static LiveMonitorMapFocus forTargets({
    required List<LiveMonitorGeoCoordinate> targets,
    required LiveMonitorGeoBounds fallbackBounds,
    required double obscuredTop,
    required double obscuredBottom,
  }) => forBounds(
    bounds: boundsForTargets(targets: targets, fallbackBounds: fallbackBounds),
    obscuredTop: obscuredTop,
    obscuredBottom: obscuredBottom,
  );

  static LiveMonitorMapFocus forBounds({
    required LiveMonitorGeoBounds bounds,
    required double obscuredTop,
    required double obscuredBottom,
  }) => LiveMonitorMapFocus(
    bounds: bounds,
    padding: LiveMonitorMapPadding(
      top:
          liveMonitorMapSafeSpacing +
          (obscuredTop.isNegative ? 0 : obscuredTop),
      bottom:
          liveMonitorMapSafeSpacing +
          (obscuredBottom.isNegative ? 0 : obscuredBottom),
    ),
  );

  static LiveMonitorGeoBounds boundsForTargets({
    required List<LiveMonitorGeoCoordinate> targets,
    required LiveMonitorGeoBounds fallbackBounds,
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
    return LiveMonitorGeoBounds(
      minLat: (minLat - seismicMapFocusMargin).clamp(-90, 90).toDouble(),
      maxLat: (maxLat + seismicMapFocusMargin).clamp(-90, 90).toDouble(),
      minLng: (minLng - seismicMapFocusMargin).clamp(-180, 180).toDouble(),
      maxLng: (maxLng + seismicMapFocusMargin).clamp(-180, 180).toDouble(),
    );
  }

  static Iterable<LiveMonitorGeoCoordinate> earthquakeTargetCoordinates(
    Earthquake earthquake,
  ) sync* {
    final hypocenter = switch (earthquake.hypocenter?.coordinates) {
      CoordinateLatLng(:final latitude, :final longitude) => geoCoordinate(
        latitude: latitude,
        longitude: longitude,
      ),
      _ => null,
    };
    if (hypocenter != null) {
      yield hypocenter;
    }
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return;
    }
    for (final nodes in intensity.intensityTree.values) {
      for (final node in nodes) {
        for (final city in node.cities) {
          for (final station in city.stations) {
            final intensity = station.intensity?.maxIntensity;
            if (intensity == null ||
                intensity.orderIndex < JmaIntensity.one.orderIndex) {
              continue;
            }
            final coordinate = geoCoordinate(
              latitude: station.station.location.lat,
              longitude: station.station.location.lon,
            );
            if (coordinate != null) {
              yield coordinate;
            }
          }
        }
      }
    }
  }

  static LiveMonitorGeoCoordinate? geoCoordinate({
    required double? latitude,
    required double? longitude,
  }) {
    if (latitude == null || longitude == null) {
      return null;
    }
    if (!latitude.isFinite || !longitude.isFinite) {
      return null;
    }
    if (latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      return null;
    }
    return (latitude: latitude, longitude: longitude);
  }
}
