import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MapIntensityPainter extends CustomPainter {
  MapIntensityPainter({
    required this.mapPolygons,
    required this.outlineStrokeWidth,
    required this.eews,
  });
  List<MapPolygon> mapPolygons;
  double outlineStrokeWidth;
  Iterable<MapEntry<CommonHead, EEWInformation>> eews;

  final Paint paintBuilding = Paint()
    ..color = const Color.fromARGB(255, 17, 147, 0)
    ..isAntiAlias = true
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    for (final eew in eews) {
      if (eew.value.intensity?.region != null) {
        //Logger().i(eew.value.intensity?.region);
        for (final region in eew.value.intensity!.region) {
          // region.codeが一致するMapPolygonを探す
          try {
            final mapPolygon = mapPolygons.firstWhere(
              (element) => element.code == region.code,
            );
            canvas
              ..drawPath(
                mapPolygon.path,
                Paint()
                  ..color = region.forecastMaxInt.from.color
                  ..isAntiAlias = true
                  ..strokeCap = StrokeCap.round,
              )
              ..drawPath(
                mapPolygon.path,
                Paint()
                  ..color = const Color.fromARGB(255, 255, 255, 255)
                  ..isAntiAlias = true
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = outlineStrokeWidth,
              );
          } on Error catch (e) {
            Logger().e(e, region.code);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(MapIntensityPainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons ||
        oldDelegate.outlineStrokeWidth != outlineStrokeWidth ||
        oldDelegate.eews != eews;
  }
}
