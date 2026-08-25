import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';

const observationPointInstanceStrideInBytes = 28;
const observationFrameUniformByteLength = 32;
const observationFrameUniformBlockName = 'ObservationFrame';
const earthquakeObservationVertexShaderSymbol = 'EarthquakeObservationVertex';
const earthquakeObservationFragmentShaderSymbol =
    'EarthquakeObservationFragment';

/// StaticInstanceGeometryと1対1で対応するinstance内容のidentity。
final class ObservationPointInstanceGeneration {
  ObservationPointInstanceGeneration._();
}

/// 1 overlay version分の観測点instanceとframe固有uniform。
final class ObservationPointBatch implements MapSceneObservationBatch {
  const ObservationPointBatch._({
    required this.frame,
    required this.versionStamp,
    required this.instanceGeneration,
    required this.instanceData,
    required this.instanceCount,
    required this.frameUniform,
    required this.phasePolicyVersion,
    required this.phase,
    required this.translucentSortPriority,
    required Object stationSnapshotIdentity,
  }) : _stationSnapshotToken = stationSnapshotIdentity;

  @override
  final MapFrameSnapshot frame;
  final MapOverlayVersionStamp versionStamp;
  final ObservationPointInstanceGeneration instanceGeneration;
  final Float32List instanceData;
  final int instanceCount;
  final ByteData frameUniform;

  @override
  final int phasePolicyVersion;

  @override
  final int phase;

  @override
  final int translucentSortPriority;

  final Object _stationSnapshotToken;

  int get instanceStrideInBytes => observationPointInstanceStrideInBytes;

  bool hasStationSnapshotIdentity(Object identity) =>
      identical(_stationSnapshotToken, identity);

  ObservationPointBatch withFrame({
    required MapFrameSnapshot frame,
    required ByteData frameUniform,
  }) {
    final ownedUniformBytes = Uint8List.fromList(
      frameUniform.buffer.asUint8List(
        frameUniform.offsetInBytes,
        frameUniform.lengthInBytes,
      ),
    );
    return ObservationPointBatch._(
      frame: frame,
      versionStamp: versionStamp,
      instanceGeneration: instanceGeneration,
      instanceData: instanceData,
      instanceCount: instanceCount,
      frameUniform: ByteData.sublistView(
        ownedUniformBytes,
      ).asUnmodifiableView(),
      phasePolicyVersion: phasePolicyVersion,
      phase: phase,
      translucentSortPriority: translucentSortPriority,
      stationSnapshotIdentity: _stationSnapshotToken,
    );
  }
}

/// 検証済みbyte列から観測点batchを作る。
ObservationPointBatch createObservationPointBatch({
  required MapFrameSnapshot frame,
  required MapOverlayVersionStamp versionStamp,
  required Float32List instanceData,
  required int instanceCount,
  required ByteData frameUniform,
  required int phasePolicyVersion,
  required int phase,
  required int translucentSortPriority,
  Object? stationSnapshotIdentity,
}) {
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

  final ownedInstances = Float32List.fromList(instanceData);
  final ownedUniformBytes = Uint8List.fromList(
    frameUniform.buffer.asUint8List(
      frameUniform.offsetInBytes,
      frameUniform.lengthInBytes,
    ),
  );
  return ObservationPointBatch._(
    frame: frame,
    versionStamp: versionStamp,
    instanceGeneration: ObservationPointInstanceGeneration._(),
    instanceData: ownedInstances.asUnmodifiableView(),
    instanceCount: instanceCount,
    frameUniform: ByteData.sublistView(
      ownedUniformBytes,
    ).asUnmodifiableView(),
    phasePolicyVersion: phasePolicyVersion,
    phase: phase,
    translucentSortPriority: translucentSortPriority,
    stationSnapshotIdentity: stationSnapshotIdentity ?? Object(),
  );
}
