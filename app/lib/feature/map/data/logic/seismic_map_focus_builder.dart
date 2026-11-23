import 'dart:math' as math;

import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_grid_cell_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';

const seismicMapFocusMargin = 0.1;

/// フォーカス対象の周囲に最低限確保する半径(km)。
///
/// EEW は震源1点しか対象を持たないため、余白のみでは bounds が極小になり
/// [mapAutomaticFocusMaxZoom] に張り付いて過度に寄った表示になる。
/// 中心から最低この半径ぶんは映るように bounds を広げる。
/// 震源の周辺だけでなく、揺れが広がる範囲まで一度に見渡せる広さにしている。
const seismicMapFocusMinimumRadiusKm = 150.0;

/// 揺れ検知を含むフォーカス範囲を外側へ広げて揃える格子の間隔(度)。
///
/// 揺れ検知の範囲は検知点が増えるたびに少しずつ広がるため、そのまま使うと
/// カメラが毎回動く。格子に揃えて、範囲が格子をまたいだ時だけ動かす。
const seismicMapFocusShakeGridDegrees = 2.0;

const _kilometersPerLatitudeDegree = 111.32;

/// 高緯度で経度方向の換算が発散するのを防ぐための cos(緯度) の下限。
const _minimumCosineLatitude = 0.01;

typedef SeismicMapGeoCoordinate = ({double latitude, double longitude});

class const SeismicMapFocusBuilder() {
  MapCameraBounds forRealtime({
    required MapCameraBounds fallbackBounds,
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) {
    final targets = realtimeTargetCoordinates(eews: eews, shakes: shakes);
    if (targets.isEmpty) {
      return fallbackBounds;
    }
    return boundsForRealtimeTargets(targets: targets, shakes: shakes);
  }

  MapCameraBounds boundsForRealtimeTargets({
    required List<SeismicMapGeoCoordinate> targets,
    required List<ShakeDetectionEvent> shakes,
  }) {
    final hasShakeTarget = shakes.any(
      (shake) => shakeTargetCoordinates(shake).isNotEmpty,
    );
    if (!hasShakeTarget) {
      return expandedBounds(targets: targets);
    }
    // 格子に揃える分が余白になる。余白を足してから揃えると、格子上の辺が1格子ぶん余計に広がる。
    return snapOutward(
      bounds: expandedBounds(targets: targets, margin: 0),
      degrees: seismicMapFocusShakeGridDegrees,
    );
  }

  static MapCameraBounds snapOutward({
    required MapCameraBounds bounds,
    required double degrees,
  }) => MapCameraBounds(
    west: ((bounds.west / degrees).floor() * degrees)
        .clamp(-180, 180)
        .toDouble(),
    south: ((bounds.south / degrees).floor() * degrees)
        .clamp(-90, 90)
        .toDouble(),
    east: ((bounds.east / degrees).ceil() * degrees)
        .clamp(-180, 180)
        .toDouble(),
    north: ((bounds.north / degrees).ceil() * degrees)
        .clamp(-90, 90)
        .toDouble(),
  );

  List<SeismicMapGeoCoordinate> realtimeTargetCoordinates({
    required List<EewTelegramItem> eews,
    required List<ShakeDetectionEvent> shakes,
  }) => [
    ...eews.expand(eewTargetCoordinates),
    ...shakes.expand(shakeTargetCoordinates),
  ];

  static Iterable<SeismicMapGeoCoordinate> eewTargetCoordinates(
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

  static Iterable<SeismicMapGeoCoordinate> shakeTargetCoordinates(
    ShakeDetectionEvent shake,
  ) sync* {
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
    yield (
      latitude: ShakeDetectionGridCell.latitudeOfIndex(
        ShakeDetectionGridCell.latIndexOf(minimum.latitude),
      ).clamp(-90, 90).toDouble(),
      longitude: ShakeDetectionGridCell.longitudeOfIndex(
        ShakeDetectionGridCell.lngIndexOf(minimum.longitude),
      ).clamp(-180, 180).toDouble(),
    );
    yield (
      latitude: ShakeDetectionGridCell.latitudeOfIndex(
        ShakeDetectionGridCell.latIndexOf(maximum.latitude) + 1,
      ).clamp(-90, 90).toDouble(),
      longitude: ShakeDetectionGridCell.longitudeOfIndex(
        ShakeDetectionGridCell.lngIndexOf(maximum.longitude) + 1,
      ).clamp(-180, 180).toDouble(),
    );
  }

  static MapCameraBounds boundsForTargets({
    required List<SeismicMapGeoCoordinate> targets,
    required MapCameraBounds fallbackBounds,
  }) {
    if (targets.isEmpty) {
      return fallbackBounds;
    }
    return expandedBounds(targets: targets);
  }

  static MapCameraBounds expandedBounds({
    required List<SeismicMapGeoCoordinate> targets,
    double margin = seismicMapFocusMargin,
  }) {
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
    return expandToMinimumRadius(
      west: minLng - margin,
      east: maxLng + margin,
      south: minLat - margin,
      north: maxLat + margin,
    );
  }

  /// 矩形の中心から [seismicMapFocusMinimumRadiusKm] を下回る辺を押し広げる。
  ///
  /// 既に十分広い矩形はそのまま維持する。
  static MapCameraBounds expandToMinimumRadius({
    required double west,
    required double east,
    required double south,
    required double north,
  }) {
    final centerLatitude = (south + north) / 2;
    final centerLongitude = (west + east) / 2;
    final latitudeRadius =
        seismicMapFocusMinimumRadiusKm / _kilometersPerLatitudeDegree;
    final cosineLatitude = math
        .cos(centerLatitude * math.pi / 180)
        .abs()
        .clamp(_minimumCosineLatitude, 1.0);
    final longitudeRadius = latitudeRadius / cosineLatitude;

    return MapCameraBounds(
      west: math
          .min(west, centerLongitude - longitudeRadius)
          .clamp(-180, 180)
          .toDouble(),
      south: math
          .min(south, centerLatitude - latitudeRadius)
          .clamp(-90, 90)
          .toDouble(),
      east: math
          .max(east, centerLongitude + longitudeRadius)
          .clamp(-180, 180)
          .toDouble(),
      north: math
          .max(north, centerLatitude + latitudeRadius)
          .clamp(-90, 90)
          .toDouble(),
    );
  }

  static SeismicMapGeoCoordinate? seismicMapGeoCoordinate({
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
