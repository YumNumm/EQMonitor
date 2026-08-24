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
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';

/// BaseMapViewが1 frameでsubmitする内容と次frameへ持ち越すoverlay state。
final class BaseMapOverlayFrameResult {
  const new({
    required this.overlay,
    required this.submission,
    required this.coverage,
    required this.observationBatchForReuse,
    required this.shouldRetireGpuResources,
  });

  final EarthquakeMapOverlaySnapshot? overlay;
  final MapSceneFrameSubmission? submission;
  final EarthquakeOverlayCoverage coverage;
  final ObservationPointBatch? observationBatchForReuse;
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
      observationBatchForReuse: _reusableObservation(
        previous: previousObservationBatch,
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
      observationBatchForReuse: null,
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
      ),
  ];
  final coverage = earthquakeOverlayCoverageFor(
    exactTileResults: exactTileResults,
  );
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
      ],
      limits: sceneFrameLimits,
    ),
    coverage: coverage,
    observationBatchForReuse:
        observation ??
        _reusableObservation(
          previous: previousObservationBatch,
          overlay: overlay,
        ),
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
EarthquakeOverlayCoverage earthquakeOverlayCoverageFor({
  required List<EarthquakeOverlayExactTileResult> exactTileResults,
}) {
  var readyTileCount = 0;
  var missingOrInvalidCodeCount = 0;
  for (final result in exactTileResults) {
    if (result is! EarthquakeOverlayExactTileHit ||
        result.areaGeometry.extent == null) {
      continue;
    }
    readyTileCount++;
    missingOrInvalidCodeCount += result.areaGeometry.missingOrInvalidCodeCount;
  }
  return EarthquakeOverlayCoverage.fromCounts(
    requestedTileCount: exactTileResults.length,
    readyTileCount: readyTileCount,
    missingOrInvalidCodeCount: missingOrInvalidCodeCount,
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
