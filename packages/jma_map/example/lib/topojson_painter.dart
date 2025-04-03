import 'package:flutter/material.dart';
import 'package:jma_map/gen/jma_map.pb.dart';

import 'map_projection.dart';

/// TopoJSONを描画するためのCustomPainter
class TopoJSONPainter extends CustomPainter {
  /// TopoJSONデータ
  final JmaMap_TopoJSONMapData topoJsonData;

  /// 投影クラス
  final MapProjection projection;

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

  TopoJSONPainter({
    required this.topoJsonData,
    required this.projection,
    this.strokeColor = Colors.black,
    this.strokeWidth = 1.0,
    this.fillColor,
    this.selectedGeometryIndex,
    this.selectedColor = Colors.red,
    this.debugMode = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 描画領域をクリップ
    canvas.clipRect(Offset.zero & size);

    // ジオメトリを描画
    for (var i = 0; i < topoJsonData.geometries.length; i++) {
      final geometry = topoJsonData.geometries[i];
      final isSelected = selectedGeometryIndex == i;

      // 描画色を決定
      final color = isSelected ? selectedColor : fillColor;

      // ジオメトリのタイプに応じて描画
      switch (geometry.type) {
        case 'Polygon':
          _drawPolygon(canvas, geometry, color, isSelected);
          break;
        case 'MultiPolygon':
          _drawMultiPolygon(canvas, geometry, color, isSelected);
          break;
        default:
          // 未対応のジオメトリタイプ
          print('Unsupported geometry type: ${geometry.type}');
      }

      // デバッグモードの場合、境界ボックスを描画
      if (debugMode && geometry.hasBounds()) {
        _drawBoundingBox(canvas, geometry.bounds, Colors.blue);
      }
    }

    // デバッグモードの場合、全体の境界ボックスを描画
    if (debugMode && topoJsonData.hasBounds()) {
      _drawBoundingBox(canvas, topoJsonData.bounds, Colors.green);
    }
  }

  /// ポリゴンを描画
  void _drawPolygon(
    Canvas canvas,
    JmaMap_TopoJSONGeometry geometry,
    Color? fillColor,
    bool isSelected,
  ) {
    // アークインデックスからパスを構築
    for (final arcIndices in geometry.arcIndices) {
      final path = Path();
      var isFirst = true;

      for (final index in arcIndices.indices) {
        final arc = _getArc(index);
        if (arc.positions.isEmpty) continue;

        // アークの座標をスクリーン座標に変換
        final points =
            arc.positions.map((latLng) {
              return projection.latLngToScreen(
                latLng.lat,
                latLng.lng,
                canvas.getLocalClipBounds().size,
              );
            }).toList();

        // パスを構築
        if (isFirst) {
          path.moveTo(points.first.x, points.first.y);
          isFirst = false;
        }

        for (var i = 1; i < points.length; i++) {
          path.lineTo(points[i].x, points[i].y);
        }
      }

      // パスを閉じる
      path.close();

      // 塗りつぶし
      if (fillColor != null) {
        final paint =
            Paint()
              ..color = fillColor
              ..style = PaintingStyle.fill;
        canvas.drawPath(path, paint);
      }

      // 境界線
      final strokePaint =
          Paint()
            ..color = isSelected ? selectedColor : strokeColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = isSelected ? strokeWidth * 2 : strokeWidth;
      canvas.drawPath(path, strokePaint);
    }
  }

  /// マルチポリゴンを描画
  void _drawMultiPolygon(
    Canvas canvas,
    JmaMap_TopoJSONGeometry geometry,
    Color? fillColor,
    bool isSelected,
  ) {
    // マルチポリゴンは複数のポリゴンの集合
    for (final arcIndices in geometry.arcIndices) {
      final subGeometry =
          JmaMap_TopoJSONGeometry()
            ..type = 'Polygon'
            ..arcIndices.add(arcIndices);

      if (geometry.hasProperty()) {
        subGeometry.property = geometry.property;
      }

      if (geometry.hasBounds()) {
        subGeometry.bounds = geometry.bounds;
      }

      _drawPolygon(canvas, subGeometry, fillColor, isSelected);
    }
  }

  /// 境界ボックスを描画（デバッグ用）
  void _drawBoundingBox(
    Canvas canvas,
    JmaMap_LatLngBounds bounds,
    Color color,
  ) {
    final sw = projection.latLngToScreen(
      bounds.southWest.lat,
      bounds.southWest.lng,
      canvas.getLocalClipBounds().size,
    );
    final ne = projection.latLngToScreen(
      bounds.northEast.lat,
      bounds.northEast.lng,
      canvas.getLocalClipBounds().size,
    );

    final rect = Rect.fromPoints(Offset(sw.x, sw.y), Offset(ne.x, ne.y));

    final paint =
        Paint()
          ..color = color.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    canvas.drawRect(rect, paint);
  }

  /// インデックスからアークを取得（負のインデックスは逆順）
  JmaMap_TopoJSONArc _getArc(int index) {
    final absIndex = index.abs();
    if (absIndex >= topoJsonData.arcs.length) {
      return JmaMap_TopoJSONArc();
    }

    final arc = topoJsonData.arcs[absIndex];

    // 負のインデックスの場合、座標を逆順にする
    if (index < 0) {
      final reversedArc = JmaMap_TopoJSONArc();
      final positions = List<JmaMap_LatLng>.from(arc.positions.reversed);
      reversedArc.positions.addAll(positions);
      if (arc.hasBounds()) {
        reversedArc.bounds = arc.bounds;
      }
      return reversedArc;
    }

    return arc;
  }

  @override
  bool shouldRepaint(TopoJSONPainter oldDelegate) {
    return oldDelegate.topoJsonData != topoJsonData ||
        oldDelegate.projection != projection ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.selectedGeometryIndex != selectedGeometryIndex ||
        oldDelegate.selectedColor != selectedColor ||
        oldDelegate.debugMode != debugMode;
  }
}

/// Canvasの拡張メソッド
extension CanvasExtension on Canvas {
  /// ローカルクリップ領域を取得
  Rect getLocalClipBounds() {
    return Rect.fromLTWH(0, 0, 0, 0).inflate(10000);
  }
}
