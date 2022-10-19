import 'package:eqmonitor/model/analyzed_kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/earthquake/kmoni_controller.dart';
import 'package:eqmonitor/utils/extension/relative_luminance.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

/// 強震観測点
class KyoshinKansokutenWidget extends ConsumerWidget {
  const KyoshinKansokutenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzedKmoniPoints =
        ref.watch(kmoniProvider.select((value) => value.analyzedPoint));

    return RepaintBoundary(
      child: CustomPaint(
        painter: KyoshinKansokutenPainter(
          obsPoints: analyzedKmoniPoints,
        ),
        size: const Size(476, 927.4),
      ),
    );
  }
}

/// 強震観測点描画
class KyoshinKansokutenPainter extends CustomPainter {
  KyoshinKansokutenPainter({required this.obsPoints});

  final List<AnalyzedKoshinKansokuten> obsPoints;
  final bool isDebug = false || kDebugMode;

  @override
  void paint(Canvas canvas, Size size) {
    for (final point in obsPoints) {
      if (point.shindoColor == null) {
        continue;
      }
      final paint = Paint()
        ..color = point.shindoColor!
        ..isAntiAlias = true
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
            .toLocalOffset(const Size(476, 927.4)),
        1.2,
        paint,
      );

      if (isDebug && (point.shindo ?? -10.0) > 0.5) {
        canvas.drawCircle(
          MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
              .toLocalOffset(const Size(476, 927.4)),
          2,
          Paint()
            ..color = point.shindoColor!
            ..isAntiAlias = true
            ..style = PaintingStyle.fill,
        );
        // 背景描画
        final paint = Paint()
          ..color = point.intensity!.color
          ..isAntiAlias = true
          ..style = PaintingStyle.fill;
        // 枠描画
        final framePainter = Paint();
        canvas.drawCircle(
          MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
              .toLocalOffset(const Size(476, 927.4)),
          1.7,
          paint,
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: point.intensity!.name,
            style: TextStyle(
              color: point.intensity!.color.onPrimary,
              fontSize: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        final offset =
            MapGlobalOffset.latLonToGlobalPoint(LatLng(point.lat, point.lon))
                .toLocalOffset(const Size(476, 927.4));
        textPainter.paint(
          canvas,
          Offset(
            offset.dx - textPainter.width * 0.5,
            offset.dy - textPainter.height * 0.5,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
