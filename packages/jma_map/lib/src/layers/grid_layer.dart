import 'package:flutter/material.dart';
import 'package:jma_map/src/layers/layer_render_parameter.dart';
import 'package:jma_map/src/layers/map_layer.dart';
import 'package:jma_map/src/utils/math_utils.dart';

/// 緯度経度のグリッド線を描画するレイヤー
/// C#の`GridLayer`に相当
class GridLayer extends MapLayer {
  /// グリッド線の間隔（緯度）
  final double latInterval;

  /// グリッド線の間隔（経度）
  final double lngInterval;

  /// グリッド線の色
  final Color gridColor;

  /// グリッド線の太さ
  final double gridStrokeWidth;

  /// テキストのサイズ
  final double textSize;

  /// グリッド線の描画に使用するペイント
  late Paint _gridPaint;

  /// テキストの描画に使用するペイント
  late TextPainter _textPainter;

  /// コンストラクタ
  GridLayer({
    this.latInterval = 5.0,
    this.lngInterval = 5.0,
    this.gridColor = const Color.fromRGBO(100, 100, 100, 0.5),
    this.gridStrokeWidth = 1.0,
    this.textSize = 12.0,
  }) {
    _gridPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = gridStrokeWidth
          ..color = gridColor;

    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
  }

  @override
  bool get needPersistentUpdate => false;

  @override
  void refreshResourceCache() {
    // リソースの更新が必要な場合はここで実装
  }

  @override
  void render(Canvas canvas, LayerRenderParameter param, bool isAnimating) {
    // 緯度線の描画
    _renderLatitudeLines(canvas, param);

    // 経度線の描画
    _renderLongitudeLines(canvas, param);
  }

  /// 緯度線を描画
  void _renderLatitudeLines(Canvas canvas, LayerRenderParameter param) {
    // 表示領域の左端の緯度を、間隔に合わせて切り捨てる
    final origin =
        param.viewAreaRect.left - (param.viewAreaRect.left % latInterval);
    // 表示領域内に描画する緯度線の数
    final count = (param.viewAreaRect.width / latInterval).ceil() + 1;

    for (var i = 0; i < count; i++) {
      final lat = origin + latInterval * i;
      // 緯度が範囲外の場合はスキップ
      if (lat.abs() > 90) continue;

      // 緯度線の座標を計算
      final pixelsPerLongitude = 256.0 * pow(2, param.zoom) / 360.0;
      final x = (lat - param.leftTopLocation.lat) * pixelsPerLongitude;

      // 緯度線を描画
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, param.pixelBound.height),
        _gridPaint,
      );

      // 緯度のテキストを描画
      _drawText(canvas, lat.toStringAsFixed(1), Offset(x, param.padding.top));
    }
  }

  /// 経度線を描画
  void _renderLongitudeLines(Canvas canvas, LayerRenderParameter param) {
    // 表示領域の上端の経度を、間隔に合わせて切り捨てる
    final origin =
        param.viewAreaRect.top - (param.viewAreaRect.top % lngInterval);
    // 表示領域内に描画する経度線の数
    final count = (param.viewAreaRect.height / lngInterval).ceil() + 1;

    for (var i = 0; i < count; i++) {
      var lng = origin + lngInterval * i;
      // 経度が範囲外の場合は補正
      if (lng > 180) lng -= 360;
      if (lng < -180) lng += 360;

      // 経度線の座標を計算
      final pixelsPerLatitude = 256.0 * pow(2, param.zoom) / 170.0;
      final y = (lng - param.leftTopLocation.lng) * pixelsPerLatitude;

      // 経度線を描画
      canvas.drawLine(
        Offset(0, y),
        Offset(param.pixelBound.width, y),
        _gridPaint,
      );

      // 経度のテキストを描画
      _drawText(canvas, lng.toStringAsFixed(1), Offset(param.padding.left, y));
    }
  }

  /// テキストを描画
  void _drawText(Canvas canvas, String text, Offset position) {
    _textPainter.text = TextSpan(
      text: text,
      style: TextStyle(color: gridColor, fontSize: textSize),
    );
    _textPainter.layout();
    _textPainter.paint(canvas, position);
  }
}
