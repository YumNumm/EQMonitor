import 'package:collection/collection.dart';
import 'package:eqmonitor/model/setting/jma_intensity_color_model.dart';
import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/parameter_earthquake.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:eqmonitor/utils/intensity_estimate/intensity_estimate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

/// EEWの震源要素から距離減衰式により計算した予想震度を描画
class EewEstimatedIntensityWidget extends ConsumerWidget {
  const EewEstimatedIntensityWidget({required this.isDeveloper, super.key});

  final bool isDeveloper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewHistoryProvider).showEews;
    if (eews.isEmpty ||
        (eews.any(
          (e) => e.value.earthQuake?.isAssuming ?? false,
        ))) {
      return const SizedBox.shrink();
    }
    final result = <List<EstimatedEarthquakeParameterItem>>[];
    for (final eew in eews) {
      try {
        result.add(
          IntensityEstimateApi().estimateIntensity(
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
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {}
    }

    return CustomPaint(
      isComplex: true,
      painter: EstimatedIntensityPainter(
        estimatedShindoPointsGroupBy: result
            .expand((e) => e)
            .toList()
            .groupListsBy((element) => element.region.code),
        mapPolygons: ref.watch(mapAreaForecastLocalEProvider),
        colors: ref.watch(jmaIntensityColorProvider),
        alpha: 0.6,
        isDeveloper: isDeveloper,
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
    required this.isDeveloper,
    this.showIntensityPoint = false,
    this.alpha = 1,
  });

  List<MapPolygon> mapPolygons;
  final Map<int, List<EstimatedEarthquakeParameterItem>>
      estimatedShindoPointsGroupBy;
  JmaIntensityColorModel colors;
  final bool showIntensityPoint;
  final double alpha;
  final bool isDeveloper;

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
          if (maxIntensity < (isDeveloper ? 0 : 3.5)) {
            return;
          }
          for (final mapRegionPolygon in mapRegionPolygons) {
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
      oldDelegate.colors != colors ||
      oldDelegate.isDeveloper != isDeveloper;
}
