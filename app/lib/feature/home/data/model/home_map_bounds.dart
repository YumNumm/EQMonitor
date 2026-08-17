import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:maplibre/maplibre.dart';

/// 沖縄を除く日本列島おおよその範囲（ホームの「本州〜九州〜北海道」プリセット）
class JapanMainIslandBounds {
  static const double minLat = 30;
  static const double maxLat = JapanBounds.maxLat;
  static const double minLng = 128;
  static const double maxLng = JapanBounds.maxLng;

  static const lngLatBounds = LngLatBounds(
    longitudeWest: minLng,
    longitudeEast: maxLng,
    latitudeSouth: minLat,
    latitudeNorth: maxLat,
  );
}

/// [HomeMapSettings] からホームマップの表示範囲を解決するクラス
class HomeMapBoundsResolver {
  const HomeMapBoundsResolver();

  /// [HomeMapSettings.defaultBounds] に対応する [LngLatBounds]。
  LngLatBounds resolve(HomeMapSettings settings) {
    switch (settings.defaultBounds) {
      case .mainIsland:
        return JapanMainIslandBounds.lngLatBounds;
      case .all:
        return const LngLatBounds(
          longitudeWest: JapanBounds.minLng,
          longitudeEast: JapanBounds.maxLng,
          latitudeSouth: JapanBounds.minLat,
          latitudeNorth: JapanBounds.maxLat,
        );
      case .custom:
        final c = settings.customBounds;
        if (c == null) {
          return JapanMainIslandBounds.lngLatBounds;
        }
        return LngLatBounds(
          longitudeWest: c.southWest.lon,
          longitudeEast: c.northEast.lon,
          latitudeSouth: c.southWest.lat,
          latitudeNorth: c.northEast.lat,
        );
    }
  }
}
