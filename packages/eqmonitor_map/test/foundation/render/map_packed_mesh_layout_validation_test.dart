import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final secondAttribute = _attribute(semantic: .colorRgba8, offset: 8);

  test('validates and owns the packed vertex layout', () {
    final attributes = [_attribute()];
    final layout = _layout(attributes: attributes);

    attributes.clear();

    expect(layout.attributes.clear, throwsUnsupportedError);
    expect(
      (
        layout.attributes.length,
        MapIndexFormat.uint16.byteLength,
        MapIndexFormat.uint32.byteLength,
      ),
      (1, 2, 4),
    );
  });

  test('rejects every invalid packed layout axis', () {
    for (final createInvalidLayout in [
      () => _layout(version: 0),
      () => _layout(vertexStride: 0),
      () => _layout(attributes: []),
      () => _layout(attributes: [_attribute(), _attribute(offset: 8)]),
      () => _layout(
        attributes: [
          _attribute(offset: 8),
          _attribute(semantic: .texCoord2D),
        ],
      ),
      () => _layout(attributes: [_attribute(offset: 2)]),
      () => _layout(
        attributes: [
          _attribute(format: .float32x3),
          secondAttribute,
        ],
      ),
      () => _layout(vertexStride: 8, attributes: [_attribute(offset: 4)]),
      () => _layout(vertexStride: 10),
    ]) {
      expect(createInvalidLayout, throwsArgumentError);
    }
  });

  test('compares every packed layout field by content', () {
    final layout = _layout();
    expect(haveCompatibleMapPackedMeshLayouts(layout, _layout()), isTrue);

    for (final incompatibleLayout in [
      _layout(version: 2),
      _layout(topology: .lineList),
      _layout(byteOrder: .big),
      _layout(vertexStride: 20),
      _layout(attributes: [_attribute(semantic: .texCoord2D)]),
      _layout(attributes: [_attribute(format: .float32x3)]),
      _layout(attributes: [_attribute(offset: 4)]),
      _layout(attributes: [_attribute(), secondAttribute]),
      _layout(indexFormat: .uint32),
    ]) {
      expect(
        haveCompatibleMapPackedMeshLayouts(layout, incompatibleLayout),
        isFalse,
      );
    }
  });
}

MapVertexAttributeLayout _attribute({
  MapVertexAttributeSemantic semantic = .position2D,
  MapVertexAttributeFormat format = .float32x2,
  int offset = 0,
}) => MapVertexAttributeLayout(
  semantic: semantic,
  format: format,
  offset: offset,
);

MapPackedMeshLayout _layout({
  int version = 1,
  MapPrimitiveTopology topology = .triangleList,
  MapPackedByteOrder byteOrder = .little,
  int vertexStride = 16,
  List<MapVertexAttributeLayout>? attributes,
  MapIndexFormat? indexFormat = .uint16,
}) => createMapPackedMeshLayout(
  version: version,
  topology: topology,
  byteOrder: byteOrder,
  vertexStride: vertexStride,
  attributes: attributes ?? [_attribute()],
  indexFormat: indexFormat,
);
