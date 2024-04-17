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
    this.position = KmoniIntensityPosition.inside,
  });

  final bool showText;
  final List<double> markers;
  final KmoniIntensityPosition position;

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
        position: position,
        onSurface: colorScheme.onSurface,
      ),
    );
  }
}

class _KmoniScalePainter extends CustomPainter {
  _KmoniScalePainter({
    required this.colorMap,
    required this.lineColor,
    required this.onSurface,
    required this.showText,
    required this.markers,
    required this.position,
  });

  final List<KyoshinColorMapModel> colorMap;

  /// 区切り線の色
  final Color lineColor;

  final bool showText;
  final List<double> markers;

  final KmoniIntensityPosition position;
  final Color onSurface;

  static const _kUnderPadding = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = switch (position) {
      KmoniIntensityPosition.inside =>
        Rect.fromLTWH(0, 0, size.width, size.height),
      KmoniIntensityPosition.under =>
        Rect.fromLTWH(0, 0, size.width, size.height - _kUnderPadding),
    };

    drawBackground(canvas, rect);
    drawRealtimeIntensityChange(
      canvas,
      rect,
      drawText: showText,
      position: position,
    );
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
        final shouldAdd = position == KmoniIntensityPosition.under;
        canvas.drawLine(
          Offset(x, rect.top),
          Offset(x, rect.bottom + (shouldAdd ? 4 : 0)),
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
    KmoniIntensityPosition position = KmoniIntensityPosition.inside,
  }) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    // 震度の切り替わりを描画
    colorMap.forEachIndexed((index, element) {
      if (element.intensity % 1 != 0) {
        return;
      }
      final color = (element.color.computeLuminance() > 0.5
          ? Colors.black
          : Colors.white);
      final x = rect.width * (index / colorMap.length) + rect.left;
      final width = rect.width / colorMap.length;
      final shouldAdd = position == KmoniIntensityPosition.under;
      canvas.drawLine(
        Offset(x + width / 2, rect.top),
        Offset(x + width / 2, rect.bottom),
        paint..color = color,
      );
      if (shouldAdd) {
        canvas.drawLine(
          Offset(x + width / 2, rect.bottom),
          Offset(x + width / 2, rect.bottom + (shouldAdd ? 4 : 0)),
          paint..color = onSurface,
        );
      }

      if (drawText) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: element.intensity.toStringAsFixed(0),
            style: TextStyle(
              color: shouldAdd ? onSurface : color,
              fontSize: 10,
              fontFamily: monoFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final offset = switch (position) {
          KmoniIntensityPosition.inside => Offset(
              x +
                  switch (element.intensity) {
                    7.0 => -textPainter.width,
                    _ => 4,
                  } +
                  rect.left,
              rect.bottom - textPainter.height,
            ),
          KmoniIntensityPosition.under => Offset(
              x + rect.left - textPainter.width / 2,
              rect.bottom + _kUnderPadding / 2,
            ),
        };
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
      !const ListEquality<double>().equals(oldDelegate.markers, markers) ||
      oldDelegate.position != position;

  @override
  bool shouldRebuildSemantics(_KmoniScalePainter oldDelegate) => false;
}

enum KmoniIntensityPosition {
  inside,
  under,
  ;
}
