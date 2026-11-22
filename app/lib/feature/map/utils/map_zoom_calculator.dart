import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

/// 日本全国の緯度経度範囲
class JapanBounds {
  /// 最小緯度（沖縄付近）
  static const double minLat = 24;

  /// 最大緯度（北海道付近）
  static const double maxLat = 46;

  /// 最小経度（与那国島付近）
  static const minLng = 122.5;

  /// 最大経度（北海道東端付近）
  static const double maxLng = 146;

  /// 中心緯度
  static const double centerLat = (minLat + maxLat) / 2;

  /// 中心経度
  static const double centerLng = (minLng + maxLng) / 2;

  /// 中心座標
  static const center = Geographic(lon: centerLng, lat: centerLat);
}

class const MapZoomCalculator() {
  /// 日本全国が映るMapOptionsを計算する
  MapOptions japanViewMapOptions({
    required BuildContext context,
    required String styleString,
    double padding = 0.9,
  }) {
    final size = MediaQuery.sizeOf(context);
    final zoom = calculate(
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
  double calculate({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required double screenWidth,
    required double screenHeight,
  }) {
    double mercY(double lat) {
      final latRad = lat * math.pi / 180.0;
      return math.log(math.tan(latRad / 2.0 + math.pi / 4.0));
    }

    var lngDelta = maxLng - minLng;
    if (lngDelta < 0) {
      lngDelta += 360;
    }

    final zoomX =
        math.log((screenWidth * 360.0) / (tileSize * lngDelta)) / math.ln2;

    final deltaMercY = math.max((mercY(maxLat) - mercY(minLat)).abs(), 1e-12);

    final zoomY =
        math.log((screenHeight * 2 * math.pi) / (tileSize * deltaMercY)) /
        math.ln2;

    return math.min(zoomX, zoomY);
  }

  /// MapLibre の zoom は 512px タイル基準（MapLibre Native の `util::tileSize_D`）。
  static const tileSize = 512.0;
}
