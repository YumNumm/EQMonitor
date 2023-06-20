import 'package:lat_lng/lat_lng.dart';
import 'package:topo_map/topo_map.dart';
import 'package:topojson/topojson.dart';

extension ListIntVector on List<IntVector> {
  /// [IntVector]のリストを[LatLng]のリストに変換する
  List<LatLng> toLocations(TopologyMap map) {
    final result = <LatLng>[];
    double x = 0;
    double y = 0;
    for (final e in this) {
      result.add(
        LatLng(
          (x += e.x) * map.scale.x + map.translate.x,
          (y += e.y) * map.scale.y + map.translate.y,
        ),
      );
    }
    return result;
  }
}
