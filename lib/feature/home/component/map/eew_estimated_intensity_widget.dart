import 'dart:developer';

import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:topo_map/topo_map.dart';

class EewEstimatedIntensityWidget extends HookConsumerWidget {
  const EewEstimatedIntensityWidget({
    super.key,
    required this.mapKey,
    this.onlyBorder = false,
  });
  final Key mapKey;
  final bool onlyBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    final zoomCachedProjectedFeatureLayer =
        ref.watch(zoomCachedProjectedFeatureLayerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // TODO(YumNumm): ここでEEWを取得する
    //ref.watch(eewEstimatedIntensityListProvider);

    return switch (zoomCachedProjectedFeatureLayer.value) {
      null => const SizedBox.shrink(),
      final data => CustomPaint(
          size: Size.infinite,
          willChange: true,
          isComplex: true,
          painter: _EewEstimatedIntensityPainter(
            state: state,
            onlyBorder: onlyBorder,
            colorScheme:
                isDark ? MapColorScheme.dark() : MapColorScheme.light(),
            maps: data,
            areas: [],
            /* eews
                .map(
                  (e) => (
                    e.$1,
                    colorScheme.fromJmaForecastIntensity(e.$2).background
                  ),
                )
                .toList()*/
          ),
        ),
    };
  }
}

class _EewEstimatedIntensityPainter extends CustomPainter {
  _EewEstimatedIntensityPainter({
    required this.state,
    required this.onlyBorder,
    required this.colorScheme,
    required this.maps,
    required this.areas,
  });

  final MapState state;
  final bool onlyBorder;
  final MapColorScheme colorScheme;
  final Map<LandLayerType, ZoomCachedProjectedFeatureLayer> maps;
  final List<(int, Color)> areas;

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in areas) {
      drawAreaPolygon(
        canvas,
        size,
        e.$1,
        e.$2,
      );
    }
    return;
  }

  void drawAreaPolygon(
    Canvas canvas,
    Size size,
    int id,
    Color color,
  ) {
    for (final e in maps[LandLayerType.earthquakeInformationSubdivisionArea]!
        .projectedPolygonFeatures
        .where(
          (element) => (element.code ?? 1) == id,
        )) {
      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }

      final path = Path()
        ..addPolygon(
          offsets,
          true,
        );

      try {
        canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.fill
            ..color = color
            ..isAntiAlias = true,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  bool shouldRepaint(covariant _EewEstimatedIntensityPainter oldDelegate) =>
      oldDelegate.state != state ||
      oldDelegate.colorScheme != colorScheme ||
      oldDelegate.onlyBorder != onlyBorder ||
      oldDelegate.maps != maps ||
      oldDelegate.areas != areas;
}
