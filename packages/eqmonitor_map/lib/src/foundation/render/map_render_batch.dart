import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';

final class MapRenderBatchCompatibility {
  const new _({
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
  const new _({
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
    if (!_haveCompatibleMapRenderBatchProperties(
      mapRenderBatchCompatibilityOf(packet: packet),
      compatibility,
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

List<MapRenderBatch> buildCanonicalRenderBatches({
  required int version,
  required MapRenderPhasePolicy policy,
  required List<MapRenderPacket> packets,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  final canonical =
      packets.indexed
          .map((entry) => (inputOrder: entry.$1, packet: entry.$2))
          .toList()
        ..sort((left, right) {
          final result = compareMapRenderSortKeys(
            left.packet.sortKey,
            right.packet.sortKey,
          );
          return result != 0
              ? result
              : left.inputOrder.compareTo(right.inputOrder);
        });
  final groups = <List<MapRenderPacket>>[];
  for (final entry in canonical) {
    final packet = entry.packet;
    if (groups.isEmpty ||
        !_haveCompatibleMapRenderBatchProperties(
          mapRenderBatchCompatibilityOf(packet: groups.last.first),
          mapRenderBatchCompatibilityOf(packet: packet),
        )) {
      groups.add(<MapRenderPacket>[]);
    }
    groups.last.add(packet);
  }
  return List<MapRenderBatch>.unmodifiable(
    groups.map(
      (group) => createMapRenderBatch(
        version: version,
        policy: policy,
        packets: group,
      ),
    ),
  );
}

bool _haveCompatibleMapRenderBatchProperties(
  MapRenderBatchCompatibility left,
  MapRenderBatchCompatibility right,
) =>
    left.contractVersion == right.contractVersion &&
    left.payloadVersion == right.payloadVersion &&
    left.batchKey == right.batchKey &&
    left.phase == right.phase &&
    left.phasePolicyVersion == right.phasePolicyVersion &&
    haveCompatibleMapPackedMeshLayouts(left.layout, right.layout) &&
    left.pipeline == right.pipeline &&
    haveEqualMapMaterialParameterContent(
      left.materialParameters,
      right.materialParameters,
    );
