import 'dart:convert';

import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
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

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON
@riverpod
String homeKyoshinMonitorObservationGeoJson(Ref ref) {
  final raw = ref.watch(kyoshinMonitorObservationGeoJsonProvider);
  final min = ref.watch(
    homeConfigurationProvider.select(
      (a) => a.value?.kyoshinMonitor.minRealtimeShindo,
    ),
  );
  if (min == null) {
    return raw;
  }
  try {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final features = decoded['features'];
    if (features is! List<dynamic>) {
      return raw;
    }
    final filtered = <dynamic>[];
    for (final f in features) {
      if (f is! Map<String, dynamic>) {
        continue;
      }
      final props = f['properties'];
      if (props is! Map<String, dynamic>) {
        filtered.add(f);
        continue;
      }
      final intensity = props['intensity'];
      if (intensity is! num) {
        filtered.add(f);
        continue;
      }
      if (intensity.toDouble() > min) {
        filtered.add(f);
      }
    }
    return jsonEncode(<String, dynamic>{
      'type': 'FeatureCollection',
      'features': filtered,
    });
  } on Exception {
    return raw;
  }
}
