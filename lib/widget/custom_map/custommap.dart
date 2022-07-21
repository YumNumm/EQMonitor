import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/model/analyzed_point_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' show LatLng;

import 'map_global_offset.dart';

class CustomMap extends CustomPainter {
  CustomMap({
    required this.mapPolygons,
    required this.outlineStrokeWidth,
    required this.obsPoints,
  });
  List<MapPolygon> mapPolygons;
  List<AnalyzedPoint> obsPoints;
  double outlineStrokeWidth;

  final Paint paintBuilding = Paint()
    ..color = const Color.fromARGB(255, 17, 147, 0)
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final paintOutline = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = outlineStrokeWidth;

    //log(size.toString());
    final start = DateTime.now().millisecondsSinceEpoch;
    canvas.save();
    // Buildingsの描画開始
    for (final polygon in mapPolygons) {
      canvas
        ..drawPath(polygon.path, paintBuilding)
        ..drawPath(polygon.path, paintOutline);
    }
    // 観測点の描画
    for (final point in obsPoints) {
      final paint = Paint()
        ..color = point.shindoColor ?? Colors.grey
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.5;
      canvas.drawCircle(
        MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
            .toLocalOffset(size),
        0.6,
        paint,
      );
    }
    final end = DateTime.now().millisecondsSinceEpoch;
    // Buildings描画終了
    canvas.restore();
    //log('Draw Map: ${end - start}ms');
  }

  @override
  bool shouldRepaint(CustomMap oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons ||
        oldDelegate.outlineStrokeWidth != outlineStrokeWidth ||
        oldDelegate.obsPoints != obsPoints;
  }
}
