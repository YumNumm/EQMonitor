import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapGlobalOffset extends Offset {
  MapGlobalOffset(super.dx, super.dy);

  factory MapGlobalOffset.latLonToGlobalPoint(LatLng latLng) {
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

  static const int tileSize = 256;
  static const pixelsPerLonDegree = tileSize / 360;
  static const pixelsPerLonRadian = tileSize / (2 * math.pi);
  static const origin = Offset(128, 128);

  static const minMapOffset = Offset(215.4, 91.5);
  static const maxMapOffset = Offset(237.5, 110.4);

  static LatLng globalPointToLatLng(Offset point) {
    final lng = (point.dx - origin.dx) / pixelsPerLonDegree;
    final latRadians = (point.dy - origin.dy) / -pixelsPerLonRadian;
    final lat =
        (2 * math.atan(math.exp(latRadians)) - math.pi / 2) * (180 / math.pi);
    return LatLng(lat, lng);
  }

  /// すべてのポリゴンを内包する矩形の北西端がOffset(0,0)に、
  /// 南東端が[displaySize]のdx,dyのうち小さいほうになるように変換する
  Offset toLocalOffset(Size displaySize) {
    final zoom = math.min(displaySize.width / 18.9, displaySize.height / 22.1);
    final x = (dx - minMapOffset.dx) * zoom;
    final y = (dy - minMapOffset.dy) * zoom;
    return Offset(x, y);
  }
}
