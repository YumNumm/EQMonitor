import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../model/analyzed_kyoshin_kansokuten.dart';
import '../../../../../provider/earthquake/kmoni_controller.dart';
import '../../../../../utils/extension/relative_luminance.dart';

/// 強震観測点
class KyoshinKansokutenWidget extends ConsumerWidget {
  const KyoshinKansokutenWidget({
    required this.showIntensityIcon,
    required this.showKmoniPoints,
    super.key,
  });

  final bool showIntensityIcon;
  final bool showKmoniPoints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzedKmoniPoints =
        ref.watch(kmoniProvider.select((value) => value.analyzedPoint));

    return RepaintBoundary(
      child: CustomPaint(
        willChange: true,
        painter: KyoshinKansokutenPainter(
          obsPoints: analyzedKmoniPoints,
          showIntensityIcon: showIntensityIcon,
          showKmoniPoints: showKmoniPoints,
        ),
        size: const Size(476, 927.4),
      ),
    );
  }
}

/// 強震観測点描画
class KyoshinKansokutenPainter extends CustomPainter {
  KyoshinKansokutenPainter({
    required this.obsPoints,
    required this.showIntensityIcon,
    required this.showKmoniPoints,
  });

  final List<AnalyzedKoshinKansokuten> obsPoints;
  final bool showIntensityIcon;
  final bool showKmoniPoints;

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in obsPoints) {
      if (point.shindoColor == null) {
        continue;
      }
      final offset =
          MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
              .toLocalOffset(const Size(476, 927.4));
      if (showKmoniPoints) {
        canvas.drawCircle(
          offset,
          1.2,
          Paint()
            ..color = point.shindoColor!
            ..isAntiAlias = true
            ..strokeWidth = 1.2
            ..style = PaintingStyle.fill,
        );
      }
      if (point.shindo == null || !showIntensityIcon) {
        continue;
      }
      if (point.shindo! > 0.5) {
        canvas.drawCircle(
          offset,
          2,
          Paint()
            ..color = point.shindoColor!
            ..isAntiAlias = true
            ..style = PaintingStyle.fill,
        );
        final paint = Paint()
          ..color = point.intensity!.color
          ..isAntiAlias = true
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          offset,
          1.7,
          paint,
        );
        final textStyle = TextStyle(
          color: point.intensity!.color.onPrimary,
          fontSize: 3,
          fontWeight: FontWeight.w900,
        );
        final textPainter = TextPainter(
          text: TextSpan(
            text: point.intensity!.name,
            style: textStyle,
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        )..layout();
        textPainter.paint(
          canvas,
          offset.translate(-textPainter.width / 2, -textPainter.height / 2),
        );
      } else if (point.shindo! > -0.5 && !showKmoniPoints) {
        canvas
          ..drawCircle(
            offset,
            1.4,
            Paint()
              ..color = const Color.fromARGB(255, 56, 56, 56)
              ..isAntiAlias = true
              ..style = PaintingStyle.stroke,
          )
          ..drawCircle(
            MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
                .toLocalOffset(const Size(476, 927.4)),
            1.4,
            Paint()
              ..color =
                  const Color.fromARGB(255, 110, 110, 110).withOpacity(0.8)
              ..isAntiAlias = true
              ..style = PaintingStyle.fill,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant KyoshinKansokutenPainter oldDelegate) =>
      oldDelegate.showIntensityIcon != showIntensityIcon ||
      oldDelegate.obsPoints != obsPoints ||
      oldDelegate.showKmoniPoints != showKmoniPoints;
}
