enum MapVertexAttributeSemantic {
  position2D,
  position3D,
  normal3D,
  colorRgba8,
  texCoord2D,
  lineExtrude2D,
  featureIdUint32,
}

enum MapVertexAttributeFormat {
  float32x2(byteLength: 8, scalarAlignment: 4),
  float32x3(byteLength: 12, scalarAlignment: 4),
  float32x4(byteLength: 16, scalarAlignment: 4),
  uint8x4Normalized(byteLength: 4, scalarAlignment: 1),
  uint16x2(byteLength: 4, scalarAlignment: 2),
  uint32(byteLength: 4, scalarAlignment: 4),
  ;

  new({
    required this.byteLength,
    required this.scalarAlignment,
  });

  final int byteLength;
  final int scalarAlignment;
}

final class MapVertexAttributeLayout {
  new({
    required this.semantic,
    required this.format,
    required this.offset,
  }) {
    if (offset < 0) {
      throw ArgumentError.value(offset, 'offset', 'must not be negative');
    }
  }

  final MapVertexAttributeSemantic semantic;
  final MapVertexAttributeFormat format;
  final int offset;
}
