import 'dart:typed_data';

import 'package:geobase/geobase.dart';
import 'package:jma_map/jma_map.dart';

/// JmaMapDataItemの拡張クラス
extension JmaMapDataItemExtension on JmaMap_JmaMapData_JmaMapDataItem {
  /// データタイプを判断する
  JmaMap_JmaMapData_DataType getDataType(JmaMap_JmaMapData_JmaMapType mapType) {
    // 津波予報区の場合
    if (mapType == JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI) {
      try {
        // LINE_STRINGとして解析を試みる
        LineString.decode(Uint8List.fromList(bytes));
        return JmaMap_JmaMapData_DataType.LINE_STRING;
      } catch (_) {
        try {
          // MULTI_LINE_STRINGとして解析を試みる
          MultiLineString.decode(Uint8List.fromList(bytes));
          return JmaMap_JmaMapData_DataType.MULTI_LINE_STRING;
        } catch (_) {
          // どちらでもない場合はエラー
          throw FormatException('Invalid bytes format for AREA_TSUNAMI');
        }
      }
    } else {
      // その他の場合
      try {
        // POLYGONとして解析を試みる
        Polygon.decode(Uint8List.fromList(bytes));
        return JmaMap_JmaMapData_DataType.POLYGON;
      } catch (_) {
        try {
          // MULTI_POLYGONとして解析を試みる
          MultiPolygon.decode(Uint8List.fromList(bytes));
          return JmaMap_JmaMapData_DataType.MULTI_POLYGON;
        } catch (_) {
          // どちらでもない場合はエラー
          throw FormatException('Invalid bytes format');
        }
      }
    }
  }
}
