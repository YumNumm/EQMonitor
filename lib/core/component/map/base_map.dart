import 'dart:developer';

import 'package:eq_map/eq_map.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:topo_map/topo_map.dart';

class BaseMapWidget extends HookConsumerWidget {
  const BaseMapWidget._({
    required this.mapKey,
    this.drawPolyline = true,
    this.drawPolygon = true,
  });

  factory BaseMapWidget.polygon(Key mapKey) => BaseMapWidget._(
        mapKey: mapKey,
        drawPolyline: false,
      );

  factory BaseMapWidget.polyline(Key mapKey) => BaseMapWidget._(
        mapKey: mapKey,
        drawPolygon: false,
      );
  factory BaseMapWidget.all(Key mapKey) => BaseMapWidget._(
        mapKey: mapKey,
      );

  final Key mapKey;
  final bool drawPolyline;
  final bool drawPolygon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zoomCachedProjectedFeatureLayer =
        ref.watch(zoomCachedProjectedFeatureLayerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return switch (zoomCachedProjectedFeatureLayer.value) {
      null => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      final data => CustomPaint(
          painter: _BaseMapPainter(
            state: ref.watch(mapViewModelProvider(mapKey)),
            drawPolyline: drawPolyline,
            drawPolygon: drawPolygon,
            colorScheme:
                isDark ? MapColorScheme.dark() : MapColorScheme.light(),
            maps: data,
          ),
          size: Size.infinite,
          willChange: true,
        ),
    };
  }
}

class _BaseMapPainter extends CustomPainter {
  _BaseMapPainter({
    required this.state,
    required this.drawPolyline,
    required this.drawPolygon,
    required this.colorScheme,
    required this.maps,
  });

  final MapState state;
  final MapColorScheme colorScheme;
  final Map<LandLayerType, ZoomCachedProjectedFeatureLayer> maps;

  final bool drawPolyline;
  final bool drawPolygon;

  @override
  void paint(Canvas canvas, Size size) {
    // draw
    if (drawPolyline) {
      drawJapanPolyline(canvas, size, colorScheme);
      drawWorldPolyline(canvas, size, colorScheme);
    }
    if (drawPolygon) {
      drawJapanPolygon(canvas, size, colorScheme);
      drawWorldPolygon(canvas, size, colorScheme);
    }
    if (state.zoomLevel > 400) {
      //  drawJapanDetailedPolyline(canvas, size, colorScheme);
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
      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
      if (offsets.length < 4 ||
          !offsets.any(
            (e) =>
                e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
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
            ..color = colorScheme.japanLandColor
            ..isAntiAlias = true,
        );
      } on Exception catch (e) {
        log(e.toString());
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
      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
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
              PolylineType.admin => colorScheme.japanBorderLineColor,
              PolylineType.city => Color.lerp(
                  colorScheme.japanBorderLineColor,
                  colorScheme.japanLandColor,
                  0.4,
                )!
                    .withOpacity(0.4),
            }
            ..strokeWidth = 1
            ..isAntiAlias = true,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void drawJapanDetailedPolyline(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    final bbox = state.getLatLngBoundary(size);

    for (final e in maps[LandLayerType.municipalityEarthquakeTsunamiArea]!
        .projectedPolylineFeatures) {
      // bbox check
      if (!bbox.containsBbox(e.bbox)) {
        //  continue;
      }

      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
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
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void drawWorldPolygon(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    final bbox = state.getLatLngBoundary(size);
    for (final e
        in maps[LandLayerType.worldWithoutJapan]!.projectedPolygonFeatures) {
      // bbox check
      if (!bbox.containsBbox(e.bbox)) {
        //  continue;
      }

      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();

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
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void drawWorldPolyline(
    Canvas canvas,
    Size size,
    MapColorScheme colorScheme,
  ) {
    final bbox = state.getLatLngBoundary(size);
    for (final e
        in maps[LandLayerType.worldWithoutJapan]!.projectedPolylineFeatures) {
      // bbox check
      if (!bbox.containsBbox(e.bbox)) {
        // continue;
      }

      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();

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
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BaseMapPainter oldDelegate) =>
      oldDelegate.state != state ||
      oldDelegate.colorScheme != colorScheme ||
      oldDelegate.drawPolyline != drawPolyline ||
      oldDelegate.maps != maps;
}
