import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../utils/map/map_global_offset.dart';

class HypocenterPainterfromLatLng extends CustomPainter {
  HypocenterPainterfromLatLng({required this.hypocenter});

  final LatLng hypocenter;

  @override
  void paint(Canvas canvas, Size size) {
    // ×印を描く
    final offset = MapGlobalOffset.latLonToGlobalPoint(
      hypocenter,
    ).toLocalOffset(const Size(476, 927.4));

    // ×印を描く

    canvas
      ..drawLine(
        Offset(offset.dx - 4, offset.dy - 4),
        Offset(offset.dx + 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 0, 0, 0)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      )
      ..drawLine(
        Offset(offset.dx + 4, offset.dy - 4),
        Offset(offset.dx - 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 0, 0, 0)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      )
      ..drawLine(
        Offset(offset.dx - 4, offset.dy - 4),
        Offset(offset.dx + 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 255, 255, 255)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3,
      )
      ..drawLine(
        Offset(offset.dx + 4, offset.dy - 4),
        Offset(offset.dx - 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 255, 255, 255)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3,
      )
      ..drawLine(
        Offset(offset.dx - 4, offset.dy - 4),
        Offset(offset.dx + 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 255, 0, 0)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      )
      ..drawLine(
        Offset(offset.dx + 4, offset.dy - 4),
        Offset(offset.dx - 4, offset.dy + 4),
        Paint()
          ..color = const Color.fromARGB(255, 255, 0, 0)
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
  }

  @override
  bool shouldRepaint(covariant HypocenterPainterfromLatLng oldDelegate) => true;
}
