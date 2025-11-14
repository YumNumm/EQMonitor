import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_hypocenter_points_provider.g.dart';

@riverpod
List<Feature<Point>> eewHypocenterPoints(Ref ref) {
  final eews = ref.watch(eewAliveTelegramProvider) ?? [];

  return eews
      .where((e) => e.latitude != null && e.longitude != null && !e.isCanceled)
      .map(
        (eew) => Feature(
          geometry: Point(
            Geographic(lon: eew.longitude!, lat: eew.latitude!),
          ),
          properties: {
            'magnitude': eew.magnitude,
            'depth': eew.depth,
            'isLowPrecise':
                eew.isIpfOnePoint || eew.isLevelEew || (eew.isPlum ?? false),
          },
        ),
      )
      .toList();
}
