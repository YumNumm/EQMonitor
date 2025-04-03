# TopoJSON描画サンプルアプリ実装計画

## 概要

`packages/jma_map/example`ディレクトリにFlutterアプリを作成し、TopoJSONデータを描画する機能を実装します。このサンプルアプリは、Protocol Bufferから読み込んだTopoJSONデータを`CustomPainter`を使用して描画し、境界ボックスを活用したパフォーマンス最適化を行います。

## ディレクトリ構造

```
packages/jma_map/example/
├── lib/
│   ├── main.dart                 # メインアプリケーション
│   ├── topojson_painter.dart     # TopoJSON描画用のCustomPainter
│   ├── topojson_provider.dart    # TopoJSONデータのプロバイダー
│   └── map_controller.dart       # 地図の操作（拡大・縮小・移動）を管理
├── assets/                       # アセットファイル
│   └── topojson/                 # TopoJSONファイル
├── pubspec.yaml                  # 依存関係の定義
└── analysis_options.yaml         # 静的解析の設定
```

## 主要コンポーネント

### 1. TopoJSONデータプロバイダー

TopoJSONデータを読み込み、Protocol Bufferから変換するプロバイダーを実装します。

```dart
// topojson_provider.dart
class TopoJSONProvider {
  // Protocol Bufferからデータを読み込む
  Future<TopoJSONMapData> loadTopoJSONData(JmaMapType mapType) async {
    // ...
  }

  // ズームレベルに応じたデータの最適化
  Future<TopoJSONMapData> optimizeForZoomLevel(
    TopoJSONMapData data,
    double zoomLevel
  ) async {
    // ...
  }
}
```

### 2. 地図コントローラー

地図の表示領域や操作（拡大・縮小・移動）を管理するコントローラーを実装します。

```dart
// map_controller.dart
class MapController {
  // 現在の表示領域
  LatLngBounds get visibleBounds => ...;

  // 現在のズームレベル
  double get zoomLevel => ...;

  // 地図の移動
  void panTo(LatLng center) {
    // ...
  }

  // 地図の拡大・縮小
  void zoomTo(double level) {
    // ...
  }

  // 表示領域と境界ボックスの交差判定
  bool isVisible(LatLngBounds bounds) {
    // ...
  }
}
```

### 3. TopoJSON描画用のCustomPainter

TopoJSONデータを描画するための`CustomPainter`を実装します。

```dart
// topojson_painter.dart
class TopoJSONPainter extends CustomPainter {
  final TopoJSONMapData data;
  final MapController controller;

  TopoJSONPainter({
    required this.data,
    required this.controller,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 表示領域外のジオメトリをスキップ
    for (final geometry in data.geometries) {
      if (!controller.isVisible(geometry.bounds)) {
        continue;
      }

      // ジオメトリの描画
      _drawGeometry(canvas, geometry);
    }
  }

  void _drawGeometry(Canvas canvas, TopoJSONGeometry geometry) {
    // arcIndicesを解析して、参照するarcsを特定
    // arcsから座標を取得
    // 座標を画面座標に変換
    // Pathオブジェクトを作成
    // Canvasに描画
  }

  @override
  bool shouldRepaint(TopoJSONPainter oldDelegate) {
    return data != oldDelegate.data ||
           controller != oldDelegate.controller;
  }
}
```

### 4. メインアプリケーション

サンプルアプリのメインコンポーネントを実装します。

```dart
// main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopoJSON Map Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _controller;
  late TopoJSONProvider _provider;
  TopoJSONMapData? _data;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
    _provider = TopoJSONProvider();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await _provider.loadTopoJSONData(JmaMapType.AREA_FORECAST_LOCAL_E);
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopoJSON Map Example'),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onPanUpdate: _handlePan,
              onScaleUpdate: _handleScale,
              child: CustomPaint(
                painter: TopoJSONPainter(
                  data: _data!,
                  controller: _controller,
                ),
                size: MediaQuery.of(context).size,
              ),
            ),
    );
  }

  void _handlePan(DragUpdateDetails details) {
    // 地図の移動処理
  }

  void _handleScale(ScaleUpdateDetails details) {
    // 地図の拡大・縮小処理
  }
}
```

## 実装手順

1. `packages/jma_map/example`ディレクトリを作成
2. 基本的なFlutterアプリの構造を設定
3. TopoJSONデータプロバイダーを実装
4. 地図コントローラーを実装
5. TopoJSON描画用のCustomPainterを実装
6. メインアプリケーションを実装
7. 動作確認とパフォーマンス最適化

## パフォーマンス最適化

1. **境界ボックスを活用した描画の最適化**
   - 表示領域外のジオメトリは描画をスキップ
   - 階層的なフィルタリングで効率的に画面外の要素を除外

2. **ズームレベルに応じたデータの最適化**
   - ズームレベルが低い場合は、簡略化されたジオメトリを使用
   - ズームレベルが高い場合は、詳細なジオメトリを使用

3. **描画キャッシュの活用**
   - 頻繁に再描画されるジオメトリはキャッシュを活用
   - `RepaintBoundary`を使用して再描画範囲を制限

## 将来の拡張性

1. **複数の地図タイプのサポート**
   - 異なるJmaMapTypeに対応した地図の切り替え機能

2. **インタラクティブな機能の追加**
   - 地域の選択と情報表示
   - 地域ごとの色分け表示

3. **アニメーション効果**
   - 地図の切り替え時のスムーズなトランジション
   - データ更新時の視覚的なフィードバック
