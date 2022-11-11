import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../../../model/travel_time_table/travel_time_table.dart';
import '../../../../provider/earthquake/eew_controller.dart';
import '../../../../provider/earthquake/kmoni_controller.dart';
import '../../../../provider/init/travel_time.dart';
import '../../../../schema/remote/dmdata/commonHeader.dart';
import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import '../../../../schema/remote/dmdata/eew-information/eew-infomation.dart';
import '../../../../utils/map/map_global_offset.dart';
import 'eew_assuming_hypocenter.dart';

/// 通常の震央地表示
class EewHypoCenterWidget extends ConsumerWidget {
  const EewHypoCenterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));

    return Stack(
      children: <Widget>[
        for (final eew in eews)
          if (eew.value.earthQuake?.isAssuming == true ||
              eew.value.earthQuake?.hypoCenter.accuracy.epicCenterAccuracy
                      .epicCenterAccuracy ==
                  EpicCenterAccuracy.f1)
            EewHypoCenterAssumingMapWidget(
              eew: eew,
            )
          else
            EewHypoCenterNormalMapWidget(
              eew: eew,
              travelTimeTables: ref.watch(travelTimeProvider),
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
  State<StatefulWidget> createState() => _EewHypoCenterNormalMapWidgetState();
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

class EewHypocenterNormalPainter extends CustomPainter {
  EewHypocenterNormalPainter({
    required this.travelTime,
    required this.eew,
    required this.opacity,
    required this.onTestStarted,
  });

  MapEntry<CommonHead, EEWInformation> eew;
  final List<TravelTimeTable> travelTime;
  double opacity = 1;
  DateTime? onTestStarted;

  @override
  void paint(Canvas canvas, Size size) {
    if (eew.value.earthQuake?.hypoCenter.coordinateComponent.latitude != null &&
        eew.value.earthQuake?.hypoCenter.coordinateComponent.longitude !=
            null) {
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!.value,
          eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!.value,
        ),
      ).toLocalOffset(const Size(476, 927.4));

      // ×印を描く

      canvas
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color =
                const Color.fromARGB(255, 255, 255, 255).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color =
                const Color.fromARGB(255, 255, 255, 255).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0).withOpacity(opacity)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        );

      // 到達予想円
      final travel = TravelTimeApi(travelTime: travelTime).getValue(
        eew.value.earthQuake!.hypoCenter.depth.value!,
        ((onTestStarted != null)
                    ? eew.value.earthQuake!.originTime!
                        .add(DateTime.now().difference(onTestStarted!))
                        .difference(
                          eew.value.earthQuake!.originTime!,
                        )
                    : DateTime.now().difference(
                        eew.value.earthQuake!.originTime!,
                      ))
                .inMilliseconds /
            1000,
      );
      if (travel == null) {
        return;
      }
      final sOffsets = <Offset>[];
      final pOffsets = <Offset>[];

      for (final bearing in List<int>.generate(360, (index) => index)) {
        sOffsets.add(
          MapGlobalOffset.latLonToGlobalPoint(
            const Distance().offset(
              LatLng(
                eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                    .value,
                eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                    .value,
              ),
              (travel.sDistance * 1000).toInt(),
              bearing,
            ),
          ).toLocalOffset(const Size(476, 927.4)),
        );
        pOffsets.add(
          MapGlobalOffset.latLonToGlobalPoint(
            const Distance().offset(
              LatLng(
                eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!
                    .value,
                eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!
                    .value,
              ),
              (travel.pDistance * 1000).toInt(),
              bearing,
            ),
          ).toLocalOffset(const Size(476, 927.4)),
        );
      }

      canvas
        ..drawPath(
          Path()..addPolygon(sOffsets, true),
          Paint()
            ..color = const Color.fromARGB(255, 255, 140, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        )
        ..drawPath(
          Path()..addPolygon(sOffsets, true),
          Paint()
            ..color = const Color.fromARGB(27, 255, 140, 0)
            ..isAntiAlias = true
            ..style = PaintingStyle.fill
            ..strokeWidth = 1,
        )
        ..drawPath(
          Path()..addPolygon(pOffsets, true),
          Paint()
            ..color = const Color.fromARGB(255, 0, 102, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.3,
        );
    }
  }

  @override
  bool shouldRepaint(covariant EewHypocenterNormalPainter oldDelegate) =>
      oldDelegate.eew != eew ||
      oldDelegate.travelTime != travelTime ||
      oldDelegate.opacity != opacity ||
      oldDelegate.onTestStarted != onTestStarted;
}
