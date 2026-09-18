import 'dart:ui';

import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';

/// 震度区域の描画style。
final class EarthquakeAreaStyle {
  const EarthquakeAreaStyle({
    required this.code,
    required this.color,
    required this.opacity,
  });

  final String code;
  final Color color;
  final double opacity;
}

/// 震度観測点の描画情報。
final class EarthquakeObservationPoint {
  const EarthquakeObservationPoint({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.color,
    required this.radiusLogicalPixels,
  });

  final String id;
  final double longitude;
  final double latitude;
  final Color color;
  final double radiusLogicalPixels;
}

/// 一つの地震sourceに対応する完全なoverlay描画入力。
final class EarthquakeMapOverlaySnapshot {
  const EarthquakeMapOverlaySnapshot._({
    required this.versionStamp,
    required this.regionToCityZoom,
    required this.stationMinZoom,
    required this.regionStyles,
    required this.cityStyles,
    required this.stations,
    required this.spriteAtlas,
    required this.sprites,
    required this.maxSpritePolicyBatches,
  });

  final MapOverlayVersionStamp versionStamp;
  final double regionToCityZoom;
  final double stationMinZoom;
  final List<EarthquakeAreaStyle> regionStyles;
  final List<EarthquakeAreaStyle> cityStyles;
  final List<EarthquakeObservationPoint> stations;
  final MapSpriteAtlas? spriteAtlas;
  final List<MapPointSpriteFeature> sprites;
  final int maxSpritePolicyBatches;
}

/// [EarthquakeMapOverlaySnapshot]を検証済みの不変入力から構築する。
EarthquakeMapOverlaySnapshot createEarthquakeMapOverlaySnapshot({
  required MapOverlayVersionStamp versionStamp,
  required double regionToCityZoom,
  required double stationMinZoom,
  required List<EarthquakeAreaStyle> regionStyles,
  required List<EarthquakeAreaStyle> cityStyles,
  required List<EarthquakeObservationPoint> stations,
  required MapSpriteAtlas? spriteAtlas,
  required List<MapPointSpriteFeature> sprites,
  required int maxSpritePolicyBatches,
}) {
  _validateSnapshotValues(
    regionToCityZoom: regionToCityZoom,
    stationMinZoom: stationMinZoom,
  );
  _validateAreaStyles(styles: regionStyles, parameterName: 'regionStyles');
  _validateAreaStyles(styles: cityStyles, parameterName: 'cityStyles');
  _validateStations(stations: stations);
  _validateSprites(
    spriteAtlas: spriteAtlas,
    sprites: sprites,
    maxSpritePolicyBatches: maxSpritePolicyBatches,
  );

  return EarthquakeMapOverlaySnapshot._(
    versionStamp: versionStamp,
    regionToCityZoom: regionToCityZoom,
    stationMinZoom: stationMinZoom,
    regionStyles: List<EarthquakeAreaStyle>.unmodifiable(regionStyles),
    cityStyles: List<EarthquakeAreaStyle>.unmodifiable(cityStyles),
    stations: List<EarthquakeObservationPoint>.unmodifiable(stations),
    spriteAtlas: spriteAtlas,
    sprites: List<MapPointSpriteFeature>.unmodifiable(sprites),
    maxSpritePolicyBatches: maxSpritePolicyBatches,
  );
}

/// Replaces only the atlas while retaining every non-texture overlay input.
EarthquakeMapOverlaySnapshot replaceEarthquakeMapOverlaySpriteAtlas({
  required EarthquakeMapOverlaySnapshot snapshot,
  required MapSpriteAtlas spriteAtlas,
}) {
  _validateSprites(
    spriteAtlas: spriteAtlas,
    sprites: snapshot.sprites,
    maxSpritePolicyBatches: snapshot.maxSpritePolicyBatches,
  );
  return EarthquakeMapOverlaySnapshot._(
    versionStamp: snapshot.versionStamp,
    regionToCityZoom: snapshot.regionToCityZoom,
    stationMinZoom: snapshot.stationMinZoom,
    regionStyles: snapshot.regionStyles,
    cityStyles: snapshot.cityStyles,
    stations: snapshot.stations,
    spriteAtlas: spriteAtlas,
    sprites: snapshot.sprites,
    maxSpritePolicyBatches: snapshot.maxSpritePolicyBatches,
  );
}

void _validateSnapshotValues({
  required double regionToCityZoom,
  required double stationMinZoom,
}) {
  if (!regionToCityZoom.isFinite) {
    throw ArgumentError.value(
      regionToCityZoom,
      'regionToCityZoom',
      'must be finite',
    );
  }
  if (!stationMinZoom.isFinite) {
    throw ArgumentError.value(
      stationMinZoom,
      'stationMinZoom',
      'must be finite',
    );
  }
}

void _validateAreaStyles({
  required List<EarthquakeAreaStyle> styles,
  required String parameterName,
}) {
  final codes = <String>{};
  for (final style in styles) {
    if (style.code.trim().isEmpty) {
      throw ArgumentError.value(style.code, '$parameterName.code');
    }
    if (!style.opacity.isFinite || style.opacity < 0 || style.opacity > 1) {
      throw ArgumentError.value(style.opacity, '$parameterName.opacity');
    }
    if (!codes.add(style.code)) {
      throw ArgumentError.value(
        style.code,
        parameterName,
        'contains duplicates',
      );
    }
  }
}

void _validateStations({required List<EarthquakeObservationPoint> stations}) {
  final ids = <String>{};
  for (final station in stations) {
    if (station.id.trim().isEmpty) {
      throw ArgumentError.value(station.id, 'stations.id', 'must not be blank');
    }
    if (!station.longitude.isFinite ||
        station.longitude < -180 ||
        station.longitude > 180) {
      throw ArgumentError.value(station.longitude, 'stations.longitude');
    }
    if (!station.latitude.isFinite ||
        station.latitude < -90 ||
        station.latitude > 90) {
      throw ArgumentError.value(station.latitude, 'stations.latitude');
    }
    if (!station.radiusLogicalPixels.isFinite ||
        station.radiusLogicalPixels <= 0) {
      throw ArgumentError.value(
        station.radiusLogicalPixels,
        'stations.radiusLogicalPixels',
      );
    }
    if (!ids.add(station.id)) {
      throw ArgumentError.value(station.id, 'stations', 'contains duplicates');
    }
  }
}

void _validateSprites({
  required MapSpriteAtlas? spriteAtlas,
  required List<MapPointSpriteFeature> sprites,
  required int maxSpritePolicyBatches,
}) {
  if (maxSpritePolicyBatches <= 0) {
    throw ArgumentError.value(
      maxSpritePolicyBatches,
      'maxSpritePolicyBatches',
      'must be positive',
    );
  }
  if (spriteAtlas == null && sprites.isNotEmpty) {
    throw ArgumentError.value(sprites, 'sprites', 'requires spriteAtlas');
  }
  final regionIds = spriteAtlas?.regions.map((region) => region.id).toSet();
  final featureIds = <String>{};
  final policyPairs = <(MapZoomLinearRange, MapZoomStep)>{};
  for (final sprite in sprites) {
    if (regionIds?.contains(sprite.spriteRegionId) != true) {
      throw ArgumentError.value(
        sprite.spriteRegionId,
        'sprites.spriteRegionId',
        'does not exist in spriteAtlas',
      );
    }
    if (!featureIds.add(sprite.id)) {
      throw ArgumentError.value(sprite.id, 'sprites', 'contains duplicates');
    }
    policyPairs.add((sprite.sizeScale, sprite.opacity));
  }
  if (policyPairs.length > maxSpritePolicyBatches) {
    throw ArgumentError.value(
      policyPairs.length,
      'sprites',
      'exceeds maxSpritePolicyBatches',
    );
  }
}
