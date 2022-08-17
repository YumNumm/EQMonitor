import '../../utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HypocenterPainterfromLatLng extends CustomPainter {
  HypocenterPainterfromLatLng({required this.hypocenter});

  final LatLng hypocenter;

  @override
  void paint(Canvas canvas, Size size) {
    // ×印を描く
    final offset = MapGlobalOffset.latLonToGlobalPoint(
      hypocenter,
    ).toLocalOffset(const Size(476, 927.4));
    {
      final textPainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: '×',
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1
                  ..color = const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(
          offset.dx - (textPainter.width / 2),
          offset.dy - (textPainter.height / 2),
        ),
      );
    }
    {
      final textPainter = TextPainter(
        text: const TextSpan(
          children: [
            TextSpan(
              text: '×',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(
          offset.dx - (textPainter.width / 2),
          offset.dy - (textPainter.height / 2),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant HypocenterPainterfromLatLng oldDelegate) => true;
}
