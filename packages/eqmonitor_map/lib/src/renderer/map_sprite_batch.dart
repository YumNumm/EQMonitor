import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';

const mapSpriteQuadVertexStrideInBytes = 8;
const mapPointSpriteInstanceStrideInBytes = 40;
const mapSpriteInstanceAbiVersion = 1;
const mapSpriteFrameUniformByteLength = 64;
const mapSpriteMaterialAbiVersion = 1;
const mapSpriteFrameUniformBlockName = 'SpriteFrame';
const mapSpriteVertexShaderSymbol = 'MapSpriteVertex';
const mapSpriteFragmentShaderSymbol = 'MapSpriteFragment';
const mapSpriteAtlasUniformName = 'spriteAtlas';

/// StaticInstanceGeometryと1対1で対応するsprite instanceのidentity。
final class MapSpriteInstanceGeneration {
  MapSpriteInstanceGeneration._();
}

/// 同じatlas/material/policyを共有するimmutable sprite instance batch。
final class MapPointSpriteInstanceBatch implements MapSceneInstanceBatch {
  const MapPointSpriteInstanceBatch._({
    required this.frame,
    required this.versionStamp,
    required this.atlas,
    required this.sizePolicy,
    required this.opacityPolicy,
    required this.featureIds,
    required this.instanceGeneration,
    required this.instanceData,
    required this.instanceCount,
    required this.instanceDigest,
    required this.frameUniform,
    required this.batchKey,
    required this.phasePolicyVersion,
    required this.phase,
  });

  @override
  final MapFrameSnapshot frame;
  final MapOverlayVersionStamp versionStamp;
  final MapSpriteAtlas atlas;
  final MapZoomLinearRange sizePolicy;
  final MapZoomStep opacityPolicy;
  final List<String> featureIds;
  final MapSpriteInstanceGeneration instanceGeneration;
  final Float32List instanceData;
  final int instanceCount;
  final String instanceDigest;
  final ByteData frameUniform;

  @override
  final MapSceneBatchKey batchKey;

  @override
  final int phasePolicyVersion;

  @override
  final int phase;

  int get instanceStrideInBytes => mapPointSpriteInstanceStrideInBytes;

  MapPointSpriteInstanceBatch withFrame({
    required MapFrameSnapshot frame,
    required MapOverlayVersionStamp versionStamp,
    required ByteData frameUniform,
  }) {
    final ownedUniform = Uint8List.fromList(
      frameUniform.buffer.asUint8List(
        frameUniform.offsetInBytes,
        frameUniform.lengthInBytes,
      ),
    );
    return MapPointSpriteInstanceBatch._(
      frame: frame,
      versionStamp: versionStamp,
      atlas: atlas,
      sizePolicy: sizePolicy,
      opacityPolicy: opacityPolicy,
      featureIds: featureIds,
      instanceGeneration: instanceGeneration,
      instanceData: instanceData,
      instanceCount: instanceCount,
      instanceDigest: instanceDigest,
      frameUniform: ByteData.sublistView(ownedUniform).asUnmodifiableView(),
      batchKey: batchKey,
      phasePolicyVersion: phasePolicyVersion,
      phase: phase,
    );
  }
}

MapPointSpriteInstanceBatch createMapPointSpriteInstanceBatch({
  required MapFrameSnapshot frame,
  required MapOverlayVersionStamp versionStamp,
  required MapSpriteAtlas atlas,
  required MapZoomLinearRange sizePolicy,
  required MapZoomStep opacityPolicy,
  required List<String> featureIds,
  required Float32List instanceData,
  required int instanceCount,
  required String instanceDigest,
  required ByteData frameUniform,
  required MapSceneBatchKey batchKey,
  required int phasePolicyVersion,
  required int phase,
}) {
  if (instanceCount <= 0 ||
      featureIds.length != instanceCount ||
      instanceData.lengthInBytes !=
          instanceCount * mapPointSpriteInstanceStrideInBytes) {
    throw ArgumentError.value(instanceData, 'instanceData');
  }
  if (frameUniform.lengthInBytes != mapSpriteFrameUniformByteLength) {
    throw ArgumentError.value(frameUniform, 'frameUniform');
  }
  if (instanceDigest.trim().isEmpty) {
    throw ArgumentError.value(instanceDigest, 'instanceDigest');
  }
  final ownedUniform = Uint8List.fromList(
    frameUniform.buffer.asUint8List(
      frameUniform.offsetInBytes,
      frameUniform.lengthInBytes,
    ),
  );
  return MapPointSpriteInstanceBatch._(
    frame: frame,
    versionStamp: versionStamp,
    atlas: atlas,
    sizePolicy: sizePolicy,
    opacityPolicy: opacityPolicy,
    featureIds: List<String>.unmodifiable(featureIds),
    instanceGeneration: MapSpriteInstanceGeneration._(),
    instanceData: Float32List.fromList(instanceData).asUnmodifiableView(),
    instanceCount: instanceCount,
    instanceDigest: instanceDigest,
    frameUniform: ByteData.sublistView(ownedUniform).asUnmodifiableView(),
    batchKey: batchKey,
    phasePolicyVersion: phasePolicyVersion,
    phase: phase,
  );
}
