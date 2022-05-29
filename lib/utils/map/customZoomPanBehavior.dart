import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../earthquake.dart';

class CustomZoomPanBehavior extends MapZoomPanBehavior {
  final Logger logger = Get.find<Logger>();

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
    /*
    renderBoxSize = renderBox.size;
    const lat = 35;
    const lon = 135;

    calc();
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    // 左上からの距離(x)
    final topLeftPosition =
        earthQuake.mapShapeLayerController.pixelToLatLng(Offset.zero);
    final dxDistance = const Distance().as(
      LengthUnit.Kilometer,
      LatLng(topLeftPosition.latitude, topLeftPosition.longitude),
      LatLng(topLeftPosition.latitude, lon.toDouble()),
    );
    print(dxDistance);

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
      );

    context.canvas.restore();
    super.paint(context, offset);*/
  }

  // 表示領域からdx,dyを計算し、更新
  void calc() {
    if (latLngBounds == null) return;
    // 表示領域の取得
    final northest = latLngBounds!.northeast;
    final southest = latLngBounds!.southwest;
    final topLeft = LatLng(northest.latitude, southest.longitude);
    final topRight = LatLng(northest.latitude, northest.longitude);
    final bottomLeft = LatLng(southest.latitude, southest.longitude);
    final bottomRight = LatLng(southest.latitude, northest.longitude);
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
