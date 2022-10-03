import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../const/prefecture/area_forecast_local_eew.model.dart';
import '../../model/setting/jma_intensity_color_model.dart';
import '../../schema/dmdata/commonHeader.dart';
import '../../schema/dmdata/eew-information/eew-infomation.dart';

/// 緊急地震速報の予想震度
/// 電文内の予想震度(震度4以上)を表示
class EewIntensityWidget extends ConsumerWidget {
  const EewIntensityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));
    return RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: EewIntensityPainter(
          colors: ref.watch(jmaIntensityColorProvider),
          eews: eews,
          mapPolygons: mapSource,
        ),
        size: const Size(476, 927.4),
      ),
    );
  }
}

/// 緊急地震速報の予想震度を描画
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
    for (final eew in eews) {
      if (eew.value.intensity?.region != null) {
        for (final region in eew.value.intensity!.region) {
          // region.codeが一致するMapPolygonを探す
          try {
            final mapRegionPolygons = mapPolygons.where(
              (element) => element.code == region.code,
            );
            for (final mapPolygon in mapRegionPolygons.toList()) {
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
              // EEW警報の対象だった場合は赤枠を描画
              // その枠の周りを黒枠で囲む
              // if (region.isWarning) {
              //   canvas
              //     ..drawPath(
              //       mapPolygon.path,
              //       Paint()
              //         ..color = const Color.fromARGB(255, 255, 255, 255)
              //         ..strokeWidth = 0.5
              //         ..isAntiAlias = true
              //         ..style = PaintingStyle.stroke,
              //     )
              //     ..drawPath(
              //       mapPolygon.path,
              //       Paint()
              //         ..color = const Color.fromARGB(255, 255, 0, 0)
              //         ..strokeWidth = 0.1
              //         ..isAntiAlias = true
              //         ..style = PaintingStyle.stroke,
              //     );
              // }
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
