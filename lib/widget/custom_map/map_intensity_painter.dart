import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MapIntensityPainter extends CustomPainter {
  MapIntensityPainter({
    required this.mapPolygons,
    required this.eews,
  });
  List<MapPolygon> mapPolygons;
  Iterable<MapEntry<CommonHead, EEWInformation>> eews;

  @override
  void paint(Canvas canvas, Size size) {
    for (final eew in eews) {
      if (eew.value.intensity?.region != null) {
        for (final region in eew.value.intensity!.region) {
          // region.codeが一致するMapPolygonを探す
          try {
            final mapRegionPolygons = mapPolygons.where(
              (element) => element.code == region.code,
            );
            for (final mapPolygon in mapRegionPolygons) {
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
                    ..style = PaintingStyle.stroke,
                );
            }
          } catch (e) {
            Logger().e(e, region.code);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(MapIntensityPainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons || oldDelegate.eews != eews;
  }
}
