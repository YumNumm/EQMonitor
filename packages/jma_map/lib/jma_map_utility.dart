import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:geobase/geobase.dart';
import 'package:jma_map/jma_map.dart';

class JmaMapUtility {
  /// [latLng] から最も近い ないしは 内包する JmaMapDataItemを返す
  JmaMap_JmaMapData_JmaMapDataItem? findNearestItem(
    JmaMap_LatLng latLng,
    JmaMap_JmaMapData mapData,
  ) {
    final referencePoint = Geographic(lon: latLng.lng, lat: latLng.lat);

    if (mapData.mapType == JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI) {
      final dataList = mapData.data.map((data) {
        final dataType = data.dataType;
        final bytes = Uint8List.fromList(data.bytes);
        print('${data.property.name}: ${bytes.lengthInBytes / 1024} KB');
        switch (dataType) {
          case JmaMap_JmaMapData_DataType.LINE_STRING:
            final lineString = LineString.decode(bytes);
            final distance = lineString.distanceTo2D(referencePoint);
            return (data, distance);
          case JmaMap_JmaMapData_DataType.MULTI_LINE_STRING:
            final multiLineString = MultiLineString.decode(bytes);
            final distance = multiLineString.distanceTo2D(referencePoint);
            return (data, distance);
          case JmaMap_JmaMapData_DataType.POLYGON:
          case JmaMap_JmaMapData_DataType.MULTI_POLYGON:
            throw UnimplementedError('Unsupported dataType: $dataType');
        }
      });

      final min = minBy(dataList, (e) => e?.$2)!;

      return min.$1;
    }

    for (final data in mapData.data) {
      final dataType = data.dataType;
      final bytes = Uint8List.fromList(data.bytes);
      switch (dataType) {
        case JmaMap_JmaMapData_DataType.POLYGON:
          final polygon = Polygon.decode(bytes);
          final isInside = polygon.isPointInPolygon2D(referencePoint);
          if (isInside) {
            return data;
          }
        case JmaMap_JmaMapData_DataType.MULTI_POLYGON:
          final multiPolygon = MultiPolygon.decode(bytes);
          final isInside = multiPolygon.isPointInPolygon2D(referencePoint);
          if (isInside) {
            return data;
          }
        case JmaMap_JmaMapData_DataType.LINE_STRING:
        case JmaMap_JmaMapData_DataType.MULTI_LINE_STRING:
          throw UnimplementedError('Unsupported dataType: $dataType');
      }
    }

    return null;
  }
}
