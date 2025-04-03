import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_map_tiles_pmtiles/vector_map_tiles_pmtiles.dart';

part 'pmtiles_provider.g.dart';

// PMTilesのURL
const pmtilesUrl = 'https://v2.map.eqmonitor.app/all.pmtiles';

@Riverpod(keepAlive: true)
Future<PmTilesVectorTileProvider> pmtilesVectorTileProvider(Ref ref) {
  return PmTilesVectorTileProvider.fromSource(pmtilesUrl);
}

@Riverpod(keepAlive: true)
Future<Style> readStyle(Ref ref) {
  return StyleReader(
    uri: "https://v2.map.eqmonitor.app/style-light.json",
  ).read();
}
