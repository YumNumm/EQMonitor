import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/custom_map/map_base_painter.dart';
import 'package:eqmonitor/widget/custom_map/obs_point_painter.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniMap extends ConsumerWidget {
  const KmoniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoniMapMatrix4 =
        ref.watch(kmoniMapNotifier.select((value) => value.mapMatrix4));

    return GestureDetector(
      child: InteractiveViewer(
        maxScale: 100,
        child: Transform(
          transform: kmoniMapMatrix4,
          child: Stack(
            children: const [
              // マップベース
              BaseMapWidget(),
              // 観測点
              ObsPointsMapWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class ObsPointsMapWidget extends ConsumerWidget {
  const ObsPointsMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoni = ref.watch(kmoniNotifier);

    return CustomPaint(
      painter: ObsPointPainter(
        obsPoints: kmoni.analyzedPoint,
      ),
      size: Size.infinite,
    );
  }
}

class BaseMapWidget extends ConsumerWidget {
  const BaseMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource =
        ref.watch(kmoniMapNotifier.select((value) => value.mapPolygons));
    return CustomPaint(
      painter: MapBasePainter(
        mapPolygons: mapSource,
        outlineStrokeWidth: 0.1,
      ),
      size: Size.infinite,
    );
  }
}
