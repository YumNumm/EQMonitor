import 'package:flutter/material.dart';
import 'package:jma_map/gen/jma_map.pb.dart';
import 'package:jma_map/src/jma_map_controller.dart';
import 'package:jma_map/src/layers/layer_render_parameter.dart';
import 'package:jma_map/src/utils/math_utils.dart';

/// 地図を描画するウィジェット
class JmaMapWidget extends StatefulWidget {
  /// 地図データ
  final JmaMap map;

  /// 初期ズームレベル
  final double initialZoom;

  /// 初期中心位置
  final JmaMap_LatLng? initialCenter;

  /// コントローラー
  final JmaMapController? controller;

  /// コンストラクタ
  const JmaMapWidget({
    Key? key,
    required this.map,
    this.initialZoom = 5.0,
    this.initialCenter,
    this.controller,
  }) : super(key: key);

  @override
  State<JmaMapWidget> createState() => _JmaMapWidgetState();
}

class _JmaMapWidgetState extends State<JmaMapWidget> {
  /// コントローラー
  late JmaMapController _controller;

  /// 前回の描画時間
  DateTime? _lastRenderTime;

  /// 描画が必要かどうか
  bool _needsRender = true;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        JmaMapController(
          map: widget.map,
          initialZoom: widget.initialZoom,
          initialCenter: widget.initialCenter,
        );
    _controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(JmaMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onControllerChanged);
      _controller =
          widget.controller ??
          JmaMapController(
            map: widget.map,
            initialZoom: widget.initialZoom,
            initialCenter: widget.initialCenter,
          );
      _controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      // 外部から提供されたコントローラーでない場合は破棄
      // _controller.dispose();
    }
    super.dispose();
  }

  /// コントローラーの状態が変更されたときのコールバック
  void _onControllerChanged() {
    setState(() {
      _needsRender = true;
    });
  }

  /// ジェスチャーによるズーム処理
  void _handleScaleStart(ScaleStartDetails details) {
    // スケール開始時の処理
  }

  /// ジェスチャーによるズーム処理
  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      // ズーム処理
      final newZoom = _controller.zoom * details.scale;
      _controller.zoom = newZoom.clamp(1.0, 18.0); // ズームレベルの制限
    }

    if (details.focalPointDelta.distance > 0) {
      // パン処理
      // 画面の移動量を地理座標の移動量に変換
      final pixelsPerLongitude = 256.0 * pow(2, _controller.zoom) / 360.0;
      final pixelsPerLatitude = 256.0 * pow(2, _controller.zoom) / 170.0;

      final deltaLng = -details.focalPointDelta.dx / pixelsPerLongitude;
      final deltaLat = details.focalPointDelta.dy / pixelsPerLatitude;

      final newLat = _controller.center.lat + deltaLat;
      final newLng = _controller.center.lng + deltaLng;

      _controller.center = JmaMap_LatLng(
        lat: newLat.clamp(-85.0, 85.0), // 緯度の制限
        lng: newLng,
      );
    }
  }

  /// ジェスチャーによるズーム処理
  void _handleScaleEnd(ScaleEndDetails details) {
    // スケール終了時の処理
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      child: CustomPaint(
        painter: _JmaMapPainter(
          controller: _controller,
          onNeedsRender: (needsRender) {
            if (needsRender) {
              // 連続描画が必要な場合
              setState(() {
                _needsRender = true;
              });
            }
          },
        ),
        size: Size.infinite,
      ),
    );
  }
}

/// 地図を描画するカスタムペインター
class _JmaMapPainter extends CustomPainter {
  /// コントローラー
  final JmaMapController controller;

  /// 描画が必要になったときのコールバック
  final ValueChanged<bool> onNeedsRender;

  /// コンストラクタ
  _JmaMapPainter({required this.controller, required this.onNeedsRender});

  @override
  void paint(Canvas canvas, Size size) {
    // 描画パラメータの作成
    final zoom = controller.zoom;
    final center = controller.center;

    // 画面の左上の座標を計算
    final pixelsPerLongitude = 256.0 * pow(2, zoom) / 360.0;
    final pixelsPerLatitude = 256.0 * pow(2, zoom) / 170.0;

    final centerPixelX = center.lng * pixelsPerLongitude;
    final centerPixelY = center.lat * pixelsPerLatitude;

    final leftTopPixelX = centerPixelX - size.width / 2;
    final leftTopPixelY = centerPixelY - size.height / 2;

    final leftTopLng = leftTopPixelX / pixelsPerLongitude;
    final leftTopLat = leftTopPixelY / pixelsPerLatitude;

    final leftTopLocation = JmaMap_LatLng(lat: leftTopLat, lng: leftTopLng);

    final leftTopPixel = Offset(leftTopPixelX, leftTopPixelY);

    final pixelBound = Rect.fromLTWH(0, 0, size.width, size.height);

    final viewAreaWidth = size.width / pixelsPerLongitude;
    final viewAreaHeight = size.height / pixelsPerLatitude;

    final viewAreaRect = Rect.fromLTWH(
      leftTopLng,
      leftTopLat,
      viewAreaWidth,
      viewAreaHeight,
    );

    final param = LayerRenderParameter(
      zoom: zoom,
      leftTopLocation: leftTopLocation,
      leftTopPixel: leftTopPixel,
      pixelBound: pixelBound,
      viewAreaRect: viewAreaRect,
      padding: EdgeInsets.zero,
    );

    // レイヤーの描画
    final needPersistentUpdate = controller.layerHost.render(
      canvas,
      param,
      false,
    );

    // 連続描画が必要な場合はコールバックを呼び出す
    onNeedsRender(needPersistentUpdate);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 常に再描画
  }
}
