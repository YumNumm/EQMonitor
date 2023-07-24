import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';

import 'package:eqmonitor/core/component/map/utils/projection.dart';
import 'package:lat_lng/lat_lng.dart';

class WebMercatorProjection implements Projection {
  static const int tileSize = 256;
  static const pixelsPerLonDegree = tileSize / 360;
  static const pixelsPerLonRadian = tileSize / (2 * math.pi);
  static const origin = Offset(128, 128);

  @override
  GlobalPoint project(LatLng latLng) {
    final siny = math.min(
      math.max(
        math.sin(latLng.lat * (math.pi / 180)),
        -0.9999,
      ),
      0.9999,
    );
    return GlobalPoint(
      origin.dx + latLng.lon * pixelsPerLonDegree,
      origin.dy + 0.5 * math.log((1 + siny) / (1 - siny)) * -pixelsPerLonRadian,
    );
  }

  @override
  LatLng unproject(GlobalPoint point) {
    final lng = point.x - origin.dx / pixelsPerLonDegree;
    final latRadians = (point.y - origin.dy) / -pixelsPerLonRadian;
    final lat =
        180 / math.pi * (2 * math.atan(math.exp(latRadians)) - math.pi / 2);
    return LatLng(lat, lng);
  }
}

class GlobalPoint extends Point<double> {
  const GlobalPoint(super.x, super.y);

  factory GlobalPoint.fromLatlng(LatLng latLng) {
    return WebMercatorProjection().project(latLng);
  }

  LatLng toLatLng() {
    return WebMercatorProjection().unproject(this);
  }

  @override
  String toString() {
    return 'GlobalPoint($x, $y)';
  }
}

extension GlobalPointToLatLngs on (GlobalPoint, GlobalPoint) {
  (LatLng, LatLng) toLatLngs() {
    final projection = WebMercatorProjection();
    final (a, b) = (
      projection.unproject(this.$1),
      projection.unproject(this.$2),
    );
    final (minLat, maxLat) = (math.min(a.lat, b.lat), math.max(a.lat, b.lat));
    final (minLng, maxLng) = (math.min(a.lon, b.lon), math.max(a.lon, b.lon));

    return (
      LatLng(minLat, minLng),
      LatLng(maxLat, maxLng),
    );
  }
}

extension LatLngToGlobalPoints on (LatLng, LatLng) {
  (GlobalPoint, GlobalPoint) toGlobalPoints() {
    final projection = WebMercatorProjection();
    final (a, b) = (
      projection.project(this.$1),
      projection.project(this.$2),
    );
    final (minX, maxX) = (math.min(a.x, b.x), math.max(a.x, b.x));
    final (minY, maxY) = (math.min(a.y, b.y), math.max(a.y, b.y));

    return (
      GlobalPoint(minX, minY),
      GlobalPoint(maxX, maxY),
    );
  }
}
