import 'dart:math';

import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:simplify/simplify.dart';

class MapShrinker {
  MapShrinker._();

  static List<GlobalPoint> shrink({
    required int zoomLevel,
    required List<GlobalPoint> points,
  }) =>
      simplify(
        points.map((e) => Point(e.x * zoomLevel, e.y * zoomLevel)).toList(),
        tolerance: 1,
        highestQuality: false,
      ).map((e) => GlobalPoint(e.x / zoomLevel, e.y / zoomLevel)).toList();
}
