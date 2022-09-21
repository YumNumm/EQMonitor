import 'package:collection/collection.dart';
import 'package:eqmonitor/api/int_calc/int_calc.dart';
import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/model/setting/jma_intensity_color_model.dart';
import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/parameter-earthquake.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

/// EEWの震源要素から距離減衰式により計算した予想震度を描画
class EewEstimatedIntensityWidget extends ConsumerWidget {
  const EewEstimatedIntensityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewHistoryProvider).showEews;
    if (eews.isEmpty ||
        (eews.any(
          (e) => e.value.earthQuake?.isAssuming ?? false,
        ))) {
      return const SizedBox.shrink();
    }
    final result = eews
        .map(
          (eew) => IntensityEstimateApi().estimateIntensity(
            jmaMagnitude: eew.value.earthQuake!.magnitude.value!,
            depth: eew.value.earthQuake!.hypoCenter.depth.value!.toDouble(),
            hypocenter: LatLng(
              eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                  .value,
              eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                  .value,
            ),
            obsPoints: ref.watch(parameterEarthquakeProvider).items,
          ),
        )
        .expand((e) => e)
        .toList();

    return CustomPaint(
      painter: EstimatedIntensityPainter(
        estimatedShindoPointsGroupBy:
            result.groupListsBy((element) => element.region.code),
        mapPolygons: ref.watch(mapAreaForecastLocalEProvider),
        colors: ref.watch(jmaIntensityColorProvider),
        alpha: 0.5,
      ),
    );
  }
}

/// 距離減衰式による予想震度描画
/// note: 描画時に予想震度を計算するため、再描画に時間がかかる
class EstimatedIntensityPainter extends CustomPainter {
  EstimatedIntensityPainter({
    required this.mapPolygons,
    required this.estimatedShindoPointsGroupBy,
    required this.colors,
    this.showIntensityPoint = false,
    this.alpha = 1,
  });

  List<MapPolygon> mapPolygons;
  final Map<int, List<EstimatedEarthquakeParameterItem>>
      estimatedShindoPointsGroupBy;
  JmaIntensityColorModel colors;
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
                  ..color = maxJmaIntensity
                      .fromUser(colors)
                      .withAlpha((alpha * 255).toInt())
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
  bool shouldRepaint(covariant EstimatedIntensityPainter oldDelegate) =>
      oldDelegate.showIntensityPoint != showIntensityPoint ||
      oldDelegate.estimatedShindoPointsGroupBy !=
          estimatedShindoPointsGroupBy ||
      oldDelegate.mapPolygons != mapPolygons ||
      oldDelegate.alpha != alpha ||
      oldDelegate.colors != colors;
}
