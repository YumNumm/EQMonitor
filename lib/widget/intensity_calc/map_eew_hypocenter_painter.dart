import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HypocenterPainterfromLatLng extends CustomPainter {
  HypocenterPainterfromLatLng({required this.hypocenter});

  final LatLng hypocenter;

  @override
  void paint(Canvas canvas, Size size) {
    // ×印を描く
    TextPainter(
      text: const TextSpan(
        children: [
          TextSpan(
            text: '×',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 17, 0),
              fontSize: 20,
            ),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(
        canvas,
        MapGlobalOffset.latLonToGlobalPoint(
          hypocenter,
        ).toLocalOffset(const Size(476, 927.4)),
      );
  }

  @override
  bool shouldRepaint(covariant HypocenterPainterfromLatLng oldDelegate) =>
      oldDelegate.hypocenter != hypocenter;
}
