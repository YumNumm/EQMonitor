import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';

final class MapRenderBatchCompatibility {
  const MapRenderBatchCompatibility._({
    required this.contractVersion,
    required this.payloadVersion,
    required this.batchKey,
    required this.phase,
    required this.phasePolicyVersion,
    required this.layout,
    required this.pipeline,
    required this.materialParameters,
  });

  final int contractVersion;
  final int payloadVersion;
  final MapRenderBatchKey batchKey;
  final int phase;
  final int phasePolicyVersion;
  final MapPackedMeshLayout layout;
  final MapRenderPipelineKey pipeline;
  final MapMaterialParameterBlock materialParameters;
}

MapRenderBatchCompatibility mapRenderBatchCompatibilityOf({
  required MapRenderPacket packet,
}) => MapRenderBatchCompatibility._(
  contractVersion: packet.contractVersion,
  payloadVersion: packet.mesh.payloadVersion,
  batchKey: packet.batchKey,
  phase: packet.sortKey.phase,
  phasePolicyVersion: packet.sortKey.phasePolicyVersion,
  layout: packet.mesh.layout,
  pipeline: packet.pipeline,
  materialParameters: packet.materialParameters,
);

final class MapRenderBatch {
  const MapRenderBatch._({
    required this.version,
    required this.compatibility,
    required this.packets,
    required this.instanceTransforms,
  });

  final int version;
  final MapRenderBatchCompatibility compatibility;
  final List<MapRenderPacket> packets;
  final List<Float64List> instanceTransforms;
}
