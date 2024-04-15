import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:eqmonitor/core/extension/kyoshin_color_map_model.dart';
import 'package:eqmonitor/core/provider/kmoni/model/kyoshin_color_map_model.dart';
import 'package:eqmonitor/core/provider/kmoni/provider/kmoni_color_provider.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniScaleWidget extends ConsumerWidget {
  const KmoniScaleWidget({
    super.key,
    this.showText = true,
    this.markers = const [],
  });

  final bool showText;
  final List<double> markers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMap = ref.watch(kyoshinColorMapProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return CustomPaint(
      size: Size.infinite,
      painter: _KmoniScalePainter(
        colorMap: colorMap,
        lineColor: colorScheme.onSurface,
        showText: showText,
        markers: markers,
      ),
    );
  }
}

class _KmoniScalePainter extends CustomPainter {
  _KmoniScalePainter({
    required this.colorMap,
    this.lineColor = Colors.black,
    this.showText = true,
    this.markers = const [],
  });

  final List<KyoshinColorMapModel> colorMap;

  /// 区切り線の色
  final Color lineColor;

  final bool showText;
  final List<double> markers;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    drawBackground(canvas, rect);
    drawRealtimeIntensityChange(canvas, rect, drawText: showText);
    for (final e in markers) {
      drawMarker(canvas, rect, e);
    }
  }

  // 背景のグラデーションを描画
  void drawBackground(Canvas canvas, Rect rect) => canvas.drawRect(
        rect,
        Paint()
          ..shader = ui.Gradient.linear(
            rect.centerLeft,
            rect.centerRight,
            colorMap.map((e) => Color.fromARGB(255, e.r, e.g, e.b)).toList(),
            colorMap.mapIndexed((index, e) => index / colorMap.length).toList(),
          ),
      );

  // 震度の切り替わりに線を描画
  void drawIntensityChangeLine(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    // 震度の切り替わりを描画
    JmaForecastIntensity? lastIntensity;
    colorMap.forEachIndexed((index, element) {
      final intensity = element.intensity.toJmaForecastIntensity;
      if (lastIntensity != null && lastIntensity != intensity) {
        final x = rect.width * (index / colorMap.length);
        canvas.drawLine(
          Offset(x, rect.top),
          Offset(x, rect.bottom),
          paint,
        );
      }
      lastIntensity = intensity;
    });
  }

  // リアルタイム震度が整数値の場合、その震度を描画
  void drawRealtimeIntensityChange(
    Canvas canvas,
    Rect rect, {
    bool drawText = true,
  }) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    // 震度の切り替わりを描画
    colorMap.forEachIndexed((index, element) {
      if (element.intensity % 1 != 0) {
        return;
      }
      final color =
          (element.color.computeLuminance() > 0.5 ? Colors.black : Colors.white)
              .withOpacity(0.8);
      final x = rect.width * (index / colorMap.length) + rect.left;
      final width = rect.width / colorMap.length;
      canvas.drawLine(
        Offset(x + width, rect.top),
        Offset(x + width, rect.bottom),
        paint..color = color,
      );

      if (drawText) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: element.intensity.toStringAsFixed(0),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFamily: monoFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final offset = Offset(
          x +
              width / 2 +
              switch (element.intensity) {
                7.0 => -textPainter.width,
                _ => textPainter.width / 2,
              } +
              rect.left,
          rect.bottom - textPainter.height,
        );
        textPainter.paint(
          canvas,
          offset,
        );
      }
    });
  }

  // 赤三角
  void drawMarker(Canvas canvas, Rect rect, double intensity) {
    final lower = colorMap.lastWhereOrNull((e) => e.intensity <= intensity);
    final upper = colorMap.firstWhereOrNull((e) => e.intensity >= intensity);

    final double x;
    if (lower == null) {
      x = 0;
    } else if (upper == null) {
      x = 1;
    } else {
      x = (colorMap.indexOf(lower) +
              (intensity - lower.intensity) /
                  (upper.intensity - lower.intensity)) /
          colorMap.length;
    }

    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    final path = Path()
      ..moveTo(rect.width * x - 5, rect.top)
      ..lineTo(rect.width * x + 5, rect.top)
      ..lineTo(rect.width * x, rect.top + 10)
      ..close();

    canvas
      ..drawPath(path, paint)
      ..drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(_KmoniScalePainter oldDelegate) =>
      oldDelegate.colorMap != colorMap ||
      oldDelegate.showText != showText ||
      !const ListEquality<double>().equals(oldDelegate.markers, markers);

  @override
  bool shouldRebuildSemantics(_KmoniScalePainter oldDelegate) => false;
}
