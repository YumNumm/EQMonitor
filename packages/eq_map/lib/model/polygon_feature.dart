import 'package:topo_map/topo_map.dart';

class PolygonFeature {
  PolygonFeature._(this.code);

  final int? code;

  factory PolygonFeature.fromTopoMap(
    TopologyMap map,
  ) {
    throw UnimplementedError();
  }
}
