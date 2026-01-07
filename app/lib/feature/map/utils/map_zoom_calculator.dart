import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

/// 日本全国の緯度経度範囲
class JapanBounds {
  /// 最小緯度（沖縄付近）
  static const double minLat = 24;

  /// 最大緯度（北海道付近）
  static const double maxLat = 46;

  /// 最小経度（与那国島付近）
  static const double minLng = 122.5;

  /// 最大経度（北海道東端付近）
  static const double maxLng = 146;

  /// 中心緯度
  static const double centerLat = (minLat + maxLat) / 2;

  /// 中心経度
  static const double centerLng = (minLng + maxLng) / 2;

  /// 中心座標
  static const center = Geographic(
    lon: centerLng,
    lat: centerLat,
  );
}

/// 日本全国が映るMapOptionsを計算する
MapOptions calculateJapanViewMapOptions({
  required BuildContext context,
  required String styleString,
  double padding = 0.9,
}) {
  final size = MediaQuery.of(context).size;
  final zoom = calculateZoomLevel(
    minLat: JapanBounds.minLat,
    maxLat: JapanBounds.maxLat,
    minLng: JapanBounds.minLng,
    maxLng: JapanBounds.maxLng,
    screenWidth: size.width,
    screenHeight: size.height,
  );

  // paddingを考慮してズームレベルを調整
  final adjustedZoom = zoom + math.log(padding) / math.ln2;

  return MapOptions(
    initCenter: const Geographic(
      lon: JapanBounds.centerLng,
      lat: JapanBounds.centerLat,
    ),
    initZoom: adjustedZoom,
    initStyle: styleString,
  );
}

/// 指定された緯度経度範囲が画面に収まるズームレベルを計算する
///
/// Web Mercator投影を使用して、経度方向と緯度方向のそれぞれから
/// 必要なズームレベルを計算し、両方を満たす最小値を返す。
@visibleForTesting
double calculateZoomLevel({
  required double minLat,
  required double maxLat,
  required double minLng,
  required double maxLng,
  required double screenWidth,
  required double screenHeight,
}) {
  // Web Mercator投影のY座標を計算する関数
  // 緯度は等角円筒図法により対数関数で変換される
  double mercY(double lat) {
    final latRad = lat * math.pi / 180.0;
    return math.log(math.tan(latRad / 2.0 + math.pi / 4.0));
  }

  // 【経度方向のズームレベル計算】
  // Web Mercatorでは、経度は線形にマッピングされる
  // - ズームレベルZでのタイル1枚の幅: 256ピクセル
  // - 世界全体の幅: 256 * 2^Z ピクセル
  // - 経度360度が 256 * 2^Z ピクセルに対応
  //
  // 表示したい経度範囲(maxLng - minLng)が画面幅に収まる条件:
  //   (maxLng - minLng) / 360 * 256 * 2^Z ≤ screenWidth
  //
  // これを変形して:
  //   2^Z ≤ (screenWidth * 360) / (256 * (maxLng - minLng))
  //   Z ≤ log2((screenWidth * 360) / (256 * (maxLng - minLng)))

  var lngDelta = maxLng - minLng;
  if (lngDelta < 0) {
    lngDelta += 360; // 国際日付変更線を跨ぐ場合の補正
  }

  final zoomX =
      math.log((screenWidth * 360.0) / (256.0 * lngDelta)) / math.log(2);

  // 【緯度方向のズームレベル計算】
  // Web Mercatorでは、緯度は対数関数でマッピングされる
  // - mercY関数で緯度をMercator Y座標に変換
  // - Mercator Y座標の全体範囲は約 [-π, π] (緯度±85度付近)
  // - ズームレベルZでの世界全体の高さ: 256 * 2^Z ピクセル
  //
  // 2つの緯度のMercator Y座標差をΔmercとすると、
  // 画面上のピクセル差は:
  //   ΔpixelY = 256 * 2^Z * (Δmerc / (2π))
  //
  // これが画面高さに収まる条件:
  //   256 * 2^Z * (Δmerc / (2π)) ≤ screenHeight
  //
  // これを変形して:
  //   2^Z ≤ (screenHeight * 2π) / (256 * Δmerc)
  //   Z ≤ log2((screenHeight * 2π) / (256 * Δmerc))

  final mercYMax = mercY(maxLat);
  final mercYMin = mercY(minLat);
  var deltaMercY = (mercYMax - mercYMin).abs();

  if (deltaMercY < 1e-12) {
    // 緯度差が極小の場合、ゼロ除算を防ぐため最小値を設定
    deltaMercY = 1e-12;
  }

  final zoomY =
      math.log((screenHeight * 2 * math.pi) / (256.0 * deltaMercY)) /
      math.log(2);

  // 経度方向と緯度方向の両方が画面に収まるように、小さい方のズームレベルを採用
  return math.min(zoomX, zoomY);
}
