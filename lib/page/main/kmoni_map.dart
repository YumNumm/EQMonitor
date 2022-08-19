// ignore_for_file: lines_longer_than_80_chars

import 'dart:ui';

import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/kmoni_controller.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
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
    return Stack(
      children: [
        InteractiveViewer(
          maxScale: 20,
          child: Stack(
            children: const [
              // マップベース
              BaseMapWidget(),
              // EEWの予想震度
              MapEewIntensityWidget(),
              // 観測点
              KyoshinKansokutensMapWidget(),
              // EEWの震央位置
              EewHypoCenterMapWidget(),
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
    final kmoni = ref.watch(kmoniProvider);
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
                        fontWeight: ((kmoni.lastUpdateAttempt
                                    .difference(
                                      kmoni.lastUpdated ?? DateTime(2000),
                                    )
                                    .inSeconds >
                                3))
                            ? FontWeight.bold
                            : null,
                        fontFamily: 'CaskaydiaCove',
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (kmoni.isUpdating)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 0, 140, 255),
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 69, 125),
                          ),
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
        .watch(eewHistoryProvider.select((value) => value.showEews))
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

class KyoshinKansokutensMapWidget extends ConsumerWidget {
  const KyoshinKansokutensMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzedKmoniPoints =
        ref.watch(kmoniProvider.select((value) => value.analyzedPoint));

    return CustomPaint(
      painter: KyoshinKansokutenPainter(
        obsPoints: analyzedKmoniPoints,
      ),
      size: Size.infinite,
    );
  }
}

class BaseMapWidget extends ConsumerWidget {
  const BaseMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    // * ThemeMode変更時に自動で更新されるので、ここでは更新しない
    final isDarkMode = ref.read(themeProvider.notifier).isDarkMode;
    print(isDarkMode);
    return CustomPaint(
      isComplex: true,
      painter: MapBasePainter(
        mapPolygons: mapSource,
        isDarkMode: isDarkMode,
      ),
      size: Size.infinite,
    );
  }
}

class MapEewIntensityWidget extends ConsumerWidget {
  const MapEewIntensityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    final eews = ref
        .watch(eewHistoryProvider.select((value) => value.showEews))
        .map((eew) => MapEntry(eew, EEWInformation.fromJson(eew.body)));
    return CustomPaint(
      painter: EewIntensityPainter(
        eews: eews,
        mapPolygons: mapSource,
      ),
      size: Size.infinite,
    );
  }
}

class EewHypoCenterMapWidget extends ConsumerWidget {
  const EewHypoCenterMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref
        .watch(eewHistoryProvider.select((value) => value.showEews))
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
