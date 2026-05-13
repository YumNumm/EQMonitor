import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:geobase/geobase.dart';
import 'package:jma_map/jma_map.dart';

typedef FindNearestItemResult = ({
  JmaMap_JmaMapData_JmaMapDataItem? item,
  /// 現在地から該当ジオメトリまでの最短距離（km）。津波予報区のみ設定される。
  double? distanceKm,
});

class JmaMapUtility {
  /// [latLng] から最も近い、ないしは内包する [JmaMap_JmaMapData_JmaMapDataItem] を返す。
  /// 津波予報区の場合は海岸線までの最短距離（km）も合わせて返す。
  FindNearestItemResult findNearestItem(
    JmaMap_LatLng latLng,
    JmaMap_JmaMapData mapData,
  ) {
    final referencePoint = Geographic(lon: latLng.lng, lat: latLng.lat);

    if (mapData.mapType == JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI) {
      final dataList = mapData.data.map((data) {
        final dataType = data.dataType;
        final bytes = Uint8List.fromList(data.bytes);
        switch (dataType) {
          case JmaMap_JmaMapData_DataType.LINE_STRING:
            final lineString = LineString.decode(bytes);
            final distanceDeg = lineString.distanceTo2D(referencePoint);
            final distanceKm = minDistanceToChainKm(
              latLng.lat,
              latLng.lng,
              lineString.chain,
            );
            return (data, distanceDeg, distanceKm);
          case JmaMap_JmaMapData_DataType.MULTI_LINE_STRING:
            final multiLineString = MultiLineString.decode(bytes);
            final distanceDeg = multiLineString.distanceTo2D(referencePoint);
            final distanceKm = multiLineString.chains.fold(
              double.infinity,
              (minDist, chain) {
                final d = minDistanceToChainKm(latLng.lat, latLng.lng, chain);
                return d < minDist ? d : minDist;
              },
            );
            return (data, distanceDeg, distanceKm);
          case JmaMap_JmaMapData_DataType.POLYGON:
          case JmaMap_JmaMapData_DataType.MULTI_POLYGON:
            throw UnimplementedError('Unsupported dataType: $dataType');
        }
      });

      // degree 距離で最近傍を選択し、km 距離を返す
      final nearest = minBy(dataList, (e) => e?.$2)!;
      return (item: nearest.$1, distanceKm: nearest.$3);
    }

    for (final data in mapData.data) {
      final dataType = data.dataType;
      final bytes = Uint8List.fromList(data.bytes);
      switch (dataType) {
        case JmaMap_JmaMapData_DataType.POLYGON:
          final polygon = Polygon.decode(bytes);
          if (polygon.isPointInPolygon2D(referencePoint)) {
            return (item: data, distanceKm: null);
          }
        case JmaMap_JmaMapData_DataType.MULTI_POLYGON:
          final multiPolygon = MultiPolygon.decode(bytes);
          if (multiPolygon.isPointInPolygon2D(referencePoint)) {
            return (item: data, distanceKm: null);
          }
        case JmaMap_JmaMapData_DataType.LINE_STRING:
        case JmaMap_JmaMapData_DataType.MULTI_LINE_STRING:
          throw UnimplementedError('Unsupported dataType: $dataType');
      }
    }

    return (item: null, distanceKm: null);
  }

  /// [chain] 上の全頂点と基準点（[refLat], [refLon]）との Haversine 距離（km）の最小値を返す。
  static double minDistanceToChainKm(
    double refLat,
    double refLon,
    PositionSeries chain,
  ) {
    var minDist = double.infinity;
    for (var i = 0; i < chain.positionCount; i++) {
      final d = haversineKm(refLat, refLon, chain.y(i), chain.x(i));
      if (d < minDist) {
        minDist = d;
      }
    }
    return minDist;
  }

  /// Haversine 公式による2点間の大円距離（km）。
  static double haversineKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371.0;
    final dLat = (lat2 - lat1) * pi / 180;
    final dLon = (lon2 - lon1) * pi / 180;
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) * cos(lat2 * pi / 180) *
            sin(dLon / 2) * sin(dLon / 2);
    return r * 2 * atan2(sqrt(a), sqrt(1 - a));
  }
}
