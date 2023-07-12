import 'package:eqapi_schema/model/components/intensity.dart';
import 'package:eqapi_schema/model/components/region_intensity.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeIntensityMapWidget extends HookConsumerWidget {
  const EarthquakeIntensityMapWidget({
    super.key,
    required this.intensity,
    required this.mapKey,
    required this.showIntensityIcon,
  });
  final Key mapKey;
  final Intensity intensity;
  final bool showIntensityIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesItem = useMemoized<List<_DrawItem>?>(() {
      // cities
      if (intensity.cities != null) {
        final cities = intensity.cities!;
        final result = <_DrawItem>[];
        //  for (final e in map) {
        //    final cityIntensity = cities.firstWhereOrNull(
        //      (cityIntensity) => cityIntensity.code == e.properties.code,
        //    );
        //    if (cityIntensity != null) {
        //      result.add(_DrawItem(polygon: e, intensity: cityIntensity));
        //    }
        //  }
        return result;
      }
      return null;
    });
    final regionsItem = useMemoized(() {
      // regionsの探索
      {
        final regions = intensity.regions;
        //   final map = ref
        //       .watch(mapDataProvider)
        //       .projectedData!
        //       .jmaMap[MapDataType.areaForecastLoadlE]!;
        final result = <_DrawItem>[];
        //   for (final e in map) {
        //     final regionIntensity = regions.firstWhereOrNull(
        //       (regionIntensity) => regionIntensity.code == e.properties.code,
        //     );
        //     if (regionIntensity != null) {
        //       result.add(_DrawItem(polygon: e, intensity: regionIntensity));
        //     }
        //   }
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
  });

  final MapState state;
  final List<_DrawItem>? citiesItem;
  final List<_DrawItem> regionsItem;
  final IntensityColorModel colorModel;

  @override
  void paint(Canvas canvas, Size size) {
    late final List<_DrawItem> items;
    if (citiesItem != null) {
      items = citiesItem!;
    } else {
      items = regionsItem;
    }
    for (final e in items) {
      try {
        final colorScheme = colorModel.fromJmaIntensity(e.intensity.maxInt!);
        final (fgColor, color) =
            (colorScheme.foreground, colorScheme.background);
        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        /*for (final polygon in e.polygon.polygons) {
          final path = Path()
            ..addPolygon(
              polygon.points.map(state.globalPointToOffset).toList(),
              true,
            );

          canvas
            ..drawPath(path, paint)
            ..drawPath(
              path,
              Paint()
                ..color = fgColor.withOpacity(0.2)
                ..style = PaintingStyle.stroke,
            );
        }*/
      } on Exception catch (_) {}
    }
  }

  @override
  bool shouldRepaint(covariant _IntensityPainter oldDelegate) => true;
}

@immutable
class _DrawItem {
  const _DrawItem({
    required this.intensity,
  });

  final RegionIntensity intensity;
}
