import 'package:eqmonitor_api/export.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_hypocenter_points_provider.g.dart';

@riverpod
List<Feature<Point>> eewHypocenterPoints(Ref ref) {
  final eews = ref.watch(eewAliveTelegramProvider) ?? [];

  return eews
      .where((e) {
        if (e.isCanceled) {
          return false;
        }
        final coords = e.hypocenter?.coordinates;
        return coords != null && coords.type == CoordinateType.latLng;
      })
      .map((eew) {
        final hypocenter = eew.hypocenter!;
        final coords = hypocenter.coordinates;
        return Feature(
          geometry: Point(
            Geographic(lon: coords.longitude!.toDouble(), lat: coords.latitude!.toDouble()),
          ),
          properties: {
            'magnitude': hypocenter.magnitude,
            'depth': hypocenter.depth,
            'isLowPrecise': eew.isPlum,
          },
        );
      })
      .toList();
}
