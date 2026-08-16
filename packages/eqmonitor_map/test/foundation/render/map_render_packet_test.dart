import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sortKey = MapRenderSortKey(
    phasePolicyVersion: 7,
    phase: 2,
    declarationOrderWithinPhase: 3,
    sourceOrder: 4,
    overscaledTileOrder: 5,
    featureOrder: 6,
  );
  MapRenderBatchKey batchKey({int policyVersion = 7, int phase = 2}) =>
      createMapRenderBatchKey(
        version: 1,
        nodeKey: createMapNodeKey(value: 'base-map'),
        scopeKey: 'tile/14/14556/6451',
        materialKey: 'fill',
        phasePolicyVersion: policyVersion,
        phase: phase,
      );
  final baseBatchKey = batchKey();
  final pipeline = createMapRenderPipelineKey(version: 1, key: 'fill');
  final attribute = MapVertexAttributeLayout(
    semantic: .featureIdUint32,
    format: .uint32,
    offset: 0,
  );
  final mesh = createMapPackedMesh(
    payloadVersion: 1,
    layout: createMapPackedMeshLayout(
      version: 1,
      topology: .points,
      byteOrder: .little,
      vertexStride: 4,
      attributes: [attribute],
      indexFormat: null,
    ),
    vertexBytes: Uint8List(0),
    vertexCount: 0,
    indexBytes: null,
    indexCount: null,
  );
  final bytes = Uint8List(0);
  final material = createMapMaterialParameterBlock(version: 1, bytes: bytes);
  MapRenderPacket packet({
    int contractVersion = 3,
    MapRenderBatchKey? batch,
    Float64List? transform,
  }) => createMapRenderPacket(
    contractVersion: contractVersion,
    sortKey: sortKey,
    batchKey: batch ?? baseBatchKey,
    pipeline: pipeline,
    mesh: mesh,
    modelTransform: transform ?? Float64List(16),
    materialParameters: material,
  );

  test('owns an immutable 16-value finite transform and retains inputs', () {
    final source = Float64List(16)..[0] = 1;
    final value = packet(transform: source);

    source[0] = 99;
    expect((value.contractVersion, value.sortKey), (3, sortKey));
    expect((value.batchKey, value.pipeline), (baseBatchKey, pipeline));
    expect((value.mesh, value.materialParameters), (mesh, material));
    expect(value.modelTransform.first, 1);
    expect(() => value.modelTransform[0] = 0, throwsUnsupportedError);
  });

  test('rejects invalid contract versions and transforms', () {
    for (final version in [0, -1]) {
      expect(() => packet(contractVersion: version), throwsArgumentError);
    }
    for (final transform in <Float64List>[
      Float64List(15),
      Float64List(17),
      Float64List(16)..[7] = double.nan,
      Float64List(16)..[15] = double.infinity,
    ]) {
      expect(() => packet(transform: transform), throwsArgumentError);
    }
  });

  test('requires batch phase and policy version to match the sort key', () {
    expect(() => packet(batch: batchKey(phase: 3)), throwsArgumentError);
    expect(
      () => packet(batch: batchKey(policyVersion: 8)),
      throwsArgumentError,
    );
  });
}
