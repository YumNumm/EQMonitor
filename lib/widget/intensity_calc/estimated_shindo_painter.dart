import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../api/int_calc/int_calc.dart';
import '../../const/kmoni/jma_intensity.dart';
import '../../const/prefecture/area_forecast_local_eew.model.dart';

class EstimatedShindoPainter extends CustomPainter {
  EstimatedShindoPainter({
    required this.mapPolygons,
    required this.estimatedShindoPointsGroupBy,
    this.showIntensityPoint = false,
    this.alpha = 1,
  });

  List<MapPolygon> mapPolygons;
  final Map<int, List<EstimatedEarthquakeParameterItem>>
      estimatedShindoPointsGroupBy;
  final bool showIntensityPoint;
  final double alpha;

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
            if (maxIntensity < 0) {
              continue;
            }
            canvas
              ..drawPath(
                mapRegionPolygon.path,
                Paint()
                  ..color =
                      maxJmaIntensity.color.withAlpha((alpha * 255).toInt())
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
      oldDelegate.mapPolygons != mapPolygons ||
      oldDelegate.alpha != alpha;
}
