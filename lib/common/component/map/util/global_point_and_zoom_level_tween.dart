import 'package:eqmonitor/common/component/map/utils/web_mercator_projection.dart';
import 'package:flutter/material.dart';

class GlobalPointAndZoomLevelTween
    extends Tween<(GlobalPoint, double zoomLevel)> {
  GlobalPointAndZoomLevelTween({
    super.begin,
    super.end,
  });

  @override
  (GlobalPoint, double zoomLevel) lerp(double t) {
    if (begin == null) {
      throw ArgumentError.notNull();
    }
    final beginPoint = begin!.$1;
    final beginZoomLevel = begin!.$2;
    final endPoint = end!.$1;
    final endZoomLevel = end!.$2;

    final targetPoint = GlobalPoint(
      beginPoint.x + (endPoint.x - beginPoint.x) * t,
      beginPoint.y + (endPoint.y - beginPoint.y) * t,
    );

    final targetZoomLevel =
        beginZoomLevel + (endZoomLevel - beginZoomLevel) * t;
    return (targetPoint, targetZoomLevel);
  }
}
