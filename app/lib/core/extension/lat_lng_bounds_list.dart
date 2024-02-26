import 'dart:math';

import 'package:jma_map/jma_map.dart';

extension LatLngBoundsListEx on List<LatLngBounds> {
  LatLngBounds marge() {
    var minLat = double.infinity;
    var minLng = double.infinity;
    var maxLat = double.negativeInfinity;
    var maxLng = double.negativeInfinity;

    for (final bounds in this) {
      minLat = min(minLat, bounds.southWest.lat);
      minLng = min(minLng, bounds.southWest.lng);
      maxLat = max(maxLat, bounds.northEast.lat);
      maxLng = max(maxLng, bounds.northEast.lng);
    }
    return LatLngBounds(
      southWest: LatLng(lat: minLat, lng: minLng),
      northEast: LatLng(lat: maxLat, lng: maxLng),
    );
  }
}

extension LatLngBoundsEx on LatLngBounds {
  LatLngBounds add(LatLng latLng) {
    final minLat = min(southWest.lat, latLng.lat);
    final minLng = min(southWest.lng, latLng.lng);
    final maxLat = max(northEast.lat, latLng.lat);
    final maxLng = max(northEast.lng, latLng.lng);
    return LatLngBounds(
      southWest: LatLng(lat: minLat, lng: minLng),
      northEast: LatLng(lat: maxLat, lng: maxLng),
    );
  }
}
