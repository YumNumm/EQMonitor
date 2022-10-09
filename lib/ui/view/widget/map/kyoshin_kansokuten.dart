import 'package:eqmonitor/model/analyzed_kyoshin_kansokuten.dart';
import 'package:eqmonitor/provider/earthquake/kmoni_controller.dart';
import 'package:eqmonitor/utils/map/map_global_offset.dart';
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
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
