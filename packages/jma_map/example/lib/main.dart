import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jma_map/jma_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TopoJSON Map Example',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        progressIndicatorTheme: ProgressIndicatorThemeData(year2023: false),
      ),
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
  JmaMap? _map;
  JmaMapController? _controller;

  @override
  void initState() {
    super.initState();
    _loadTopoJsonData();
  }

  void _loadTopoJsonData() async {
    // データのロード
    final data = await rootBundle.load('assets/jma_map_with_topojson.pb');
    final bytes = data.buffer.asUint8List();

    final map = JmaMap.fromBuffer(bytes);

    // コントローラーの作成
    final controller = JmaMapController(
      map: map,
      initialZoom: 5.0,
      initialCenter: JmaMap_LatLng(lat: 35.681236, lng: 139.767125), // 東京駅
    );

    // レイヤーの設定
    final layerHost = controller.layerHost;
    layerHost.layers = [
      // グリッドレイヤー
      GridLayer(
        latInterval: 5.0,
        lngInterval: 5.0,
        gridColor: const Color.fromRGBO(100, 100, 100, 0.5),
      ),
    ];

    setState(() {
      _map = map;
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TopoJSON Map Example')),
      body:
          _map == null
              ? const Center(child: CircularProgressIndicator())
              : JmaMapWidget(map: _map!, controller: _controller),
    );
  }
}
