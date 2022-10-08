import 'package:eqmonitor/provider/init/map_area_forecast_local_eew.dart';
import 'package:eqmonitor/provider/theme_providers.dart';
import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 日本地図
class BaseMapWidget extends ConsumerWidget {
  const BaseMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSource = ref.watch(mapAreaForecastLocalEewProvider);
    // * ThemeMode変更時に自動で更新されるので、ここでは更新しない
    final isDarkMode = ref.read(themeProvider.notifier).isDarkMode;
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color.fromARGB(255, 22, 28, 45)
              : const Color.fromARGB(255, 207, 219, 255),
        ),
        child: CustomPaint(
          isComplex: true,
          painter: MapBasePainter(
            mapPolygons: mapSource,
            isDarkMode: isDarkMode,
          ),
          size: const Size(476, 927.4),
        ),
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
          ? const Color.fromARGB(255, 166, 166, 166)
          : const Color.fromARGB(255, 255, 255, 255)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final paintOutline = Paint()
      ..color = isDarkMode
          ? const Color.fromARGB(255, 79, 79, 79)
          : const Color.fromARGB(255, 50, 50, 50)
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

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
