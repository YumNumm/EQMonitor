import 'dart:math';

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_settings.dart';
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
    return CustomPaint(
      painter: _KmoniPainter(
        state: state,
        kmoniState: kmoniState,
        settingsState: kmoniSettingsState,
        colorModel: ref.watch(intensityColorProvider),
      ),
      size: Size.infinite,
    );
  }
}

class _KmoniPainter extends CustomPainter {
  _KmoniPainter({
    required this.state,
    required this.kmoniState,
    required this.settingsState,
    required this.colorModel,
  });

  final MapState state;
  final List<AnalyzedKmoniObservationPoint>? kmoniState;
  final KmoniSettingsState settingsState;
  final IntensityColorModel colorModel;

  @override
  void paint(Canvas canvas, Size size) {
    if (kmoniState == null) {
      return;
    }
    final circleSize = switch (state.zoomLevel) {
      < 30 => 2.0,
      > 60 => min(state.zoomLevel / 20.0, 10),
      > 120 => 8.0,
      _ => 3.0,
    };

    for (final e in kmoniState!) {
      if (e.intensityValue == null) {
        continue;
      }

      final offset = state.globalPointToOffset(
        WebMercatorProjection().project(
          LatLng(e.lat, e.lon),
        ),
      );
      // 画面外の場合は描画しない
      if (offset.dx < -10 ||
          offset.dx > size.width + 10 ||
          offset.dy < -10 ||
          offset.dy > size.height + 10) {
        continue;
      }
      final intensity = e.intensityValue!.toJmaForecastIntensity;

      if (settingsState.isUpper0Only) {
        if (intensity == null) {
          continue;
        }
        if (intensity == JmaForecastIntensity.zero) {
          // グレーの枠
          final paint = Paint()
            ..color = Colors.white.withOpacity(0.8)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
            offset,
            circleSize.toDouble(),
            paint,
          );
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
        final (fg, bg) = colorModel.fromJmaForecastIntensity(intensity);
        canvas
          ..drawCircle(
            offset,
            circleSize.toDouble() + 2,
            Paint()
              ..color = e.intensityColor ?? Colors.transparent
              ..style = PaintingStyle.fill,
          )
          ..drawCircle(
            offset,
            circleSize.toDouble(),
            Paint()
              ..color = bg
              ..style = PaintingStyle.fill,
          );
        final textStyle = TextStyle(
          color: fg,
          fontSize: circleSize.toDouble() * 1.5,
          fontWeight: FontWeight.w900,
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