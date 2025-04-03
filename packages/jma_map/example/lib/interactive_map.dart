import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jma_map/gen/jma_map.pb.dart';

import 'map_projection.dart';
import 'topojson_painter.dart';

/// インタラクティブなTopoJSONマップウィジェット
class InteractiveMap extends StatefulWidget {
  /// TopoJSONデータ
  final JmaMap_TopoJSONMapData topoJsonData;

  /// 初期ズームレベル
  final double initialZoom;

  /// 初期中心座標（緯度・経度）
  final Point<double>? initialCenter;

  /// 境界線の色
  final Color strokeColor;

  /// 境界線の太さ
  final double strokeWidth;

  /// 塗りつぶしの色
  final Color? fillColor;

  /// 選択されたジオメトリのインデックス
  final int? selectedGeometryIndex;

  /// 選択されたジオメトリの色
  final Color selectedColor;

  /// デバッグモード（境界ボックスを表示）
  final bool debugMode;

  /// ジオメトリがタップされたときのコールバック
  final void Function(int index, JmaMap_TopoJSONGeometry geometry)?
  onGeometryTap;

  const InteractiveMap({
    super.key,
    required this.topoJsonData,
    this.initialZoom = 5.0,
    this.initialCenter,
    this.strokeColor = Colors.black,
    this.strokeWidth = 1.0,
    this.fillColor,
    this.selectedGeometryIndex,
    this.selectedColor = Colors.red,
    this.debugMode = false,
    this.onGeometryTap,
  });

  @override
  _InteractiveMapState createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  /// 投影クラス
  late MapProjection _projection;

  /// 前回のスケール（ピンチジェスチャー用）
  double _lastScale = 1.0;

  /// 前回の回転角（回転ジェスチャー用）
  double _lastRotation = 0.0;

  @override
  void initState() {
    super.initState();

    // 初期中心座標が指定されていない場合は、TopoJSONデータの境界ボックスの中心を使用
    Point<double>? center;
    if (widget.initialCenter == null && widget.topoJsonData.hasBounds()) {
      final bounds = widget.topoJsonData.bounds;
      final lat = (bounds.northEast.lat + bounds.southWest.lat) / 2;
      final lng = (bounds.northEast.lng + bounds.southWest.lng) / 2;
      center = Point(lng, lat);
    } else {
      center = widget.initialCenter;
    }

    // 投影クラスを初期化
    _projection = MapProjection(zoomLevel: widget.initialZoom, center: center);
  }

  @override
  void didUpdateWidget(InteractiveMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    // TopoJSONデータが変更された場合、中心座標を再設定
    if (oldWidget.topoJsonData != widget.topoJsonData &&
        widget.initialCenter == null &&
        widget.topoJsonData.hasBounds()) {
      final bounds = widget.topoJsonData.bounds;
      final lat = (bounds.northEast.lat + bounds.southWest.lat) / 2;
      final lng = (bounds.northEast.lng + bounds.southWest.lng) / 2;
      setState(() {
        _projection.center = Point(lng, lat);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // すべてのジェスチャー（パン、ズーム、回転）をScaleGestureDetectorで処理
      onScaleStart: (details) {
        _lastScale = 1.0;
        _lastRotation = 0.0;
      },
      onScaleUpdate: (details) {
        setState(() {
          // パン処理
          // details.scale == 1.0 かつ details.rotation == 0.0 の場合はパンと判断
          if (details.scale == 1.0 && details.rotation == 0.0) {
            _projection.panBy(
              details.focalPointDelta.dx,
              details.focalPointDelta.dy,
              MediaQuery.of(context).size,
            );
          }

          // ズーム処理
          if (details.scale != 1.0) {
            final scaleFactor = details.scale / _lastScale;
            if (scaleFactor > 1.0) {
              _projection.zoomIn(0.05);
            } else if (scaleFactor < 1.0) {
              _projection.zoomOut(0.05);
            }
            _lastScale = details.scale;
          }

          // 回転処理
          if (details.rotation != 0.0) {
            final rotationDelta = details.rotation - _lastRotation;
            if (rotationDelta.abs() > 0.01) {
              _projection.rotate(rotationDelta);
            }
            _lastRotation = details.rotation;
          }
        });
      },
      onScaleEnd: (details) {
        // スケールジェスチャーの終了処理（必要に応じて）
      },

      // ダブルタップ（ズームイン）
      onDoubleTap: () {
        setState(() {
          _projection.zoomIn(0.5);
        });
      },

      // タップ（ジオメトリ選択）
      onTapUp: (details) {
        if (widget.onGeometryTap != null) {
          _handleTap(details.localPosition);
        }
      },

      child: CustomPaint(
        painter: TopoJSONPainter(
          topoJsonData: widget.topoJsonData,
          projection: _projection,
          strokeColor: widget.strokeColor,
          strokeWidth: widget.strokeWidth,
          fillColor: widget.fillColor,
          selectedGeometryIndex: widget.selectedGeometryIndex,
          selectedColor: widget.selectedColor,
          debugMode: widget.debugMode,
        ),
        child: Container(),
      ),
    );
  }

  /// タップ位置からジオメトリを検出
  void _handleTap(Offset position) {
    final size = MediaQuery.of(context).size;
    final latLng = _projection.screenToLatLng(position.dx, position.dy, size);

    // タップされた座標を含むジオメトリを検索
    for (var i = 0; i < widget.topoJsonData.geometries.length; i++) {
      final geometry = widget.topoJsonData.geometries[i];

      // 境界ボックスで簡易判定
      if (geometry.hasBounds()) {
        final bounds = geometry.bounds;
        if (latLng.x >= bounds.southWest.lng &&
            latLng.x <= bounds.northEast.lng &&
            latLng.y >= bounds.southWest.lat &&
            latLng.y <= bounds.northEast.lat) {
          // より詳細な判定（ポリゴン内部かどうか）は省略
          // 実際のアプリケーションでは、ポイントインポリゴンアルゴリズムを実装する必要がある

          widget.onGeometryTap?.call(i, geometry);
          return;
        }
      }
    }
  }
}

/// マップコントロールウィジェット
class MapControls extends StatelessWidget {
  /// 投影クラス
  final MapProjection projection;

  /// コントロールの位置
  final Alignment alignment;

  /// コントロールの背景色
  final Color backgroundColor;

  /// コントロールのアイコン色
  final Color iconColor;

  /// 状態を更新するコールバック
  final VoidCallback onUpdate;

  const MapControls({
    super.key,
    required this.projection,
    required this.onUpdate,
    this.alignment = Alignment.topRight,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ズームイン
            _buildControlButton(
              icon: Icons.add,
              onPressed: () {
                projection.zoomIn(0.5);
                onUpdate();
              },
            ),
            const Divider(height: 1),
            // ズームアウト
            _buildControlButton(
              icon: Icons.remove,
              onPressed: () {
                projection.zoomOut(0.5);
                onUpdate();
              },
            ),
            const Divider(height: 1),
            // 回転リセット
            _buildControlButton(
              icon: Icons.refresh,
              onPressed: () {
                projection.rotation = 0.0;
                onUpdate();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// コントロールボタンを構築
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}
