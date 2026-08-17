import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('validates and owns packed vertex and index bytes', () {
    final vertices = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    final indices = Uint8List.fromList([0, 0, 1, 0]);
    final mesh = _mesh(vertexBytes: vertices, indexBytes: indices);

    vertices[0] = 9;
    indices[0] = 9;

    expect(
      (mesh.payloadVersion, mesh.vertexCount, mesh.indexCount),
      (1, 2, 2),
    );
    expect(mesh.vertexBytes, [1, 2, 3, 4, 5, 6, 7, 8]);
    expect(mesh.indexBytes, [0, 0, 1, 0]);
    expect(() => mesh.vertexBytes[0] = 9, throwsUnsupportedError);
    expect(() => mesh.indexBytes?[0] = 9, throwsUnsupportedError);
  });

  test('rejects invalid versions, byte lengths, and counts', () {
    for (final createInvalid in [
      () => _mesh(payloadVersion: 0),
      () => _mesh(vertexBytes: Uint8List(7)),
      () => _mesh(vertexCount: 1),
      () => _mesh(indexBytes: Uint8List(3)),
      () => _mesh(indexCount: 1),
    ]) {
      expect(createInvalid, throwsArgumentError);
    }
  });

  test('requires index format, bytes, and count together', () {
    final unindexed = _mesh(
      indexFormat: null,
      includeIndexBytes: false,
      indexCount: null,
    );
    expect((unindexed.indexBytes, unindexed.indexCount), (null, null));

    for (final createInvalid in [
      () => _mesh(includeIndexBytes: false, indexCount: null),
      () => _mesh(includeIndexBytes: false),
      () => _mesh(indexCount: null),
      () => _mesh(indexFormat: null),
    ]) {
      expect(createInvalid, throwsArgumentError);
    }
  });
}

MapPackedMesh _mesh({
  int payloadVersion = 1,
  Uint8List? vertexBytes,
  int vertexCount = 2,
  MapIndexFormat? indexFormat = .uint16,
  Uint8List? indexBytes,
  bool includeIndexBytes = true,
  int? indexCount = 2,
}) => createMapPackedMesh(
  payloadVersion: payloadVersion,
  layout: createMapPackedMeshLayout(
    version: 1,
    topology: .triangleList,
    byteOrder: .little,
    vertexStride: 4,
    attributes: [
      MapVertexAttributeLayout(
        semantic: .featureIdUint32,
        format: .uint32,
        offset: 0,
      ),
    ],
    indexFormat: indexFormat,
  ),
  vertexBytes: vertexBytes ?? Uint8List(8),
  vertexCount: vertexCount,
  indexBytes: includeIndexBytes
      ? indexBytes ?? Uint8List.fromList([0, 0, 1, 0])
      : null,
  indexCount: indexCount,
);
