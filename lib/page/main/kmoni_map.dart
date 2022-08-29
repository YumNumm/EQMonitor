// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:eqmonitor/api/int_calc/int_calc.dart';
import 'package:eqmonitor/model/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/init/parameter-earthquake.dart';
import 'package:eqmonitor/provider/init/travel_time.dart';
import 'package:eqmonitor/provider/kmoni_controller.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:eqmonitor/schema/dmdata/eew-information/eew-infomation.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:eqmonitor/widget/custom_map/map_base_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_eew_hypocenter_painter.dart';
import 'package:eqmonitor/widget/custom_map/map_intensity_painter.dart';
import 'package:eqmonitor/widget/custom_map/obs_point_painter.dart';
import 'package:eqmonitor/widget/intensity_calc/estimated_shindo_painter.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:realtime_client/src/constants.dart';

import '../../widget/eew/eew_body_widget.dart';

final transformationControllerProvider =
    Provider((ref) => TransformationController());

class KmoniMap extends HookConsumerWidget {
  const KmoniMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeveloper = ref.watch(developerModeProvider).isDeveloper;
    final doubleTapPosition = useState(TapDownDetails());
    return Stack(
      children: [
        GestureDetector(
          onDoubleTapDown: (details) => doubleTapPosition.value = details,
          onDoubleTap: () {
            final controller = ref.read(transformationControllerProvider);
            if (controller.value != Matrix4.identity()) {
              controller.value = Matrix4.identity();
            } else {
              final position = doubleTapPosition.value.localPosition;
              controller.value = Matrix4.identity()
                ..translate(-position.dx, -position.dy)
                ..scale(2);
            }
          },
          child: Center(
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              transformationController:
                  ref.watch(transformationControllerProvider),
              maxScale: 20,
              constrained: false,
              child: SizedBox(
                height: 927.4,
                width: 476,
                child: Stack(
                  children: const [
                    // マップベース
                    BaseMapWidget(),
                    // EEWの距離減衰式による予想震度
                    // if (isDeveloper ||
                    //     kDebugMode ||
                    //     (ref.watch(kmoniProvider).testCaseStartTime != null))
                    //   const MapEewIntensityEstimateWidget(),

                    // EEWの予想震度
                    MapEewIntensityWidget(),
                    // 観測点
                    KyoshinKansokutensMapWidget(),
                    // EEWの震央位置
                    EewHypoCenterMapWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // テストモードのオーバレイ
        if (ref.watch(kmoniProvider).testCaseStartTime != null)
          const Center(
            child: IgnorePointer(
              child: FittedBox(
                child: Text(
                  ' TEST ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(100, 0, 0, 0),
                    fontSize: 200,
                  ),
                ),
              ),
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

class MapEewIntensityEstimateWidget extends ConsumerWidget {
  const MapEewIntensityEstimateWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewHistoryProvider).showEews;
    if (eews.isEmpty ||
        (eews.any(
          (e) => e.value.earthQuake?.isAssuming ?? false,
        ))) {
      return const SizedBox.shrink();
    }
    final result = eews
        .map(
          (eew) => IntensityEstimateApi().estimateIntensity(
            jmaMagnitude: eew.value.earthQuake!.magnitude.value!,
            depth: eew.value.earthQuake!.hypoCenter.depth.value!.toDouble(),
            hypocenter: LatLng(
              eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                  .value,
              eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                  .value,
            ),
            obsPoints: ref.watch(parameterEarthquakeProvider).items,
          ),
        )
        .expand((e) => e)
        .toList();

    return CustomPaint(
      painter: EstimatedShindoPainter(
        estimatedShindoPointsGroupBy:
            result.groupListsBy((element) => element.region.code),
        mapPolygons: ref.watch(mapAreaForecastLocalEProvider),
        colors: ref.watch(jmaIntensityColorProvider),
        alpha: 0.5,
      ),
    );
  }
}

class KmoniStatusWidget extends ConsumerWidget {
  const KmoniStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kmoni = ref.watch(kmoniProvider);
    final eewProvider = ref.watch(eewHistoryProvider);

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
                    // WebSocket 接続状態
                    if (eewProvider.subscription?.socket.connState ==
                        SocketStates.open)
                      const Icon(
                        Icons.link,
                        semanticLabel: 'WebSocket 接続中',
                      )
                    else
                      const Icon(
                        Icons.link_off,
                        color: Colors.red,
                        semanticLabel: 'WebSocket 切断',
                      ),
                    const SizedBox(width: 8),

                    /// テストモード時
                    if (ref.watch(kmoniProvider).testCaseStartTime != null)
                      const Icon(Icons.bug_report),

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

/// EEW情報
class OnEewWidget extends ConsumerWidget {
  const OnEewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));
    log(eews.length.toString(), name: 'eews.length');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final eew in eews)
            Padding(
              padding: const EdgeInsets.all(8),
              child: EewBodyWidget(
                eew: eew,
                colors: ref.watch(jmaIntensityColorProvider),
              ),
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
      size: const Size(476, 927.4),
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
    return CustomPaint(
      isComplex: true,
      painter: MapBasePainter(
        mapPolygons: mapSource,
        isDarkMode: isDarkMode,
      ),
      size: const Size(476, 927.4),
    );
  }
}

class MapEewIntensityWidget extends ConsumerWidget {
  const MapEewIntensityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));
    return CustomPaint(
      painter: EewIntensityPainter(
        colors: ref.watch(jmaIntensityColorProvider),
        eews: eews,
        mapPolygons: mapSource,
      ),
      size: const Size(476, 927.4),
    );
  }
}

/// ref: Flutter Animation Gallery
class EewHypoCenterAssumingMapWidget extends StatefulWidget {
  const EewHypoCenterAssumingMapWidget({required this.eew, super.key});
  final MapEntry<CommonHead, EEWInformation> eew;

  @override
  _EewHypoCenterAssumingMapWidgetState createState() =>
      _EewHypoCenterAssumingMapWidgetState();
}

class _EewHypoCenterAssumingMapWidgetState
    extends State<EewHypoCenterAssumingMapWidget>
    with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late AnimationController centerCircleController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> firstRippleWidthAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> secondRippleWidthAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;
  late Animation<double> thirdRippleWidthAnimation;
  late Animation<double> centerCircleRadiusAnimation;

  @override
  void initState() {
    firstRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          firstRippleController.forward();
        }
      });

    firstRippleOpacityAnimation = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    firstRippleWidthAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          secondRippleController.forward();
        }
      });

    secondRippleOpacityAnimation = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdRippleController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          thirdRippleController.forward();
        }
      });

    thirdRippleOpacityAnimation = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleWidthAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    centerCircleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    centerCircleRadiusAnimation = Tween<double>(begin: 2, end: 3).animate(
      CurvedAnimation(
        parent: centerCircleController,
        curve: Curves.fastOutSlowIn,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            centerCircleController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerCircleController.forward();
          }
        },
      );

    firstRippleController.forward();
    Timer(
      const Duration(milliseconds: 765),
      () => secondRippleController.forward(),
    );

    Timer(
      const Duration(milliseconds: 1050),
      () => thirdRippleController.forward(),
    );

    centerCircleController.forward();

    super.initState();
  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    centerCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eew = widget.eew;

    return CustomPaint(
      painter: EewHypoCenterAssumingPainter(
        firstRippleRadiusAnimation.value,
        firstRippleOpacityAnimation.value,
        firstRippleWidthAnimation.value,
        secondRippleRadiusAnimation.value,
        secondRippleOpacityAnimation.value,
        secondRippleWidthAnimation.value,
        thirdRippleRadiusAnimation.value,
        thirdRippleOpacityAnimation.value,
        thirdRippleWidthAnimation.value,
        centerCircleRadiusAnimation.value,
        eew,
      ),
    );
  }
}

class EewHypoCenterAssumingPainter extends CustomPainter {
  EewHypoCenterAssumingPainter(
    this.firstRippleRadius,
    this.firstRippleOpacity,
    this.firstRippleStrokeWidth,
    this.secondRippleRadius,
    this.secondRippleOpacity,
    this.secondRippleStrokeWidth,
    this.thirdRippleRadius,
    this.thirdRippleOpacity,
    this.thirdRippleStrokeWidth,
    this.centerCircleRadius,
    this.eew,
  );

  final double firstRippleRadius;
  final double firstRippleOpacity;
  final double firstRippleStrokeWidth;
  final double secondRippleRadius;
  final double secondRippleOpacity;
  final double secondRippleStrokeWidth;
  final double thirdRippleRadius;
  final double thirdRippleOpacity;
  final double thirdRippleStrokeWidth;
  final double centerCircleRadius;
  final MapEntry<CommonHead, EEWInformation> eew;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = MapGlobalOffset.latLonToGlobalPoint(
      LatLng(
        eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!.value,
        eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!.value,
      ),
    ).toLocalOffset(const Size(476, 927.4));
    const myColor = Color.fromARGB(255, 125, 88, 255);

    final firstPaint = Paint()
      ..color = myColor.withOpacity(firstRippleOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = firstRippleStrokeWidth;

    canvas.drawCircle(offset, firstRippleRadius, firstPaint);

    final secondPaint = Paint()
      ..color = myColor.withOpacity(secondRippleOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = secondRippleStrokeWidth;

    canvas.drawCircle(offset, secondRippleRadius, secondPaint);

    final thirdPaint = Paint()
      ..color = myColor.withOpacity(thirdRippleOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thirdRippleStrokeWidth;

    canvas.drawCircle(offset, thirdRippleRadius, thirdPaint);

    final fourthPaint = Paint()
      ..color = myColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawCircle(offset, centerCircleRadius, fourthPaint)
      ..drawCircle(
        offset,
        centerCircleRadius,
        fourthPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.1
          ..color = Colors.white,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class EewHypoCenterMapWidget extends ConsumerWidget {
  const EewHypoCenterMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));

    return Stack(
      children: <Widget>[
        for (final eew in eews)
          if (eew.value.earthQuake?.isAssuming == true)
            EewHypoCenterAssumingMapWidget(
              eew: eew,
            )
          else
            EewHypoCenterNormalMapWidget(
              eew: eew,
              travelTimeTables: ref.watch(TravelTimeProvider),
              onTestStarted: ref.watch(kmoniProvider).testCaseStartTime,
            ),
      ],
    );
  }
}

class EewHypoCenterNormalMapWidget extends StatefulWidget {
  const EewHypoCenterNormalMapWidget({
    required this.eew,
    required this.travelTimeTables,
    super.key,
    required this.onTestStarted,
  });
  final MapEntry<CommonHead, EEWInformation> eew;
  final List<TravelTimeTable> travelTimeTables;
  final DateTime? onTestStarted;

  @override
  _EewHypoCenterNormalMapWidgetState createState() =>
      _EewHypoCenterNormalMapWidgetState();
}

class _EewHypoCenterNormalMapWidgetState
    extends State<EewHypoCenterNormalMapWidget> with TickerProviderStateMixin {
  late AnimationController opacityController;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    opacityAnimation = Tween<double>(begin: 1, end: 0.3).animate(
      CurvedAnimation(
        parent: opacityController,
        curve: Curves.linear,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            opacityController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            opacityController.forward();
          }
        },
      );

    opacityController.forward();

    super.initState();
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eew = widget.eew;
    final travelTimeTables = widget.travelTimeTables;
    final onTestStarted = widget.onTestStarted;

    return CustomPaint(
      painter: EewHypocenterNormalPainter(
        eew: eew,
        opacity: opacityAnimation.value,
        travelTime: travelTimeTables,
        onTestStarted: onTestStarted,
      ),
    );
  }
}
