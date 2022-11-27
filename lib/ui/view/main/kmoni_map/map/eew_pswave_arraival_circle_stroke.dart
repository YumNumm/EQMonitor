import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/provider/earthquake/kmoni_controller.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../../../../provider/earthquake/eew_provider.dart';

/// 緊急地震速報のP・S波到達予想円の枠を表示するWidget
class EewPswaveArraivalCircleStrokeWidgets extends ConsumerWidget {
  const EewPswaveArraivalCircleStrokeWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 精度が低いEEWを除いたEEWのリスト
    final eews = ref
        .watch(eewProvider.select((value) => value.showEews))
        .where(
          (e) =>
              e.eew.earthquake?.condition != '仮定震源要素' &&
              e.eew.earthquake?.hypocenter.accuracy.epicenters[0] != 1,
        )
        .toList();
    final travelTimeTables = ref.watch(travelTimeProvider);
    final onTestStarted = ref.watch(kmoniProvider).testCaseStartTime;

    return CustomPaint(
      willChange: true,
      painter: _EewPswaveArraivalCircleStrokePainter(
        eews: eews,
        onTestStarted: onTestStarted,
        travelTimeTables: travelTimeTables,
      ),
    );
  }
}

class _EewPswaveArraivalCircleStrokePainter extends CustomPainter {
  _EewPswaveArraivalCircleStrokePainter({
    required this.travelTimeTables,
    required this.eews,
    required this.onTestStarted,
  });

  final List<EewTelegram> eews;
  final List<TravelTimeTable> travelTimeTables;
  final DateTime? onTestStarted;

  @override
  void paint(Canvas canvas, Size size) {
    for (final eew in eews) {
      if (eew.eew.earthquake?.hypocenter.coordinate.latitude != null &&
          eew.eew.earthquake?.hypocenter.coordinate.longitude != null) {
        final travel = TravelTimeApi(travelTime: travelTimeTables).getValue(
          eew.eew.earthquake!.hypocenter.depth.value!,
          ((onTestStarted != null)
                      ? eew.eew.earthquake!.originTime!
                          .add(DateTime.now().difference(onTestStarted!))
                          .difference(
                            eew.eew.earthquake!.originTime!,
                          )
                      : DateTime.now().difference(
                          eew.eew.earthquake!.originTime!,
                        ))
                  .inMilliseconds /
              1000,
        );

        if (travel == null) {
          continue;
        }
        final sOffsets = <Offset>[];
        final pOffsets = <Offset>[];

        for (final bearing in List<int>.generate(360, (index) => index)) {
          if (travel.sDistance != 0) {
            sOffsets.add(
              MapGlobalOffset.latLonToGlobalPoint(
                const Distance().offset(
                  LatLng(
                    eew.eew.earthquake!.hypocenter.coordinate.latitude!.value,
                    eew.eew.earthquake!.hypocenter.coordinate.longitude!.value,
                  ),
                  (travel.sDistance * 1000).toInt(),
                  bearing,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
            );
          }
          if (travel.pDistance != 0) {
            pOffsets.add(
              MapGlobalOffset.latLonToGlobalPoint(
                const Distance().offset(
                  LatLng(
                    eew.eew.earthquake!.hypocenter.coordinate.latitude!.value,
                    eew.eew.earthquake!.hypocenter.coordinate.longitude!.value,
                  ),
                  (travel.pDistance * 1000).toInt(),
                  bearing,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
            );
          }
        }
        final isWarning = eew.eew.isWarning ??
            eew.eew.comments?.warning?.codes.contains(201) ??
            false;
        canvas
          ..drawPath(
            Path()..addPolygon(sOffsets, true),
            Paint()
              ..color = isWarning
                  ? const Color.fromARGB(255, 255, 0, 0).withOpacity(0.6)
                  : const Color.fromARGB(255, 255, 149, 0).withOpacity(0.6)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1,
          )
          ..drawPath(
            Path()..addPolygon(pOffsets, true),
            Paint()
              ..color = const Color.fromARGB(255, 0, 0, 255)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.0,
          );
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant _EewPswaveArraivalCircleStrokePainter oldDelegate,
  ) =>
      oldDelegate.eews != eews ||
      oldDelegate.onTestStarted != onTestStarted ||
      oldDelegate.travelTimeTables != travelTimeTables;
}
