import 'dart:math';

import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/common/feature/map/data/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/data/model/state/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
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
    useEffect(
      () {
        ref.read(mapDataProvider.notifier).initialize();
        return null;
      },
      [],
    );
    final state = ref.watch(MapViewModelProvider(mapKey));
    final mapData =
        ref.watch(mapDataProvider.select((value) => value.projectedData));
    if (mapData == null) {
      debugPrint('mapData is null');
      return const SizedBox.shrink();
    }
    return CustomPaint(
      painter: _BaseMapPainter(
        state: state,
        mapData: mapData,
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
    required this.mapData,
    required this.onlyBorder,
    required this.colors,
  });

  final MapState state;
  final MapProjectedData mapData;
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
      final data = mapData.jmaMap[type];
      final foregroundPainter = paints.$1;
      final backgroundPainter = paints.$2;
      if (data == null) {
        return;
      }
      for (final area in data) {
        for (final polygon in area.polygons) {
          final path = Path()
            ..addPolygon(
              polygon.points.map(state.globalPointToOffset).toList(),
              true,
            );
          // 画面外の場合は描画しない
          if (!path
              .getBounds()
              .overlaps(Rect.fromLTWH(0, 0, size.width, size.height))) {
            continue;
          }
          if (foregroundPainter != null) {
            canvas.drawPath(path, foregroundPainter);
          }
          if (backgroundPainter != null) {
            canvas.drawPath(path, backgroundPainter);
          }
        }
      }
    }

    void drawWorldMap({
      required Canvas canvas,
      required Size size,
      required bool ignoreJapan,
    }) {
      final data = mapData.worldMap;

      final outlinePaint = Paint()
        ..color = fg
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = bg;

      for (final area in data) {
        if (ignoreJapan && area.properties.name == 'Japan') {
          continue;
        }
        for (final polygon in area.polygons) {
          final path = Path()
            ..addPolygon(
              polygon.points.map(state.globalPointToOffset).toList(),
              true,
            );
          // 画面外の場合は描画しない
          if (!path
              .getBounds()
              .overlaps(Rect.fromLTWH(0, 0, size.width, size.height))) {
            continue;
          }
          canvas
            ..drawPath(
              path,
              outlinePaint,
            )
            ..drawPath(
              path,
              fillPaint,
            );
        }
      }
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
      oldDelegate.state != state || oldDelegate.mapData != mapData;
}
