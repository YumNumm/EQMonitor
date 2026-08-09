import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';

enum MapPrimitiveTopology {
  points,
  lineList,
  lineStrip,
  triangleList,
  triangleStrip,
}

enum MapPackedByteOrder { little, big }

enum MapIndexFormat { uint16, uint32 }

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
