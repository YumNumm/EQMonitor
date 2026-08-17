import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_hypocenter_points_provider.g.dart';

@riverpod
List<Feature<Point>> eewHypocenterPoints(Ref ref) {
  final eews = ref.watch(eewAliveTelegramProvider) ?? [];

  return eews
      .where((e) => !e.isCanceled)
      .map((eew) {
        final hypocenter = eew.hypocenter;
        final latitude = hypocenter?.latitude;
        final longitude = hypocenter?.longitude;
        if (hypocenter == null || latitude == null || longitude == null) {
          return null;
        }
        return Feature(
          geometry: Point(Geographic(lon: longitude, lat: latitude)),
          properties: {
            'magnitude': hypocenter.magnitude,
            'depth': hypocenter.depth,
            'isLowPrecise': eew.isPlum,
          },
        );
      })
      .whereType<Feature<Point>>()
      .toList();
}
