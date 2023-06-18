import 'package:eqmonitor/common/feature/map/data/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:lat_lng/lat_lng.dart';

class MultiPolygonProjectedMapData<T> {
  MultiPolygonProjectedMapData._(
    this.polygons,
    this.boundary,
    this.properties,
  );

  factory MultiPolygonProjectedMapData.fromList(
    List<MapProjectedPolygon> polygons,
    T properties,
  ) {
    return MultiPolygonProjectedMapData._(
      polygons,
      GlobalPointBoundary.merge(polygons.map((e) => e.boundary).toList()),
      properties,
    );
  }

  factory MultiPolygonProjectedMapData.fromMapData(
    MultiPolygonMapData<T> data,
    WebMercatorProjection projection,
  ) {
    return MultiPolygonProjectedMapData<T>._(
      data.polygons
          .map((e) => MapProjectedPolygon.fromLatLngList(e.points, projection))
          .toList(),
      GlobalPointBoundary.fromLatLngBoundary(projection, data.boundary),
      data.properties,
    );
  }

  final List<MapProjectedPolygon> polygons;
  final GlobalPointBoundary boundary;
  final T properties;
}

class MultiLineProjectedMapData<T> {
  MultiLineProjectedMapData._(
    this.polylines,
    this.boundary,
    this.properties,
  );

  factory MultiLineProjectedMapData.fromList(
    List<MapProjectedPolyline> polylines,
    T properties,
  ) {
    return MultiLineProjectedMapData._(
      polylines.map((e) => MapProjectedPolyline.fromList(e.points)).toList(),
      GlobalPointBoundary.merge(polylines.map((e) => e.boundary).toList()),
      properties,
    );
  }

  factory MultiLineProjectedMapData.fromLineData(
    MultiLineMapData<T> data,
    WebMercatorProjection projection,
  ) {
    return MultiLineProjectedMapData<T>._(
      data.polylines
          .map((e) => MapProjectedPolyline.fromLatLngList(e.points, projection))
          .toList(),
      GlobalPointBoundary.fromLatLngBoundary(projection, data.boundary),
      data.properties,
    );
  }
  final List<MapProjectedPolyline> polylines;
  final GlobalPointBoundary boundary;
  final T properties;
}

class MapProjectedPolyline {
  MapProjectedPolyline._(this.points, this.boundary);

  factory MapProjectedPolyline.fromList(List<GlobalPoint> points) {
    return MapProjectedPolyline._(points, GlobalPointBoundary.fromList(points));
  }

  factory MapProjectedPolyline.fromLatLngList(
    List<LatLng> points,
    WebMercatorProjection projection,
  ) {
    return MapProjectedPolyline._(
      points.map((e) => projection.project(e)).toList(),
      GlobalPointBoundary.fromLatLngBoundary(
        projection,
        LatLngBoundary.fromList(points),
      ),
    );
  }

  final List<GlobalPoint> points;
  final GlobalPointBoundary boundary;
}

class MapProjectedPolygon {
  MapProjectedPolygon._(this.points, this.boundary);

  factory MapProjectedPolygon.fromList(List<GlobalPoint> points) {
    return MapProjectedPolygon._(points, GlobalPointBoundary.fromList(points));
  }
  factory MapProjectedPolygon.fromLatLngList(
    List<LatLng> points,
    WebMercatorProjection projection,
  ) {
    return MapProjectedPolygon._(
      points.map((e) => projection.project(e)).toList(),
      GlobalPointBoundary.fromLatLngBoundary(
        projection,
        LatLngBoundary.fromList(points),
      ),
    );
  }
  final List<GlobalPoint> points;
  final GlobalPointBoundary boundary;
}

class GlobalPointBoundary {
  GlobalPointBoundary._(this.min, this.max);

  factory GlobalPointBoundary.fromList(List<GlobalPoint> points) {
    final min = GlobalPoint(
      points
          .map((e) => e.x)
          .reduce((value, element) => value < element ? value : element),
      points
          .map((e) => e.y)
          .reduce((value, element) => value < element ? value : element),
    );
    final max = GlobalPoint(
      points
          .map((e) => e.x)
          .reduce((value, element) => value > element ? value : element),
      points
          .map((e) => e.y)
          .reduce((value, element) => value > element ? value : element),
    );
    return GlobalPointBoundary._(min, max);
  }

  factory GlobalPointBoundary.merge(List<GlobalPointBoundary> boundaries) {
    final min = GlobalPoint(
      boundaries
          .map((e) => e.min.x)
          .reduce((value, element) => value < element ? value : element),
      boundaries
          .map((e) => e.min.y)
          .reduce((value, element) => value < element ? value : element),
    );
    final max = GlobalPoint(
      boundaries
          .map((e) => e.max.x)
          .reduce((value, element) => value > element ? value : element),
      boundaries
          .map((e) => e.max.y)
          .reduce((value, element) => value > element ? value : element),
    );
    return GlobalPointBoundary._(min, max);
  }

  factory GlobalPointBoundary.fromLatLngBoundary(
    WebMercatorProjection projection,
    LatLngBoundary boundary,
  ) {
    final p1 = projection.project(boundary.northEast);
    final p2 = projection.project(boundary.southWest);
    final min = GlobalPoint(
      p1.x < p2.x ? p1.x : p2.x,
      p1.y < p2.y ? p1.y : p2.y,
    );
    final max = GlobalPoint(
      p1.x > p2.x ? p1.x : p2.x,
      p1.y > p2.y ? p1.y : p2.y,
    );
    return GlobalPointBoundary._(min, max);
  }

  final GlobalPoint min;
  final GlobalPoint max;

  @override
  String toString() {
    return 'GlobalPointBoundary{min: $min, max: $max}';
  }

  LatLng get center => LatLng(
        (min.x + max.x) / 2,
        (min.y + max.y) / 2,
      );
}
