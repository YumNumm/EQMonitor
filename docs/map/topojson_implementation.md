# TopoJSONデータのProtocol Buffer実装と描画

## 背景と目的

現在、EQMonitorアプリケーションでは、地図データとしてGeoJSONを使用しています。しかし、GeoJSONはデータサイズが大きく、パフォーマンスに影響を与える可能性があります。TopoJSONは、GeoJSONよりもデータサイズが小さく、パフォーマンスが向上する可能性があります。

本ドキュメントでは、`utils/map_converter/data/geojson_shrinked/*.topojson`ファイルを利用して、TopoJSONデータをProtocol Bufferに格納し、CustomPainterでレンダリングする方法について説明します。

## TopoJSONの構造

TopoJSONは、以下のような構造になっています：

```json
{
  "type": "Topology",
  "objects": {
    "data": {
      "geometries": [
        {
          "properties": {
            "code": "120",
            "name": "オホーツク海沿岸",
            "namekana": "おほーつくかいえんがん"
          },
          "type": "MultiLineString",
          "arcs": [[0], [1], [2], [3], [4]],
          "id": "feature_00"
        },
        ...
      ]
    }
  },
  "arcs": [
    [[142.2267819464297, 45.28269527886408], [142.22877975348285, 45.282661225135485], ...],
    ...
  ]
}
```

TopoJSONの特徴は以下の通りです：
1. `type`フィールドが`Topology`である
2. `objects`フィールドにジオメトリオブジェクトが含まれる
3. `arcs`フィールドに座標データが含まれる
4. 座標データは差分エンコーディングされている場合がある

## Protocol Bufferの修正内容

`packages/jma_map/proto/jma_map.proto`ファイルに、TopoJSONデータを格納するための構造を追加します。

```protobuf
message JmaMap {
  repeated JmaMapData data = 1;
  repeated TopoJSONMapData topoJsonData = 2;

  // 既存のメッセージ定義...

  // TopoJSON関連のメッセージ定義
  message TopoJSONMapData {
    JmaMapData.JmaMapType mapType = 1;
    string name = 2; // "AreaForecastLocalE" など
    repeated TopoJSONGeometry geometries = 3;
    repeated TopoJSONArc arcs = 4;
    LatLngBounds bounds = 5; // 全体の境界ボックス
  }

  message TopoJSONGeometry {
    string type = 1; // "Polygon", "MultiPolygon" など
    repeated TopoJSONArcIndices arcIndices = 2; // ネストされた配列構造
    JmaMapData.JmaMapDataItem.Property property = 3; // 既存のPropertyを再利用
    LatLngBounds bounds = 4; // ジオメトリごとの境界ボックス
  }

  message TopoJSONArcIndices {
    repeated int32 indices = 1; // 単一のarcを参照するインデックスの配列
  }

  message TopoJSONArc {
    repeated LatLng positions = 1; // 既存のLatLngを再利用
    LatLngBounds bounds = 2; // アークごとの境界ボックス
  }
}
```

## データ読み込みの最適化

TopoJSONファイルは非常に大きいため（例：AreaTsunami.topojsonは385,289行）、全体を読み込むのではなく、先頭N行だけを読み込むようにします。

```dart
// TopoJSONファイルを読み込む関数
Future<String> readTopoJsonFile(String path, {int maxLines = 10000}) async {
  final file = File(path);
  final lines = await file.readAsLines();
  return lines.take(maxLines).join('\n');
}
```

また、必要な情報（geometriesとarcs）だけを抽出して、Protocol Bufferに格納します。

```dart
// TopoJSONデータをパースする関数
TopoJSONMapData parseTopoJson(String jsonString, JmaMapData.JmaMapType mapType, String name) {
  final json = jsonDecode(jsonString);
  final geometries = <TopoJSONGeometry>[];
  final arcs = <TopoJSONArc>[];

  // geometriesを抽出
  final jsonGeometries = json['objects']['data']['geometries'] as List;
  for (final jsonGeometry in jsonGeometries) {
    // geometryを抽出して、geometriesに追加
  }

  // arcsを抽出
  final jsonArcs = json['arcs'] as List;
  for (final jsonArc in jsonArcs) {
    // arcを抽出して、arcsに追加
  }

  return TopoJSONMapData(
    mapType: mapType,
    name: name,
    geometries: geometries,
    arcs: arcs,
    bounds: calculateBounds(arcs),
  );
}
```

## CustomPainterでのレンダリング

Protocol Bufferから読み込んだTopoJSONデータを使用して、CustomPainterでレンダリングします。

```dart
class TopoJSONPainter extends CustomPainter {
  final TopoJSONMapData topoJsonData;
  final Color color;
  final double strokeWidth;

  TopoJSONPainter({
    required this.topoJsonData,
    required this.color,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (final geometry in topoJsonData.geometries) {
      // 表示領域に含まれるジオメトリだけをレンダリング
      if (!isGeometryVisible(geometry, canvas, size)) {
        continue;
      }

      // ジオメトリのタイプに応じて、パスを描画
      if (geometry.type == 'LineString') {
        drawLineString(canvas, paint, geometry);
      } else if (geometry.type == 'MultiLineString') {
        drawMultiLineString(canvas, paint, geometry);
      } else if (geometry.type == 'Polygon') {
        drawPolygon(canvas, paint, geometry);
      } else if (geometry.type == 'MultiPolygon') {
        drawMultiPolygon(canvas, paint, geometry);
      }
    }
  }

  // LineStringを描画する関数
  void drawLineString(Canvas canvas, Paint paint, TopoJSONGeometry geometry) {
    final path = Path();
    final arcIndex = geometry.arcIndices[0].indices[0];
    final arc = topoJsonData.arcs[arcIndex];

    if (arc.positions.isEmpty) {
      return;
    }

    path.moveTo(arc.positions[0].lng, arc.positions[0].lat);
    for (int i = 1; i < arc.positions.length; i++) {
      path.lineTo(arc.positions[i].lng, arc.positions[i].lat);
    }

    canvas.drawPath(path, paint);
  }

  // MultiLineStringを描画する関数
  void drawMultiLineString(Canvas canvas, Paint paint, TopoJSONGeometry geometry) {
    for (final arcIndices in geometry.arcIndices) {
      for (final arcIndex in arcIndices.indices) {
        final arc = topoJsonData.arcs[arcIndex];
        final path = Path();

        if (arc.positions.isEmpty) {
          continue;
        }

        path.moveTo(arc.positions[0].lng, arc.positions[0].lat);
        for (int i = 1; i < arc.positions.length; i++) {
          path.lineTo(arc.positions[i].lng, arc.positions[i].lat);
        }

        canvas.drawPath(path, paint);
      }
    }
  }

  // Polygonを描画する関数
  void drawPolygon(Canvas canvas, Paint paint, TopoJSONGeometry geometry) {
    // Polygonの描画処理
  }

  // MultiPolygonを描画する関数
  void drawMultiPolygon(Canvas canvas, Paint paint, TopoJSONGeometry geometry) {
    // MultiPolygonの描画処理
  }

  // ジオメトリが表示領域に含まれるかどうかを判定する関数
  bool isGeometryVisible(TopoJSONGeometry geometry, Canvas canvas, Size size) {
    // 表示領域と境界ボックスの交差判定
    return true; // 仮の実装
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 仮の実装
  }
}
```

## パフォーマンス最適化

描画時には、表示領域に含まれるジオメトリだけをレンダリングします。境界ボックス（bounds）を使用して、表示領域外のジオメトリをスキップします。

```dart
// 境界ボックスを計算する関数
LatLngBounds calculateBounds(List<TopoJSONArc> arcs) {
  double minLat = double.infinity;
  double minLng = double.infinity;
  double maxLat = -double.infinity;
  double maxLng = -double.infinity;

  for (final arc in arcs) {
    for (final position in arc.positions) {
      minLat = min(minLat, position.lat);
      minLng = min(minLng, position.lng);
      maxLat = max(maxLat, position.lat);
      maxLng = max(maxLng, position.lng);
    }
  }

  return LatLngBounds(
    southwest: LatLng(lat: minLat, lng: minLng),
    northeast: LatLng(lat: maxLat, lng: maxLng),
  );
}

// 表示領域と境界ボックスの交差判定を行う関数
bool isIntersect(LatLngBounds bounds1, LatLngBounds bounds2) {
  return bounds1.southwest.lat <= bounds2.northeast.lat &&
         bounds1.northeast.lat >= bounds2.southwest.lat &&
         bounds1.southwest.lng <= bounds2.northeast.lng &&
         bounds1.northeast.lng >= bounds2.southwest.lng;
}
```

## 実装手順

1. `packages/jma_map/proto/jma_map.proto`ファイルを修正して、TopoJSONデータを格納するための構造を追加する
2. Protocol Bufferのコードを生成する
3. TopoJSONファイルを読み込み、Protocol Bufferに変換する処理を実装する
4. CustomPainterを実装して、TopoJSONデータをレンダリングする
5. パフォーマンス最適化を行う

## 注意事項

- TopoJSONファイルは非常に大きいため、メモリ使用量に注意する必要があります
- TopoJSONの座標データは差分エンコーディングされている場合があるため、デコード処理が必要になる場合があります
- CustomPainterでのレンダリングは、パフォーマンスに影響を与える可能性があるため、最適化が必要です
