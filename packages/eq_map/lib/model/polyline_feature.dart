import 'package:eq_map/extension/list_int_vector.dart';
import 'package:extensions/extensions.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:topo_map/topo_map.dart';

class PolylineFeature {
  final List<LatLng> points;
  final PolylineType type;
  final bool isClosed;

  PolylineFeature._({
    required this.points,
    required this.type,
    required this.isClosed,
  });

  factory PolylineFeature.fromTopoMap(TopologyMap map, int index) {
    final arc = map.arcs.getOrNull<TopologyArc>(index);
    if (arc == null) {
      throw ArgumentError('arc is null at index: $index');
    }
    final type = switch (arc.type) {
      TopologyArcType.coastline => PolylineType.coastLine,
      TopologyArcType.admin => PolylineType.admin,
      TopologyArcType.area => PolylineType.city,
    };
    final points = arc.arc.toLocations(map);
    final isClosed = (points.first.lat - points.last.lat).abs() < 0.0001 &&
        (points.first.lon - points.last.lon).abs() < 0.0001;
    return PolylineFeature._(
      points: points,
      type: type,
      isClosed: isClosed,
    );
  }
}

enum PolylineType {
  /// 海岸線
  coastLine,

  /// 行政境界
  admin,

  /// 市区町村
  city,
}
