import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:eqmonitor/feature/map/data/logic/seismic_map_focus_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_map_focus_bounds_builder.g.dart';

@riverpod
EewMapFocusBoundsBuilder eewMapFocusBoundsBuilder(Ref ref) =>
    const EewMapFocusBoundsBuilder();

class EewMapFocusBoundsBuilder {
  const EewMapFocusBoundsBuilder();

  static const step = 0.5;

  EewMapFocusGridRect snapOutward({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) => EewMapFocusGridRect(
    minLat: (minLat / step).floorToDouble() * step,
    maxLat: (maxLat / step).ceilToDouble() * step,
    minLng: (minLng / step).floorToDouble() * step,
    maxLng: (maxLng / step).ceilToDouble() * step,
  );

  EewMapFocusGridRect union({
    required EewMapFocusGridRect a,
    required EewMapFocusGridRect b,
  }) => EewMapFocusGridRect(
    minLat: a.minLat < b.minLat ? a.minLat : b.minLat,
    maxLat: a.maxLat > b.maxLat ? a.maxLat : b.maxLat,
    minLng: a.minLng < b.minLng ? a.minLng : b.minLng,
    maxLng: a.maxLng > b.maxLng ? a.maxLng : b.maxLng,
  );

  /// 揺れ検知1件を 0.5° グリッド矩形へ変換する。
  ///
  /// 座標の妥当性検証は [shakeTargetCoordinates] と同じ基準
  /// （有限値・緯度経度レンジ・min <= max）に揃える。
  EewMapFocusGridRect? gridRectForShake({required ShakeDetectionEvent shake}) {
    final minimum = seismicMapGeoCoordinate(
      latitude: shake.minLat,
      longitude: shake.minLng,
    );
    final maximum = seismicMapGeoCoordinate(
      latitude: shake.maxLat,
      longitude: shake.maxLng,
    );
    if (minimum == null || maximum == null) {
      return null;
    }
    if (minimum.latitude > maximum.latitude ||
        minimum.longitude > maximum.longitude) {
      return null;
    }
    return snapOutward(
      minLat: minimum.latitude,
      maxLat: maximum.latitude,
      minLng: minimum.longitude,
      maxLng: maximum.longitude,
    );
  }

  EewMapFocusGridRect? mergeShakeEvents({
    required List<ShakeDetectionEvent> shakes,
  }) => shakes
      .map((shake) => gridRectForShake(shake: shake))
      .fold<EewMapFocusGridRect?>(
        null,
        (accumulated, rect) => switch ((accumulated, rect)) {
          (null, final rect) => rect,
          (final accumulated?, null) => accumulated,
          (final accumulated?, final rect?) => union(a: accumulated, b: rect),
        },
      );

  LngLatBounds? boundsForFocus({
    required ({double latitude, double longitude})? hypocenter,
    required EewMapFocusGridRect? shakeRect,
    required LngLatBounds fallbackBounds,
  }) {
    final hypocenterCoordinate = hypocenter == null
        ? null
        : seismicMapGeoCoordinate(
            latitude: hypocenter.latitude,
            longitude: hypocenter.longitude,
          );
    final targets = <SeismicMapGeoCoordinate>[
      if (hypocenterCoordinate != null) hypocenterCoordinate,
      if (shakeRect != null) ...[
        (latitude: shakeRect.minLat, longitude: shakeRect.minLng),
        (latitude: shakeRect.maxLat, longitude: shakeRect.maxLng),
      ],
    ];
    if (targets.isEmpty) {
      return null;
    }
    return boundsForTargets(targets: targets, fallbackBounds: fallbackBounds);
  }
}
