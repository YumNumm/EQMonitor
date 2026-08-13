import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';

const sourceId = 'source-a';

void putGeometry({
  required BaseMapTileCache cache,
  required CanonicalTileId tileId,
}) {
  cache.put(
    sourceInstanceId: sourceId,
    tileId: tileId,
    geometry: const BaseMapTileGeometry(layers: []),
    token: cache.beginDecode(),
  );
}

OverscaledTileId requested({required CanonicalTileId tileId, int wrap = 0}) =>
    OverscaledTileId(overscaledZ: tileId.z, wrap: wrap, canonical: tileId);
