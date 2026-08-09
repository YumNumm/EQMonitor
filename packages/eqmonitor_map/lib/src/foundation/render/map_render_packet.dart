import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_render_packet.freezed.dart';

@Freezed(copyWith: false)
sealed class MapRenderPipelineKey with _$MapRenderPipelineKey {
  const factory MapRenderPipelineKey._({
    required int version,
    required String key,
  }) = _MapRenderPipelineKey;
}

@Freezed(copyWith: false)
sealed class MapRenderBatchKey with _$MapRenderBatchKey {
  const factory MapRenderBatchKey._({
    required int version,
    required MapNodeKey nodeKey,
    required String scopeKey,
    required String materialKey,
    required int phasePolicyVersion,
    required int phase,
  }) = _MapRenderBatchKey;
}

final class MapMaterialParameterBlock {
  const MapMaterialParameterBlock._({
    required this.version,
    required this.bytes,
  });

  final int version;
  final Uint8List bytes;
}

MapMaterialParameterBlock createMapMaterialParameterBlock({
  required int version,
  required Uint8List bytes,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }

  return MapMaterialParameterBlock._(
    version: version,
    bytes: Uint8List.fromList(bytes).asUnmodifiableView(),
  );
}

bool haveEqualMapMaterialParameterContent(
  MapMaterialParameterBlock left,
  MapMaterialParameterBlock right,
) {
  if (left.version != right.version ||
      left.bytes.length != right.bytes.length) {
    return false;
  }
  for (var index = 0; index < left.bytes.length; index++) {
    if (left.bytes[index] != right.bytes[index]) {
      return false;
    }
  }
  return true;
}

MapRenderPipelineKey createMapRenderPipelineKey({
  required int version,
  required String key,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  final normalizedKey = key.trim();
  if (normalizedKey.isEmpty) {
    throw ArgumentError.value(key, 'key', 'must not be blank');
  }

  return MapRenderPipelineKey._(version: version, key: normalizedKey);
}

MapRenderBatchKey createMapRenderBatchKey({
  required int version,
  required MapNodeKey nodeKey,
  required String scopeKey,
  required String materialKey,
  required int phasePolicyVersion,
  required int phase,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  if (phasePolicyVersion <= 0) {
    throw ArgumentError.value(
      phasePolicyVersion,
      'phasePolicyVersion',
      'must be positive',
    );
  }
  if (phase < 0) {
    throw ArgumentError.value(phase, 'phase', 'must not be negative');
  }
  final normalizedScopeKey = scopeKey.trim();
  if (normalizedScopeKey.isEmpty) {
    throw ArgumentError.value(scopeKey, 'scopeKey', 'must not be blank');
  }
  final normalizedMaterialKey = materialKey.trim();
  if (normalizedMaterialKey.isEmpty) {
    throw ArgumentError.value(
      materialKey,
      'materialKey',
      'must not be blank',
    );
  }

  return MapRenderBatchKey._(
    version: version,
    nodeKey: nodeKey,
    scopeKey: normalizedScopeKey,
    materialKey: normalizedMaterialKey,
    phasePolicyVersion: phasePolicyVersion,
    phase: phase,
  );
}
