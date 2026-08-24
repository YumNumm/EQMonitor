import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';

/// Task 7が実装する観測点batchの最小typed contract。
abstract interface class MapSceneObservationBatch {
  MapFrameSnapshot get frame;
  int get phasePolicyVersion;
  int get phase;
  int get translucentSortPriority;
}

/// 1 frameで同じSceneへ送るbase、震度Fill、観測点batch。
final class MapSceneFrameSubmission {
  factory MapSceneFrameSubmission({
    required MapRenderSubmission baseMap,
    required MapRenderSubmission earthquakeFill,
    required MapSceneObservationBatch? observationBatch,
  }) {
    final submission = MapSceneFrameSubmission._(
      baseMap: baseMap,
      earthquakeFill: earthquakeFill,
      observationBatch: observationBatch,
    );
    validateMapSceneFrameSubmission(submission: submission);
    return submission;
  }

  const MapSceneFrameSubmission._({
    required this.baseMap,
    required this.earthquakeFill,
    required this.observationBatch,
  });

  final MapRenderSubmission baseMap;
  final MapRenderSubmission earthquakeFill;
  final MapSceneObservationBatch? observationBatch;

  MapFrameSnapshot get frame => baseMap.frame;
}

/// frame identity、共有phase policy、submission用途をsubmit前に検証する。
void validateMapSceneFrameSubmission({
  required MapSceneFrameSubmission submission,
}) {
  validateMapRenderSubmission(submission: submission.baseMap);
  validateMapRenderSubmission(submission: submission.earthquakeFill);
  if (!identical(submission.baseMap.frame, submission.earthquakeFill.frame)) {
    throw ArgumentError('baseMap and earthquakeFill must share one frame');
  }

  validateMapSceneBatches(
    batches: submission.baseMap.batches,
    expectedPhases: {
      mapSceneRenderPhasePolicy.rankOf(mapSceneBaseLandFillPhaseId),
      mapSceneRenderPhasePolicy.rankOf(
        mapSceneBaseAdministrativeLinePhaseId,
      ),
    },
    parameterName: 'baseMap',
  );
  validateMapSceneBatches(
    batches: submission.earthquakeFill.batches,
    expectedPhases: {
      mapSceneRenderPhasePolicy.rankOf(mapSceneOverlayHazardFillPhaseId),
    },
    parameterName: 'earthquakeFill',
  );
  validateEarthquakeFillBatches(batches: submission.earthquakeFill.batches);
  validateCombinedBatchOrder(submission: submission);

  final observation = submission.observationBatch;
  if (observation == null) {
    return;
  }
  if (!identical(observation.frame, submission.frame)) {
    throw ArgumentError('observationBatch must share the Scene frame');
  }
  final observationPhase = mapSceneRenderPhasePolicy.rankOf(
    mapSceneLivePointPhaseId,
  );
  if (observation.phasePolicyVersion != mapSceneRenderPhasePolicy.version ||
      observation.phase != observationPhase) {
    throw ArgumentError.value(
      observation.phase,
      'observationBatch',
      'must use the shared observation phase',
    );
  }
  validateMapSceneTranslucentSortPriority(
    phase: observation.phase,
    priority: observation.translucentSortPriority,
  );
}

void validateMapSceneBatches({
  required List<MapRenderBatch> batches,
  required Set<int> expectedPhases,
  required String parameterName,
}) {
  for (final batch in batches) {
    if (batch.compatibility.phasePolicyVersion !=
            mapSceneRenderPhasePolicy.version ||
        !expectedPhases.contains(batch.compatibility.phase)) {
      throw ArgumentError.value(
        batch,
        parameterName,
        'contains an unknown phase or policy version',
      );
    }
  }
}

void validateEarthquakeFillBatches({required List<MapRenderBatch> batches}) {
  final phases = <int>{};
  for (final batch in batches) {
    phases.add(batch.compatibility.phase);
    if (batch.compatibility.batchKey.materialKey !=
            earthquakeAreaFillMaterialKey ||
        batch.compatibility.pipeline != earthquakeAreaFillPipelineKey) {
      throw ArgumentError.value(
        batch,
        'earthquakeFill',
        'contains an unknown material or pipeline',
      );
    }
  }
  if (phases.length > 1) {
    throw ArgumentError.value(
      batches,
      'earthquakeFill',
      'must contain either region or city Fill, never both',
    );
  }
}

void validateCombinedBatchOrder({
  required MapSceneFrameSubmission submission,
}) {
  final batches = [
    ...submission.baseMap.batches,
    ...submission.earthquakeFill.batches,
  ];
  for (var index = 1; index < batches.length; index++) {
    if (compareMapRenderSortKeys(
          batches[index - 1].packets.last.sortKey,
          batches[index].packets.first.sortKey,
        ) >
        0) {
      throw ArgumentError.value(
        batches[index],
        'submission',
        'is not in canonical Scene order',
      );
    }
  }
}
