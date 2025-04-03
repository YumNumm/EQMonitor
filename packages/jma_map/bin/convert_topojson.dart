import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:jma_map/gen/jma_map.pb.dart';

/// TopoJSONデータをProtocol Bufferに変換するスクリプト
Future<void> main() async {
  // TopoJSONファイルのパス
  final topoJsonPaths = {
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E:
        '../../utils/map_converter/data/topojson/AreaForecastLocalE.topojson',
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW:
        '../../utils/map_converter/data/topojson/AreaForecastLocalEEW.topojson',
    JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY:
        '../../utils/map_converter/data/topojson/AreaInformationCityQuake.topojson',
    JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI:
        '../../utils/map_converter/data/topojson/AreaTsunami.topojson',
  };

  // 既存のJmaMapを読み込む
  final existingJmaMap = JmaMap();
  try {
    final existingFile = File('out.pb');
    if (await existingFile.exists()) {
      existingJmaMap.mergeFromBuffer(await existingFile.readAsBytes());
      print('Existing JmaMap loaded: ${existingJmaMap.data.length} data items');
    }
  } catch (e) {
    print('Failed to load existing JmaMap: $e');
  }

  // TopoJSONデータを変換
  final topoJsonDataList = <JmaMap_TopoJSONMapData>[];

  for (final entry in topoJsonPaths.entries) {
    final mapType = entry.key;
    final path = entry.value;
    final name = path.split('/').last.split('.').first;

    print('Converting $name...');

    // TopoJSONファイルを読み込む（先頭N行のみ）
    final jsonString = await readTopoJsonFile(path);

    // TopoJSONデータをパースしてProtocol Bufferに変換
    final topoJsonData = parseTopoJson(jsonString, mapType, name);

    // リストに追加
    topoJsonDataList.add(topoJsonData);
  }

  // JmaMapに追加
  existingJmaMap.topoJsonData.addAll(topoJsonDataList);

  // Protocol Bufferをバイナリ形式で保存
  final outputPath = 'out.pb';
  await File(outputPath).writeAsBytes(existingJmaMap.writeToBuffer());

  // JSONとして保存（デバッグ用）
  final jsonOutputPath = 'out.json';
  await File(
    jsonOutputPath,
  ).writeAsString(jsonEncode(existingJmaMap.toProto3Json()));

  print('Conversion completed. Output: $outputPath, $jsonOutputPath');
}

/// TopoJSONファイルを読み込む関数
///
/// [path] TopoJSONファイルのパス
Future<String> readTopoJsonFile(String path) async {
  final file = File(path);
  return await file.readAsString();
}

/// TopoJSONデータをパースする関数
///
/// [jsonString] TopoJSONデータの文字列
/// [mapType] 地図の種類
/// [name] 地図の名前
JmaMap_TopoJSONMapData parseTopoJson(
  String jsonString,
  JmaMap_JmaMapData_JmaMapType mapType,
  String name,
) {
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  final geometries = <JmaMap_TopoJSONGeometry>[];
  final arcs = <JmaMap_TopoJSONArc>[];

  // geometriesを抽出
  final objects = json['objects'] as Map<String, dynamic>;
  final dataKey = objects.keys.first;
  final data = objects[dataKey] as Map<String, dynamic>;
  final jsonGeometries = data['geometries'] as List<dynamic>;

  for (final jsonGeometry in jsonGeometries) {
    final geometry = parseGeometry(jsonGeometry as Map<String, dynamic>);
    geometries.add(geometry);
  }

  // arcsを抽出
  final jsonArcs = json['arcs'] as List<dynamic>;
  for (final jsonArc in jsonArcs) {
    final arc = parseArc(jsonArc as List<dynamic>);
    arcs.add(arc);
  }

  // 全体の境界ボックスを計算
  final bounds = calculateBounds(arcs);

  return JmaMap_TopoJSONMapData(
    mapType: mapType,
    name: name,
    geometries: geometries,
    arcs: arcs,
    bounds: bounds,
  );
}

/// ジオメトリをパースする関数
///
/// [jsonGeometry] ジオメトリのJSON
JmaMap_TopoJSONGeometry parseGeometry(Map<String, dynamic> jsonGeometry) {
  final type = jsonGeometry['type'] as String;
  final property = parseProperty(
    jsonGeometry['properties'] as Map<String, dynamic>,
  );
  final arcIndices = <JmaMap_TopoJSONArcIndices>[];

  // arcsを抽出
  final jsonArcs = jsonGeometry['arcs'];
  if (jsonArcs != null) {
    if (jsonArcs is List<dynamic>) {
      if (type == 'LineString') {
        // LineStringの場合、arcsは単一の整数
        final indices = JmaMap_TopoJSONArcIndices(
          indices: [jsonArcs[0] as int],
        );
        arcIndices.add(indices);
      } else if (type == 'MultiLineString' || type == 'Polygon') {
        // MultiLineStringまたはPolygonの場合、arcsは整数の配列の配列
        for (final jsonArcIndices in jsonArcs) {
          final indices = <int>[];
          for (final index in jsonArcIndices as List<dynamic>) {
            indices.add(index as int);
          }
          arcIndices.add(JmaMap_TopoJSONArcIndices(indices: indices));
        }
      } else if (type == 'MultiPolygon') {
        // MultiPolygonの場合、arcsは整数の配列の配列の配列
        for (final jsonPolygon in jsonArcs) {
          for (final jsonRing in jsonPolygon as List<dynamic>) {
            final indices = <int>[];
            for (final index in jsonRing as List<dynamic>) {
              indices.add(index as int);
            }
            arcIndices.add(JmaMap_TopoJSONArcIndices(indices: indices));
          }
        }
      }
    }
  }

  // 境界ボックスは後で計算
  final bounds = JmaMap_LatLngBounds();

  return JmaMap_TopoJSONGeometry(
    type: type,
    arcIndices: arcIndices,
    property: property,
    bounds: bounds,
  );
}

/// アークをパースする関数
///
/// [jsonArc] アークのJSON
JmaMap_TopoJSONArc parseArc(List<dynamic> jsonArc) {
  final positions = <JmaMap_LatLng>[];

  for (final jsonPosition in jsonArc) {
    final position = JmaMap_LatLng(
      lat: (jsonPosition as List<dynamic>)[1] as double,
      lng: jsonPosition[0] as double,
    );
    positions.add(position);
  }

  // 境界ボックスを計算
  final bounds = calculateArcBounds(positions);

  return JmaMap_TopoJSONArc(positions: positions, bounds: bounds);
}

/// プロパティをパースする関数
///
/// [jsonProperty] プロパティのJSON
JmaMap_JmaMapData_JmaMapDataItem_Property parseProperty(
  Map<String, dynamic> jsonProperty,
) {
  return JmaMap_JmaMapData_JmaMapDataItem_Property(
    code: jsonProperty['code']?.toString() ?? '',
    name: jsonProperty['name']?.toString() ?? '',
    nameKana: jsonProperty['namekana'] as String? ?? '',
  );
}

/// アークの境界ボックスを計算する関数
///
/// [positions] 座標の配列
JmaMap_LatLngBounds calculateArcBounds(List<JmaMap_LatLng> positions) {
  if (positions.isEmpty) {
    return JmaMap_LatLngBounds();
  }

  double minLat = double.infinity;
  double minLng = double.infinity;
  double maxLat = -double.infinity;
  double maxLng = -double.infinity;

  for (final position in positions) {
    minLat = min(minLat, position.lat);
    minLng = min(minLng, position.lng);
    maxLat = max(maxLat, position.lat);
    maxLng = max(maxLng, position.lng);
  }

  return JmaMap_LatLngBounds(
    southWest: JmaMap_LatLng(lat: minLat, lng: minLng),
    northEast: JmaMap_LatLng(lat: maxLat, lng: maxLng),
  );
}

/// 全体の境界ボックスを計算する関数
///
/// [arcs] アークの配列
JmaMap_LatLngBounds calculateBounds(List<JmaMap_TopoJSONArc> arcs) {
  if (arcs.isEmpty) {
    return JmaMap_LatLngBounds();
  }

  double minLat = double.infinity;
  double minLng = double.infinity;
  double maxLat = -double.infinity;
  double maxLng = -double.infinity;

  for (final arc in arcs) {
    final arcBounds = arc.bounds;
    minLat = min(minLat, arcBounds.southWest.lat);
    minLng = min(minLng, arcBounds.southWest.lng);
    maxLat = max(maxLat, arcBounds.northEast.lat);
    maxLng = max(maxLng, arcBounds.northEast.lng);
  }

  return JmaMap_LatLngBounds(
    southWest: JmaMap_LatLng(lat: minLat, lng: minLng),
    northEast: JmaMap_LatLng(lat: maxLat, lng: maxLng),
  );
}
