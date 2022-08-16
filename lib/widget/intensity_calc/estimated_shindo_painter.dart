import 'package:eqmonitor/api/int_calc/int_calc.dart';
import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../const/kmoni/jma_intensity.dart';

class EstimatedShindoPainter extends CustomPainter {
  EstimatedShindoPainter({
    required this.mapPolygons,
    required this.estimatedShindoPointsGroupBy,
    this.showIntensityPoint = false,
  });

  List<MapPolygon> mapPolygons;
  final Map<int, List<EstimatedEarthquakeParameterItem>>
      estimatedShindoPointsGroupBy;
  final bool showIntensityPoint;

  @override
  void paint(Canvas canvas, Size size) {
    // 全てのestimatedShindoPointsGroupByに対して処理する
    estimatedShindoPointsGroupBy.forEach(
      (regionCode, estimatedShindoPoints) {
        try {
          // regionCodeが一致するMapPolygonを探す
          final mapRegionPolygons = mapPolygons.where(
            (element) => element.code == regionCode,
          );
          // 最大震度を求める
          final maxIntensity =
              estimatedShindoPoints.map((e) => e.estimatedIntensity).reduce(
                    (a, b) => a > b ? a : b,
                  );
          final maxJmaIntensity =
              JmaIntensity.toJmaIntensity(intensity: maxIntensity);
          for (final mapRegionPolygon in mapRegionPolygons) {
            canvas
              ..drawPath(
                mapRegionPolygon.path,
                Paint()
                  ..color = maxJmaIntensity.color
                  ..isAntiAlias = true
                  ..strokeCap = StrokeCap.round,
              )
              ..drawPath(
                mapRegionPolygon.path,
                Paint()
                  ..color = Colors.white
                  ..isAntiAlias = true
                  ..style = PaintingStyle.stroke,
              );
          }

          // 0 < int < 0.5のみ点を描く
          //for (final point in estimatedShindoPoints) {
          //  if (point.estimatedIntensity < 0 ||
          //      point.estimatedIntensity > 0.5) {
          //    continue;
          //  }
          //  final offset = MapGlobalOffset.latLonToGlobalPoint(
          //    LatLng(point.latitude, point.longitude),
          //  ).toLocalOffset(const Size(476, 927.4));
          //  canvas
          //    ..drawCircle(
          //      offset,
          //      1,
          //      Paint()
          //        ..color = point.estimatedJmaIntensity.color
          //        ..isAntiAlias = true
          //        ..style = PaintingStyle.fill,
          //    )
          //    ..drawCircle(
          //      offset,
          //      1,
          //      Paint()
          //        ..color = Colors.white
          //        ..isAntiAlias = true
          //        ..strokeWidth = 0.1
          //        ..style = PaintingStyle.stroke,
          //    );
          //}
        } on Exception catch (e) {
          Logger().e(e);
        }
      },
    );
  }

  @override
  bool shouldRepaint(covariant EstimatedShindoPainter oldDelegate) =>
      oldDelegate.showIntensityPoint != showIntensityPoint ||
      oldDelegate.estimatedShindoPointsGroupBy !=
          estimatedShindoPointsGroupBy ||
      oldDelegate.mapPolygons != mapPolygons;
}
