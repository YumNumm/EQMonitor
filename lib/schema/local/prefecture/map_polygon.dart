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


