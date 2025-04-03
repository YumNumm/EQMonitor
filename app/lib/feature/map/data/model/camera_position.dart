import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'camera_position.freezed.dart';
part 'camera_position.g.dart';

/// マップのカメラ位置を表すモデル
@freezed
class MapCameraPosition with _$MapCameraPosition {
  const factory MapCameraPosition({
    /// カメラの中心座標
    required LatLng target,

    /// ズームレベル
    @Default(5.0) double zoom,

    /// カメラの傾き (0-60)
    @Default(0.0) double tilt,

    /// カメラの向き (0-360)
    @Default(0.0) double bearing,
  }) = _MapCameraPosition;

  /// MapLibreのCameraPositionに変換
  const MapCameraPosition._();

  factory MapCameraPosition.fromJson(Map<String, dynamic> json) =>
      _$MapCameraPositionFromJson(json);

  /// 指定された緯度経度矩形が画面に収まるカメラ位置を計算する
  /// [screenWidth] 画面の幅（ピクセル）
  /// [screenHeight] 画面の高さ（ピクセル）
  /// [bounds] 表示したい緯度経度の矩形（minLat, minLng, maxLat, maxLng）
  /// [padding] 画面の端から境界までのパディング（ピクセル）
  /// [tileSize] タイルサイズ（通常は256または512）
  /// [return] 適切なカメラ位置
  factory MapCameraPosition.fitBounds({
    required double screenWidth,
    required double screenHeight,
    required ({double minLat, double minLng, double maxLat, double maxLng})
    bounds,
    double padding = 0,
    double tileSize = 512,
  }) {
    // パディングを適用した有効画面サイズを計算
    final effectiveWidth = screenWidth - 2 * padding;
    final effectiveHeight = screenHeight - 2 * padding;

    // 矩形の中心座標を計算
    final centerLat = (bounds.minLat + bounds.maxLat) / 2;
    final centerLng = (bounds.minLng + bounds.maxLng) / 2;
    final center = LatLng(centerLat, centerLng);

    // 経度と緯度の範囲を計算
    final longitudeSpan = bounds.maxLng - bounds.minLng;
    final latitudeSpan = bounds.maxLat - bounds.minLat;

    // 経度と緯度のそれぞれについてズームレベルを計算
    // 経度方向のズームレベル計算
    final zoomLng = _calculateZoomForLongitude(
      longitudeSpan: longitudeSpan,
      screenWidth: effectiveWidth,
      tileSize: tileSize,
    );

    // 緯度方向のズームレベル計算
    final zoomLat = _calculateZoomForLatitude(
      latitudeSpan: latitudeSpan,
      centerLatitude: centerLat,
      screenHeight: effectiveHeight,
      tileSize: tileSize,
      maxLat: bounds.maxLat,
      minLat: bounds.minLat,
    );

    // より制約の厳しい（小さい）ズームレベルを採用
    final zoom = math.min(zoomLng, zoomLat);

    // ズームレベルは通常小数点以下1桁程度に制限
    final roundedZoom = (zoom * 10).round() / 10;

    return MapCameraPosition(target: center, zoom: roundedZoom);
  }

  /// 経度方向のズームレベルを計算
  static double _calculateZoomForLongitude({
    required double longitudeSpan,
    required double screenWidth,
    required double tileSize,
  }) {
    // 経度スパンが0の場合の対策
    if (longitudeSpan <= 0) {
      return 20; // 最大ズーム
    }

    // 360度（全世界）に対する経度スパンの比率から計算
    // ズームレベルzでは、世界の幅は tileSize * 2^z ピクセル
    // スクリーン幅:経度スパンの比率 = tileSize * 2^z:360
    return math.log(screenWidth * 360 / (longitudeSpan * tileSize)) / math.ln2;
  }

  /// 緯度方向のズームレベルを計算
  static double _calculateZoomForLatitude({
    required double latitudeSpan,
    required double centerLatitude,
    required double screenHeight,
    required double tileSize,
    required double maxLat,
    required double minLat,
  }) {
    // 緯度スパンが0の場合の対策
    if (latitudeSpan <= 0) {
      return 20; // 最大ズーム
    }
    // 北から南への緯度範囲をピクセルに変換
    final topPixel = _latitudeToPixelY(maxLat, 0, tileSize);
    final bottomPixel = _latitudeToPixelY(minLat, 0, tileSize);
    final pixelSpan = (bottomPixel - topPixel).abs();

    return math.log(screenHeight / pixelSpan) / math.ln2;
  }

  /// 緯度をY座標（ピクセル）に変換
  static double _latitudeToPixelY(double lat, double zoom, double tileSize) {
    // メルカトル投影の数式
    final sinLat = math.sin(lat * math.pi / 180);
    final y = 0.5 - math.log((1 + sinLat) / (1 - sinLat)) / (4 * math.pi);
    return y * tileSize * math.pow(2, zoom);
  }
}
