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
  const MapTouchHandlerWidget({super.key, required this.mapKey});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController();
    final scaleController = useAnimationController();

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) => Future(
            () {
              ref.read(mapViewModelProvider(mapKey).notifier)
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

    return Listener(
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
  }
}

class BaseMapWidget extends ConsumerWidget {
  const BaseMapWidget({super.key, required this.mapKey});
  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    final mapData =
        ref.watch(mapDataProvider.select((value) => value.projectedData));
    if (mapData == null) {
      throw Exception('mapData is null');
    }
    return CustomPaint(
      painter: MapPainter(
        state: state,
        mapData: mapData,
      ),
      size: Size.infinite,
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
  bool shouldRepaint(covariant MapPainter oldDelegate) =>
      oldDelegate.state != state || oldDelegate.mapData != mapData;
}
