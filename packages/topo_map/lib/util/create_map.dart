import 'package:collection/collection.dart';
import 'package:extensions/extensions.dart';
import 'package:topo_map/src/enum/land_layer_type.dart';
import 'package:topo_map/src/model/topology_map.dart';
import 'package:topojson/topojson.dart';

TopologyMap createMap(TopoJson json, LandLayerType layerType) {
  final base = TopologyMap(
    scale:
        DoubleVector(x: json.transform!.scale[1], y: json.transform!.scale[0]),
    translate: DoubleVector(
        x: json.transform!.translate[1], y: json.transform!.translate[0],),
    polygons: [],
    arcs: [],
  );
  print('ポリゴンの処理を開始');
  final resultPolygons = <TopologyPolygon>[];

  for (final obj in json.objects.values) {
    for (final geo in (obj as GeometryCollection).geometries) {
      switch (geo.type) {
        case TopoJsonGeometryType.polygon:
          final arcs = (geo as Polygon).arcs;
          resultPolygons.add(
            TopologyPolygon(
              arcs: arcs,
              areaCode: int.tryParse(
                    (geo.properties)?.getOrNull('code').toString() ?? '',
                  ) ??
                  int.tryParse(
                    (geo.properties)?.getOrNull('regioncode').toString() ?? '',
                  ) ??
                  int.tryParse(
                    (geo.properties)?.getOrNull('ISO_N3').toString() ?? '',
                  ),
            ),
          );
        case TopoJsonGeometryType.multiPolygon:
          for (final arcs in (geo as MultiPolygon).arcs) {
            resultPolygons.add(
              TopologyPolygon(
                arcs: arcs,
                areaCode: int.tryParse(
                      (geo.properties)?.getOrNull('code').toString() ?? '',
                    ) ??
                    int.tryParse(
                      (geo.properties)?.getOrNull('regioncode').toString() ??
                          '',
                    ) ??
                    int.tryParse(
                      (geo.properties)?.getOrNull('ISO_N3').toString() ?? '',
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
                (geo.properties)?.getOrNull('code').toString() ?? '',
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
                  (geo.properties)?.getOrNull('code').toString() ?? '',
                ),
              ),
            );
          }

        default:
          break;
      }
    }
  }

  print('$layerType: ${resultPolygons.length}個のポリゴンが処理されました');
  print('$layerType: 境界線を処理しています...');

  // 境界線の処理
  final resultArcs = json.getArcs.mapIndexed((index, arc) {
    // 当該するPolylineを利用しているポリゴンを取得
    final refPolygons = resultPolygons
        .where(
          (e) => e.arcs.any(
            (arc) => arc.any((i) => (i < 0 ? i.abs() - 1 : i) == index),
          ),
        )
        .toList();
    print(refPolygons.map((e) => e.areaCode));
    final TopologyArcType arcType;
    // このPolylineを利用しているポリゴンが1つのみだったら 海岸線
    if (refPolygons.length <= 1) {
      arcType = TopologyArcType.coastline;
    } else if (refPolygons
            .where((polygon) => polygon.areaCode != null)
            .groupListsBy(
                (polygon) => polygon.areaCode! ~/ layerType.multiAreaGroupNo,)
            .length >=
        2) {
      // このPolylineを参照しているポリゴンのcode すべて一致するなら 県境
      arcType = TopologyArcType.admin;
    } else {
      // そうでもないなら 一次細分区域
      arcType = TopologyArcType.area;
    }
    print(arcType);
    return TopologyArc(
      arc: arc,
      type: arcType,
    );
  }).toList();

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
