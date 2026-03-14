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
        return e.hypocenter?.hasLatLng ?? false;
      })
      .map((eew) {
        final hypocenter = eew.hypocenter!;
        return Feature(
          geometry: Point(
            Geographic(
              lon: hypocenter.longitude!,
              lat: hypocenter.latitude!,
            ),
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
