import 'dart:math';

import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/state/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/component/map/model/map_state.dart';
import 'package:eqmonitor/feature/home/component/map/view_model/base_map_viemwodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaseMapWidget extends HookConsumerWidget {
  const BaseMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baseMapViewModelProvider);
    final mapData = ref.read(mapDataProvider.notifier).mapProjectedData;
    final theme = Theme.of(context);
    Animation<Offset>? animation;
    Animation<double>? scaleAnimation;
    final controller = useAnimationController();
    final scaleController = useAnimationController();

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) => Future(
            () =>
                ref.read(baseMapViewModelProvider.notifier).registerWidgetSize(
                      context.size!,
                    ),
          ),
        );
        return null;
      },
      [],
    );

    return Stack(
      children: [
        // 背景色
        Container(
          color: const Color.fromARGB(255, 203, 211, 255),
        ),
        GestureDetector(
          //onPanUpdate: ref.read(baseMapViewModelProvider.notifier).handlePanUpdate,
          onScaleUpdate:
              ref.read(baseMapViewModelProvider.notifier).handleScaleUpdate,
          onScaleStart:
              ref.read(baseMapViewModelProvider.notifier).handleScaleStart,
          onScaleEnd:
              ref.read(baseMapViewModelProvider.notifier).handleScaleEnd,
          child: CustomPaint(
            willChange: true,
            isComplex: true,
            painter: BaseMapPainter(
              state: state,
              mapData: mapData,
              point: state.focalPoint,
            ),
            size: Size.infinite,
          ),
        ),
        // 初期値に戻す

        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FilledButton.tonalIcon(
                  onPressed: ref.read(baseMapViewModelProvider.notifier).reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('init'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => ref
                      .read(baseMapViewModelProvider.notifier)
                      .centerLatLng = const LatLng(35, 135),
                  icon: const Icon(Icons.home),
                  label: const Text('set center 35,135'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => ref
                      .read(baseMapViewModelProvider.notifier)
                      .zoomLevel = 20,
                  icon: const Icon(Icons.home),
                  label: const Text('set zoomLevel 20'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      ref.read(baseMapViewModelProvider.notifier).fitBounds(
                    [
                      const LatLng(20, 120),
                      const LatLng(45, 150),
                    ],
                  ),
                  icon: const Icon(Icons.home),
                  label: const Text('Fit Bounds 20,120 ~ 45,150'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BaseMapPainter extends CustomPainter {
  BaseMapPainter({
    required this.state,
    required this.mapData,
    this.point,
  });

  final MapState state;
  final MapProjectedData mapData;
  final GlobalPoint? point;

  @override
  void paint(Canvas canvas, Size size) {
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
            ..color = const Color.fromARGB(255, 156, 156, 156)
            ..strokeWidth = max(1, state.zoomLevel / 500)
            ..isAntiAlias = true,
          Paint()
            ..style = PaintingStyle.fill
            ..color = const Color.fromARGB(255, 255, 255, 255)
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
            ..color = const Color.fromARGB(255, 199, 199, 199)
            ..style = PaintingStyle.stroke,
          null,
        ),
      );
    }
    if (kDebugMode && point != null) {
      final offset = state.globalPointToOffset(point!);
      canvas.drawCircle(
        offset,
        10,
        Paint()..color = Colors.blueAccent,
      );
    }
  }

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
      ..color = const Color.fromARGB(255, 189, 189, 189)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
