import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_tile_resolver.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter/foundation.dart';

@immutable
final class const BaseMapTileTransformInput({
  required final UnwrappedTileId tileId,
  required final double zoom,
  required final int extent,
});

@immutable
final class const BaseMapLayerRenderPlan({
  required final BaseMapTileGeometry tileGeometry,
  required final BaseMapTileLayerGeometry layerGeometry,
  required final BaseMapTileTransformInput transformInput,
});

List<BaseMapLayerRenderPlan> buildBaseMapRenderPlans({
  required List<OverscaledTileId> requestedCover,
  required String sourceInstanceId,
  required BaseMapTileCache cache,
  required int maxParentSteps,
  required double zoom,
}) {
  final renderTiles = const BaseMapRenderTileResolver().resolve(
    requestedCover: requestedCover,
    sourceInstanceId: sourceInstanceId,
    cache: cache,
    maxParentSteps: maxParentSteps,
  );
  return const _BaseMapRenderPlanBuilder().build(
    renderTiles: renderTiles,
    zoom: zoom,
  );
}

final class const _BaseMapRenderPlanBuilder() {
  List<BaseMapLayerRenderPlan> build({
    required List<BaseMapRenderTile> renderTiles,
    required double zoom,
  }) {
    final plans = <BaseMapLayerRenderPlan>[];
    for (final spec in baseMapLayerSpecs) {
      if (spec.kind == BaseMapLayerKind.background) {
        continue;
      }
      for (final renderTile in renderTiles) {
        final layer = renderTile.geometry.layers.singleWhere(
          (candidate) => candidate.styleLayerId == spec.styleLayerId,
        );
        final meshes = switch (layer) {
          BaseMapTileFillLayerGeometry(:final meshes) => meshes,
          BaseMapTileLineLayerGeometry(:final meshes) => meshes,
        };
        if (meshes.isEmpty) {
          continue;
        }
        final extent = layer.extent;
        if (extent == null) {
          throw StateError(
            '${layer.styleLayerId} has meshes without an MVT extent.',
          );
        }
        plans.add(
          BaseMapLayerRenderPlan(
            tileGeometry: renderTile.geometry,
            layerGeometry: layer,
            transformInput: BaseMapTileTransformInput(
              tileId: renderTile.tileId,
              zoom: zoom,
              extent: extent,
            ),
          ),
        );
      }
    }
    return List.unmodifiable(plans);
  }
}
