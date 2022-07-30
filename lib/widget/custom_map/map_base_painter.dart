import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:flutter/material.dart';

class MapBasePainter extends CustomPainter {
  MapBasePainter({
    required this.mapPolygons,
    required this.outlineStrokeWidth,
  });
  List<MapPolygon> mapPolygons;
  double outlineStrokeWidth;

  final Paint paintBuilding = Paint()
    ..color = const Color.fromARGB(161, 66, 66, 66)
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final paintOutline = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = outlineStrokeWidth;

    for (final polygon in mapPolygons) {
      canvas
        ..drawPath(polygon.path, paintBuilding)
        ..drawPath(polygon.path, paintOutline);
    }
  }

  @override
  bool shouldRepaint(MapBasePainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons ||
        oldDelegate.outlineStrokeWidth != outlineStrokeWidth;
  }
}
