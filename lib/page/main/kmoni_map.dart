import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/custom_map/map_base_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_eew_hypocenter_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_intensity_painter.dart';
import 'package:eqmonitor/widget/custom_map/obs_point_painter.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/eew/eew_body_widget.dart';

class KmoniMap extends ConsumerWidget {
  const KmoniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoniMapMatrix4 =
        ref.watch(kmoniMapController.select((value) => value.mapMatrix4));

    return Stack(
      children: [
        InteractiveViewer(
          maxScale: 100,
          child: Stack(
            children: const [
              // マップベース
              BaseMapWidget(),
              // EEWの予想震度
              MapIntensityWidget(),

              // 観測点
              ObsPointsMapWidget(),
              // EEWの震央位置
              EewCenterMapWidget(),
            ],
          ),
        ),
        // EEW表示
        const onEewWidget(),
      ],
    );
  }
}

class onEewWidget extends ConsumerWidget {
  const onEewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref
        .watch(eewHistoryController.select((value) => value.showEews))
        .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body)));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final eew in eews)
            Padding(
              padding: const EdgeInsets.all(8),
              child: EewBodyWidget(eew: eew),
            ),
        ],
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
      isComplex: true,
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
        ref.watch(kmoniMapController.select((value) => value.mapPolygons));
    return CustomPaint(
      isComplex: true,
      painter: MapBasePainter(
        mapPolygons: mapSource,
        outlineStrokeWidth: 0.1,
      ),
      size: Size.infinite,
    );
  }
}

class MapIntensityWidget extends ConsumerWidget {
  const MapIntensityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource =
        ref.watch(kmoniMapController.select((value) => value.mapPolygons));
    final eews = ref
        .watch(eewHistoryController.select((value) => value.showEews))
        .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body)));
    return CustomPaint(
      painter: MapIntensityPainter(
        eews: eews,
        mapPolygons: mapSource,
        outlineStrokeWidth: 0.1,
      ),
      size: Size.infinite,
    );
  }
}

class EewCenterMapWidget extends ConsumerWidget {
  const EewCenterMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref
        .watch(eewHistoryController.select((value) => value.showEews))
        .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body)));
    if (eews.isNotEmpty) {
      // 1秒間隔のOpacityAnimationを作成する

      return CustomPaint(
        painter: EewHypocenterPainter(
          eews: eews,
        ),
        size: Size.infinite,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}