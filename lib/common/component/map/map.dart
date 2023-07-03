import 'package:eq_map/eq_map.dart';
import 'package:eqmonitor/common/component/map/model/map_config.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/model/projected_feature_layer.dart';
import 'package:eqmonitor/common/component/map/view_model/map_config.dart';
import 'package:eqmonitor/common/component/map/view_model/map_shrinker_viewmodel.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/common/provider/topology_map/provider/topology_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:topo_map/topo_map.dart';

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
    final map = ref.watch(mapDataProvider);
    final mapData = map.valueOrNull;
    if (mapData == null || mapData.maps == null) {
      print('mapData is null');
      return Container();
    }
    final projectedFeatureLayer =
        useMemoized<Map<LandLayerType, ProjectedFeatureLayer>?>(
      () {
        print('useMemoized');
        return mapData.maps!.map((key, value) {
          final projected = ProjectedFeatureLayer.fromFeatureLayer(
            layer: value,
            projection: WebMercatorProjection(),
          );
          return MapEntry(key, projected);
        });
      },
      [mapData],
    );
    if (projectedFeatureLayer == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    final colorScheme = Theme.of(context).colorScheme;
    final mapConfig = ref.watch(mapConfigStateProvider(ThemeMode.light));
    return CustomPaint(
      painter: _BaseMapPainter(
        state: state,
        onlyBorder: onlyBorder,
        colorScheme: MapColorScheme.light(),
        // colorScheme: mapConfig.colorScheme,
        maps: projectedFeatureLayer,
        shrinker: ref.watch(mapShrinkerProvider),
      ),
      size: Size.infinite,
    );
  }
}

class _BaseMapPainter extends CustomPainter {
  _BaseMapPainter({
    required this.state,
    required this.onlyBorder,
    required this.colorScheme,
    required this.maps,
    required this.shrinker,
  });

  final MapState state;
  final bool onlyBorder;
  final MapColorScheme colorScheme;
  final Map<LandLayerType, ProjectedFeatureLayer> maps;
  final MapShrinker shrinker;

  @override
  void paint(Canvas canvas, Size size) {
    baseColorPaint(canvas, colorScheme);
    // draw
    drawJapanPolygon(canvas, size, colorScheme);
    drawJapanPolyline(canvas, size, colorScheme);
    drawWorldPolygon(canvas, size, colorScheme);
    drawWorldPolyline(canvas, size, colorScheme);
    if (state.zoomLevel > 400) {
      drawJapanDetailedPolyline(canvas, size, colorScheme);
    }

    return;
  }

  void drawJapanPolygon(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    for (final e in maps[LandLayerType.earthquakeInformationSubdivisionArea]!
        .projectedPolygonFeatures) {
      final globalPoints = e.points;

      // apply DP
      final offsets = state.globalPointsToOffsetsIntercepted(
        points: globalPoints,
        id: 'LandLayerType.earthquakeInformationSubdivisionArea-polygon-${e.hashCode}',
        intercept: shrinker.applyShrinker,
      );

      if (offsets == null) {
        continue;
      }
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas.drawPath(
          Path()..addPolygon(offsets, true),
          Paint()
            ..style = PaintingStyle.fill
            ..color = colorScheme.japanLandColor
            ..isAntiAlias = true,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void drawJapanPolyline(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    for (final e in maps[LandLayerType.earthquakeInformationSubdivisionArea]!
        .projectedPolylineFeatures) {
      final globalPoints = e.points;

      // apply DP
      final offsets = state.globalPointsToOffsetsIntercepted(
        points: globalPoints,
        id: 'LandLayerType.earthquakeInformationSubdivisionArea-polyline-${e.hashCode}',
        intercept: shrinker.applyShrinker,
      );

      if (offsets == null) {
        continue;
      }
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas.drawPath(
          Path()..addPolygon(offsets, false),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = switch (e.type) {
              PolylineType.coastLine => colorScheme.japanCoastlineColor,
              _ => colorScheme.japanBorderLineColor,
            }
            ..strokeWidth = 1
            ..isAntiAlias = true,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void drawJapanDetailedPolyline(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    for (final e in maps[LandLayerType.municipalityEarthquakeTsunamiArea]!
        .projectedPolylineFeatures) {
      final globalPoints = e.points;

      // apply DP
      final offsets = state.globalPointsToOffsetsIntercepted(
        points: globalPoints,
        id: 'LandLayerType.municipalityEarthquakeTsunamiArea-polyline-${e.hashCode}',
        intercept: shrinker.applyShrinker,
      );

      if (offsets == null) {
        continue;
      }
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas.drawPath(
          Path()..addPolygon(offsets, false),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = colorScheme.worldLandColor
            ..isAntiAlias = true,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void drawWorldPolygon(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    for (final e
        in maps[LandLayerType.worldWithoutJapan]!.projectedPolygonFeatures) {
      final globalPoints = e.points;

      // apply DP
      final offsets = state.globalPointsToOffsetsIntercepted(
        points: globalPoints,
        id: 'LandLayerType.worldWithoutJapan-polygon-${e.hashCode}',
        intercept: shrinker.applyShrinker,
      );

      if (offsets == null) {
        continue;
      }
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas.drawPath(
          Path()..addPolygon(offsets, true),
          Paint()
            ..style = PaintingStyle.fill
            ..color = colorScheme.worldLandColor
            ..isAntiAlias = true,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void drawWorldPolyline(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    for (final e
        in maps[LandLayerType.worldWithoutJapan]!.projectedPolylineFeatures) {
      final globalPoints = e.points;

      // apply DP
      final offsets = state.globalPointsToOffsetsIntercepted(
        points: globalPoints,
        id: 'LandLayerType.worldWithoutJapan-polyline-${e.hashCode}',
        intercept: shrinker.applyShrinker,
      );

      if (offsets == null) {
        continue;
      }
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas.drawPath(
          Path()..addPolygon(offsets, false),
          Paint()
            ..style = PaintingStyle.stroke
            ..color = switch (e.type) {
              PolylineType.coastLine => colorScheme.worldCoastlineColor,
              _ => colorScheme.worldBorderLineColor,
            }
            ..strokeWidth = 1
            ..isAntiAlias = true,
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void baseColorPaint(Canvas canvas, MapColorScheme colorScheme) {
    canvas.drawColor(colorScheme.backgroundColor, BlendMode.srcATop);
  }

  @override
  bool shouldRepaint(covariant _BaseMapPainter oldDelegate) =>
      oldDelegate.state != state ||
      oldDelegate.colorScheme != colorScheme ||
      oldDelegate.onlyBorder != onlyBorder ||
      oldDelegate.maps != maps ||
      oldDelegate.shrinker != shrinker;
}
