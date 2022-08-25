import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../schema/dmdata/commonHeader.dart';
import '../../schema/dmdata/eew-information/eew-infomation.dart';
import '../../utils/map/map_global_offset.dart';

class EewHypocenterNormalPainter extends CustomPainter {
  EewHypocenterNormalPainter({
    required this.travelTime,
    required this.eew,
    required this.opacity,
    required this.onTestStarted,
  });

  MapEntry<CommonHead, EEWInformation> eew;
  final List<TravelTimeTable> travelTime;
  double opacity = 1;
  DateTime? onTestStarted;

  @override
  void paint(Canvas canvas, Size size) {
    if (eew.value.earthQuake?.hypoCenter.coordinateComponent.latitude != null &&
        eew.value.earthQuake?.hypoCenter.coordinateComponent.longitude !=
            null) {
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!.value,
          eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!.value,
        ),
      ).toLocalOffset(const Size(476, 927.4));

      // ×印を描く

      canvas
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color =
                const Color.fromARGB(255, 255, 255, 255).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color =
                const Color.fromARGB(255, 255, 255, 255).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );

      // 到達予想円
      final travel = TravelTimeApi(travelTime: travelTime).getValue(
        eew.value.earthQuake!.hypoCenter.depth.value!,
        ((onTestStarted != null)
                    ? eew.value.earthQuake!.originTime!
                        .add(DateTime.now().difference(onTestStarted!))
                        .difference(
                          eew.value.earthQuake!.originTime!,
                        )
                    : DateTime.now().difference(
                        eew.value.earthQuake!.originTime!,
                      ))
                .inMilliseconds /
            1000,
      );
      if (travel == null) {
        return;
      }
      final sOffsets = <Offset>[];
      final pOffsets = <Offset>[];

      for (final bearing in List<int>.generate(360, (index) => index)) {
        sOffsets.add(
          MapGlobalOffset.latLonToGlobalPoint(
            const Distance().offset(
              LatLng(
                eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                    .value,
                eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                    .value,
              ),
              (travel.sDistance * 1000).toInt(),
              bearing,
            ),
          ).toLocalOffset(const Size(476, 927.4)),
        );
        pOffsets.add(
          MapGlobalOffset.latLonToGlobalPoint(
            const Distance().offset(
              LatLng(
                eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                    .value,
                eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                    .value,
              ),
              (travel.pDistance * 1000).toInt(),
              bearing,
            ),
          ).toLocalOffset(const Size(476, 927.4)),
        );
      }

      canvas
        ..drawPath(
          Path()..addPolygon(sOffsets, true),
          Paint()
            ..color = const Color.fromARGB(255, 255, 140, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        )
        ..drawPath(
          Path()..addPolygon(pOffsets, true),
          Paint()
            ..color = const Color.fromARGB(255, 0, 102, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.3,
        );
    }
  }

  @override
  bool shouldRepaint(covariant EewHypocenterNormalPainter oldDelegate) =>
      oldDelegate.eew != eew ||
      oldDelegate.travelTime != travelTime ||
      oldDelegate.opacity != opacity ||
      oldDelegate.onTestStarted != onTestStarted;
}
