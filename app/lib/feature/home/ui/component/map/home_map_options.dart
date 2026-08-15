import 'dart:math' as math;

import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_bounds.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

/// ホーム設定に基づく [MapOptions] を構築するクラス
class HomeMapOptionsBuilder {
  const HomeMapOptionsBuilder();

  /// ホーム設定から全マップ共通の maxZoom と gestures を取り出す
  ({double maxZoom, MapGestures gestures}) sharedOptions(HomeMapSettings map) {
    final maxZ = (map.maxZoom ?? 22).clamp(0.0, 24.0);
    return (maxZoom: maxZ, gestures: MapGestures.all(rotate: !map.lockBearing));
  }

  /// ホーム設定に基づく初期 [MapOptions]（最大ズーム・方位ロック・表示範囲プリセット）
  MapOptions build({
    required BuildContext context,
    required String styleString,
    required HomeMapSettings map,
    double padding = 0.9,
  }) {
    final bounds = const HomeMapBoundsResolver().resolve(map);
    final size = MediaQuery.sizeOf(context);
    final zoom = const MapZoomCalculator().calculate(
      minLat: bounds.latitudeSouth,
      maxLat: bounds.latitudeNorth,
      minLng: bounds.longitudeWest,
      maxLng: bounds.longitudeEast,
      screenWidth: size.width,
      screenHeight: size.height,
    );
    final adjustedZoom = zoom + math.log(padding) / math.ln2;
    final maxZ = (map.maxZoom ?? 22).clamp(0.0, 24.0);
    final initZoom = adjustedZoom.clamp(0.0, maxZ);
    final centerLat = (bounds.latitudeSouth + bounds.latitudeNorth) / 2;
    final centerLon = (bounds.longitudeWest + bounds.longitudeEast) / 2;

    return MapOptions(
      initStyle: styleString,
      initCenter: Geographic(lon: centerLon, lat: centerLat),
      initZoom: initZoom,
      maxZoom: maxZ,
      gestures: MapGestures.all(rotate: !map.lockBearing),
    );
  }
}
