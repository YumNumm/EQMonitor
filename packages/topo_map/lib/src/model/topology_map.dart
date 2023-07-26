import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:topojson/topojson.dart';

part 'topology_map.freezed.dart';
part 'topology_map.g.dart';

@freezed
class TopologyMap with _$TopologyMap {
  const factory TopologyMap({
    required DoubleVector scale,
    required DoubleVector translate,
    required List<TopologyPolygon> polygons,
    required List<TopologyArc> arcs,
  }) = _TopologyMap;

  factory TopologyMap.fromJson(Map<String, dynamic> json) =>
      _$TopologyMapFromJson(json);
}

@freezed
class TopologyArc with _$TopologyArc {
  const factory TopologyArc({
    required List<IntVector> arc,
    required TopologyArcType type,
  }) = _TopologyArc;

  factory TopologyArc.fromJson(Map<String, dynamic> json) =>
      _$TopologyArcFromJson(json);
}

@freezed
class TopologyPolygon with _$TopologyPolygon {
  const factory TopologyPolygon({
    required List<List<int>> arcs,
    required int? areaCode,
  }) = _TopologyPolygon;

  factory TopologyPolygon.fromJson(Map<String, dynamic> json) =>
      _$TopologyPolygonFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TopologyArcType {
  /// 海岸線
  coastline('coastline'),

  /// 県境
  admin('admin'),

  /// 一次細分化区域
  area('area');

  const TopologyArcType(this.type);
  final String type;
}
