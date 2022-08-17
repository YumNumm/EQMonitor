import '../../const/prefecture/area_forecast_local_eew.model.dart';
import 'package:flutter/material.dart';

class MapBasePainter extends CustomPainter {
  MapBasePainter({
    required this.mapPolygons,
    required this.isDarkMode,
  });
  List<MapPolygon> mapPolygons;
  bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final paintBuilding = Paint()
      ..color = isDarkMode
          ? const Color.fromARGB(255, 95, 95, 95)
          : const Color.fromARGB(255, 231, 230, 230)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final paintOutline = Paint()
      ..color = isDarkMode
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 190, 190, 190)
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    for (final polygon in mapPolygons) {
      canvas
        ..drawPath(polygon.path, paintBuilding)
        ..drawPath(polygon.path, paintOutline);
    }
  }

  @override
  bool shouldRepaint(MapBasePainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons;
  }
}
