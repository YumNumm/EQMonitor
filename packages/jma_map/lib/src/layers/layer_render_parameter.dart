import 'package:flutter/material.dart';
import 'package:jma_map/gen/jma_map.pb.dart';

/// レイヤー描画に必要なパラメータを保持するクラス
/// C#の`LayerRenderParameter`に相当
class LayerRenderParameter {
  /// 現在のズームレベル
  final double zoom;

  /// 画面左上の地理座標
  final JmaMap_LatLng leftTopLocation;

  /// 画面左上のピクセル座標
  final Offset leftTopPixel;

  /// 画面のピクセル境界
  final Rect pixelBound;

  /// 表示領域の地理座標境界
  final Rect viewAreaRect;

  /// パディング
  final EdgeInsets padding;

  /// コンストラクタ
  const LayerRenderParameter({
    required this.zoom,
    required this.leftTopLocation,
    required this.leftTopPixel,
    required this.pixelBound,
    required this.viewAreaRect,
    required this.padding,
  });
}
