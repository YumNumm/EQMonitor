import 'dart:math';

import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/has_eew_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniMapWidget extends HookConsumerWidget {
  const KmoniMapWidget({
    super.key,
    required this.mapKey,
  });
  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    final kmoniState = ref
        .watch(kmoniViewModelProvider.select((value) => value.analyzedPoints));
    final kmoniSettingsState = ref.watch(kmoniSettingsProvider);
    final hasEew = ref.watch(hasEewProvider);
    return CustomPaint(
      painter: _KmoniPainter(
        state: state,
        kmoniState: kmoniState,
        settingsState: kmoniSettingsState,
        colorModel: ref.watch(intensityColorProvider),
        drawBorder: hasEew,
      ),
      size: Size.infinite,
      willChange: true,
    );
  }
}

class _KmoniPainter extends CustomPainter {
  _KmoniPainter({
    required this.state,
    required this.kmoniState,
    required this.settingsState,
    required this.colorModel,
    required this.drawBorder,
  });

  final MapState state;
  final List<AnalyzedKmoniObservationPoint>? kmoniState;
  final KmoniSettingsState settingsState;
  final IntensityColorModel colorModel;
  final bool drawBorder;

  @override
  void paint(Canvas canvas, Size size) {
    if (kmoniState == null) {
      return;
    }
    final zoomLevel = pow(state.zoomLevel, 1 / 2);
    final circleSize = switch (zoomLevel) {
      < 3 => 2.0,
      > 20 => min(zoomLevel, 10),
      _ => zoomLevel * 0.4,
    };

    for (final e in kmoniState!) {
      if (e.intensityValue == null) {
        continue;
      }

      final offset = state.globalPointToOffset(
        e.point.globalPoint,
      );
      // 画面外の場合は描画しない
      if (offset.dx < -10 ||
          offset.dx > size.width + 10 ||
          offset.dy < -10 ||
          offset.dy > size.height + 10) {
        continue;
      }
      // 任意のどれか
      final intensity = e.intensityValue!.toJmaForecastIntensity;

      if (settingsState.isUpper0Only) {
        if (intensity == null) {
          continue;
        }
        if (intensity == JmaForecastIntensity.zero) {
          // グレー
          final paint = Paint()
            ..color = Colors.grey.withOpacity(0.8)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
            offset,
            circleSize.toDouble(),
            paint,
          );
          if (drawBorder) {
            final paint = Paint()
              ..color = Colors.white.withOpacity(0.8)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1;
            canvas.drawCircle(
              offset,
              circleSize.toDouble(),
              paint,
            );
          }
          continue;
        }
      }
      if (settingsState.isShowIntensityIcon) {
        if (intensity == null || intensity == JmaForecastIntensity.zero) {
          final paint = Paint()
            ..color = e.intensityColor ?? Colors.transparent
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
            offset,
            circleSize.toDouble(),
            paint,
          );
          continue;
        }
        final colorScheme = colorModel.fromJmaForecastIntensity(intensity);
        final (fg, bg) = (colorScheme.foreground, colorScheme.background);
        canvas
          ..drawCircle(
            offset,
            circleSize.toDouble() * 1.5,
            Paint()
              ..color = e.intensityColor ?? Colors.transparent
              ..style = PaintingStyle.fill,
          )
          ..drawCircle(
            offset,
            circleSize.toDouble() * 1.3,
            Paint()
              ..color = bg
              ..style = PaintingStyle.fill,
          );
        final textStyle = TextStyle(
          color: fg,
          fontSize: circleSize.toDouble() * 2,
          fontWeight: FontWeight.w800,
          fontFamily: FontFamily.jetBrainsMono,
        );
        final textPainter = TextPainter(
          text: TextSpan(
            text: intensity.type,
            style: textStyle,
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        )..layout();
        textPainter.paint(
          canvas,
          offset.translate(-textPainter.width / 2, -textPainter.height / 2),
        );
        continue;
      }

      final paint = Paint()
        ..color = e.intensityColor ?? Colors.transparent
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        offset,
        circleSize.toDouble(),
        paint,
      );
      if (drawBorder) {
        final paint = Paint()
          ..color = Colors.grey.withOpacity(0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        canvas.drawCircle(
          offset,
          circleSize.toDouble(),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _KmoniPainter oldDelegate) => true;
}

extension JmaForecastIntensityDouble on double {
  JmaForecastIntensity? get toJmaForecastIntensity => switch (this) {
        < -0.5 => null,
        < 0.5 => JmaForecastIntensity.zero,
        < 1.5 => JmaForecastIntensity.one,
        < 2.5 => JmaForecastIntensity.two,
        < 3.5 => JmaForecastIntensity.three,
        < 4.5 => JmaForecastIntensity.four,
        < 5.0 => JmaForecastIntensity.fiveLower,
        < 5.5 => JmaForecastIntensity.fiveUpper,
        < 6.0 => JmaForecastIntensity.sixLower,
        < 6.5 => JmaForecastIntensity.sixUpper,
        _ => JmaForecastIntensity.seven,
      };
}
