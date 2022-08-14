// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/custom_map/map_base_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_eew_hypocenter_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_intensity_painter.dart';
import 'package:eqmonitor/widget/custom_map/obs_point_painter.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../widget/eew/eew_body_widget.dart';

class KmoniMap extends ConsumerWidget {
  const KmoniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final kmoniMapMatrix4 =
    //     ref.watch(kmoniMapController.select((value) => value.mapMatrix4));
    final isKmoniMapLoaded =
        ref.watch(kmoniMapController.select((value) => value.isMapLoaded));
    if (!isKmoniMapLoaded) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Stack(
      children: [
        InteractiveViewer(
          maxScale: 500,
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
        const OnEewWidget(),
        // KMoniの更新状況
        const Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: KmoniStatusWidget(),
          ),
        ),
      ],
    );
  }
}

class KmoniStatusWidget extends ConsumerWidget {
  const KmoniStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoni = ref.watch(kmoniController);
    final maxShindoColor = (kmoni.analyzedPoint.length > 100)
        ? kmoni.analyzedPoint
            .reduce(
              (curr, next) =>
                  (curr.shindo ?? -4) > (next.shindo ?? -4) ? curr : next,
            )
            .shindoColor
        : null;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (kmoni.analyzedPoint.length > 100)
              ? maxShindoColor?.withAlpha(100)
              : null,
          border: Border.all(
            color: maxShindoColor ?? Colors.transparent,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "最終更新: ${(kmoni.lastUpdated != null) ? DateFormat('yyyy/MM/dd HH:mm:ss').format((kmoni.lastUpdated!).toLocal()) : '-'}",
                      style: TextStyle(
                        color: (kmoni.lastUpdateAttempt
                                    .difference(
                                      kmoni.lastUpdated ?? DateTime(2000),
                                    )
                                    .inSeconds >
                                3)
                            ? const Color.fromARGB(255, 255, 17, 0)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (kmoni.isUpdating)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      )
                    else
                      const SizedBox(
                        width: 10,
                        height: 10,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnEewWidget extends ConsumerWidget {
  const OnEewWidget({
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
    final kmoni = ref.watch(kmoniController);

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
