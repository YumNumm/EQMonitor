import 'package:collection/collection.dart';
import 'package:topo_map/src/enum/land_layer_type.dart';
import 'package:topo_map/src/model/topology_map.dart';
import 'package:topojson/topojson.dart';
import 'package:extensions/extensions.dart';

TopologyMap createMap(TopoJson json, LandLayerType layerType) {
  final base = TopologyMap(
    scale:
        DoubleVector(x: json.transform!.scale[1], y: json.transform!.scale[0]),
    translate: DoubleVector(
        x: json.transform!.translate[1], y: json.transform!.translate[0]),
    polygons: [],
    arcs: [],
  );
  print("ポリゴンの処理を開始");
  final resultPolygons = <TopologyPolygon>[];
  final resultArcs = <TopologyArc>[];

  for (final obj in json.objects.values) {
    for (final geo in (obj as GeometryCollection).geometries) {
      switch (geo.type) {
        case TopoJsonGeometryType.polygon:
          final arcs = (geo as Polygon).arcs;
          resultPolygons.add(
            TopologyPolygon(
              arcs: arcs,
              areaCode: int.tryParse(
                    (geo.properties)?.getOrNull("code").toString() ?? "",
                  ) ??
                  int.tryParse(
                    (geo.properties)?.getOrNull("regioncode").toString() ?? "",
                  ) ??
                  int.tryParse(
                    (geo.properties)?.getOrNull("ISO_N3").toString() ?? "",
                  ),
            ),
          );
        case TopoJsonGeometryType.multiPolygon:
          for (final arcs in (geo as MultiPolygon).arcs) {
            resultPolygons.add(
              TopologyPolygon(
                arcs: arcs,
                areaCode: int.tryParse(
                      (geo.properties)?.getOrNull("code").toString() ?? "",
                    ) ??
                    int.tryParse(
                      (geo.properties)?.getOrNull("regioncode").toString() ??
                          "",
                    ) ??
                    int.tryParse(
                      (geo.properties)?.getOrNull("ISO_N3").toString() ?? "",
                    ),
              ),
            );
          }

        case TopoJsonGeometryType.lineString
            when layerType == LandLayerType.tsunamiForecastArea:
          final arcs = (geo as LineString).arcs;
          resultPolygons.add(
            TopologyPolygon(
              arcs: [arcs],
              areaCode: int.tryParse(
                (geo.properties)?.getOrNull("code").toString() ?? "",
              ),
            ),
          );
        case TopoJsonGeometryType.multiLineString
            when layerType == LandLayerType.tsunamiForecastArea:
          for (final arcs in (geo as MultiLineString).arcs) {
            resultPolygons.add(
              TopologyPolygon(
                arcs: [arcs],
                areaCode: int.tryParse(
                  (geo.properties)?.getOrNull("code").toString() ?? "",
                ),
              ),
            );
          }

        default:
          break;
      }
    }
  }

  print("$layerType: ${resultPolygons.length}個のポリゴンが処理されました");
  print("$layerType: 境界線を処理しています...");

  // 境界線の処理
  json.getArcs.forEachIndexed((index, arc) {
    final TopologyArcType arcType;
    // 当該するPolyLineを利用しているポリゴンを取得
    final refPolygons = resultPolygons
        .where(
          (e) => e.arcs.any(
            (arc) => arc.any((i) => (i < 0 ? i.abs() - 1 : i) == index),
          ),
        )
        .toList();
    // 1つのみだったら海岸線
    if (refPolygons.length <= 1) {
      arcType = TopologyArcType.coastline;
    } else if (layerType.multiareaGroupNo == 1 ||
        refPolygons
                .where((polygon) => polygon.areaCode != null)
                .groupListsBy(
                    (poly) => poly.areaCode! / layerType.multiareaGroupNo)
                .length >
            1) {
      // ポリゴン自体が結合不可もしくは使用しているポリゴンがAreaCodeがnullでないかつ上3桁が違うものであれば県境
      arcType = TopologyArcType.admin;
    } else {
      // そうでもないなら一次細分区域
      arcType = TopologyArcType.area;
    }
    resultArcs.add(
      TopologyArc(
        arc: arc,
        type: arcType,
      ),
    );
  });

  return base.copyWith(
    polygons: resultPolygons,
    arcs: resultArcs,
  );
}

extension MapSafetyAccess on Map<String, String> {
  String? getOrNull(String key) {
    if (containsKey(key)) {
      return this[key];
    }
    return null;
  }
}
