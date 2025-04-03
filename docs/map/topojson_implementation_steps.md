# TopoJSONを利用した地図描画の実装方針

## 概要

本ドキュメントでは、`utils/map_converter/data/geojson_shrinked/*.topojson`を利用して地図を描画するための実装方針について説明します。外部ライブラリを利用せずに、CustomPainterを使用してTopoJSONデータをレンダリングする方法を示します。

## 実装ステップ

### 1. Protocol Bufferの拡張

TopoJSONデータを格納するために、Protocol Bufferの定義を拡張しました。`packages/jma_map/proto/jma_map.proto`に以下のメッセージを追加しました：

```protobuf
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
```

これにより、TopoJSONデータの構造をそのままProtocol Bufferに格納できるようになりました。

### 2. TopoJSONデータの変換

TopoJSONデータをProtocol Bufferに変換するスクリプト`packages/jma_map/bin/convert_topojson.dart`を作成しました。このスクリプトは以下の処理を行います：

1. TopoJSONファイルを読み込む
2. TopoJSONデータをパースしてProtocol Bufferに変換する
3. Protocol Bufferをバイナリ形式で保存する

```dart
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

    // TopoJSONファイルを読み込む
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
  await File(jsonOutputPath).writeAsString(
    jsonEncode(existingJmaMap.toProto3Json()),
  );

  print('Conversion completed. Output: $outputPath, $jsonOutputPath');
}
```

### 3. CustomPainterの実装

TopoJSONデータをレンダリングするためのCustomPainter`TopoJSONPainter`を実装しました。このCustomPainterは以下の機能を持ちます：

1. TopoJSONデータを描画する
2. 表示領域（ビューポート）を指定して、その範囲内のデータのみを描画する
3. ズームレベルを指定して、データのスケールを調整する
4. 選択されたジオメトリを強調表示する

```dart
class TopoJSONPainter extends CustomPainter {
  final JmaMap_TopoJSONMapData topoJsonData;
  final JmaMap_LatLngBounds viewport;
  final double zoomLevel;
  final Color strokeColor;
  final double strokeWidth;
  final Color? fillColor;
  final int? selectedGeometryIndex;
  final Color selectedColor;

  TopoJSONPainter({
    required this.topoJsonData,
    required this.viewport,
    this.zoomLevel = 1.0,
    this.strokeColor = Colors.black,
    this.strokeWidth = 1.0,
    this.fillColor,
    this.selectedGeometryIndex,
    this.selectedColor = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 表示領域の計算
    final viewportWidth = viewport.northEast.lng - viewport.southWest.lng;
    final viewportHeight = viewport.northEast.lat - viewport.southWest.lat;

    // 座標変換関数
    final transformLatLng = (JmaMap_LatLng latLng) {
      final x = (latLng.lng - viewport.southWest.lng) / viewportWidth * size.width;
      final y = size.height - (latLng.lat - viewport.southWest.lat) / viewportHeight * size.height;
      return Offset(x, y);
    };

    // 境界ボックスが表示領域と交差するかどうかを判定する関数
    final isIntersect = (JmaMap_LatLngBounds bounds) {
      return bounds.southWest.lat <= viewport.northEast.lat &&
             bounds.northEast.lat >= viewport.southWest.lat &&
             bounds.southWest.lng <= viewport.northEast.lng &&
             bounds.northEast.lng >= viewport.southWest.lng;
    };

    // 描画用のペイント
    final strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = fillColor ?? Colors.transparent
      ..style = PaintingStyle.fill;

    final selectedPaint = Paint()
      ..color = selectedColor
      ..strokeWidth = strokeWidth * 2
      ..style = PaintingStyle.stroke;

    // 各ジオメトリを描画
    for (int i = 0; i < topoJsonData.geometries.length; i++) {
      final geometry = topoJsonData.geometries[i];

      // 表示領域外のジオメトリはスキップ
      if (!isIntersect(geometry.bounds)) {
        continue;
      }

      // 選択されたジオメトリかどうか
      final isSelected = selectedGeometryIndex == i;

      // ジオメトリのタイプに応じて描画
      switch (geometry.type) {
        case 'LineString':
          drawLineString(canvas, isSelected ? selectedPaint : strokePaint, geometry, transformLatLng);
          break;
        case 'MultiLineString':
          drawMultiLineString(canvas, isSelected ? selectedPaint : strokePaint, geometry, transformLatLng);
          break;
        case 'Polygon':
          drawPolygon(canvas, isSelected ? selectedPaint : strokePaint, fillPaint, geometry, transformLatLng);
          break;
        case 'MultiPolygon':
          drawMultiPolygon(canvas, isSelected ? selectedPaint : strokePaint, fillPaint, geometry, transformLatLng);
          break;
      }
    }
  }

  // 各ジオメトリタイプの描画メソッド（省略）

  @override
  bool shouldRepaint(covariant TopoJSONPainter oldDelegate) {
    return topoJsonData != oldDelegate.topoJsonData ||
           viewport != oldDelegate.viewport ||
           zoomLevel != oldDelegate.zoomLevel ||
           strokeColor != oldDelegate.strokeColor ||
           strokeWidth != oldDelegate.strokeWidth ||
           fillColor != oldDelegate.fillColor ||
           selectedGeometryIndex != oldDelegate.selectedGeometryIndex ||
           selectedColor != oldDelegate.selectedColor;
  }
}
```

### 4. インタラクティブな地図ウィジェットの実装

TopoJSONデータを表示し、ユーザーがインタラクティブに操作できるウィジェット`InteractiveTopoJSONMap`を実装しました。このウィジェットは以下の機能を持ちます：

1. TopoJSONデータを表示する
2. パン操作で地図を移動する
3. ピンチ操作で地図をズームする
4. タップ操作でジオメトリを選択する

```dart
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  JmaMap_TopoJSONMapData? _topoJsonData;
  JmaMap_LatLngBounds? _viewport;
  final TransformationController _transformationController = TransformationController();
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  int? _selectedGeometryIndex;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTopoJsonData();
  }

  Future<void> _loadTopoJsonData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // アセットからProtocol Bufferファイルを読み込む
      final data = await _loadAsset('assets/jma_map_with_topojson.pb');
      final jmaMap = JmaMap.fromBuffer(data);

      if (jmaMap.topoJsonData.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'TopoJSONデータが見つかりませんでした。';
        });
        return;
      }

      // 最初のTopoJSONデータを取得
      final topoJsonData = jmaMap.topoJsonData[0];

      // 表示領域を設定
      final viewport = topoJsonData.bounds;

      setState(() {
        _topoJsonData = topoJsonData;
        _viewport = viewport;
        _resetTransformation();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'データの読み込みに失敗しました: $e';
      });
      print('Error loading TopoJSON data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopoJSON Map Example'),
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_topoJsonData == null || _viewport == null) {
      return const Center(child: Text('データが読み込まれていません。'));
    }

    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: 0.1,
      maxScale: 10.0,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      onInteractionEnd: (details) {
        // 変換行列から現在のスケールとオフセットを取得
        final matrix = _transformationController.value;
        _scale = math.sqrt(matrix.getMaxScaleOnAxis());
        _offset = Offset(matrix.getTranslation().x, matrix.getTranslation().y);

        // ビューポートを更新
        _updateViewport();
      },
      child: GestureDetector(
        onTapDown: _handleTapDown,
        child: CustomPaint(
          painter: TopoJSONPainter(
            topoJsonData: _topoJsonData!,
            viewport: _viewport!,
            zoomLevel: _scale,
            strokeColor: Colors.blue,
            strokeWidth: 1.0,
            fillColor: Colors.blue.withOpacity(0.2),
            selectedGeometryIndex: _selectedGeometryIndex,
            selectedColor: Colors.red,
          ),
          size: MediaQuery.of(context).size,
        ),
      ),
    );
  }

  // その他のメソッド（省略）
}
```

## 利点

この実装方針には以下の利点があります：

1. **効率的なデータ格納**: TopoJSONデータをProtocol Bufferに変換することで、データサイズを削減し、読み込み速度を向上させることができます。

2. **カスタマイズ性**: 外部ライブラリを使用せずにCustomPainterを実装することで、描画方法を完全にカスタマイズできます。

3. **パフォーマンス**: 表示領域内のデータのみを描画することで、パフォーマンスを向上させることができます。

4. **インタラクティブ性**: InteractiveViewerを使用することで、パン、ズーム、タップなどのインタラクティブな操作を簡単に実装できます。

## 今後の課題

1. **パフォーマンスの最適化**: 大量のデータを描画する場合、パフォーマンスが低下する可能性があります。キャッシュやレンダリングの最適化を検討する必要があります。

2. **スタイリングの拡張**: 現在は基本的なスタイリングのみをサポートしていますが、より高度なスタイリング（グラデーション、パターン、テキストラベルなど）をサポートすることで、より豊かな地図表現が可能になります。

3. **インタラクションの拡張**: 現在はタップ操作でジオメトリを選択する機能のみをサポートしていますが、ドラッグ、長押し、ダブルタップなどの追加のインタラクションをサポートすることで、より豊かなユーザー体験を提供できます。
