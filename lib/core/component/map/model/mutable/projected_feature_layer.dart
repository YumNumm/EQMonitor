import 'package:eq_map/eq_map.dart';
import 'package:eqmonitor/core/component/map/utils/projection.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:lat_lng/lat_lng.dart';

class ProjectedFeatureLayer {
  factory ProjectedFeatureLayer.fromFeatureLayer({
    required FeatureLayer layer,
    required Projection projection,
  }) =>
      ProjectedFeatureLayer._(
        basedLayer: layer,
        projectedPolygonFeatures: layer.polygonFeatures
            .map(
              (e) => ProjectedPolygonFeature.fromPolygonFeature(
                feature: e,
                projection: projection,
              ),
            )
            .toList(),
        projectedPolylineFeatures: layer.lineFeatures
            .map(
              (e) => ProjectedPolylineFeature.fromPolylineFeature(
                feature: e,
                projection: projection,
              ),
            )
            .toList(),
      );

  ProjectedFeatureLayer._({
    required this.basedLayer,
    required this.projectedPolygonFeatures,
    required this.projectedPolylineFeatures,
  });

  final FeatureLayer basedLayer;
  final List<ProjectedPolygonFeature> projectedPolygonFeatures;
  final List<ProjectedPolylineFeature> projectedPolylineFeatures;
}

class ProjectedPolylineFeature {
  ProjectedPolylineFeature._({
    required this.points,
    required this.type,
    required this.isClosed,
    required this.bbox,
  });

  factory ProjectedPolylineFeature.fromPolylineFeature({
    required PolylineFeature feature,
    required Projection projection,
  }) =>
      ProjectedPolylineFeature._(
        points: feature.points.map(projection.project).toList(),
        type: feature.type,
        isClosed: feature.isClosed,
        bbox: LatLngBoundary.fromList(feature.points),
      );

  final List<GlobalPoint> points;
  final PolylineType type;
  final bool isClosed;
  final LatLngBoundary bbox;
}

class ProjectedPolygonFeature {
  ProjectedPolygonFeature._({
    required this.code,
    required this.bbox,
    required this.points,
  });

  factory ProjectedPolygonFeature.fromPolygonFeature({
    required PolygonFeature feature,
    required Projection projection,
  }) =>
      ProjectedPolygonFeature._(
        code: feature.code,
        bbox: feature.bbox ?? LatLngBoundary.fromList(feature.points),
        points: feature.points.map(projection.project).toList(),
      );

  final int? code;
  final LatLngBoundary bbox;
  final List<GlobalPoint> points;
}
