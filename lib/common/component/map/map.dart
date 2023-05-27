import 'dart:math';

import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/state/map_data_state.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// タッチ操作をハンドルするWidget
/// mapViewModelProviderからMapStateを取得すること
class MapTouchHandlerWidget extends HookConsumerWidget {
  const MapTouchHandlerWidget({required this.key});

  final GlobalKey key;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController();
    final scaleController = useAnimationController();

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) => Future(
            () {
              ref.read(mapViewModelProvider(key).notifier)
                ..registerWidgetSize(
                  context.size!,
                )
                ..registerAnimationControllers(
                  moveController: controller,
                  scaleController: scaleController,
                )
                ..fitBounds(
                  [
                    const LatLng(45.3, 145.1),
                    const LatLng(30, 128.8),
                  ],
                );
            },
          ),
        );
        return null;
      },
      [],
    );

    return Stack(
      children: [
        Listener(
          onPointerSignal:
              ref.read(mapViewModelProvider(key).notifier).recievedPointerSignal,
          child: GestureDetector(
            onScaleUpdate:
                ref.read(mapViewModelProvider(key).notifier).handleScaleUpdate,
            onScaleStart:
                ref.read(mapViewModelProvider(key).notifier).handleScaleStart,
            onScaleEnd: ref.read(mapViewModelProvider(key).notifier).handleScaleEnd,
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
                  onPressed: ref.read(mapViewModelProvider(key).notifier).reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('init'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      ref.read(mapViewModelProvider(key).notifier).animatedMoveTo(
                            const LatLng(35, 135),
                            duration: const Duration(milliseconds: 250),
                          ),
                  icon: const Icon(Icons.home),
                  label: const Text('Animated Move To 35,135'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => ref
                      .read(mapViewModelProvider(key).notifier)
                      .animatedZoomTo(20),
                  icon: const Icon(Icons.home),
                  label: const Text('Animated Zoom To Lv.20'),
                ),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      ref.read(mapViewModelProvider(key).notifier).animatedBounds(
                    [
                      const LatLng(45.6, 145.1),
                      const LatLng(30, 128.8),
                    ],
                  ),
                  icon: const Icon(Icons.home),
                  label: const Text('Animated Fit Japan Map'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MapPainter extends CustomPainter {
  MapPainter({
    required this.state,
    required this.mapData,
  });

  final MapState state;
  final MapProjectedData mapData;

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
