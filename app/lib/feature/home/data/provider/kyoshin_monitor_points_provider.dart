import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/provider/log/talker.dart';
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
  final totalSw = Stopwatch()..start();
  final analyzedPoints = ref.watch(
    _kyoshinMonitorObservationPointsStreamProvider,
  );

  final buildSw = Stopwatch()..start();
  final features = Timeline.timeSync('kmoni.geojson.buildFeatures', () {
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
    return features;
  });
  buildSw.stop();

  final encodeSw = Stopwatch()..start();
  final json = Timeline.timeSync(
    'kmoni.geojson.jsonEncode',
    () => jsonEncode({
      'type': 'FeatureCollection',
      'features': features,
    }),
  );
  encodeSw.stop();
  totalSw.stop();

  talker.logCustom(
    KyoshinMonitorLog(
      '[perf] geojson build=${buildSw.elapsedMilliseconds}ms '
      'encode=${encodeSw.elapsedMilliseconds}ms '
      'total=${totalSw.elapsedMilliseconds}ms '
      'features=${features.length} bytes=${json.length}',
    ),
  );
  return json;
}
