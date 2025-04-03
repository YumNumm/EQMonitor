import 'dart:math';
import 'dart:ui';

import 'package:vector_math/vector_math.dart';

/// MapLibreで使用されるWeb Mercator投影を実装するクラス
class MapProjection {
  /// タイルサイズ（ピクセル）
  final double tileSize;

  /// 現在のズームレベル
  double _zoomLevel;

  /// 中心座標（緯度・経度）
  Point<double> _center;

  /// 回転角（ラジアン）
  double _rotation;

  /// 傾き角（ラジアン）
  double _pitch;

  /// 変換行列
  Matrix4? _transformMatrix;

  /// 逆変換行列
  Matrix4? _inverseMatrix;

  MapProjection({
    this.tileSize = 512.0,
    double zoomLevel = 5.0,
    Point<double>? center,
    double rotation = 0.0,
    double pitch = 0.0,
  }) : _zoomLevel = zoomLevel,
       _center = center ?? const Point(139.767, 35.681), // デフォルトは東京
       _rotation = rotation,
       _pitch = pitch {
    _updateMatrix();
  }

  /// ワールドサイズを計算（ピクセル単位）
  double get worldSize => tileSize * pow(2, _zoomLevel);

  /// 現在のズームレベル
  double get zoomLevel => _zoomLevel;

  /// 中心座標
  Point<double> get center => _center;

  /// 回転角（ラジアン）
  double get rotation => _rotation;

  /// 傾き角（ラジアン）
  double get pitch => _pitch;

  /// ズームレベルを設定
  set zoomLevel(double value) {
    if (_zoomLevel != value) {
      _zoomLevel = value;
      _updateMatrix();
    }
  }

  /// 中心座標を設定
  set center(Point<double> value) {
    if (_center != value) {
      _center = value;
      _updateMatrix();
    }
  }

  /// 回転角を設定
  set rotation(double value) {
    if (_rotation != value) {
      _rotation = value;
      _updateMatrix();
    }
  }

  /// 傾き角を設定
  set pitch(double value) {
    if (_pitch != value) {
      _pitch = value;
      _updateMatrix();
    }
  }

  /// 変換行列を更新
  void _updateMatrix() {
    // 変換行列を計算
    final matrix = Matrix4.identity();

    // 1. スクリーン中心に移動
    matrix.translate(0.0, 0.0);

    // 2. ズーム適用
    final scale = pow(2, _zoomLevel);
    matrix.scale(scale.toDouble(), scale.toDouble());

    // 3. 回転適用
    if (_rotation != 0) {
      matrix.rotateZ(_rotation);
    }

    // 4. 傾き適用（簡易版 - 完全な3D投影ではない）
    if (_pitch != 0) {
      matrix.rotateX(_pitch);
    }

    // 5. 中心座標に移動
    final centerPoint = _latLngToPoint(_center.y, _center.x);
    matrix.translate(-centerPoint.x, -centerPoint.y);

    _transformMatrix = matrix;
    _inverseMatrix = matrix.clone()..invert();
  }

  /// 緯度・経度をピクセル座標に変換（Web Mercator投影）
  Point<double> _latLngToPoint(double lat, double lng) {
    final x = (180 + lng) / 360 * worldSize;

    // Web Mercator投影のY座標計算
    final latRad = lat * pi / 180;
    final y = (1 - log(tan(pi / 4 + latRad / 2)) / pi) / 2 * worldSize;

    return Point(x, y);
  }

  /// ピクセル座標を緯度・経度に変換
  Point<double> _pointToLatLng(double x, double y) {
    final lng = x / worldSize * 360 - 180;

    final latRad = 2 * atan(exp(pi * (1 - 2 * y / worldSize))) - pi / 2;
    final lat = latRad * 180 / pi;

    return Point(lng, lat);
  }

  /// 緯度・経度をスクリーン座標に変換
  Point<double> latLngToScreen(double lat, double lng, Size screenSize) {
    final worldPoint = _latLngToPoint(lat, lng);

    // 変換行列を適用
    final vector = Vector3(worldPoint.x, worldPoint.y, 0);
    final transformed = _transformMatrix!.transform3(vector);

    // スクリーン中心を原点とする座標系に変換
    final screenX = transformed.x + screenSize.width / 2;
    final screenY = transformed.y + screenSize.height / 2;

    return Point(screenX, screenY);
  }

  /// スクリーン座標を緯度・経度に変換
  Point<double> screenToLatLng(double x, double y, Size screenSize) {
    // スクリーン中心を原点とする座標系に変換
    final screenX = x - screenSize.width / 2;
    final screenY = y - screenSize.height / 2;

    // 逆変換行列を適用
    final vector = Vector3(screenX, screenY, 0);
    final transformed = _inverseMatrix!.transform3(vector);

    return _pointToLatLng(transformed.x, transformed.y);
  }

  /// ズームイン
  void zoomIn(double factor) {
    zoomLevel += factor;
  }

  /// ズームアウト
  void zoomOut(double factor) {
    zoomLevel -= factor;
  }

  /// 指定した座標を中心にパン
  void panTo(Point<double> latLng) {
    center = latLng;
  }

  /// 相対的にパン
  void panBy(double dx, double dy, Size screenSize) {
    final currentCenter = screenToLatLng(
      screenSize.width / 2,
      screenSize.height / 2,
      screenSize,
    );
    final newCenter = screenToLatLng(
      screenSize.width / 2 - dx,
      screenSize.height / 2 - dy,
      screenSize,
    );
    center = newCenter;
  }

  /// 回転
  void rotate(double angle) {
    rotation += angle;
  }

  /// 傾き調整
  void tilt(double angle) {
    pitch += angle;
    // 傾きの範囲を制限（0〜π/2）
    pitch = max(0, min(pi / 2, pitch));
  }
}
