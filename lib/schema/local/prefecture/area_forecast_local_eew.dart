import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:flutter/foundation.dart';

@immutable
class AreaForecastLocalEew extends MapPolygon {
  const AreaForecastLocalEew({
    required super.code,
    required super.name,
    required super.path,
    required super.points,
  });
}
