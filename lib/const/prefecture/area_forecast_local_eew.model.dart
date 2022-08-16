import 'package:flutter/cupertino.dart';

@immutable
class MapPolygon {
  const MapPolygon({
    required this.code,
    required this.name,
    required this.path,
    required this.points,
  });

  final int code;
  final String name;
  final Path path;
  final List<Offset> points;
}

enum MapType {
  /// 緊急地震速報／府県予報区
  areaForecastLocalEew,

  /// 地震情報／細分区域
  areaForecastLocalE,
}
