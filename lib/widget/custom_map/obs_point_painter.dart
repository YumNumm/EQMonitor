import '../../utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../model/analyzed_kyoshin_kansokuten.dart';

class KyoshinKansokutenPainter extends CustomPainter {
  KyoshinKansokutenPainter({required this.obsPoints});

  final List<AnalyzedKoshinKansokuten> obsPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in obsPoints) {
      if (point.shindoColor == null) {
        continue;
      }
      final paint = Paint()
        ..color = point.shindoColor!
        ..isAntiAlias = true
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
            .toLocalOffset(const Size(476, 927.4)),
        0.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
