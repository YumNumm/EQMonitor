import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:flutter/foundation.dart';

/// 地震overlayで描画する区域layer。
enum EarthquakeAreaLayerMode { region, city }

/// exact cache missについて、呼び出し側が確認済みの理由。
enum EarthquakeOverlayExactTileMissReason {
  /// scheduler待ち、実行中、またはまだschedulerへ渡していないcache miss。
  pending,

  /// PMTiles directoryにcanonical tile entryが存在しない。
  authoritativeEmpty,

  /// entryは存在したがdecodeまたはschema検証に失敗した。
  decodeFailure,
}

/// exact tileの区域geometryを取得した結果。
@immutable
sealed class EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileResult({
    required this.tileId,
    required this.canonicalTileId,
    required this.sourceInstanceId,
  });

  final UnwrappedTileId tileId;
  final CanonicalTileId canonicalTileId;
  final String sourceInstanceId;
}

/// exact tileがschedulerまたはdecode待ちの結果。
final class EarthquakeOverlayExactTilePending
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTilePending({
    required super.tileId,
    required super.canonicalTileId,
    required super.sourceInstanceId,
  });
}

/// PMTiles directoryがcanonical tileの不存在を証明した結果。
final class EarthquakeOverlayExactTileAuthoritativeEmpty
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileAuthoritativeEmpty({
    required super.tileId,
    required super.canonicalTileId,
    required super.sourceInstanceId,
  });
}

/// canonical tileのdecodeまたはschema検証に失敗した結果。
final class EarthquakeOverlayExactTileDecodeFailure
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileDecodeFailure({
    required super.tileId,
    required super.canonicalTileId,
    required super.sourceInstanceId,
  });
}

/// 要求されたcanonical tileの区域geometry。
final class EarthquakeOverlayExactTileHit
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileHit({
    required super.tileId,
    required super.canonicalTileId,
    required super.sourceInstanceId,
    required this.areaGeometry,
  });

  /// 表示modeで選んだ区域layer。source layer欠損時はextentが`null`になる。
  final EarthquakeAreaTileLayerGeometry areaGeometry;
}

/// [requestedTile]と同一canonical tileの区域geometryだけをcacheから取得する。
///
/// 背景地図が使う親/子tile fallbackはoverlayには適用しない。city modeでcity
/// layerが欠損しても、region layerへ差し替えない。
EarthquakeOverlayExactTileResult resolveEarthquakeOverlayExactTile({
  required UnwrappedTileId requestedTile,
  required String sourceInstanceId,
  required BaseMapTileCache cache,
  required EarthquakeAreaLayerMode mode,
  required EarthquakeOverlayExactTileMissReason missReason,
}) {
  final geometry = cache.get(
    sourceInstanceId: sourceInstanceId,
    tileId: requestedTile.canonical,
  );
  if (geometry == null) {
    return switch (missReason) {
      EarthquakeOverlayExactTileMissReason.pending =>
        EarthquakeOverlayExactTilePending(
          tileId: requestedTile,
          canonicalTileId: requestedTile.canonical,
          sourceInstanceId: sourceInstanceId,
        ),
      EarthquakeOverlayExactTileMissReason.authoritativeEmpty =>
        EarthquakeOverlayExactTileAuthoritativeEmpty(
          tileId: requestedTile,
          canonicalTileId: requestedTile.canonical,
          sourceInstanceId: sourceInstanceId,
        ),
      EarthquakeOverlayExactTileMissReason.decodeFailure =>
        EarthquakeOverlayExactTileDecodeFailure(
          tileId: requestedTile,
          canonicalTileId: requestedTile.canonical,
          sourceInstanceId: sourceInstanceId,
        ),
    };
  }
  final areaGeometry = switch (mode) {
    EarthquakeAreaLayerMode.region => geometry.earthquakeAreas.forecastRegions,
    EarthquakeAreaLayerMode.city => geometry.earthquakeAreas.cities,
  };
  return EarthquakeOverlayExactTileHit(
    tileId: requestedTile,
    canonicalTileId: requestedTile.canonical,
    sourceInstanceId: sourceInstanceId,
    areaGeometry: areaGeometry,
  );
}
