import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:flutter/foundation.dart';

/// 地震overlayで描画する区域layer。
enum EarthquakeAreaLayerMode { region, city }

/// exact tileの区域geometryを取得した結果。
@immutable
sealed class EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileResult();
}

/// 要求されたcanonical tileがcacheにない結果。
final class EarthquakeOverlayExactTileMiss
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileMiss();
}

/// 要求されたcanonical tileの区域geometry。
final class EarthquakeOverlayExactTileHit
    extends EarthquakeOverlayExactTileResult {
  const EarthquakeOverlayExactTileHit({
    required this.tileId,
    required this.areaGeometry,
  });

  /// world wrapを含む、描画位置としての要求tile。
  final UnwrappedTileId tileId;

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
}) {
  final geometry = cache.get(
    sourceInstanceId: sourceInstanceId,
    tileId: requestedTile.canonical,
  );
  if (geometry == null) {
    return const EarthquakeOverlayExactTileMiss();
  }
  final areaGeometry = switch (mode) {
    EarthquakeAreaLayerMode.region => geometry.earthquakeAreas.forecastRegions,
    EarthquakeAreaLayerMode.city => geometry.earthquakeAreas.cities,
  };
  return EarthquakeOverlayExactTileHit(
    tileId: requestedTile,
    areaGeometry: areaGeometry,
  );
}
