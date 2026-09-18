import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FillMesh fillMesh({
    required List<double> positions,
    required List<int> indices,
  }) => FillMesh(
    positions: Float32List.fromList(positions),
    indices: Uint16List.fromList(indices),
    vertexCount: positions.length ~/ 2,
  );

  LineMesh lineMesh({
    required List<double> positions,
    required List<double> extrudes,
    required List<int> indices,
  }) => LineMesh(
    positions: Float32List.fromList(positions),
    extrudes: Float32List.fromList(extrudes),
    indices: Uint16List.fromList(indices),
    vertexCount: positions.length ~/ 2,
  );

  List<double> floatsOf(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    return [
      for (var offset = 0; offset < bytes.length; offset += 4)
        data.getFloat32(offset, Endian.little),
    ];
  }

  List<int> uint16sOf(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    return [
      for (var offset = 0; offset < bytes.length; offset += 2)
        data.getUint16(offset, Endian.little),
    ];
  }

  group('layouts', () {
    test('fill layout carries only a tile-local 2D position', () {
      final layout = baseMapFillPackedMeshLayout;

      expect(layout.version, 1);
      expect(layout.topology, MapPrimitiveTopology.triangleList);
      expect(layout.byteOrder, MapPackedByteOrder.little);
      expect(layout.vertexStride, 8);
      expect(layout.indexFormat, MapIndexFormat.uint16);
      expect(layout.attributes.map((a) => a.semantic), [
        MapVertexAttributeSemantic.position2D,
      ]);
      expect(
        layout.attributes.single.format,
        MapVertexAttributeFormat.float32x2,
      );
      expect(layout.attributes.single.offset, 0);
    });

    test('line layout appends the extrusion normal after the position', () {
      final layout = baseMapLinePackedMeshLayout;

      expect(layout.version, 1);
      expect(layout.topology, MapPrimitiveTopology.triangleList);
      expect(layout.byteOrder, MapPackedByteOrder.little);
      expect(layout.vertexStride, 16);
      expect(layout.indexFormat, MapIndexFormat.uint16);
      expect(layout.attributes.map((a) => a.semantic), [
        MapVertexAttributeSemantic.position2D,
        MapVertexAttributeSemantic.lineExtrude2D,
      ]);
      expect(layout.attributes.map((a) => a.offset), [0, 8]);
      expect(
        layout.attributes.map((a) => a.format),
        List.filled(2, MapVertexAttributeFormat.float32x2),
      );
    });

    test('fill and line layouts are not interchangeable', () {
      expect(
        haveCompatibleMapPackedMeshLayouts(
          baseMapFillPackedMeshLayout,
          baseMapLinePackedMeshLayout,
        ),
        isFalse,
      );
    });
  });

  group('packBaseMapFillMesh', () {
    test('packs tile-local positions in declaration order', () {
      final packed = packBaseMapFillMesh(
        fillMesh(
          positions: [0, 1, 2, 3, 4, 5],
          indices: [0, 1, 2],
        ),
      );

      expect(packed.payloadVersion, baseMapPackedMeshPayloadVersion);
      expect(packed.layout, same(baseMapFillPackedMeshLayout));
      expect(packed.vertexCount, 3);
      expect(packed.vertexBytes.length, 3 * 8);
      expect(floatsOf(packed.vertexBytes), [0, 1, 2, 3, 4, 5]);
      expect(packed.indexCount, 3);
      expect(uint16sOf(packed.indexBytes!), [0, 1, 2]);
    });

    test('keeps coordinates outside the MVT extent', () {
      // extent 4096 + buffer 80 のような clip 辺は正当な地物であり、packer で
      // 落とさない(clip は描画側の scissor の責務)。
      final packed = packBaseMapFillMesh(
        fillMesh(
          positions: [-80, 4176, 4176, -80],
          indices: [0, 1, 0],
        ),
      );

      expect(floatsOf(packed.vertexBytes), [-80, 4176, 4176, -80]);
    });

    test('rejects an empty mesh instead of packing a zero-vertex payload', () {
      expect(
        () => packBaseMapFillMesh(fillMesh(positions: [], indices: [])),
        throwsArgumentError,
      );
    });

    test('rejects a mesh whose vertexCount disagrees with its positions', () {
      expect(
        () => packBaseMapFillMesh(
          FillMesh(
            positions: Float32List.fromList([0, 1, 2, 3]),
            indices: Uint16List.fromList([0, 1, 0]),
            vertexCount: 3,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('rejects an index that points outside the vertex range', () {
      expect(
        () => packBaseMapFillMesh(
          fillMesh(positions: [0, 1, 2, 3], indices: [0, 1, 2]),
        ),
        throwsArgumentError,
      );
    });
  });

  group('packBaseMapLineMesh', () {
    test('interleaves the position and the Y-flipped extrusion normal', () {
      final packed = packBaseMapLineMesh(
        lineMesh(
          positions: [10, 20, 30, 40],
          extrudes: [0, 1, -1, 0],
          indices: [0, 1, 0],
        ),
      );

      expect(packed.payloadVersion, baseMapPackedMeshPayloadVersion);
      expect(packed.layout, same(baseMapLinePackedMeshLayout));
      expect(packed.vertexCount, 2);
      expect(packed.vertexBytes.length, 2 * 16);
      // vertex 0: pos(10, 20) extrude(0, -1) / vertex 1: pos(30, 40) extrude(-1, -0)
      expect(floatsOf(packed.vertexBytes), [10, 20, 0, -1, 30, 40, -1, 0]);
      expect(uint16sOf(packed.indexBytes!), [0, 1, 0]);
    });

    test('preserves the miter extrusion length while flipping Y', () {
      // miter join の頂点は単位法線ではなく miterLength 倍の長さを持つ。
      // Y 反転は符号だけを変え、長さを正規化しない。
      final packed = packBaseMapLineMesh(
        lineMesh(
          positions: [0, 0, 1, 1],
          extrudes: [0.6, 3.2, -0.6, -3.2],
          indices: [0, 1, 0],
        ),
      );

      final floats = floatsOf(packed.vertexBytes);
      expect(floats[2], closeTo(0.6, 1e-6));
      expect(floats[3], closeTo(-3.2, 1e-6));
      expect(floats[6], closeTo(-0.6, 1e-6));
      expect(floats[7], closeTo(3.2, 1e-6));
    });

    test('rejects an extrude list that does not match the positions', () {
      expect(
        () => packBaseMapLineMesh(
          LineMesh(
            positions: Float32List.fromList([0, 0, 1, 1]),
            extrudes: Float32List.fromList([0, 1]),
            indices: Uint16List.fromList([0, 1, 0]),
            vertexCount: 2,
          ),
        ),
        throwsArgumentError,
      );
    });

    test('rejects an empty mesh', () {
      expect(
        () => packBaseMapLineMesh(
          lineMesh(positions: [], extrudes: [], indices: []),
        ),
        throwsArgumentError,
      );
    });

    test('rejects an index that points outside the vertex range', () {
      expect(
        () => packBaseMapLineMesh(
          lineMesh(
            positions: [0, 0, 1, 1],
            extrudes: [0, 1, 0, 1],
            indices: [0, 2, 1],
          ),
        ),
        throwsArgumentError,
      );
    });
  });

  group('index count', () {
    test('rejects an index count that is not a multiple of three', () {
      expect(
        () => packBaseMapFillMesh(
          fillMesh(positions: [0, 1, 2, 3, 4, 5], indices: [0, 1]),
        ),
        throwsArgumentError,
      );
    });
  });
}
