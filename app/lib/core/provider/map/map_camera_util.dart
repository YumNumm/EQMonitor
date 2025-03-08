import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// 地図表示に関するユーティリティクラス
class MapCameraUtil {
  MapCameraUtil._();

  /// 緯度経度の矩形と画面サイズから適切なカメラポジションを計算する
  ///
  /// [bounds] 表示したい緯度経度の矩形
  /// [screenWidth] 画面の幅（ピクセル）
  /// [screenHeight] 画面の高さ（ピクセル）
  /// [padding] 矩形の周囲に追加する余白（ピクセル）
  static CameraPosition getCameraPositionForBounds({
    required LatLngBounds bounds,
    required double screenWidth,
    required double screenHeight,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    // 有効な画面サイズを計算（パディングを考慮）
    final availableWidth = screenWidth - padding.left - padding.right;
    final availableHeight = screenHeight - padding.top - padding.bottom;

    // 中心座標を計算
    final center = LatLng(
      (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
      (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
    );

    // 緯度経度の範囲を計算
    final latDelta =
        (bounds.northeast.latitude - bounds.southwest.latitude).abs();
    final lngDelta =
        (bounds.northeast.longitude - bounds.southwest.longitude).abs();

    // 経度方向の距離を調整（緯度によって経度の実距離は変わる）
    final lngCorrectionFactor = cos(center.latitude * pi / 180);
    final correctedLngDelta = lngDelta * lngCorrectionFactor;

    // 画面のアスペクト比
    final screenRatio = availableWidth / availableHeight;

    // 緯度経度のアスペクト比
    final boundsRatio = correctedLngDelta / latDelta;

    // ズームレベルを計算
    double zoom;
    if (boundsRatio > screenRatio) {
      // 横長の地図範囲の場合、経度範囲に基づいてズーム計算
      zoom = _calculateZoomLevelNew(
        span: lngDelta,
        pixelSpan: availableWidth,
        latitude: center.latitude,
      );
    } else {
      // 縦長の地図範囲の場合、緯度範囲に基づいてズーム計算
      zoom = _calculateZoomLevelNew(
        span: latDelta,
        pixelSpan: availableHeight,
        latitude: center.latitude,
      );
    }

    // 安全マージンを持たせる（日本全体表示の場合、一般的には5〜7程度のズームが適切）
    zoom = max(5, zoom - 0.5);

    return CameraPosition(target: center, zoom: zoom);
  }

  /// 緯度・経度の範囲と画面サイズからズームレベルを計算（改良版）
  ///
  /// [span] 緯度または経度の範囲
  /// [pixelSpan] 画面の幅または高さ（ピクセル）
  /// [latitude] 中心緯度（経度の場合に補正のために使用）
  static double _calculateZoomLevelNew({
    required double span,
    required double pixelSpan,
    required double latitude,
  }) {
    // 地球の円周（赤道で約40,075km）
    const earthCircumference = 40075016.686;

    // メルカトル図法のタイルサイズ（ピクセル単位）
    const tileSize = 512.0;

    // 緯度に応じた縮尺を計算（メルカトル図法補正）
    final latitudeRadians = latitude * pi / 180;
    final latitudeFactor = cos(latitudeRadians);

    // 1ピクセルあたりのメートル数を計算
    final metersPerPixel =
        earthCircumference * latitudeFactor / (tileSize * pow(2, 0));

    // 表示範囲の距離（メートル）
    final spanInMeters = span * earthCircumference * latitudeFactor / 360;

    // 必要なピクセル数
    final requiredPixels = spanInMeters / metersPerPixel;

    // ズームレベルを計算
    final zoomLevel = log(pixelSpan / requiredPixels) / log(2) + 1;

    return zoomLevel;
  }
}
