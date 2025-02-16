import 'dart:math' as math;

import 'package:maplibre_gl/maplibre_gl.dart';

/// 画面サイズに応じて地図のカメラ位置を計算するヘルパークラス
class MapCameraPositionHelper {
  const MapCameraPositionHelper._();

  static const _japanBounds = (
    north: 45.7,
    south: 31.0,
    east: 146.5,
    west: 128.0,
  );

  /// メルカトル図法でのY座標を計算
  static double _latitudeToMercatorY(double latitude) {
    final latRad = latitude * math.pi / 180;
    return math.log(math.tan(math.pi / 4 + latRad / 2));
  }

  /// 日本全体を表示するためのカメラ位置を計算する
  ///
  /// [screenWidth] 画面の幅
  /// [screenHeight] 画面の高さ
  static LatLng calculateJapanCenterPosition(
    double screenWidth,
    double screenHeight,
  ) {
    // メルカトル図法での日本の中心を計算
    final northY = _latitudeToMercatorY(_japanBounds.north);
    final southY = _latitudeToMercatorY(_japanBounds.south);
    final centerY = (northY + southY) / 2;

    // メルカトル座標から緯度に戻す
    final centerLat =
        (2 * math.atan(math.exp(centerY)) - math.pi / 2) *
        180 /
        math.pi;
    final centerLng =
        (_japanBounds.east + _japanBounds.west) / 2;

    return LatLng(centerLat, centerLng);
  }

  /// 日本全体を表示するためのズームレベルを計算する
  ///
  /// [screenWidth] 画面の幅
  /// [screenHeight] 画面の高さ
  static double calculateJapanZoomLevel(
    double screenWidth,
    double screenHeight,
  ) {
    // メルカトル図法での日本の縦幅を計算
    final northY = _latitudeToMercatorY(_japanBounds.north);
    final southY = _latitudeToMercatorY(_japanBounds.south);
    final mercatorHeight = (northY - southY).abs();

    // 経度方向の幅（度）
    final longitudeWidth =
        _japanBounds.east - _japanBounds.west;

    // 画面サイズと地理的な範囲から基本ズームレベルを計算
    final latitudeBasedZoom =
        math.log(screenHeight / mercatorHeight) / math.ln2;
    final longitudeBasedZoom =
        math.log(screenWidth / longitudeWidth) / math.ln2;

    // 縦横の小さい方のズームレベルを採用し、マージンを考慮
    return math.min(latitudeBasedZoom, longitudeBasedZoom) -
        0.5;
  }
}
