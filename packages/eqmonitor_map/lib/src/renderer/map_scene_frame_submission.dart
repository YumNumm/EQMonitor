import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';

extension type const MapSceneLogicalSourceKey._(String value) {}

extension type const MapSceneComponentKey._(String value) {}

extension type const MapSceneBatchKey._(String value) {}

MapSceneLogicalSourceKey createMapSceneLogicalSourceKey({
  required String value,
}) => MapSceneLogicalSourceKey._(
  normalizeMapSceneKey(value: value, parameterName: 'value'),
);

MapSceneComponentKey createMapSceneComponentKey({required String value}) =>
    MapSceneComponentKey._(
      normalizeMapSceneKey(value: value, parameterName: 'value'),
    );

MapSceneBatchKey createMapSceneBatchKey({required String value}) =>
    MapSceneBatchKey._(
      normalizeMapSceneKey(value: value, parameterName: 'value'),
    );

String normalizeMapSceneKey({
  required String value,
  required String parameterName,
}) {
  final normalized = value.trim();
  if (normalized.isEmpty) {
    throw ArgumentError.value(value, parameterName, 'must not be blank');
  }
  return normalized;
}

final MapSceneLogicalSourceKey mapSceneBaseSourceKey =
    createMapSceneLogicalSourceKey(
      value: 'base-map',
    );
final MapSceneLogicalSourceKey mapSceneEarthquakeHistorySourceKey =
    createMapSceneLogicalSourceKey(
      value: 'earthquake-history',
    );
final MapSceneComponentKey mapSceneBaseComponentKey =
    createMapSceneComponentKey(value: 'base');
final MapSceneComponentKey mapSceneRegionFillComponentKey =
    createMapSceneComponentKey(
      value: 'region-fill',
    );
final MapSceneComponentKey mapSceneCityFillComponentKey =
    createMapSceneComponentKey(
      value: 'city-fill',
    );
final MapSceneComponentKey mapSceneObservationPointComponentKey =
    createMapSceneComponentKey(
      value: 'observation-point',
    );
final MapSceneComponentKey mapSceneHypocenterSpriteComponentKey =
    createMapSceneComponentKey(
      value: 'hypocenter-sprite',
    );
final MapSceneBatchKey mapSceneObservationBatchKey = createMapSceneBatchKey(
  value: 'observation-point',
);

enum MapSceneMeshLayerKind { baseMap, earthquakeAreaFill }

final class MapSceneMeshPipelineMismatch implements Exception {
  const MapSceneMeshPipelineMismatch({
    required this.kind,
    required this.pipeline,
  });

  final MapSceneMeshLayerKind kind;
  final MapRenderPipelineKey pipeline;
}

enum MapSceneInstanceLayerKind { observationPoint, pointSprite }

abstract interface class MapSceneInstanceBatch {
  MapFrameSnapshot get frame;
  MapSceneBatchKey get batchKey;
  int get phasePolicyVersion;
  int get phase;
}

sealed class MapSceneLayerSubmission {
  const MapSceneLayerSubmission();

  MapFrameSnapshot get frame;
  MapSceneLogicalSourceKey get logicalSourceKey;
  MapSceneComponentKey get componentKey;
  MapSceneBatchKey get batchKey;
  MapOverlayVersionStamp? get overlayVersion;
  int get phasePolicyVersion;
  int get phase;
  int get orderWithinPhase;
}

final class MapSceneMeshLayerSubmission extends MapSceneLayerSubmission {
  factory MapSceneMeshLayerSubmission({
    required MapFrameSnapshot frame,
    required MapSceneLogicalSourceKey logicalSourceKey,
    required MapSceneComponentKey componentKey,
    required MapOverlayVersionStamp? overlayVersion,
    required int orderWithinPhase,
    required MapRenderBatch batch,
    required MapSceneMeshLayerKind kind,
  }) {
    validateMapSceneLayerOrder(orderWithinPhase);
    return MapSceneMeshLayerSubmission._(
      frame: frame,
      logicalSourceKey: logicalSourceKey,
      componentKey: componentKey,
      overlayVersion: overlayVersion,
      orderWithinPhase: orderWithinPhase,
      batch: batch,
      kind: kind,
      batchKey: mapSceneBatchKeyFor(batch: batch),
    );
  }

  const MapSceneMeshLayerSubmission._({
    required this.frame,
    required this.logicalSourceKey,
    required this.componentKey,
    required this.overlayVersion,
    required this.orderWithinPhase,
    required this.batch,
    required this.kind,
    required this.batchKey,
  });

  @override
  final MapFrameSnapshot frame;
  @override
  final MapSceneLogicalSourceKey logicalSourceKey;
  @override
  final MapSceneComponentKey componentKey;
  @override
  final MapOverlayVersionStamp? overlayVersion;
  @override
  final int orderWithinPhase;
  final MapRenderBatch batch;
  final MapSceneMeshLayerKind kind;
  @override
  final MapSceneBatchKey batchKey;

  @override
  int get phasePolicyVersion => batch.compatibility.phasePolicyVersion;

  @override
  int get phase => batch.compatibility.phase;
}

final class MapSceneInstanceLayerSubmission extends MapSceneLayerSubmission {
  factory MapSceneInstanceLayerSubmission({
    required MapSceneLogicalSourceKey logicalSourceKey,
    required MapSceneComponentKey componentKey,
    required MapOverlayVersionStamp? overlayVersion,
    required int orderWithinPhase,
    required MapSceneInstanceLayerKind kind,
    required MapSceneInstanceBatch batch,
  }) {
    validateMapSceneLayerOrder(orderWithinPhase);
    return MapSceneInstanceLayerSubmission._(
      logicalSourceKey: logicalSourceKey,
      componentKey: componentKey,
      overlayVersion: overlayVersion,
      orderWithinPhase: orderWithinPhase,
      kind: kind,
      batch: batch,
    );
  }

  const MapSceneInstanceLayerSubmission._({
    required this.logicalSourceKey,
    required this.componentKey,
    required this.overlayVersion,
    required this.orderWithinPhase,
    required this.kind,
    required this.batch,
  });

  @override
  MapFrameSnapshot get frame => batch.frame;
  @override
  final MapSceneLogicalSourceKey logicalSourceKey;
  @override
  final MapSceneComponentKey componentKey;
  @override
  final MapOverlayVersionStamp? overlayVersion;
  @override
  final int orderWithinPhase;
  final MapSceneInstanceLayerKind kind;
  final MapSceneInstanceBatch batch;

  @override
  MapSceneBatchKey get batchKey => batch.batchKey;

  @override
  int get phasePolicyVersion => batch.phasePolicyVersion;

  @override
  int get phase => batch.phase;
}

final class MapSceneFrameLimits {
  new({required this.maxNodeCount}) {
    if (maxNodeCount <= 0) {
      throw ArgumentError.value(
        maxNodeCount,
        'maxNodeCount',
        'must be positive',
      );
    }
  }

  final int maxNodeCount;
}

final class MapSceneFrameSubmission {
  factory MapSceneFrameSubmission({
    required MapFrameSnapshot frame,
    required List<MapSceneLayerSubmission> layers,
    required MapSceneFrameLimits limits,
  }) {
    final canonical = List<MapSceneLayerSubmission>.of(layers)
      ..sort(compareMapSceneLayerSubmissions);
    validateMapSceneFrameLayers(
      frame: frame,
      layers: canonical,
      limits: limits,
    );
    return MapSceneFrameSubmission._(
      frame: frame,
      layers: List.unmodifiable(canonical),
    );
  }

  const MapSceneFrameSubmission._({
    required this.frame,
    required this.layers,
  });

  final MapFrameSnapshot frame;
  final List<MapSceneLayerSubmission> layers;
}

MapSceneBatchKey mapSceneBatchKeyFor({required MapRenderBatch batch}) {
  final key = batch.compatibility.batchKey;
  final fields = [
    key.version.toString(),
    key.nodeKey.value,
    key.scopeKey,
    key.materialKey,
    key.phasePolicyVersion.toString(),
    key.phase.toString(),
  ];
  return createMapSceneBatchKey(
    value: fields.map((field) => '${field.length}:$field').join('|'),
  );
}

int compareMapSceneLayerSubmissions(
  MapSceneLayerSubmission left,
  MapSceneLayerSubmission right,
) => left.phase != right.phase
    ? left.phase.compareTo(right.phase)
    : left.orderWithinPhase != right.orderWithinPhase
    ? left.orderWithinPhase.compareTo(right.orderWithinPhase)
    : left.logicalSourceKey.value != right.logicalSourceKey.value
    ? left.logicalSourceKey.value.compareTo(right.logicalSourceKey.value)
    : left.componentKey.value != right.componentKey.value
    ? left.componentKey.value.compareTo(right.componentKey.value)
    : left.batchKey.value.compareTo(right.batchKey.value);

void validateMapSceneLayerOrder(int orderWithinPhase) {
  if (orderWithinPhase < 0) {
    throw ArgumentError.value(
      orderWithinPhase,
      'orderWithinPhase',
      'must not be negative',
    );
  }
}

void validateMapSceneFrameLayers({
  required MapFrameSnapshot frame,
  required List<MapSceneLayerSubmission> layers,
  required MapSceneFrameLimits limits,
}) {
  final identities = <String>{};
  final overlayVersions = <MapSceneLogicalSourceKey, MapOverlayVersionStamp?>{};
  var hasRegion = false;
  var hasCity = false;
  var nodeCount = 0;

  for (final layer in layers) {
    if (!identical(layer.frame, frame)) {
      throw ArgumentError.value(
        layer,
        'layers',
        'must share the captured frame',
      );
    }
    if (layer.phasePolicyVersion != mapSceneRenderPhasePolicy.version ||
        !mapSceneRenderPhasePolicy.containsRank(layer.phase)) {
      throw ArgumentError.value(
        layer,
        'layers',
        'has an unknown phase policy',
      );
    }
    validateMapSceneLayerCompatibility(layer);

    final identity =
        '${layer.logicalSourceKey.value.length}:'
        '${layer.logicalSourceKey.value}|${layer.componentKey.value.length}:'
        '${layer.componentKey.value}|${layer.batchKey.value.length}:'
        '${layer.batchKey.value}';
    if (!identities.add(identity)) {
      throw ArgumentError.value(
        layer,
        'layers',
        'has a duplicate identity tuple',
      );
    }

    if (overlayVersions.containsKey(layer.logicalSourceKey) &&
        overlayVersions[layer.logicalSourceKey] != layer.overlayVersion) {
      throw ArgumentError.value(
        layer,
        'layers',
        'mixes overlay version stamps',
      );
    }
    overlayVersions[layer.logicalSourceKey] = layer.overlayVersion;

    if (layer.logicalSourceKey == mapSceneEarthquakeHistorySourceKey) {
      hasRegion =
          hasRegion || layer.componentKey == mapSceneRegionFillComponentKey;
      hasCity = hasCity || layer.componentKey == mapSceneCityFillComponentKey;
    }
    nodeCount += switch (layer) {
      MapSceneMeshLayerSubmission(:final batch) => batch.packets.length,
      MapSceneInstanceLayerSubmission() => 1,
    };
  }

  if (hasRegion && hasCity) {
    throw ArgumentError.value(
      layers,
      'layers',
      'must not mix region and city Fill',
    );
  }
  if (nodeCount > limits.maxNodeCount) {
    throw ArgumentError.value(nodeCount, 'layers', 'exceeds maxNodeCount');
  }
}

void validateMapSceneLayerCompatibility(MapSceneLayerSubmission layer) {
  switch (layer) {
    case MapSceneMeshLayerSubmission(:final kind, :final batch):
      final pipeline = batch.compatibility.pipeline;
      final expectedPhase = switch (kind) {
        MapSceneMeshLayerKind.baseMap when pipeline == baseMapFillPipelineKey =>
          mapSceneRenderPhasePolicy.rankOf(mapSceneBaseLandFillPhaseId),
        MapSceneMeshLayerKind.baseMap when pipeline == baseMapLinePipelineKey =>
          mapSceneRenderPhasePolicy.rankOf(
            mapSceneBaseAdministrativeLinePhaseId,
          ),
        MapSceneMeshLayerKind.earthquakeAreaFill
            when pipeline == earthquakeAreaFillPipelineKey =>
          mapSceneRenderPhasePolicy.rankOf(mapSceneOverlayHazardFillPhaseId),
        _ => throw MapSceneMeshPipelineMismatch(
          kind: kind,
          pipeline: pipeline,
        ),
      };
      if (layer.phase != expectedPhase) {
        throw ArgumentError.value(
          layer.phase,
          'layer',
          'has a phase mismatch',
        );
      }
      switch (kind) {
        case MapSceneMeshLayerKind.baseMap:
          if (layer.logicalSourceKey != mapSceneBaseSourceKey ||
              layer.componentKey != mapSceneBaseComponentKey ||
              layer.overlayVersion != null) {
            throw ArgumentError.value(
              layer,
              'layer',
              'has invalid base identity',
            );
          }
        case MapSceneMeshLayerKind.earthquakeAreaFill:
          if (layer.logicalSourceKey != mapSceneEarthquakeHistorySourceKey ||
              (layer.componentKey != mapSceneRegionFillComponentKey &&
                  layer.componentKey != mapSceneCityFillComponentKey) ||
              layer.overlayVersion == null) {
            throw ArgumentError.value(
              layer,
              'layer',
              'has invalid earthquake Fill identity',
            );
          }
      }
    case MapSceneInstanceLayerSubmission(:final kind):
      final expected = switch (kind) {
        MapSceneInstanceLayerKind.observationPoint => (
          phase: mapSceneRenderPhasePolicy.rankOf(mapSceneLivePointPhaseId),
          component: mapSceneObservationPointComponentKey,
        ),
        MapSceneInstanceLayerKind.pointSprite => (
          phase: mapSceneRenderPhasePolicy.rankOf(mapSceneSpritePhaseId),
          component: mapSceneHypocenterSpriteComponentKey,
        ),
      };
      if (layer.phase != expected.phase ||
          layer.logicalSourceKey != mapSceneEarthquakeHistorySourceKey ||
          layer.componentKey != expected.component ||
          layer.overlayVersion == null) {
        throw ArgumentError.value(
          layer,
          'layer',
          'has an instance mismatch',
        );
      }
  }
}
