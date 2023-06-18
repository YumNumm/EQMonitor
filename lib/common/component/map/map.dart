import 'dart:math';

import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/common/feature/map/data/model/map_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// タッチ操作をハンドルするWidget
/// mapViewModelProviderからMapStateを取得すること
class MapTouchHandlerWidget extends HookConsumerWidget {
  const MapTouchHandlerWidget({super.key, required this.mapKey});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widget = Listener(
      onPointerSignal:
          ref.read(mapViewModelProvider(mapKey).notifier).recievedPointerSignal,
      child: GestureDetector(
        onScaleUpdate:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleUpdate,
        onScaleStart:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleStart,
        onScaleEnd:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleEnd,
      ),
    );
    return widget;
  }
}

class BaseMapWidget extends HookConsumerWidget {
  const BaseMapWidget({
    super.key,
    required this.mapKey,
    this.onlyBorder = false,
  });
  final Key mapKey;
  final bool onlyBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(MapViewModelProvider(mapKey));
    return CustomPaint(
      painter: _BaseMapPainter(
        state: state,
        onlyBorder: onlyBorder,
        colors: (
          Theme.of(context).colorScheme.onSurface,
          Theme.of(context).colorScheme.surface,
        ),
      ),
      size: Size.infinite,
    );
  }
}

class _BaseMapPainter extends CustomPainter {
  _BaseMapPainter({
    required this.state,
    required this.onlyBorder,
    required this.colors,
  });

  final MapState state;
  final bool onlyBorder;
  final (Color foreground, Color background) colors;

  @override
  void paint(Canvas canvas, Size size) {
    final fg = colors.$1;
    final bg = colors.$2;

    void drawJmaMap({
      required Canvas canvas,
      required Size size,
      required MapDataType type,
      required (Paint? foregroundPainter, Paint? backgroundPainter) paints,
    }) {
      final foregroundPainter = paints.$1;
      final backgroundPainter = paints.$2;
    }

    void drawWorldMap({
      required Canvas canvas,
      required Size size,
      required bool ignoreJapan,
    }) {

      final outlinePaint = Paint()
        ..color = fg
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = bg;

    }

    if (onlyBorder) {
      drawJmaMap(
        canvas: canvas,
        size: size,
        type: MapDataType.areaForecastLocalEew,
        paints: (
          Paint()
            ..style = PaintingStyle.stroke
            ..color = fg
            ..strokeWidth = max(1, state.zoomLevel / 500)
            ..isAntiAlias = true,
          null,
        ),
      );
      return;
    }
    drawWorldMap(
      canvas: canvas,
      size: size,
      ignoreJapan: state.zoomLevel > 10,
    );

    if (state.zoomLevel > 10) {
      drawJmaMap(
        canvas: canvas,
        size: size,
        type: MapDataType.areaForecastLocalEew,
        paints: (
          Paint()
            ..style = PaintingStyle.stroke
            ..color = fg
            ..strokeWidth = max(1, state.zoomLevel / 500)
            ..isAntiAlias = true,
          Paint()
            ..style = PaintingStyle.fill
            ..color = bg
            ..isAntiAlias = true,
        ),
      );
    }
    if (state.zoomLevel > 100) {
      drawJmaMap(
        canvas: canvas,
        size: size,
        type: MapDataType.areaForecastLoadlE,
        paints: (
          Paint()
            ..color = fg
            ..style = PaintingStyle.stroke,
          null,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BaseMapPainter oldDelegate) =>
      oldDelegate.state != state;
}
