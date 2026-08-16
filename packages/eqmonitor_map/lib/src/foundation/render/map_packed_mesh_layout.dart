import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';

enum MapPrimitiveTopology {
  points,
  lineList,
  lineStrip,
  triangleList,
  triangleStrip,
}

enum MapPackedByteOrder { little, big }

enum MapIndexFormat {
  uint16(byteLength: 2),
  uint32(byteLength: 4),
  ;

  const MapIndexFormat({required this.byteLength});

  final int byteLength;
}

final class MapPackedMeshLayout {
  const MapPackedMeshLayout._({
    required this.version,
    required this.topology,
    required this.byteOrder,
    required this.vertexStride,
    required this.attributes,
    required this.indexFormat,
  });

  final int version;
  final MapPrimitiveTopology topology;
  final MapPackedByteOrder byteOrder;
  final int vertexStride;
  final List<MapVertexAttributeLayout> attributes;
  final MapIndexFormat? indexFormat;
}

MapPackedMeshLayout createMapPackedMeshLayout({
  required int version,
  required MapPrimitiveTopology topology,
  required MapPackedByteOrder byteOrder,
  required int vertexStride,
  required List<MapVertexAttributeLayout> attributes,
  required MapIndexFormat? indexFormat,
}) {
  if (version <= 0) {
    throw ArgumentError.value(version, 'version', 'must be positive');
  }
  if (vertexStride <= 0) {
    throw ArgumentError.value(
      vertexStride,
      'vertexStride',
      'must be positive',
    );
  }
  if (attributes.isEmpty) {
    throw ArgumentError.value(attributes, 'attributes', 'must not be empty');
  }

  final semantics = <MapVertexAttributeSemantic>{};
  var previousOffset = -1;
  var previousEnd = 0;
  var maximumAlignment = 1;
  for (final attribute in attributes) {
    if (!semantics.add(attribute.semantic)) {
      throw ArgumentError.value(attributes, 'attributes', 'duplicate semantic');
    }
    if (attribute.offset <= previousOffset) {
      throw ArgumentError.value(
        attributes,
        'attributes',
        'offsets must ascend',
      );
    }
    final alignment = attribute.format.scalarAlignment;
    if (attribute.offset % alignment != 0) {
      throw ArgumentError.value(attribute.offset, 'attributes', 'misaligned');
    }
    final end = attribute.offset + attribute.format.byteLength;
    if (attribute.offset < previousEnd || end > vertexStride) {
      throw ArgumentError.value(attributes, 'attributes', 'range is invalid');
    }
    previousOffset = attribute.offset;
    previousEnd = end;
    if (alignment > maximumAlignment) {
      maximumAlignment = alignment;
    }
  }
  if (vertexStride % maximumAlignment != 0) {
    throw ArgumentError.value(vertexStride, 'vertexStride', 'misaligned');
  }

  return MapPackedMeshLayout._(
    version: version,
    topology: topology,
    byteOrder: byteOrder,
    vertexStride: vertexStride,
    attributes: List.unmodifiable(attributes),
    indexFormat: indexFormat,
  );
}

bool haveCompatibleMapPackedMeshLayouts(
  MapPackedMeshLayout left,
  MapPackedMeshLayout right,
) {
  if (left.version != right.version ||
      left.topology != right.topology ||
      left.byteOrder != right.byteOrder ||
      left.vertexStride != right.vertexStride ||
      left.attributes.length != right.attributes.length ||
      left.indexFormat != right.indexFormat) {
    return false;
  }
  for (var index = 0; index < left.attributes.length; index++) {
    final leftAttribute = left.attributes[index];
    final rightAttribute = right.attributes[index];
    if (leftAttribute.semantic != rightAttribute.semantic ||
        leftAttribute.format != rightAttribute.format ||
        leftAttribute.offset != rightAttribute.offset) {
      return false;
    }
  }
  return true;
}
