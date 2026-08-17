import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';

final class RecordingMapRenderBatchAdapter implements MapRenderBatchAdapter {
  final submissions = <MapRenderSubmission>[];
  var _createdRenderObjectCount = 0;

  int get createdRenderObjectCount => _createdRenderObjectCount;

  @override
  void submit({required MapRenderSubmission submission}) {
    validateMapRenderSubmission(submission: submission);
    submissions.add(submission);
    _createdRenderObjectCount += submission.batches.length;
  }
}

MapRenderBatch buildMapRenderBatchForAdapterTest({
  required int version,
  required int policyVersion,
  required int phase,
  required int order,
  int packetCount = 1,
}) {
  final policy = createMapRenderPhasePolicy(
    version: policyVersion,
    orderedPhases: [
      createMapRenderPhaseId(value: 'base'),
      MapRenderPhaseId.labelForeground,
    ],
  );
  return createMapRenderBatch(
    version: version,
    policy: policy,
    packets: List.generate(
      packetCount,
      (packetIndex) => createMapRenderPacket(
        contractVersion: 1,
        sortKey: MapRenderSortKey(
          phasePolicyVersion: policyVersion,
          phase: phase,
          declarationOrderWithinPhase: 0,
          sourceOrder: 0,
          overscaledTileOrder: 0,
          featureOrder: order + packetIndex,
        ),
        batchKey: createMapRenderBatchKey(
          version: 1,
          nodeKey: createMapNodeKey(value: 'map'),
          scopeKey: 'scope-$order',
          materialKey: 'point',
          phasePolicyVersion: policyVersion,
          phase: phase,
        ),
        pipeline: createMapRenderPipelineKey(version: 1, key: 'point'),
        mesh: createMapPackedMesh(
          payloadVersion: 1,
          layout: createMapPackedMeshLayout(
            version: 1,
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
          ),
          vertexBytes: Uint8List(0),
          vertexCount: 0,
          indexBytes: null,
          indexCount: null,
        ),
        modelTransform: Float64List(16),
        materialParameters: createMapMaterialParameterBlock(
          version: 1,
          bytes: Uint8List(0),
        ),
      ),
    ),
  );
}
