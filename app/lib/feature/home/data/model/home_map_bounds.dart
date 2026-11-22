import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';

/// 沖縄を除く日本列島おおよその範囲（ホームの「本州〜九州〜北海道」プリセット）
class JapanMainIslandBounds {
  static const double minLat = 30;
  static const double maxLat = JapanBounds.maxLat;
  static const double minLng = 128;
  static const double maxLng = JapanBounds.maxLng;

  static const lngLatBounds = MapCameraBounds(
    west: minLng,
    south: minLat,
    east: maxLng,
    north: maxLat,
  );
}

/// [HomeMapSettings] からホームマップの表示範囲を解決するクラス
class const HomeMapBoundsResolver() {
  /// [HomeMapSettings.defaultBounds] に対応する [MapCameraBounds]。
  MapCameraBounds resolve(HomeMapSettings settings) {
    switch (settings.defaultBounds) {
      case .mainIsland:
        return JapanMainIslandBounds.lngLatBounds;
      case .all:
        return const MapCameraBounds(
          west: JapanBounds.minLng,
          south: JapanBounds.minLat,
          east: JapanBounds.maxLng,
          north: JapanBounds.maxLat,
        );
      case .custom:
        final c = settings.customBounds;
        if (c == null) {
          return JapanMainIslandBounds.lngLatBounds;
        }
        return MapCameraBounds(
          west: c.southWest.lon,
          south: c.southWest.lat,
          east: c.northEast.lon,
          north: c.northEast.lat,
        );
    }
  }
}
