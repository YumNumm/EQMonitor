import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final batchKey = createMapRenderBatchKey(
    version: 2,
    nodeKey: createMapNodeKey(value: 'base-map'),
    scopeKey: 'tile/14/14556/6451',
    materialKey: 'fill',
    phasePolicyVersion: 7,
    phase: 3,
  );
  final pipeline = createMapRenderPipelineKey(version: 4, key: 'fill');
  final layout = createMapPackedMeshLayout(
    version: 5,
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
  final material = createMapMaterialParameterBlock(
    version: 6,
    bytes: Uint8List.fromList([1, 2]),
  );
  final packet = createMapRenderPacket(
    contractVersion: 8,
    sortKey: MapRenderSortKey(
      phasePolicyVersion: 7,
      phase: 3,
      declarationOrderWithinPhase: 0,
      sourceOrder: 0,
      overscaledTileOrder: 0,
      featureOrder: 0,
    ),
    batchKey: batchKey,
    pipeline: pipeline,
    mesh: createMapPackedMesh(
      payloadVersion: 9,
      layout: layout,
      vertexBytes: Uint8List(0),
      vertexCount: 0,
      indexBytes: null,
      indexCount: null,
    ),
    modelTransform: Float64List(16),
    materialParameters: material,
  );

  test('derives every compatibility field from the packet', () {
    final value = readCompatibility(packet);

    expect(
      (
        value.contractVersion,
        value.payloadVersion,
        value.batchKey,
        value.phase,
        value.phasePolicyVersion,
        value.layout,
        value.pipeline,
        value.materialParameters,
      ),
      (8, 9, batchKey, 3, 7, layout, pipeline, material),
    );
  });

  test('exposes a type-annotatable packet and transform batch shape', () {
    (List<MapRenderPacket>, List<Float64List>) read(MapRenderBatch batch) =>
        (batch.packets, batch.instanceTransforms);

    expect(read, isA<Function>());
  });
}

MapRenderBatchCompatibility readCompatibility(MapRenderPacket packet) =>
    mapRenderBatchCompatibilityOf(packet: packet);
