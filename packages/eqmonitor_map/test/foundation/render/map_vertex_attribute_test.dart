import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defines the exact vertex attribute semantic catalog', () {
    expect(MapVertexAttributeSemantic.values, [
      MapVertexAttributeSemantic.position2D,
      MapVertexAttributeSemantic.position3D,
      MapVertexAttributeSemantic.normal3D,
      MapVertexAttributeSemantic.colorRgba8,
      MapVertexAttributeSemantic.texCoord2D,
      MapVertexAttributeSemantic.lineExtrude2D,
      MapVertexAttributeSemantic.featureIdUint32,
    ]);
  });

  test('defines exact format sizes and scalar alignments', () {
    final expected = [
      (MapVertexAttributeFormat.float32x2, 8, 4),
      (MapVertexAttributeFormat.float32x3, 12, 4),
      (MapVertexAttributeFormat.float32x4, 16, 4),
      (MapVertexAttributeFormat.uint8x4Normalized, 4, 1),
      (MapVertexAttributeFormat.uint16x2, 4, 2),
      (MapVertexAttributeFormat.uint32, 4, 4),
    ];

    expect(MapVertexAttributeFormat.values, expected.map((item) => item.$1));
    for (final (format, byteLength, scalarAlignment) in expected) {
      expect(format.byteLength, byteLength);
      expect(format.scalarAlignment, scalarAlignment);
    }
  });

  test('retains the semantic, format, and byte offset', () {
    final layout = MapVertexAttributeLayout(
      semantic: MapVertexAttributeSemantic.featureIdUint32,
      format: MapVertexAttributeFormat.uint32,
      offset: 12,
    );

    expect(layout.semantic, MapVertexAttributeSemantic.featureIdUint32);
    expect(layout.format, MapVertexAttributeFormat.uint32);
    expect(layout.offset, 12);
  });

  test('rejects a negative byte offset', () {
    expect(
      () => MapVertexAttributeLayout(
        semantic: MapVertexAttributeSemantic.position2D,
        format: MapVertexAttributeFormat.float32x2,
        offset: -1,
      ),
      throwsArgumentError,
    );
  });
}
