import 'dart:math' as math;

import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:maplibre/maplibre.dart';

const seismicMapFocusMargin = 0.1;

/// フォーカス対象の周囲に最低限確保する半径(km)。
///
/// EEW は震源1点しか対象を持たないため、余白のみでは bounds が極小になり
/// [mapAutomaticFocusMaxZoom] に張り付いて過度に寄った表示になる。
/// 中心から最低この半径ぶんは映るように bounds を広げる。
const seismicMapFocusMinimumRadiusKm = 50.0;

const _kilometersPerLatitudeDegree = 111.32;

/// 高緯度で経度方向の換算が発散するのを防ぐための cos(緯度) の下限。
const _minimumCosineLatitude = 0.01;

typedef SeismicMapGeoCoordinate = ({double latitude, double longitude});

class SeismicMapFocusBuilder {
  const new();

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

  static LngLatBounds boundsForTargets({
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
    return expandToMinimumRadius(
      west: minLng - seismicMapFocusMargin,
      east: maxLng + seismicMapFocusMargin,
      south: minLat - seismicMapFocusMargin,
      north: maxLat + seismicMapFocusMargin,
    );
  }

  /// 矩形の中心から [seismicMapFocusMinimumRadiusKm] を下回る辺を押し広げる。
  ///
  /// 既に十分広い矩形はそのまま維持する。
  static LngLatBounds expandToMinimumRadius({
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

    return LngLatBounds(
      longitudeWest: math
          .min(west, centerLongitude - longitudeRadius)
          .clamp(-180, 180)
          .toDouble(),
      longitudeEast: math
          .max(east, centerLongitude + longitudeRadius)
          .clamp(-180, 180)
          .toDouble(),
      latitudeSouth: math
          .min(south, centerLatitude - latitudeRadius)
          .clamp(-90, 90)
          .toDouble(),
      latitudeNorth: math
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
