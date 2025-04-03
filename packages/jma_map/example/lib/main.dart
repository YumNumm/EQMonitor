import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jma_map/gen/jma_map.pb.dart';

import 'interactive_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopoJSON Map Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  JmaMap_TopoJSONMapData? _topoJsonData;
  JmaMap_LatLngBounds? _viewport;
  bool _isLoading = true;
  String? _errorMessage;

  // 選択されたジオメトリのインデックス
  int? _selectedGeometryIndex;

  // デバッグモード
  bool _debugMode = false;

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

  Future<List<int>> _loadAsset(String assetPath) async {
    return (await rootBundle.load(assetPath)).buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TopoJSON Map Example')),
      body: _buildBody(),
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

    // InteractiveMapウィジェットを使用してTopoJSONを描画
    return Stack(
      children: [
        // インタラクティブマップ
        InteractiveMap(
          topoJsonData: _topoJsonData!,
          initialZoom: 5.0,
          strokeColor: Colors.black,
          strokeWidth: 1.0,
          fillColor: Colors.lightBlue.withOpacity(0.3),
          selectedGeometryIndex: _selectedGeometryIndex,
          selectedColor: Colors.red,
          debugMode: _debugMode,
          onGeometryTap: _handleGeometryTap,
        ),

        // 情報パネル（選択されたジオメトリの情報を表示）
        if (_selectedGeometryIndex != null &&
            _selectedGeometryIndex! < _topoJsonData!.geometries.length)
          _buildInfoPanel(_topoJsonData!.geometries[_selectedGeometryIndex!]),

        // デバッグモード切り替えボタン
        Positioned(
          left: 16,
          bottom: 16,
          child: FloatingActionButton(
            heroTag: 'debug',
            onPressed: () {
              setState(() {
                _debugMode = !_debugMode;
              });
            },
            child: Icon(
              _debugMode ? Icons.bug_report : Icons.bug_report_outlined,
            ),
          ),
        ),
      ],
    );
  }

  /// ジオメトリがタップされたときの処理
  void _handleGeometryTap(int index, JmaMap_TopoJSONGeometry geometry) {
    setState(() {
      // 同じジオメトリが選択された場合は選択解除
      if (_selectedGeometryIndex == index) {
        _selectedGeometryIndex = null;
      } else {
        _selectedGeometryIndex = index;
      }
    });
  }

  /// 情報パネルを構築
  Widget _buildInfoPanel(JmaMap_TopoJSONGeometry geometry) {
    // プロパティがない場合は何も表示しない
    if (!geometry.hasProperty()) {
      return const SizedBox.shrink();
    }

    final property = geometry.property;

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                property.hasName() ? property.name : '名称なし',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (property.hasCode())
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('コード: ${property.code}'),
                ),
              if (property.hasNameKana())
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('よみがな: ${property.nameKana}'),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('タイプ: ${geometry.type}'),
              ),
              if (geometry.hasBounds())
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '範囲: (${geometry.bounds.southWest.lat.toStringAsFixed(2)}, ${geometry.bounds.southWest.lng.toStringAsFixed(2)}) - '
                    '(${geometry.bounds.northEast.lat.toStringAsFixed(2)}, ${geometry.bounds.northEast.lng.toStringAsFixed(2)})',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
