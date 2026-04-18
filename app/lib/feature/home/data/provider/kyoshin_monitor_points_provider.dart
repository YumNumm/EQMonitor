import 'dart:convert';

import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_points_provider.g.dart';

@riverpod
String kyoshinMonitorObservationGeoJson(Ref ref) {
  return ref.watch(
        kyoshinMonitorProvider.select((v) => v.value?.geoJson),
      ) ??
      jsonEncode({
        'type': 'FeatureCollection',
        'features': <Map<String, dynamic>>[],
      });
}
