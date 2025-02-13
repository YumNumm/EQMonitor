import 'dart:math' show log, min;

import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_controller.g.dart';

/// マップのカメラ位置を制御するコントローラー
@riverpod
class MapCameraController extends _$MapCameraController {
  @override
  MapCameraPosition build() {
    return const MapCameraPosition(
      target: LatLng(35.681236, 139.767125), // 東京駅
    );
  }

  /// カメラ位置を更新
  void updateCamera(MapCameraPosition position) {
    state = position;
  }

  /// カメラを指定位置に移動
  void moveTo({LatLng? target, double? zoom, double? tilt, double? bearing}) {
    state = MapCameraPosition(
      target: target ?? state.target,
      zoom: zoom ?? state.zoom,
      tilt: tilt ?? state.tilt,
      bearing: bearing ?? state.bearing,
    );
  }

  /// カメラを指定の境界に合わせて移動
  void moveToLatLngBounds(LatLngBounds bounds, {double padding = 50}) {
    // 境界の中心を計算
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    // 境界に合わせたズームレベルを計算
    final latZoom = _getZoomLevel(
      bounds.northeast.latitude - bounds.southwest.latitude,
      padding,
    );
    final lngZoom = _getZoomLevel(
      bounds.northeast.longitude - bounds.southwest.longitude,
      padding,
    );

    moveTo(target: center, zoom: min(latZoom, lngZoom));
  }

  /// 距離からズームレベルを計算
  double _getZoomLevel(double distance, double padding) {
    const baseZoom = 20.0;
    final scale = distance * padding;
    return baseZoom - log(scale) / log(2);
  }
}
