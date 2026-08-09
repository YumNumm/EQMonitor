import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';

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

MapRenderBatch createMapRenderBatch({
  required int version,
  required MapRenderPhasePolicy policy,
  required List<MapRenderPacket> packets,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  if (packets.isEmpty) {
    throw ArgumentError.value(packets, 'packets', 'must not be empty');
  }

  final compatibility = mapRenderBatchCompatibilityOf(packet: packets.first);
  for (final (index, packet) in packets.indexed) {
    if (packet.sortKey.phasePolicyVersion != policy.version ||
        packet.sortKey.phase >= policy.orderedPhases.length) {
      throw ArgumentError.value(
        packet,
        'packets',
        'must conform to the phase policy',
      );
    }
    if (index > 0 &&
        compareMapRenderSortKeys(packets[index - 1].sortKey, packet.sortKey) >=
            0) {
      throw ArgumentError.value(
        packets,
        'packets',
        'sort keys must be unique and in canonical order',
      );
    }
    if (packet.contractVersion != compatibility.contractVersion ||
        packet.mesh.payloadVersion != compatibility.payloadVersion ||
        packet.batchKey != compatibility.batchKey ||
        packet.sortKey.phase != compatibility.phase ||
        packet.sortKey.phasePolicyVersion != compatibility.phasePolicyVersion ||
        !haveCompatibleMapPackedMeshLayouts(
          packet.mesh.layout,
          compatibility.layout,
        ) ||
        packet.pipeline != compatibility.pipeline ||
        !haveEqualMapMaterialParameterContent(
          packet.materialParameters,
          compatibility.materialParameters,
        )) {
      throw ArgumentError.value(
        packet,
        'packets',
        'must be compatible with the first packet',
      );
    }
  }

  final ownedPackets = List<MapRenderPacket>.unmodifiable(packets);
  return MapRenderBatch._(
    version: version,
    compatibility: compatibility,
    packets: ownedPackets,
    instanceTransforms: List<Float64List>.unmodifiable(
      ownedPackets.map((packet) => packet.modelTransform),
    ),
  );
}
