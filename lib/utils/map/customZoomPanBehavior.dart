import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class CustomZoomPanBehavior extends MapZoomPanBehavior {
  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final Path path = Path();
  Size renderBoxSize = Size.infinite;
  final RxDouble dy = 0.0.obs;
  final RxDouble dx = 0.0.obs;

  final sWavePaint = Paint()
    ..color = const Color.fromARGB(255, 255, 123, 0)
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;
  final pWavePaint = Paint()
    ..color = const Color.fromARGB(255, 0, 140, 255)
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;

  @override
  void onZooming(MapZoomDetails details) {
    if (details.localFocalPoint == null) return;

    super.onZooming(details);
  }

  @override
  void onPanning(MapPanDetails details) {
    if (details.localFocalPoint == null) return;

    super.onPanning(details);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print('PAINT');
    renderBoxSize = renderBox.size;

    calc();

    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    context.canvas
      ..drawCircle(
        Offset(renderBoxSize.width / 2, renderBoxSize.height / 2),
        (dx.value + dy.value) / 2 * 50,
        sWavePaint,
      )
      ..drawCircle(
        Offset(renderBoxSize.width / 2, renderBoxSize.height / 2),
        (dx.value + dy.value) / 2 * 100,
        pWavePaint,
      )
      ..drawLine(
        Offset(renderBoxSize.width / 2 - 10, renderBoxSize.height / 2 - 10),
        Offset(renderBoxSize.width / 2 + 10, renderBoxSize.height / 2 + 10),
        sWavePaint,
      )
      ..drawLine(
        Offset(renderBoxSize.width / 2 + 10, renderBoxSize.height / 2 - 10),
        Offset(renderBoxSize.width / 2 - 10, renderBoxSize.height / 2 + 10),
        sWavePaint,
      );

    context.canvas.restore();
    super.paint(context, offset);
  }

  // 表示領域からdx,dyを計算し、更新
  void calc() {
    if (latLngBounds == null) return;
    // 表示領域の取得
    final _northest = latLngBounds!.northeast;
    final _southest = latLngBounds!.southwest;
    final topLeft = LatLng(_northest.latitude, _southest.longitude);
    final topRight = LatLng(_northest.latitude, _northest.longitude);
    final bottomLeft = LatLng(_southest.latitude, _southest.longitude);
    final bottomRight = LatLng(_southest.latitude, _northest.longitude);
    // topLeft->bottomLeft
    final rightHeight = renderBoxSize.height /
        const Distance().as(LengthUnit.Kilometer, topLeft, topRight);
    // topRight->bottomRight
    final leftHeight = renderBoxSize.height /
        const Distance().as(LengthUnit.Kilometer, topRight, bottomRight);

    // topLight->topRight
    final topWidth = renderBoxSize.width /
        const Distance().as(LengthUnit.Kilometer, topLeft, topRight);
    // bottomLight->bottomRight
    final bottomWidth = renderBoxSize.width /
        const Distance().as(LengthUnit.Kilometer, bottomLeft, bottomRight);
    dy.value = (rightHeight + leftHeight) / 2;
    dx.value = (topWidth + bottomWidth) / 2;
  }
}
