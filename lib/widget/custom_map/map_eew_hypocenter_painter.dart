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
          // 丸で描画
          canvas.drawCircle(
            MapGlobalOffset.latLonToGlobalPoint(
              LatLng(
                eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                    .value,
                eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                    .value,
              ),
            ).toLocalOffset(const Size(476, 927.4)),
            10,
            Paint()
              ..color = Colors.red
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.round,
          );
        } else {
          // ×印を描く
          TextPainter(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '×',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            textDirection: TextDirection.ltr,
          )
            ..layout()
            ..paint(
              canvas,
              MapGlobalOffset.latLonToGlobalPoint(
                LatLng(
                  eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                      .value,
                  eew.value.earthQuake!.hypoCenter.coordinateComponent
                      .longitude!.value,
                ),
              ).toLocalOffset(const Size(476, 927.4)),
            );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant EewHypocenterPainter oldDelegate) =>
      oldDelegate.eews != eews;
}
