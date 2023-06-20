import 'package:collection/collection.dart';
import 'package:eq_map/model/polygon_feature.dart';
import 'package:eq_map/model/polyline_feature.dart';
import 'package:topo_map/topo_map.dart';

class FeatureLayer {
  final TopologyMap basedMap;
  final List<PolylineFeature> lineFeatures;
  final List<PolygonFeature> polygonFeatures;

  FeatureLayer._({
    required this.basedMap,
    required this.lineFeatures,
    required this.polygonFeatures,
  });

  factory FeatureLayer.fromTopologyMap(TopologyMap map) {
    final lineFeatures = map.arcs
        .mapIndexed(
          (index, _) => PolylineFeature.fromTopoMap(map, index),
        )
        .toList();
    final polygonFeatures = map.polygons
        .mapIndexed(
          (_, polygon) =>
              PolygonFeature.fromTopoMap(map, lineFeatures, polygon),
        )
        .toList();
    return FeatureLayer._(
      basedMap: map,
      lineFeatures: lineFeatures,
      polygonFeatures: polygonFeatures,
    );
  }

  List<PolygonFeature> getPolygonsByCode(int code) =>
      polygonFeatures.where((e) => e.code == code).toList();
}
