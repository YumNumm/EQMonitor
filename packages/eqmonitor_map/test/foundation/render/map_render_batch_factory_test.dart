import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final policy = createMapRenderPhasePolicy(
    version: 7,
    orderedPhases: [
      createMapRenderPhaseId(value: 'base-map'),
      MapRenderPhaseId.labelForeground,
    ],
  );
  MapPackedMeshLayout layout({int version = 1}) => createMapPackedMeshLayout(
    version: version,
    topology: .points,
    byteOrder: .little,
    vertexStride: 4,
    attributes: [
      MapVertexAttributeLayout(
        semantic: .featureIdUint32,
        format: .uint32,
        offset: 0,
      ),
    ],
    indexFormat: null,
  );
  MapRenderPacket packet({
    required int order,
    int contractVersion = 1,
    int payloadVersion = 1,
    int policyVersion = 7,
    int phase = 0,
    int layoutVersion = 1,
    int pipelineVersion = 1,
    String pipelineKey = 'fill',
    int materialVersion = 1,
    List<int> materialBytes = const [1, 2],
    double transformMarker = 0,
  }) => createMapRenderPacket(
    contractVersion: contractVersion,
    sortKey: MapRenderSortKey(
      phasePolicyVersion: policyVersion,
      phase: phase,
      declarationOrderWithinPhase: 0,
      sourceOrder: 0,
      overscaledTileOrder: 0,
      featureOrder: order,
    ),
    batchKey: createMapRenderBatchKey(
      version: 1,
      nodeKey: createMapNodeKey(value: 'base-map'),
      scopeKey: 'tile/14/14556/6451',
      materialKey: 'fill',
      phasePolicyVersion: policyVersion,
      phase: phase,
    ),
    pipeline: createMapRenderPipelineKey(
      version: pipelineVersion,
      key: pipelineKey,
    ),
    mesh: createMapPackedMesh(
      payloadVersion: payloadVersion,
      layout: layout(version: layoutVersion),
      vertexBytes: Uint8List(0),
      vertexCount: 0,
      indexBytes: null,
      indexCount: null,
    ),
    modelTransform: Float64List(16)..[0] = transformMarker,
    materialParameters: createMapMaterialParameterBlock(
      version: materialVersion,
      bytes: Uint8List.fromList(materialBytes),
    ),
  );

  test('creates a compatible packet batch', () {
    final batch = createMapRenderBatch(
      version: 3,
      policy: policy,
      packets: [packet(order: 0)],
    );

    expect((batch.version, batch.packets.length), (3, 1));
  });
}
