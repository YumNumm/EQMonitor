import 'dart:developer';

import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../model/analyzed_point_model.dart';

class ObsPointPainter extends CustomPainter {
  ObsPointPainter({required this.obsPoints});

  final List<AnalyzedPoint> obsPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in obsPoints) {
      final paint = Paint()
        ..color = point.shindoColor ?? Colors.grey
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.5;
      canvas.drawCircle(
        MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
            .toLocalOffset(const Size(476, 927.4)),
        0.6,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
