import 'package:lat_lng/src/lat_lng.dart';

class LatLngBoundary {

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

  factory LatLngBoundary.fromList(List<LatLng> points) {
    assert(points.isNotEmpty && points.length > 1);
    var northEastLat = double.negativeInfinity;
    var northEastLon = double.negativeInfinity;
    var southWestLat = double.infinity;
    var southWestLon = double.infinity;
    for (final point in points) {
      northEastLat = northEastLat > point.lat ? northEastLat : point.lat;
      northEastLon = northEastLon > point.lon ? northEastLon : point.lon;
      southWestLat = southWestLat < point.lat ? southWestLat : point.lat;
      southWestLon = southWestLon < point.lon ? southWestLon : point.lon;
    }
    final northEast = LatLng(northEastLat, northEastLon);
    final southWest = LatLng(southWestLat, southWestLon);
    return LatLngBoundary._(northEast, southWest);
  }
  LatLngBoundary._(this.northEast, this.southWest);

  final LatLng northEast;
  final LatLng southWest;

  bool containsBbox(LatLngBoundary other) {
    return northEast.lat >= other.northEast.lat &&
        northEast.lon >= other.northEast.lon &&
        southWest.lat <= other.southWest.lat &&
        southWest.lon <= other.southWest.lon;
  }

  @override
  String toString() {
    return 'LatLngBoundary(northEast: $northEast, southWest: $southWest)';
  }
}
