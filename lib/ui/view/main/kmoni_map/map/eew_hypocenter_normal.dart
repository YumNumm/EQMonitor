import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../../../../schema/remote/dmdata/commonHeader.dart';
import '../../../../../schema/remote/dmdata/eew-information/eew-infomation.dart';
import '../../../../../utils/map/map_global_offset.dart';

class EewHypoCenterNormalMapWidget extends StatefulWidget {
  const EewHypoCenterNormalMapWidget({
    required this.eew,
    super.key,
  });
  final MapEntry<CommonHead, EEWInformation> eew;

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

    opacityAnimation = Tween<double>(begin: 1, end: 0.2).animate(
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

    return Opacity(
      opacity: opacityAnimation.value,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: EewHypocenterNormalPainter(
            eew: eew,
          ),
        ),
      ),
    );
  }
}

class EewHypocenterNormalPainter extends CustomPainter {
  EewHypocenterNormalPainter({
    required this.eew,
  });

  MapEntry<CommonHead, EEWInformation> eew;

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
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 0, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 255, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5,
        )
        ..drawLine(
          Offset(offset.dx - 4, offset.dy - 4),
          Offset(offset.dx + 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        )
        ..drawLine(
          Offset(offset.dx + 4, offset.dy - 4),
          Offset(offset.dx - 4, offset.dy + 4),
          Paint()
            ..color = const Color.fromARGB(255, 255, 0, 0)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.3,
        );
    }
  }

  @override
  bool shouldRepaint(covariant EewHypocenterNormalPainter oldDelegate) =>
      oldDelegate.eew != eew;
}
