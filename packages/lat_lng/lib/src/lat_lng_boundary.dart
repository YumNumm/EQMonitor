import 'package:lat_lng/src/lat_lng.dart';

class LatLngBoundary {
  LatLngBoundary(this.northEast, this.southWest);

  final LatLng northEast;
  final LatLng southWest;

  factory LatLngBoundary.fromTwo(LatLng one, LatLng two) {
    final northEast = LatLng(
      one.lat > two.lat ? one.lat : two.lat,
      one.lon > two.lon ? one.lon : two.lon,
    );
    final southWest = LatLng(
      one.lat < two.lat ? one.lat : two.lat,
      one.lon < two.lon ? one.lon : two.lon,
    );
    return LatLngBoundary(northEast, southWest);
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
    return LatLngBoundary(northEast, southWest);
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
    return LatLngBoundary(northEast, southWest);
  }
}
