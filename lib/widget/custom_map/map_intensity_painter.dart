import 'dart:developer';

import '../../model/setting/jma_intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../const/prefecture/area_forecast_local_eew.model.dart';
import '../../schema/dmdata/commonHeader.dart';
import '../../schema/dmdata/eew-information/eew-infomation.dart';

class EewIntensityPainter extends CustomPainter {
  EewIntensityPainter({
    required this.mapPolygons,
    required this.eews,
    required this.colors,
  });
  List<MapPolygon> mapPolygons;
  Iterable<MapEntry<CommonHead, EEWInformation>> eews;
  JmaIntensityColorModel colors;

  @override
  void paint(Canvas canvas, Size size) {
    log('描画', name: 'EewIntensityPainter');

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
                    ..color = region.forecastMaxInt.from.fromUser(colors)
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
          } on Exception catch (e) {
            Logger().e(e, region.code);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(EewIntensityPainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons || oldDelegate.eews != eews;
  }
}
