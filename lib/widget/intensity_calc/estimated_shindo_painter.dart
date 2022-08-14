import 'package:eqmonitor/api/int_calc/int_calc.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EstimatedShindoPainter extends CustomPainter {
  EstimatedShindoPainter({required this.estimatedShindoPoints});

  final List<EstimatedShindoPoint> estimatedShindoPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in estimatedShindoPoints) {
      // 計測予想震度が0以下なら描画しない
      if (point.estimatedIntensity <= 0) {
        continue;
      }
      final offset =
          MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
              .toLocalOffset(const Size(476, 927.4));
      final paint = Paint()
        ..color = point.estimatedJmaIntensity.color
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.5;
      canvas.drawCircle(
        offset,
        1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant EstimatedShindoPainter oldDelegate) =>
      oldDelegate.estimatedShindoPoints != estimatedShindoPoints;
}
