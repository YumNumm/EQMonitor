import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';

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

class MapPolyline{
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

class LatLngBoundary {
  LatLngBoundary._(this.northEast, this.southWest);

  factory LatLngBoundary.fromTwo(LatLng one, LatLng two) {
    final northEast = LatLng(
      one.lat > two.lat ? one.lat : two.lat,
      one.lon > two.lon ? one.lon : two.lon,
    );
    final southWest = LatLng(
      one.lat < two.lat ? one.lat : two.lat,
      one.lon < two.lon ? one.lon : two.lon,
    );
    return LatLngBoundary._(northEast, southWest);
  }

  factory LatLngBoundary.fromList(List<LatLng> points) {
    final northEast = LatLng(
      points
          .map((e) => e.lat)
          .reduce((value, element) => value > element ? value : element),
      points
          .map((e) => e.lon)
          .reduce((value, element) => value > element ? value : element),
    );
    final southWest = LatLng(
      points
          .map((e) => e.lat)
          .reduce((value, element) => value < element ? value : element),
      points
          .map((e) => e.lon)
          .reduce((value, element) => value < element ? value : element),
    );
    return LatLngBoundary._(northEast, southWest);
  }

  factory LatLngBoundary.merge(List<LatLngBoundary> boundaries) {
    final northEast = LatLng(
      boundaries
          .map((e) => e.northEast.lat)
          .reduce((value, element) => value > element ? value : element),
      boundaries
          .map((e) => e.northEast.lon)
          .reduce((value, element) => value > element ? value : element),
    );
    final southWest = LatLng(
      boundaries
          .map((e) => e.southWest.lat)
          .reduce((value, element) => value < element ? value : element),
      boundaries
          .map((e) => e.southWest.lon)
          .reduce((value, element) => value < element ? value : element),
    );
    return LatLngBoundary._(northEast, southWest);
  }

  final LatLng northEast;
  final LatLng southWest;
}
