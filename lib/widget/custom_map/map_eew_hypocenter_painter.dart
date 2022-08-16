import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EewHypocenterPainter extends CustomPainter {
  EewHypocenterPainter({required this.eews});

  Iterable<MapEntry<CommonHead, EEWInformation>> eews;

  @override
  void paint(Canvas canvas, Size size) {
    for (final eew in eews) {
      if (eew.value.earthQuake?.hypoCenter.coordinateComponent.latitude !=
              null &&
          eew.value.earthQuake?.hypoCenter.coordinateComponent.longitude !=
              null) {
        if (eew.value.earthQuake?.isAssuming ?? true) {
          final offset = MapGlobalOffset.latLonToGlobalPoint(
            LatLng(
              eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                  .value,
              eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                  .value,
            ),
          ).toLocalOffset(const Size(476, 927.4));
          // 丸で描画
          canvas
            ..drawCircle(
              MapGlobalOffset.latLonToGlobalPoint(
                LatLng(
                  eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                      .value,
                  eew.value.earthQuake!.hypoCenter.coordinateComponent
                      .longitude!.value,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
              5,
              Paint()
                ..color = const Color.fromARGB(255, 121, 121, 121)
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1,
            )
            ..drawCircle(
              MapGlobalOffset.latLonToGlobalPoint(
                LatLng(
                  eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                      .value,
                  eew.value.earthQuake!.hypoCenter.coordinateComponent
                      .longitude!.value,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
              5,
              Paint()
                ..color = const Color.fromARGB(255, 226, 226, 226)
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            )
            ..drawCircle(
              MapGlobalOffset.latLonToGlobalPoint(
                LatLng(
                  eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                      .value,
                  eew.value.earthQuake!.hypoCenter.coordinateComponent
                      .longitude!.value,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
              3,
              Paint()
                ..color = eew.value.intensity?.maxint.from.color ??
                    const Color.fromARGB(255, 255, 17, 0)
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            );
        } else {
          final offset = MapGlobalOffset.latLonToGlobalPoint(
            LatLng(
              eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                  .value,
              eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                  .value,
            ),
          ).toLocalOffset(const Size(476, 927.4));
          // ×印を描く
          {
            final textPainter = TextPainter(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '×',
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              textDirection: TextDirection.ltr,
            )..layout();
            textPainter.paint(
              canvas,
              Offset(
                offset.dx - (textPainter.width / 2),
                offset.dy - (textPainter.height / 2),
              ),
            );
          }
          {
            final textPainter = TextPainter(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '×',
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 0.3
                        ..color = const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              textDirection: TextDirection.ltr,
            )..layout();
            textPainter.paint(
              canvas,
              Offset(
                offset.dx - (textPainter.width / 2),
                offset.dy - (textPainter.height / 2),
              ),
            );
          }
          {
            final textPainter = TextPainter(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '×',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              textDirection: TextDirection.ltr,
            )..layout();
            textPainter.paint(
              canvas,
              Offset(
                offset.dx - (textPainter.width / 2),
                offset.dy - (textPainter.height / 2),
              ),
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant EewHypocenterPainter oldDelegate) =>
      oldDelegate.eews != eews;
}
