import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapGlobalOffset extends Offset {
  MapGlobalOffset(super.dx, super.dy);
  static const int tileSize = 256;
  static const pixelsPerLonDegree = tileSize / 360;
  static const pixelsPerLonRadian = tileSize / (2 * math.pi);
  static const origin = Offset(128, 128);

  static const minMapOffset = Offset(215.4, 91.5);
  static const maxMapOffset = Offset(237.5, 110.4);

  static MapGlobalOffset latLonToGlobalPoint(LatLng latLng) {
    final siny = math.min(
      math.max(
        math.sin(latLng.latitude * (math.pi / 180)),
        -0.9999,
      ),
      0.9999,
    );
    return MapGlobalOffset(
      origin.dx + latLng.longitude * pixelsPerLonDegree,
      origin.dy + 0.5 * math.log((1 + siny) / (1 - siny)) * -pixelsPerLonRadian,
    );
  }

  static MapGlobalOffset globalPointToLatLng(Offset point) {
    final lng = (point.dx - origin.dx) / pixelsPerLonDegree;
    final latRadians = (point.dy - origin.dy) / -pixelsPerLonRadian;
    final lat =
        (2 * math.atan(math.exp(latRadians)) - math.pi / 2) * (180 / math.pi);
    return MapGlobalOffset(lat, lng);
  }

  Offset toLocalOffset(Size displaySize) {
    // displaySizeのdx,dyのうち小さい方を基準にして
    // 座標を変換する
    final delta = math.min(displaySize.width, displaySize.height);
    final x =
        (dx - minMapOffset.dx) / (maxMapOffset.dx - minMapOffset.dx) * delta;
    final y =
        (dy - minMapOffset.dy) / (maxMapOffset.dy - minMapOffset.dy) * delta;
    return Offset(x, y);
  }
}
