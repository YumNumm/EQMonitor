import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_points_provider.g.dart';

@riverpod
List<Feature<Point>> kyoshinMonitorPoints(Ref ref) {
  final stateValue = ref.watch(kyoshinMonitorProvider);
  final points = stateValue.value?.analyzedPoints ?? [];

  return points.map((p) {
    final observation = p.observation;
    final point = p.point;

    final colorHex =
        '#${observation.r.toRadixString(16).padLeft(2, '0')}${observation.g.toRadixString(16).padLeft(2, '0')}${observation.b.toRadixString(16).padLeft(2, '0')}'
            .toUpperCase();

    return Feature(
      geometry: Point(
        Geographic(
          lon: point.location.longitude,
          lat: point.location.latitude,
        ),
      ),
      properties: {
        'color': colorHex,
        'intensity': observation.scaleToIntensity,
        'name': point.name,
      },
    );
  }).toList();
}
