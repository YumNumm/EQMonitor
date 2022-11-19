import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../schema/remote/dmdata/commonHeader.dart';
import '../../../../../schema/remote/dmdata/eew-information/eew-infomation.dart';
import '../../../../../utils/map/map_global_offset.dart';

/// PLUM法等の仮定震源要素表示
/// ref: Flutter Animation Gallery
class EewHypoCenterAssumingMapWidget extends StatefulWidget {
  const EewHypoCenterAssumingMapWidget({required this.eew, super.key});
  final MapEntry<CommonHead, EEWInformation> eew;

  @override
  State<StatefulWidget> createState() => _EewHypoCenterAssumingMapWidgetState();
}

class _EewHypoCenterAssumingMapWidgetState
    extends State<EewHypoCenterAssumingMapWidget>
    with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late AnimationController centerOpacityController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> firstRippleWidthAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> secondRippleWidthAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;
  late Animation<double> thirdRippleWidthAnimation;
  late Animation<double> centerOpacityAnimation;

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

    firstRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
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

    thirdRippleWidthAnimation = Tween<double>(begin: 10, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    centerOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    centerOpacityAnimation = Tween<double>(begin: 1, end: 0.2).animate(
      CurvedAnimation(
        parent: centerOpacityController,
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
            centerOpacityController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            centerOpacityController.forward();
          }
        },
      );

    centerOpacityController.forward();
    firstRippleController.forward();
    Timer(
      const Duration(milliseconds: 333),
      () => secondRippleController.forward(),
    );

    Timer(
      const Duration(milliseconds: 667),
      () => thirdRippleController.forward(),
    );

    super.initState();
  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    centerOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eew = widget.eew;

    return CustomPaint(
      isComplex: true,
      painter: EewHypoCenterAssumingPainter(
        firstRippleRadiusAnimation.value,
        firstRippleOpacityAnimation.value,
        firstRippleRadiusAnimation.value,
        secondRippleRadiusAnimation.value,
        secondRippleOpacityAnimation.value,
        secondRippleRadiusAnimation.value,
        thirdRippleRadiusAnimation.value,
        thirdRippleOpacityAnimation.value,
        thirdRippleRadiusAnimation.value,
        3,
        centerOpacityAnimation.value,
        eew,
      ),
    );
  }
}

/// PLUM法等の仮定震源要素描画
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
    this.centerOpacity,
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
  final double centerOpacity;
  final MapEntry<CommonHead, EEWInformation> eew;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = MapGlobalOffset.latLonToGlobalPoint(
      LatLng(
        eew.value.earthQuake!.hypoCenter.coordinateComponent.latitude!.value,
        eew.value.earthQuake!.hypoCenter.coordinateComponent.longitude!.value,
      ),
    ).toLocalOffset(const Size(476, 927.4));
    const myColor = Color.fromARGB(255, 255, 0, 0);

    final firstPaint = Paint()
      ..color = myColor.withOpacity(firstRippleOpacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(offset, firstRippleRadius, firstPaint);

    final secondPaint = Paint()
      ..color = myColor.withOpacity(secondRippleOpacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(offset, secondRippleRadius, secondPaint);

    final thirdPaint = Paint()
      ..color = myColor.withOpacity(thirdRippleOpacity)
      ..style = PaintingStyle.fill;

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
          ..strokeWidth = .1
          ..color = Colors.white,
      );
  }

  @override
  bool shouldRepaint(covariant EewHypoCenterAssumingPainter oldDelegate) =>
      true;
}
