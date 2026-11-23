import 'dart:math' as math;

import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/map/data/logic/map_camera_bounds_fitter.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds_fit_result.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

final class const IntensityHistoryCityCamera() {
  EdgeInsets padding({
    required Size viewportSize,
    required EdgeInsets safePadding,
  }) => EdgeInsets.fromLTRB(
    24,
    safePadding.top + 96,
    24,
    viewportSize.height * CityDetailModalAction.initialChildSize + 24,
  );

  MapCameraBounds? cityBounds({
    required String cityCode,
    required JmaMap_JmaMapData cityMap,
  }) => cityMap.data
      .where((item) => item.property.code == cityCode && item.hasBounds())
      .map((item) => item.bounds)
      .fold<MapCameraBounds?>(
        null,
        (current, bounds) => MapCameraBounds(
          west: math.min(current?.west ?? 180, bounds.southWest.lng),
          south: math.min(current?.south ?? 90, bounds.southWest.lat),
          east: math.max(current?.east ?? -180, bounds.northEast.lng),
          north: math.max(current?.north ?? -90, bounds.northEast.lat),
        ),
      );

  MapOptions? initialMapOptions({
    required String cityCode,
    required JmaMap_JmaMapData cityMap,
    required Size viewportSize,
    required EdgeInsets safePadding,
    required String styleString,
  }) {
    final bounds = cityBounds(cityCode: cityCode, cityMap: cityMap);
    if (bounds == null) {
      return null;
    }
    const defaults = MapOptions();
    final fit = const MapCameraBoundsFitter().fit(
      bounds: bounds,
      viewportLogicalSize: viewportSize,
      devicePixelRatio: 1,
      padding: padding(viewportSize: viewportSize, safePadding: safePadding),
      minZoom: defaults.minZoom,
      maxZoom: defaults.maxZoom,
    );
    return switch (fit) {
      MapCameraBoundsFitSucceeded(:final camera) => MapOptions(
        style: MapStyle.file(styleString),
        initCamera: CameraUpdate.position(
          center: Geographic(
            lon: camera.centerLongitude,
            lat: camera.centerLatitude,
          ),
          zoom: camera.zoom,
        ),
      ),
      MapCameraBoundsFitInvalid() => null,
    };
  }
}
