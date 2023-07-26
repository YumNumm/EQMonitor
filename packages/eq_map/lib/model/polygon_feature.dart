import 'package:eq_map/extension/list_int_vector.dart';
import 'package:extensions/extensions.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:topo_map/topo_map.dart';

class PolygonFeature {

  factory PolygonFeature.fromTopoMap(
    TopologyMap map,
    TopologyPolygon topologyPolygon,
  ) {
    final polyIndexes = topologyPolygon.arcs;
    final firstPolyIndexes = polyIndexes.getOrNull<List<int>>(0);
    if (firstPolyIndexes == null) {
      throw ArgumentError('firstPolyIndexes is null');
    }
    final points = <LatLng>[];
    for (final index in firstPolyIndexes) {
      if (points.isEmpty) {
        if (index < 0) {
          points.addAll(
            map.arcs[index.abs() - 1].arc.toLocations(map).reversed,
          );
        } else {
          points.addAll(
            map.arcs[index].arc.toLocations(map),
          );
        }
        continue;
      }

      if (index < 0) {
        points.addAll(
          map.arcs[index.abs() - 1].arc.toLocations(map).reversed.skip(1),
        );
      } else {
        points.addAll(
          map.arcs[index].arc.toLocations(map).skip(1),
        );
      }
    }
    final bbox = LatLngBoundary.fromList(points);
    return PolygonFeature._(
      code: topologyPolygon.areaCode,
      bbox: bbox,
      points: points,
    );
  }
  PolygonFeature._({
    required this.code,
    required this.bbox,
    required this.points,
  });

  final int? code;
  final LatLngBoundary? bbox;
  final List<LatLng> points;
}
