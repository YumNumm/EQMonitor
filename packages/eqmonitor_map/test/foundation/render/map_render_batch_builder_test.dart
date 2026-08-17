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
  final layout = createMapPackedMeshLayout(
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
  );
  MapRenderPacket packet({
    required int order,
    String scope = 'A',
    int policyVersion = 7,
    int phase = 0,
    double transformMarker = 0,
  }) => createMapRenderPacket(
    contractVersion: 1,
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
      scopeKey: scope,
      materialKey: 'fill',
      phasePolicyVersion: policyVersion,
      phase: phase,
    ),
    pipeline: createMapRenderPipelineKey(version: 1, key: 'fill'),
    mesh: createMapPackedMesh(
      payloadVersion: 1,
      layout: layout,
      vertexBytes: Uint8List(0),
      vertexCount: 0,
      indexBytes: null,
      indexCount: null,
    ),
    modelTransform: Float64List(16)..[0] = transformMarker,
    materialParameters: createMapMaterialParameterBlock(
      version: 1,
      bytes: Uint8List.fromList([1, 2]),
    ),
  );

  test('sorts packets into one immutable transform-aligned batch', () {
    final packets = [
      packet(order: 1, transformMarker: 11),
      packet(order: 0, transformMarker: 10),
    ];
    final batches = buildCanonicalRenderBatches(
      version: 3,
      policy: policy,
      packets: packets,
    );
    packets.clear();

    expect(batches, hasLength(1));
    expect(
      batches.single.packets.map((value) => value.sortKey.featureOrder),
      [0, 1],
    );
    expect(
      batches.single.instanceTransforms.map((value) => value.first),
      [10, 11],
    );
    expect(batches.clear, throwsUnsupportedError);
    expect(batches.single.instanceTransforms.clear, throwsUnsupportedError);
  });

  test(
    'keeps compatible packets separated across an intervening batch key',
    () {
      final batches = buildCanonicalRenderBatches(
        version: 3,
        policy: policy,
        packets: [
          packet(order: 2),
          packet(order: 0),
          packet(order: 1, scope: 'B'),
        ],
      );

      expect(
        batches.map((batch) => batch.packets.single.batchKey.scopeKey),
        ['A', 'B', 'A'],
      );
    },
  );

  test('preserves input order for equal sort keys in separate batches', () {
    final batches = buildCanonicalRenderBatches(
      version: 3,
      policy: policy,
      packets: [
        packet(order: 0, scope: 'B'),
        packet(order: 0),
      ],
    );

    expect(
      batches.map((batch) => batch.packets.single.batchKey.scopeKey),
      ['B', 'A'],
    );
  });

  test('rejects packet phase and policy keys outside the supplied policy', () {
    for (final invalid in [
      packet(order: 0, policyVersion: 8),
      packet(order: 0, phase: 2),
    ]) {
      expect(
        () => buildCanonicalRenderBatches(
          version: 3,
          policy: policy,
          packets: [invalid],
        ),
        throwsArgumentError,
      );
    }
  });
}
