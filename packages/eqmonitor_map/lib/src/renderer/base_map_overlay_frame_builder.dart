import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_controller.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_packed_mesh_cache.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_resources.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_render_lifecycle_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch_builder.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';

typedef EarthquakeOverlayExactTileMissReasonFor =
    EarthquakeOverlayExactTileMissReason Function(CanonicalTileId tileId);

/// BaseMapViewが1 frameでsubmitする内容と次frameへ持ち越すoverlay state。
final class BaseMapOverlayFrameResult {
  const new({
    required this.overlay,
    required this.submission,
    required this.coverage,
    required this.diagnostic,
    required this.observationBatchForReuse,
    required this.spriteBatchesForReuse,
    required this.shouldRetireGpuResources,
  });

  final EarthquakeMapOverlaySnapshot? overlay;
  final MapSceneFrameSubmission? submission;
  final EarthquakeOverlayCoverage coverage;
  final EarthquakeOverlayCoverageDiagnostic diagnostic;
  final ObservationPointBatch? observationBatchForReuse;
  final List<MapPointSpriteInstanceBatch> spriteBatchesForReuse;
  final bool shouldRetireGpuResources;
}

/// snapshot選択、exact coverage、Fill/観測点を1つのScene frameへ統合する。
BaseMapOverlayFrameResult buildBaseMapOverlayFrame({
  required MapFrameSnapshot frame,
  required MapRenderSubmission baseMap,
  required EarthquakeMapOverlaySnapshot? currentOverlay,
  required EarthquakeMapOverlaySnapshot? requestedOverlay,
  required ObservationPointBatch? previousObservationBatch,
  required List<OverscaledTileId> requestedCover,
  required String tileSourceInstanceId,
  required BaseMapTileCache tileCache,
  required EarthquakeAreaPackedMeshResolver packedMeshFor,
  required EarthquakeAreaRenderStyleCache styleCache,
  required MapSceneFrameLimits sceneFrameLimits,
  required EarthquakeOverlayExactTileMissReasonFor missingExactTileReasonFor,
  required int requiredCodeUnresolvedCount,
  List<MapPointSpriteInstanceBatch> previousSpriteBatches = const [],
}) {
  if (!identical(baseMap.frame, frame)) {
    throw ArgumentError('baseMap must use the captured frame');
  }
  final overlay = selectEarthquakeOverlaySnapshot(
    current: currentOverlay,
    requested: requestedOverlay,
  );
  if (suspendsMapRendering(frame.lifecycle)) {
    return BaseMapOverlayFrameResult(
      overlay: overlay,
      submission: null,
      coverage: const EarthquakeOverlayCoverage.hidden(),
      diagnostic: const EarthquakeOverlayCoverageDiagnostic.empty(),
      observationBatchForReuse: _reusableObservation(
        previous: previousObservationBatch,
        overlay: overlay,
      ),
      spriteBatchesForReuse: _reusableSprites(
        previous: previousSpriteBatches,
        overlay: overlay,
      ),
      shouldRetireGpuResources: true,
    );
  }
  if (overlay == null) {
    return BaseMapOverlayFrameResult(
      overlay: null,
      submission: buildBaseMapOnlyFrameSubmission(
        frame: frame,
        baseMap: baseMap,
        sceneFrameLimits: sceneFrameLimits,
      ),
      coverage: const EarthquakeOverlayCoverage.hidden(),
      diagnostic: const EarthquakeOverlayCoverageDiagnostic.empty(),
      observationBatchForReuse: null,
      spriteBatchesForReuse: const [],
      shouldRetireGpuResources: false,
    );
  }

  final layerMode = frame.camera.zoom < overlay.regionToCityZoom
      ? EarthquakeAreaLayerMode.region
      : EarthquakeAreaLayerMode.city;
  final exactTileResults = [
    for (final tile in requestedCover)
      resolveEarthquakeOverlayExactTile(
        requestedTile: tile.toUnwrapped(),
        sourceInstanceId: tileSourceInstanceId,
        cache: tileCache,
        mode: layerMode,
        missReason: missingExactTileReasonFor(tile.canonical),
      ),
  ];
  final diagnostic = earthquakeOverlayCoverageDiagnosticFor(
    exactTileResults: exactTileResults,
    requiredCodeUnresolvedCount: requiredCodeUnresolvedCount,
    stationCount: overlay.stations.length,
    spriteCount: overlay.sprites.length,
  );
  final coverage = EarthquakeOverlayCoverage.fromDiagnostic(diagnostic);
  final styles = styleCache.resolve(
    snapshot: overlay,
    layerMode: layerMode,
    parametersFor: earthquakeAreaMaterialParametersFor,
  );
  final earthquakeFill = buildEarthquakeAreaRenderSubmission(
    frame: frame,
    snapshot: overlay,
    exactTileResults: exactTileResults,
    packedMeshFor: packedMeshFor,
    styleResources: styles,
  );
  final observation = buildObservationPointBatch(
    frame: frame,
    snapshot: overlay,
    previous: previousObservationBatch,
  );
  final sprites = buildMapPointSpriteBatches(
    frame: frame,
    versionStamp: overlay.versionStamp,
    atlas: overlay.spriteAtlas,
    features: overlay.sprites,
    maxPolicyBatches: overlay.maxSpritePolicyBatches,
    previous: previousSpriteBatches,
  );
  return BaseMapOverlayFrameResult(
    overlay: overlay,
    submission: MapSceneFrameSubmission(
      frame: frame,
      layers: [
        ...buildBaseMapSceneLayers(frame: frame, baseMap: baseMap),
        for (final batch in earthquakeFill.batches)
          MapSceneMeshLayerSubmission(
            frame: frame,
            logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
            componentKey: switch (layerMode) {
              EarthquakeAreaLayerMode.region => mapSceneRegionFillComponentKey,
              EarthquakeAreaLayerMode.city => mapSceneCityFillComponentKey,
            },
            overlayVersion: overlay.versionStamp,
            orderWithinPhase:
                batch.packets.first.sortKey.declarationOrderWithinPhase,
            batch: batch,
            kind: MapSceneMeshLayerKind.earthquakeAreaFill,
          ),
        if (observation != null)
          MapSceneInstanceLayerSubmission(
            logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
            componentKey: mapSceneObservationPointComponentKey,
            overlayVersion: overlay.versionStamp,
            orderWithinPhase: 0,
            kind: MapSceneInstanceLayerKind.observationPoint,
            batch: observation,
          ),
        for (final (index, batch) in sprites.indexed)
          MapSceneInstanceLayerSubmission(
            logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
            componentKey: mapSceneHypocenterSpriteComponentKey,
            overlayVersion: overlay.versionStamp,
            orderWithinPhase: index,
            kind: MapSceneInstanceLayerKind.pointSprite,
            batch: batch,
          ),
      ],
      limits: sceneFrameLimits,
    ),
    coverage: coverage,
    diagnostic: diagnostic,
    observationBatchForReuse:
        observation ??
        _reusableObservation(
          previous: previousObservationBatch,
          overlay: overlay,
        ),
    spriteBatchesForReuse: sprites,
    shouldRetireGpuResources: false,
  );
}

MapSceneFrameSubmission buildBaseMapOnlyFrameSubmission({
  required MapFrameSnapshot frame,
  required MapRenderSubmission baseMap,
  required MapSceneFrameLimits sceneFrameLimits,
}) {
  if (!identical(baseMap.frame, frame)) {
    throw ArgumentError('baseMap must use the captured frame');
  }
  return MapSceneFrameSubmission(
    frame: frame,
    layers: buildBaseMapSceneLayers(frame: frame, baseMap: baseMap),
    limits: sceneFrameLimits,
  );
}

List<MapSceneMeshLayerSubmission> buildBaseMapSceneLayers({
  required MapFrameSnapshot frame,
  required MapRenderSubmission baseMap,
}) => List.unmodifiable([
  for (final batch in baseMap.batches)
    MapSceneMeshLayerSubmission(
      frame: frame,
      logicalSourceKey: mapSceneBaseSourceKey,
      componentKey: mapSceneBaseComponentKey,
      overlayVersion: null,
      orderWithinPhase: batch.packets.first.sortKey.declarationOrderWithinPhase,
      batch: batch,
      kind: MapSceneMeshLayerKind.baseMap,
    ),
]);

EarthquakeMapOverlaySnapshot? selectEarthquakeOverlaySnapshot({
  required EarthquakeMapOverlaySnapshot? current,
  required EarthquakeMapOverlaySnapshot? requested,
}) {
  if (requested == null) {
    return null;
  }
  return switch (commitEarthquakeOverlaySnapshot(
    current: current,
    next: requested,
  )) {
    EarthquakeOverlayCommitAccepted(:final next) => next,
    EarthquakeOverlayCommitRejected(:final current) => current,
  };
}

/// exact tile結果からsource layer/code欠損を含むcoverageを数える。
EarthquakeOverlayCoverageDiagnostic earthquakeOverlayCoverageDiagnosticFor({
  required List<EarthquakeOverlayExactTileResult> exactTileResults,
  required int requiredCodeUnresolvedCount,
  required int stationCount,
  required int spriteCount,
}) {
  final visited = <CanonicalTileId>{};
  var pendingTileCount = 0;
  var authoritativeEmptyTileCount = 0;
  var sourceLayerAbsentTileCount = 0;
  var missingOrInvalidPropertyFeatureCount = 0;
  var decodeOrSchemaFailureTileCount = 0;
  for (final result in exactTileResults) {
    if (!visited.add(result.canonicalTileId)) {
      continue;
    }
    switch (result) {
      case EarthquakeOverlayExactTilePending():
        pendingTileCount++;
      case EarthquakeOverlayExactTileAuthoritativeEmpty():
        authoritativeEmptyTileCount++;
      case EarthquakeOverlayExactTileDecodeFailure():
        decodeOrSchemaFailureTileCount++;
      case EarthquakeOverlayExactTileHit(:final areaGeometry):
        if (areaGeometry.extent == null) {
          sourceLayerAbsentTileCount++;
          continue;
        }
        missingOrInvalidPropertyFeatureCount +=
            areaGeometry.missingOrInvalidCodeCount;
        if (areaGeometry.features.isEmpty &&
            areaGeometry.missingOrInvalidCodeCount == 0) {
          authoritativeEmptyTileCount++;
        }
    }
  }
  return EarthquakeOverlayCoverageDiagnostic(
    visibleCanonicalTileCount: visited.length,
    pendingTileCount: pendingTileCount,
    authoritativeEmptyTileCount: authoritativeEmptyTileCount,
    sourceLayerAbsentTileCount: sourceLayerAbsentTileCount,
    missingOrInvalidPropertyFeatureCount: missingOrInvalidPropertyFeatureCount,
    decodeOrSchemaFailureTileCount: decodeOrSchemaFailureTileCount,
    requiredCodeUnresolvedCount: requiredCodeUnresolvedCount,
    stationCount: stationCount,
    spriteCount: spriteCount,
  );
}

ObservationPointBatch? _reusableObservation({
  required ObservationPointBatch? previous,
  required EarthquakeMapOverlaySnapshot? overlay,
}) {
  if (previous == null || overlay == null) {
    return null;
  }
  return previous.versionStamp == overlay.versionStamp &&
          previous.hasStationSnapshotIdentity(overlay.stations)
      ? previous
      : null;
}

List<MapPointSpriteInstanceBatch> _reusableSprites({
  required List<MapPointSpriteInstanceBatch> previous,
  required EarthquakeMapOverlaySnapshot? overlay,
}) => overlay == null
    ? const []
    : List.unmodifiable(
        previous.where((batch) => batch.versionStamp == overlay.versionStamp),
      );
