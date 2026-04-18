import 'dart:convert';

import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_points_provider.g.dart';

@riverpod
List<KyoshinMonitorImageParseObservationPoint>
_kyoshinMonitorObservationPointsStream(Ref ref) {
  ref.listen(
    kyoshinMonitorProvider.select(
      (v) => v.value?.lastImageFetchTargetTime,
    ),
    (prev, next) {
      print('prev: $prev, next: $next');
      ref.invalidateSelf();
    },
  );
  return ref.read(
        kyoshinMonitorProvider.select((v) => v.value?.analyzedPoints),
      ) ??
      [];
}

@riverpod
String kyoshinMonitorObservationGeoJson(Ref ref) {
  final analyzedPoints = ref.watch(
    _kyoshinMonitorObservationPointsStreamProvider,
  );

  final features = <Map<String, dynamic>>[];
  for (final p in analyzedPoints) {
    final observation = p.observation;
    final point = p.point;
    final loc = point.location;
    final colorHex =
        '#${observation.r.toRadixString(16).padLeft(2, '0')}${observation.g.toRadixString(16).padLeft(2, '0')}${observation.b.toRadixString(16).padLeft(2, '0')}'
            .toUpperCase();
    features.add({
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [loc.longitude, loc.latitude],
      },
      'properties': {
        'color': colorHex,
        'intensity': observation.scaleToIntensity,
        'name': point.name,
      },
    });
  }

  final json = jsonEncode({
    'type': 'FeatureCollection',
    'features': features,
  });
  return json;
}
