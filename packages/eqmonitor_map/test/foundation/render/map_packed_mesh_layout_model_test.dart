import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exposes all required packed layout fields', () {
    ({
      int version,
      MapPrimitiveTopology topology,
      MapPackedByteOrder byteOrder,
      int vertexStride,
      List<MapVertexAttributeLayout> attributes,
      MapIndexFormat? indexFormat,
    })
    readRequiredLayoutFields(MapPackedMeshLayout layout) => (
      version: layout.version,
      topology: layout.topology,
      byteOrder: layout.byteOrder,
      vertexStride: layout.vertexStride,
      attributes: layout.attributes,
      indexFormat: layout.indexFormat,
    );

    expect(readRequiredLayoutFields, isA<Function>());
  });

  test('defines the exact primitive topology catalog', () {
    expect(MapPrimitiveTopology.values, [
      MapPrimitiveTopology.points,
      MapPrimitiveTopology.lineList,
      MapPrimitiveTopology.lineStrip,
      MapPrimitiveTopology.triangleList,
      MapPrimitiveTopology.triangleStrip,
    ]);
  });

  test('defines the exact packed byte order catalog', () {
    expect(MapPackedByteOrder.values, [
      MapPackedByteOrder.little,
      MapPackedByteOrder.big,
    ]);
  });

  test('defines the exact optional index format catalog', () {
    expect(MapIndexFormat.values, [
      MapIndexFormat.uint16,
      MapIndexFormat.uint32,
    ]);
  });
}
