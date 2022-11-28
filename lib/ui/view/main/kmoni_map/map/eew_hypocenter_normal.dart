import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' hide Path;

import '../../../../../utils/map/map_global_offset.dart';

class EewHypocenterNormalMapWidget extends StatefulWidget {
  const EewHypocenterNormalMapWidget({
    required this.eew,
    super.key,
  });
  final EewTelegram eew;

  @override
  State<StatefulWidget> createState() => _EewHypocenterNormalMapWidgetState();
}

class _EewHypocenterNormalMapWidgetState
    extends State<EewHypocenterNormalMapWidget> with TickerProviderStateMixin {
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
  const EewHypocenterNormalPainter({
    required this.eew,
  });

  final EewTelegram eew;

  @override
  void paint(Canvas canvas, Size size) {
    if (eew.eew.earthquake?.hypocenter.coordinate.latitude != null &&
        eew.eew.earthquake?.hypocenter.coordinate.longitude != null) {
      final offset = MapGlobalOffset.latLonToGlobalPoint(
        LatLng(
          eew.eew.earthquake!.hypocenter.coordinate.latitude!.value,
          eew.eew.earthquake!.hypocenter.coordinate.longitude!.value,
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
