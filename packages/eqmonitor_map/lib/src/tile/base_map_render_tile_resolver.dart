import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter/foundation.dart';

@immutable
final class BaseMapRenderTile {
  const BaseMapRenderTile({required this.tileId, required this.geometry});

  final UnwrappedTileId tileId;
  final BaseMapTileGeometry geometry;
}

final class BaseMapRenderTileResolver {
  const BaseMapRenderTileResolver();

  List<BaseMapRenderTile> resolve({
    required List<OverscaledTileId> requestedCover,
    required String sourceInstanceId,
    required BaseMapTileCache cache,
    required int maxParentSteps,
  }) {
    if (maxParentSteps < 0) {
      throw ArgumentError.value(maxParentSteps, 'maxParentSteps');
    }
    final rendered = <UnwrappedTileId, BaseMapTileGeometry>{};
    for (final requestedTile in requestedCover) {
      final fallback = cache.lookupWithFallback(
        sourceInstanceId: sourceInstanceId,
        tileId: requestedTile.canonical,
        maxParentSteps: maxParentSteps,
      );
      switch (fallback) {
        case BaseMapTileFallbackMiss():
          continue;
        case BaseMapTileFallbackExact(:final geometry):
          rendered.putIfAbsent(requestedTile.toUnwrapped(), () => geometry);
        case BaseMapTileFallbackParent(:final tileId, :final geometry):
          final unwrapped = UnwrappedTileId(
            wrap: requestedTile.wrap,
            canonical: tileId,
          );
          rendered.putIfAbsent(unwrapped, () => geometry);
        case BaseMapTileFallbackChildren(:final children):
          final childIds = requestedTile.canonical.children();
          for (var index = 0; index < childIds.length; index++) {
            final unwrapped = UnwrappedTileId(
              wrap: requestedTile.wrap,
              canonical: childIds[index],
            );
            rendered.putIfAbsent(unwrapped, () => children[index]);
          }
      }
    }
    return List.unmodifiable([
      for (final entry in rendered.entries)
        BaseMapRenderTile(tileId: entry.key, geometry: entry.value),
    ]);
  }
}
