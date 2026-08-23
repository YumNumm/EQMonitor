import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';

const observationPointInstanceStrideInBytes = 28;
const observationFrameUniformByteLength = 32;
const observationFrameUniformBlockName = 'ObservationFrame';
const earthquakeObservationVertexShaderSymbol = 'EarthquakeObservationVertex';
const earthquakeObservationFragmentShaderSymbol =
    'EarthquakeObservationFragment';

/// 1 snapshot revision分の観測点instanceとframe固有uniform。
final class ObservationPointBatch implements MapSceneObservationBatch {
  const ObservationPointBatch._({
    required this.frame,
    required this.sourceId,
    required this.snapshotRevision,
    required this.instanceData,
    required this.instanceCount,
    required this.frameUniform,
    required this.phasePolicyVersion,
    required this.phase,
    required this.translucentSortPriority,
  });

  @override
  final MapFrameSnapshot frame;
  final String sourceId;
  final int snapshotRevision;
  final Float32List instanceData;
  final int instanceCount;
  final ByteData frameUniform;

  @override
  final int phasePolicyVersion;

  @override
  final int phase;

  @override
  final int translucentSortPriority;

  int get instanceStrideInBytes => observationPointInstanceStrideInBytes;
}

/// 検証済みbyte列から観測点batchを作る。
ObservationPointBatch createObservationPointBatch({
  required MapFrameSnapshot frame,
  required String sourceId,
  required int snapshotRevision,
  required Float32List instanceData,
  required int instanceCount,
  required ByteData frameUniform,
  required int phasePolicyVersion,
  required int phase,
  required int translucentSortPriority,
}) {
  if (sourceId.trim().isEmpty) {
    throw ArgumentError.value(sourceId, 'sourceId', 'must not be blank');
  }
  if (snapshotRevision.isNegative) {
    throw ArgumentError.value(
      snapshotRevision,
      'snapshotRevision',
      'must not be negative',
    );
  }
  if (instanceCount <= 0 ||
      instanceData.lengthInBytes !=
          instanceCount * observationPointInstanceStrideInBytes) {
    throw ArgumentError.value(
      instanceData.lengthInBytes,
      'instanceData',
      'must contain exactly instanceCount * 28 bytes',
    );
  }
  if (frameUniform.lengthInBytes != observationFrameUniformByteLength) {
    throw ArgumentError.value(
      frameUniform.lengthInBytes,
      'frameUniform',
      'must contain exactly 32 bytes',
    );
  }

  return ObservationPointBatch._(
    frame: frame,
    sourceId: sourceId,
    snapshotRevision: snapshotRevision,
    instanceData: instanceData.asUnmodifiableView(),
    instanceCount: instanceCount,
    frameUniform: frameUniform.asUnmodifiableView(),
    phasePolicyVersion: phasePolicyVersion,
    phase: phase,
    translucentSortPriority: translucentSortPriority,
  );
}
