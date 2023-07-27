import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_schema/model/components/intensity.dart';
import 'package:eqapi_schema/model/components/region_intensity.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:topo_map/topo_map.dart';

class EarthquakeIntensityMapWidget extends HookConsumerWidget {
  const EarthquakeIntensityMapWidget({
    super.key,
    required this.intensity,
    required this.mapKey,
    required this.showIntensityIcon,
    required this.mapData,
  });
  final Key mapKey;
  final Intensity intensity;
  final bool showIntensityIcon;
  final Map<LandLayerType, ZoomCachedProjectedFeatureLayer> mapData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesItem = useMemoized<List<_DrawItem>?>(() {
      // cities
      if (intensity.cities != null) {
        final cities = intensity.cities!;
        final result = <_DrawItem>[];
        for (final e
            in mapData[LandLayerType.municipalityEarthquakeTsunamiArea]!
                .projectedPolygonFeatures) {
          final cityIntensity = cities.firstWhereOrNull(
            (cityIntensity) =>
                (int.tryParse(cityIntensity.code) ?? -2) == (e.code ?? -1),
          );
          if (cityIntensity != null) {
            result.add(_DrawItem(feature: e, intensity: cityIntensity));
          }
        }
        return result;
      }
      return null;
    });
    final regionsItem = useMemoized(() {
      // regionsの探索
      {
        final regions = intensity.regions;
        final result = <_DrawItem>[];
        for (final e
            in mapData[LandLayerType.earthquakeInformationSubdivisionArea]!
                .projectedPolygonFeatures) {
          final regionIntensity = regions.firstWhereOrNull(
            (cityIntensity) => cityIntensity.code == e.code.toString(),
          );
          if (regionIntensity != null) {
            result.add(_DrawItem(feature: e, intensity: regionIntensity));
          }
        }
        return result;
      }
    });

    final state = ref.watch(MapViewModelProvider(mapKey));

    return CustomPaint(
      painter: _IntensityPainter(
        state: state,
        colorModel: ref.watch(intensityColorProvider),
        citiesItem: citiesItem,
        regionsItem: regionsItem,
        items: citiesItem ?? regionsItem,
      ),
      size: Size.infinite,
    );
  }
}

class _IntensityPainter extends CustomPainter {
  _IntensityPainter({
    required this.state,
    required this.regionsItem,
    required this.citiesItem,
    required this.colorModel,
    required this.items,
  });

  final MapState state;
  final List<_DrawItem>? citiesItem;
  final List<_DrawItem> regionsItem;
  final IntensityColorModel colorModel;
  final List<_DrawItem> items;

  @override
  void paint(Canvas canvas, Size size) {
    late final List<_DrawItem> items;
    if (citiesItem != null && state.zoomLevel > 12 * 12) {
      items = citiesItem!;
    } else {
      items = regionsItem;
    }
    for (final e in items) {
      final points = e.feature.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
      final intensity = e.intensity;
      if (intensity.maxInt == null) {
        continue;
      }
      final color = colorModel.fromJmaIntensity(intensity.maxInt!);
      if (!offsets.any(
        (e) => 0 < e.dx && 0 < e.dy && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }
      try {
        canvas
          ..drawPath(
            Path()..addPolygon(offsets, true),
            Paint()
              ..style = PaintingStyle.fill
              ..color = color.background
              ..isAntiAlias = true,
          )
          ..drawPath(
            Path()..addPolygon(offsets, false),
            Paint()
              ..style = PaintingStyle.stroke
              ..color = color.foreground.withOpacity(0.3)
              ..isAntiAlias = true,
          );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  void drawPolyline(Canvas canvas, Size size) {}

  void drawPolygon(Canvas canvas, Size size) {
    for (final e in items) {
      final points = e.feature.getPoints(state.zoomLevel.truncate());
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
            ..strokeWidth = 1
            ..isAntiAlias = true,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  bool shouldRepaint(covariant _IntensityPainter oldDelegate) => true;
}

@immutable
class _DrawItem {
  const _DrawItem({
    required this.intensity,
    required this.feature,
  });

  final RegionIntensity intensity;
  final ZoomCachedProjectedPolygonFeature feature;
}
