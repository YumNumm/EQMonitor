import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';

/// 論理的に同じ震度区域meshのstable packed instanceを引く関数。
typedef EarthquakeAreaPackedMeshResolver = MapPackedMesh Function({
  required String sourceInstanceId,
  required CanonicalTileId tileId,
  required int snapshotRevision,
  required EarthquakeAreaLayerMode layerMode,
  required int featureIndex,
  required int meshIndex,
  required FillMesh mesh,
});

/// 震度区域Fillのpacked meshをtile/layer単位で保持するLRU cache。
///
/// GPU ledgerは[MapPackedMesh]のinstance identityをresource keyにするため、
/// 同じsource、canonical tile、snapshot revision、region/city layer、
/// feature/mesh ordinalには同じinstanceを返す。sourceのgeometryは
/// `sourceInstanceId`の世代内で不変、feature/mesh順はdecoder出力で安定、
/// snapshot revisionはoverlay入力の世代を表すという上流contractに基づく。
final class EarthquakeAreaPackedMeshCache {
  EarthquakeAreaPackedMeshCache({required this.maxEntries}) {
    if (maxEntries <= 0) {
      throw ArgumentError.value(maxEntries, 'maxEntries', 'must be positive');
    }
  }

  /// cacheへ保持できるtile/layer entryの最大件数。
  final int maxEntries;

  final Map<
    (String, CanonicalTileId, int, EarthquakeAreaLayerMode),
    Map<(int, int), MapPackedMesh>
  >
  _entries = {};

  int get length => _entries.length;

  MapPackedMesh resolve({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required int snapshotRevision,
    required EarthquakeAreaLayerMode layerMode,
    required int featureIndex,
    required int meshIndex,
    required FillMesh mesh,
  }) {
    final tileKey = (sourceInstanceId, tileId, snapshotRevision, layerMode);
    final meshes = _entries.remove(tileKey) ?? <(int, int), MapPackedMesh>{};
    _entries[tileKey] = meshes;
    final packed = meshes.putIfAbsent(
      (featureIndex, meshIndex),
      () => packBaseMapFillMesh(mesh),
    );
    while (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
    return packed;
  }

  void clear() => _entries.clear();
}
