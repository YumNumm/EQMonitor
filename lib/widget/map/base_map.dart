import 'package:eqmonitor/provider/init/map_area_forecast_local_e.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../const/prefecture/area_forecast_local_eew.model.dart';

/// 日本地図
class BaseMapWidget extends ConsumerWidget {
  const BaseMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEProvider);
    // * ThemeMode変更時に自動で更新されるので、ここでは更新しない
    final isDarkMode = ref.read(themeProvider.notifier).isDarkMode;
    return RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: MapBasePainter(
          mapPolygons: mapSource,
          isDarkMode: isDarkMode,
        ),
        size: const Size(476, 927.4),
      ),
    );
  }
}

/// 日本地図の描画
class MapBasePainter extends CustomPainter {
  MapBasePainter({
    required this.mapPolygons,
    required this.isDarkMode,
  });
  List<MapPolygon> mapPolygons;
  bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final paintBuilding = Paint()
      ..color = isDarkMode
          ? const Color.fromARGB(255, 95, 95, 95)
          : const Color.fromARGB(255, 231, 230, 230)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final paintOutline = Paint()
      ..color = isDarkMode
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromARGB(255, 190, 190, 190)
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    for (final polygon in mapPolygons) {
      canvas
        ..drawPath(polygon.path, paintBuilding)
        ..drawPath(polygon.path, paintOutline);
    }
  }

  @override
  bool shouldRepaint(MapBasePainter oldDelegate) {
    return oldDelegate.mapPolygons != mapPolygons;
  }
}
