import 'dart:math';

import 'package:eq_map/eq_map.dart';
import 'package:eqmonitor/core/component/map/model/mutable/projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/utils/map_shrinker.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:lat_lng/lat_lng.dart';

class ZoomCachedProjectedFeatureLayer {
  ZoomCachedProjectedFeatureLayer._({
    required this.projectedPolygonFeatures,
    required this.projectedPolylineFeatures,
    required this.basedLayer,
  });

  factory ZoomCachedProjectedFeatureLayer.fromProjectedFeatureLayer(
    ProjectedFeatureLayer layer,
  ) =>
      ZoomCachedProjectedFeatureLayer._(
        projectedPolygonFeatures: layer.projectedPolygonFeatures
            .map(ZoomCachedProjectedPolygonFeature.fromProjectedPolygonFeature)
            .toList(),
        projectedPolylineFeatures: layer.projectedPolylineFeatures
            .map(
              ZoomCachedProjectedPolylineFeature.fromProjectedPolylineFeature,
            )
            .toList(),
        basedLayer: layer,
      );

  final List<ZoomCachedProjectedPolygonFeature> projectedPolygonFeatures;
  final List<ZoomCachedProjectedPolylineFeature> projectedPolylineFeatures;
  final ProjectedFeatureLayer basedLayer;
}

class ZoomCachedProjectedPolylineFeature {
  factory ZoomCachedProjectedPolylineFeature.fromProjectedPolylineFeature(
    ProjectedPolylineFeature feature,
  ) =>
      ZoomCachedProjectedPolylineFeature._(
        points: feature.points,
        type: feature.type,
        isClosed: feature.isClosed,
        bbox: feature.bbox,
      );

  ZoomCachedProjectedPolylineFeature._({
    required this.points,
    required this.type,
    required this.isClosed,
    required this.bbox,
  });

  final List<GlobalPoint> points;
  final PolylineType type;
  final bool isClosed;
  final LatLngBoundary bbox;

  /// cache
  final Map<int, List<GlobalPoint>> _cache = {};

  /// [zoomLevel]を適用したList<Point>を返す
  List<GlobalPoint> _applyZoomLevel(int zoomLevel) => _cache[zoomLevel] =
      MapShrinker.shrink(zoomLevel: zoomLevel, points: points);

  /// キャッシュがある場合はそれを返し、ない場合は[zoomLevel]を適用したList<Point>を返す
  List<GlobalPoint> getPoints(int zoomLevel) {
    final value = pow(2, sqrt(min(200, zoomLevel) / 4).toInt()).toInt() * 4;

    return _cache[value] ??= _applyZoomLevel(value);
  }

  /// キャッシュをクリアする
  void clearCache() => _cache.clear();
}

class ZoomCachedProjectedPolygonFeature {
  factory ZoomCachedProjectedPolygonFeature.fromProjectedPolygonFeature(
    ProjectedPolygonFeature feature,
  ) =>
      ZoomCachedProjectedPolygonFeature._(
        points: feature.points,
        code: feature.code,
        bbox: feature.bbox,
      );

  ZoomCachedProjectedPolygonFeature._({
    required this.points,
    required this.code,
    required this.bbox,
  });

  final List<GlobalPoint> points;
  final int? code;
  final LatLngBoundary bbox;

  /// cache
  final Map<int, List<GlobalPoint>> _cache = {};

  /// [zoomLevel]を適用したList<Point>を返す
  List<GlobalPoint> _applyZoomLevel(int zoomLevel) => _cache[zoomLevel] =
      MapShrinker.shrink(zoomLevel: zoomLevel, points: points);

  /// キャッシュがある場合はそれを返し、ない場合は[zoomLevel]を適用したList<Point>を返す
  List<GlobalPoint> getPoints(int zoomLevel) {
    final value = pow(2, sqrt(max(100, zoomLevel) / 3).toInt()).toInt() * 3;
    return _cache[value] ??= _applyZoomLevel(value);
  }

  /// キャッシュをクリアする
  void clearCache() => _cache.clear();
}
