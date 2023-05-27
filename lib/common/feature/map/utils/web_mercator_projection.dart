import 'dart:math';
import 'dart:math' as math;

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:flutter/services.dart';

class WebMercatorProjection {
  static const int tileSize = 256;
  static const pixelsPerLonDegree = tileSize / 360;
  static const pixelsPerLonRadian = tileSize / (2 * math.pi);
  static const origin = Offset(128, 128);

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
