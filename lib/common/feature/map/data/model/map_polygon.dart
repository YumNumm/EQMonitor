import 'package:lat_lng/lat_lng.dart';

class MultiPolygonMapData<T> {
  factory MultiPolygonMapData.fromList(
    List<MapPolygon> polygons,
    T properties,
  ) {
    return MultiPolygonMapData._(
      polygons,
      LatLngBoundary.merge(polygons.map((e) => e.boundary).toList()),
      properties,
    );
  }

  MultiPolygonMapData._(
    this.polygons,
    this.boundary,
    this.properties,
  );
  final List<MapPolygon> polygons;
  final LatLngBoundary boundary;
  final T properties;
}

class MultiLineMapData<T> {
  factory MultiLineMapData.fromList(
    List<MapPolyline> polylines,
    T properties,
  ) {
    return MultiLineMapData._(
      polylines,
      LatLngBoundary.merge(polylines.map((e) => e.boundary).toList()),
      properties,
    );
  }

  MultiLineMapData._(
    this.polylines,
    this.boundary,
    this.properties,
  );
  final List<MapPolyline> polylines;
  final LatLngBoundary boundary;
  final T properties;
}

class MapPolyline {
  MapPolyline._(this.points, this.boundary);

  factory MapPolyline.fromList(List<LatLng> points) {
    return MapPolyline._(points, LatLngBoundary.fromList(points));
  }

  final List<LatLng> points;
  final LatLngBoundary boundary;
}

class MapPolygon {
  MapPolygon._(this.points, this.boundary);

  factory MapPolygon.fromList(List<LatLng> points) {
    return MapPolygon._(points, LatLngBoundary.fromList(points));
  }

  final List<LatLng> points;
  final LatLngBoundary boundary;
}
