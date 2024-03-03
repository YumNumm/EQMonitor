import 'dart:typed_data';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_lg_intensity_icon.dart';
import 'package:eqmonitor/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screenshot/screenshot.dart';

class MapComponentsRenderer {
  final ScreenshotController _controller = ScreenshotController();
  Future<Uint8List> renderIntensityIcon(
    BuildContext context,
    JmaIntensity intensity,
    IntensityIconType type,
  ) async {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final result = await _controller.captureFromWidget(
      ProviderScope(
        parent: container,
        child: JmaIntensityIcon(
          intensity: intensity,
          type: type,
        ),
      ),
      context: context,
      pixelRatio: pixelRatio,
    );
    return result;
  }

  Future<Uint8List> renderLpgmIntensityIcon(
    BuildContext context,
    JmaLgIntensity intensity,
    IntensityIconType type,
  ) async {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final result = await _controller.captureFromWidget(
      ProviderScope(
        parent: container,
        child: JmaLgIntensityIcon(
          intensity: intensity,
          type: type,
        ),
      ),
      context: context,
      pixelRatio: pixelRatio,
    );
    return result;
  }

  Future<Uint8List> renderHypocenterIcon(
    BuildContext context,
    HypocenterType type,
  ) async {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final result = await _controller.captureFromWidget(
      CustomPaint(
        painter: _HypocenterPainter(type: type),
        size: const Size(80, 80),
      ),
      context: context,
      pixelRatio: pixelRatio,
    );
    return result;
  }

  static Widget hypocenterIcon() => const CustomPaint(
        painter: _HypocenterPainter(type: HypocenterType.normal),
        size: Size(80, 80),
      );
}

class _HypocenterPainter extends CustomPainter {
  const _HypocenterPainter({
    required this.type,
  });
  final HypocenterType type;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(size.width / 2, size.height / 2);
    if (type == HypocenterType.lowPrecise) {
      // 円を描く
      canvas
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = Colors.black
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = Colors.white
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawCircle(
          offset,
          25,
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10,
        );
    } else if (type == HypocenterType.normal) {
      // ×印を描く
      canvas
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 25,
        )
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 18,
        )
        ..drawLine(
          Offset(offset.dx - 20, offset.dy - 20),
          Offset(offset.dx + 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12,
        )
        ..drawLine(
          Offset(offset.dx + 20, offset.dy - 20),
          Offset(offset.dx - 20, offset.dy + 20),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _) => false;
}

enum HypocenterType {
  normal,
  lowPrecise,
  ;
}
